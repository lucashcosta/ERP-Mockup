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

namespace WebAdmin
{
    public partial class ConsultaClientesPosibles : System.Web.UI.Page
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

        [WebMethod]
        public static string GetClientsOfOrders(string date)
        {
            DataTable table = new DataTable();
            DateTime dateTime = Convert.ToDateTime(date);

            // To store values from DB
            ClientsTable clientsTable;

            // Creates a SQL connection
            string strConnString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (var connection = new SqlConnection(strConnString))
            {
                connection.Open();

                // Creates a SQL command
                using (var command = new SqlCommand("SELECT id_cliente, nombre_cliente, apellido_cliente, colonia_cliente, nombre_ruta, postal_cliente, telefono_cliente, movil_cliente, plano_cliente FROM View_ClientesConPedido WHERE fechaEntrega_orden = @DeliverDate", connection))
                {
                    // Loads the query results into the table
                    command.Parameters.AddWithValue("@DeliverDate", dateTime);
                    table.Load(command.ExecuteReader());
                }

                clientsTable = new ClientsTable(table);
                connection.Close();
            }

            // Filter values form DB (Remove repeated clients)
            List<Client> distinctItems = clientsTable.ClientsStoredTable.GroupBy(x => x.Id).Select(y => y.First()).ToList();

            string json = JsonConvert.SerializeObject(distinctItems);
            return json;
        }

        [WebMethod]
        public static string GetCloseClients(IDictionary<string, object> client, bool colony, bool rute, string date)
        {
            DataTable table = new DataTable();
            DateTime dateTime = Convert.ToDateTime(date);

            Client clientObj = new Client(client);

            // To store values from DB
            ClientsTable clientsTable;

            // Creates a SQL connection
            string strConnString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (var connection = new SqlConnection(strConnString))
            {
                connection.Open();

                // Creates a SQL command, default is colony search
                string sqlQuery = "SELECT id_cliente, nombre_cliente, apellido_cliente, colonia_cliente, nombre_ruta, id_ruta, postal_cliente, telefono_cliente, movil_cliente, plano_cliente" +
                        " FROM View_ClienteRutas WHERE colonia_cliente LIKE @Place AND id_cliente != @ThisClientID AND id_cliente not in (SELECT id_cliente FROM View_ClientesConPedido WHERE fechaEntrega_orden = @Date OR fechaEntrega_orden = CAST(GETDATE() AS DATE))";
                if (colony)
                {
                    sqlQuery = "SELECT id_cliente, nombre_cliente, apellido_cliente, colonia_cliente, nombre_ruta, id_ruta, postal_cliente, telefono_cliente, movil_cliente, plano_cliente" +
                        " FROM View_ClienteRutas WHERE colonia_cliente LIKE @Place AND id_cliente != @ThisClientID AND id_cliente not in (SELECT id_cliente FROM View_ClientesConPedido WHERE fechaEntrega_orden = @Date OR fechaEntrega_orden = CAST(GETDATE() AS DATE))";
                }
                if (rute)
                {
                    sqlQuery = "SELECT id_cliente, nombre_cliente, apellido_cliente, colonia_cliente, nombre_ruta, id_ruta, postal_cliente, telefono_cliente, movil_cliente, plano_cliente" +
                        " FROM View_ClienteRutas WHERE id_ruta = @Place AND id_cliente != @ThisClientID AND id_cliente not in (SELECT id_cliente FROM View_ClientesConPedido WHERE fechaEntrega_orden = @Date OR fechaEntrega_orden = CAST(GETDATE() AS DATE))";
                }

                using (var command = new SqlCommand(sqlQuery, connection))
                {
                    // Loads the query results into the table
                    // Default colony parameter
                    command.Parameters.AddWithValue("@Place", clientObj.Colonia);
                    if (rute)
                        command.Parameters.AddWithValue("@Place", clientObj.idRuta);

                    command.Parameters.AddWithValue("@ThisClientID", Convert.ToInt32(clientObj.Id));
                    command.Parameters.AddWithValue("@Date", dateTime);
                    table.Load(command.ExecuteReader());
                }

                clientsTable = new ClientsTable(table);
                connection.Close();
            }

            // Filter values form DB (Remove repeated clients)
            List<Client> distinctItems = clientsTable.ClientsStoredTable.GroupBy(x => x.Id).Select(y => y.First()).ToList();
            distinctItems.Add(clientObj);

            string json = JsonConvert.SerializeObject(distinctItems);
            return json;
        }
    }
}