using System;
using System.Configuration;
using System.Data.SqlClient;

namespace LaptopZone_project.Public
{
    public partial class Login : System.Web.UI.Page
    {
        string strCon = ConfigurationManager.ConnectionStrings["LaptopStoreDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Nếu đã đăng nhập rồi thì không cho vào trang này nữa
            if (Session["TenDN"] != null && !IsPostBack)
            {
                Response.Redirect("Default.aspx");
            }
        }

        protected void btnDangNhap_Click(object sender, EventArgs e)
        {
            string tenDN = txtTenDN.Text.Trim();
            string matKhau = txtMatKhau.Text.Trim();

            using (SqlConnection con = new SqlConnection(strCon))
            {
                con.Open();

                // 1. KIỂM TRA BẢNG ADMIN (CÓ ROLE)
                string sqlAdmin = "SELECT TenDN, HoTen, Role FROM Admin WHERE TenDN=@dn AND MatKhau=@mk";
                SqlCommand cmdAdmin = new SqlCommand(sqlAdmin, con);
                cmdAdmin.Parameters.AddWithValue("@dn", tenDN);
                cmdAdmin.Parameters.AddWithValue("@mk", matKhau);

                SqlDataReader drAdmin = cmdAdmin.ExecuteReader();

                if (drAdmin.Read())
                {
                    string role = drAdmin["Role"].ToString();

                    Session["TenDN"] = drAdmin["TenDN"].ToString();
                    Session["HoTen"] = drAdmin["HoTen"].ToString();
                    Session["Role"] = role;

                    drAdmin.Close();

                    if (role == "Admin")
                    {
                        Session["admin"] = tenDN;
                        Response.Redirect("~/Admin/Dashboard.aspx");
                    }
                    else if (role == "Shipper")
                    {
                        Session["shipper"] = tenDN;
                        Response.Redirect("~/Shipper/Default.aspx");
                    }

                    return;
                }

                drAdmin.Close();

                // 2. NẾU KHÔNG PHẢI ADMIN/SHIPPER → KIỂM TRA KHÁCH HÀNG
                string sqlKH = "SELECT MaKH, HoTenKH FROM KhachHang WHERE TenDN=@dn AND MatKhau=@mk";
                SqlCommand cmdKH = new SqlCommand(sqlKH, con);
                cmdKH.Parameters.AddWithValue("@dn", tenDN);
                cmdKH.Parameters.AddWithValue("@mk", matKhau);

                SqlDataReader drKH = cmdKH.ExecuteReader();

                if (drKH.Read())
                {
                    Session["MaKH"] = drKH["MaKH"];
                    Session["TenDN"] = tenDN;
                    Session["HoTen"] = drKH["HoTenKH"].ToString();
                    Session["Role"] = "Customer";

                    Response.Redirect("Default.aspx");
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('Tên đăng nhập hoặc mật khẩu không đúng!');", true);
                }
            }
        }
    }
}
