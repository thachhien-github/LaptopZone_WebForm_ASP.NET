using System;
using System.Data;
using System.Linq;
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
            if (Session["GioHang"] == null)
            {
                ShowEmpty();
                UpdateMasterCount(0);
                return;
            }

            DataTable dt = (DataTable)Session["GioHang"];

            if (dt.Rows.Count == 0)
            {
                ShowEmpty();
                UpdateMasterCount(0);
                return;
            }

            phEmptyCart.Visible = false;
            phCartContent.Visible = true;

            rptGioHang.DataSource = dt;
            rptGioHang.DataBind();

            // Tính toán tiền bạc
            decimal tamTinh = dt.AsEnumerable().Sum(r => r.Field<decimal>("ThanhTien"));
            decimal vat = tamTinh * 0.1m;
            decimal tongCong = tamTinh + vat;

            int tongSoLuong = dt.AsEnumerable().Sum(r => r.Field<int>("SoLuong"));

            ltrCount.Text = tongSoLuong.ToString();
            ltrTamTinh.Text = tamTinh.ToString("N0");
            ltrVAT.Text = vat.ToString("N0");
            ltrTongCong.Text = tongCong.ToString("N0");

            UpdateMasterCount(tongSoLuong);
        }

        private void ShowEmpty()
        {
            phEmptyCart.Visible = true;
            phCartContent.Visible = false;
            ltrCount.Text = "0";
        }

        private void UpdateMasterCount(int count)
        {
            string script = $"updateMasterCartCount('{count}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "UpdateCartCount", script, true);
        }

        protected void btnTang_Click(object sender, EventArgs e)
        {
            int maLaptop = int.Parse(((LinkButton)sender).CommandArgument);
            UpdateQuantity(maLaptop, 1);
        }

        protected void btnGiam_Click(object sender, EventArgs e)
        {
            int maLaptop = int.Parse(((LinkButton)sender).CommandArgument);
            UpdateQuantity(maLaptop, -1);
        }

        protected void txtSoLuong_TextChanged(object sender, EventArgs e)
        {
            TextBox txt = (TextBox)sender;
            // Lấy ID từ thuộc tính data-id đã gán ở ASPX
            int maLaptop = int.Parse(txt.Attributes["data-id"]);

            int soLuong;
            if (!int.TryParse(txt.Text, out soLuong) || soLuong <= 0)
                soLuong = 1;

            SetQuantity(maLaptop, soLuong);
        }

        private void UpdateQuantity(int maLaptop, int delta)
        {
            DataTable dt = (DataTable)Session["GioHang"];
            if (dt == null) return;

            DataRow row = dt.AsEnumerable().FirstOrDefault(r => r.Field<int>("MaLaptop") == maLaptop);
            if (row != null)
            {
                int soLuongMoi = Convert.ToInt32(row["SoLuong"]) + delta;
                if (soLuongMoi < 1) soLuongMoi = 1;

                row["SoLuong"] = soLuongMoi;
                row["ThanhTien"] = soLuongMoi * Convert.ToDecimal(row["Gia"]);

                Session["GioHang"] = dt;
            }
            LoadCart();
        }

        private void SetQuantity(int maLaptop, int soLuong)
        {
            DataTable dt = (DataTable)Session["GioHang"];
            if (dt == null) return;

            DataRow row = dt.AsEnumerable().FirstOrDefault(r => r.Field<int>("MaLaptop") == maLaptop);
            if (row != null)
            {
                row["SoLuong"] = soLuong;
                row["ThanhTien"] = soLuong * Convert.ToDecimal(row["Gia"]);

                Session["GioHang"] = dt;
            }
            LoadCart();
        }

        protected void btnXoa_Click(object sender, EventArgs e)
        {
            int maLaptop = int.Parse(((LinkButton)sender).CommandArgument);
            DataTable dt = (DataTable)Session["GioHang"];
            if (dt == null) return;

            DataRow row = dt.AsEnumerable().FirstOrDefault(r => r.Field<int>("MaLaptop") == maLaptop);
            if (row != null)
            {
                dt.Rows.Remove(row);
                Session["GioHang"] = dt;
            }
            LoadCart();
        }

        protected void btnThanhToan_Click(object sender, EventArgs e)
        {
            if (Session["TenDN"] == null)
                Response.Redirect("Login.aspx?ReturnUrl=GioHang.aspx");
            else
                Response.Redirect("ThanhToan.aspx");
        }
    }
}