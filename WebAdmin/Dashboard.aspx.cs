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
using System.Web.Http;
using WebAdmin.Classes;
using System.Globalization;

namespace WebAdmin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        private String connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        /*
         * Web method -> Donut chart 
         * Get popular items
         */
        [WebMethod]
        public static List<Item> GetPopularItems()
        {
            List<Item> popItems = new List<Item>();
            DataTable table = new DataTable();
            using (var con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            using (var cmd = new SqlCommand("GetPopularItems", con))
            using (var da = new SqlDataAdapter(cmd))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                da.Fill(table);
            }

            int i = 0;
            foreach (DataRow row in table.Rows)
            {
                popItems.Add(new Item() { Name = row.Field<string>(0), RequestedQty = row.Field<int>(1)});
                i++;
                //popItems[i].Name = row.Field<string>(0);
                //popItems[i].RequestedQty = row.Field<int>(1);
            }

            return popItems;
        }

        /*
         * Web method -> Area chart 
         * Get Months sells / Year sells
         */
        [WebMethod]
        public static List<SellsMonth> GetSellsByMonth()
        {
            List<SellsMonth> sellsM = new List<SellsMonth>();
            DataTable table = new DataTable();
            using (var con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            using (var cmd = new SqlCommand("GetSellsByMonth", con))
            using (var da = new SqlDataAdapter(cmd))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                da.Fill(table);
            }

            int i = 0;
            foreach (DataRow row in table.Rows)
            {
                sellsM.Add(new SellsMonth() { Qty = row.Field<int>(0), MonthNumber = row.Field<int>(1), MonthName = row.Field<string>(2), DistName = row.Field<string>(3) });
                i++;
                //popItems[i].Name = row.Field<string>(0);
                //popItems[i].RequestedQty = row.Field<int>(1);
            }

            int first = sellsM.First().MonthNumber;
            int last = sellsM.Last().MonthNumber;
            int j = 0;
            // Fill since first month 1 (Enero)
            for (i = 1; i < first; i++)
            {
                sellsM.Insert(j, new SellsMonth() { Qty = 0, MonthNumber = i, MonthName = DateTimeFormatInfo.CurrentInfo.GetAbbreviatedMonthName(i), DistName = String.Empty });
                j++;
            }

            // Fill til last month 12 (Dic)
            for (i = 12; i > last; i--)
            {
                sellsM.Insert(last, new SellsMonth() { Qty = 0, MonthNumber = i, MonthName = DateTimeFormatInfo.CurrentInfo.GetAbbreviatedMonthName(i), DistName = String.Empty });
            }

            if (sellsM.Count < 12)
            {
                for (i = 0; i < 12; i++)
                {
                    if (!(sellsM[i].MonthNumber == i + 1))
                    {
                        sellsM.Insert(i, new SellsMonth() { Qty = 0, MonthNumber = i+1, MonthName = DateTimeFormatInfo.CurrentInfo.GetAbbreviatedMonthName(i+1), DistName = String.Empty });
                    }
                }
            }

            return sellsM;
        }

        /*
         *Methods for notifications
         */
        [WebMethod]
        public static List<Client> GetStackedClient(int stackId)
        {
            List<Client> stackedClients = new List<Client>();
            string query = @"SELECT [id_cliente], [nombre_cliente] ,[apellido_cliente] ,[telefono_cliente] ,[movil_cliente] ,[plano_cliente] FROM [View_StackClientes] WHERE id_stack = " + stackId;
            DataTable table = new DataTable();
            SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
            SqlCommand cmd = new SqlCommand(query, conn);
            conn.Open();

            // create data adapter
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            // this will query your database and return the result to your datatable
            da.Fill(table);

            foreach (DataRow row in table.Rows)
            {
                stackedClients.Add(new Client() { FirstName = row.Field<string>(1), LastName = row.Field<string>(2), Phone = row.Field<string>(3), Mobile = row.Field<string>(4), Plano = row.Field<string>(5) });
                //popItems[i].Name = row.Field<string>(0);
                //popItems[i].RequestedQty = row.Field<int>(1);
            }

            conn.Close();
            da.Dispose();
            return stackedClients;
        }

        [WebMethod]
        public static int SetRequestFromStack(int stackId)
        {
            string strConnString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection sqlConnection1 = new SqlConnection(strConnString);

            string query = "[SetRequestFromStack]";
            SqlCommand cmd = new SqlCommand(query);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@StackId", stackId);

            cmd.Connection = sqlConnection1;
            sqlConnection1.Open();

            Object rowsAffected = cmd.ExecuteScalar();

            System.Diagnostics.Process process1 = new System.Diagnostics.Process();
            process1.StartInfo.FileName = HttpContext.Current.Server.MapPath("~/App_Data/SchedulerWebAdmin.exe");
            process1.Start();

            return Decimal.ToInt32((decimal)rowsAffected);
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