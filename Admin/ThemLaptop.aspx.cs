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
    public partial class ThemLaptop : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["LaptopStoreDBConnectionString"]?.ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDropdowns();
            }
        }

        private void LoadDropdowns()
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
                ddlLoai.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Chọn loại...", "0"));

                // Load Hãng
                SqlDataAdapter daHang = new SqlDataAdapter("SELECT * FROM HangSanXuat", con);
                DataTable dtHang = new DataTable();
                daHang.Fill(dtHang);
                ddlHang.DataSource = dtHang;
                ddlHang.DataTextField = "TenHang";
                ddlHang.DataValueField = "MaHang";
                ddlHang.DataBind();
                ddlHang.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Chọn hãng...", "0"));
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            // Kiểm tra dữ liệu cơ bản
            if (string.IsNullOrEmpty(txtTenLaptop.Text) || string.IsNullOrEmpty(txtGia.Text))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Vui lòng nhập tên và giá máy!');", true);
                return;
            }

            string tenFile = "no-image.png";
            if (fuAnhBia.HasFile)
            {
                tenFile = Path.GetFileName(fuAnhBia.FileName);
                string uploadPath = Server.MapPath("~/Images/");
                if (!Directory.Exists(uploadPath)) Directory.CreateDirectory(uploadPath);
                fuAnhBia.SaveAs(uploadPath + tenFile);
            }

            using (SqlConnection con = new SqlConnection(connString))
            {
                // Thêm VGA và HDH vào câu SQL
                string sql = @"INSERT INTO Laptop (TenLaptop, MaLoai, MaHang, Gia, SoLuong, MoTa, AnhBia, NgayCapNhat, CPU, RAM, OCung, ManHinh, VGA, HDH, SoLuotXem) 
                       VALUES (@ten, @loai, @hang, @gia, @soluong, @mota, @anh, GETDATE(), @cpu, @ram, @ocung, @manhinh, @vga, @hdh, 0)";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@ten", txtTenLaptop.Text.Trim());
                cmd.Parameters.AddWithValue("@loai", ddlLoai.SelectedValue);
                cmd.Parameters.AddWithValue("@hang", ddlHang.SelectedValue);
                cmd.Parameters.AddWithValue("@gia", decimal.Parse(txtGia.Text));
                cmd.Parameters.AddWithValue("@soluong", string.IsNullOrEmpty(txtSoLuong.Text) ? 0 : int.Parse(txtSoLuong.Text));
                cmd.Parameters.AddWithValue("@mota", txtMoTa.Text.Trim());
                cmd.Parameters.AddWithValue("@anh", tenFile);
                cmd.Parameters.AddWithValue("@cpu", txtCPU.Text.Trim());
                cmd.Parameters.AddWithValue("@ram", txtRAM.Text.Trim());
                cmd.Parameters.AddWithValue("@ocung", txtOCung.Text.Trim());
                cmd.Parameters.AddWithValue("@manhinh", txtManHinh.Text.Trim());
                // BỔ SUNG 2 THAM SỐ
                cmd.Parameters.AddWithValue("@vga", txtVGA.Text.Trim());
                cmd.Parameters.AddWithValue("@hdh", txtHDH.Text.Trim());

                con.Open();
                cmd.ExecuteNonQuery();

                string script = "alert('Thành công! Sản phẩm đã được thêm vào hệ thống.'); window.location='QuanLyLaptop.aspx';";
                ScriptManager.RegisterStartupScript(this, GetType(), "success", script, true);
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