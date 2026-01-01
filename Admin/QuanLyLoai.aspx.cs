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
    public partial class QuanLyLoai : System.Web.UI.Page
    {
        string strCon = ConfigurationManager.ConnectionStrings["LaptopStoreDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
            }
        }

        private void LoadData()
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                string sql = "SELECT * FROM LoaiLaptop ORDER BY MaLoai DESC";
                SqlDataAdapter da = new SqlDataAdapter(sql, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvLoai.DataSource = dt;
                gvLoai.DataBind();
            }
        }

        protected void gvLoai_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvLoai.PageIndex = e.NewPageIndex;
            LoadData();
        }

        protected void gvLoai_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditLoai")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                LoadLoaiToForm(id);
            }
            else if (e.CommandName == "DeleteLoai")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                DeleteLoai(id);
            }
        }

        private void LoadLoaiToForm(int id)
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                string sql = "SELECT * FROM LoaiLaptop WHERE MaLoai = @MaLoai";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@MaLoai", id);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    hdMaLoai.Value = dr["MaLoai"].ToString();
                    txtTenLoai.Text = dr["TenLoai"].ToString();
                    litFormTitle.Text = "Chỉnh Sửa Loại #" + id;
                    pnlForm.Visible = true;
                }
            }
        }

        private void DeleteLoai(int id)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(strCon))
                {
                    string sql = "DELETE FROM LoaiLaptop WHERE MaLoai = @MaLoai";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@MaLoai", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    LoadData();
                    // Optional: Hiển thị thông báo thành công bằng JavaScript
                }
            }
            catch (SqlException ex)
            {
                // Lỗi 547 là lỗi ràng buộc khóa ngoại (Foreign Key)
                if (ex.Number == 547)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Không thể xóa loại này vì đang có sản phẩm thuộc danh mục này!');", true);
                }
            }
        }

        protected void btnLuu_Click(object sender, EventArgs e)
        {
            string tenLoai = txtTenLoai.Text.Trim();
            if (string.IsNullOrEmpty(tenLoai)) return;

            using (SqlConnection con = new SqlConnection(strCon))
            {
                string sql = "";
                if (string.IsNullOrEmpty(hdMaLoai.Value))
                {
                    sql = "INSERT INTO LoaiLaptop(TenLoai) VALUES (@TenLoai)";
                }
                else
                {
                    sql = "UPDATE LoaiLaptop SET TenLoai = @TenLoai WHERE MaLoai = @MaLoai";
                }

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@TenLoai", tenLoai);
                if (!string.IsNullOrEmpty(hdMaLoai.Value))
                {
                    cmd.Parameters.AddWithValue("@MaLoai", hdMaLoai.Value);
                }

                con.Open();
                cmd.ExecuteNonQuery();
                pnlForm.Visible = false;
                LoadData();
            }
        }

        protected void btnShowAdd_Click(object sender, EventArgs e)
        {
            hdMaLoai.Value = "";
            txtTenLoai.Text = "";
            litFormTitle.Text = "Thêm Loại Mới";
            pnlForm.Visible = true;
        }

        protected void btnClose_Click(object sender, EventArgs e)
        {
            pnlForm.Visible = false;
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
    }
}