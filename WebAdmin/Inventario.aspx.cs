using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Configuration;
using WebAdmin.Classes;

namespace WebAdmin
{
    public partial class Inventario : System.Web.UI.Page
    {
        private String connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            //BindTable();
        }

        /*
         * Web method -> Donut chart 
         * Get popular items
         */
        [WebMethod]
        public static List<ItemsPrepared> GetRequestedItems(string startDate, string endDate)
        {
            List<ItemsPrepared> popItems = new List<ItemsPrepared>();
            if (String.IsNullOrEmpty(startDate))
            {
                startDate = DateTime.Now.ToString("DD/MM/YYYY");
            }
            if (String.IsNullOrEmpty(endDate))
            {
                endDate = DateTime.Now.ToString("DD/MM/YYYY");
            }
            DataTable table = new DataTable();
            using (var con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            using (var cmd = new SqlCommand("GetInventory", con))
            using (var da = new SqlDataAdapter(cmd))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@StartDate", Convert.ToDateTime(startDate));
                cmd.Parameters.AddWithValue("@EndDate", Convert.ToDateTime(endDate));
                da.Fill(table);
            }

            int i = 0;
            foreach (DataRow row in table.Rows)
            {
                popItems.Add(new ItemsPrepared() { Qty = row.Field<int>(0), Name = row.Field<string>(1), Description = row.Field<string>(2), Price = row.Field<string>(3), Brand = row.Field<string>(4)});
                i++;
                //popItems[i].Name = row.Field<string>(0);
                //popItems[i].RequestedQty = row.Field<int>(1);
            }

            return popItems;
        }

        private static DataTable GetData(SqlCommand cmd)
        {
            String connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            DataTable dt = new DataTable();
            SqlConnection con = new SqlConnection(connectionString);
            SqlDataAdapter sda = new SqlDataAdapter();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            con.Open();
            sda.SelectCommand = cmd;
            sda.Fill(dt);

            con.Dispose();
            con.Close();
            sda.Dispose();
            return dt;
        }
    }
}