using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services; // QUAN TRỌNG: Thêm thư viện này
using System.Web.UI.WebControls;

namespace LaptopZone_project.Public
{
    public partial class Default : System.Web.UI.Page
    {
        private readonly string connStr = ConfigurationManager.ConnectionStrings["LaptopStoreDBConnectionString"].ConnectionString;

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
                string search = Request.QueryString["search"];

                if (!string.IsNullOrEmpty(search))
                {
                    sql += " AND (TenLaptop LIKE N'%' + @search + '%' OR CPU LIKE N'%' + @search + '%')";
                    ltrTitle.Text = "Kết quả cho: \"" + search + "\"";
                }
                else { ltrTitle.Text = "Laptop Mới Nhất"; }

                var selectedBrands = cblHang.Items.Cast<ListItem>().Where(i => i.Selected).Select(i => i.Value).ToList();
                if (selectedBrands.Count > 0)
                    sql += " AND MaHang IN (" + string.Join(",", selectedBrands) + ")";

                if (!string.IsNullOrEmpty(rblRam.SelectedValue))
                    sql += " AND RAM LIKE '%' + @ram + '%'";

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

                ltrTotalCount.Text = dt.Rows.Count.ToString();

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

        // ================= XỬ LÝ AJAX TẠI ĐÂY =================
        [WebMethod]
        public static string AddToCartAjax(int maLaptop)
        {
            string connStr = ConfigurationManager.ConnectionStrings["LaptopStoreDBConnectionString"].ConnectionString;
            var context = HttpContext.Current;

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

                    DataTable dt = context.Session["GioHang"] == null ? CreateCartTableStatic() : (DataTable)context.Session["GioHang"];

                    DataRow[] rows = dt.Select("MaLaptop = " + maLaptop);
                    int soLuongTrongGio = rows.Length > 0 ? (int)rows[0]["SoLuong"] : 0;

                    if (soLuongTrongGio + 1 > tonKho)
                        return $"Error|Rất tiếc! {tenLP} chỉ còn {tonKho} sản phẩm.";

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
                        nr["AnhBia"] = dr["AnhBia"].ToString();
                        nr["Gia"] = gia;
                        nr["SoLuong"] = 1;
                        nr["ThanhTien"] = gia;
                        dt.Rows.Add(nr);
                    }

                    context.Session["GioHang"] = dt;
                    int totalCount = dt.AsEnumerable().Sum(r => r.Field<int>("SoLuong"));

                    return $"Success|Đã thêm {tenLP} vào giỏ hàng!|{totalCount}";
                }
            }
            return "Error|Không tìm thấy sản phẩm.";
        }

        private static DataTable CreateCartTableStatic()
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