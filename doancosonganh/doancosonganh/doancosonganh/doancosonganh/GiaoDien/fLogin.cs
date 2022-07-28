using DevExpress.XtraEditors;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using TieuLuanDevExpress.DAO;
using TieuLuanDevExpress.DTO;
using TieuLuanDevExpress.GiaoDien;

namespace TieuLuanDevExpress
{
    public partial class fLogin : DevExpress.XtraEditors.XtraForm
    {
        public fLogin()
        {
            InitializeComponent();
        }
        public static string taikhoan;
        #region Methods
        public static bool checkDangNhap = false;
        bool LogIn(string userName, string passWord)
        {
            return AccountDAO.Instance.Login(userName, passWord);
        }
        #endregion
        #region Events
        private void checkbtnHienthi_CheckedChanged(object sender, EventArgs e)
        {//Hiển thị mật khẩu
            if (checkbtnHienthi.Checked == true) txtMatkhau.UseSystemPasswordChar = false;
            else txtMatkhau.UseSystemPasswordChar = true;
        }
        private void btnDangnhap_Click(object sender, EventArgs e)
        {
            string userName = txtTendangnhap.Text;
            string password = txtMatkhau.Text;
            if (LogIn(userName, password))
            {
                //button Đăng nhập
                checkDangNhap = true;
                taikhoan = txtTendangnhap.Text;
                this.Close();
            }
            else
            {
                MessageBox.Show("Tài khoản hoặc Mật khẩu không chính xác", "Cảnh báo", MessageBoxButtons.OKCancel, MessageBoxIcon.Warning);
            }
        }
        private void btnThoat_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        #endregion
    }
}