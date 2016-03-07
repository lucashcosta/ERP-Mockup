using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;

namespace WebAdmin
{
    public partial class Pedido : System.Web.UI.Page
    {
        private const int QTY_ITEMS = 10; // Number of items avaible

        /*
         * Fields used in behind code for SQL purposes
         */
        private int m_id; // Selected ID in CliensGrid
        private static int m_buys;
        private static bool m_IsClient = false;

        /*
         * Session user bindings
         * m_UserBinds[0] = brandID
         * m_UserBinds[1] = distID
         * m_UserBinds[2] = brandName
         * 
         */
        private static string[] m_UserBinds;

        /*
         * Constants strings
         * Fields names in order to catch them when POST
         */
        private const string f_isClient = "ctl00$MainContent$isClient";
        private const string f_clientID = "ctl00$MainContent$clientID";

        private const string f_productPrice = "ctl00$MainContent$productPrice";
        private const string f_productPrice2 = "ctl00$MainContent$productPrice2";
        private const string f_productPrice3 = "ctl00$MainContent$productPrice3";
        private const string f_productPrice4 = "ctl00$MainContent$productPrice4";
        private const string f_productPrice5 = "ctl00$MainContent$productPrice5";
        private const string f_productPrice6 = "ctl00$MainContent$productPrice6";
        private const string f_productPrice7 = "ctl00$MainContent$productPrice7";
        private const string f_productPrice8 = "ctl00$MainContent$productPrice8";
        private const string f_productPrice9 = "ctl00$MainContent$productPrice9";

        private const string f_unitPriceProduct = "ctl00$MainContent$unitPriceProduct";
        private const string f_unitPriceProduct2 = "ctl00$MainContent$unitPriceProduct2";
        private const string f_unitPriceProduct3 = "ctl00$MainContent$unitPriceProduct3";
        private const string f_unitPriceProduct4 = "ctl00$MainContent$unitPriceProduct4";
        private const string f_unitPriceProduct5 = "ctl00$MainContent$unitPriceProduct5";
        private const string f_unitPriceProduct6 = "ctl00$MainContent$unitPriceProduct6";
        private const string f_unitPriceProduct7 = "ctl00$MainContent$unitPriceProduct7";
        private const string f_unitPriceProduct8 = "ctl00$MainContent$unitPriceProduct8";
        private const string f_unitPriceProduct9 = "ctl00$MainContent$unitPriceProduct9";
        private const string f_shippingPrice= "ctl00$MainContent$shippingPrice";

        private const string f_totalProductPrice = "ctl00$MainContent$totalProductPrice";
        //private const string f_firstName = "ctl00$MainContent$firstName";
        //private const string f_lastName = "ctl00$MainContent$lastName";
        private const string f_phone = "ctl00$MainContent$phone";
        private const string f_mobile = "ctl00$MainContent$mobile";
        private const string f_plano = "ctl00$MainContent$plano";
        private const string f_city = "ctl00$MainContent$city";
        private const string f_colony = "ctl00$MainContent$colony";
        private const string f_street = "ctl00$MainContent$street";
        private const string f_betStreets = "ctl00$MainContent$betStreets";
        private const string f_dirNumber = "ctl00$MainContent$dirNumber";
        private const string f_postalCode = "ctl00$MainContent$postalCode";
        private const string f_dirNotes = "ctl00$MainContent$dirNotes";
        private const string f_orderDate = "ctl00$MainContent$orderDate";
        private const string f_deliveringTime = "ctl00$MainContent$deliveringTime";
        private const string f_qtyPay = "ctl00$MainContent$qtyPay";
        private const string f_payMethod = "ctl00$MainContent$payMethod";
        //private const string f_brand = "ctl00$MainContent$brandDropD"; // Delete this
        private const string f_product = "ctl00$MainContent$productDropD";
        private const string f_type = "ctl00$MainContent$typeDropD";
        private const string f_qtyProduct = "ctl00$MainContent$qtyP";
        private const string f_product2 = "ctl00$MainContent$productDropD2";
        private const string f_type2 = "ctl00$MainContent$typeDropD2";
        private const string f_qtyProduct2 = "ctl00$MainContent$qtyP2";
        private const string f_product3 = "ctl00$MainContent$productDropD3";
        private const string f_type3 = "ctl00$MainContent$typeDropD3";
        private const string f_qtyProduct3 = "ctl00$MainContent$qtyP3";
        private const string f_product4 = "ctl00$MainContent$productDropD4";
        private const string f_type4 = "ctl00$MainContent$typeDropD4";
        private const string f_qtyProduct4 = "ctl00$MainContent$qtyP4";
        private const string f_product5 = "ctl00$MainContent$productDropD5";
        private const string f_type5 = "ctl00$MainContent$typeDropD5";
        private const string f_qtyProduct5 = "ctl00$MainContent$qtyP5";
        private const string f_product6 = "ctl00$MainContent$productDropD6";
        private const string f_type6 = "ctl00$MainContent$typeDropD6";
        private const string f_qtyProduct6 = "ctl00$MainContent$qtyP6";
        private const string f_product7 = "ctl00$MainContent$productDropD7";
        private const string f_type7 = "ctl00$MainContent$typeDropD7";
        private const string f_qtyProduct7 = "ctl00$MainContent$qtyP7";
        private const string f_product8 = "ctl00$MainContent$productDropD8";
        private const string f_type8 = "ctl00$MainContent$typeDropD8";
        private const string f_qtyProduct8 = "ctl00$MainContent$qtyP8";
        private const string f_product9 = "ctl00$MainContent$productDropD9";
        private const string f_type9 = "ctl00$MainContent$typeDropD9";
        private const string f_qtyProduct9 = "ctl00$MainContent$qtyP9";
        private const string f_promotion = "ctl00$MainContent$promotionsDropD";
        //private const string f_status = "statusOptions";
        private const string f_refContacto = "ctl00$MainContent$refContacto";
        private const string f_refPromo = "ctl00$MainContent$refPromo";
        private const string f_estimatedTime = "ctl00$MainContent$estimatedTime";
        private const string f_reqNotes = "ctl00$MainContent$reqNotes";
        private const string f_SubmitBtn = "ctl00$MainContent$submitBtn";



        private String connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["success"] != null)
                {
                    messagesText.Attributes["class"] = "alert alert-success alert-dismissable";
                    lblMessage.Text = "Guardado en base de datos";
                    panelMessage.Visible = true;
                    Session.Remove("success");
                }

                if (Session["UserBinds"] != null)
                {
                    m_UserBinds = Session["UserBinds"] as string[];
                }
                else
                {
                    m_UserBinds = Global.getUserBinds();
                }

                Session["CheckRefresh"] = Server.UrlDecode(System.DateTime.Now.ToString());
                //BindBrandsDropDown();
                BindTypeDropDown();
                BindPromotionsDropDown();
                //BindClientsGrid();
                BindRutesDropD();

