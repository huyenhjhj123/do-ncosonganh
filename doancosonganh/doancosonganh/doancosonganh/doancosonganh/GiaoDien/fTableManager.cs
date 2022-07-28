using DevExpress.XtraEditors;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using TieuLuanDevExpress.DAO;
using TieuLuanDevExpress.DTO;
using ComboBox = System.Windows.Forms.ComboBox;
using Menu = TieuLuanDevExpress.DTO.Menu;
namespace TieuLuanDevExpress.GiaoDien
{
    public partial class fTableManager : DevExpress.XtraEditors.XtraForm
    {
        public fTableManager()
        {
            InitializeComponent();
            loadTalbe();
            loadCategory();
            loadComboboxTable(cbChuyenban);
        }
        #region Methods
        void loadCategory()
        {//Đưa dữ liệu vào Danh mục
            List<Category> listCategory = CategoryDAO.Instance.GetListCategory();
            cbDanhmuc.DataSource = listCategory;
            cbDanhmuc.DisplayMember = "Name";//Hiển thị theo từng thành phần của thuộc tính
        }
        void loadFoodListByCategoryID(int id)
        {//Đưa dữ liệu lên Lựa chọn
            List<Food> listFood = FoodDAO.Instance.GetFoodByCategoryID(id);
            cbLuachon.DataSource = listFood;
            cbLuachon.DisplayMember = "Name";//Hiển thị theo từng thành phần của thuộc tính
        }
        void loadComboboxTable(System.Windows.Forms.ComboBox cb)
        {
            cb.DataSource = TableDAO.Instance.LoadTableList();
            cb.DisplayMember = "Name";
        }
        void loadTalbe()
        {//load danh sách các bàn
            floBanan.Controls.Clear();
            
            List<Table> tableList = TableDAO.Instance.LoadTableList();
            foreach (Table item in tableList)
            {
                Button  btn = new Button() { Width = TableDAO.TableWidth, Height = TableDAO.TableHeight };
                btn.Text = item.Name + Environment.NewLine + " (Đang " + item.Status.ToString()+")";
                btn.Tag=item;//Dùng tag để có thể lấy dữ liệu từ table khi thao tác với event
                btn.Click += Btn_Click;//Tạo event cho btn bàn 
                switch (item.Status)
                {
                    case "Trống":
                        {
                            btn.ImageAlign = System.Drawing.ContentAlignment.TopCenter;
                            btn.ImageIndex = 0;
                            btn.ImageList = this.imageBanan;
                            btn.Size = new System.Drawing.Size(150, 100);
                            btn.TextAlign = System.Drawing.ContentAlignment.BottomCenter;
                            btn.UseVisualStyleBackColor = true;
                            break;
                        }
                    default:
                        {
                            btn.ImageAlign = System.Drawing.ContentAlignment.TopCenter;
                            btn.ImageIndex = 1;
                            btn.ImageList = this.imageBanan;
                            btn.Size = new System.Drawing.Size(150, 100);
                            btn.TextAlign = System.Drawing.ContentAlignment.BottomCenter;
                            btn.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
                            btn.ForeColor = System.Drawing.Color.White;
                            break;
                        }
                }
                floBanan.Controls.Add(btn);
            }
        }
        void ShowBill(int id)
        {
            lvDanhSachFood.Items.Clear();
            List<Menu> ListBillInfo = MenuDAO.Instance.GetListMenuByTable(id);
            float totalPrice = 0;
            foreach (Menu item in ListBillInfo)
            {
                //lên giao diện fTableManagerDesingn listview property: coloum; add 2 trường id food, count
                ListViewItem lsvItem = new ListViewItem(item.FoodName.ToString());
                lsvItem.SubItems.Add(item.Count.ToString());
                lsvItem.SubItems.Add(item.Price.ToString());
                lsvItem.SubItems.Add(item.TotalPrice.ToString());
                totalPrice += item.TotalPrice;
                lvDanhSachFood.Items.Add(lsvItem);
            }
            CultureInfo culture = new CultureInfo("vi-Vn");//en-US
            //Thread.CurrentThread.CurrentCulture = culture;Tạo ra một luồng mới để chỉnh sửa
            txtTong.Text = totalPrice.ToString("c", culture);
        }
        #endregion
        #region Events
        private void cbDanhmuc_SelectedIndexChanged(object sender, EventArgs e)
        {//load dữ liệu vào lực chọn
            int id = 0;
            ComboBox cb = sender as ComboBox;
            if (cb.SelectedItem == null) return;
            Category selected = cb.SelectedItem as Category;//giá trị của datacombobox truyền vào
            id = selected.ID;
            loadFoodListByCategoryID(id);
        }
        private void Btn_Click(object sender, EventArgs e)
        {//đầy button bàn1, bàn 2... event
            int tableID = ((sender as Button).Tag as Table).ID;//ép kiểu đối tượng thành kiểu table vì tag đã chuyển thành table
            btnCanhbao.Text = ((sender as Button).Tag as Table).Name.ToString();
            lvDanhSachFood.Tag = (sender as Button).Tag;//bắt đối tượng bàn1, bàn 2...
            ShowBill(tableID);
        }
        private void btnThemmon_Click(object sender, EventArgs e)
        {//Thêm món
            txtTong.Font = new System.Drawing.Font("Microsoft Sans Serif", 7.8F);
            Table table = lvDanhSachFood.Tag as Table;//Lấy ra cái table hiện tại, khi chạy event
            if (table == null)
            {
                MessageBox.Show("hãy chọn bàn");
                return;
            }
            int idBill = BillDAO.Instance.GetUncheckBillIDbyTableID(table.ID);
            int foodID = (cbLuachon.SelectedItem as Food).ID;
            int count = (int)nmrSoluong.Value;//lấy từ giá trị của numeriUpDown1 làm số lượng muốn thêm
            if (idBill == -1)
            {//Trường hợp Bill chưa tồn tại
                BillDAO.Instance.InsertBill(table.ID);
                BillInfoDAO.Instance.InsertBillInfo(BillDAO.Instance.GetMaxIDBill(), foodID, count);
            }
            else
            {
                BillInfoDAO.Instance.InsertBillInfo(idBill, foodID, count);
            }
            ShowBill(table.ID);
            loadTalbe();
            
            
        }
        private void btnThanhtoan_Click(object sender, EventArgs e)
        {//nút thanh toán
            Table table = lvDanhSachFood.Tag as Table;
            int idBill = BillDAO.Instance.GetUncheckBillIDbyTableID(table.ID);
            int discount = (int)numericUpDown2.Value;
            double totalPrice = Convert.ToDouble((txtTong.Text.Split(',')[0]).Replace(".", ""));
            double finaltotalPrice = totalPrice - (totalPrice / 100) * discount;
            if (idBill != -1)
            {
                if (MessageBox.Show(string.Format("Bạn có chắc muốn thanh toán hóa đơn cho bàn {0}\n" +
                    "Tổng tiền -  (Tổng tiền / 100) x Giảm giá \n=> {1} - ({1} / 100) x {2} = {3}đ"
                    , table.Name, totalPrice, discount, finaltotalPrice), "Thông báo",
                    MessageBoxButtons.OKCancel, MessageBoxIcon.Question) == System.Windows.Forms.DialogResult.OK)
                {
                    BillDAO.Instance.CheckOut(idBill, discount, (float)finaltotalPrice);
                    ShowBill(table.ID);
                    loadTalbe();
                }
            }
            txtTong.Font = new System.Drawing.Font("Microsoft Sans Serif", 7.8F);
        }
        private void btnChuyenban_Click(object sender, EventArgs e)
        {//Chuyển bàn
            int id1 = (lvDanhSachFood.Tag as Table).ID;
            int id2 = (cbChuyenban.SelectedItem as Table).ID;
            if (MessageBox.Show(string.Format("Bạn có thật sự muốn chuyển bàn {0} sang bàn {1}", (lvDanhSachFood.Tag as Table).Name,
                (cbChuyenban.SelectedItem as Table).Name), "Thông báo", MessageBoxButtons.OKCancel,
                MessageBoxIcon.Information) == System.Windows.Forms.DialogResult.OK)
            {
                TableDAO.Instance.SwitchTable(id1, id2);
                loadTalbe();
            }
        }
        #endregion
    }
}