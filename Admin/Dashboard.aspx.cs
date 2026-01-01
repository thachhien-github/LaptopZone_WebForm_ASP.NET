using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LaptopZone_project.Admin
{
    [ScriptService]
    public partial class Dashboard : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["LaptopStoreDBConnectionString"]?.ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Mặc định lọc dữ liệu tháng hiện tại
                txtTuNgay.Text = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1).ToString("yyyy-MM-dd");
                txtDenNgay.Text = DateTime.Now.ToString("yyyy-MM-dd");
                RefreshData();
            }
        }

        protected void btnLoc_Click(object sender, EventArgs e) => RefreshData();

        private void RefreshData()
        {
            LoadStats();
            LoadRecentOrders();
            LoadTopBrands();
        }

        private void LoadStats()
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                string sql = @"
                    SELECT 
                        (SELECT SUM(TriGia) FROM DonDatHang WHERE NgayDH >= @tu AND NgayDH <= @den) as DoanhThu,
                        (SELECT COUNT(*) FROM DonDatHang WHERE NgayDH >= @tu AND NgayDH <= @den) as SoDonHang,
                        (SELECT COUNT(*) FROM Laptop) as TongLaptop,
                        (SELECT COUNT(*) FROM KhachHang) as TongKhachHang";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@tu", txtTuNgay.Text);
                cmd.Parameters.AddWithValue("@den", txtDenNgay.Text + " 23:59:59");
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    decimal dt = dr["DoanhThu"] != DBNull.Value ? Convert.ToDecimal(dr["DoanhThu"]) : 0;
                    ltrDoanhThu.Text = dt.ToString("N0");
                    ltrDonHang.Text = dr["SoDonHang"].ToString();
                    ltrLaptop.Text = dr["TongLaptop"].ToString();
                    ltrKhachHang.Text = dr["TongKhachHang"].ToString();
                }
            }
        }

        private void LoadRecentOrders()
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                // Lấy thêm cột DaGiao để hiển thị nhãn trạng thái
                string sql = @"SELECT TOP 8 d.TriGia, d.NgayDH, d.DaGiao, k.HoTenKH 
                               FROM DonDatHang d 
                               LEFT JOIN KhachHang k ON d.MaKH = k.MaKH 
                               ORDER BY d.NgayDH DESC";
                SqlDataAdapter da = new SqlDataAdapter(sql, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvMoiNhat.DataSource = dt;
                gvMoiNhat.DataBind();
            }
        }

        private void LoadTopBrands()
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                // Thống kê số lượng máy bán ra theo hãng
                string sql = @"SELECT TOP 5 h.TenHang, SUM(ct.SoLuong) as SL
                               FROM CTDatHang ct
                               JOIN Laptop l ON ct.MaLaptop = l.MaLaptop
                               JOIN HangSanXuat h ON l.MaHang = h.MaHang
                               GROUP BY h.TenHang ORDER BY SL DESC";
                SqlDataAdapter da = new SqlDataAdapter(sql, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptTopBrands.DataSource = dt;
                rptTopBrands.DataBind();
            }
        }

        public string GetChartData()
        {
            List<string> labels = new List<string>();
            List<decimal> values = new List<decimal>();
            using (SqlConnection con = new SqlConnection(connString))
            {
                string sql = @"SELECT CAST(NgayDH AS DATE) as Ngay, SUM(TriGia) as DT 
                               FROM DonDatHang 
                               WHERE NgayDH >= DATEADD(day, -6, GETDATE()) 
                               GROUP BY CAST(NgayDH AS DATE) ORDER BY Ngay";
                con.Open();
                SqlCommand cmd = new SqlCommand(sql, con);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    labels.Add(Convert.ToDateTime(dr["Ngay"]).ToString("dd/MM"));
                    values.Add(Convert.ToDecimal(dr["DT"]));
                }
            }
            return new JavaScriptSerializer().Serialize(new { labels, values });
        }

        public string GetCategoryChartData()
        {
            List<string> labels = new List<string>();
            List<int> values = new List<int>();
            using (SqlConnection con = new SqlConnection(connString))
            {
                string sql = @"SELECT l.TenLoai, COUNT(p.MaLaptop) as SL
                               FROM LoaiLaptop l
                               LEFT JOIN Laptop p ON l.MaLoai = p.MaLoai
                               GROUP BY l.TenLoai";
                con.Open();
                SqlCommand cmd = new SqlCommand(sql, con);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    labels.Add(dr["TenLoai"].ToString());
                    values.Add(Convert.ToInt32(dr["SL"]));
                }
            }
            return new JavaScriptSerializer().Serialize(new { labels, values });
        }

        // --- WEB METHOD XỬ LÝ THÔNG BÁO REALTIME ---
        [WebMethod(EnableSession = true)]
        public static object GetNewOrders()
        {
            List<object> notifications = new List<object>();
            string connStr = ConfigurationManager.ConnectionStrings["LaptopStoreDBConnectionString"]?.ConnectionString;

            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    // Truy vấn lấy đơn hàng chưa giao từ LaptopStoreDB
                    string sql = @"SELECT TOP 5 d.SoDH, d.NgayDH, k.HoTenKH 
                                   FROM DonDatHang d 
                                   INNER JOIN KhachHang k ON d.MaKH = k.MaKH 
                                   WHERE d.DaGiao = 0 OR d.DaGiao IS NULL
                                   ORDER BY d.NgayDH DESC";

                    SqlCommand cmd = new SqlCommand(sql, con);
                    con.Open();
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            notifications.Add(new
                            {
                                ID = dr["SoDH"].ToString(),
                                User = dr["HoTenKH"].ToString(),
                                Time = Convert.ToDateTime(dr["NgayDH"]).ToString("HH:mm dd/MM")
                            });
                        }
                    }
                }
                // Trả về dữ liệu bọc trong đối tượng để ASP.NET tự serialize sang JSON
                return notifications;
            }
            catch (Exception ex)
            {
                return new { error = ex.Message };
            }
        }
    }
}