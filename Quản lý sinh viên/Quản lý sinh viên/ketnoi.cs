using System;
using System.Data;
using System.Data.SqlClient;

namespace Quản_lý_sinh_viên
{
    public class ketnoi
    {
        // Chuỗi kết nối
        private static string connStr = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=QuanlySV;Integrated Security=True";

        // Mở kết nối
        public static SqlConnection GetConnection()
        {
            SqlConnection conn = new SqlConnection(connStr);
            return conn;
        }

        // Thực thi câu lệnh không trả về dữ liệu (INSERT, UPDATE, DELETE)
        public static int ExecuteNonQuery(string sql, params SqlParameter[] parameters)
        {
            using (SqlConnection conn = GetConnection())
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    if (parameters != null)
                        cmd.Parameters.AddRange(parameters);

                    return cmd.ExecuteNonQuery();
                }
            }
        }

        // Thực thi câu lệnh trả về 1 giá trị (COUNT, MAX, ...)
        public static object ExecuteScalar(string sql, params SqlParameter[] parameters)
        {
            using (SqlConnection conn = GetConnection())
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    if (parameters != null)
                        cmd.Parameters.AddRange(parameters);

                    return cmd.ExecuteScalar();
                }
            }
        }

        // Lấy dữ liệu trả về DataTable
        public static DataTable GetData(string sql, params SqlParameter[] parameters)
        {
            using (SqlConnection conn = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    if (parameters != null)
                        cmd.Parameters.AddRange(parameters);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    return dt;
                }
            }
        }

        // Lấy dữ liệu trả về DataSet
        public static DataSet GetDataSet(string sql, params SqlParameter[] parameters)
        {
            using (SqlConnection conn = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    if (parameters != null)
                        cmd.Parameters.AddRange(parameters);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    da.Fill(ds);
                    return ds;
                }
            }
        }
    }
}