using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TieuLuanDevExpress.DAO
{
    class DataProvider
    {
        private static DataProvider instance;//Thẳng này chỉ đc khởi tảo một lần, tránh kết nối nhiều gây lỗi, khó kiểm soát
        private string connectionSTR = @"Data Source=MSI\SQLEXPRESS01;Initial Catalog=QuanLyQuanCafe;Integrated Security=True";

        public static DataProvider Instance
        {
            get { if (instance == null) instance = new DataProvider(); return DataProvider.instance; }
            private set => instance = value;
        }
        private DataProvider() { }
        public DataTable ExtecuteQuery(string query, object[] parameters = null)//parameter =null có thể ko cần parameters;
        {
            DataTable data = new DataTable();//Tạo ra một dataTable để đổ dữ liệu vào
            using (SqlConnection connection = new SqlConnection(connectionSTR))
            {
                //Tạo ra lớp trung gian, để kết nối từ lian xuống sever
                connection.Open();//phải mở connection mới xài được
                SqlCommand command = new SqlCommand(query, connection);//Câu lệnh này sẽ thực thi câu query trên kết nối này
                if (parameters != null)
                {
                    //add n parameters
                    int i = 0;
                    string[] listPara = query.Split(' ');
                    foreach (string item in listPara)
                    {
                        if (item.Contains('@'))
                        {
                            command.Parameters.AddWithValue(item, parameters[i]);
                            i++;
                        }
                    }
                }
                //command.Parameters.AddWithValue("@userName", id);//thay đổi parameters truyền vào 
                SqlDataAdapter adapter = new SqlDataAdapter(command);//Thằng trung gian thực hiện câu truy vấn giúp lấy dữ liệu ra
                adapter.Fill(data);//Đổ dữ liệu lấy ra vào data
                connection.Close();//đóng lại
            }//Khi sử dụng use, khối lệnh bên trong khi thực thi xong sẽ tự động giải phóng để tránh gặp lỗi    
            return data;
        }
        public int ExtecuteNonQuery(string query, object[] parameters = null)//hàm này trả ra số dòng thành công, ko load dữ liệu lên
        {
            int data = 0;
            using (SqlConnection connection = new SqlConnection(connectionSTR))
            {
                //Tạo ra lớp trung gian, để kết nối từ lian xuống sever
                connection.Open();//phải mở connection mới xài được
                SqlCommand command = new SqlCommand(query, connection);//Câu lệnh này sẽ thực thi câu query trên kết nối này
                if (parameters != null)
                {
                    //add n parameters
                    int i = 0;
                    string[] listPara = query.Split(' ');
                    foreach (string item in listPara)
                    {
                        if (item.Contains('@'))
                        {
                            command.Parameters.AddWithValue(item, parameters[i]);
                            i++;
                        }
                    }
                }
                data = command.ExecuteNonQuery();
                connection.Close();//đóng lại
            }//Khi sử dụng use, khối lệnh bên trong khi thực thi xong sẽ tự động giải phóng để tránh gặp lỗi    
            return data;
        }
        public object ExtecuteScalar(string query, object[] parameters = null)//hàm này trả về dòng đầu tiên
        {
            object data = 0;
            using (SqlConnection connection = new SqlConnection(connectionSTR))
            {
                //Tạo ra lớp trung gian, để kết nối từ lian xuống sever
                connection.Open();//phải mở connection mới xài được
                SqlCommand command = new SqlCommand(query, connection);//Câu lệnh này sẽ thực thi câu query trên kết nối này
                if (parameters != null)
                {
                    //add n parameters
                    int i = 0;
                    string[] listPara = query.Split(' ');
                    foreach (string item in listPara)
                    {
                        if (item.Contains('@'))
                        {
                            command.Parameters.AddWithValue(item, parameters[i]);
                            i++;
                        }
                    }
                }
                data = command.ExecuteScalar();
                connection.Close();//đóng lại
            }//Khi sử dụng use, khối lệnh bên trong khi thực thi xong sẽ tự động giải phóng để tránh gặp lỗi    
            return data;
        }
    }
}
