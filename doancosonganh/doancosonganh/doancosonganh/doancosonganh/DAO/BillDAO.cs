using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TieuLuanDevExpress.DTO;

namespace TieuLuanDevExpress.DAO
{
    public class BillDAO
    {
        private static BillDAO instance;

        public static BillDAO Instance
        {
            get { if (instance == null) instance = new BillDAO(); return BillDAO.instance; }
            private set => instance = value;
        }
        private BillDAO() { }
        /// <summary>
        /// Thành công trả về bill.ID
        /// thất bại return -1
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public int GetUncheckBillIDbyTableID(int id)
        {
            DataTable data = DataProvider.Instance.ExtecuteQuery("select * from dbo.Bill where idTable = " + id + " and status1 = 0");
            if (data.Rows.Count > 0)
            {
                Bill bill = new Bill(data.Rows[0]);
                return bill.ID;
            }
            return -1;
        }
        public void CheckOut(int id, int discount, float totalPrice)
        {
            string query = "update dbo.Bill set DateCheckOut=GETDATE(), status1 = 1, discount=" + discount + ", totalPrice=" + totalPrice + " where id = " + id;
            DataProvider.Instance.ExtecuteNonQuery(query);
        }
        public DataTable GetBillListByDate(DateTime checkIn, DateTime checkOut)
        {
            return DataProvider.Instance.ExtecuteQuery("exec USP_GetListBillByDate @checkIn , @checkOut", new object[] { checkIn, checkOut });
        }
        public void InsertBill(int id)
        {
            DataProvider.Instance.ExtecuteNonQuery("exec USP_InsertBill @idTable", new object[] { id });
        }
        public int GetMaxIDBill()
        {
            try
            {
                return (int)DataProvider.Instance.ExtecuteScalar("select Max(id) from dbo.Bill");
            }
            catch
            {
                return 1;
            }
        }
    }
}
