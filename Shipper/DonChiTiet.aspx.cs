using System;
using System.Configuration;
using System.Data.SqlClient;

namespace LaptopZone_project.Shipper
{
    public partial class DonChiTiet : System.Web.UI.Page
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
                LoadChiTiet();
            }
        }

        void LoadChiTiet()
        {
            if (!int.TryParse(Request.QueryString["id"], out int soDH))
            {
                Response.Redirect("Default.aspx");
                return;
            }

            string tenDN = Session["TenDN"].ToString();

            using (SqlConnection con = new SqlConnection(strCon))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(@"
                    SELECT d.SoDH, d.NgayDH, d.TriGia, d.DaGiao,
                           k.HoTenKH, k.DiaChi
                    FROM DonDatHang d
                    INNER JOIN KhachHang k ON d.MaKH = k.MaKH
                    WHERE d.SoDH = @SoDH
                    AND d.TenDNShipper = @TenDN", con);

                cmd.Parameters.AddWithValue("@SoDH", soDH);
                cmd.Parameters.AddWithValue("@TenDN", tenDN);

                SqlDataReader rd = cmd.ExecuteReader();

                if (!rd.Read())
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                string diaChi = rd["DiaChi"].ToString();
                bool daGiao = Convert.ToBoolean(rd["DaGiao"]);

                // ===== HIỂN THỊ DỮ LIỆU =====
                lblSoDH.Text = rd["SoDH"].ToString();
                lblKhachHang.Text = rd["HoTenKH"].ToString();
                lblNgayDat.Text = Convert.ToDateTime(rd["NgayDH"])
                                    .ToString("dd/MM/yyyy HH:mm");
                lblDiaChi.Text = diaChi;
                lblTriGia.Text = string.Format("{0:N0} đ", rd["TriGia"]);

                // ===== TRẠNG THÁI =====
                if (daGiao)
                {
                    lblTrangThai.Text = "Đã giao";
                    lblTrangThai.CssClass += " bg-green-100 text-green-700";
                    btnHoanThanh.Visible = false;
                }
                else
                {
                    lblTrangThai.Text = "Đang giao";
                    lblTrangThai.CssClass += " bg-yellow-100 text-yellow-700";
                    btnHoanThanh.Visible = true;
                }

                // ===== GOOGLE MAP =====
                string encodedDiaChi = Server.UrlEncode(diaChi);

                iframeMap.Attributes["src"] =
                    "https://www.google.com/maps?q=" +
                    encodedDiaChi + "&output=embed";

                lnkMoMap.NavigateUrl =
                    "https://www.google.com/maps/search/?api=1&query=" +
                    encodedDiaChi;
            }
        }

        protected void btnHoanThanh_Click(object sender, EventArgs e)
        {
            if (!int.TryParse(Request.QueryString["id"], out int soDH))
                return;

            string tenDN = Session["TenDN"].ToString();

            using (SqlConnection con = new SqlConnection(strCon))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(@"
                    UPDATE DonDatHang
                    SET TrangThai = 2,
                        DaGiao = 1,
                        NgayGiao = GETDATE()
                    WHERE SoDH = @SoDH
                    AND TenDNShipper = @TenDN", con);

                cmd.Parameters.AddWithValue("@SoDH", soDH);
                cmd.Parameters.AddWithValue("@TenDN", tenDN);

                cmd.ExecuteNonQuery();
            }

            LoadChiTiet();
        }
    }
}