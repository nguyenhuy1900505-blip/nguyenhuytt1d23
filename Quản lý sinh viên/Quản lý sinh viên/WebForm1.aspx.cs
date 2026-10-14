using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Quản_lý_sinh_viên
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        string connStr = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=QuanlySV;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadLop();
                LoadSinhVien();
            }
        }

        // ===== Load danh sách lớp =====
        void LoadLop()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT MaLop, TenLop FROM Lop", conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlLop.DataSource = dt;
                ddlLop.DataTextField = "TenLop";
                ddlLop.DataValueField = "MaLop";
                ddlLop.DataBind();
                ddlLop.Items.Insert(0, new ListItem("-- Tất cả lớp học --", ""));

                ddlLopForm.DataSource = dt;
                ddlLopForm.DataTextField = "TenLop";
                ddlLopForm.DataValueField = "MaLop";
                ddlLopForm.DataBind();
            }
        }

        // ===== Load & Lọc sinh viên =====
        void LoadSinhVien(string keyword = "", string maLop = "")
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = @"SELECT sv.MaSV, sv.HotenSV, sv.ngaysinh, sv.SDT, sv.Anh, 
                                      l.TenLop
                               FROM Sinhvien sv
                               LEFT JOIN Lop l ON sv.MaLop = l.MaLop
                               WHERE 1=1";

                if (!string.IsNullOrEmpty(keyword))
                    sql += " AND (sv.MaSV LIKE @kw OR sv.HotenSV LIKE @kw)";
                if (!string.IsNullOrEmpty(maLop))
                    sql += " AND sv.MaLop = @maLop";

                SqlCommand cmd = new SqlCommand(sql, conn);
                if (!string.IsNullOrEmpty(keyword))
                    cmd.Parameters.AddWithValue("@kw", "%" + keyword + "%");
                if (!string.IsNullOrEmpty(maLop))
                    cmd.Parameters.AddWithValue("@maLop", maLop);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvSinhVien.DataSource = dt;
                gvSinhVien.DataBind();
            }
        }

        // Nút Lọc
        protected void btnLoc_Click(object sender, EventArgs e)
        {
            LoadSinhVien(txtSearch.Text.Trim(), ddlLop.SelectedValue);
        }

        // Nút Thêm
        protected void btnThem_Click(object sender, EventArgs e)
        {
            hfMaSV.Value = "";
            hfAnhCu.Value = "";
            txtMaSV.Text = txtHoten.Text = txtNgaySinh.Text = txtSDT.Text = "";
            lblAnhCu.Text = "";
            txtMaSV.Enabled = true;
            ScriptManager.RegisterStartupScript(this, GetType(), "show", "openModal(false);", true);
        }

        // Xử lý Sửa / Xóa
        protected void gvSinhVien_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string maSV = e.CommandArgument.ToString();

            if (e.CommandName == "Xoa")
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("DELETE FROM Sinhvien WHERE MaSV = @ma", conn);
                    cmd.Parameters.AddWithValue("@ma", maSV);
                    cmd.ExecuteNonQuery();
                }
                LoadSinhVien(txtSearch.Text.Trim(), ddlLop.SelectedValue);
            }
            else if (e.CommandName == "Sua")
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT * FROM Sinhvien WHERE MaSV = @ma", conn);
                    cmd.Parameters.AddWithValue("@ma", maSV);
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        hfMaSV.Value = maSV;
                        txtMaSV.Text = maSV;
                        txtMaSV.Enabled = false;
                        txtHoten.Text = dr["HotenSV"].ToString();
                        txtNgaySinh.Text = Convert.ToDateTime(dr["ngaysinh"]).ToString("yyyy-MM-dd");
                        txtSDT.Text = dr["SDT"].ToString();
                        ddlLopForm.SelectedValue = dr["MaLop"].ToString();

                        // Lưu tên ảnh cũ
                        string anhCu = dr["Anh"].ToString();
                        hfAnhCu.Value = anhCu;
                        lblAnhCu.Text = string.IsNullOrEmpty(anhCu) ? "" : "Ảnh hiện tại: " + anhCu;
                    }
                }
                ScriptManager.RegisterStartupScript(this, GetType(), "show", "openModal(true);", true);
            }
        }

        // Nút Lưu (Thêm hoặc Sửa) - Có Upload ảnh
        protected void btnLuu_Click(object sender, EventArgs e)
        {
            string tenAnh = hfAnhCu.Value; // Mặc định giữ ảnh cũ

            // Nếu người dùng chọn ảnh mới thì Upload
            if (fuAnh.HasFile)
            {
                // Tạo tên file mới để tránh trùng
                string extension = Path.GetExtension(fuAnh.FileName).ToLower();
                tenAnh = Guid.NewGuid().ToString() + extension;

                // Đường dẫn lưu vào thư mục images
                string path = Server.MapPath("~/images/" + tenAnh);
                fuAnh.SaveAs(path);
            }

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlCommand cmd;

                if (string.IsNullOrEmpty(hfMaSV.Value)) // Thêm mới
                {
                    cmd = new SqlCommand(
                        @"INSERT INTO Sinhvien (MaSV, HotenSV, ngaysinh, SDT, Anh, MaLop)
                          VALUES (@ma, @ten, @ns, @sdt, @anh, @lop)", conn);
                }
                else // Sửa
                {
                    cmd = new SqlCommand(
                        @"UPDATE Sinhvien SET HotenSV=@ten, ngaysinh=@ns, SDT=@sdt, Anh=@anh, MaLop=@lop
                          WHERE MaSV=@ma", conn);
                }

                cmd.Parameters.AddWithValue("@ma", txtMaSV.Text.Trim());
                cmd.Parameters.AddWithValue("@ten", txtHoten.Text.Trim());
                cmd.Parameters.AddWithValue("@ns", txtNgaySinh.Text);
                cmd.Parameters.AddWithValue("@sdt", txtSDT.Text.Trim());
                cmd.Parameters.AddWithValue("@anh", tenAnh ?? "");
                cmd.Parameters.AddWithValue("@lop", ddlLopForm.SelectedValue);
                cmd.ExecuteNonQuery();
            }

            LoadSinhVien(txtSearch.Text.Trim(), ddlLop.SelectedValue);
            ScriptManager.RegisterStartupScript(this, GetType(), "hide", "closeModal();", true);
        }

        // Phân trang
        protected void gvSinhVien_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvSinhVien.PageIndex = e.NewPageIndex;
            LoadSinhVien(txtSearch.Text.Trim(), ddlLop.SelectedValue);
        }
    }
}