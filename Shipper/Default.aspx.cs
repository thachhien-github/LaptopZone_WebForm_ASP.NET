using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace LaptopZone_project.Shipper
{
    public partial class Default : System.Web.UI.Page
    {
        string strCon = ConfigurationManager
            .ConnectionStrings["LaptopStoreDBConnectionString"]
            .ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["TenDN"] == null)
            {
                Response.Redirect("~/Public/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                ltrTen.Text = Session["TenDN"].ToString();
                LoadStats();
                LoadDonDangGiao();
            }
        }

        void LoadStats()
        {
            string tenDN = Session["TenDN"].ToString();

            using (SqlConnection con = new SqlConnection(strCon))
            {
                con.Open();

                // Chờ giao toàn hệ thống
                ltrChoGiao.Text = GetCount(con, "TrangThai = 0");

                // Đang giao của tài xế
                ltrDangGiao.Text = GetCount(con,
                    "TrangThai = 1 AND TenDNShipper = @TenDN",
                    tenDN);

                // Tổng tiền đã thu
                SqlCommand cmdTien = new SqlCommand(@"
                    SELECT ISNULL(SUM(TriGia),0)
                    FROM DonDatHang
                    WHERE TrangThai = 2
                    AND TenDNShipper = @TenDN", con);

                cmdTien.Parameters.AddWithValue("@TenDN", tenDN);

                object tongTien = cmdTien.ExecuteScalar();

                ltrDaGiao.Text =
                    string.Format("{0:N0} đ", tongTien);
            }
        }

        string GetCount(SqlConnection con, string condition, string tenDN = null)
        {
            SqlCommand cmd = new SqlCommand(
                $"SELECT COUNT(*) FROM DonDatHang WHERE {condition}", con);

            if (tenDN != null)
                cmd.Parameters.AddWithValue("@TenDN", tenDN);

            object result = cmd.ExecuteScalar();
            return result != null ? result.ToString() : "0";
        }

        void LoadDonDangGiao()
        {
            string tenDN = Session["TenDN"].ToString();

            using (SqlConnection con = new SqlConnection(strCon))
            {
                SqlDataAdapter da = new SqlDataAdapter(@"
                    SELECT d.SoDH, d.NgayDH, d.TriGia,
                           k.HoTenKH, k.DiaChi
                    FROM DonDatHang d
                    INNER JOIN KhachHang k ON d.MaKH = k.MaKH
                    WHERE d.TenDNShipper = @TenDN
                    AND d.TrangThai = 1
                    ORDER BY d.NgayDH ASC", con);

                da.SelectCommand.Parameters.AddWithValue("@TenDN", tenDN);

                DataTable dt = new DataTable();
                da.Fill(dt);

                rptDonGanDay.DataSource = dt;
                rptDonGanDay.DataBind();
            }
        }
    }
}