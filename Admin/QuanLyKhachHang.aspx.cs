using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LaptopZone_project.Admin
{
    public partial class QuanLyKhachHang : System.Web.UI.Page
    {
        string strCon = ConfigurationManager.ConnectionStrings["LaptopStoreDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        public void BindGrid()
        {
            string search = txtSearch.Text.Trim();
            string filter = ddlFilter.SelectedValue;

            using (SqlConnection con = new SqlConnection(strCon))
            {
                // Truy vấn SQL nâng cao kết hợp lọc theo trạng thái đơn hàng
                string sql = "SELECT KH.* FROM KhachHang KH WHERE 1=1";

                if (filter == "hasOrder")
                    sql += " AND EXISTS (SELECT 1 FROM DonDatHang WHERE MaKH = KH.MaKH)";
                else if (filter == "noOrder")
                    sql += " AND NOT EXISTS (SELECT 1 FROM DonDatHang WHERE MaKH = KH.MaKH)";

                if (!string.IsNullOrEmpty(search))
                    sql += " AND (HoTenKH LIKE @s OR DienThoai LIKE @s OR Email LIKE @s OR TenDN LIKE @s)";

                sql += " ORDER BY MaKH DESC";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@s", "%" + search + "%");

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvKhachHang.DataSource = dt;
                gvKhachHang.DataBind();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindGrid();
        }

        protected void gvKhachHang_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int maKH = (int)gvKhachHang.DataKeys[e.RowIndex].Value;
            try
            {
                using (SqlConnection con = new SqlConnection(strCon))
                {
                    string sql = "DELETE FROM KhachHang WHERE MaKH = @id";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@id", maKH);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                BindGrid();
                Alert("Đã xóa khách hàng thành công!");
            }
            catch (SqlException ex)
            {
                if (ex.Number == 547) Alert("Khách hàng này đã có đơn hàng, không thể xóa!");
            }
        }

        protected void btnConfirmUpdate_Click(object sender, EventArgs e)
        {
            string newPass = txtNewPass.Text.Trim();
            if (newPass.Length < 6) { Alert("Mật khẩu phải từ 6 ký tự trở lên!"); return; }

            using (SqlConnection con = new SqlConnection(strCon))
            {
                string sql = "UPDATE KhachHang SET MatKhau = @pass WHERE MaKH = @id";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@pass", newPass);
                cmd.Parameters.AddWithValue("@id", hdnMaKH.Value);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            txtNewPass.Text = "";
            BindGrid();
            Alert("Cập nhật mật khẩu thành công!");
            // Script để đóng modal sau khi lưu thành công
            ScriptManager.RegisterStartupScript(this, GetType(), "close", "closePassModal();", true);
        }

        // Helper Methods
        public string GetInitials(string name)
        {
            if (string.IsNullOrWhiteSpace(name)) return "K";
            string[] words = name.Trim().Split(' ');
            return words.Length > 1 ? (words[0][0].ToString() + words[words.Length - 1][0].ToString()).ToUpper() : name[0].ToString().ToUpper();
        }

        private void Alert(string msg)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('{msg}');", true);
        }

        // --- WEB METHOD XỬ LÝ THÔNG BÁO REALTIME ---
        [WebMethod(EnableSession = true)]
        public static object GetNewOrders()
        {
            List<object> notifications = new List<object>();
            string connStr = ConfigurationManager.ConnectionStrings["LaptopStoreDBConnectionString"]?.ConnectionString;

            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    // Truy vấn lấy đơn hàng chưa giao từ LaptopStoreDB
                    string sql = @"SELECT TOP 5 d.SoDH, d.NgayDH, k.HoTenKH 
                                   FROM DonDatHang d 
                                   INNER JOIN KhachHang k ON d.MaKH = k.MaKH 
                                   WHERE d.DaGiao = 0 OR d.DaGiao IS NULL
                                   ORDER BY d.NgayDH DESC";

                    SqlCommand cmd = new SqlCommand(sql, con);
                    con.Open();
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            notifications.Add(new
                            {
                                ID = dr["SoDH"].ToString(),
                                User = dr["HoTenKH"].ToString(),
                                Time = Convert.ToDateTime(dr["NgayDH"]).ToString("HH:mm dd/MM")
                            });
                        }
                    }
                }
                // Trả về dữ liệu bọc trong đối tượng để ASP.NET tự serialize sang JSON
                return notifications;
            }
            catch (Exception ex)
            {
                return new { error = ex.Message };
            }
        }

        protected void gvKhachHang_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvKhachHang.PageIndex = e.NewPageIndex;
            BindGrid();
        }
    }
}