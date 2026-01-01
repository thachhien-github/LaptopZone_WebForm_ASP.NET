using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LaptopZone_project.Public
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Không sử dụng IsPostBack ở đây nếu bro muốn cập nhật số lượng giỏ hàng 
            // ngay lập tức khi người dùng nhấn "Thêm vào giỏ" ở trang con
            CheckLoginStatus();
        }

        /// <summary>
        /// Kiểm tra trạng thái đăng nhập của khách hàng/admin
        /// </summary>
        private void CheckLoginStatus()
        {
            // 1. Kiểm tra nếu là Admin đăng nhập (Sử dụng hệ thống Admin mới)
            if (Session["admin"] != null)
            {
                phAnonymous.Visible = false;
                phLoggedIn.Visible = true;
                phAdmin.Visible = true; // Hiện nút Quản trị
                ltrTenKH.Text = Session["admin"].ToString() + " (Quản trị)";
            }
            // 2. Kiểm tra nếu là Khách hàng đăng nhập
            else if (Session["TenDN"] != null)
            {
                phAnonymous.Visible = false;
                phLoggedIn.Visible = true;
                phAdmin.Visible = false; // Khách thường không thấy nút Quản trị

                string hoTen = Session["HoTenKH"] != null ? Session["HoTenKH"].ToString() : Session["TenDN"].ToString();
                ltrTenKH.Text = hoTen;
            }
            // 3. Chưa đăng nhập
            else
            {
                phAnonymous.Visible = true;
                phLoggedIn.Visible = false;
                phAdmin.Visible = false;
            }
        }

        /// <summary>
        /// Hàm public để file Site.Master có thể gọi: <%= GetCartCount() %>
        /// </summary>
        public string GetCartCount()
        {
            try
            {
                if (Session["GioHang"] != null && Session["GioHang"] is DataTable dt)
                {
                    // Tính tổng giá trị cột "SoLuong" trong DataTable giỏ hàng
                    // Nếu giỏ hàng trống hoặc row count = 0, kết quả Sum sẽ là 0
                    object sumObject = dt.Compute("Sum(SoLuong)", "");
                    return sumObject != DBNull.Value ? sumObject.ToString() : "0";
                }
            }
            catch
            {
                return "0";
            }
            return "0";
        }

        /// <summary>
        /// Xử lý sự kiện tìm kiếm từ Header
        /// </summary>
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string keyword = txtSearch.Text.Trim();
            if (!string.IsNullOrEmpty(keyword))
            {
                // Chuyển hướng sang trang Default.aspx kèm query string 'search'
                Response.Redirect("~/Public/Default.aspx?search=" + Server.UrlEncode(keyword));
            }
        }

        /// <summary>
        /// Xử lý đăng xuất
        /// </summary>
        protected void lbtnLogout_Click(object sender, EventArgs e)
        {
            // Xóa sạch Session
            Session.Clear();
            Session.Abandon();

            // Chuyển hướng về trang chủ
            Response.Redirect("~/Public/Default.aspx");
        }
    }
}