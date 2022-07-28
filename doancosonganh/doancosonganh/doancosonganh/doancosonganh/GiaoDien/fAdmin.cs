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
using ComboBox = System.Windows.Forms.ComboBox;

namespace TieuLuanDevExpress.GiaoDien
{
    public partial class fAdmin : DevExpress.XtraEditors.XtraForm
    {
        BindingSource foodList = new BindingSource();
        BindingSource accountList = new BindingSource();
        public Account LoginAccount;
        public fAdmin()
        {
            InitializeComponent();
            Load1();
        }
        void Load1()
        {
            dtgvFood.DataSource = foodList;
            dtgvAccount.DataSource = accountList;
            LoadDatetimePickerBill();
            loadListBillByDate(dtpFromdate.Value, dtpToDate.Value);
            LoadListFood();
            AddFoodBiding();
            LoadCategoryIntoCombobox(cbDanhmuc);
            AddaccountBinding();
            LoadAccount();
        }
        void LoadAccount()
        {
            accountList.DataSource = AccountDAO.Instance.GetListAccount();
        }
        void AddaccountBinding()
        {
            txtTentaikhoan.DataBindings.Add(new Binding("Text", dtgvAccount.DataSource, "UserName", true, DataSourceUpdateMode.Never));
            txtHienthi.DataBindings.Add(new Binding("Text", dtgvAccount.DataSource, "DisplayName", true, DataSourceUpdateMode.Never));
            txtLoaitk.DataBindings.Add(new Binding("Value", dtgvAccount.DataSource, "type1", true, DataSourceUpdateMode.Never));
        }
        void LoadCategoryIntoCombobox(ComboBox cb)
        {
            cb.DataSource = CategoryDAO.Instance.GetListCategory();
            cb.DisplayMember = "Name";
        }
        void LoadListFood()
        {
            foodList.DataSource = FoodDAO.Instance.GetListFood();
        }
        void AddFoodBiding()
        {
            txtTenmon.DataBindings.Add(new Binding("Text", dtgvFood.DataSource, "name", true, DataSourceUpdateMode.Never));//liên kết dữ liệu với nhau
            txtFoodid.DataBindings.Add(new Binding("Text", dtgvFood.DataSource, "id", true, DataSourceUpdateMode.Never));
            nmrPrice.DataBindings.Add(new Binding("Value", dtgvFood.DataSource, "Price", true, DataSourceUpdateMode.Never));
        }
        void loadListBillByDate(DateTime checkIn, DateTime checkOut)
        {
            dtvBill.DataSource = BillDAO.Instance.GetBillListByDate(checkIn, checkOut);
        }
        void LoadDatetimePickerBill()
        {//reset ngày bắt dầu: đầu tháng, ngày kết thúc cuối tháng
            DateTime today = DateTime.Now;
            dtpFromdate.Value = new DateTime(today.Year, today.Month, 1);
            dtpToDate.Value = dtpFromdate.Value.AddMonths(1).AddDays(-1);
        }
        List<Food> SearchFoodByName(string name)
        {//thao tác tìm kiếm
            List<Food> listFood = FoodDAO.Instance.SearchFoodByName(name);
            return listFood;
        }
        private void btnThongke_Click(object sender, EventArgs e)
        {
            loadListBillByDate(dtpFromdate.Value, dtpToDate.Value);
        }
        private void btnTimfood_Click(object sender, EventArgs e)
        {
            foodList.DataSource = SearchFoodByName(txtTimkiem.Text);
        }

        private void btnXemFood_Click(object sender, EventArgs e)
        {
            LoadListFood();
        }

