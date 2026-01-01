using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LaptopZone_project.Admin
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. Xóa toàn bộ dữ liệu trong Session
            Session.Remove("admin"); // Xóa riêng quyền admin
            Session.Abandon();       // Hủy bỏ toàn bộ session hiện tại

            // 2. Xóa sạch các Cookie liên quan (nếu có)
            Response.Cookies.Add(new HttpCookie("ASP.NET_SessionId", ""));

            // 3. Chuyển hướng về trang đăng nhập của Admin
            Response.Redirect("LoginAdmin.aspx");
        }
    }
}