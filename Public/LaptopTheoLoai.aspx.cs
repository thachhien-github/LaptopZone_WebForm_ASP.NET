using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.Services;
using System.Web.UI.WebControls;

namespace LaptopZone_project.Public
{
    public partial class LaptopTheoLoai : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["LaptopStoreDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["MaLoai"]))
                {
                    LoadFilterData();
                    BindData(0);
                }
                else
                {
                    Response.Redirect("Default.aspx");
                }
            }
        }

        private void LoadFilterData()
        {
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
            string maLoai = Request.QueryString["MaLoai"];

            using (SqlConnection con = new SqlConnection(connStr))
            {
                // Lấy tên loại hiển thị tiêu đề
                SqlCommand cmdLoai = new SqlCommand("SELECT TenLoai FROM LoaiLaptop WHERE MaLoai = @ML", con);
                cmdLoai.Parameters.AddWithValue("@ML", maLoai);
                con.Open();
                string tenLoai = cmdLoai.ExecuteScalar()?.ToString() ?? "Laptop";
                ltrTenLoai.Text = tenLoai;
                ltrBreadcrumb.Text = tenLoai;

                // Query gốc
                string sql = "SELECT * FROM Laptop WHERE MaLoai = @ML";

                // Filter Hãng
                var selectedBrands = cblHang.Items.Cast<ListItem>().Where(i => i.Selected).Select(i => i.Value).ToList();
                if (selectedBrands.Count > 0)
                    sql += " AND MaHang IN (" + string.Join(",", selectedBrands) + ")";

                // Filter RAM
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
                cmd.Parameters.AddWithValue("@ML", maLoai);
                if (!string.IsNullOrEmpty(rblRam.SelectedValue)) cmd.Parameters.AddWithValue("@ram", rblRam.SelectedValue);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

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

                        // 1. Khởi tạo giỏ hàng
                        LaptopTheoLoai page = new LaptopTheoLoai();
                        DataTable dt = System.Web.HttpContext.Current.Session["GioHang"] == null
                                       ? page.CreateCartTable()
                                       : (DataTable)System.Web.HttpContext.Current.Session["GioHang"];

                        // 2. Kiểm tra hàng trong giỏ
                        int soLuongTrongGio = 0;
                        DataRow[] rows = dt.Select("MaLaptop = " + maLaptop);
                        if (rows.Length > 0)
                            soLuongTrongGio = (int)rows[0]["SoLuong"];

                        if (soLuongTrongGio + 1 > tonKho)
                        {
                            return $"Error|Rất tiếc! {tenLP} chỉ còn {tonKho} sản phẩm.";
                        }

                        // 3. Cập nhật DataTable
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

                        // Tính tổng số lượng để cập nhật icon giỏ hàng
                        int totalItems = dt.AsEnumerable().Sum(x => x.Field<int>("SoLuong"));

                        return $"Success|Đã thêm {tenLP} vào giỏ hàng!|{totalItems}";
                    }
                    return "Error|Sản phẩm không tồn tại.";
                }
            }
            catch (Exception ex)
            {
                return "Error|Lỗi: " + ex.Message;
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
