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
using Newtonsoft.Json;
using System.Web.Security;

namespace WebAdmin
{
    public partial class ConsultaPedidos : System.Web.UI.Page
    {
        private String connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        //private static int PageSize = 30;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                // Do
                BindTable();
            }
        }

        /*
         * private void BindProgrammedTable()
         * string strQuery = "SELECT * FROM Pedido INNER JOIN Clientes ON Pedido.id_cliente = Clientes.id_cliente WHERE status_orden = 'Programado' ORDER BY fechaAbrio_orden DESC"; //Mas nuevas a mas viejas
         */
        
        private void BindTable()
        {
            //string strQuery = "SELECT * FROM Pedido INNER JOIN Clientes ON Pedido.id_cliente = Clientes.id_cliente ORDER BY fechaAbrio_orden DESC"; //Mas nuevas a mas viejas
            //SqlCommand cmd = new SqlCommand(strQuery);
            //gridView.DataSource = GetData(cmd);
            //gridView.DataBind();

            // Dummy bind
            DataTable dummy = new DataTable();
            dummy.Columns.Add("id_pedido");
            dummy.Columns.Add("id_cliente");
            dummy.Columns.Add("nombre_cliente");
            //dummy.Columns.Add("apellido_cliente");
            dummy.Columns.Add("movil_cliente");
            dummy.Columns.Add("telefono_cliente");
            dummy.Columns.Add("plano_cliente");
            dummy.Columns.Add("fechaEntrega_orden");
            dummy.Columns.Add("direccion");
            dummy.Columns.Add("postal_cliente");
            dummy.Columns.Add("ciudad_cliente");
            dummy.Columns.Add("horarioEntrega_orden");
            dummy.Columns.Add("totalProductos_orden");
            dummy.Columns.Add("status_orden");
            dummy.Rows.Add();

            gridView.DataSource = dummy;
            gridView.DataBind();

            // Footable
            TableCellCollection cells = gridView.HeaderRow.Cells;
            //cells[0].Attributes.Add("data-hide", "phone,tablet");
            cells[1].Attributes.Add("data-hide", "phone,tablet");
            cells[2].Attributes.Add("data-hide", "phone,tablet");
            //cells[2].Attributes.Add("data-hide", "phone,");
            //cells[3].Attributes.Add("data-hide", "phone,");
            cells[4].Attributes.Add("data-hide", "phone,tablet");
            cells[5].Attributes.Add("data-hide", "phone,tablet");
            cells[6].Attributes.Add("data-hide", "phone,tablet");
            cells[7].Attributes.Add("data-hide", "phone,");
            cells[8].Attributes.Add("data-hide", "phone,tablet");
            cells[9].Attributes.Add("data-hide", "phone,tablet");
            cells[10].Attributes.Add("data-hide", "phone,tablet");
            cells[11].Attributes.Add("data-hide", "phone,tablet");
        }

        private DataTable GetData(SqlCommand cmd)
        {
            DataTable dt = new DataTable();
            SqlConnection con = new SqlConnection(connectionString);
            SqlDataAdapter sda = new SqlDataAdapter();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            con.Open();
            sda.SelectCommand = cmd;
            sda.Fill(dt);
            return dt;
        }

        [WebMethod]
        public static string SetStatusGroup(string[] ids)
        {
            DataTable _myDataTable = new DataTable();

            // ID column (EmployeeID idiot column)
            _myDataTable.Columns.Add("EmployeeID ", typeof(int));

            for (int i = 0; i < ids.Length; i++)
                _myDataTable.Rows.Add(Int32.Parse(ids[i]));

            string strConnString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection sqlConnection1 = new SqlConnection(strConnString);

            string query = "[SetStatusChanges]";
            SqlCommand cmd = new SqlCommand(query);

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Array", _myDataTable);
            cmd.Parameters.AddWithValue("@Status", "Entregado & pagado");

            cmd.Connection = sqlConnection1;
            sqlConnection1.Open();

            Object rowsAffected = cmd.ExecuteScalar();
            sqlConnection1.Close();

            return "SUCCESS";
        }

        [WebMethod]
        public static string AskCloseBox()
        {
            // Table to store the query results
            DataTable table = new DataTable();

            // Class to store the table
            BoxTable boxTable;

            // Creates a SQL connection
            string strConnString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (var connection = new SqlConnection(strConnString))
            {
                connection.Open();

                // Creates a SQL command
                using (var command = new SqlCommand("SELECT * FROM View_AskBox", connection))
                {
                    // Loads the query results into the table
                    table.Load(command.ExecuteReader());
                }

                boxTable = new BoxTable(table);
                connection.Close();
            }

            string json = JsonConvert.SerializeObject(boxTable);
            return json;
        }

        [WebMethod]
        public static string TellCloseBox()
        {
            string strConnString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            string userId = Membership.GetUser().ProviderUserKey.ToString();

            SqlConnection sqlConnection1 = new SqlConnection(strConnString);

            string query = "[TellCloseBox]";
            SqlCommand cmd = new SqlCommand(query);

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id_usuario", new Guid(userId));

            cmd.Connection = sqlConnection1;
            sqlConnection1.Open();

            Object rowsAffected = cmd.ExecuteScalar();
            sqlConnection1.Close();

            return "SUCCESS";
        }

        [WebMethod]
        public static string UpdateDeliverDate(string[] ids, string modDate)
        {
            DateTime setDate = Convert.ToDateTime(modDate);
            DataTable _myDataTable = new DataTable();

            // ID column (EmployeeID idiot column)
            _myDataTable.Columns.Add("EmployeeID ", typeof(int));

            for (int i = 0; i < ids.Length; i++)
            {
                try
                {
                    _myDataTable.Rows.Add(Int32.Parse(ids[i]));
                }
                catch (Exception ex) { }
            }

            string strConnString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection sqlConnection1 = new SqlConnection(strConnString);

            string query = "[SetDeliverDatesChanges]";
            SqlCommand cmd = new SqlCommand(query);

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Array", _myDataTable);
            cmd.Parameters.AddWithValue("@NewDate", setDate);

            cmd.Connection = sqlConnection1;
            sqlConnection1.Open();

            Object rowsAffected = cmd.ExecuteScalar();
            sqlConnection1.Close();

            return "SUCCESS";
        }

        /*
         * Web method for search and pagination
         */
        [WebMethod]
        public static string GetCustomers(string searchTerm, int pageIndex, int pageSize, string startDate, string endDate, string deliverFilter, string statusFilter, string streetFilter, string colonyFilter, string firstNameFilter, string lastNameFilter)
        {
            string query = "[GetCustomers_Pager]";
            SqlCommand cmd = new SqlCommand(query);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@SearchTerm", searchTerm);
            cmd.Parameters.AddWithValue("@PageIndex", pageIndex);
            cmd.Parameters.AddWithValue("@PageSize", pageSize);
            cmd.Parameters.AddWithValue("@StartDate", Convert.ToDateTime(startDate));
            cmd.Parameters.AddWithValue("@EndDate", Convert.ToDateTime(endDate));
            cmd.Parameters.Add("@PageCount", SqlDbType.Int, 4).Direction = ParameterDirection.Output;

            //Filters
            cmd.Parameters.AddWithValue("@DeliverTimeFilter", deliverFilter);
            cmd.Parameters.AddWithValue("@StatusFilter", statusFilter);
            cmd.Parameters.AddWithValue("@StreetFilter", streetFilter);
            cmd.Parameters.AddWithValue("@ColonyFilter", colonyFilter);
            cmd.Parameters.AddWithValue("@FirstNameFilter", firstNameFilter);
            cmd.Parameters.AddWithValue("@LastNameFilter", lastNameFilter);
            return GetData(cmd, pageIndex, pageSize, Convert.ToDateTime(startDate), Convert.ToDateTime(endDate)).GetXml();
        }

        private static DataSet GetData(SqlCommand cmd, int pageIndex, int pageSize, DateTime startDate, DateTime endDate)
        {
            string strConnString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection con = new SqlConnection(strConnString))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using (DataSet ds = new DataSet())
                    {
                        sda.Fill(ds, "View_ConsultaPedidos");
                        DataTable dt = new DataTable("PageCount");
                        dt.Columns.Add("PageIndex");
                        dt.Columns.Add("PageSize");
                        dt.Columns.Add("PageCount");
                        dt.Columns.Add("StartDate");
                        dt.Columns.Add("EndDate");
                        dt.Rows.Add();
                        dt.Rows[0]["PageIndex"] = pageIndex;
                        dt.Rows[0]["PageSize"] = pageSize;
                        dt.Rows[0]["StartDate"] = startDate;
                        dt.Rows[0]["EndDate"] = endDate;
                        dt.Rows[0]["PageCount"] = cmd.Parameters["@PageCount"].Value;
                        ds.Tables.Add(dt);
                        return ds;
                    }
                }
            }
        }

        protected void gridView_PreRender(object sender, EventArgs e)
        {
            gridView.UseAccessibleHeader = true;
            gridView.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
    }
}