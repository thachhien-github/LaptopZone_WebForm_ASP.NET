using System;
using System.Web.UI;
namespace LaptopZone_project.Public
{
    public partial class Contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Nếu khách hàng đã đăng nhập, tự điền tên và email
            if (!IsPostBack && Session["HoTen"] != null)
            {
                txtHoTen.Text = Session["HoTen"].ToString();
            }
        }

        protected void btnGui_Click(object sender, EventArgs e)
        {
            // Kiểm tra dữ liệu
            if (string.IsNullOrEmpty(txtHoTen.Text) || string.IsNullOrEmpty(txtNoiDung.Text))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Vui lòng điền đầy đủ thông tin!');", true);
                return;
            }

            // Xử lý lưu vào Database (Bạn có thể tạo thêm bảng LienHe nếu cần)
            // Code xử lý SQL tương tự các trang trước...

            // Thông báo thành công
            string script = "alert('Cảm ơn bạn! Chúng tôi đã nhận được tin nhắn và sẽ phản hồi sớm nhất.'); window.location='Default.aspx';";
            ScriptManager.RegisterStartupScript(this, GetType(), "success", script, true);
        }
    }
}
