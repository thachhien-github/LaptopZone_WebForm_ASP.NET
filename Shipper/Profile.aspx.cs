using System;

namespace LaptopZone_project.Shipper
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["TenDN"] == null)
            {
                Response.Redirect("~/Public/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                lblTenDN.Text = Session["TenDN"].ToString();
                lblTenDN2.Text = Session["TenDN"].ToString();
            }
        }

        protected void btnDangXuat_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("~/Public/Login.aspx");
        }
    }
}