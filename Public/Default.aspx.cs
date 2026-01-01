using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI.WebControls;
namespace LaptopZone_project.Public
{
    public partial class Default : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["LaptopStoreDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadFilterData();
                BindData(0);
            }
        }

        private void LoadFilterData()
        {
            // Load danh sách hãng sản xuất vào checkbox list
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT MaHang, TenHang FROM HangSanXuat", con);
                con.Open();
                cblHang.DataSource = cmd.ExecuteReader();
                cblHang.DataTextField = "TenHang";
                cblHang.DataValueField = "MaHang";
                cblHang.DataBind();
            }
        }

        private void BindData(int pageIndex)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = "SELECT * FROM Laptop WHERE 1=1";

                // Lọc theo search
                string search = Request.QueryString["search"];
                if (!string.IsNullOrEmpty(search))
                {
                    sql += " AND (TenLaptop LIKE N'%' + @search + '%' OR CPU LIKE N'%' + @search + '%')";
                    ltrTitle.Text = "Kết quả cho: \"" + search + "\"";
                }
                else
                {
                    ltrTitle.Text = "Laptop Mới Nhất";
                }

                // Lọc theo hãng
                var selectedBrands = cblHang.Items.Cast<ListItem>().Where(i => i.Selected).Select(i => i.Value).ToList();
                if (selectedBrands.Count > 0)
                    sql += " AND MaHang IN (" + string.Join(",", selectedBrands) + ")";

                // Lọc theo RAM
                if (!string.IsNullOrEmpty(rblRam.SelectedValue))
                    sql += " AND RAM LIKE '%' + @ram + '%'";

                // Sắp xếp
                switch (ddlSort.SelectedValue)
                {
                    case "price-asc": sql += " ORDER BY Gia ASC"; break;
                    case "price-desc": sql += " ORDER BY Gia DESC"; break;
                    default: sql += " ORDER BY NgayCapNhat DESC"; break;
                }

                SqlCommand cmd = new SqlCommand(sql, con);
                if (!string.IsNullOrEmpty(search)) cmd.Parameters.AddWithValue("@search", search);
                if (!string.IsNullOrEmpty(rblRam.SelectedValue)) cmd.Parameters.AddWithValue("@ram", rblRam.SelectedValue);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // --- DÒNG QUAN TRỌNG ĐỂ HIỂN THỊ TỔNG SỐ SẢN PHẨM ---
                ltrTotalCount.Text = dt.Rows.Count.ToString();

                // Phân trang
                PagedDataSource pds = new PagedDataSource
                {
                    DataSource = dt.DefaultView,
                    AllowPaging = true,
                    PageSize = 9,
                    CurrentPageIndex = pageIndex
                };

                rptLaptops.DataSource = pds;
                rptLaptops.DataBind();
                GeneratePager(pds.PageCount, pageIndex);
            }
        }

        protected void Filter_Changed(object sender, EventArgs e) => BindData(0);

        protected void btnClearFilter_Click(object sender, EventArgs e)
        {
            cblHang.ClearSelection();
            rblRam.ClearSelection();
            BindData(0);
        }

        private void GeneratePager(int totalPages, int currentPageIndex)
        {
            var pages = new List<object>();
            for (int i = 0; i < totalPages; i++)
                pages.Add(new { Text = (i + 1).ToString(), Value = i, Active = (i == currentPageIndex) });
            rptPager.DataSource = pages;
            rptPager.DataBind();
        }

        protected void Page_Changed(object sender, EventArgs e)
        {
            int pageIndex = int.Parse(((LinkButton)sender).CommandArgument);
            BindData(pageIndex);
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
