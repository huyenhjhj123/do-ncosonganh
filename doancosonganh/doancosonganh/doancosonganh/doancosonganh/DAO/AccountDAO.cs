using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using TieuLuanDevExpress.DTO;

namespace TieuLuanDevExpress.DAO
{
    public class AccountDAO
    {
        //Cấu hình của một thằng Singleton
        private static AccountDAO instance;
        public static AccountDAO Instance
        {
            get { if (instance == null) instance = new AccountDAO(); return instance; }
            set => instance = value;
        }
        private AccountDAO() { }
        public bool Login(string userName, string password)
        {
            string query = @"USP_Login @userName , @passWord";//Thêm exec trong câu lệnh cùng đc tùy thích
            //có một lỗi bảo mật khá lớn khi người dùng nhập password= " 'or 1=1--"; giá trị sẽ đúng => không có đk lỗi bảo mật
            //Có thể thay like = "=" như câu truy vấn thông thường
            //int result = DataProvider.Instance.ExtecuteNonQuery(query);thằng ExtecuteNonQuery này không trả về giá trị int
            //nó chỉ trả về khi delete update, insert
            DataTable result = DataProvider.Instance.ExtecuteQuery(query, new object[] { userName, password });
            return result.Rows.Count > 0;//số hàng trả ra phải lớn hơn không thì mật khẩu mới đúng
        }
        public bool updateAccount(string userName, string displayName, string pass, string newpass)
        {
            int result = DataProvider.Instance.ExtecuteNonQuery("exec USP_UpdateAccount @userName , @displayName , @password , @newPassword", new object[] { userName, displayName, pass, newpass });
            return result > 0;//dùng excutenonQuery khi nó thực hiện câu lệnh update
        }
        public Account GetAccountByUserName(string userName)
        {
            DataTable data = DataProvider.Instance.ExtecuteQuery("select * from dbo.Account where UserName= N'" + userName + "'");
            foreach (DataRow item in data.Rows)
            {
                return new Account(item);
            }
            return null;
        }
        public DataTable GetListAccount()
        {
            return DataProvider.Instance.ExtecuteQuery("select UserName,DisplayName,Type1 from dbo.Account");
        }
        public bool InsertAccount(string name, string displayName, int type)
        {
            string query = string.Format("insert dbo.Account (UserName,DisplayName,Type1) values(N'{0}',N'{1}',{2})", name, displayName, type);
            int result = DataProvider.Instance.ExtecuteNonQuery(query);
            return result > 0;
        }
        public bool UpdateAccount(string name, string displayName, int type)
        {
            string query = string.Format("update dbo.Account set DisplayName=N'{1}', Type1= {2} where UserName=N'{0}'", name, displayName, type);
            int result = DataProvider.Instance.ExtecuteNonQuery(query);
            return result > 0;
        }
        public bool DeleteAccount(string name)
        {
            string query = string.Format("delete dbo.Account where UserName='{0}'", name);
            int result = DataProvider.Instance.ExtecuteNonQuery(query);
            return result > 0;
        }
        public bool ResetPassWord(string name)
        {
            string query = string.Format("update Dbo.Account set password1 =N'0' where UserName=N'{0}'", name);
            int result = DataProvider.Instance.ExtecuteNonQuery(query);
            return result > 0;
        }
    }
}
