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
    public partial class QuanLyHang : System.Web.UI.Page
    {
        string strCon = ConfigurationManager.ConnectionStrings["LaptopStoreDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) LoadData();
        }

        private void LoadData()
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM HangSanXuat ORDER BY MaHang DESC", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvHang.DataSource = dt;
                gvHang.DataBind();
            }
        }

        protected void gvHang_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvHang.PageIndex = e.NewPageIndex;
            LoadData();
        }

        protected void gvHang_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "EditHang")
            {
                using (SqlConnection con = new SqlConnection(strCon))
                {
                    SqlCommand cmd = new SqlCommand("SELECT * FROM HangSanXuat WHERE MaHang = @MaHang", con);
                    cmd.Parameters.AddWithValue("@MaHang", id);
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        hdMaHang.Value = dr["MaHang"].ToString();
                        txtTenHang.Text = dr["TenHang"].ToString();
                        txtDiaChi.Text = dr["DiaChi"].ToString();
                        txtDienThoai.Text = dr["DienThoai"].ToString();
                        litFormTitle.Text = "Cập Nhật Hãng";
                        pnlForm.Visible = true;
                    }
                }
            }
            else if (e.CommandName == "DeleteHang")
            {
                DeleteHang(id);
            }
        }

        private void DeleteHang(int id)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(strCon))
                {
                    SqlCommand cmd = new SqlCommand("DELETE FROM HangSanXuat WHERE MaHang = @MaHang", con);
                    cmd.Parameters.AddWithValue("@MaHang", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    LoadData();
                }
            }
            catch
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "err", "alert('Không thể xóa! Hãng này hiện đang có máy trong kho.');", true);
            }
        }

        protected void btnLuu_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                string sql = string.IsNullOrEmpty(hdMaHang.Value)
                    ? "INSERT INTO HangSanXuat(TenHang, DiaChi, DienThoai) VALUES (@Ten, @DC, @DT)"
                    : "UPDATE HangSanXuat SET TenHang=@Ten, DiaChi=@DC, DienThoai=@DT WHERE MaHang=@MaHang";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@Ten", txtTenHang.Text.Trim());
                cmd.Parameters.AddWithValue("@DC", txtDiaChi.Text.Trim());
                cmd.Parameters.AddWithValue("@DT", txtDienThoai.Text.Trim());
                if (!string.IsNullOrEmpty(hdMaHang.Value)) cmd.Parameters.AddWithValue("@MaHang", hdMaHang.Value);

                con.Open();
                cmd.ExecuteNonQuery();
                pnlForm.Visible = false;
                LoadData();
            }
        }

        protected void btnOpenAdd_Click(object sender, EventArgs e)
        {
            hdMaHang.Value = "";
            txtTenHang.Text = ""; txtDiaChi.Text = ""; txtDienThoai.Text = "";
            litFormTitle.Text = "Thêm Đối Tác Mới";
            pnlForm.Visible = true;
        }

        protected void btnClose_Click(object sender, EventArgs e) => pnlForm.Visible = false;

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