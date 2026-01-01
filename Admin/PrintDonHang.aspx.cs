using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LaptopZone_project.Admin
{
    public partial class PrintDonHang : System.Web.UI.Page
    {
        // Sử dụng chung ConnectionString với trang Chi tiết
        string connString = ConfigurationManager.ConnectionStrings["LaptopStoreDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Nhận tham số SoDH từ trang Chi tiết gửi sang
                string soDH = Request.QueryString["SoDH"];

                if (!string.IsNullOrEmpty(soDH))
                {
                    LoadThongTinDonHang(soDH);
                    LoadChiTietDonHang(soDH);
                }
                else
                {
                    Response.Write("<script>alert('Mã đơn hàng không hợp lệ!'); window.close();</script>");
                }
            }
        }

        private void LoadThongTinDonHang(string soDH)
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                // JOIN với bảng KhachHang để lấy thông tin người nhận
                string sql = @"SELECT d.SoDH, d.NgayDH, d.TriGia, k.HoTenKH, k.DienThoai, k.DiaChi 
                               FROM DonDatHang d 
                               JOIN KhachHang k ON d.MaKH = k.MaKH 
                               WHERE d.SoDH = @SoDH";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@SoDH", soDH);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    // Đổ dữ liệu vào các Literal/Label trên trang PrintDonHang.aspx
                    ltrSoDH.Text = dr["SoDH"].ToString();
                    ltrNgayDH.Text = string.Format("{0:dd/MM/yyyy HH:mm}", dr["NgayDH"]);
                    ltrTenKH.Text = dr["HoTenKH"].ToString();
                    ltrSDT.Text = dr["DienThoai"].ToString();
                    ltrDiaChi.Text = dr["DiaChi"].ToString();

                    decimal tongTien = Convert.ToDecimal(dr["TriGia"]);
                    ltrTongTienHang.Text = tongTien.ToString("N0") + " đ";
                    ltrTongTien.Text = tongTien.ToString("N0") + " đ";
                }
            }
        }

        private void LoadChiTietDonHang(string soDH)
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                // JOIN với bảng Laptop để lấy tên máy
                string sql = @"SELECT c.*, l.TenLaptop 
                               FROM CTDatHang c 
                               JOIN Laptop l ON c.MaLaptop = l.MaLaptop 
                               WHERE c.SoDH = @SoDH";

                SqlDataAdapter da = new SqlDataAdapter(sql, con);
                da.SelectCommand.Parameters.AddWithValue("@SoDH", soDH);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Gán dữ liệu vào GridView chi tiết đơn hàng (gvCTDH)
                gvCTDH.DataSource = dt;
                gvCTDH.DataBind();
            }
        }
    }
}