        private void txtFoodid_TextChanged(object sender, EventArgs e)
        {//lấy idFood
            try
            {
                if (dtgvFood.SelectedCells.Count > 0)
                {
                    int id = (int)dtgvFood.SelectedCells[0].OwningRow.Cells["CategoryId"].Value;
                    Category category = CategoryDAO.Instance.GetCategoryByID(id);
                    cbDanhmuc.SelectedItem = category;
                    int index = -1;
                    int i = 0;
                    foreach (Category item in cbDanhmuc.Items)
                    {
                        if (item.ID == category.ID)
                        {
                            index = i;
                            break;
                        }
                        i++;
                    }
                    cbDanhmuc.SelectedIndex = index;
                }
            }
            catch
            {

            }
        }
        private void btnAddFood_Click(object sender, EventArgs e)
        {//thêm món
            string name = txtTenmon.Text;
            int categoryID = (int)(cbDanhmuc.SelectedItem as Category).ID;
            float price = (float)nmrPrice.Value;
            if (FoodDAO.Instance.InsertFood(name, categoryID, price))
            {
                MessageBox.Show("Thêm món thành công!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                LoadListFood();//load lại danh sách
                if (insertFood != null)
                    insertFood(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Thêm món Thất bại!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private event EventHandler insertFood;
        public event EventHandler InsertFood
        {
            add { insertFood += value; }
            remove { insertFood -= value; }
        }
        private event EventHandler deleteFood;
        public event EventHandler DeletetFood
        {
            add { deleteFood += value; }
            remove { deleteFood -= value; }
        }
        private event EventHandler updateFood;
        public event EventHandler UpdateFood
        {
            add { updateFood += value; }
            remove { updateFood -= value; }
        }

        private void btnSua_Click(object sender, EventArgs e)
        {//sửa món ăn 
            string name = txtTenmon.Text;
            int categoryID = (int)(cbDanhmuc.SelectedItem as Category).ID;
            float price = (float)nmrPrice.Value;
            int id = Convert.ToInt32(txtFoodid.Text);
            if (FoodDAO.Instance.UpdateFood(id, name, categoryID, price))
            {
                MessageBox.Show("Sửa món thành công!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                LoadListFood();//load lại danh sách
                if (updateFood != null)
                    updateFood(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Sửa món Thất bại!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void btnXoa_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(txtFoodid.Text);
            if (FoodDAO.Instance.DeleteFood(id))
            {
                MessageBox.Show("Xóa món thành công!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                LoadListFood();//load lại danh sách
                if (deleteFood != null)
                    deleteFood(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Xóa món Thất bại!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void btnXemAcc_Click(object sender, EventArgs e)
        {
            LoadAccount();
        }
        void ResetPass(string userName)
        {
            if (AccountDAO.Instance.ResetPassWord(userName))
            {
                MessageBox.Show("Reset tài khoản thành công");
            }
            else
            {
                MessageBox.Show("Reset tài khoản thất bại!");
            }
        }
        void AddAccount(string userName, string displayName, int type)
        {
            if (AccountDAO.Instance.InsertAccount(userName, displayName, type))
            {
                MessageBox.Show("Thêm tài khoản thành công");
            }
            else
            {
                MessageBox.Show("Thêm tài khoản thất bại!");
            }
            LoadAccount();
        }
        void EditAccount(string userName, string displayName, int type)
        {
            if (AccountDAO.Instance.UpdateAccount(userName, displayName, type))
            {
                MessageBox.Show("Cập nhật tài khoản thành công");
            }
            else
            {
                MessageBox.Show("Cập nhật tài khoản thất bại!");
            }
            LoadAccount();
        }
        void deleteAccount(string userName)
        {
            if (fLogin.taikhoan.Equals(userName))
            {
                MessageBox.Show("Tài khoản đang đăng nhập!");
                return;
            }
            else
            {
                if (AccountDAO.Instance.DeleteAccount(userName))
                {
                    MessageBox.Show("Xóa tài khoản thành công");
                }
                else
                {
                    MessageBox.Show("Xóa tài khoản thất bại!");
                }
                LoadAccount();
            }

        }

        private void btnThemAcc_Click(object sender, EventArgs e)
        {
            string userName = txtTentaikhoan.Text;
            string displayName = txtHienthi.Text;
            int type = (int)txtLoaitk.Value;
            AddAccount(userName, displayName, type);
        }

        private void btnXoaAcc_Click(object sender, EventArgs e)
        {
            string userName = txtTentaikhoan.Text;
            deleteAccount(userName);
        }

        private void btnSuaAcc_Click(object sender, EventArgs e)
        {
            string userName = txtTentaikhoan.Text;
            string displayName = txtHienthi.Text;
            int type = (int)txtLoaitk.Value;
            EditAccount(userName, displayName, type);
        }

        private void tbResetMK_Click(object sender, EventArgs e)
        {
            string userName = txtTentaikhoan.Text;
            ResetPass(userName);
        }
    }
}