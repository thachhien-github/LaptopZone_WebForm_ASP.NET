using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace LaptopZone_project.Public
{
    public partial class Profile : System.Web.UI.Page
    {
        string strCon = ConfigurationManager.ConnectionStrings["LaptopStoreDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["MaKH"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadUserInfo();
                LoadOrderHistory();
            }
        }

        private void LoadUserInfo()
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                string sql = "SELECT * FROM KhachHang WHERE MaKH = @MaKH";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@MaKH", Session["MaKH"]);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtHoTen.Text = dr["HoTenKH"].ToString();
                    txtEmail.Text = dr["Email"].ToString();
                    txtSDT.Text = dr["DienThoai"].ToString();
                    txtDiaChi.Text = dr["DiaChi"].ToString();
                }
            }
        }

        private void LoadOrderHistory()
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                string sql = "SELECT SoDH, NgayDH, TriGia, DaGiao FROM DonDatHang WHERE MaKH = @MaKH ORDER BY NgayDH DESC";
                SqlDataAdapter da = new SqlDataAdapter(sql, con);
                da.SelectCommand.Parameters.AddWithValue("@MaKH", Session["MaKH"]);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvOrders.DataSource = dt;
                gvOrders.DataBind();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                string sql = "UPDATE KhachHang SET HoTenKH=@ht, Email=@email, DienThoai=@sdt, DiaChi=@dc WHERE MaKH=@MaKH";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@ht", txtHoTen.Text);
                cmd.Parameters.AddWithValue("@email", txtEmail.Text);
                cmd.Parameters.AddWithValue("@sdt", txtSDT.Text);
                cmd.Parameters.AddWithValue("@dc", txtDiaChi.Text);
                cmd.Parameters.AddWithValue("@MaKH", Session["MaKH"]);

                con.Open();
                cmd.ExecuteNonQuery();

                // Cập nhật lại tên hiển thị trên Session nếu có thay đổi
                Session["HoTen"] = txtHoTen.Text;

                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Cập nhật thông tin thành công!');", true);
            }
        }

        protected void btnChangePass_Click(object sender, EventArgs e)
        {
            // 1. Kiểm tra đầu vào cơ bản
            if (string.IsNullOrEmpty(txtOldPass.Text) || string.IsNullOrEmpty(txtNewPass.Text))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Vui lòng nhập đầy đủ thông tin mật khẩu!');", true);
                return;
            }

            if (txtNewPass.Text != txtConfirmPass.Text)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Mật khẩu mới và nhập lại không khớp!');", true);
                return;
            }

            using (SqlConnection con = new SqlConnection(strCon))
            {
                con.Open();

                // 2. Kiểm tra mật khẩu cũ có đúng không
                string checkSql = "SELECT COUNT(*) FROM KhachHang WHERE MaKH = @MaKH AND MatKhau = @oldPass";
                SqlCommand checkCmd = new SqlCommand(checkSql, con);
                checkCmd.Parameters.AddWithValue("@MaKH", Session["MaKH"]);
                checkCmd.Parameters.AddWithValue("@oldPass", txtOldPass.Text);

                int count = (int)checkCmd.ExecuteScalar();

                if (count > 0)
                {
                    // 3. Cập nhật mật khẩu mới
                    string updateSql = "UPDATE KhachHang SET MatKhau = @newPass WHERE MaKH = @MaKH";
                    SqlCommand updateCmd = new SqlCommand(updateSql, con);
                    updateCmd.Parameters.AddWithValue("@newPass", txtNewPass.Text);
                    updateCmd.Parameters.AddWithValue("@MaKH", Session["MaKH"]);

                    updateCmd.ExecuteNonQuery();

                    // Xóa trắng ô nhập sau khi thành công
                    txtOldPass.Text = txtNewPass.Text = txtConfirmPass.Text = "";

                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Đổi mật khẩu thành công!');", true);
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Mật khẩu cũ không chính xác!');", true);
                }
            }
        }
    }
}
