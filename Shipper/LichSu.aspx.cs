using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace LaptopZone_project.Shipper
{
    public partial class LichSu : System.Web.UI.Page
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
                LoadLichSu();
            }
        }

        void LoadLichSu(string tuNgay = null, string denNgay = null)
        {
            string tenDN = Session["TenDN"].ToString();

            using (SqlConnection con = new SqlConnection(strCon))
            {
                string query = @"
                    SELECT d.SoDH, d.TriGia, d.NgayGiao,
                           k.HoTenKH, k.DiaChi
                    FROM DonDatHang d
                    INNER JOIN KhachHang k ON d.MaKH = k.MaKH
                    WHERE d.TrangThai = 2
                    AND d.TenDNShipper = @TenDN";

                if (!string.IsNullOrEmpty(tuNgay))
                    query += " AND CAST(d.NgayGiao AS DATE) >= @TuNgay";

                if (!string.IsNullOrEmpty(denNgay))
                    query += " AND CAST(d.NgayGiao AS DATE) <= @DenNgay";

                query += " ORDER BY d.NgayGiao DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                da.SelectCommand.Parameters.AddWithValue("@TenDN", tenDN);

                if (!string.IsNullOrEmpty(tuNgay))
                    da.SelectCommand.Parameters.AddWithValue("@TuNgay", tuNgay);

                if (!string.IsNullOrEmpty(denNgay))
                    da.SelectCommand.Parameters.AddWithValue("@DenNgay", denNgay);

                DataTable dt = new DataTable();
                da.Fill(dt);

                rptLichSu.DataSource = dt;
                rptLichSu.DataBind();

                // Tính tổng tiền
                decimal tong = 0;
                foreach (DataRow row in dt.Rows)
                {
                    tong += Convert.ToDecimal(row["TriGia"]);
                }

                lblTongTien.Text =
                    string.Format("{0:N0} đ", tong);
            }
        }

        protected void btnLoc_Click(object sender, EventArgs e)
        {
            LoadLichSu(txtTuNgay.Text, txtDenNgay.Text);
        }
    }
}