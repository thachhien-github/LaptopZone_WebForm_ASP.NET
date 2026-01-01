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
    public partial class QuanLyDonHang : System.Web.UI.Page
    {
        string strCon = ConfigurationManager.ConnectionStrings["LaptopStoreDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDonHang();
            }
        }

        private void LoadDonHang()
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                // Truy vấn cơ bản: Kết hợp bảng đơn hàng và khách hàng
                string sql = @"SELECT d.*, k.HoTenKH 
                             FROM DonDatHang d 
                             INNER JOIN KhachHang k ON d.MaKH = k.MaKH 
                             WHERE 1=1";

                // 1. Cập nhật logic tìm kiếm: Tìm theo Tên khách hàng HOẶC Mã đơn hàng
                if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
                {
                    // CAST(d.SoDH AS NVARCHAR) để có thể so sánh LIKE với số đơn hàng
                    sql += " AND (k.HoTenKH LIKE @search OR CAST(d.SoDH AS NVARCHAR) LIKE @search)";
                }

                // 2. Lọc theo trạng thái giao hàng
                if (ddlTrangThai.SelectedValue != "-1")
                    sql += " AND d.DaGiao = @trangthai";

                // 3. Lọc theo ngày đặt
                if (!string.IsNullOrEmpty(txtTuNgay.Text))
                    sql += " AND d.NgayDH >= @tungay";

                sql += " ORDER BY d.NgayDH DESC";

                SqlCommand cmd = new SqlCommand(sql, con);

                // Gán tham số an toàn
                if (sql.Contains("@search"))
                    cmd.Parameters.AddWithValue("@search", "%" + txtSearch.Text.Trim() + "%");

                if (sql.Contains("@trangthai"))
                    cmd.Parameters.AddWithValue("@trangthai", ddlTrangThai.SelectedValue);

                if (sql.Contains("@tungay"))
                    cmd.Parameters.AddWithValue("@tungay", txtTuNgay.Text);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvDonHang.DataSource = dt;
                gvDonHang.DataBind();
            }
        }

        protected void btnLoc_Click(object sender, EventArgs e)
        {
            LoadDonHang();
        }

        protected void gvDonHang_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvDonHang.PageIndex = e.NewPageIndex;
            LoadDonHang();
        }

        protected void gvDonHang_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteDH")
            {
                int soDH = Convert.ToInt32(e.CommandArgument);
                XoaDonHang(soDH);
                LoadDonHang();
            }
        }

        private void XoaDonHang(int soDH)
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                con.Open();
                SqlTransaction trans = con.BeginTransaction();
                try
                {
                    // Xóa chi tiết trước để tránh lỗi khóa ngoại
                    SqlCommand cmdCt = new SqlCommand("DELETE FROM CTDatHang WHERE SoDH = @id", con, trans);
                    cmdCt.Parameters.AddWithValue("@id", soDH);
                    cmdCt.ExecuteNonQuery();

                    // Xóa đơn hàng chính
                    SqlCommand cmdDh = new SqlCommand("DELETE FROM DonDatHang WHERE SoDH = @id", con, trans);
                    cmdDh.Parameters.AddWithValue("@id", soDH);
                    cmdDh.ExecuteNonQuery();

                    trans.Commit();
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Xóa đơn hàng thành công!');", true);
                }
                catch (Exception)
                {
                    trans.Rollback();
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Lỗi khi xóa đơn hàng!');", true);
                }
            }
        }

        [WebMethod(EnableSession = true)]
        public static object GetNewOrders()
        {
            List<object> notifications = new List<object>();
            string connStr = ConfigurationManager.ConnectionStrings["LaptopStoreDBConnectionString"]?.ConnectionString;

            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
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
                return notifications;
            }
            catch (Exception ex)
            {
                return new { error = ex.Message };
            }
        }
    }
}