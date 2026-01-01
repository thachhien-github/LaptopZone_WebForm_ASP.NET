using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
namespace LaptopZone_project.Public
{
    public partial class ChiTietDonHang : System.Web.UI.Page
    {
        string strCon = ConfigurationManager.ConnectionStrings["LaptopStoreDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Kiểm tra đăng nhập
            if (Session["MaKH"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            // Lấy SoDH từ QueryString (ví dụ: ChiTietDonHang.aspx?id=10)
            string soDH = Request.QueryString["id"];
            if (string.IsNullOrEmpty(soDH))
            {
                Response.Redirect("Profile.aspx");
                return;
            }

            if (!IsPostBack)
            {
                ltrSoDH.Text = soDH;
                LoadChiTiet(soDH);
            }
        }

        private void LoadChiTiet(string soDH)
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                // Truy vấn JOIN để lấy thông tin sản phẩm từ bảng Laptop
                string sql = @"SELECT CT.SoLuong, CT.DonGia, CT.ThanhTien, L.TenLaptop, L.AnhBia, D.TriGia 
                             FROM CTDatHang CT 
                             JOIN Laptop L ON CT.MaLaptop = L.MaLaptop 
                             JOIN DonDatHang D ON CT.SoDH = D.SoDH
                             WHERE CT.SoDH = @SoDH AND D.MaKH = @MaKH";

                SqlDataAdapter da = new SqlDataAdapter(sql, con);
                da.SelectCommand.Parameters.AddWithValue("@SoDH", soDH);
                da.SelectCommand.Parameters.AddWithValue("@MaKH", Session["MaKH"]);

                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    gvChiTiet.DataSource = dt;
                    gvChiTiet.DataBind();

                    // Lấy tổng tiền từ cột TriGia của dòng đầu tiên
                    decimal tongTien = Convert.ToDecimal(dt.Rows[0]["TriGia"]);
                    ltrTongTien.Text = tongTien.ToString("N0");
                }
                else
                {
                    // Nếu không tìm thấy hoặc đơn hàng không thuộc khách hàng này
                    Response.Redirect("Profile.aspx");
                }
            }
        }
    }
}
