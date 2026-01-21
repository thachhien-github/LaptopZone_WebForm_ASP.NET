using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.Services;
using System.Web.UI.WebControls;
namespace LaptopZone_project.Public
{
    public partial class ChiTietLaptop : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["LaptopStoreDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string id = Request.QueryString["MaLaptop"];
                if (!string.IsNullOrEmpty(id))
                {
                    LoadDetail(id);
                }
                else
                {
                    Response.Redirect("Default.aspx");
                }
            }
        }

        private void LoadDetail(string id)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                // Join thêm bảng Hang và Loai để lấy TenHang, TenLoai hiển thị
                string sql = @"SELECT l.*, h.TenHang, t.TenLoai 
                             FROM Laptop l 
                             INNER JOIN HangSanXuat h ON l.MaHang = h.MaHang
                             INNER JOIN LoaiLaptop t ON l.MaLoai = t.MaLoai
                             WHERE l.MaLaptop = @Ma";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@Ma", id);
                con.Open();

                rptChiTiet.DataSource = cmd.ExecuteReader();
                rptChiTiet.DataBind();
            }
        }

        [WebMethod(EnableSession = true)]
        public static string AddToCartAjax(int maLaptop)
        {
            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["LaptopStoreDBConnectionString"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string sql = "SELECT TenLaptop, AnhBia, Gia, SoLuong FROM Laptop WHERE MaLaptop = @Ma";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@Ma", maLaptop);
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        int tonKho = Convert.ToInt32(dr["SoLuong"]);
                        string tenLP = dr["TenLaptop"].ToString();
                        decimal gia = Convert.ToDecimal(dr["Gia"]);
                        string anh = dr["AnhBia"].ToString();

                        // Tạo đối tượng tạm để gọi hàm bổ trợ (CreateCartTable)
                        ChiTietLaptop tempPage = new ChiTietLaptop();
                        DataTable dt = System.Web.HttpContext.Current.Session["GioHang"] == null
                                       ? tempPage.CreateCartTable()
                                       : (DataTable)System.Web.HttpContext.Current.Session["GioHang"];

                        int soLuongTrongGio = 0;
                        DataRow[] rows = dt.Select("MaLaptop = " + maLaptop);
                        if (rows.Length > 0)
                            soLuongTrongGio = (int)rows[0]["SoLuong"];

                        // Kiểm tra tồn kho
                        if (soLuongTrongGio + 1 > tonKho)
                            return $"Error|Rất tiếc! {tenLP} chỉ còn {tonKho} sản phẩm.";

                        // Cập nhật giỏ hàng
                        if (rows.Length > 0)
                        {
                            rows[0]["SoLuong"] = soLuongTrongGio + 1;
                            rows[0]["ThanhTien"] = (int)rows[0]["SoLuong"] * gia;
                        }
                        else
                        {
                            DataRow nr = dt.NewRow();
                            nr["MaLaptop"] = maLaptop;
                            nr["TenLaptop"] = tenLP;
                            nr["AnhBia"] = anh;
                            nr["Gia"] = gia;
                            nr["SoLuong"] = 1;
                            nr["ThanhTien"] = gia;
                            dt.Rows.Add(nr);
                        }

                        System.Web.HttpContext.Current.Session["GioHang"] = dt;

                        // Tính tổng số lượng hàng trong giỏ để gửi về cho client
                        int totalCount = dt.AsEnumerable().Sum(x => x.Field<int>("SoLuong"));

                        return $"Success|Đã thêm thành công {tenLP} vào giỏ hàng!|{totalCount}";
                    }
                    return "Error|Không tìm thấy sản phẩm.";
                }
            }
            catch (Exception ex)
            {
                return "Error|Đã xảy ra lỗi: " + ex.Message;
            }
        }

        // Hàm phụ tạo cấu trúc bảng giỏ hàng
        private DataTable CreateCartTable()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("MaLaptop", typeof(int));
            dt.Columns.Add("TenLaptop", typeof(string));
            dt.Columns.Add("AnhBia", typeof(string));
            dt.Columns.Add("Gia", typeof(decimal));
            dt.Columns.Add("SoLuong", typeof(int));
            dt.Columns.Add("ThanhTien", typeof(decimal));
            return dt;
        }
    }
}
