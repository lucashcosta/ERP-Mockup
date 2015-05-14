using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Globalization;

namespace WebAdmin
{
    public partial class EditarCliente : System.Web.UI.Page
    {
        int id;
        DataTable req_Info;

        private String connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["success"] != null)
                {
                    messagesText.Attributes["class"] = "alert alert-success alert-dismissable";
                    lblMessage.Text = "Actuailzacion del cliente " + Request.QueryString["Id"] + " correcta";
                    panelMessage.Visible = true;
                    Session.Remove("success");
                }

                // Avoid event fire on refresh
                Session["CheckRefresh"] = Server.UrlDecode(System.DateTime.Now.ToString());
                id = Convert.ToInt32(Request.QueryString["Id"]);
                ShowRecentclientActivity();

                // Fill datable
                SqlCommand cmd;
                string strQuery = "SELECT * FROM [dbo].[Clientes] WHERE id_cliente = @id";
                cmd = new SqlCommand(strQuery);
                cmd.Parameters.AddWithValue("@id", id);
                req_Info = GetData(cmd);

                // Fill order
                if (req_Info.Rows.Count > 0)
                {
                    BindRutesDropD();
                    FillEditForm();
                }
            }
        }

        private void BindRutesDropD()
        {
            string strQuery = "SELECT [id], [nombre] FROM [dbo].[Rutas]";
            SqlCommand cmd = new SqlCommand(strQuery);

            ruteInputDropD.DataSource = GetData(cmd);
            ruteInputDropD.DataTextField = "nombre";
            ruteInputDropD.DataValueField = "id";
            ruteInputDropD.DataBind();
        }

        private void FillEditForm()
        {
            firstNameInput.Text = req_Info.Rows[0].Field<string>("nombre_cliente");
            lastNameInput.Text = req_Info.Rows[0].Field<string>("apellido_cliente");
            phoneInput.Text = req_Info.Rows[0].Field<string>("telefono_cliente");
            mobileInput.Text = req_Info.Rows[0].Field<string>("movil_cliente");
            planoInput.Text = req_Info.Rows[0].Field<string>("plano_cliente");
            cityInput.Text = req_Info.Rows[0].Field<string>("ciudad_cliente");
            colonyInput.Text = req_Info.Rows[0].Field<string>("colonia_cliente");
            streetInput.Text = req_Info.Rows[0].Field<string>("calle_cliente");
            betStreetsInput.Text = req_Info.Rows[0].Field<string>("entreCalles_cliente");
            dirNumberInput.Text = req_Info.Rows[0].Field<string>("numeroDir_cliente");
            postalInput.Text = req_Info.Rows[0].Field<string>("postal_cliente");
            //ruteInputDropD.Text = req_Info.Rows[0].Field<string>("");
            dirRefInput.Text = req_Info.Rows[0].Field<string>("referencias_direccion_cliente");
            notesInput.Text = req_Info.Rows[0].Field<string>("notas_cliente");

            // Rutes: Unselect all items before
            foreach (ListItem item in this.ruteInputDropD.Items)
            {
                item.Selected = false;
            }
            if (!String.IsNullOrEmpty(req_Info.Rows[0].Field<int>("id_ruta").ToString()))
                ruteInputDropD.Items.FindByValue(req_Info.Rows[0].Field<int>("id_ruta").ToString()).Selected = true;
            else
                ruteInputDropD.Items.FindByValue("0").Selected = true;

            var a = req_Info.Rows[0].Field<int?>("id_ruta").ToString();
            // Contact Ref (Como se entero de nosotros)
            foreach (ListItem item in this.contactRefDropD.Items)
            {
                item.Selected = false;
            }
            if (!String.IsNullOrEmpty(req_Info.Rows[0].Field<string>("formaContacto_cliente")))
            {
                try
                {
                    contactRefDropD.Items.FindByText(req_Info.Rows[0].Field<string>("formaContacto_cliente")).Selected = true;
                }
                catch (NullReferenceException ex)
                { }
            }

            // Special ship price
            if (req_Info.Rows[0].Field<int?>("envioEspecial_cliente") == 1)
            {
                shipbox.Attributes.Add("checked", "true");
                shipValue.Text = req_Info.Rows[0].Field<double?>("precioEnvio_cliente").ToString();
            }

            // Special ship price
            if (req_Info.Rows[0].Field<int?>("descuentoEspecial_cliente") == 1)
            {
                discbox.Attributes.Add("checked", "true");
                discValue.Text = req_Info.Rows[0].Field<double?>("valorDescuento_cliente").ToString();
            }
        }

        private void UpdateClient()
        {
            var connection = new SqlConnection(connectionString);
            connection.Open();
            string sql_update = "UPDATE Clientes SET [id_ruta] = @ruteId "
                                  +",[nombre_cliente] = @firstName"
                                  +",[apellido_cliente] = @lastName"
                                  +",[telefono_cliente] = @phone"
                                  +",[movil_cliente] = @mobile"
                                  +",[plano_cliente] = @plano"
                                  +",[ciudad_cliente] = @city"
                                  +",[colonia_cliente] = @colony"
                                  +",[calle_cliente] = @street"
                                  +",[entreCalles_cliente] = @betStreets"
                                  +",[numeroDir_cliente] = @dirNumber"
                                  +",[postal_cliente] = @postal"
                                  +",[referencias_direccion_cliente] = @dirRef"
                                  +",[notas_cliente] = @notes "
                                  + ",[formaContacto_cliente] = @contactRef"
                                  + ",[envioEspecial_cliente] = @specialShipping"
                                  + ",[precioEnvio_cliente] = @specialShippingPrice"
                                  + ",[descuentoEspecial_cliente] = @specialDiscount"
                                  + ",[valorDescuento_cliente] = @specialDiscountValue "

                                +"WHERE id_cliente = @clientID";

            // Set special ship price if the case
            int specialShipping = 0;
            if (shipbox.Checked)
                specialShipping = 1;

            // Set discount value id the case
            int specialDiscount = 0;
            if (discbox.Checked)
                specialDiscount = 1;

            try
            {
                SqlCommand command = new SqlCommand(sql_update, connection);
                command.Parameters.AddWithValue("@clientID", Convert.ToInt32(Request.QueryString["Id"]));

                command.Parameters.AddWithValue("@ruteId", Convert.ToInt32(ruteInputDropD.SelectedValue));
                command.Parameters.AddWithValue("@firstName", firstNameInput.Text.Trim());
                command.Parameters.AddWithValue("@lastName", lastNameInput.Text.Trim());
                command.Parameters.AddWithValue("@phone", phoneInput.Text.Trim());
                command.Parameters.AddWithValue("@mobile", mobileInput.Text.Trim());
                command.Parameters.AddWithValue("@plano", planoInput.Text.Trim().ToUpper());
                command.Parameters.AddWithValue("@city", cityInput.Text.Trim());
                command.Parameters.AddWithValue("@colony", colonyInput.Text.Trim());
                command.Parameters.AddWithValue("@street", streetInput.Text.Trim());
                command.Parameters.AddWithValue("@betStreets", betStreetsInput.Text.Trim());
                command.Parameters.AddWithValue("@dirNumber", dirNumberInput.Text.Trim());
                command.Parameters.AddWithValue("@postal", postalInput.Text.Trim());
                command.Parameters.AddWithValue("@dirRef", dirRefInput.Text.Trim());
                command.Parameters.AddWithValue("@notes", notesInput.Text.Trim());
                command.Parameters.AddWithValue("@contactRef", contactRefDropD.SelectedItem.Text.Trim());
                command.Parameters.AddWithValue("@specialShipping", specialShipping);
                if(!String.IsNullOrWhiteSpace(shipValue.Text))
                    command.Parameters.AddWithValue("@specialShippingPrice", Convert.ToDouble(shipValue.Text));
                else
                    command.Parameters.AddWithValue("@specialShippingPrice", DBNull.Value);

                command.Parameters.AddWithValue("@specialDiscount", specialDiscount);
                
                if (!String.IsNullOrWhiteSpace(discValue.Text))
                    command.Parameters.AddWithValue("@specialDiscountValue", Convert.ToDouble(discValue.Text));
                else
                    command.Parameters.AddWithValue("@specialDiscountValue", DBNull.Value);

                command.ExecuteNonQuery();
                command.Parameters.Clear();
                command.Dispose();
                connection.Close();

                Session["success"] = true;
                Response.Redirect("EditarCliente.aspx?Id=" + Request.QueryString["Id"]); // Fix POST method when refreshing
            }
            catch (SqlException s_exp)
            {
                string htmlError = "<div class=\"alert alert-danger alert-dismissable\">" +
                                      "<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">&times;</button>" +
                                      "Error: " + s_exp +
                                   "</div>";
                Response.Write(htmlError);
                //Response.Write(s_exp);
            }
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

        protected void updateBtn_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(firstNameInput.Text) || String.IsNullOrEmpty(lastNameInput.Text) || String.IsNullOrEmpty(phoneInput.Text)
                || String.IsNullOrEmpty(cityInput.Text) || String.IsNullOrEmpty(colonyInput.Text) || String.IsNullOrEmpty(dirNumberInput.Text))
                return;

            UpdateClient();
        }

        protected void lastBuysGrid_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //e.Row.Attributes["onclick"] = "SelectBase()";
                e.Row.Attributes["style"] = "cursor:pointer";
                e.Row.CssClass = "baseRow";

                if (e.Row.Cells[2].Text == "Entregado &amp; pagado")
                {
                    e.Row.CssClass = e.Row.CssClass + " success";
                    return;
                }
                if (e.Row.Cells[2].Text == "Entregado &amp; no pagado")
                {
                    e.Row.CssClass = e.Row.CssClass + " danger";
                    return;
                }
                if (e.Row.Cells[2].Text == "Pagado &amp; no entregado")
                {
                    e.Row.CssClass = e.Row.CssClass + " warning";
                    return;
                }
                if (e.Row.Cells[2].Text == "Cancelado")
                {
                    e.Row.CssClass = e.Row.CssClass + " danger";
                    return;
                }
            }
        }

        private void ShowRecentclientActivity()
        {
            //Bind with lastName criteria
            string strQuery = "SELECT TOP 5 id_pedido, "
                                + "producto_orden, tipoProducto_orden, cantidadProducto_orden, producto2_orden, tipoProducto2_orden, cantidadProducto2_orden, producto3_orden, tipoProducto3_orden, cantidadProducto3_orden, "
                                + "producto4_orden, tipoProducto4_orden, cantidadProducto4_orden, producto5_orden, tipoProducto5_orden, cantidadProducto5_orden, producto6_orden, tipoProducto6_orden, cantidadProducto6_orden, "
                                + "producto7_orden, tipoProducto7_orden, cantidadProducto7_orden, producto8_orden, tipoProducto8_orden, cantidadProducto8_orden, producto9_orden, tipoProducto9_orden, cantidadProducto9_orden, "
                                + "totalProductos_orden, "
                                + "CAST(DAY(fechaEntrega_orden) AS VARCHAR(2)) + ' ' + DATENAME(MM, fechaEntrega_orden) + ' ' + CAST(YEAR(fechaEntrega_orden) AS VARCHAR(4)) AS fechaEntrega_orden, "
                                + "status_orden FROM [dbo].[Pedido] WHERE id_cliente = @clientId ORDER BY fechaAbrio_orden DESC";
            SqlCommand cmd = new SqlCommand(strQuery);

            string searchMobile = string.Format("%{0}%", mobileInput.Text.Trim());
            cmd.Parameters.AddWithValue("@clientId", id);

            var a = GetData(cmd);

            lastBuysGrid.DataSource = GetData(cmd);
            lastBuysGrid.DataBind();

            //lastBuysDiv.Attributes["class"].Replace("hidden", "");

        }

        /*
         * WebMethod. Gauto-generate a request (pedido)
         */
        [WebMethod]
        public static int StackRequest(int reqId, int clientId, string dateInput, int addDays)
        {
            string strConnString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            int rowsAffected;
            SqlConnection sqlConnection1 = new SqlConnection(strConnString);

            DateTime orderDate;
            DateTimeFormatInfo formatOrderDate = new DateTimeFormatInfo();
            formatOrderDate.ShortDatePattern = "yyyy-MM-dd";
            formatOrderDate.DateSeparator = "-";
            orderDate = Convert.ToDateTime(dateInput, formatOrderDate);

            string query = "[PutRequestInStack]";
            SqlCommand cmd = new SqlCommand(query);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@reqId", reqId);
            cmd.Parameters.AddWithValue("@clientId", clientId);
            cmd.Parameters.AddWithValue("@orderDate", orderDate);
            cmd.Parameters.AddWithValue("@freqRate", addDays);
            cmd.Parameters.AddWithValue("@nextDate", orderDate.AddDays(addDays));

            cmd.Connection = sqlConnection1;
            sqlConnection1.Open();

            rowsAffected = cmd.ExecuteNonQuery();

            System.Diagnostics.Process process1 = new System.Diagnostics.Process();
            process1.StartInfo.FileName = HttpContext.Current.Server.MapPath("~/App_Data/SchedulerWebAdmin.exe");
            process1.Start();

            return rowsAffected;
        }
    }
}