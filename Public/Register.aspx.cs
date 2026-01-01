using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
namespace LaptopZone_project.Public
{
    public partial class Register : System.Web.UI.Page
    {
        string strCon = ConfigurationManager.ConnectionStrings["LaptopStoreDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnDangKy_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string tenDN = txtTenDN.Text.Trim();
            string matKhau = txtMatKhau.Text.Trim();

            // 1. Chặn đăng ký với tên "admin"
            if (tenDN.ToLower().Contains("admin"))
            {
                ShowAlert("Tên đăng nhập không hợp lệ hoặc đã được bảo vệ!");
                ResetButton();
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(strCon))
                {
                    string sql = "INSERT INTO KhachHang (HoTenKH, TenDN, MatKhau, Email, DienThoai) VALUES (@ht, @dn, @mk, @email, @sdt)";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@ht", txtHoTen.Text.Trim());
                    cmd.Parameters.AddWithValue("@dn", tenDN);
                    cmd.Parameters.AddWithValue("@mk", matKhau); // Để an toàn hơn bro nên Hash mật khẩu này
                    cmd.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@sdt", txtSDT.Text.Trim());

                    con.Open();
                    int result = cmd.ExecuteNonQuery();

                    if (result > 0)
                    {
                        string script = "alert('Đăng ký thành công! Hãy đăng nhập để bắt đầu mua sắm.'); window.location='Login.aspx';";
                        ScriptManager.RegisterStartupScript(this, GetType(), "Success", script, true);
                    }
                }
            }
            catch (SqlException ex)
            {
                if (ex.Number == 2627) ShowAlert("Tên đăng nhập hoặc Email này đã tồn tại!");
                else ShowAlert("Lỗi hệ thống: " + ex.Message);
                ResetButton();
            }
        }

        private void ShowAlert(string msg)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "Alert", $"alert('{msg}');", true);
        }

        private void ResetButton()
        {
            // Reset lại nút bấm nếu server trả về lỗi
            string js = $"var btn = document.getElementById('{btnDangKy.ClientID}'); btn.disabled=false; btn.value='ĐĂNG KÝ TÀI KHOẢN';";
            ScriptManager.RegisterStartupScript(this, GetType(), "ResetBtn", js, true);
        }
    }
}
