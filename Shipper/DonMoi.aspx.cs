using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace LaptopZone_project.Shipper
{
    public partial class DonMoi : System.Web.UI.Page
    {
        string strCon = ConfigurationManager
            .ConnectionStrings["LaptopStoreDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["TenDN"] == null)
            {
                Response.Redirect("~/Public/Login.aspx");
                return;
            }

            if (!IsPostBack)
                LoadDonMoi();
        }

        void LoadDonMoi()
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                SqlDataAdapter da = new SqlDataAdapter(@"
            SELECT d.SoDH, d.NgayDH, d.TriGia,
                   k.HoTenKH, k.DienThoai, k.DiaChi
            FROM DonDatHang d
            INNER JOIN KhachHang k ON d.MaKH = k.MaKH
            WHERE d.TrangThai = 0
            ORDER BY d.NgayDH DESC", con);

                DataTable dt = new DataTable();
                da.Fill(dt);

                rptDonMoi.DataSource = dt;
                rptDonMoi.DataBind();
            }
        }

        protected void rptDonMoi_ItemCommand(object source,
            System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Nhan")
            {
                int soDH = Convert.ToInt32(e.CommandArgument);
                string tenDN = Session["TenDN"].ToString();

                using (SqlConnection con = new SqlConnection(strCon))
                {
                    con.Open();

                    SqlCommand cmd = new SqlCommand(
                    @"UPDATE DonDatHang
                      SET TrangThai = 1,
                          TenDNShipper = @TenDN
                      WHERE SoDH = @SoDH
                      AND TrangThai = 0", con);

                    cmd.Parameters.AddWithValue("@SoDH", soDH);
                    cmd.Parameters.AddWithValue("@TenDN", tenDN);

                    cmd.ExecuteNonQuery();
                }

                LoadDonMoi();
            }
        }
    }
}