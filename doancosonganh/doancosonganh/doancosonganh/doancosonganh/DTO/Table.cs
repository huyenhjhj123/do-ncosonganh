using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TieuLuanDevExpress.DTO
{
    public class Table
    {
        //Lưu thông tin thuộc tính của thằng Table
        private int iD;

        public int ID { get => iD; set => iD = value; }
        private string name;
        public string Name { get => name; set => name = value; }
        private string status;
        public string Status { get => status; set => status = value; }
        public Table(int id, string name, string status)
        {
            this.ID = iD;
            this.Name = name;
            this.Status = status;
        }
        
        public Table(DataRow row)
        {
            // Lấy ra Dòng của bảng dữ liệu
            this.ID = (int)row["id"];
            this.Name = row["name"].ToString();
            this.Status = row["status1"].ToString();
        }
    }
}
