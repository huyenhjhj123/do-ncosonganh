using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TieuLuanDevExpress.DTO;

namespace TieuLuanDevExpress.DAO
{
    public class FoodDAO
    {
        private static FoodDAO instance;

        public static FoodDAO Instance
        {
            get { if (instance == null) instance = new FoodDAO(); return FoodDAO.instance; }
            set => instance = value;
        }
        private FoodDAO() { }
        public List<Food> GetFoodByCategoryID(int id)
        {
            List<Food> list = new List<Food>();
            string query = "select * from dbo.Food Where idCategory=" + id;
            DataTable data = DataProvider.Instance.ExtecuteQuery(query);
            foreach (DataRow item in data.Rows)
            {
                Food food = new Food(item);
                list.Add(food);
            }
            return list;
        }
        public List<Food> GetListFood()
        {
            List<Food> list = new List<Food>();
            string query = "select * from dbo.Food ";
            DataTable data = DataProvider.Instance.ExtecuteQuery(query);
            foreach (DataRow item in data.Rows)
            {
                Food food = new Food(item);
                list.Add(food);
            }
            return list;
        }
        public bool InsertFood(string name, int id, float price)
        {
            //extecuteQuery là trả về giá trị dataTalbe, nếu insert, update thì dùng extecuteNonQuery
            string query = string.Format("insert dbo.Food (name1,idCategory,price) values(N'{0}',{1},{2})", name, id, price);
            int result = DataProvider.Instance.ExtecuteNonQuery(query);
            return result > 0;
        }
        public bool UpdateFood(int idFood, string name, int id, float price)
        {
            string query = string.Format("update dbo.Food set name1=N'{0}', idCategory={1}, price={2} where id={3}", name, id, price, idFood);
            int result = DataProvider.Instance.ExtecuteNonQuery(query);
            return result > 0;
        }
        public bool DeleteFood(int idFood)
        {
            BillInfoDAO.Instance.DeleteBillInfoByIdFood(idFood);//trước khi xóa thằng food, xóa billinfo trước
            string query = string.Format("delete dbo.Food where id={0}", idFood);
            int result = DataProvider.Instance.ExtecuteNonQuery(query);
            return result > 0;
        }
        public List<Food> SearchFoodByName(string name)
        {
            List<Food> list = new List<Food>();
            //Tìm kiếm tất cả các kí tự có nằm trong chuỗi(sql) tìm kiếm gần đúng, phải có dấu, ko dấu khó tìm
            string query = string.Format("select * from dbo.Food where dbo.fuConvertToUnsign1(name1) like N'%'+dbo.fuConvertToUnsign1(N'{0}')+'%'", name);
            DataTable data = DataProvider.Instance.ExtecuteQuery(query);
            foreach (DataRow item in data.Rows)
            {
                Food food = new Food(item);
                list.Add(food);
            }
            return list;
        }
    }
}
