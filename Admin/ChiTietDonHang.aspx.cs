using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LaptopZone_project.Admin
{
    public partial class ChiTietDonHang : System.Web.UI.Page
    {
        string strCon = ConfigurationManager.ConnectionStrings["LaptopStoreDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] == null)
            {
                Response.Redirect("QuanLyDonHang.aspx");
                return;
            }

            if (!IsPostBack)
            {
                int soDH = Convert.ToInt32(Request.QueryString["id"]);
                lblMaDH.Text = soDH.ToString();
                LoadThongTinDonHang(soDH);
                LoadGridChiTiet(soDH);
            }
        }

        private void LoadThongTinDonHang(int soDH)
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                string sql = @"SELECT k.HoTenKH, k.DienThoai, k.DiaChi, d.TriGia, d.DaGiao 
                       FROM DonDatHang d 
                       JOIN KhachHang k ON d.MaKH = k.MaKH 
                       WHERE d.SoDH = @id";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@id", soDH);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    lblTenKH.Text = dr["HoTenKH"].ToString();
                    lblSDT.Text = dr["DienThoai"].ToString();
                    lblDiaChi.Text = dr["DiaChi"].ToString();

                    // --- Xử lý tính toán tiền và VAT ---
                    decimal tongThanhToan = Convert.ToDecimal(dr["TriGia"]);

                    // Tính ngược: Tiền trước thuế = Tổng / 1.1
                    decimal tamTinh = tongThanhToan / 1.1m;
                    // Tiền thuế VAT = Tổng - Tiền trước thuế
                    decimal vat = tongThanhToan - tamTinh;

                    lblTamTinh.Text = tamTinh.ToString("N0");
                    lblVAT.Text = vat.ToString("N0"); // Gán giá trị VAT
                    lblTongTien.Text = tongThanhToan.ToString("N0");

                    // --- Xử lý trạng thái nút Xác nhận ---
                    bool trangThaiGiao = false;
                    if (dr["DaGiao"] != DBNull.Value)
                    {
                        trangThaiGiao = Convert.ToBoolean(dr["DaGiao"]);
                    }

                    if (trangThaiGiao)
                    {
                        btnXacNhan.Enabled = false;
                        btnXacNhan.Text = "Đơn hàng này đã giao";
                        btnXacNhan.CssClass += " opacity-50 cursor-not-allowed bg-gray-400 shadow-none hover:bg-gray-400";
                    }
                }
            }
        }

        private void LoadGridChiTiet(int soDH)
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                // Thêm l.AnhBia vào câu SELECT
                string sql = @"SELECT c.*, l.TenLaptop, l.AnhBia 
                       FROM CTDatHang c 
                       JOIN Laptop l ON c.MaLaptop = l.MaLaptop 
                       WHERE c.SoDH = @id";

                SqlDataAdapter da = new SqlDataAdapter(sql, con);
                da.SelectCommand.Parameters.AddWithValue("@id", soDH);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvChiTiet.DataSource = dt;
                gvChiTiet.DataBind();
            }
        }

        protected void btnXacNhan_Click(object sender, EventArgs e)
        {
            int soDH = Convert.ToInt32(lblMaDH.Text);
            using (SqlConnection con = new SqlConnection(strCon))
            {
                // Cập nhật trạng thái DaGiao và NgayGiao
                string sql = "UPDATE DonDatHang SET DaGiao = 1, NgayGiao = GETDATE() WHERE SoDH = @id";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@id", soDH);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            // Thông báo và load lại trang hoặc về danh sách
            ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Đã cập nhật trạng thái đơn hàng thành công!'); window.location='QuanLyDonHang.aspx';", true);
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