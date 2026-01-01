using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LaptopZone_project.Admin
{
    public partial class LoginAdmin : System.Web.UI.Page
    {
        string strCon = ConfigurationManager.ConnectionStrings["LaptopStoreDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Nếu đã login rồi thì vào thẳng Dashboard
            if (Session["admin"] != null) Response.Redirect("Dashboard.aspx");
        }

        protected void btnDangNhap_Click(object sender, EventArgs e)
        {
            string user = txtTenDN.Text.Trim();
            string pass = txtMatKhau.Text.Trim();

            using (SqlConnection con = new SqlConnection(strCon))
            {
                // Truy vấn bảng Admin (nhớ tạo bảng này trong SQL nhé)
                string sql = "SELECT TenDN FROM Admin WHERE TenDN=@u AND MatKhau=@p";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@u", user);
                cmd.Parameters.AddWithValue("@p", pass);

                try
                {
                    con.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        Session["admin"] = result.ToString();
                        Response.Redirect("Dashboard.aspx"); // Vào trang quản trị
                    }
                    else
                    {
                        Alert("Sai tài khoản hoặc mật khẩu Admin!");
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
    }
}