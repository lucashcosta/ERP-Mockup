<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Detalles.aspx.cs" Inherits="WebAdmin.Detalles" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <link href="/css/Pages/invoice.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="/css/jquery.datepick.css"> 
    <%--<link rel="stylesheet" type="text/css" href="/css/ui-hot-sneaks.datepick.css" id="themeTR">
    <link rel="stylesheet" type="text/css" href="http://code.jquery.com/ui/1.10.3/themes/hot-sneaks/jquery-ui.css"> --%>

    <style type="text/css">

    input[type="number"] {
        width:50px;
    }

    </style>

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
                                <span title="Edit order" class="pull-right editable"><i id="editCartSpan" class="fa fa-pencil pull-right"></i></span>
                                <span title="Save" class="pull-right editable cancelable hidden"><i id="saveCartSpan" class="fa fa-save pull-right"></i></span>
                                <span title="Cancel" style="margin-right: 66px" class="pull-right editable cancelable hidden"><i id="cancelCartSpan" class="fa fa-times pull-right"></i></span>
                            </div>
                            <div class="panel-body" style="padding: 0px;">
                                <div class="table-responsive">
                                <asp:GridView ID="shopppingGrid" ClientIDMode="Static" runat="server" AutoGenerateColumns="false" CssClass="table table-responsive table-bordered table-striped table-hover table-panelfit">
                                    <Columns>
                                        <asp:TemplateField ItemStyle-Width="100px" ItemStyle-CssClass="menu hidden" HeaderStyle-CssClass="menu hidden" >
                                            <HeaderTemplate>
                                                Total
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <button type="button" class=" add-edit btn btn-success btn-xs">
                                                    <i class="fa fa-plus"></i>
                                                </button>
                                                <button type="button" class="remove-edit btn btn-danger btn-xs">
                                                    <i class="fa fa-minus"></i>
                                                </button>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-CssClass="ignore">
                                            <HeaderTemplate>
                                                Producto
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                               <%--<asp:LinkButton runat="server" ForeColor="White" CssClass="btn btn-xs btn-info" CommandName="Select" Font-Underline="false" Font-Overline="false" Font-Size="Small"><i class="fa fa-search-plus icon-white icon-fix"></i> Detalles</asp:LinkButton>--%>
                                                <div class="default">
                                                  <%# Eval("Producto") %>
                                                </div>  
                                                    <select class="menu product-menu hidden">
                                                    </select>
                                                <%--<span class="label label-default"><asp:LinkButton runat="server" ><i class="fa fa-book icon-fix"></i> Check</asp:LinkButton></span>--%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-CssClass="ignore">
                                            <HeaderTemplate>
                                                Tipo
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                               <%--<asp:LinkButton runat="server" ForeColor="White" CssClass="btn btn-xs btn-info" CommandName="Select" Font-Underline="false" Font-Overline="false" Font-Size="Small"><i class="fa fa-search-plus icon-white icon-fix"></i> Detalles</asp:LinkButton>--%>
                                                <div class="default">
                                                  <%# Eval("Tipo") %>
                                                </div>  
                                                    <select class="type-menu menu hidden">
                                                    </select>
                                                <%--<span class="label label-default"><asp:LinkButton runat="server" ><i class="fa fa-book icon-fix"></i> Check</asp:LinkButton></span>--%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-CssClass="ignore" >
                                            <HeaderTemplate>
                                                Precio
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                               <%--<asp:LinkButton runat="server" ForeColor="White" CssClass="btn btn-xs btn-info" CommandName="Select" Font-Underline="false" Font-Overline="false" Font-Size="Small"><i class="fa fa-search-plus icon-white icon-fix"></i> Detalles</asp:LinkButton>--%>
                                                <div class="price-edit menu hidden">
                                                </div> 
                                                <div class="default">
                                                  <%# Eval("Precio") %>
                                                </div>  
                                                <%--<span class="label label-default"><asp:LinkButton runat="server" ><i class="fa fa-book icon-fix"></i> Check</asp:LinkButton></span>--%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-Width="40px" ItemStyle-CssClass="ignore" >
                                            <HeaderTemplate>
                                                Cantidad
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                               <%--<asp:LinkButton runat="server" ForeColor="White" CssClass="btn btn-xs btn-info" CommandName="Select" Font-Underline="false" Font-Overline="false" Font-Size="Small"><i class="fa fa-search-plus icon-white icon-fix"></i> Detalles</asp:LinkButton>--%>
                                                <div class="qtyBefore default">
                                                  <%# Eval("Cantidad") %>
                                                </div>  
                                                <input class="qtyEdit menu hidden" type="number" name="quantity" min="1">
                                                <%--<span class="label label-default"><asp:LinkButton runat="server" ><i class="fa fa-book icon-fix"></i> Check</asp:LinkButton></span>--%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-CssClass="ignore" >
                                            <HeaderTemplate>
                                                Total
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                               <%--<asp:LinkButton runat="server" ForeColor="White" CssClass="btn btn-xs btn-info" CommandName="Select" Font-Underline="false" Font-Overline="false" Font-Size="Small"><i class="fa fa-search-plus icon-white icon-fix"></i> Detalles</asp:LinkButton>--%>
                                                <div class="total-edit menu hidden">
                                                </div>
                                                <div class="default">
                                                  <%# Eval("Total") %>
                                                </div>  
                                                <%--<span class="label label-default"><asp:LinkButton runat="server" ><i class="fa fa-book icon-fix"></i> Check</asp:LinkButton></span>--%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
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
                                <asp:LinkButton CssClass="pull-right btn btn-success" runat="server" id="submitBtn" Text="Submit" ForeColor="White" OnClientClick="return ValidateForm();" OnClick="submitBtn_Click"></asp:LinkButton>
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

            // Get query string
            function getParameterByName(name, url) {
                if (!url) url = window.location.href;
                name = name.replace(/[\[\]]/g, "\\$&");
                var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
                    results = regex.exec(url);
                if (!results) return null;
                if (!results[2]) return '';
                return decodeURIComponent(results[2].replace(/\+/g, " "));
            }

            if (!Modernizr.touch || !Modernizr.inputtypes.date) {
                //alert("called");
                //$('#edit_OrderDate').datepick({ dateFormat: "dd/mm/yy" });                

                $('#edit_OrderDate').datepick($.extend({
                    renderer: $.datepick.themeRollerRenderer,
                    altFormat: 'DD, d MM, yyyy'
                },
                $.datepick.regionalOptions['es']));
            }
            
            $('.table-responsive').on('show.bs.dropdown', function () {
                $('.table-responsive').css("overflow", "inherit");
            });

            $('.table-responsive').on('hide.bs.dropdown', function () {
                $('.table-responsive').css("overflow", "auto");
            })

            $("#editCartSpan").click(function () {
                $(this).addClass('hidden');
                startEditMode();
            });

            $("#cancelCartSpan").click(function () {
                exitEditMode();
            });

            $("#saveCartSpan").click(function () {
                saveOrderChanges();
            });

            /* Edit type logic
            -------------------------*/
            function askForTypes() {
                $.ajax({
                    type: "POST",
                    url: "Detalles.aspx/GetTypes",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    traditional: true,
                    success: OnSuccessGetEditTypes,
                    failure: function (response) {
                        alert("Fail: " + response.d);
                    },
                    error: function (response) {
                        alert("Error: " + response.d);
                    }
                });
            }

            function OnSuccessGetEditTypes(response) {
                var json = JSON.parse(response.d);
                $("#shoppingCart").enable();
                populateEditType(json);
            }

            function populateEditType(productList) {
                var typeMenu = $(".type-menu")
                typeMenu.empty();
                $.each(productList, function () {
                    typeMenu.append($("<option data-increase=" + this.IncreaseRatio + "/>").val(this.IdType).text(this.TypeName));
                });

                for (var i = 0; i < typeMenu.length; ++i) {
                    selectDropDownByText(typeMenu.eq(i), typeMenu.eq(i).prev().text().trim());
                }
            }

            // Set data-price to 'select' element
            $('.qtyEdit').on('change', function () {
                calculateTotalPrice($(this));
            });

            // Set data-price to 'select' element
            $('.type-menu').on('change', function () {
                var priceValue = $(this).find(':selected').data('increase');
                $(this).data('increase', priceValue);

                calculateTotalPrice($(this));
            });

            /* Edit product logic
            -------------------------*/
            function askForProducts() {
                var id = getParameterByName('Id');
                $.ajax({
                    type: "POST",
                    url: "Detalles.aspx/GetProducts",
                    data: "{id: " + id + "}",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    traditional: true,
                    success: OnSuccessGetEditProducts,
                    failure: function (response) {
                        alert("Fail: " + response.d);
                    },
                    error: function (response) {
                        alert("Error: " + response.d);
                    }
                });
            }

            function OnSuccessGetEditProducts(response) {
                var json = JSON.parse(response.d);
                populateEditProduct(json);
            }

            function populateEditProduct(productList) {
                var productMenu = $(".product-menu")
                productMenu.empty();
                $.each(productList, function () {
                    productMenu.append($("<option data-price=" + this.UnitPrice + "/>").val(this.IdProduct).text(this.ProductName));
                });

                for (var i = 0; i < productMenu.length; ++i) {
                    selectDropDownByText(productMenu.eq(i), productMenu.eq(i).prev().text().trim());
                }
            }

            // Set data-price to 'select' element
            $('.product-menu').change(function () {
                var priceValue = $(this).find(':selected').data('price');
                $(this).data('price', priceValue);
                calculateTotalPrice($(this));
            });

            /* Remove - Add functions
            ------------------------------*/
            $(document).on("click", ".remove-edit", function () {
                $(this).closest('tr').addClass('hidden removed')
            });

            $(document).on("click", ".add-edit", function () {
                var tr = $(this).closest('tr');
                var clone = tr.clone(true, true)

                // Set default values
                clone.find('.qtyEdit').val(1);
                clone.find('.product-menu').trigger('change');
                clone.find('.type-menu').trigger('change');

                tr.after(clone.addClass('added').fadeIn('slow'));
            });

            /* Confirm changes
            -------------------------------*/
            function saveOrderChanges() {
                var order = getOrderFromTable();
                sendOrderUpdate(order)
            }

            function getOrderFromTable() {
                var id = getParameterByName('Id');
                var newOrder = {
                    items: [],
                    id: id
                }

                $('#shopppingGrid > tbody  > tr:not(.hidden):not(:first)').each(function () {
                    var product = $(this).find('.product-menu');
                    var type = $(this).find('.type-menu');
                    var qty = $(this).find('.qtyEdit');
                    var total = $(this).find('.total-edit');

                    var order = {
                        productId: product.val(),
                        productPrice: product.data('price'),
                        productName: product.children(':selected').text(),
                        typeId: type.val(),
                        typeIncrease: type.data('increase'),
                        typeName: type.children(':selected').text(),
                        qty: qty.val(),
                        total: total.val()
                    }

                    newOrder.items.push(order)
                });

                return newOrder;
            }

            function sendOrderUpdate(order) {
                $.ajax({
                    type: "POST",
                    url: "Detalles.aspx/UpdateOrder",
                    data: JSON.stringify({order}),
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    traditional: true,
                    success: OnSuccessUpdateOrder,
                    failure: function (response) {
                        alert("Fail: " + response.d);
                    },
                    error: function (response) {
                        alert("Error: " + response.d);
                    }
                });
            }

            function OnSuccessUpdateOrder(response) {
                location.reload();
            }

            /* Common edit functions
            ------------------------------*/

            function exitEditMode() {
                $("#shoppingCart").enable();

                $("#editCartSpan").removeClass('hidden');
                $(".cancelable").addClass('hidden')
                $(".menu").addClass('hidden');
                $(".default").removeClass('hidden');

                // Deleted / Added rows
                $(".removed").removeClass('hidden');
                $(".added").remove();

                resetDefaults();
            }

            function startEditMode() {
                $("#shoppingCart").disable();

                askForProducts();
                askForTypes();

                $(".cancelable").removeClass("hidden");
                $(".menu").removeClass('hidden');
                $(".default").addClass('hidden');

                setDefaults();
            }

            function setDefaults() {
                var divsBefore = $(".qtyBefore");
                var inputEdit = $(".qtyEdit");

                divsBefore.addClass('hidden');

                for (var i = 0; i < divsBefore.length; ++i) {
                    inputEdit.eq(i).val(divsBefore.eq(i).text().trim())
                }
            }

            function resetDefaults() {
                var divsBefore = $(".qtyBefore");
                divsBefore.removeClass('hidden');
            }

            function selectDropDownByText(menu, text) {
                menu.children('option').each(function () {
                    if ($(this).text() == text) {
                        $(this).attr('selected', 'selected');
                        $(this).trigger('change');
                    }
                });
            }

            function calculateTotalPrice($scope) {
                var price = $scope.closest('tr').find('.product-menu').data('price');
                var increase = $scope.closest('tr').find('.type-menu').data('increase');
                var qty = $scope.closest('tr').find('.qtyEdit').val();

                var singleProductPrice = price + (price * (increase / 100));
                var total = singleProductPrice * qty;

                $scope.closest('tr').find('.price-edit').text('$' + singleProductPrice);
                $scope.closest('tr').find('.total-edit').text('$' + total.toFixed(2)).val(total);
            }

            /* End Common edit functions
            ------------------------------*/

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

            // Extensions for disabling
            $.fn.disable = function () {
                this.addClass('disabled');
            }

            $.fn.enable = function () {
                this.removeClass('disabled');
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
