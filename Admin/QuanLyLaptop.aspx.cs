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
    public partial class QuanLyLaptop : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["LaptopStoreDBConnectionString"]?.ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadFilterData();
                LoadLaptop();
            }
        }

        private void LoadFilterData()
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                try
                {
                    con.Open();
                    // Load Loại
                    SqlDataAdapter daLoai = new SqlDataAdapter("SELECT MaLoai, TenLoai FROM LoaiLaptop ORDER BY TenLoai", con);
                    DataTable dtLoai = new DataTable();
                    daLoai.Fill(dtLoai);
                    ddlLoai.DataSource = dtLoai;
                    ddlLoai.DataTextField = "TenLoai";
                    ddlLoai.DataValueField = "MaLoai";
                    ddlLoai.DataBind();
                    ddlLoai.Items.Insert(0, new ListItem("Tất cả loại", "0"));

                    // Load Hãng
                    SqlDataAdapter daHang = new SqlDataAdapter("SELECT MaHang, TenHang FROM HangSanXuat ORDER BY TenHang", con);
                    DataTable dtHang = new DataTable();
                    daHang.Fill(dtHang);
                    ddlHang.DataSource = dtHang;
                    ddlHang.DataTextField = "TenHang";
                    ddlHang.DataValueField = "MaHang";
                    ddlHang.DataBind();
                    ddlHang.Items.Insert(0, new ListItem("Tất cả hãng", "0"));
                }
                catch { }
            }
        }

        private void LoadLaptop()
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                // Câu lệnh SQL giữ nguyên l.* sẽ tự lấy thêm cột SoLuong
                string sql = @"SELECT l.*, loai.TenLoai, h.TenHang 
                       FROM Laptop l
                       LEFT JOIN LoaiLaptop loai ON l.MaLoai = loai.MaLoai
                       LEFT JOIN HangSanXuat h ON l.MaHang = h.MaHang
                       WHERE (l.TenLaptop LIKE @search OR l.CPU LIKE @search OR l.VGA LIKE @search)";

                if (ddlLoai.SelectedValue != "0") sql += " AND l.MaLoai = @maLoai";
                if (ddlHang.SelectedValue != "0") sql += " AND l.MaHang = @maHang";

                sql += " ORDER BY l.NgayCapNhat DESC";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@search", "%" + txtTimKiem.Text.Trim() + "%");
                cmd.Parameters.AddWithValue("@maLoai", ddlLoai.SelectedValue);
                cmd.Parameters.AddWithValue("@maHang", ddlHang.SelectedValue);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvLaptop.DataSource = dt;
                gvLaptop.DataBind();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e) => LoadLaptop();

        protected void gvLaptop_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int maLaptop = Convert.ToInt32(gvLaptop.DataKeys[e.RowIndex].Value);
            using (SqlConnection con = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM Laptop WHERE MaLaptop = @id", con);
                cmd.Parameters.AddWithValue("@id", maLaptop);
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    LoadLaptop();
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Xóa sản phẩm thành công!');", true);
                }
                catch (SqlException ex)
                {
                    if (ex.Number == 547) // Lỗi vi phạm khóa ngoại (Foreign Key Constraint)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                            "alert('Không thể xóa sản phẩm này vì đã có trong đơn hàng của khách!');", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                            "alert('Đã xảy ra lỗi hệ thống khi xóa!');", true);
                    }
                }
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

        protected void gvLaptop_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            // Gán chỉ số trang mới
            gvLaptop.PageIndex = e.NewPageIndex;

            // Gọi lại hàm load dữ liệu (tên hàm tùy thuộc vào code của bạn, thường là BindGrid hoặc LoadLaptop)
            // Ví dụ:
            LoadLaptop();
        }
    }
}