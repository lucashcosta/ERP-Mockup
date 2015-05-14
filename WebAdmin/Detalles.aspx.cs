using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace WebAdmin
{
    public partial class Detalles : System.Web.UI.Page
    {
        private const int QTY_ITEMS = 10;
        int id;
        int thisClientId;
        DataTable req_Info;
        DataTable dt = new DataTable(); // Used to fill shopping carts
        DataTable unlcokedOrders;
        string req_Status;
        string req_StatusClass;

        string[] req_Products = new string[QTY_ITEMS];
        string[] req_typeProducts = new string[QTY_ITEMS];
        int[] req_QtyProducts = new int[QTY_ITEMS];
        double[] req_subtotalProducts = new double[QTY_ITEMS];
        double[] req_unitProductPrices = new double[QTY_ITEMS];
        string[,] shoppingCart;
        string[,] invCart;

        private String connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                // Avoid event fire on refresh
                Session["CheckRefresh"] = Server.UrlDecode(System.DateTime.Now.ToString());

                id = Convert.ToInt32(Request.QueryString["Id"]);

                // Fill datable
                SqlCommand cmd;
                string strQuery = "SELECT * FROM [dbo].[View_ClientesPedido] WHERE id_pedido = @id";
                cmd = new SqlCommand(strQuery);
                cmd.Parameters.AddWithValue("@id", id);
                req_Info = GetData(cmd);

                if (req_Info.Rows.Count > 0)
                    thisClientId = req_Info.Rows[0].Field<int>("id_cliente");

                // Fill datable
                strQuery = "SELECT * FROM [dbo].[View_ClientesPedido] WHERE id_cliente = @id AND locked_pedido = @open ORDER BY [fechaAbrio_orden] DESC";
                cmd = new SqlCommand(strQuery);
                cmd.Parameters.AddWithValue("@id", thisClientId);
                cmd.Parameters.AddWithValue("@open", 0);
                unlcokedOrders = GetData(cmd);

                if (unlcokedOrders.Rows.Count > 0)
                {
                    holdedOrdersClient.Visible = true;
                    FillclientUnlcokedOrders();
                }

                // Fill order
                if (req_Info.Rows.Count > 0)
                {
                    HandleReqStatus();
                    SetItems();
                    FillOrder();
                    
                }
            }
        }

        private void FillclientUnlcokedOrders()
        {
            for (int i = 0; i < unlcokedOrders.Rows.Count; i++)
            {
                if (unlcokedOrders.Rows[i].Field<int>("id_pedido").Equals(id))
                {
                    unlcokedOrders.Rows[i].Delete();
                    unlcokedOrders.AcceptChanges();
                }
            }

            if (unlcokedOrders.Rows.Count == 1)
                lbl_headHold.Text = "El cliente tiene una orden pendiente";
            else
                lbl_headHold.Text = "El cliente tiene " + unlcokedOrders.Rows.Count + " ordenes pendientes";

            Label order;

            // Create HTML
            for (int i = 0; i < unlcokedOrders.Rows.Count; i++)
            {
                DateTime holdOrderDate = unlcokedOrders.Rows[i].Field<DateTime>("fechaEntrega_orden");
                place_bodyHols.Controls.Add(new LiteralControl("<div class=\"row\">"));
                place_bodyHols.Controls.Add(new LiteralControl("    <div class=\"col-md-5 name\">"));
                place_bodyHols.Controls.Add(new LiteralControl("    " + holdOrderDate.ToString("D").First().ToString().ToUpper() + String.Join("", holdOrderDate.ToString("D").Skip(1))));
                place_bodyHols.Controls.Add(new LiteralControl("    </div>")); // /.div class="col-md-5"
                place_bodyHols.Controls.Add(new LiteralControl("    <div class=\"col-md-7 value\">"));

                order = new Label();
                place_bodyHols.Controls.Add(new LiteralControl("    <a href=\"Detalles.aspx?Id=" + unlcokedOrders.Rows[i].Field<int>("id_pedido").ToString() + " \" >"));
                order.Text = unlcokedOrders.Rows[i].Field<int>("id_pedido").ToString() + "</a>";
                order.Font.Bold = true;
                order.Attributes.Add("rel", "tooltip-top");
                order.Attributes.Add("title", unlcokedOrders.Rows[i].Field<string>("notas_orden"));
                place_bodyHols.Controls.Add(order);
                
                //lbl_promotion.Text = " <span class=\"label label-warning\">" + promotion + "</span>";
                order = new Label();
                order.Text = " <span class=\"label " + HandleReqStatus(unlcokedOrders.Rows[i].Field<string>("status_orden")) + " \">" + unlcokedOrders.Rows[i].Field<string>("status_orden") + "</span>";
                place_bodyHols.Controls.Add(order);

                place_bodyHols.Controls.Add(new LiteralControl("    </div>"));// /.div class="col-md-7"
                place_bodyHols.Controls.Add(new LiteralControl("</div>")); // /.row
            }
        }

        // Methods
        private void FillOrder()
        {
            /*
             * Ways to get data from DataTable:
             * req_Info.Rows[0]["Column"] -> Doesnt handle nullable types
             * req_Info.Rows[0].Field<int>("id_pedido") -> Handle nullable types
             */

            int lockedOrder = req_Info.Rows[0].Field<int>("locked_pedido");
            string fa_lock;
            string text_lock;
            if (lockedOrder == 0)
            {
                fa_lock = "fa-unlock";
                text_lock = "Orden Abierta";
                lbl_lockOrder.Attributes["class"] = "label label-default pull-right";
            }
            else 
            {
                fa_lock = "fa-lock";
                text_lock = "Orden Cerrada";
                lbl_lockOrder.Attributes["class"] = "label label-success pull-right";
            }
            lbl_lockOrder.Text = "<i class=\"fa " + fa_lock + " \"></i>  " + text_lock;

            // Order Details
            DateTime orderDate = req_Info.Rows[0].Field<DateTime>("fechaEntrega_orden");

            lbl_orderNumber.Text = req_Info.Rows[0].Field<int>("id_pedido").ToString();
            lbl_orderDate.Text = orderDate.ToString("D").First().ToString().ToUpper() + String.Join("", orderDate.ToString("D").Skip(1));
            lbl_deliveringTime.Text = req_Info.Rows[0].Field<string>("horarioEntrega_orden");
            lbl_status.Text = " <span class=\"label " + req_StatusClass + " \">" + req_Status + "</span>";
            lbl_totalPaidDet.Text = "$" + req_Info.Rows[0].Field<double?>("pagoCon_orden").ToString();
            lbl_payMethod.Text = req_Info.Rows[0].Field<string>("formaPago_orden");
            lbl_brand.Text = " <span class=\"label label-primary \">" + req_Info.Rows[0].Field<string>("marca_orden") + "</span>";

            // Client Info
            lbl_clientId.Text = req_Info.Rows[0].Field<int>("id_cliente").ToString();
            lbl_fullName.Text = req_Info.Rows[0].Field<string>("nombre_cliente") + " " + req_Info.Rows[0].Field<string>("apellido_cliente");
            lbl_phone.Text = req_Info.Rows[0].Field<string>("telefono_cliente");
            lbl_mobile.Text = req_Info.Rows[0].Field<string>("movil_cliente");
            lbl_buyQty.Text = req_Info.Rows[0].Field<int>("cantidad_compras").ToString();
            lbl_notes.Text = req_Info.Rows[0].Field<string>("notas_cliente");

            // Shipping Address
            lbl_rute.Text = req_Info.Rows[0].Field<string>("nombre_ruta");
            lbl_plano.Text = req_Info.Rows[0].Field<string>("plano_cliente");
            lbl_city.Text = req_Info.Rows[0].Field<string>("ciudad_cliente");
            lbl_colony.Text = req_Info.Rows[0].Field<string>("colonia_cliente");
            lbl_street.Text = req_Info.Rows[0].Field<string>("calle_cliente");
            lbl_dirNumber.Text = req_Info.Rows[0].Field<string>("numeroDir_cliente");
            lbl_postal.Text = req_Info.Rows[0].Field<string>("postal_cliente");
            lbl_betStreets.Text = req_Info.Rows[0].Field<string>("entreCalles_cliente");
            lbl_dirRef.Text = req_Info.Rows[0].Field<string>("referencias_direccion_cliente");

            // Shopping Cart
            BindShoppingCart();

            // Refs
            DateTime openOrderDate = req_Info.Rows[0].Field<DateTime>("fechaAbrio_orden");
            lbl_openOrderDate.Text = openOrderDate.ToString("D").First().ToString().ToUpper() + String.Join("", openOrderDate.ToString("D").Skip(1));
            lbl_refPromotion.Text = req_Info.Rows[0].Field<string>("promocion_referencia");
            lbl_refContact.Text = req_Info.Rows[0].Field<string>("contacto_referencia");
            lbl_orderNotes.Text = req_Info.Rows[0].Field<string>("notas_orden");

            // Total sum Well
            string promotion;
            if (String.IsNullOrEmpty(req_Info.Rows[0].Field<string>("promocion_orden")))
            {
                promotion = "No";
                inv_promoLi.Visible = false;
            }
            else
            {
                promotion = req_Info.Rows[0].Field<string>("promocion_orden");
                
            }
            lbl_promotion.Text = " <span class=\"label label-warning\">" + promotion + "</span>";
            
            
            // if discount exists on orden
            int discPrice;
            if (req_Info.Rows[0].Field<int?>("descuentoEnvio_orden") != 0)
            {
                if (req_Info.Rows[0].Field<int?>("descuentoEnvio_orden") == null)
                    return;

                discPrice = req_Info.Rows[0].Field<int>("descuentoEnvio_orden");

                // Set fields visibles
                inv_discPriceLi.Visible = true;
                lbl_discRow.Visible = true;

                //Set details text and invoice text
                lbl_disc.Text = discPrice.ToString() + "%";
                inv_discPrice.Text = lbl_disc.Text;
            }

            double shippingPrice = req_Info.Rows[0].Field<double>("precioEnvio_orden");
            double total = req_Info.Rows[0].Field<double>("totalProductos_orden");
            double subtotal = req_Info.Rows[0].Field<double>("subTotalProductos_orden");
            lbl_subTotal.Text = "$" + subtotal.ToString("#.##");
            
            lbl_shippingPrice.Text = "$" + shippingPrice.ToString();
            lbl_total.Text = "$" + total.ToString("#.##");

            /*
             * Filling Invoice
             */
            inv_idReq.Text = "#" + lbl_orderNumber.Text;

            // Invoice Client
            inv_idClient.Text = lbl_clientId.Text;
            inv_clientName.Text = lbl_fullName.Text;
            inv_clientCity.Text = lbl_city.Text;
            inv_clientAddress.Text = lbl_colony.Text + ", " + lbl_street.Text + " " + lbl_dirNumber.Text;
            inv_clientPostal.Text = lbl_postal.Text;
            inv_clientPhone.Text = "<i class=\"fa fa-phone\"></i>  " + lbl_phone.Text;
            inv_clientMobile.Text = "<i class=\"fa fa-mobile icon-fix\"></i>  " + lbl_mobile.Text;

            // Detalles
            inv_payMethod.Text = lbl_payMethod.Text;
            inv_orderOpenDate.Text = lbl_openOrderDate.Text;
            inv_orderDate.Text = lbl_orderDate.Text;
            inv_distName.Text = req_Info.Rows[0].Field<string>("nombre_distribuidor");

            // Dist
            inv_distDir.Text = req_Info.Rows[0].Field<string>("direccion_distribuidor").Replace("\n", "<br/>");

            BindInvoiceCart();

            inv_promo.Text = lbl_promotion.Text;
            inv_subTotal.Text = subtotal.ToString("#.##");
            inv_shippingPrice.Text = lbl_shippingPrice.Text;
            inv_grandTotal.Text = total.ToString("#.##");

            // Set status to edit tab
            edit_status.SelectedValue = req_Status;
            // Set payMethod to edit tab
            edit_payMethod.SelectedValue = lbl_payMethod.Text;
            // Set orderDate to edit tab
            edit_OrderDate.Text = orderDate.ToString("yyyy-MM-dd");
            // Set paid placeholder to edit tab
            edit_qtyPaid.Attributes["placeholder"] = lbl_totalPaidDet.Text;
        }

        private void BindShoppingCart()
        {
            shoppingCart = new string[req_Products.Length, 5];
            for (int i = 0; i < req_Products.Length; i++)
            {
                shoppingCart[i, 0] = req_Products[i];
                shoppingCart[i, 1] = req_typeProducts[i];
                shoppingCart[i, 2] = req_unitProductPrices[i].ToString("#.##");
                shoppingCart[i, 3] = req_QtyProducts[i].ToString();
                shoppingCart[i, 4] = req_subtotalProducts[i].ToString("#.##");
            }

            dt.Columns.Add("Producto");
            dt.Columns.Add("Tipo");
            dt.Columns.Add("Precio");
            dt.Columns.Add("Cantidad");
            dt.Columns.Add("Total");
            for (int i = 0; i < req_Products.Length; i++)
            {
                dt.Rows.Add();
                dt.Rows[i]["Producto"] = shoppingCart[i, 0];
                dt.Rows[i]["Tipo"] = shoppingCart[i, 1];
                dt.Rows[i]["Precio"] = "$" + shoppingCart[i, 2];
                dt.Rows[i]["Cantidad"] = shoppingCart[i, 3];
                dt.Rows[i]["Total"] = "$" + shoppingCart[i, 4];
            }
            shopppingGrid.DataSource = dt;
            shopppingGrid.DataBind();
        }

        private void BindInvoiceCart()
        {
            invCart = new string[req_Products.Length, 6];
            dt.Columns.Add("Numero");
            for (int i = 0; i < req_Products.Length; i++)
            {
                dt.Rows[i]["Numero"] = (i + 1).ToString();
            }

            invoiceGrid.DataSource = dt;
            invoiceGrid.DataBind();
            dt.Dispose();
            dt.Clear();
        }

        private void HandleReqStatus()
        {
            req_Status = req_Info.Rows[0].Field<string>("status_orden");

            if (req_Status.Equals("Programado"))
            {
                req_StatusClass = "label label-primary";
                return;
            }

            if (req_Status.Equals("Pendiente"))
            {
                req_StatusClass = "label label-warning";
                return;
            }

            if (req_Status.Equals("Cancelado"))
            {
                req_StatusClass = "label label-danger";
                return;
            }

            if (req_Status.Equals("Entregado & pagado"))
            {
                req_StatusClass = "label label-success";
                return;
            }

            if (req_Status.Equals("Entregado & no pagado"))
            {
                req_StatusClass = "label label-danger";
                return;
            }

            if (req_Status.Equals("No atendido"))
            {
                req_StatusClass = "label label-danger";
                return;
            }

            if (req_Status.Equals("Pagado & no entregado"))
            {
                req_StatusClass = "label label-info";
                return;
            }

            if (req_Status.Equals("En ruta"))
            {
                req_StatusClass = "label label-info";
                return;
            }
        }

        private string HandleReqStatus(string status)
        {
            string CssClass = "label label-default";

            if (status.Equals("Programado"))
            {
                CssClass = "label label-primary";
                return CssClass;
            }

            if (status.Equals("Pendiente"))
            {
                CssClass = "label label-warning";
                return CssClass;
            }

            if (status.Equals("Cancelado"))
            {
                CssClass = "label label-danger";
                return CssClass;
            }

            if (status.Equals("Entregado & pagado"))
            {
                CssClass = "label label-success";
                return CssClass;
            }

            if (status.Equals("Entregado & no pagado"))
            {
                CssClass = "label label-danger";
                return CssClass;
            }

            if (status.Equals("Pagado & no entregado"))
            {
                CssClass = "label label-info";
                return CssClass;
            }

            if (status.Equals("En ruta"))
            {
                CssClass = "label label-info";
                return CssClass;
            }

            return CssClass;
        }

        // Optimize this with List<> maybe?
        private void SetItems()
        {
            int n = 1, i = 2;
            // Get first product -> type -> qty -> subtotal -> unit price
            req_Products[0] = req_Info.Rows[0].Field<string>("producto_orden");
            req_typeProducts[0] = req_Info.Rows[0].Field<string>("tipoProducto_orden");
            req_QtyProducts[0] = req_Info.Rows[0].Field<int>("cantidadProducto_orden");
            req_subtotalProducts[0] = req_Info.Rows[0].Field<double>("subTotalProducto_orden");
            req_unitProductPrices[0] = req_Info.Rows[0].Field<double>("precioProducto_orden");

            for (i = 2; i < QTY_ITEMS; i++)
            {
                if (req_Info.Rows[0].Field<string>("producto" + i + "_orden").Length <= 0)
                    break;
                req_Products[n] = req_Info.Rows[0].Field<string>("producto" + i + "_orden");
                req_typeProducts[n] = req_Info.Rows[0].Field<string>("tipoProducto" + i + "_orden");
                req_unitProductPrices[n] = req_Info.Rows[0].Field<double>("precioProducto" + i + "_orden");
                req_QtyProducts[n] = req_Info.Rows[0].Field<int>("cantidadProducto" + i + "_orden");
                req_subtotalProducts[n] = req_Info.Rows[0].Field<double>("subTotalProducto" + i + "_orden");
                n++;
            }

            // Cleaning arrays
            req_Products = req_Products.Where(x => !string.IsNullOrEmpty(x)).ToArray();
            req_typeProducts = req_typeProducts.Where(x => !string.IsNullOrEmpty(x)).ToArray();
            Array.Resize(ref req_QtyProducts, req_Products.Length);
            Array.Resize(ref req_subtotalProducts, req_Products.Length);
            Array.Resize(ref req_unitProductPrices, req_Products.Length);
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

        protected void submitBtn_Click(object sender, EventArgs e)
        {
            if (Session["CheckRefresh"].ToString() == ViewState["CheckRefresh"].ToString())
            {
                string status = edit_status.SelectedValue;
                string orderDate = edit_OrderDate.Text;
                string totalPaid = edit_qtyPaid.Text;
                string payMethod = edit_payMethod.SelectedValue;
                int lockOrder = 0;
                if (status.ToLower() == "entregado & pagado" || status.ToLower() == "cancelado") 
                    lockOrder = 1;

                UpdateOrder(status, orderDate, totalPaid, payMethod, lockOrder, lbl_edit_notes.Text);

                Response.Redirect("Detalles.aspx?Id=" + Request.QueryString["Id"]);
            }
        }

        private void UpdateOrder(string status, string orderDate, string totalPaid, string payMethod, int lockOrder, string orderNotes)
        {
            var connection = new SqlConnection(connectionString);
            connection.Open();
            string sql_update = "UPDATE Pedido SET status_orden = @newStatus, fechaEntrega_orden = @newOrderDate, pagoCon_orden = @newPaid, formaPago_orden = @newPayMethod, locked_pedido = @lockOrder, notas_orden = @orderNotes WHERE id_pedido = @id"; // Update Desc only

            try
            {
                SqlCommand command = new SqlCommand(sql_update, connection);
                command.Parameters.AddWithValue("@newStatus", status);
                command.Parameters.AddWithValue("@newOrderDate", orderDate);
                command.Parameters.AddWithValue("@newPaid", totalPaid);
                command.Parameters.AddWithValue("@newPayMethod", payMethod);
                command.Parameters.AddWithValue("@id", Request.QueryString["Id"]);
                command.Parameters.AddWithValue("@lockOrder", lockOrder);
                command.Parameters.AddWithValue("@orderNotes", orderNotes);

                command.ExecuteNonQuery();
                command.Parameters.Clear();
                command.Dispose();
                connection.Close();
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

        protected void Page_PreRender(object sender, EventArgs e)
        {
            ViewState["CheckRefresh"] = Session["CheckRefresh"];
        }
    }
}