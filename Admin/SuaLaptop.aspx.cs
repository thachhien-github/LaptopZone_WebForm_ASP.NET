using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LaptopZone_project.Admin
{
    public partial class SuaLaptop : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["LaptopStoreDBConnectionString"]?.ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDataControls();
                if (Request.QueryString["id"] != null)
                {
                    LoadLaptopDetails(int.Parse(Request.QueryString["id"]));
                }
                else
                {
                    Response.Redirect("QuanLyLaptop.aspx");
                }
            }
        }

        private void LoadDataControls()
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                con.Open();
                // Load Loại
                SqlDataAdapter daLoai = new SqlDataAdapter("SELECT * FROM LoaiLaptop", con);
                DataTable dtLoai = new DataTable();
                daLoai.Fill(dtLoai);
                ddlLoai.DataSource = dtLoai;
                ddlLoai.DataTextField = "TenLoai";
                ddlLoai.DataValueField = "MaLoai";
                ddlLoai.DataBind();

                // Load Hãng
                SqlDataAdapter daHang = new SqlDataAdapter("SELECT * FROM HangSanXuat", con);
                DataTable dtHang = new DataTable();
                daHang.Fill(dtHang);
                ddlHang.DataSource = dtHang;
                ddlHang.DataTextField = "TenHang";
                ddlHang.DataValueField = "MaHang";
                ddlHang.DataBind();
            }
        }

        private void LoadLaptopDetails(int id)
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM Laptop WHERE MaLaptop = @id", con);
                cmd.Parameters.AddWithValue("@id", id);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtTenLaptop.Text = dr["TenLaptop"].ToString();
                    ddlLoai.SelectedValue = dr["MaLoai"].ToString();
                    ddlHang.SelectedValue = dr["MaHang"].ToString();
                    txtGia.Text = Convert.ToDecimal(dr["Gia"]).ToString("0");
                    txtSoLuong.Text = dr["SoLuong"].ToString();
                    txtMoTa.Text = dr["MoTa"].ToString();
                    txtCPU.Text = dr["CPU"].ToString();
                    txtRAM.Text = dr["RAM"].ToString();
                    txtOCung.Text = dr["OCung"].ToString();
                    txtManHinh.Text = dr["ManHinh"].ToString();
                    txtVGA.Text = dr["VGA"].ToString();
                    txtHDH.Text = dr["HDH"].ToString();

                    string anh = dr["AnhBia"].ToString();
                    hfAnhCu.Value = anh;
                    imgHienTai.ImageUrl = "~/Images/" + (string.IsNullOrEmpty(anh) ? "no-image.png" : anh);
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                int id = int.Parse(Request.QueryString["id"]);
                string tenFileMoi = hfAnhCu.Value;

                // 1. Xử lý ảnh nếu Admin upload ảnh mới
                if (fuAnhBia.HasFile)
                {
                    // Xóa ảnh cũ trên Server (tránh rác bộ nhớ)
                    if (!string.IsNullOrEmpty(hfAnhCu.Value) && hfAnhCu.Value != "no-image.png")
                    {
                        string oldPath = Server.MapPath("~/Images/") + hfAnhCu.Value;
                        if (File.Exists(oldPath)) File.Delete(oldPath);
                    }

                    // Lưu ảnh mới với tên duy nhất (GUID)
                    tenFileMoi = Guid.NewGuid().ToString() + Path.GetExtension(fuAnhBia.FileName);
                    fuAnhBia.SaveAs(Server.MapPath("~/Images/") + tenFileMoi);
                }

                // 2. Cập nhật Database
                using (SqlConnection con = new SqlConnection(connString))
                {
                    string sql = @"UPDATE Laptop SET 
                                TenLaptop=@ten, MaLoai=@loai, MaHang=@hang, Gia=@gia, SoLuong=@soluong,
                                MoTa=@mota, AnhBia=@anh, NgayCapNhat=GETDATE(),
                                CPU=@cpu, RAM=@ram, OCung=@ocung, ManHinh=@manhinh, VGA=@vga, HDH=@hdh
                                WHERE MaLaptop=@id";

                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@ten", txtTenLaptop.Text.Trim());
                    cmd.Parameters.AddWithValue("@loai", ddlLoai.SelectedValue);
                    cmd.Parameters.AddWithValue("@hang", ddlHang.SelectedValue);
                    cmd.Parameters.AddWithValue("@gia", decimal.Parse(txtGia.Text));
                    cmd.Parameters.AddWithValue("@soluong", string.IsNullOrEmpty(txtSoLuong.Text) ? 0 : int.Parse(txtSoLuong.Text));
                    cmd.Parameters.AddWithValue("@mota", txtMoTa.Text.Trim());
                    cmd.Parameters.AddWithValue("@anh", tenFileMoi);
                    cmd.Parameters.AddWithValue("@cpu", txtCPU.Text.Trim());
                    cmd.Parameters.AddWithValue("@ram", txtRAM.Text.Trim());
                    cmd.Parameters.AddWithValue("@ocung", txtOCung.Text.Trim());
                    cmd.Parameters.AddWithValue("@manhinh", txtManHinh.Text.Trim());
                    cmd.Parameters.AddWithValue("@vga", txtVGA.Text.Trim());
                    cmd.Parameters.AddWithValue("@hdh", txtHDH.Text.Trim());
                    cmd.Parameters.AddWithValue("@id", id);

                    con.Open();
                    cmd.ExecuteNonQuery();

                    // Thông báo và quay lại danh sách
                    ScriptManager.RegisterStartupScript(this, GetType(), "success", "alert('Cập nhật thành công!'); window.location='QuanLyLaptop.aspx';", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "error", $"alert('Lỗi hệ thống: {ex.Message}');", true);
            }
        }

        // --- WEB METHOD XỬ LÝ THÔNG BÁO REALTIME ---
        [WebMethod(EnableSession = true)]
        public static object GetNewOrders()
        {
            List<object> notifications = new List<object>();
            string connStr = ConfigurationManager.ConnectionStrings["LaptopStoreDBConnectionString"]?.ConnectionString;

            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    // Truy vấn lấy đơn hàng chưa giao từ LaptopStoreDB
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
                // Trả về dữ liệu bọc trong đối tượng để ASP.NET tự serialize sang JSON
                return notifications;
            }
            catch (Exception ex)
            {
                return new { error = ex.Message };
            }
        }
    }
}