                if (true)
                {
                    //Bind all brands
                    BindBrandsDropDown();
                    BindAdminProductDropDown(Convert.ToInt32(brandDropD.Items.FindByText("Ion Water").Value));
                }
                else 
                {
                    //Bind normally
                    BindProductDropDown();
                }
            }
        }

        private void BindClientsGrid()
        {
            //if (String.IsNullOrWhiteSpace(firstName.Text) && String.IsNullOrWhiteSpace(lastName.Text) && String.IsNullOrWhiteSpace(phone.Text) && String.IsNullOrWhiteSpace(mobile.Text)) { }
            SqlCommand cmd;
            string strQuery = "SELECT * FROM [dbo].[Clientes]";
            cmd = new SqlCommand(strQuery);
            clientsGrid.DataSource = GetData(cmd);
            clientsGrid.DataBind();
        }

        //Filling fields
        private void BindBrandsDropDown()
        {
            string strQuery = "SELECT [id_marca] ,[nombre_marca] FROM [dbo].[Marcas]";
            SqlCommand cmd = new SqlCommand(strQuery);
            brandDropD.DataSource = GetData(cmd);
            brandDropD.DataTextField = "nombre_marca";
            brandDropD.DataValueField = "id_marca";
            brandDropD.DataBind();
            brandDropD.Items.FindByText("Ion Water").Selected = true;
        }

        //private void BindMessengerDropD()
        //{
        //    string strQuery = "SELECT [id_marca] ,[nombre_marca] FROM [dbo].[Marcas]";
        //    SqlCommand cmd = new SqlCommand(strQuery);
        //    brandDropD.DataSource = GetData(cmd);
        //    brandDropD.DataTextField = "nombre_marca";
        //    brandDropD.DataValueField = "id_marca";
        //    brandDropD.DataBind();
        //    brandDropD.Items.FindByText("Ion Water").Selected = true;
        //}

        private void BindRutesDropD()
        {
            string strQuery = "SELECT [id], [nombre] FROM [dbo].[Rutas]";
            SqlCommand cmd = new SqlCommand(strQuery);

            ruteDropD.DataSource = GetData(cmd);
            ruteDropD.DataTextField = "nombre";
            ruteDropD.DataValueField = "id";
            ruteDropD.DataBind();
        }

        private void BindAdminProductDropDown(int id)
        {
            string strQuery = "SELECT [id_producto] ,CONCAT([nombre_producto], ' / $', [precioUnitario_producto]) AS fullProduct, [precioUnitario_producto] FROM [dbo].[View_MarcasProducto] WHERE id_marca = " + id;
            SqlCommand cmd = new SqlCommand(strQuery);
            DataTable data = GetData(cmd);

            productDropD.Items.Clear();
            productDropD.DataSource = data;
            productDropD.DataTextField = "fullProduct";
            productDropD.DataValueField = "precioUnitario_producto";
            productDropD.DataBind();

            //Product 2
            productDropD2.Items.Clear();
            productDropD2.DataSource = data;
            productDropD2.DataTextField = "fullProduct";
            productDropD2.DataValueField = "precioUnitario_producto";
            productDropD2.DataBind();

            //Product 3
            productDropD3.Items.Clear();
            productDropD3.DataSource = data;
            productDropD3.DataTextField = "fullProduct";
            productDropD3.DataValueField = "precioUnitario_producto";
            productDropD3.DataBind();

            //Product 4
            productDropD4.Items.Clear();
            productDropD4.DataSource = data;
            productDropD4.DataTextField = "fullProduct";
            productDropD4.DataValueField = "precioUnitario_producto";
            productDropD4.DataBind();

            //Product 5
            productDropD5.Items.Clear();
            productDropD5.DataSource = data;
            productDropD5.DataTextField = "fullProduct";
            productDropD5.DataValueField = "precioUnitario_producto";
            productDropD5.DataBind();

            //Product 6
            productDropD6.Items.Clear();
            productDropD6.DataSource = data;
            productDropD6.DataTextField = "fullProduct";
            productDropD6.DataValueField = "precioUnitario_producto";
            productDropD6.DataBind();

            //Product 7
            productDropD7.Items.Clear();
            productDropD7.DataSource = data;
            productDropD7.DataTextField = "fullProduct";
            productDropD7.DataValueField = "precioUnitario_producto";
            productDropD7.DataBind();

            //Product 8
            productDropD8.Items.Clear();
            productDropD8.DataSource = data;
            productDropD8.DataTextField = "fullProduct";
            productDropD8.DataValueField = "precioUnitario_producto";
            productDropD8.DataBind();

            //Product 9
            productDropD9.Items.Clear();
            productDropD9.DataSource = data;
            productDropD9.DataTextField = "fullProduct";
            productDropD9.DataValueField = "precioUnitario_producto";
            productDropD9.DataBind();
        }

        private void BindProductDropDown()
        {
            // make sure m_UserBinds have something
            if (m_UserBinds == null)
            {
                if (Session["UserBinds"] != null)
                    m_UserBinds = Session["UerBinds"] as string[];
                else
                    m_UserBinds = Global.getUserBinds();
            }

            string strQuery = "SELECT [id_producto] ,CONCAT([nombre_producto], ' / $', [precioUnitario_producto]) AS fullProduct, [precioUnitario_producto] FROM [dbo].[View_MarcasProducto] WHERE id_marca = " + Convert.ToInt32(m_UserBinds[0]);
            SqlCommand cmd = new SqlCommand(strQuery);
            DataTable data = GetData(cmd);

            productDropD.DataSource = data;
            productDropD.DataTextField = "fullProduct";
            productDropD.DataValueField = "precioUnitario_producto";
            productDropD.DataBind();

            //Product 2
            productDropD2.DataSource = data;
            productDropD2.DataTextField = "fullProduct";
            productDropD2.DataValueField = "precioUnitario_producto";
            productDropD2.DataBind();

            //Product 3
            productDropD3.DataSource = data;
            productDropD3.DataTextField = "fullProduct";
            productDropD3.DataValueField = "precioUnitario_producto";
            productDropD3.DataBind();

            //Product 4
            productDropD4.DataSource = data;
            productDropD4.DataTextField = "fullProduct";
            productDropD4.DataValueField = "precioUnitario_producto";
            productDropD4.DataBind();

            //Product 5
            productDropD5.DataSource = data;
            productDropD5.DataTextField = "fullProduct";
            productDropD5.DataValueField = "precioUnitario_producto";
            productDropD5.DataBind();

            //Product 6
            productDropD6.DataSource = data;
            productDropD6.DataTextField = "fullProduct";
            productDropD6.DataValueField = "precioUnitario_producto";
            productDropD6.DataBind();

            //Product 7
            productDropD7.DataSource = data;
            productDropD7.DataTextField = "fullProduct";
            productDropD7.DataValueField = "precioUnitario_producto";
            productDropD7.DataBind();

            //Product 8
            productDropD8.DataSource = data;
            productDropD8.DataTextField = "fullProduct";
            productDropD8.DataValueField = "precioUnitario_producto";
            productDropD8.DataBind();

            //Product 9
            productDropD9.DataSource = data;
            productDropD9.DataTextField = "fullProduct";
            productDropD9.DataValueField = "precioUnitario_producto";
            productDropD9.DataBind();
        }

        private void BindTypeDropDown()
        {
            string strQuery = "SELECT [id_tipo] ,[nombre_tipo], [aumentoPorcentaje_tipo] FROM [dbo].[Tipos]";
            SqlCommand cmd = new SqlCommand(strQuery);
            DataTable data = GetData(cmd);

            typeDropD.DataSource = data;
            typeDropD.DataTextField = "nombre_tipo";
            typeDropD.DataValueField = "aumentoPorcentaje_tipo";
            typeDropD.DataBind();

            //Type 2
            typeDropD2.DataSource = data;
            typeDropD2.DataTextField = "nombre_tipo";
            typeDropD2.DataValueField = "aumentoPorcentaje_tipo";
            typeDropD2.DataBind();

            //Type 3
            typeDropD3.DataSource = data;
            typeDropD3.DataTextField = "nombre_tipo";
            typeDropD3.DataValueField = "aumentoPorcentaje_tipo";
            typeDropD3.DataBind();

            //Type 4
            typeDropD4.DataSource = data;
            typeDropD4.DataTextField = "nombre_tipo";
            typeDropD4.DataValueField = "aumentoPorcentaje_tipo";
            typeDropD4.DataBind();

            //Type 5
            typeDropD5.DataSource = data;
            typeDropD5.DataTextField = "nombre_tipo";
            typeDropD5.DataValueField = "aumentoPorcentaje_tipo";
            typeDropD5.DataBind();

            //Type 6
            typeDropD6.DataSource = data;
            typeDropD6.DataTextField = "nombre_tipo";
            typeDropD6.DataValueField = "aumentoPorcentaje_tipo";
            typeDropD6.DataBind();

            //Type 7
            typeDropD7.DataSource = data;
            typeDropD7.DataTextField = "nombre_tipo";
            typeDropD7.DataValueField = "aumentoPorcentaje_tipo";
            typeDropD7.DataBind();

            //Type 8
            typeDropD8.DataSource = data;
            typeDropD8.DataTextField = "nombre_tipo";
            typeDropD8.DataValueField = "aumentoPorcentaje_tipo";
            typeDropD8.DataBind();

            //Type 9
            typeDropD9.DataSource = data;
            typeDropD9.DataTextField = "nombre_tipo";
            typeDropD9.DataValueField = "aumentoPorcentaje_tipo";
            typeDropD9.DataBind();
        }

        private void BindPromotionsDropDown()
        {
            string strQuery = "SELECT [id] ,[nombre] FROM [dbo].[Promociones]";
            SqlCommand cmd = new SqlCommand(strQuery);
            promotionsDropD.DataSource = GetData(cmd);
            promotionsDropD.DataTextField = "nombre";
            promotionsDropD.DataValueField = "nombre";
            promotionsDropD.DataBind();
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

            con.Dispose();
            con.Close();
            sda.Dispose();
            return dt;
        }

        protected void clientsGrid_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(clientsGrid, "Select$" + e.Row.RowIndex);
                e.Row.Attributes["style"] = "cursor:pointer";
            }
        }

        protected void lastBuysGrid_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.Cells[2].Text == "Entregado &amp; pagado")
                {
                    e.Row.CssClass = "success";
                    return;
                }
                else
                {
                    e.Row.CssClass = "danger";
                }
            }
        }

        protected void clientsGrid_SelectedIndexChanged(object sender, EventArgs e)
        {
            //int index = clientsGrid.SelectedRow.RowIndex;
            //m_id = Convert.ToInt32(clientsGrid.SelectedRow.Cells[0].Text);
            firstName.Text = clientsGrid.SelectedRow.Cells[1].Text;
            lastName.Text = clientsGrid.SelectedRow.Cells[2].Text;
            phone.Text = clientsGrid.SelectedRow.Cells[3].Text;
            mobile.Text = clientsGrid.SelectedRow.Cells[4].Text;
            plano.Text = clientsGrid.SelectedRow.Cells[5].Text;
            city.Text = clientsGrid.SelectedRow.Cells[6].Text;
            colony.Text = clientsGrid.SelectedRow.Cells[7].Text;
            street.Text = clientsGrid.SelectedRow.Cells[8].Text;
            betStreets.Text = clientsGrid.SelectedRow.Cells[9].Text;
            dirNumber.Text = clientsGrid.SelectedRow.Cells[10].Text;
            postalCode.Text = clientsGrid.SelectedRow.Cells[11].Text;

            if (clientsGrid.SelectedRow.Cells[12].Text == "&nbsp;")
                dirRef.Text = "";
            else
                dirRef.Text = clientsGrid.SelectedRow.Cells[12].Text;

            if (clientsGrid.SelectedRow.Cells[13].Text == "&nbsp;")
                dirRef.Text = "";
            else
                dirRef.Text = clientsGrid.SelectedRow.Cells[13].Text;
            dirNotes.Text = "";

            // Unselect all items before
            foreach (ListItem item in this.ruteDropD.Items)
            {
                item.Selected = false;
            }
            ruteDropD.Items.FindByValue(clientsGrid.SelectedRow.Cells[14].Text).Selected = true;

            // Check if client has special Shipping
            if (clientsGrid.SelectedRow.Cells[15].Text == "1")
            {
                if (clientsGrid.SelectedRow.Cells[16].Text == "0")
                    shipbox.Attributes.Remove("checked");
                else
                {
                    shipbox.Attributes.Add("checked", "true");
                    shippingPrice.Value = clientsGrid.SelectedRow.Cells[16].Text;
                }
            }

            // Check if client has special discount
            if (clientsGrid.SelectedRow.Cells[17].Text == "1")
            {
                discdivRow.Visible = true;
                divRowHr.Visible = true;
                discbox.Attributes.Add("checked", "true");
                discPrice.Value = clientsGrid.SelectedRow.Cells[18].Text;
            }

            //Set readonly
            firstName.ReadOnly = true;
            lastName.ReadOnly = true;
            phone.ReadOnly = true;
            mobile.ReadOnly = true;
            plano.ReadOnly = true;
            city.ReadOnly = true;
            colony.ReadOnly = true;
            street.ReadOnly = true;
            betStreets.ReadOnly = true;
            dirNumber.ReadOnly = true;
            postalCode.ReadOnly = true;
            ruteDropD.Enabled = false;
            dirRef.ReadOnly = true;
            dirNotes.ReadOnly = true;

            // Dont render contactRef
            refContactDiv.Visible = false;

            // Set isClient attr
            isClient.Value = "1";
            clientID.Value = clientsGrid.SelectedRow.Cells[0].Text;
            cleanSpan.Visible = true;

            Page.ClientScript.RegisterStartupScript(this.GetType(), "collapse", "$('#infoClientSpan').click(); $('#dirClientSpan').click();", true);
            Page.ClientScript.RegisterStartupScript(this.GetType(), "addPanelHeadingColors", "$('#clientDivPanel').removeClass('panel-default').addClass('panel-primary'); "
                                                                                + "$('#dirDivPanel').removeClass('panel-default').addClass('panel-primary');", true);
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "setReadOnly", "$('#ruteDropD').prop('disabled', true)", true);

            // Show last 3 buys
            ShowRecentclientActivity();

            // Labels [Cliente nuevo -> Cliente Registrado]
            // Deprecated due to fit wrapping issues
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "addLabels", "$('#clientLabel').text('Cliente registrado').removeClass('label-default').addClass('label-success'); "
            //                                                                    + "$('#dirLabel').text('Cliente registrado').removeClass('label-default').addClass('label-success');", true);
        }

        private void ShowRecentclientActivity()
        {
            //Bind with lastName criteria
            string strQuery = "SELECT TOP 3 id_pedido, notas_orden,"
                                + "producto_orden, tipoProducto_orden, cantidadProducto_orden, producto2_orden, tipoProducto2_orden, cantidadProducto2_orden, producto3_orden, tipoProducto3_orden, cantidadProducto3_orden, "
                                + "producto4_orden, tipoProducto4_orden, cantidadProducto4_orden, producto5_orden, tipoProducto5_orden, cantidadProducto5_orden, producto6_orden, tipoProducto6_orden, cantidadProducto6_orden, "
                                + "producto7_orden, tipoProducto7_orden, cantidadProducto7_orden, producto8_orden, tipoProducto8_orden, cantidadProducto8_orden, producto9_orden, tipoProducto9_orden, cantidadProducto9_orden, "
                                +"totalProductos_orden, "
                                +"CAST(DAY(fechaEntrega_orden) AS VARCHAR(2)) + ' ' + DATENAME(MM, fechaEntrega_orden) + ' ' + CAST(YEAR(fechaEntrega_orden) AS VARCHAR(4)) AS fechaEntrega_orden, "
                                +"status_orden FROM [dbo].[Pedido] WHERE id_cliente = @clientId ORDER BY fechaAbrio_orden DESC";
            SqlCommand cmd = new SqlCommand(strQuery);

            string searchMobile = string.Format("%{0}%", mobile.Text.Trim());
            cmd.Parameters.AddWithValue("@clientId", Convert.ToInt32(clientID.Value));

            var a = GetData(cmd);

            lastBuysGrid.DataSource = GetData(cmd);
            lastBuysGrid.DataBind();

            //lastBuysDiv.Attributes["class"].Replace("hidden", "");
            Page.ClientScript.RegisterStartupScript(this.GetType(), "showClientActivity", "$('#lastBuysDiv').removeClass('hidden');", true);

        }

        protected void firstNameSearch_Click(object sender, EventArgs e)
        {
            if (Session["CheckRefresh"].ToString() == ViewState["CheckRefresh"].ToString())
            {
                //Bind with lastName criteria
                string strQuery = "SELECT * FROM [dbo].[Clientes] WHERE nombre_cliente LIKE @firstName";
                SqlCommand cmd = new SqlCommand(strQuery);

                string searchFirstName = string.Format("%{0}%", firstName.Text.Trim());
                cmd.Parameters.AddWithValue("@firstName", searchFirstName);

                clientsGrid.DataSource = GetData(cmd);
                clientsGrid.DataBind();

                Page.ClientScript.RegisterStartupScript(this.GetType(), "showModal", "$('#modalClientsGrid').modal('show');", true);
                Session["CheckRefresh"] = Server.UrlDecode(System.DateTime.Now.ToString());
            }
        }

        protected void lastNameSearch_Click(object sender, EventArgs e)
        {
            if (Session["CheckRefresh"].ToString() == ViewState["CheckRefresh"].ToString())
            {
                //Bind with lastName criteria
                string strQuery = "SELECT * FROM [dbo].[Clientes] WHERE apellido_cliente LIKE @lastName";
                SqlCommand cmd = new SqlCommand(strQuery);

                string searchLastName = string.Format("%{0}%", lastName.Text.Trim());
                cmd.Parameters.AddWithValue("@lastName", searchLastName);

                clientsGrid.DataSource = GetData(cmd);
                clientsGrid.DataBind();

                Page.ClientScript.RegisterStartupScript(this.GetType(), "func", "$('#modalClientsGrid').modal('show');", true);
                Session["CheckRefresh"] = Server.UrlDecode(System.DateTime.Now.ToString());
            }
        }

        protected void phoneSearch_Click(object sender, EventArgs e)
        {
            if (Session["CheckRefresh"].ToString() == ViewState["CheckRefresh"].ToString())
            {
                //Bind with lastName criteria
                string strQuery = "SELECT * FROM [dbo].[Clientes] WHERE telefono_cliente LIKE @phone";
                SqlCommand cmd = new SqlCommand(strQuery);

                string searchPhone = string.Format("%{0}%", phone.Text.Trim());
                cmd.Parameters.AddWithValue("@phone", searchPhone);

                clientsGrid.DataSource = GetData(cmd);
                clientsGrid.DataBind();

                Page.ClientScript.RegisterStartupScript(this.GetType(), "func", "$('#modalClientsGrid').modal('show');", true);
                Session["CheckRefresh"] = Server.UrlDecode(System.DateTime.Now.ToString());
            }
        }

        protected void mobileSearch_Click(object sender, EventArgs e)
        {
            if (Session["CheckRefresh"].ToString() == ViewState["CheckRefresh"].ToString())
            {
                //Bind with lastName criteria
                string strQuery = "SELECT * FROM [dbo].[Clientes] WHERE movil_cliente LIKE @mobile";
                SqlCommand cmd = new SqlCommand(strQuery);

                string searchMobile = string.Format("%{0}%", mobile.Text.Trim());
                cmd.Parameters.AddWithValue("@mobile", searchMobile);

                clientsGrid.DataSource = GetData(cmd);
                clientsGrid.DataBind();

                Page.ClientScript.RegisterStartupScript(this.GetType(), "func", "$('#modalClientsGrid').modal('show');", true);
                Session["CheckRefresh"] = Server.UrlDecode(System.DateTime.Now.ToString());
            }
        }

        /*
         * Submit handling
         */
        protected void submitBtn_Click(object sender, EventArgs e)
        {
            if (Session["CheckRefresh"].ToString() == ViewState["CheckRefresh"].ToString())
            {
                if (isClient.Value == "1")
                {
                    UpdateClientAndRequest();
                    
                }
                else
                {
                    InsertClientAndRequest();
                }

            }
        }

        /*
         * Already registered client
         */
        private void UpdateClientAndRequest()
        {
            var s = Request.Form.AllKeys;

            var connection = new SqlConnection(connectionString);

            /*
             * [dbo].[Clientes] 
             * Registered client UPDATE
             */
            string query_updateClient = "UPDATE Clientes SET cantidad_compras = cantidad_compras + 1 WHERE id_cliente = @m_id";

            try
            {
                SqlCommand command = new SqlCommand(query_updateClient, connection);
                command.Parameters.AddWithValue("@m_id", Convert.ToInt32(Request.Form.Get(f_clientID)));

                connection.Open();
                command.ExecuteNonQuery();
                command.Parameters.Clear();
                command.Dispose();
                //connection.Close();
            }
            catch (SqlException s_exp)
            {
                messagesText.Attributes["class"] = "alert alert-danger alert-dismissable";
                lblMessage.Text = s_exp.ToString();
                panelMessage.Visible = true;
            }

            /*
             * [dbo].[Pedido] 
             * New request INSERT
             */
            string query_insertRequest = "INSERT INTO Pedido "
                + "(id_cliente, id_distribuidor, fechaEntrega_orden, horarioEntrega_orden, pagoCon_orden, formaPago_orden, marca_orden, "
                + "producto_orden, tipoProducto_orden, cantidadProducto_orden, producto2_orden, tipoProducto2_orden, cantidadProducto2_orden, producto3_orden, tipoProducto3_orden, cantidadProducto3_orden, producto4_orden, tipoProducto4_orden, cantidadProducto4_orden, "
                + "producto5_orden, tipoProducto5_orden, cantidadProducto5_orden, producto6_orden, tipoProducto6_orden, cantidadProducto6_orden, producto7_orden, tipoProducto7_orden, cantidadProducto7_orden, producto8_orden, tipoProducto8_orden, cantidadProducto8_orden, producto9_orden, tipoProducto9_orden, cantidadProducto9_orden, "
                + "promocion_orden, promocion_referencia, status_orden, tiempoEstimado, notas_orden, fechaAbrio_orden, totalProductos_orden, "
                + "subTotalProducto_orden, subTotalProducto2_orden, subTotalProducto3_orden, subTotalProducto4_orden, subTotalProducto5_orden, subTotalProducto6_orden, subTotalProducto7_orden, subTotalProducto8_orden, subTotalProducto9_orden, "
                + "precioProducto_orden, precioProducto2_orden, precioProducto3_orden, precioProducto4_orden, precioProducto5_orden, precioProducto6_orden, precioProducto7_orden, precioProducto8_orden, precioProducto9_orden, precioEnvio_orden, descuentoEnvio_orden, subTotalProductos_orden) "
                + "VALUES(@clientID, @distID, @orderDate, @deliveringTime, @qtyPay, @payMethod, @brand, "
                + "@product, @type, @qtyProduct, @product2, @type2, @qtyProduct2, @product3, @type3, @qtyProduct3, @product4, @type4, @qtyProduct4, @product5, @type5, @qtyProduct5, @product6, @type6, @qtyProduct6, @product7, @type7, @qtyProduct7, @product8, @type8, @qtyProduct8, @product9, @type9, @qtyProduct9, "
                + "@promotion, @refPromo, @status, @estimatedTime, @reqNotes, @orderOpenDate, @totalProductPrice, @subtotalProduct, @subtotalProduct2, @subtotalProduct3, @subtotalProduct4, @subtotalProduct5, @subtotalProduct6, @subtotalProduct7, @subtotalProduct8, @subtotalProduct9, "
                + "@unitPriceProduct, @unitPriceProduct2, @unitPriceProduct3, @unitPriceProduct4, @unitPriceProduct5, @unitPriceProduct6, @unitPriceProduct7, @unitPriceProduct8, @unitPriceProduct9, @shippingPrice, @discPrice, @subTotalProducts)";

            /*
             * Set datetimes variables
             * estimatedTime: Sum days to orderDate for notify purposes
             * formatOrderDate: For parsing f_orderDate and assing to DateTime orderDate obj
             * orderDate: DateTime parsed from f_orderDate Field string
             * totalProductPrice: Double
             */

            // Handle estimatedTime null or empty
            int estimatedTime;
            if (String.IsNullOrWhiteSpace(Request.Form.Get(f_estimatedTime)))
                estimatedTime = 0;
            else
                estimatedTime = Convert.ToInt32(Request.Form.Get(f_estimatedTime));

            // Handle orderDate null or empty
            DateTime orderDate;
            DateTimeFormatInfo formatOrderDate = new DateTimeFormatInfo();
            formatOrderDate.ShortDatePattern = "dd-MM-yyyy";
            formatOrderDate.DateSeparator = "-";
            orderDate = Convert.ToDateTime(Request.Form.Get(f_orderDate), formatOrderDate);

            //Handle qtyPay null or empty
            double qtyPay;
            if (String.IsNullOrWhiteSpace(Request.Form.Get(f_qtyPay)))
                qtyPay = 0;
            else
                qtyPay = Convert.ToDouble(Request.Form.Get(f_qtyPay));

            // Handle ProductPrice
            double totalProductPrice;
            if (String.IsNullOrEmpty(Request.Form.Get(f_totalProductPrice)))
                totalProductPrice = 0.0;
            else
                totalProductPrice = Convert.ToDouble(Request.Form.Get(f_totalProductPrice));

            // make sure m_UserBinds have something
            if (m_UserBinds == null)
            {
                if (Session["UserBinds"] != null)
                    m_UserBinds = Session["UerBinds"] as string[];
                else
                    m_UserBinds = Global.getUserBinds();
            }

            // Set special ship price if the case
            int specialShipping = 0;
            if (shipbox.Checked)
                specialShipping = 1;

            try
            {
                SqlCommand command = new SqlCommand(query_insertRequest, connection);
                command.Parameters.AddWithValue("@clientID", Convert.ToInt32(Request.Form.Get(f_clientID)));
                command.Parameters.AddWithValue("@distID", m_UserBinds[1]);
                command.Parameters.AddWithValue("@orderDate", orderDate); //Date
                command.Parameters.AddWithValue("@deliveringTime", Request.Form.Get(f_deliveringTime));
                command.Parameters.AddWithValue("@qtyPay", qtyPay);
                command.Parameters.AddWithValue("@payMethod", Request.Form.Get(f_payMethod));

                // If admin, use selected brand, else use Session[UserBinds]
                if (true)
                    command.Parameters.AddWithValue("@brand", brandDropD.SelectedItem.Text.Trim());
                else
                    command.Parameters.AddWithValue("@brand", m_UserBinds[2]);
                //command.Parameters.AddWithValue("@brand", Request.Form.Get(f_brand));

                //command.Parameters.AddWithValue("@product", Request.Form.Get(f_product));
                //command.Parameters.AddWithValue("@type", Request.Form.Get(f_type));
                command.Parameters.AddWithValue("@product", productDropD.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@type", typeDropD.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@qtyProduct", Convert.ToInt32(Request.Form.Get(f_qtyProduct)));

                command.Parameters.AddWithValue("@product2", productDropD2.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@type2", typeDropD2.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@qtyProduct2", Convert.ToInt32(Request.Form.Get(f_qtyProduct2)));

                command.Parameters.AddWithValue("@product3", productDropD3.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@type3", typeDropD3.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@qtyProduct3", Convert.ToInt32(Request.Form.Get(f_qtyProduct3)));

                command.Parameters.AddWithValue("@product4", productDropD4.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@type4", typeDropD4.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@qtyProduct4", Convert.ToInt32(Request.Form.Get(f_qtyProduct4)));

                command.Parameters.AddWithValue("@product5", productDropD5.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@type5", typeDropD5.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@qtyProduct5", Convert.ToInt32(Request.Form.Get(f_qtyProduct5)));

                command.Parameters.AddWithValue("@product6", productDropD6.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@type6", typeDropD6.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@qtyProduct6", Convert.ToInt32(Request.Form.Get(f_qtyProduct6)));

                command.Parameters.AddWithValue("@product7", productDropD7.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@type7", typeDropD7.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@qtyProduct7", Convert.ToInt32(Request.Form.Get(f_qtyProduct7)));

                command.Parameters.AddWithValue("@product8", productDropD8.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@type8", typeDropD8.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@qtyProduct8", Convert.ToInt32(Request.Form.Get(f_qtyProduct8)));

                command.Parameters.AddWithValue("@product9", productDropD9.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@type9", typeDropD9.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@qtyProduct9", Convert.ToInt32(Request.Form.Get(f_qtyProduct9)));

                command.Parameters.AddWithValue("@promotion", Request.Form.Get(f_promotion));
                //command.Parameters.AddWithValue("@refContact", Request.Form.Get(f_refContacto));
                command.Parameters.AddWithValue("@refPromo", Request.Form.Get(f_refPromo));
                command.Parameters.AddWithValue("@status", "Programado"); //Request.Form.Get(f_status)
                command.Parameters.AddWithValue("@estimatedTime", orderDate.AddDays(estimatedTime)); //Date
                command.Parameters.AddWithValue("@reqNotes", Request.Form.Get(f_reqNotes));
                command.Parameters.AddWithValue("@orderOpenDate", DateTime.Now); //Datetime
                command.Parameters.AddWithValue("@totalProductPrice", totalProductPrice);

                command.Parameters.AddWithValue("@subtotalProduct", Convert.ToDouble(Request.Form.Get(f_productPrice)));
                command.Parameters.AddWithValue("@subtotalProduct2", Convert.ToDouble(Request.Form.Get(f_productPrice2)));
                command.Parameters.AddWithValue("@subtotalProduct3", Convert.ToDouble(Request.Form.Get(f_productPrice3)));
                command.Parameters.AddWithValue("@subtotalProduct4", Convert.ToDouble(Request.Form.Get(f_productPrice4)));
                command.Parameters.AddWithValue("@subtotalProduct5", Convert.ToDouble(Request.Form.Get(f_productPrice5)));
                command.Parameters.AddWithValue("@subtotalProduct6", Convert.ToDouble(Request.Form.Get(f_productPrice6)));
                command.Parameters.AddWithValue("@subtotalProduct7", Convert.ToDouble(Request.Form.Get(f_productPrice7)));
                command.Parameters.AddWithValue("@subtotalProduct8", Convert.ToDouble(Request.Form.Get(f_productPrice8)));
                command.Parameters.AddWithValue("@subtotalProduct9", Convert.ToDouble(Request.Form.Get(f_productPrice9)));

                command.Parameters.AddWithValue("@unitPriceProduct", Convert.ToDouble(Request.Form.Get(f_unitPriceProduct)));
                command.Parameters.AddWithValue("@unitPriceProduct2", Convert.ToDouble(Request.Form.Get(f_unitPriceProduct2)));
                command.Parameters.AddWithValue("@unitPriceProduct3", Convert.ToDouble(Request.Form.Get(f_unitPriceProduct3)));
                command.Parameters.AddWithValue("@unitPriceProduct4", Convert.ToDouble(Request.Form.Get(f_unitPriceProduct4)));
                command.Parameters.AddWithValue("@unitPriceProduct5", Convert.ToDouble(Request.Form.Get(f_unitPriceProduct5)));
                command.Parameters.AddWithValue("@unitPriceProduct6", Convert.ToDouble(Request.Form.Get(f_unitPriceProduct6)));
                command.Parameters.AddWithValue("@unitPriceProduct7", Convert.ToDouble(Request.Form.Get(f_unitPriceProduct7)));
                command.Parameters.AddWithValue("@unitPriceProduct8", Convert.ToDouble(Request.Form.Get(f_unitPriceProduct8)));
                command.Parameters.AddWithValue("@unitPriceProduct9", Convert.ToDouble(Request.Form.Get(f_unitPriceProduct9)));

                command.Parameters.AddWithValue("@shippingPrice", Convert.ToDouble(finalshippingPrice.Value));
                command.Parameters.AddWithValue("@discPrice", Convert.ToDouble(finaldiscPrice.Value));
                command.Parameters.AddWithValue("@subTotalProducts", Convert.ToDouble(finalSubTotalPrice.Value));

                //connection.Open();
                command.ExecuteNonQuery(); // Get instered row ID

                command.Parameters.Clear();
                command.Dispose();
                connection.Close();

                Session["success"] = true;
                Response.Redirect("Pedido.aspx"); // Fix POST method when refreshing
            }
            catch (SqlException s_exp)
            {
                messagesText.Attributes["class"] = "alert alert-danger alert-dismissable";
                lblMessage.Text = s_exp.ToString();
                panelMessage.Visible = true;

                // Rollback client buy
                string query_rollBackClient = "UPDATE Clientes SET cantidad_compras = cantidad_compras - 1 WHERE id_cliente = @m_id";
                SqlCommand command = new SqlCommand(query_rollBackClient, connection);
                command.Parameters.AddWithValue("@m_id", Convert.ToInt32(Request.Form.Get(f_clientID)));

                //connection.Open();
                command.ExecuteNonQuery();
                command.Parameters.Clear();
                command.Dispose();
                connection.Close();
            }
        }

        /*
         * New client
         * This will register in [dbo].[Clientes]
         */
        private void InsertClientAndRequest()
        {
            int insertedID = 0;
            var connection = new SqlConnection(connectionString);

            /*
             * [dbo].[Clientes] 
             * New client INSERT
             */
            string query_insertClient = "INSERT INTO Clientes "
                +"(id_ruta, nombre_cliente, apellido_cliente, telefono_cliente, movil_cliente, plano_cliente, "
                + "ciudad_cliente, colonia_cliente, calle_cliente, entreCalles_cliente, numeroDir_cliente, postal_cliente, notas_cliente, referencias_direccion_cliente, formaContacto_cliente, cantidad_compras) "
                +"VALUES (@ruteId, @firstName, @lastName, @phone, @mobile, @plano, "
                +"@city, @colony, @street, @betStreets, @dirNumber, @postalCode, @dirNotes, @dirRefs, @contactRef, @buys); "
                +"SELECT CAST(scope_identity() AS int)";

            try
            {
                SqlCommand command = new SqlCommand(query_insertClient, connection);
                command.Parameters.AddWithValue("@ruteId", Convert.ToInt32(ruteDropD.SelectedValue));
                command.Parameters.AddWithValue("@firstName", CultureInfo.CurrentCulture.TextInfo.ToTitleCase(HttpUtility.HtmlDecode(firstName.Text)));
                command.Parameters.AddWithValue("@lastName", CultureInfo.CurrentCulture.TextInfo.ToTitleCase(HttpUtility.HtmlDecode(lastName.Text)));
                //command.Parameters.AddWithValue("@firstName", CultureInfo.CurrentCulture.TextInfo.ToTitleCase(Request.Form.Get(f_firstName)));
                //command.Parameters.AddWithValue("@lastName", CultureInfo.CurrentCulture.TextInfo.ToTitleCase(Request.Form.Get(f_lastName)));
                command.Parameters.AddWithValue("@phone", Request.Form.Get(f_phone).Trim());
                command.Parameters.AddWithValue("@mobile", Request.Form.Get(f_mobile).Trim());
                command.Parameters.AddWithValue("@plano", Request.Form.Get(f_plano).Trim().ToUpper());
                command.Parameters.AddWithValue("@city", Request.Form.Get(f_city).Trim());
                command.Parameters.AddWithValue("@colony", Request.Form.Get(f_colony).Trim());
                command.Parameters.AddWithValue("@street", Request.Form.Get(f_street).Trim());
                command.Parameters.AddWithValue("@betStreets", Request.Form.Get(f_betStreets).Trim());
                command.Parameters.AddWithValue("@dirNumber", Request.Form.Get(f_dirNumber).Trim());
                command.Parameters.AddWithValue("@postalCode", Request.Form.Get(f_postalCode));
                command.Parameters.AddWithValue("@dirNotes", Request.Form.Get(f_dirNotes).Trim());
                command.Parameters.AddWithValue("@dirRefs", dirRef.Text.Trim());
                command.Parameters.AddWithValue("@contactRef", refContact.Text.Trim());
                command.Parameters.AddWithValue("@buys", 1); // 1st Buy

                connection.Open();
                insertedID = (Int32)command.ExecuteScalar(); // Get instered row ID

                command.Parameters.Clear();
                command.Dispose();
                //connection.Close();
            }
            catch (SqlException s_exp)
            {
                messagesText.Attributes["class"] = "alert alert-danger alert-dismissable";
                lblMessage.Text = s_exp.ToString();
                panelMessage.Visible = true;
            }

            /*
             * [dbo].[Pedido] 
             * New request INSERT
             */
            string query_insertRequest = "INSERT INTO Pedido "
                + "(id_cliente, id_distribuidor, fechaEntrega_orden, horarioEntrega_orden, pagoCon_orden, formaPago_orden, marca_orden, "
                + "producto_orden, tipoProducto_orden, cantidadProducto_orden, producto2_orden, tipoProducto2_orden, cantidadProducto2_orden, producto3_orden, tipoProducto3_orden, cantidadProducto3_orden, producto4_orden, tipoProducto4_orden, cantidadProducto4_orden, "
                + "producto5_orden, tipoProducto5_orden, cantidadProducto5_orden, producto6_orden, tipoProducto6_orden, cantidadProducto6_orden, producto7_orden, tipoProducto7_orden, cantidadProducto7_orden, producto8_orden, tipoProducto8_orden, cantidadProducto8_orden, producto9_orden, tipoProducto9_orden, cantidadProducto9_orden, "
                + "promocion_orden, promocion_referencia, status_orden, tiempoEstimado, notas_orden, fechaAbrio_orden, totalProductos_orden, "
                + "subTotalProducto_orden, subTotalProducto2_orden, subTotalProducto3_orden, subTotalProducto4_orden, subTotalProducto5_orden, subTotalProducto6_orden, subTotalProducto7_orden, subTotalProducto8_orden, subTotalProducto9_orden, "
                + "precioProducto_orden, precioProducto2_orden, precioProducto3_orden, precioProducto4_orden, precioProducto5_orden, precioProducto6_orden, precioProducto7_orden, precioProducto8_orden, precioProducto9_orden, precioEnvio_orden) "
                + "VALUES(@clientID, @distID, @orderDate, @deliveringTime, @qtyPay, @payMethod, @brand, "
                + "@product, @type, @qtyProduct, @product2, @type2, @qtyProduct2, @product3, @type3, @qtyProduct3, @product4, @type4, @qtyProduct4, @product5, @type5, @qtyProduct5, @product6, @type6, @qtyProduct6, @product7, @type7, @qtyProduct7, @product8, @type8, @qtyProduct8, @product9, @type9, @qtyProduct9, "
                + "@promotion, @refPromo, @status, @estimatedTime, @reqNotes, @orderOpenDate, @totalProductPrice, @subtotalProduct, @subtotalProduct2, @subtotalProduct3, @subtotalProduct4, @subtotalProduct5, @subtotalProduct6, @subtotalProduct7, @subtotalProduct8, @subtotalProduct9, "
                + "@unitPriceProduct, @unitPriceProduct2, @unitPriceProduct3, @unitPriceProduct4, @unitPriceProduct5, @unitPriceProduct6, @unitPriceProduct7, @unitPriceProduct8, @unitPriceProduct9, @shippingPrice)";

            /*
             * Set datetimes variables
             * estimatedTime: Sum days to Datetime.Now for notify purposes
             * formatOrderDate: For parsing f_orderDate and assing to DateTime orderDate obj
             * orderDate: DateTime parsed from f_orderDate Field string
             * totalProductPrice: Double
             */

            // Handle estimatedTime null or empty
            int estimatedTime;
            if (String.IsNullOrWhiteSpace(Request.Form.Get(f_estimatedTime)))
                estimatedTime = 0;
            else
                estimatedTime = Convert.ToInt32(Request.Form.Get(f_estimatedTime));

            // Handle orderDate null or empty
            DateTime orderDate;
            DateTimeFormatInfo formatOrderDate = new DateTimeFormatInfo();
            formatOrderDate.ShortDatePattern = "dd-MM-yyyy";
            formatOrderDate.DateSeparator = "-";
            orderDate = Convert.ToDateTime(Request.Form.Get(f_orderDate), formatOrderDate);

            //Handle qtyPay null or empty
            double qtyPay;
            if (String.IsNullOrWhiteSpace(Request.Form.Get(f_qtyPay)))
                qtyPay = 0;
            else
                qtyPay = Convert.ToDouble(Request.Form.Get(f_qtyPay));

            // Handle ProductPrice
            double totalProductPrice;
            if (String.IsNullOrEmpty(Request.Form.Get(f_totalProductPrice)))
                totalProductPrice = 0.0;
            else
                totalProductPrice = Convert.ToDouble(Request.Form.Get(f_totalProductPrice));

            // make sure m_UserBinds have something
            if (m_UserBinds == null)
            {
                if (Session["UserBinds"] != null)
                    m_UserBinds = Session["UerBinds"] as string[];
                else
                    m_UserBinds = Global.getUserBinds();
            }

            // Set special ship price if the case
            int specialShipping = 0;
            if (shipbox.Checked)
                specialShipping = 1;

            try
            {
                SqlCommand command = new SqlCommand(query_insertRequest, connection);
                command.Parameters.AddWithValue("@clientID", insertedID);
                command.Parameters.AddWithValue("@distID", m_UserBinds[1]);
                command.Parameters.AddWithValue("@orderDate", orderDate); //Date
                command.Parameters.AddWithValue("@deliveringTime", Request.Form.Get(f_deliveringTime));
                command.Parameters.AddWithValue("@qtyPay", qtyPay);
                command.Parameters.AddWithValue("@payMethod", Request.Form.Get(f_payMethod));

                // If admin, use selected brand, else use Session[UserBinds]
                if (true)
                    command.Parameters.AddWithValue("@brand", brandDropD.SelectedItem.Text.Trim());
                else
                    command.Parameters.AddWithValue("@brand", m_UserBinds[2]);
                //command.Parameters.AddWithValue("@brand", Request.Form.Get(f_brand));

                //command.Parameters.AddWithValue("@product", Request.Form.Get(f_product));
                //command.Parameters.AddWithValue("@type", Request.Form.Get(f_type));
                command.Parameters.AddWithValue("@product", productDropD.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@type", typeDropD.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@qtyProduct", Convert.ToInt32(Request.Form.Get(f_qtyProduct)));

                command.Parameters.AddWithValue("@product2", productDropD2.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@type2", typeDropD2.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@qtyProduct2", Convert.ToInt32(Request.Form.Get(f_qtyProduct2)));

                command.Parameters.AddWithValue("@product3", productDropD3.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@type3", typeDropD3.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@qtyProduct3", Convert.ToInt32(Request.Form.Get(f_qtyProduct3)));

                command.Parameters.AddWithValue("@product4", productDropD4.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@type4", typeDropD4.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@qtyProduct4", Convert.ToInt32(Request.Form.Get(f_qtyProduct4)));

                command.Parameters.AddWithValue("@product5", productDropD5.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@type5", typeDropD5.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@qtyProduct5", Convert.ToInt32(Request.Form.Get(f_qtyProduct5)));

                command.Parameters.AddWithValue("@product6", productDropD6.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@type6", typeDropD6.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@qtyProduct6", Convert.ToInt32(Request.Form.Get(f_qtyProduct6)));

                command.Parameters.AddWithValue("@product7", productDropD7.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@type7", typeDropD7.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@qtyProduct7", Convert.ToInt32(Request.Form.Get(f_qtyProduct7)));

                command.Parameters.AddWithValue("@product8", productDropD8.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@type8", typeDropD8.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@qtyProduct8", Convert.ToInt32(Request.Form.Get(f_qtyProduct8)));

                command.Parameters.AddWithValue("@product9", productDropD9.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@type9", typeDropD9.SelectedItem.Text.Split('/')[0].Trim());
                command.Parameters.AddWithValue("@qtyProduct9", Convert.ToInt32(Request.Form.Get(f_qtyProduct9)));

                command.Parameters.AddWithValue("@promotion", Request.Form.Get(f_promotion));
                //command.Parameters.AddWithValue("@refContact", Request.Form.Get(f_refContacto));
                command.Parameters.AddWithValue("@refPromo", Request.Form.Get(f_refPromo));
                command.Parameters.AddWithValue("@status", "Programado"); //Request.Form.Get(f_status)
                command.Parameters.AddWithValue("@estimatedTime", orderDate.AddDays(estimatedTime)); //Date
                command.Parameters.AddWithValue("@reqNotes", Request.Form.Get(f_reqNotes));
                command.Parameters.AddWithValue("@orderOpenDate", DateTime.Now); //Datetime
                command.Parameters.AddWithValue("@totalProductPrice", totalProductPrice);

                command.Parameters.AddWithValue("@subtotalProduct", Convert.ToDouble(Request.Form.Get(f_productPrice)));
                command.Parameters.AddWithValue("@subtotalProduct2", Convert.ToDouble(Request.Form.Get(f_productPrice2)));
                command.Parameters.AddWithValue("@subtotalProduct3", Convert.ToDouble(Request.Form.Get(f_productPrice3)));
                command.Parameters.AddWithValue("@subtotalProduct4", Convert.ToDouble(Request.Form.Get(f_productPrice4)));
                command.Parameters.AddWithValue("@subtotalProduct5", Convert.ToDouble(Request.Form.Get(f_productPrice5)));
                command.Parameters.AddWithValue("@subtotalProduct6", Convert.ToDouble(Request.Form.Get(f_productPrice6)));
                command.Parameters.AddWithValue("@subtotalProduct7", Convert.ToDouble(Request.Form.Get(f_productPrice7)));
                command.Parameters.AddWithValue("@subtotalProduct8", Convert.ToDouble(Request.Form.Get(f_productPrice8)));
                command.Parameters.AddWithValue("@subtotalProduct9", Convert.ToDouble(Request.Form.Get(f_productPrice9)));

                command.Parameters.AddWithValue("@unitPriceProduct", Convert.ToDouble(Request.Form.Get(f_unitPriceProduct)));
                command.Parameters.AddWithValue("@unitPriceProduct2", Convert.ToDouble(Request.Form.Get(f_unitPriceProduct2)));
                command.Parameters.AddWithValue("@unitPriceProduct3", Convert.ToDouble(Request.Form.Get(f_unitPriceProduct3)));
                command.Parameters.AddWithValue("@unitPriceProduct4", Convert.ToDouble(Request.Form.Get(f_unitPriceProduct4)));
                command.Parameters.AddWithValue("@unitPriceProduct5", Convert.ToDouble(Request.Form.Get(f_unitPriceProduct5)));
                command.Parameters.AddWithValue("@unitPriceProduct6", Convert.ToDouble(Request.Form.Get(f_unitPriceProduct6)));
                command.Parameters.AddWithValue("@unitPriceProduct7", Convert.ToDouble(Request.Form.Get(f_unitPriceProduct7)));
                command.Parameters.AddWithValue("@unitPriceProduct8", Convert.ToDouble(Request.Form.Get(f_unitPriceProduct8)));
                command.Parameters.AddWithValue("@unitPriceProduct9", Convert.ToDouble(Request.Form.Get(f_unitPriceProduct9)));

                command.Parameters.AddWithValue("@shippingPrice", Convert.ToDouble(shippingPrice.Value));

                //connection.Open();
                command.ExecuteNonQuery(); // Get instered row ID

                command.Parameters.Clear();
                command.Dispose();
                connection.Close();

                Session["success"] = true;
                Response.Redirect("Pedido.aspx"); // Fix POST method when refreshing
            }
            catch (SqlException s_exp)
            {
                messagesText.Attributes["class"] = "alert alert-danger alert-dismissable";
                lblMessage.Text = s_exp.ToString();
                panelMessage.Visible = true;

                // Rollback client buy
                string query_rollBackClient = "DELETE FROM dbo.Clientes WHERE id_cliente = @clientID";
                SqlCommand command = new SqlCommand(query_rollBackClient, connection);
                command.Parameters.AddWithValue("@clientID", insertedID);

                //connection.Open();
                command.ExecuteNonQuery();
                command.Parameters.Clear();
                command.Dispose();
                connection.Close();
            }
        }

        // Avoid Event Fire
        protected void Page_PreRender(object sender, EventArgs e)
        {
            ViewState["CheckRefresh"] = Session["CheckRefresh"];
        }

        protected void brandDropD_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindAdminProductDropDown(Convert.ToInt32(brandDropD.SelectedValue));
        }

        protected void productDropD_DataBound(object sender, EventArgs e)
        {
            productDropD.Items.Insert(0, new ListItem("Selecciona un producto", "0"));
            productDropD2.Items.Insert(0, new ListItem(String.Empty, "0"));
            productDropD3.Items.Insert(0, new ListItem(String.Empty, "0"));
            productDropD4.Items.Insert(0, new ListItem(String.Empty, "0"));
            productDropD5.Items.Insert(0, new ListItem(String.Empty, "0"));
            productDropD6.Items.Insert(0, new ListItem(String.Empty, "0"));
            productDropD7.Items.Insert(0, new ListItem(String.Empty, "0"));
            productDropD8.Items.Insert(0, new ListItem(String.Empty, "0"));
            productDropD9.Items.Insert(0, new ListItem(String.Empty, "0"));
        }

    }
}