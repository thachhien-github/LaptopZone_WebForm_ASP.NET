using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LaptopZone_project.Admin
{
    public partial class DoiMatKhauAdmin : System.Web.UI.Page
    {
        string strCon = ConfigurationManager.ConnectionStrings["LaptopStoreDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Kiểm tra xem đã đăng nhập admin chưa
            // Nếu bạn dùng Session["admin"] ở các trang quản trị khác thì giữ nguyên ở đây
            if (Session["admin"] == null)
            {
                Response.Redirect("~/Admin/Login.aspx");
            }
        }

        protected void btnChangePass_Click(object sender, EventArgs e)
        {
            string oldPass = txtOldPass.Text.Trim();
            string newPass = txtNewPass.Text.Trim();
            string confirmPass = txtConfirmPass.Text.Trim();

            // Lấy tên đăng nhập Admin hiện tại từ Session
            string tenDN = Session["admin"].ToString();

            if (newPass != confirmPass)
            {
                Alert("Xác nhận mật khẩu mới không khớp!");
                return;
            }

            using (SqlConnection con = new SqlConnection(strCon))
            {
                try
                {
                    con.Open();
                    // 1. Kiểm tra mật khẩu cũ trong bảng Admin
                    string sqlCheck = "SELECT COUNT(*) FROM Admin WHERE TenDN = @u AND MatKhau = @p";
                    SqlCommand cmdCheck = new SqlCommand(sqlCheck, con);
                    cmdCheck.Parameters.AddWithValue("@u", tenDN);
                    cmdCheck.Parameters.AddWithValue("@p", oldPass);

                    int exists = (int)cmdCheck.ExecuteScalar();

                    if (exists > 0)
                    {
                        // 2. Cập nhật mật khẩu mới cho Admin
                        string sqlUpdate = "UPDATE Admin SET MatKhau = @new WHERE TenDN = @u";
                        SqlCommand cmdUpdate = new SqlCommand(sqlUpdate, con);
                        cmdUpdate.Parameters.AddWithValue("@new", newPass);
                        cmdUpdate.Parameters.AddWithValue("@u", tenDN);
                        cmdUpdate.ExecuteNonQuery();

                        Alert("Đổi mật khẩu Admin thành công!");
                        // Xóa trắng form
                        txtOldPass.Text = txtNewPass.Text = txtConfirmPass.Text = "";
                    }
                    else
                    {
                        Alert("Mật khẩu cũ không chính xác!");
                    }
                }
                catch (Exception ex)
                {
                    Alert("Lỗi: " + ex.Message);
                }
            }
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
    }
}