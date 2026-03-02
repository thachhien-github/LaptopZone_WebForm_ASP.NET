using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace LaptopZone_project.Shipper
{
    public partial class DonDangGiao : System.Web.UI.Page
    {
        string strCon = ConfigurationManager
            .ConnectionStrings["LaptopStoreDBConnectionString"]
            .ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Kiểm tra đăng nhập
            if (Session["TenDN"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadDangGiao();
            }
        }

        void LoadDangGiao()
        {
            string tenDN = Session["TenDN"].ToString();

            using (SqlConnection con = new SqlConnection(strCon))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                @"SELECT SoDH, NgayDH, TriGia
                  FROM DonDatHang
                  WHERE TrangThai = 1
                  AND TenDNShipper = @TenDN
                  ORDER BY NgayDH DESC", con);

                da.SelectCommand.Parameters.AddWithValue("@TenDN", tenDN);

                DataTable dt = new DataTable();
                da.Fill(dt);

                rptDangGiao.DataSource = dt;
                rptDangGiao.DataBind();
            }
        }

        protected void rptDangGiao_ItemCommand(object source,
            RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "HoanThanh")
            {
                int soDH = Convert.ToInt32(e.CommandArgument);
                string tenDN = Session["TenDN"].ToString();

                using (SqlConnection con = new SqlConnection(strCon))
                {
                    con.Open();

                    SqlCommand cmd = new SqlCommand(
                    @"UPDATE DonDatHang
                      SET TrangThai = 2,
                          DaGiao = 1,
                          NgayGiao = GETDATE()
                      WHERE SoDH = @SoDH
                      AND TenDNShipper = @TenDN
                      AND TrangThai = 1", con);

                    cmd.Parameters.AddWithValue("@SoDH", soDH);
                    cmd.Parameters.AddWithValue("@TenDN", tenDN);

                    cmd.ExecuteNonQuery();
                }

                LoadDangGiao();
            }
        }
    }
}