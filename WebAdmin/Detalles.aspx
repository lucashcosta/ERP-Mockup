<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Detalles.aspx.cs" Inherits="WebAdmin.Detalles" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <link href="/css/Pages/invoice.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="/css/jquery.datepick.css"> 
    <%--<link rel="stylesheet" type="text/css" href="/css/ui-hot-sneaks.datepick.css" id="themeTR">
    <link rel="stylesheet" type="text/css" href="http://code.jquery.com/ui/1.10.3/themes/hot-sneaks/jquery-ui.css"> --%>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div id="page-wrapper">
        <div class="row hidden-print">
            <div class="col-lg-12">
                <h1>Consultas <small>Detalles de Pedido</small></h1>
                <ol class="breadcrumb">
                    <li><a href="Dashboard"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                    <li><a href="#"><i class="fa fa-book"></i> Consultas</a></li>
                    <li><a href="ConsultaPedidos"><i class="fa fa-truck"></i> Pedidos</a></li>
                    <li class="active"><i class="fa fa-search-plus"></i> Detalles</li>
                </ol>
            </div>
        </div><!-- /.row Titulo de aspx -->

        <h2 class="hidden-print" id="nav-tabs">Orden <asp:Label runat="server" ID="lbl_lockOrder"></asp:Label></h2>
            <div class="bs-example">
              <ul class="nav nav-tabs hidden-print" style="margin-bottom: 15px;">
                <li class="active"><a href="#detalles" data-toggle="tab">Detalles</a></li>
                <li><a href="#editOrder" data-toggle="tab">Editar orden</a></li>
                <li><a href="#invoice" data-toggle="tab">Invoice</a></li>
              </ul>
              <div id="myTabContent" class="tab-content">
                <div class="tab-pane fade active in" id="detalles">
                    <div class="col-md-6 col-sm-12">
                        <div id="orderDetails" class="panel panel-primary">
                            <div class="panel-heading">
                                <h4 class="panel-title"><i class="fa fa-gears"></i>  Detalles de pedido 
                                    <%--<span id="clientLabel" style="margin-left:10px; margin-bottom:30px;" class="label label-default">Cliente nuevo</span>--%>
                                </h4>
                                <span class="pull-right clickable"><i id="orderDetailsSpan" class="fa fa-chevron-up"></i></span>
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-5 name">
                                        # Orden:
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label runat="server" ID="lbl_orderNumber"></asp:Label>
                                    </div>
                                </div>
                                <p></p>
                                <div class="row">
                                    <div class="col-md-5 name">
                                        Fecha de entrega:
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label runat="server" ID="lbl_orderDate"></asp:Label>
                                    </div>
                                </div>
                                <p></p>
                                <div class="row">
                                    <div class="col-md-5 name">
                                        Horario de entrega:
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label runat="server" ID="lbl_deliveringTime"></asp:Label>
                                    </div>
                                </div>
                                <p></p>
                                <div class="row">
                                    <div class="col-md-5 name">
                                        Status:
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label runat="server" ID="lbl_status"></asp:Label>
                                    </div>
                                </div>
                                <p></p>
                                <div class="row">
                                    <div class="col-md-5 name">
                                        Total Pagado:
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label runat="server" ID="lbl_totalPaidDet"></asp:Label>
                                    </div>
                                </div>
                                <p></p>
                                <div class="row">
                                    <div class="col-md-5 name">
                                        Forma de pago:
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label  runat="server" ID="lbl_payMethod"></asp:Label>
                                    </div>
                                </div>
                                <p></p>
                                <div class="row">
                                    <div class="col-md-5 name">
                                        Marca:
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label  runat="server" ID="lbl_brand"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Shiping -->
                        <div id="shippingAddress" class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title"><i class="fa fa-road"></i>  Direccion de entrega 
                                    <%--<span id="clientLabel" style="margin-left:10px; margin-bottom:30px;" class="label label-default">Cliente nuevo</span>--%>
                                </h4>
                                <span class="pull-right clickable"><i id="shippingAddressSpan" class="fa fa-chevron-up"></i></span>
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-5 name">
                                        Plano
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label runat="server" ID="lbl_plano"></asp:Label>
                                    </div>
                                </div>
                                <p></p>
                                <div class="row">
                                    <div class="col-md-5 name">
                                        Ruta
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label runat="server" ID="lbl_rute"></asp:Label>
                                    </div>
                                </div>
                                <p></p>
                                <div class="row">
                                    <div class="col-md-5 name">
                                        Ciudad:
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label runat="server" ID="lbl_city"></asp:Label>
                                    </div>
                                </div>
                                <p></p>
                                <div class="row">
                                    <div class="col-md-5 name">
                                        Colonia:
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label runat="server" ID="lbl_colony"></asp:Label>
                                    </div>
                                </div>
                                <p></p>
                                <div class="row">
                                    <div class="col-md-5 name">
                                        Calle:
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label runat="server" ID="lbl_street"></asp:Label>
                                    </div>
                                </div>
                                <p></p>
                                <div class="row">
                                    <div class="col-md-5 name">
                                        Numero (direccion):
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label runat="server" ID="lbl_dirNumber"></asp:Label>
                                    </div>
                                </div>
                                <p></p>
                                <div class="row">
                                    <div class="col-md-5 name">
                                        Codigo Postal:
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label runat="server" ID="lbl_postal"></asp:Label>
                                    </div>
                                </div>
                                <p></p>
                                <div class="row">
                                    <div class="col-md-5 name">
                                        Entre calles:
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label runat="server" ID="lbl_betStreets"></asp:Label>
                                    </div>
                                </div>
                                <p></p>
                                <div class="row">
                                    <div class="col-md-5 name">
                                        Referencias de direccion:
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label runat="server" ID="lbl_dirRef"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                  </div>
                    
                    <!-- Next column -->
                    <div class="col-md-6 col-sm-12">
                        <div id="clientInfo" class="panel panel-primary">
                            <div class="panel-heading">
                                <h4 class="panel-title"><i class="fa fa-user"></i>  Informacion del cliente
                                    <%--<span id="clientLabel" style="margin-left:10px; margin-bottom:30px;" class="label label-default">Cliente nuevo</span>--%>
                                </h4>
                                <span class="pull-right clickable"><i id="infoClientSpan" class="fa fa-chevron-up"></i></span>
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-5 name">
                                        # Cliente:
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label runat="server" ID="lbl_clientId"></asp:Label>
                                    </div>
                                </div>
                                <p></p>
                                <div class="row">
                                    <div class="col-md-5 name">
                                        Nombre completo:
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label runat="server" ID="lbl_fullName"></asp:Label>
                                    </div>
                                </div>
                                <p></p>
                                <div class="row">
                                    <div class="col-md-5 name">
                                        Telefono:
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label runat="server" ID="lbl_phone"></asp:Label>
                                    </div>
                                </div>
                                <p></p>
                                <div class="row">
                                    <div class="col-md-5 name">
                                        Movil:
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label runat="server" ID="lbl_mobile"></asp:Label>
                                    </div>
                                </div>
                                <p></p>
                                <div class="row">
                                    <div class="col-md-5 name">
                                        Cantidad de compras:
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label runat="server" ID="lbl_buyQty"></asp:Label>
                                    </div>
                                </div>
                                <p></p>
                                <div class="row">
                                    <div class="col-md-5 name">
                                        Notas:
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label runat="server" ID="lbl_notes"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div runat="server" visible="false" id="holdedOrdersClient" class="panel panel-warning">
                            <div class="panel-heading">
                                <h4 class="panel-title"><i class="fa fa-warning "></i>  Pendientes del cliente
                                    <%--<span id="clientLabel" style="margin-left:10px; margin-bottom:30px;" class="label label-default">Cliente nuevo</span>--%>
                                </h4>
                                <span class="pull-right clickable"><i id="holdedOrdersClientSpan" class="fa fa-chevron-up"></i></span>
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-12 name">
                                        <asp:Label Font-Bold="true" runat="server" ID="lbl_headHold"></asp:Label>
                                    </div>
                                </div>
                                <p></p>
                                <asp:PlaceHolder runat="server" ID="place_bodyHols">

                                </asp:PlaceHolder>
                                <%--<div class="row">
                                    <div class="col-md-5 name">
                                        Tiempo estimado para volver a notificar despues de que se abrio la orden:
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label runat="server" ID="lbl_estimatedTime"></asp:Label>
                                    </div>
                                </div>--%>
                            </div>
                        </div>
                        <div id="refInfo" class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title"><i class="fa fa-comments-o"></i>  Referencias
                                    <%--<span id="clientLabel" style="margin-left:10px; margin-bottom:30px;" class="label label-default">Cliente nuevo</span>--%>
                                </h4>
                                <span class="pull-right clickable"><i id="refInfoSpan" class="fa fa-chevron-up"></i></span>
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-5 name">
                                        Fecha que se abrio la orden:
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label runat="server" ID="lbl_openOrderDate"></asp:Label>
                                    </div>
                                </div>
                                <p></p>
                                <div class="row">
                                    <div class="col-md-5 name">
                                        Referencia de promocion:
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label runat="server" ID="lbl_refPromotion"></asp:Label>
                                    </div>
                                </div>
                                <p></p>
                                <div class="row">
                                    <div class="col-md-5 name">
                                        Contacto:
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label runat="server" ID="lbl_refContact"></asp:Label>
                                    </div>
                                </div>
                                <p></p>
                                <%--<div class="row">
                                    <div class="col-md-5 name">
                                        Tiempo estimado para volver a notificar despues de que se abrio la orden:
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label runat="server" ID="lbl_estimatedTime"></asp:Label>
                                    </div>
                                </div>--%>
                                <p></p>
                                <div class="row">
                                    <div class="col-md-5 name">
                                        Notas de la orden:
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label runat="server" ID="lbl_orderNotes"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                  </div>

                    <!-- Bottom panel -->
                    <div class="col-md-12 col-sm-12">
                        <div id="shoppingCart" class="panel panel-success">
                            <div class="panel-heading">
                                <h4 class="panel-title"><i class="fa fa-shopping-cart"></i>  Carrito
                                    <%--<span id="clientLabel" style="margin-left:10px; margin-bottom:30px;" class="label label-default">Cliente nuevo</span>--%>
                                </h4>
                                <span class="pull-right clickable"><i id="shoppingCartSpan" class="fa fa-chevron-up"></i></span>
                            </div>
                            <div class="panel-body">
                                <div class="table-responsive">
                                <asp:GridView ID="shopppingGrid" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered table-striped table-hover">
                                    <Columns>
                                        <asp:BoundField ItemStyle-Width = "150px"
                                         DataField = "Producto" HeaderText = "Producto" />
                                        <asp:BoundField ItemStyle-Width = "150px"
                                         DataField = "Tipo" HeaderText = "Tipo" />
                                        <asp:BoundField ItemStyle-Width = "150px" ItemStyle-Font-Bold="true"
                                         DataField = "Precio" HeaderText = "Precio" />
                                        <asp:BoundField ItemStyle-Width = "150px"
                                         DataField = "Cantidad" HeaderText = "Cantidad" />
                                        <asp:BoundField ItemStyle-Width = "150px" ItemStyle-Font-Bold="true"
                                         DataField = "Total" HeaderText = "Total" />
                                   </Columns>
                                </asp:GridView>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <!-- aligning next div [Wells] -->
                        </div>
                        <div class="col-md-6">
                            <div class="well">
                                <div class="row">
                                    <div class="col-md-5 name">
                                        Promocion:
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label runat="server" ID="lbl_promotion"></asp:Label>
                                    </div>
                                </div>
                                <p></p>
                                <div class="row">
                                    <div class="col-md-5 name">
                                        Subtotal:
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label runat="server" ID="lbl_subTotal"></asp:Label>
                                    </div>
                                </div>
                                <p></p>
                                <div class="row" runat="server" id="lbl_discRow" visible="false">
                                    <div class="col-md-5 name">
                                        Descuento:
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label runat="server" ID="lbl_disc"></asp:Label>
                                    </div>
                                </div>
                                <p></p>
                                <div class="row">
                                    <div class="col-md-5 name">
                                        Envío:
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label runat="server" ID="lbl_shippingPrice"></asp:Label>
                                    </div>
                                </div>
                                <p></p>
                                <div class="row">
                                    <div class="col-md-5 name">
                                        Gran total:
                                    </div>
                                    <div class="col-md-7 value">
                                        <asp:Label runat="server" ClientIDMode="Static" ID="lbl_total"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                  </div>
                </div>
                <div class="tab-pane fade" id="invoice">
                    <asp:Panel runat="server" ClientIDMode="Static" ID="contentInvoice">
                    <div class="invoice">
				    <div class="row invoice-logo">
					    <div class="col-xs-6 invoice-logo-space">
						    <%--<img style="height:50px; max-width:150px" src="/Images/Sample/Invoice/evalogo.png" alt=""/>--%>
					    </div>
					    <div class="col-xs-6">
						    <p>
                                <asp:Label Font-Size="26px" runat="server" ID="inv_idReq"></asp:Label>
							    <span class="muted">
								     #Pedido
							    </span>
						    </p>
					    </div>
				    </div>
				<hr/>
				<div class="row">
					<div class="col-xs-4">
						<h4>Cliente:</h4>
						<ul class="list-unstyled">
							<li>
								 <asp:Label Font-Size="13px" runat="server" ID="inv_idClient"></asp:Label>
							</li>
							<li>
								 <asp:Label Font-Size="13px" runat="server" ID="inv_clientName"></asp:Label>
							</li>
							<li>
								 <asp:Label Font-Size="13px" runat="server" ID="inv_clientCity"></asp:Label>
							</li>
							<li>
								 <asp:Label Font-Size="13px" runat="server" ID="inv_clientAddress"></asp:Label>
							</li>
							<li>
								 <asp:Label Font-Size="13px" runat="server" ID="inv_clientPostal"></asp:Label>
							</li>
							<li>
								 <asp:Label Font-Size="13px" runat="server" ID="inv_clientPhone"></asp:Label>
							</li>
                            <li>
								 <asp:Label Font-Size="13px" runat="server" ID="inv_clientMobile"></asp:Label>
							</li>
						</ul>
					</div>
					<div class="col-xs-4">
                        <!-- Next div position -->
					</div>
					<div class="col-xs-4 invoice-payment" style="text-align: right;">
						<h4>Detalles:</h4>
						<ul class="list-unstyled">
                            <li>
								<strong style="font-size:13px">Distribuidor:</strong> <asp:Label Font-Size="13px" runat="server" ID="inv_distName"></asp:Label>
							</li>
							<li>
								<strong style="font-size:13px">Forma de pago:</strong> <asp:Label Font-Size="13px" runat="server" ID="inv_payMethod"></asp:Label>
							</li>
							<li>
								<strong style="font-size:13px">Fecha de pedido:</strong> <asp:Label Font-Size="13px" runat="server" ID="inv_orderOpenDate"></asp:Label>
							</li>
							<li>
								<strong style="font-size:13px">Fecha de entrega:</strong> <asp:Label Font-Size="13px" runat="server" ID="inv_orderDate"></asp:Label>
							</li>
						</ul>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12">
                        <div>
                        <asp:GridView Font-Size="Small" ID="invoiceGrid" runat="server" AutoGenerateColumns="false" RowStyle-BorderWidth="0px" EditRowStyle-BorderWidth="0px" CssClass="table table-striped table-hover">
                            <Columns>
                                <asp:BoundField ItemStyle-Width = "40px"
                                    DataField = "Numero" HeaderText= "#" />
                                <asp:BoundField ItemStyle-Width = "90px"
                                    DataField = "Producto" HeaderText = "Producto" />
                                <asp:BoundField ItemStyle-Width = "80px"
                                    DataField = "Tipo" HeaderText = "Tipo" />
                                <asp:BoundField ItemStyle-Width = "70px" ItemStyle-Font-Bold="true"
                                    DataField = "Precio" HeaderText = "Precio" />
                                <asp:BoundField ItemStyle-Width = "60px"
                                    DataField = "Cantidad" HeaderText = "Cantidad" />
                                <asp:BoundField ItemStyle-Width = "50px" ItemStyle-Font-Bold="true"
                                    DataField = "Total" HeaderText = "Total" />
                            </Columns>
                        </asp:GridView>
                        </div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-4">
						<div class="well">
							<address>
							<strong>Distribuidor</strong><br/>
                                <asp:Label Font-Size="13px" runat="server" ID="inv_distDir"></asp:Label>
							</address>
						</div>
					</div>
					<div class="col-xs-8 invoice-block">
						<ul class="list-unstyled amounts">
							<li runat="server" id="inv_promoLi">
								<strong>Promocion:</strong> <asp:Label Font-Size="13px" runat="server" ID="inv_promo"></asp:Label>
							</li>
                            <li runat="server">
								<strong>Subtotal:</strong> <asp:Label Font-Size="13px" runat="server" ID="inv_subTotal"></asp:Label>
							</li>
                            <li runat="server" visible="false" id="inv_discPriceLi">
								<strong>Descuento:</strong> <asp:Label Font-Size="13px" runat="server" ID="inv_discPrice"></asp:Label>
							</li>
                            <li>
								<strong>Envío:</strong> <asp:Label Font-Size="13px" runat="server" ID="inv_shippingPrice"></asp:Label>
							</li>
							<li>
								<strong>Gran Total:</strong> <asp:Label Font-Size="13px" runat="server" ID="inv_grandTotal"></asp:Label>
							</li>
						</ul>
						<br/>
                        <%--<a class="btn btn-lg btn-primary hidden-print" onclick="return getPrint();">--%>
						<%--<a class="btn btn-lg btn-primary hidden-print" onclick="javascript:window.print();">
							 Print <i class="fa fa-print"></i>
						</a>--%>
						<%--<a class="btn btn-lg green hidden-print">
							 Submit Invoice <i class="fa fa-check"></i>
						</a>--%>
					</div>
				</div>
			</div>
                        </asp:Panel>
                </div>
                  <!-- End Invoice -->

                  <!-- Start Close/Edit Order -->
                  <div class="tab-pane fade" id="editOrder">
                      <div class="col-lg-12">
                        <div id="orderEdit" class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title"><i class="fa fa-exchange"></i>  Orden 
                                    <%--<span id="clientLabel" style="margin-left:10px; margin-bottom:30px;" class="label label-default">Cliente nuevo</span>--%>
                                </h4>
                                <span class="pull-right clickable"><i id="orderEditSpan" class="fa fa-chevron-up"></i></span>
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-4 name">
                                        Status:
                                    </div>
                                    <div class="col-md-8 value">
                                        <asp:DropDownList runat="server" AutoPostBack="false" ClientIDMode="Static" CssClass="form-control status" ID="edit_status">
                                            <asp:ListItem >Programado</asp:ListItem>
                                            <asp:ListItem >Cancelado</asp:ListItem>
                                            <asp:ListItem >En ruta</asp:ListItem>
                                            <asp:ListItem >Entregado & pagado</asp:ListItem>
                                            <asp:ListItem >Entregado & no pagado</asp:ListItem>
                                            <asp:ListItem >Pagado & no entregado</asp:ListItem>
                                            <asp:ListItem >Pendiente</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <p></p>
                                <div class="row">
                                    <div class="col-md-4 name">
                                        Fecha de entrega:
                                    </div>
                                    <div class="col-md-8 value">
                                        <asp:TextBox TextMode="Date" ClientIDMode="Static" ID="edit_OrderDate" name="edit_orderDate" runat="server" class="form-control" placeholder="Fechad de la orden"></asp:TextBox>
                                    </div>
                                </div>
                                <p></p>
                                <div class="row">
                                    <div class="col-md-4 name">
                                        Total Pagado:
                                    </div>
                                    <div class="col-md-8 value">
                                        <asp:TextBox runat="server" ID="edit_qtyPaid" CssClass="form-control qtyPaid" ClientIDMode="Static" onkeypress="return isNumberKey(event);"></asp:TextBox>
                                    </div>
                                </div>
                                <p></p>
                                <div class="row">
                                    <div class="col-md-4 name">
                                        Forma de pago:
                                    </div>
                                    <div class="col-md-8 value">
                                        <asp:DropDownList ClientIDMode="Static" AppendDataBoundItems=True ID="edit_payMethod" runat="server" CssClass="form-control" >
                                            <asp:ListItem>Efectivo</asp:ListItem>
                                            <asp:ListItem>Cretido</asp:ListItem>
                                            <asp:ListItem>Consignacion</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <p></p>
                                <div class="row">
                                    <div class="col-md-4 name">
                                        Notas:
                                    </div>
                                    <div class="col-md-8 value">
                                        <asp:TextBox TextMode="MultiLine" runat="server" ID="lbl_edit_notes" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <p></p>
                                <asp:LinkButton CssClass="pull-right btn btn-success" runat="server" id="submitBtn" Text="Sumbit" ForeColor="White" OnClientClick="return ValidateForm();" OnClick="submitBtn_Click"></asp:LinkButton>
                            </div>
                        </div>
                  </div>
                  </div>
              </div>
            </div>

        <script src="js/modernizr.custom.js" type="text/javascript"></script>
        <script type="text/javascript" src="js/jquery.plugin.min.js"></script> 
        <script type="text/javascript" src="js/jquery.datepick.js"></script>
        <script type="text/javascript" src="js/jquery.datepick-es.js"></script>
        <script>

            if (!Modernizr.touch || !Modernizr.inputtypes.date) {
                //alert("called");
                //$('#edit_OrderDate').datepick({ dateFormat: "dd/mm/yy" });                

                $('#edit_OrderDate').datepick($.extend({
                    renderer: $.datepick.themeRollerRenderer,
                    altFormat: 'DD, d MM, yyyy'
                },
                $.datepick.regionalOptions['es']));
            }
            

            $(document).on('click', '.panel-heading span.clickable', function (e) {
                var $this = $(this);
                if (!$this.hasClass('panel-collapsed')) {
                    $this.parents('.panel').find('.panel-body').slideUp();
                    $this.addClass('panel-collapsed');
                    $this.find('i').removeClass('fa-chevron-up').addClass('fa-chevron-down');
                } else {
                    $this.parents('.panel').find('.panel-body').slideDown();
                    $this.removeClass('panel-collapsed');
                    $this.find('i').removeClass('fa-chevron-down').addClass('fa-chevron-up');
                }
            })

            function isNumberKey(evt) {
                var charCode = (evt.which) ? evt.which : event.keyCode;
                if (charCode != 46 && charCode > 31
                  && (charCode < 48 || charCode > 57))
                    return false;

                return true;
            }

            $("#edit_status").change(function () {
                if (($('#edit_status').val() == "Entregado & pagado" || $('#edit_status').val() == "Pagado & no entregado")) {
                    $('#edit_qtyPaid').val($("#lbl_total").text().substring(1));
                }
                else {
                    $('#edit_qtyPaid').val("");
                }
            });

            // Print invoice
            function getPrint() {
                //Creating new page
                var pp = window.open();
                //Adding HTML opening tag with <HEAD> ?</HEAD> portion
                pp.document.writeln('<HTML><HEAD><title>Title</title><LINK href=StyleSheet.css  type="text/css" rel="stylesheet">')
                pp.document.writeln('<LINK href=PrintStyle.css  type="text/css" rel="stylesheet" media="print"><base target="_self"></HEAD>')
                //Adding Body Tag
                pp.document.writeln('<body MS_POSITIONING="GridLayout" bottomMargin="0" leftMargin="0" topMargin="0" rightMargin="0">');
                //Adding form Tag
                pp.document.writeln('<form  method="post">');
                //Creating two buttons Print and Close within a table
                pp.document.writeln('<TABLE width=100%><TR><TD></TD></TR><TR><TD align=right><INPUT ID="PRINT" type="button" value="Print" onclick="javascript:location.reload(true);window.print();"><INPUT ID="CLOSE" type="button" value="Close" onclick="window.close();"></TD></TR><TR><TD></TD></TR></TABLE>');
                //Writing print area of the calling page
                pp.document.writeln(document.getElementById(print_area).innerHTML);
                //Ending Tag of </form>, </body> and </HTML>
                pp.document.writeln('</form></body></HTML>');


            }

            function ValidateForm() {
                if ($('#edit_OrderDate').val().trim().length == 0) {
                    alert("Introduce una fecha");
                    return false
                }

                if (($('#edit_status').val() == "Entregado & pagado" || $('#edit_status').val() == "Pagado & no entregado") && $('#edit_qtyPaid').val().trim().length == 0) {
                    alert("Introduce cantidad de pago");
                    return false;
                }
            }

            // Tooltips
            $(document).ready(function () {
                $("[rel=tooltip]").tooltip({ placement: 'left' });
            });
            // Tooltips
            $(document).ready(function () {
                $("[rel=tooltip-top]").tooltip({ placement: 'top' });
            });

        </script>
    </div>
</asp:Content>
