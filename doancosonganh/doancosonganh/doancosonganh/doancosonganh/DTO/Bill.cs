using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TieuLuanDevExpress.DTO
{
    public class Bill
    {
        public Bill(int id, DateTime? dataCheckInt, DateTime? dataCheckOut, int status1, int discount = 0)
        {
            this.ID = id;
            this.DataCheckInt = dataCheckInt;
            this.DataCheckOut = dataCheckOut;
            this.Status1 = status1;
            this.Discount = discount;
        }
        public Bill(DataRow row)
        {
            this.ID = (int)row["id"];
            this.DataCheckInt = (DateTime?)row["DateCheckIn"];
            var dataCheckOutTemp = row["DateCheckOut"];
            if (dataCheckOutTemp.ToString() != "")
                this.DataCheckOut = (DateTime?)dataCheckOutTemp;
            this.Status1 = (int)row["status1"];
            if (row["discount"].ToString() != "")
                this.Discount = (int)row["discount"];
        }
        private int status1;
        private int iD;
        private int discount;
        public int ID { get => iD; set => iD = value; }
        private DateTime? dataCheckInt;
        public DateTime? DataCheckInt { get => dataCheckInt; set => dataCheckInt = value; }
        private DateTime? dataCheckOut;
        public DateTime? DataCheckOut { get => dataCheckOut; set => dataCheckOut = value; }
        public int Status1 { get => status1; set => status1 = value; }
        public int Discount { get => discount; set => discount = value; }
    }
}
