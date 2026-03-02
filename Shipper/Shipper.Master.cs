using System;
using System.Configuration;
using System.Data.SqlClient;

namespace LaptopZone_project.Shipper
{
    public partial class Shipper : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() != "Shipper")
            {
                Response.Redirect("~/Public/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                ltrShipperName.Text = Session["HoTen"]?.ToString();
                SetActiveMenu();
            }
        }

        void SetActiveMenu()
        {
            string page = System.IO.Path.GetFileName(Request.Path);

            if (page == "Default.aspx")
                linkDashboard.CssClass = "flex flex-col items-center gap-1 text-primary";

            if (page == "DonMoi.aspx")
                linkDonMoi.CssClass = "flex flex-col items-center gap-1 text-primary";

            if (page == "LichSu.aspx")
                linkLichSu.CssClass = "flex flex-col items-center gap-1 text-primary";

            if (page == "Profile.aspx")
                linkProfile.CssClass = "flex flex-col items-center gap-1 text-primary";
        }
    }
}