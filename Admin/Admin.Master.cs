using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web.Services;

namespace LaptopZone_project.Admin
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. Kiểm tra quyền Admin
            if (Session["admin"] == null)
            {
                Response.Redirect("LoginAdmin.aspx");
            }

            if (!IsPostBack)
            {
                // 2. Hiển thị tên Admin
                ltrAdminName.Text = Session["admin"].ToString();
                UpdateNavigationState();
            }
        }

        private void UpdateNavigationState()
        {
            string pageName = Path.GetFileName(Request.Url.AbsolutePath).ToLower();
            string normalClass = "flex items-center gap-3 px-3 py-2.5 rounded-lg text-slate-500 hover:bg-slate-50 transition-all group";

            nav_dash.Attributes["class"] = normalClass;
            nav_laptop.Attributes["class"] = normalClass;
            nav_loai.Attributes["class"] = normalClass;
            nav_hang.Attributes["class"] = normalClass;
            nav_kh.Attributes["class"] = normalClass;
            nav_dh.Attributes["class"] = normalClass;

            switch (pageName)
            {
                case "dashboard.aspx":
                    SetActive(nav_dash, "Dashboard", "Thống kê tổng quan");
                    break;
                case "quanlylaptop.aspx":
                    SetActive(nav_laptop, "Sản phẩm", "Quản lý danh mục Laptop");
                    break;
                case "quanlyloai.aspx":
                    SetActive(nav_loai, "Loại Laptop", "Danh mục phân loại");
                    break;
                case "quanlyhang.aspx":
                    SetActive(nav_hang, "Hãng sản xuất", "Đối tác sản xuất");
                    break;
                case "quanlykhachhang.aspx":
                    SetActive(nav_kh, "Khách hàng", "Danh sách người dùng");
                    break;
                case "quanlydonhang.aspx":
                    SetActive(nav_dh, "Đơn hàng", "Theo dõi đơn đặt hàng");
                    break;
            }
        }

        private void SetActive(System.Web.UI.HtmlControls.HtmlAnchor control, string title, string breadcrumb)
        {
            control.Attributes["class"] = "flex items-center gap-3 px-3 py-2.5 rounded-lg nav-item-active transition-all group";
            ltrTitle.Text = title;
            ltrBreadcrumb.Text = breadcrumb;
        }

        [WebMethod]
        public static object GetNewOrders()
        {
            List<object> notifications = new List<object>();
            string connString = ConfigurationManager.ConnectionStrings["LaptopStoreDBConnectionString"]?.ConnectionString;

            try
            {
                using (SqlConnection con = new SqlConnection(connString))
                {
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
            }
            catch { return new { error = "Lỗi kết nối" }; }
            return notifications;
        }

        protected void lbtnThoat_Click(object sender, EventArgs e)
        {
            Session.Remove("admin");
            Session.Abandon();
            Response.Redirect("LoginAdmin.aspx");
        }
    }
}