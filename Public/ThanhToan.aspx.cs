using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LaptopZone_project.Public
{
    public partial class ThanhToan : System.Web.UI.Page
    {
        // Sử dụng chung chuỗi kết nối từ Web.config
        string strCon = ConfigurationManager.ConnectionStrings["LaptopStoreDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. Kiểm tra đăng nhập
            if (Session["MaKH"] == null)
            {
                Response.Redirect("Login.aspx?ReturnUrl=ThanhToan.aspx");
                return;
            }

            // 2. Kiểm tra giỏ hàng có dữ liệu không
            DataTable dt = (DataTable)Session["GioHang"];
            if (dt == null || dt.Rows.Count == 0)
            {
                Response.Redirect("Default.aspx");
                return;
            }

            if (!IsPostBack)
            {
                BindData(dt);
                // Mặc định ngày giao sau 3 ngày
                txtNgayGiao.Text = DateTime.Now.AddDays(3).ToString("yyyy-MM-dd");
                LoadCustomerInfo();
            }
        }

        private void LoadCustomerInfo()
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                string sql = "SELECT HoTenKH, DienThoai, DiaChi FROM KhachHang WHERE MaKH = @MaKH";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@MaKH", Session["MaKH"]);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtHoTen.Text = dr["HoTenKH"].ToString();
                    txtSDT.Text = dr["DienThoai"].ToString();
                    txtDiaChi.Text = dr["DiaChi"].ToString();
                }
            }
        }

        private void BindData(DataTable dt)
        {
            rptTomTat.DataSource = dt;
            rptTomTat.DataBind();

            decimal tamTinh = dt.AsEnumerable().Sum(x => x.Field<decimal>("ThanhTien"));
            decimal vat = tamTinh * 0.1m; // Thuế 10%
            decimal tongCong = tamTinh + vat;

            ltrCount.Text = dt.Rows.Count.ToString();
            ltrTamTinh.Text = tamTinh.ToString("N0");
            ltrVAT.Text = vat.ToString("N0");
            ltrTongCong.Text = tongCong.ToString("N0");
        }

        protected void btnXacNhan_Click(object sender, EventArgs e)
        {
            DataTable dt = (DataTable)Session["GioHang"];
            decimal tamTinh = dt.AsEnumerable().Sum(x => x.Field<decimal>("ThanhTien"));
            decimal tongCong = tamTinh * 1.1m;

            using (SqlConnection con = new SqlConnection(strCon))
            {
                con.Open();
                SqlTransaction trans = con.BeginTransaction(); // Bắt đầu giao dịch

                try
                {
                    // BƯỚC 1: LƯU ĐƠN ĐẶT HÀNG
                    string sqlDonHang = @"INSERT INTO DonDatHang (MaKH, NgayDH, TriGia, DaGiao, NgayGiao) 
                                         OUTPUT INSERTED.SoDH 
                                         VALUES (@MaKH, @NgayDH, @TriGia, @DaGiao, @NgayGiao)";

                    SqlCommand cmdDH = new SqlCommand(sqlDonHang, con, trans);
                    cmdDH.Parameters.AddWithValue("@MaKH", Session["MaKH"]);
                    cmdDH.Parameters.AddWithValue("@NgayDH", DateTime.Now);
                    cmdDH.Parameters.AddWithValue("@TriGia", tongCong);
                    cmdDH.Parameters.AddWithValue("@DaGiao", false);
                    cmdDH.Parameters.AddWithValue("@NgayGiao", DateTime.Parse(txtNgayGiao.Text));

                    int soDH = (int)cmdDH.ExecuteScalar();

                    // BƯỚC 2: DUYỆT GIỎ HÀNG ĐỂ LƯU CHI TIẾT VÀ TRỪ KHO
                    foreach (DataRow dr in dt.Rows)
                    {
                        int maLP = Convert.ToInt32(dr["MaLaptop"]);
                        int slMua = Convert.ToInt32(dr["SoLuong"]);

                        // 2.1. Kiểm tra và Trừ số lượng trong bảng Laptop
                        // Chỉ trừ nếu SoLuong trong kho >= slMua
                        string sqlUpdateKho = @"UPDATE Laptop SET SoLuong = SoLuong - @SL 
                                               WHERE MaLaptop = @MaLP AND SoLuong >= @SL";
                        SqlCommand cmdUpdate = new SqlCommand(sqlUpdateKho, con, trans);
                        cmdUpdate.Parameters.AddWithValue("@SL", slMua);
                        cmdUpdate.Parameters.AddWithValue("@MaLP", maLP);

                        int rowsAffected = cmdUpdate.ExecuteNonQuery();
                        if (rowsAffected == 0)
                        {
                            // Nếu không có dòng nào bị ảnh hưởng -> Hết hàng
                            throw new Exception("Sản phẩm mã " + maLP + " đã hết hàng hoặc không đủ số lượng tồn kho!");
                        }

                        // 2.2. Lưu vào bảng Chi tiết Đặt hàng (CTDatHang)
                        string sqlCT = @"INSERT INTO CTDatHang (MaLaptop, SoDH, SoLuong, DonGia, ThanhTien) 
                                        VALUES (@MaLP, @SoDH, @SL, @Gia, @ThanhTien)";
                        SqlCommand cmdCT = new SqlCommand(sqlCT, con, trans);
                        cmdCT.Parameters.AddWithValue("@MaLP", maLP);
                        cmdCT.Parameters.AddWithValue("@SoDH", soDH);
                        cmdCT.Parameters.AddWithValue("@SL", slMua);
                        cmdCT.Parameters.AddWithValue("@Gia", dr["Gia"]);
                        cmdCT.Parameters.AddWithValue("@ThanhTien", dr["ThanhTien"]);
                        cmdCT.ExecuteNonQuery();
                    }

                    // BƯỚC 3: XÁC NHẬN HOÀN TẤT
                    trans.Commit();
                    Session.Remove("GioHang"); // Xóa giỏ hàng sau khi mua xong

                    string script = $"alert('Đặt hàng thành công! Mã đơn: {soDH}'); window.location='Default.aspx';";
                    ClientScript.RegisterStartupScript(this.GetType(), "Success", script, true);
                }
                catch (Exception ex)
                {
                    trans.Rollback(); // Có lỗi thì hủy bỏ toàn bộ thay đổi (không trừ kho, không tạo đơn)
                    string error = ex.Message.Replace("'", "");
                    ClientScript.RegisterStartupScript(this.GetType(), "Error", $"alert('Lỗi: {error}');", true);
                }
            }
        }
    }
}