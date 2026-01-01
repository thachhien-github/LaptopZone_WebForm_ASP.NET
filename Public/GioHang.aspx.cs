using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LaptopZone_project.Public
{
    public partial class GioHang : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCart();
            }
        }

        private void LoadCart()
        {
            if (Session["GioHang"] != null)
            {
                DataTable dt = (DataTable)Session["GioHang"];
                if (dt.Rows.Count > 0)
                {
                    phEmptyCart.Visible = false;
                    phCartContent.Visible = true;

                    rptGioHang.DataSource = dt;
                    rptGioHang.DataBind();

                    // Tính toán tiền
                    decimal tamTinh = dt.AsEnumerable().Sum(row => row.Field<decimal>("ThanhTien"));
                    decimal vat = tamTinh * 0.1m;
                    decimal tongCong = tamTinh + vat;

                    ltrCount.Text = dt.Rows.Count.ToString();
                    ltrTamTinh.Text = tamTinh.ToString("N0");
                    ltrVAT.Text = vat.ToString("N0");
                    ltrTongCong.Text = tongCong.ToString("N0");
                }
                else { ShowEmpty(); }
            }
            else { ShowEmpty(); }
        }

        private void ShowEmpty()
        {
            phEmptyCart.Visible = true;
            phCartContent.Visible = false;
            ltrCount.Text = "0";
        }

        // Cập nhật khi gõ số vào TextBox
        protected void txtSoLuong_TextChanged(object sender, EventArgs e)
        {
            TextBox txt = (TextBox)sender;
            RepeaterItem item = (RepeaterItem)txt.NamingContainer;
            int maLaptop = int.Parse(((LinkButton)item.FindControl("btnTang")).CommandArgument); // Lấy mã từ nút ẩn hoặc argument

            UpdateCart(maLaptop, int.Parse(txt.Text));
        }

        // Nút Tăng số lượng
        protected void btnTang_Click(object sender, EventArgs e)
        {
            int maLaptop = int.Parse(((LinkButton)sender).CommandArgument);
            DataTable dt = (DataTable)Session["GioHang"];
            DataRow row = dt.Select("MaLaptop = " + maLaptop).FirstOrDefault();
            if (row != null)
            {
                int slMoi = (int)row["SoLuong"] + 1;
                UpdateCart(maLaptop, slMoi);
            }
        }

        // Nút Giảm số lượng
        protected void btnGiam_Click(object sender, EventArgs e)
        {
            int maLaptop = int.Parse(((LinkButton)sender).CommandArgument);
            DataTable dt = (DataTable)Session["GioHang"];
            DataRow row = dt.Select("MaLaptop = " + maLaptop).FirstOrDefault();
            if (row != null)
            {
                int slMoi = (int)row["SoLuong"] - 1;
                if (slMoi > 0) UpdateCart(maLaptop, slMoi);
            }
        }

        // Hàm dùng chung để cập nhật Session
        private void UpdateCart(int maLaptop, int soLuong)
        {
            DataTable dt = (DataTable)Session["GioHang"];
            foreach (DataRow dr in dt.Rows)
            {
                if ((int)dr["MaLaptop"] == maLaptop)
                {
                    dr["SoLuong"] = soLuong;
                    dr["ThanhTien"] = soLuong * (decimal)dr["Gia"];
                    break;
                }
            }
            Session["GioHang"] = dt;
            LoadCart();
        }

        // Xóa sản phẩm
        protected void btnXoa_Click(object sender, EventArgs e)
        {
            int maLaptop = int.Parse(((LinkButton)sender).CommandArgument);
            DataTable dt = (DataTable)Session["GioHang"];
            DataRow row = dt.Select("MaLaptop = " + maLaptop).FirstOrDefault();
            if (row != null)
            {
                dt.Rows.Remove(row);
            }
            Session["GioHang"] = dt;
            LoadCart();
        }

        // Nút Thanh toán
        protected void btnThanhToan_Click(object sender, EventArgs e)
        {
            if (Session["TenDN"] == null)
            {
                // Chưa đăng nhập thì sang trang Login, lưu lại ReturnUrl để quay lại giỏ hàng
                Response.Redirect("Login.aspx?ReturnUrl=GioHang.aspx");
            }
            else
            {
                // Đã đăng nhập thì sang trang thanh toán/xác nhận
                Response.Redirect("ThanhToan.aspx");
            }
        }
    }
}
