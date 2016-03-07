using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebAdmin.Classes;

namespace WebAdmin.Reportes
{
    public partial class CierreCaja : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string GetBox(string date)
        {
            // Table to store the query results
            DataTable table = new DataTable();
            DateTime dateTime = Convert.ToDateTime(date);

            // Class to store the table
            BoxTable boxTable;

            // Creates a SQL connection
            string strConnString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (var connection = new SqlConnection(strConnString))
            {
                connection.Open();

                // Creates a SQL command
                using (var command = new SqlCommand("SELECT * FROM View_FullBox WHERE fecha_cierre_caja = @CloseBoxDate", connection))
                {
                    // Loads the query results into the table
                    command.Parameters.AddWithValue("@CloseBoxDate", dateTime);
                    table.Load(command.ExecuteReader());
                }

                boxTable = new BoxTable(table);
                connection.Close();
            }

            string json = JsonConvert.SerializeObject(boxTable);
            return json;
        }
    }
}