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

namespace TieuLuanDevExpress.GiaoDien
{
    public partial class fLoginCanhan : DevExpress.XtraEditors.XtraForm
    {
        public fLoginCanhan()
        {
            InitializeComponent();
        }
        #region Methods
        void updateAccount()
        {
            string displayName = txtTenHT.Text;
            string password = txtMatkhau.Text;
            string newpass = txtMatkhaumoi.Text;
            string reenterpass = txtMknhaplai.Text;
            string userName = txtTendangnhap.Text;
            if (!newpass.Equals(reenterpass))
            {
                MessageBox.Show("Mật khẩu mới không trùng khớp!", "Cảnh báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
            else
            {
                if (AccountDAO.Instance.updateAccount(userName, displayName, password, newpass))
                {
                    txtTenHT.Text = displayName;
                    MessageBox.Show("Cập nhật thông tin thành công!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else
                {
                    MessageBox.Show("Mật khẩu hoặc tài khoản không chính xác", "Cảnh báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }
            }
        }
        #endregion
        #region Events
        private void btnCapnhat_Click(object sender, EventArgs e)
        {
            updateAccount();
        }
        private void btnThoat1_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        #endregion
    }
}