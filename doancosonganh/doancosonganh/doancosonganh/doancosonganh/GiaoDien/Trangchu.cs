using DevExpress.XtraBars;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using TieuLuanDevExpress.GiaoDien;

namespace TieuLuanDevExpress
{
    public partial class Trangchu : DevExpress.XtraBars.Ribbon.RibbonForm
    {
        public Trangchu()
        {
            InitializeComponent();
        }
        #region Methods
        public void skins()
        {
            DevExpress.LookAndFeel.DefaultLookAndFeel themes = new DevExpress.LookAndFeel.DefaultLookAndFeel();
            themes.LookAndFeel.SkinName = "McSkin";//tên giao diện
        }
        void OpenForm(Type typeForm)
        {//kiểm tra xem form đã hoạt động chưa
            foreach (Form frm in MdiChildren)
            {
                if (frm.GetType() == typeForm)
                {
                    frm.Activate();
                    return;
                }
            }
            Form f = (Form)Activator.CreateInstance(typeForm);
            f.MdiParent = this;
            f.Show();
        }
        #endregion
        #region Events
        private void btnDangnhap_ItemClick(object sender, ItemClickEventArgs e)
        {//nút đăng nhập 
            fLogin f = new fLogin();
            f.ShowDialog();
            if (fLogin.checkDangNhap)
            {
                btnThongtintaikhoan.Enabled = true;
                btnAdmin.Enabled = true;
                btnDangnhap.Caption = "Đăng xuất";
                OpenForm(typeof(fTableManager));
            }
        }
        private void btnAdmin_ItemClick(object sender, ItemClickEventArgs e)
        {
            if (fLogin.checkDangNhap)
            {
                OpenForm(typeof(fAdmin));
                
            }
        }

        private void btnThongtintaikhoan_ItemClick(object sender, ItemClickEventArgs e)
        {
            fLoginCanhan f = new fLoginCanhan();
            f.ShowDialog();
        }

        private void Trangchu_Load(object sender, EventArgs e)
        {
            skins();
        }
        private void tsGiaoDien_Toggled(object sender, EventArgs e)
        {
            if (tsGiaoDien.IsOn == true)
            {
                DevExpress.LookAndFeel.DefaultLookAndFeel themes = new DevExpress.LookAndFeel.DefaultLookAndFeel();
                themes.LookAndFeel.SkinName = "Dark Side";//tên giao diện
            }
            else skins();
        }
        #endregion
    }
}