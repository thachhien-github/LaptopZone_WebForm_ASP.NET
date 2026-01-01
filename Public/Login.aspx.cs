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

                // 1. KIỂM TRA BẢNG ADMIN TRƯỚC
                string sqlAdmin = "SELECT TenDN FROM Admin WHERE TenDN=@dn AND MatKhau=@mk";
                SqlCommand cmdAdmin = new SqlCommand(sqlAdmin, con);
                cmdAdmin.Parameters.AddWithValue("@dn", tenDN);
                cmdAdmin.Parameters.AddWithValue("@mk", matKhau);
                object adminResult = cmdAdmin.ExecuteScalar();

                if (adminResult != null)
                {
                    // Nếu là Admin: Cấp cả 2 Session cho tiện
                    Session["admin"] = adminResult.ToString();
                    Session["TenDN"] = adminResult.ToString();
                    Session["HoTen"] = "Quản trị viên";

                    Response.Redirect("~/Admin/Dashboard.aspx"); // Vào thẳng trang quản trị
                    return;
                }

                // 2. NẾU KHÔNG PHẢI ADMIN, KIỂM TRA BẢNG KHACHHANG
                string sqlKH = "SELECT MaKH, HoTenKH FROM KhachHang WHERE TenDN = @dn AND MatKhau = @mk";
                SqlCommand cmdKH = new SqlCommand(sqlKH, con);
                cmdKH.Parameters.AddWithValue("@dn", tenDN);
                cmdKH.Parameters.AddWithValue("@mk", matKhau);
                SqlDataReader dr = cmdKH.ExecuteReader();

                if (dr.Read())
                {
                    Session["MaKH"] = dr["MaKH"];
                    Session["TenDN"] = tenDN;
                    Session["HoTen"] = dr["HoTenKH"].ToString();

                    Response.Redirect("Default.aspx");
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Tên đăng nhập hoặc mật khẩu không đúng!');", true);
                }
            }
        }
    }
}
