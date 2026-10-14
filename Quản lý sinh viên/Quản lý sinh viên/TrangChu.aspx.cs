using System;
using System.Data.SqlClient;

namespace Quản_lý_sinh_viên
{
    public partial class TrangChu : System.Web.UI.Page
    {
        string connStr = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=QuanlySV;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblNgay.Text = DateTime.Now.ToString("dd/MM/yyyy");
                lblTongSV.Text = DemBanGhi("Sinhvien").ToString();
                lblTongLop.Text = DemBanGhi("Lop").ToString();
            }
        }

        int DemBanGhi(string tenBang)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM " + tenBang, conn);
                return (int)cmd.ExecuteScalar();
            }
        }
    }
}