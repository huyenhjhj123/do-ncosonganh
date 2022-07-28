﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TieuLuanDevExpress.DTO;

namespace TieuLuanDevExpress.DAO
{
    public class TableDAO
    {
        private static TableDAO instance;
        public static int TableWidth = 100;
        public static int TableHeight = 80;
        public static TableDAO Instance
        {
            get { if (instance == null) instance = new TableDAO(); return TableDAO.instance; }
            private set => instance = value;
        }
        TableDAO() { }
        public void SwitchTable(int id1, int id2)
        {
            DataProvider.Instance.ExtecuteQuery("USP_SwitchTable @idTable1 , @idTable2", new object[] { id1, id2 });
        }
        public List<Table> LoadTableList()
        {
            List<Table> tableList = new List<Table>();
            DataTable data = DataProvider.Instance.ExtecuteQuery("USP_GetTableList");
            foreach (DataRow item in data.Rows)
            {
                Table table = new Table(item);
                tableList.Add(table);
            }
            return tableList;
        }
    }
}
