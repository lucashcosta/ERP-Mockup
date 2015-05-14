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
using System.Globalization;

namespace WebAdmin
{
    public partial class ConsultaClientes : System.Web.UI.Page
    {
        private String connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                BindTable();
                //BindReports();
            }
        }

        private void BindReports()
        {
            //SELECT id_cliente, nombre_cliente, MONTH(fechaAbrio_orden) Mes, COUNT(*) AS Compras FROM View_ClientesPedido Group by id_cliente, MONTH(fechaAbrio_orden), nombre_cliente, cantidad_compras Order by cantidad_compras desc
            string strQuery = "SELECT id_cliente, nombre_cliente, cantidad_compras, MONTH(fechaAbrio_orden) Mes, COUNT(*) AS Compras FROM View_ClientesPedido "
            + "WHERE fechaAbrio_orden BETWEEN DATEADD(month, -4, GETDATE()) AND GETDATE() "
            + "Group by id_cliente, MONTH(fechaAbrio_orden), nombre_cliente, cantidad_compras Order by cantidad_compras desc, id_cliente";

            SqlCommand cmd = new SqlCommand(strQuery);
            DataTable tempClients = GetData(cmd);

            string tempId = String.Empty;
            string id = String.Empty;
            string chartValues = "0,0,0,0";
            string month = String.Empty;

            string thisMonth = DateTime.Today.Month.ToString();

            for (int i = 0; i < tempClients.Rows.Count; i++)
            {
                tempId += tempClients.Rows[i].Field<string>("id_cliente") + ",";
                id = tempClients.Rows[i].Field<string>("id_cliente");
                month = tempClients.Rows[i].Field<string>("Mes");

                //Position the value in chart string
            }

            //topClientsGrid.DataSource = GetData(cmd);
            //topClientsGrid.DataBind();
        }

        private void BindTable()
        {
            //Bind Top 5 Clients
            string query = "SELECT * FROM [TopClientes]";
            SqlCommand cmd = new SqlCommand(query);

            topClientsGrid.DataSource = GetData(cmd);
            topClientsGrid.DataBind();

            // Dummy bind
            DataTable dummy = new DataTable();
            dummy.Columns.Add("id_cliente");
            dummy.Columns.Add("nombre_cliente");
            dummy.Columns.Add("telefono_cliente");
            dummy.Columns.Add("plano_cliente");
            dummy.Columns.Add("nombre_ruta");
            dummy.Columns.Add("ciudad_cliente");
            dummy.Columns.Add("direccion");
            dummy.Columns.Add("postal_cliente");
            dummy.Columns.Add("cantidad_compras");
            dummy.Columns.Add("diasSinCompra");
            dummy.Rows.Add();

            gridView.DataSource = dummy;
            gridView.DataBind();

            dummy.Clear();
            dummy.Dispose();

            DataTable inactiveDummy = new DataTable();

            inactiveDummy.Columns.Add("id_cliente");
            inactiveDummy.Columns.Add("cantidad_compras");
            inactiveDummy.Columns.Add("nombre_cliente");
            inactiveDummy.Columns.Add("telefono_cliente");
            inactiveDummy.Columns.Add("UltimaEntrega");
            inactiveDummy.Rows.Add();

            inactiveClientsGrid.DataSource = inactiveDummy;
            inactiveClientsGrid.DataBind();

            // Footable
            TableCellCollection cells = gridView.HeaderRow.Cells;
            cells[0].Attributes.Add("data-hide", "phone,tablet");
            //cells[1].Attributes.Add("data-hide", "phone,tablet");
            cells[2].Attributes.Add("data-hide", "phone,");
            cells[3].Attributes.Add("data-hide", "phone,");
            cells[3].Attributes.Add("data-hide", "phone,tablet");
            cells[4].Attributes.Add("data-hide", "phone,tablet");
            cells[5].Attributes.Add("data-hide", "phone,tablet");
            cells[6].Attributes.Add("data-hide", "phone,");
            cells[7].Attributes.Add("data-hide", "phone,tablet");
            cells[8].Attributes.Add("data-hide", "phone,tablet");
            cells[9].Attributes.Add("data-hide", "phone,tablet");
        }

        /*
         * Web method for search and pagination
         */
        [WebMethod]
        public static string GetClients(string searchTerm, int pageIndex, int pageSize)
        {
            string query = "[GetClientsCatalog]";
            SqlCommand cmd = new SqlCommand(query);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@SearchTerm", searchTerm);
            cmd.Parameters.AddWithValue("@PageIndex", pageIndex);
            cmd.Parameters.AddWithValue("@PageSize", pageSize);
            cmd.Parameters.Add("@PageCount", SqlDbType.Int, 4).Direction = ParameterDirection.Output;
            return GetData(cmd, pageIndex, pageSize).GetXml();
        }

        [WebMethod]
        public static string GetInactiveClients(string days)
        {
            string query = "[InactiveClients]";
            SqlCommand cmd = new SqlCommand(query);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Days", Convert.ToInt32(days));
            return GetDataReports(cmd).GetXml();
        }

        private static DataSet GetData(SqlCommand cmd, int pageIndex, int pageSize)
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
                        sda.Fill(ds, "View_ClienteRutas");
                        DataTable dt = new DataTable("PageCount");
                        dt.Columns.Add("PageIndex");
                        dt.Columns.Add("PageSize");
                        dt.Columns.Add("PageCount");
                        dt.Rows.Add();
                        dt.Rows[0]["PageIndex"] = pageIndex;
                        dt.Rows[0]["PageSize"] = pageSize;
                        dt.Rows[0]["PageCount"] = cmd.Parameters["@PageCount"].Value;
                        ds.Tables.Add(dt);
                        return ds;
                    }
                }
            }
        }

        private static DataSet GetDataReports(SqlCommand cmd)
        {
            string strConnString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            cmd.Connection = con;
            try
            {
                SqlDataAdapter custDA = new SqlDataAdapter();
                custDA.SelectCommand = cmd;

                con.Open();

                DataSet custDS = new DataSet();
                custDA.Fill(custDS, "Clientes");

                con.Close();
                con.Dispose();

                return custDS;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void gridView_PreRender(object sender, EventArgs e)
        {
            gridView.UseAccessibleHeader = true;
            gridView.HeaderRow.TableSection = TableRowSection.TableHeader;

            
        }

        // Methods
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

        private void Delete(int id)
        {
            SqlConnection connection = new SqlConnection(connectionString);
            try
            {
                connection.Open();

                string sql_command = "DELETE FROM Clientes WHERE id_cliente=" + id;
                SqlCommand cmd = new SqlCommand(sql_command, connection);
                //cmd.Parameters.RemoveAt("@id", );
                cmd.ExecuteNonQuery();
                cmd.Dispose();
                //Refresh Table
                BindTable();
            }
            catch (SqlException s_exp)
            {
                messagesText.Attributes["class"] = "alert alert-danger alert-dismissable";
                lblMessage.Text = s_exp.ToString();
                panelMessage.Visible = true;
            }
        }

        protected void deleteClient_Click(object sender, EventArgs e)
        {
            if (deleteID.Value == "0")
                return;

            Delete(Convert.ToInt32(deleteID.Value));
        }

        protected void inactiveClientsGrid_PreRender(object sender, EventArgs e)
        {
            inactiveClientsGrid.UseAccessibleHeader = true;
            inactiveClientsGrid.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

    }
}