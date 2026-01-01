using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
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

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            int maLaptop = int.Parse(((LinkButton)sender).CommandArgument);

            // 1. Lấy thông tin sản phẩm và Tồn kho từ DB
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

                    // 2. Khởi tạo/Lấy giỏ hàng từ Session
                    DataTable dt = Session["GioHang"] == null ? CreateCartTable() : (DataTable)Session["GioHang"];

                    // 3. Tính toán số lượng dự định sẽ có trong giỏ
                    int soLuongTrongGio = 0;
                    DataRow[] rows = dt.Select("MaLaptop = " + maLaptop);
                    if (rows.Length > 0)
                        soLuongTrongGio = (int)rows[0]["SoLuong"];

                    // KIỂM TRA TỒN KHO: Nếu số lượng sắp thêm vào > tồn kho thì báo lỗi
                    if (soLuongTrongGio + 1 > tonKho)
                    {
                        string msg = $"alert('Rất tiếc! {tenLP} chỉ còn {tonKho} sản phẩm trong kho.');";
                        ClientScript.RegisterStartupScript(this.GetType(), "OutOfStock", msg, true);
                        return; // Dừng, không cho thêm vào giỏ
                    }

                    // 4. Cập nhật giỏ hàng
                    if (rows.Length > 0)
                    {
                        rows[0]["SoLuong"] = soLuongTrongGio + 1;
                        rows[0]["ThanhTien"] = (int)rows[0]["SoLuong"] * (decimal)rows[0]["Gia"];
                    }
                    else
                    {
                        DataRow nr = dt.NewRow();
                        nr["MaLaptop"] = maLaptop;
                        nr["TenLaptop"] = tenLP;
                        nr["AnhBia"] = dr["AnhBia"];
                        nr["Gia"] = dr["Gia"];
                        nr["SoLuong"] = 1;
                        nr["ThanhTien"] = dr["Gia"];
                        dt.Rows.Add(nr);
                    }

                    Session["GioHang"] = dt;
                    Response.Redirect(Request.RawUrl);
                }
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
