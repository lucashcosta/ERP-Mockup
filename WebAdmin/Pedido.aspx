<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Pedido.aspx.cs" Inherits="WebAdmin.Pedido" EnableEventValidation = "false" ValidateRequest="false"%>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <link href="/css/Pages/invoice.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="/css/jquery.datepick.css"> 

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div id="page-wrapper">
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="isClient" Value="0"/>
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="clientID" Value="0"/>
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="productPrice" Value="0"/>
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="productPrice2" Value="0"/>
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="productPrice3" Value="0"/>
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="productPrice4" Value="0"/>
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="productPrice5" Value="0"/>
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="productPrice6" Value="0"/>
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="productPrice7" Value="0"/>
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="productPrice8" Value="0"/>
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="productPrice9" Value="0"/>
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="totalProductPrice" Value="0"/>
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="unitPriceProduct" Value="0"/>
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="unitPriceProduct2" Value="0"/>
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="unitPriceProduct3" Value="0"/>
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="unitPriceProduct4" Value="0"/>
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="unitPriceProduct5" Value="0"/>
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="unitPriceProduct6" Value="0"/>
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="unitPriceProduct7" Value="0"/>
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="unitPriceProduct8" Value="0"/>
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="unitPriceProduct9" Value="0"/>
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="shippingPrice" Value="25"/>
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="finalshippingPrice" Value="25"/>
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="discPrice" Value="0"/>
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="finaldiscPrice" Value="0"/>
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="finalSubTotalPrice" Value="0"/>

    <div class="row">
        <asp:Panel ID="panelMessage" runat="server" Visible="false"> 
            <h4 id="messagesText" class="alert-info" runat="server">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <asp:Label ID="lblMessage" ClientIDMode="Static" runat="server" Text=""></asp:Label>
            </h4> 
        </asp:Panel>
        <div id="clientError" class="alert alert-danger hidden">
            <%--<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>--%>
            <span id="clientErrorMsg"></span>
        </div>
            <div class="col-lg-12">
                <h1>Pedido <small>Registro de un pedido</small><a class="pull-right" href="Pedido.aspx" runat="server" visible="false" id="cleanSpan"><i  rel="tooltip" title="Limpiar forma" class="clickable fa fa-trash-o"></i></a></h1>
                <ol class="breadcrumb">
                    <li><a href="Dashboard"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                    <li class="active"><a href="Pedido.aspx"><i class="fa fa-magic"></i> Pedido</a></li> 
                    <%--<span class="pull-right"><strong>Fecha de pedido: <%=DateTime.Now.ToString()%></strong></span>--%>
                </ol>
            </div>
        </div><!-- /.row Titulo de aspx -->

    <div class="col-lg-6">
        <div id="clientDivPanel" class="panel panel-default">
            <div class="panel-heading clickable">
                <h4 class="panel-title"><i class="fa fa-user"></i>  Info. del Cliente 
                    <%--<span id="clientLabel" style="margin-left:10px; margin-bottom:30px;" class="label label-default">Cliente nuevo</span>--%>
                </h4>
                <span class="pull-right"><i id="infoClientSpan" class="fa fa-chevron-up"></i></span>
            </div>
            <div class="panel-body" id="clientDiv">
                <div class="form-group input-group" id="firstNameDiv">
                    <asp:TextBox ClientIDMode="Static" rel="tooltip-top" title="Nombre" ID="firstName" name="firstName" runat="server" class="form-control" placeholder="Nombre(s)" required></asp:TextBox>
                    <span class="input-group-btn">
                        <%--<button class="btn btn-default" data-toggle="modal" data-target="#modalClientsGrid" type="button"><i class="fa fa-search icon-blue-search"></i></button>--%>
                        <asp:LinkButton OnClick="firstNameSearch_Click" CausesValidation="false" UseSubmitBehavior="false" ID="firstNameSearch" ClientIDMode="Static" CSSClass="btn btn-default" runat="server"><i id="faFirstName" class="fa fa-search icon-blue-search"></i></asp:LinkButton>
                    </span>
                </div>
                <div class="form-group input-group" id="lastNameDiv">
                    <asp:TextBox ClientIDMode="Static" rel="tooltip-top" title="Apellido" ID="lastName" name="lastName" runat="server" class="form-control" placeholder="Apellido(s)" required></asp:TextBox>
                    <span class="input-group-btn">
                        <%--<button id="lastNameSearch" data-toggle="modal" data-target="#modalClientsGrid" class="btn btn-default"  type="button"><i class="fa fa-search icon-blue-search"></i></button>--%>
                        <asp:LinkButton OnClick="lastNameSearch_Click" ID="lastNameSearch" ClientIDMode="Static" CSSClass="btn btn-default" runat="server"><i id="faLastName" class="fa fa-search icon-blue-search"></i></asp:LinkButton>
                    </span>
                </div>
                <div class="form-group input-group" id="phoneDiv">
                    <span class="input-group-addon"><i class="fa fa-phone"></i></span>
                    <asp:TextBox TextMode="Phone" rel="tooltip-top" title="Telefono" ClientIDMode="Static" ID="phone" name="phone" runat="server" class="form-control" placeholder="Telefono" required></asp:TextBox>
                    <span class="input-group-btn">
                        <%--<button class="btn btn-default" data-toggle="modal" data-target="#modalClientsGrid" type="button"><i class="fa fa-search icon-blue-search"></i></button>--%>
                        <asp:LinkButton OnClick="phoneSearch_Click" ID="phoneSearch" ClientIDMode="Static" CSSClass="btn btn-default" runat="server"><i id="faPhone" class="fa fa-search icon-blue-search"></i></asp:LinkButton>
                    </span>
                </div>
                <div class="form-group input-group" id="mobileDiv">
                    <span class="input-group-addon"><i class="fa fa-mobile icon-fix"></i></span>
                    <asp:TextBox TextMode="Phone" rel="tooltip-top" title="Celular" ClientIDMode="Static" ID="mobile" name="mobile" runat="server" class="form-control" placeholder="Movil"></asp:TextBox>
                    <span class="input-group-btn">
                        <%--<button class="btn btn-default" data-toggle="modal" data-target="#modalClientsGrid" type="button"><i class="fa fa-search icon-blue-search"></i></button>--%>
                        <asp:LinkButton OnClick="mobileSearch_Click" ID="mobileSearch" ClientIDMode="Static" CSSClass="btn btn-default" runat="server"><i id="faMobile" class="fa fa-search icon-blue-search"></i></asp:LinkButton>
                    </span>
                </div>
                <div class="form-group input-group" id="planoDiv">
                    <span class="input-group-addon"><i class="fa fa-map-marker icon-red"></i></span>
                    <asp:TextBox ClientIDMode="Static" rel="tooltip-top" title="Plano [###A#]" ID="plano" name="plano" runat="server" class="form-control" placeholder="Plano"></asp:TextBox>
                </div>
            </div>
        </div>
        <div id="dirDivPanel" class="panel panel-default">
            <div class="panel-heading clickable">
                <h3 class="panel-title"><i class="fa fa-location-arrow"></i>  Direccion del cliente
                    <%--<span id="dirLabel" style="margin-left:10px; margin-bottom:30px;" class="label label-default">Cliente nuevo</span>--%>
                </h3>
                <span class="pull-right"><i id="dirClientSpan" class="fa fa-chevron-up"></i></span>
            </div>
            <div class="panel-body" id="dirDiv">
                <div class="form-group" id="streetDiv">
                    <asp:TextBox ClientIDMode="Static" rel="tooltip-top" title="Calle" ID="street" name="street" runat="server" class="form-control" placeholder="Calle" required></asp:TextBox>
                </div>
                <div class="form-group" id="dirNumberDiv">
                    <asp:TextBox ClientIDMode="Static" rel="tooltip-top" title="Numero (Direccón)" ID="dirNumber" name="dirNumber" runat="server" class="form-control" placeholder="Numero"></asp:TextBox>
                </div>
                <div class="form-group" id="colonyDiv">
                    <asp:TextBox ClientIDMode="Static" rel="tooltip-top" title="Colonia" ID="colony" name="colony" runat="server" class="form-control" placeholder="Colonia" required></asp:TextBox>
                </div>
                <div class="form-group" id="cityDiv">
                    <asp:TextBox ClientIDMode="Static" rel="tooltip-top" title="Ciudad" ID="city" name="city" runat="server" class="form-control" placeholder="Ciudad"></asp:TextBox>
                </div>
                <div class="form-group" id="betStreetsDiv">
                    <asp:TextBox ClientIDMode="Static" rel="tooltip-top" title="Entre calles" ID="betStreets" name="betStreets" runat="server" class="form-control" placeholder="Entre Calles"></asp:TextBox>
                </div>
                <div class="form-group" id="postalCodeDiv">
                    <asp:TextBox ClientIDMode="Static" pattern="\d*" rel="tooltip-top" title="Codigo Postal [#####]" onkeypress="return isNumberKey(event)" ID="postalCode" name="postalCode" runat="server" class="form-control" placeholder="Codigo Postal"></asp:TextBox>
                </div>
                <div class="form-group" id="ruteDiv">
                      <asp:DropDownList rel="tooltip-top" title="Ruta"  AppendDataBoundItems=True CssClass="form-control" runat="server" ID="ruteDropD" ClientIDMode="Static">
                          <asp:ListItem Value="0" Text="Ruta"></asp:ListItem>
                      </asp:DropDownList>
                  </div>
                <div class="form-group" id="dirRefDiv">
                    <asp:TextBox TextMode="Multiline" ClientIDMode="Static" rel="tooltip-top" title="Referencias de direccion" ID="dirRef" name="dirRef" runat="server" class="form-control" placeholder="Referencias de direccion"></asp:TextBox>
                </div>
                <div class="form-group" id="dirNotesDiv">
                    <asp:TextBox TextMode="Multiline" ClientIDMode="Static" rel="tooltip-top" title="Notas" ID="dirNotes" name="dirNotes" runat="server" class="form-control" placeholder="Notas"></asp:TextBox>
                </div>
            </div>
        </div>
        <div id="lastBuysDiv" class="hidden panel panel-primary">
            <div class="panel-heading clickable">
                <h3 class="panel-title"><i class="fa fa-calendar"></i>  Actividad reciente del cliente
                    <%--<span id="lastBuysLabel" style="margin-left:10px; margin-bottom:30px;" class="label label-default">Cliente nuevo</span>--%>
                </h3>
                <%--<span class="pull-right"><i id="lastBuysSpan" class="fa fa-chevron-up"></i></span>--%>
            </div>
            <div class="table-responsive">
                <!-- TODO: Last 3 buys -->
                <asp:GridView runat="server" ID="lastBuysGrid" OnRowDataBound="lastBuysGrid_RowDataBound" AutoGenerateColumns="false" ClientIDMode="Static" CssClass="table table-panelfit table-hover table-bordered table-responsive">
                    <Columns>
                        <asp:BoundField DataField="id_pedido" HeaderText="ID" />
                        <asp:BoundField DataField="fechaEntrega_orden" HeaderText="Fecha entrega" />
                        <asp:BoundField DataField="status_orden" HeaderText="Status"/>
                        <asp:BoundField DataField="totalProductos_orden" HeaderText="Total" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"/>

                        <asp:BoundField DataField="producto_orden" HeaderText="Producto" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"/>
                        <asp:BoundField DataField="tipoProducto_orden" HeaderText="Tipo" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"/>
                        <asp:BoundField DataField="cantidadProducto_orden" HeaderText="Cantidad" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"/>

                        <asp:BoundField DataField="producto2_orden" HeaderText="Producto" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"/>
                        <asp:BoundField DataField="tipoProducto2_orden" HeaderText="Tipo" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"/>
                        <asp:BoundField DataField="cantidadProducto2_orden" HeaderText="Cantidad" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"/>

                        <asp:BoundField DataField="producto3_orden" HeaderText="Producto" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"/>
                        <asp:BoundField DataField="tipoProducto3_orden" HeaderText="Tipo" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"/>
                        <asp:BoundField DataField="cantidadProducto3_orden" HeaderText="Cantidad" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"/>

                        <asp:BoundField DataField="producto4_orden" HeaderText="Producto" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"/>
                        <asp:BoundField DataField="tipoProducto4_orden" HeaderText="Tipo" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"/>
                        <asp:BoundField DataField="cantidadProducto4_orden" HeaderText="Cantidad" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"/>

                        <asp:BoundField DataField="producto5_orden" HeaderText="Producto" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"/>
                        <asp:BoundField DataField="tipoProducto5_orden" HeaderText="Tipo" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"/>
                        <asp:BoundField DataField="cantidadProducto5_orden" HeaderText="Cantidad" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"/>

                        <asp:BoundField DataField="producto6_orden" HeaderText="Producto" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"/>
                        <asp:BoundField DataField="tipoProducto6_orden" HeaderText="Tipo" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"/>
                        <asp:BoundField DataField="cantidadProducto6_orden" HeaderText="Cantidad" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"/>

                        <asp:BoundField DataField="producto7_orden" HeaderText="Producto" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"/>
                        <asp:BoundField DataField="tipoProducto7_orden" HeaderText="Tipo" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"/>
                        <asp:BoundField DataField="cantidadProducto7_orden" HeaderText="Cantidad" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"/>

                        <asp:BoundField DataField="producto8_orden" HeaderText="Producto" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"/>
                        <asp:BoundField DataField="tipoProducto8_orden" HeaderText="Tipo" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"/>
                        <asp:BoundField DataField="cantidadProducto8_orden" HeaderText="Cantidad" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"/>

                        <asp:BoundField DataField="producto9_orden" HeaderText="Producto" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"/>
                        <asp:BoundField DataField="tipoProducto9_orden" HeaderText="Tipo" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"/>
                        <asp:BoundField DataField="cantidadProducto9_orden" HeaderText="Cantidad" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"/>

                        <asp:TemplateField ItemStyle-Width="7px" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="text-center" HeaderText="Mas" HeaderStyle-Width="10px" HeaderStyle-Wrap="true">
                            <ItemTemplate>
                                <%--<asp:LinkButton ID="openBuyDetails" ClientIDMode="Static" runat="server" CssClass="btn btn-xs btn-default btn-default" OnClientClick="openDetails()">
                                    <i class="fa fa-plus"></i>
                                </asp:LinkButton>--%>
                                <button type="button" id="openBuyDetails" runat="server" class="detailsBtn btn btn-xs btn-default btn-default">
                                    <i class="fa fa-plus"></i>
                                </button>
                                <%--<span class="label label-default"><asp:LinkButton runat="server" ><i class="fa fa-book icon-fix"></i> Check</asp:LinkButton></span>--%>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                </div>
        </div>
        <div class="panel panel-warning">
                <div class="panel-heading clickable">
                <h3 class="panel-title"><i class="fa fa-bolt"></i>  Orden</h3>
                <span class="pull-right"><i class="fa fa-chevron-up"></i></span>
                </div>
                <div class="panel-body">
                    <%--<div class="form-group" id="messengerDiv" >
                        <label class="">Mensajero</label>
                        <asp:DropDownList ClientIDMode="Static" AppendDataBoundItems=True ID="messengerDropD" runat="server" CssClass="form-control" >
                        </asp:DropDownList>
                    </div>--%>
                    <div class="form-group" id="orderDateDiv" data-placement="left">
                        <label class="">Fecha de entrega</label>
                        <asp:TextBox TextMode="Date" ClientIDMode="Static" ID="orderDate" name="orderDate" runat="server" class="form-control" placeholder="Fechad de la orden" required></asp:TextBox>
                    </div>
                    <div class="form-group" id="deliveringTimeDiv">
                        <label class="">Horario de entrega</label>
                        <asp:DropDownList ClientIDMode="Static" AppendDataBoundItems=True ID="deliveringTime" runat="server" CssClass="form-control" >
                            <asp:ListItem Value="0"> Selecciona un horiario</asp:ListItem>
                            <asp:ListItem>9am a 12pm</asp:ListItem>
                            <asp:ListItem>12pm a 2pm</asp:ListItem>
                            <asp:ListItem>2pm a 4pm</asp:ListItem>
                            <asp:ListItem>4am a 6pm</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <%--<label class="hidden">Pago</label>
                    <div class="form-group input-group hidden" id="qtyPayDiv">
                        <span class="input-group-addon"><i class="fa fa-dollar"></i></span>
                        <asp:TextBox ClientIDMode="Static" ID="qtyPay" name="qtyPay" runat="server" class="form-control" placeholder="Cantidad de pago" onkeypress="return isNumberKey(event)"></asp:TextBox>
                    </div>--%>
                    <div class="form-group" id="payMethodDiv">
                        <label class="">Forma de pago</label>
                        <asp:DropDownList ClientIDMode="Static" AppendDataBoundItems=True ID="payMethod" runat="server" CssClass="form-control" >
                            <asp:ListItem>Efectivo</asp:ListItem>
                            <asp:ListItem>Cretido</asp:ListItem>
                            <asp:ListItem>T.C</asp:ListItem>
                            <asp:ListItem>Consignacion</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
            </div>
    </div> <!-- /.div col 6 -->
        <div class="col-lg-6">
            <div class="panel panel-warning">
                <div class="panel-heading clickable">
                <h3 class="panel-title"><i class="fa fa-bolt"></i>  Orden - Producto</h3>
                <span class="pull-right"><i class="fa fa-chevron-up"></i></span>
                </div>
                <div id="productsSelectDiv" class="panel-body">
                    <% if (User.Identity.Name.Equals("admin"))
                           brandDropDDiv.Visible = true;%>

                    <div runat="server" visible="false" class="form-group" id="brandDropDDiv" data-toggle="tooltip" data-placement="left" title="Tooltip on left">
                        <asp:DropDownList ClientIDMode="Static" AppendDataBoundItems=True ID="brandDropD" runat="server" CssClass="form-control" OnSelectedIndexChanged="brandDropD_SelectedIndexChanged" AutoPostBack="true" >
                            <asp:ListItem Value="0"> Selecciona una marca</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="row">
                    <div class="col-lg-5 form-group" id="productDropDDiv">
                        <%--<label class="">Producto</label>--%>
                        <asp:DropDownList ClientIDMode="Static" AppendDataBoundItems=True ID="productDropD" runat="server" CssClass="form-control" >
                            
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-3 form-group" id="typeDropDDiv">
                        <%--<label class="">Tipo</label>--%>
                        <asp:DropDownList ClientIDMode="Static" AppendDataBoundItems=True ID="typeDropD" runat="server" CssClass="form-control" >
                            <%--<asp:ListItem Value="0"></asp:ListItem>--%>
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-3">
                        <asp:TextBox ID="qtyP" pattern="\d*" onkeypress="return isNumberKey(event)" ClientIDMode="Static" Width="70px" runat="server" TextMode="Number" min="1">1</asp:TextBox>                        
                        <span id="price_p1" style="margin-left:10px; padding-top:10px;" class="pull-right"></span>
                    </div>
                    </div>
                    <div><hr /></div>

                    <!--Prodcut 2 -->
                    <div id="rowP2" class="hidden row">
                    <div class="col-lg-5 form-group" id="productDropDDiv2">
                        <%--<label class="">Producto</label>--%>
                        <asp:DropDownList ClientIDMode="Static" AppendDataBoundItems=True ID="productDropD2" runat="server" CssClass="form-control" >
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-3 form-group" id="typeDropDDiv2">
                        <%--<label class="">Tipo</label>--%>
                        <asp:DropDownList ClientIDMode="Static" AppendDataBoundItems=True ID="typeDropD2" runat="server" CssClass="form-control" >
                            <%--<asp:ListItem Value="0"> Selecciona tipo de agua</asp:ListItem>--%>
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-3">
                        <asp:TextBox ID="qtyP2" pattern="\d*" onkeypress="return isNumberKey(event)" ClientIDMode="Static" Width="70px" runat="server" TextMode="Number" min="0">0</asp:TextBox>
                        <span id="price_p2" style="margin-left:10px; padding-top:10px;" class="pull-right"></span>
                    </div>
                    </div>
                    <div class="hidden" id="hrProduct2"><hr /></div>

                    <!--Prodcut 3 -->
                    <div id="rowP3" class="hidden row">
                    <div class="col-lg-5 form-group" id="productDropDDiv3">
                        <%--<label class="">Producto</label>--%>
                        <asp:DropDownList ClientIDMode="Static" AppendDataBoundItems=True ID="productDropD3" runat="server" CssClass="form-control" >
                            
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-3 form-group" id="typeDropDDiv3">
                        <%--<label class="">Tipo</label>--%>
                        <asp:DropDownList ClientIDMode="Static" AppendDataBoundItems=True ID="typeDropD3" runat="server" CssClass="form-control" >
                            <%--<asp:ListItem Value="0"> Selecciona tipo de agua</asp:ListItem>--%>
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-3">
                        <asp:TextBox ID="qtyP3" pattern="\d*" onkeypress="return isNumberKey(event)" ClientIDMode="Static" Width="70px" runat="server" TextMode="Number" min="0">0</asp:TextBox>
                        <span id="price_p3" style="margin-left:10px; padding-top:10px;" class="pull-right"></span>
                    </div>
                    </div>
                    <div class="hidden" id="hrProduct3"><hr /></div>

                    <!--Prodcut 4 -->
                    <div id="rowP4" class="hidden row">
                    <div class="col-lg-5 form-group" id="productDropDDiv4">
                        <%--<label class="">Producto</label>--%>
                        <asp:DropDownList ClientIDMode="Static" AppendDataBoundItems=True ID="productDropD4" runat="server" CssClass="form-control" >
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-3 form-group" id="typeDropDDiv4">
                        <%--<label class="">Tipo</label>--%>
                        <asp:DropDownList ClientIDMode="Static" AppendDataBoundItems=True ID="typeDropD4" runat="server" CssClass="form-control" >
                            <%--<asp:ListItem Value="0"> Selecciona tipo de agua</asp:ListItem>--%>
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-3">
                        <asp:TextBox ID="qtyP4" pattern="\d*" onkeypress="return isNumberKey(event)" ClientIDMode="Static" Width="70px" runat="server" TextMode="Number" min="0">0</asp:TextBox>
                        <span id="price_p4" style="margin-left:10px; padding-top:10px;" class="pull-right"></span>
                    </div>
                    </div>
                    <div class="hidden" id="hrProduct4"><hr /></div>

                    <!--Prodcut 5 -->
                    <div id="rowP5" class="hidden row">
                    <div class="col-lg-5 form-group" id="productDropDDiv5">
                        <%--<label class="">Producto</label>--%>
                        <asp:DropDownList ClientIDMode="Static" AppendDataBoundItems=True ID="productDropD5" runat="server" CssClass="form-control" >
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-3 form-group" id="typeDropDDiv5">
                        <%--<label class="">Tipo</label>--%>
                        <asp:DropDownList ClientIDMode="Static" AppendDataBoundItems=True ID="typeDropD5" runat="server" CssClass="form-control" >
                            <%--<asp:ListItem Value="0"> Selecciona tipo de agua</asp:ListItem>--%>
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-3">
                        <asp:TextBox ID="qtyP5" pattern="\d*" onkeypress="return isNumberKey(event)" ClientIDMode="Static" Width="70px" runat="server" TextMode="Number" min="0">0</asp:TextBox>
                        <span id="price_p5" style="margin-left:10px; padding-top:10px;" class="pull-right"></span>
                    </div>
                    </div>
                    <div class="hidden" id="hrProduct5"><hr /></div>

                    <!--Prodcut 6 -->
                    <div id="rowP6" class="hidden row">
                    <div class="col-lg-5 form-group" id="productDropDDiv6">
                        <%--<label class="">Producto</label>--%>
                        <asp:DropDownList ClientIDMode="Static" AppendDataBoundItems=True ID="productDropD6" runat="server" CssClass="form-control" >
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-3 form-group" id="typeDropDDiv6">
                        <%--<label class="">Tipo</label>--%>
                        <asp:DropDownList ClientIDMode="Static" AppendDataBoundItems=True ID="typeDropD6" runat="server" CssClass="form-control" >
                            <%--<asp:ListItem Value="0"> Selecciona tipo de agua</asp:ListItem>--%>
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-3">
                        <asp:TextBox ID="qtyP6" pattern="\d*" onkeypress="return isNumberKey(event)" ClientIDMode="Static" Width="70px" runat="server" TextMode="Number" min="0">0</asp:TextBox>
                        <span id="price_p6" style="margin-left:10px; padding-top:10px;" class="pull-right"></span>
                    </div>
                    </div>
                    <div class="hidden" id="hrProduct6"><hr /></div>

                    <!--Prodcut 7 -->
                    <div id="rowP7" class="hidden row">
                    <div class="col-lg-5 form-group" id="productDropDDiv7">
                        <%--<label class="">Producto</label>--%>
                        <asp:DropDownList ClientIDMode="Static" AppendDataBoundItems=True ID="productDropD7" runat="server" CssClass="form-control" >
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-3 form-group" id="typeDropDDiv7">
                        <%--<label class="">Tipo</label>--%>
                        <asp:DropDownList ClientIDMode="Static" AppendDataBoundItems=True ID="typeDropD7" runat="server" CssClass="form-control" >
                            <%--<asp:ListItem Value="0"> Selecciona tipo de agua</asp:ListItem>--%>
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-3">
                        <asp:TextBox ID="qtyP7" pattern="\d*" onkeypress="return isNumberKey(event)" ClientIDMode="Static" Width="70px" runat="server" TextMode="Number" min="0">0</asp:TextBox>
                        <span id="price_p7" style="margin-left:10px; padding-top:10px;" class="pull-right"></span>
                    </div>
                    </div>
                    <div class="hidden" id="hrProduct7"><hr /></div>

                    <!--Prodcut 8 -->
                    <div id="rowP8" class="hidden row">
                    <div class="col-lg-5 form-group" id="productDropDDiv8">
                        <%--<label class="">Producto</label>--%>
                        <asp:DropDownList ClientIDMode="Static" AppendDataBoundItems=True ID="productDropD8" runat="server" CssClass="form-control" >
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-3 form-group" id="typeDropDDiv8">
                        <%--<label class="">Tipo</label>--%>
                        <asp:DropDownList ClientIDMode="Static" AppendDataBoundItems=True ID="typeDropD8" runat="server" CssClass="form-control" >
                            <%--<asp:ListItem Value="0"> Selecciona tipo de agua</asp:ListItem>--%>
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-3">
                        <asp:TextBox ID="qtyP8" pattern="\d*" onkeypress="return isNumberKey(event)" ClientIDMode="Static" Width="70px" runat="server" TextMode="Number" min="0">0</asp:TextBox>
                        <span id="price_p8" style="margin-left:10px; padding-top:10px;" class="pull-right"></span>
                    </div>
                    </div>
                    <div class="hidden" id="hrProduct8"><hr /></div>

                    <!--Prodcut 9 -->
                    <div id="rowP9" class="hidden row">
                    <div class="col-lg-5 form-group" id="productDropDDiv9">
                        <%--<label class="">Producto</label>--%>
                        <asp:DropDownList ClientIDMode="Static" AppendDataBoundItems=True ID="productDropD9" OnDataBound="productDropD_DataBound" runat="server" CssClass="form-control" >
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-3 form-group" id="typeDropDDiv9">
                        <%--<label class="">Tipo</label>--%>
                        <asp:DropDownList ClientIDMode="Static" AppendDataBoundItems=True ID="typeDropD9" runat="server" CssClass="form-control" >
                            <%--<asp:ListItem Value="0"> Selecciona tipo de agua</asp:ListItem>--%>
                        </asp:DropDownList>
                    </div>
                    <div class="col-lg-3">
                        <asp:TextBox ID="qtyP9" pattern="\d*" onkeypress="return isNumberKey(event)" ClientIDMode="Static" Width="70px" runat="server" TextMode="Number" min="0">0</asp:TextBox>
                        <span id="price_p9" style="margin-left:10px; padding-top:10px;" class="pull-right"></span>
                    </div>
                    </div>
                    <div class="hidden" id="hrProduct9"><hr /></div>
                    <div id="shippingPaydivRow" style="height:30px;" class=" row">
                    <div class="col-lg-12 form-group" id="shippingBox">
                        <%--<label class="">Producto</label>--%>
                        <%--<asp:CheckBox runat="server" ID="shippingPay" ClientIDMode="Static"/><span style="padding-bottom:20px;">  Cobrar envío</span>--%>
                        <span class="button-checkbox">
                            <button type="button" id="shipBtn" class="btn" data-color="success">Cobrar Envío</button>
                            <input runat="server" type="checkbox" id="shipbox" class="hidden shipbox" checked />
                            <span id="price_shipping" style="padding-right:50px; padding-top:10px;" class="pull-right"></span>
                        </span>
                    </div>
                    </div>
                    <hr />
                    <div runat="server" visible="false" id="discdivRow" style="height:30px;" class=" row">
                    <div class="col-lg-12 form-group" id="discBox">
                        <%--<label class="">Producto</label>--%>
                        <%--<asp:CheckBox runat="server" ID="shippingPay" ClientIDMode="Static"/><span style="padding-bottom:20px;">  Cobrar envío</span>--%>
                        <span class="button-checkbox">
                            <button type="button" id="discBtn" class="btn" data-color="success">Aplicar Descuento</button>
                            <input runat="server" type="checkbox" id="discbox" class="hidden discbox" checked />
                            <span id="disc_price" style="padding-right:50px; padding-top:10px;" class="pull-right"></span>
                        </span>
                    </div>
                    </div>
                    <hr runat="server" id="divRowHr" visible="false" />
                    <asp:Label ID="labelCurrentTotal" ClientIDMode="Static" runat="server" style="padding-right:30px;" class="pull-right"></asp:Label>
                    <button id="addProductInputBtn" type="button" onclick="addProductInput()" class="pull-left btn btn-success"><i class="fa fa-plus"></i></button>
                    <button id="removeProductInputBtn" style="margin-right:10px" type="button" onclick="removeProductInput()" class="pull-left btn btn-danger"><i class="fa fa-minus"></i></button>
                </div>
            </div>
            <div class="panel panel-warning">
                <div class="panel-heading clickable">
                <h3 class="panel-title"><i class="fa fa-bolt"></i>  Orden - Informacion adicional</h3>
                <span class="pull-right"><i class="fa fa-chevron-up"></i></span>
                </div>
                <div class="panel-body">
                    <div class="form-group" id="promotionsDiv">
                        <%--<label class="">Promociones</label>--%>
                        <asp:DropDownList  ClientIDMode="Static" AppendDataBoundItems=True ID="promotionsDropD" runat="server" CssClass="form-control" >
                            <asp:ListItem Value=""> Selecciona una promocion</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <%--<label>Status</label>--%>
                    <%--<div class="form-group" id="statusPedidodiv" data-toggle="tooltip" data-placement="left" title="Tooltip on left">
                        <div class="btn-group" data-toggle="buttons">
                            <label class="btn btn-primary">
                                <input value="Programado" type="radio" name="statusOptions" checked id="option1"> Programado
                            </label>
                            <label class="btn btn-primary">
                                <input value="En Ruta" type="radio" name="statusOptions" id="option2"> En ruta
                            </label>
                            <label class="btn btn-primary">
                                <input value="Cancelado" type="radio" name="statusOptions" id="option3"> Cancelado
                            </label>
                            <label class="btn btn-primary">
                                <input value="Entrgado-Pagado" type="radio" name="statusOptions" id="option4"> Entregado & pagado
                            </label>
                            <br />
                            <label class="btn btn-primary">
                                <input value="Entregado-NoPagado" type="radio" name="statusOptions" id="option5"> Entregado & no pagado
                            </label>
                            <label class="btn btn-primary">
                                <input value="NoEntregado-Pagado" type="radio" name="statusOptions" id="option6"> Pagado & no entregado
                            </label>
                            <label class="btn btn-primary">
                                <input value="Pendiente" type="radio" name="statusOptions" id="option7"> Pendiente
                            </label>
                        </div>
                    </div>--%>
                    <div class="form-group" runat="server" id="refContactDiv" visible="false" data-placement="left" >
                        <asp:DropDownList ClientIDMode="Static" AppendDataBoundItems=True ID="refContact" runat="server" CssClass="form-control" >
                            <asp:ListItem Value="">Medio por el cual se entero de nosotros</asp:ListItem>
                            <asp:ListItem>TV</asp:ListItem>
                            <asp:ListItem>Radio</asp:ListItem>
                            <asp:ListItem>Internet</asp:ListItem>
                            <asp:ListItem>Recomendado</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group" id="refPromoDiv" data-placement="left" >
                        <%--<label class="">Como se entero de nosotros</label>--%>
                        <asp:DropDownList ClientIDMode="Static" AppendDataBoundItems=True ID="refPromo" runat="server" CssClass="form-control" >
                            <asp:ListItem Value="">Como se entero de la promocion</asp:ListItem>
                            <asp:ListItem>TV</asp:ListItem>
                            <asp:ListItem>Radio</asp:ListItem>
                            <asp:ListItem>Internet</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group" id="estimatedTimeDiv" data-placement="left" >
                        <label class="">Tiempo estimado a notificar</label>
                        <asp:TextBox TextMode="number" pattern="\d*" onkeypress="return isNumberKey(event)" ClientIDMode="Static" ID="estimatedTime" runat="server" class="form-control" placeholder="Dias para volver a notificar" min="0"></asp:TextBox>
                    </div>
                    <div class="form-group" id="reqNotesDiv" data-placement="left" >
                        <asp:TextBox TextMode="MultiLine" ClientIDMode="Static" ID="reqNotes" runat="server" class="form-control" placeholder="Notas adicionales"></asp:TextBox>
                    </div>
                </div>
            </div>

            <!-- Modals -->
            <!-- Modal clients grid search -->
            <div class="modal fade" id="modalClientsGrid" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">Selecciona un cliente</h4>
                  </div>
                  <div class="modal-body">
                      <div class="table-responsive">
                      <%--Clientes aqui--%>
                      <asp:GridView id="clientsGrid" ClientIDMode="Static" 
                          autogeneratecolumns="false"
                          runat="server"
                          OnRowDataBound="clientsGrid_RowDataBound"
                          Font-Size="Small"
                          OnSelectedIndexChanged="clientsGrid_SelectedIndexChanged"
                          CssClass="table table-hover table-striped table-bordered">
                          <Columns>
                              <asp:BoundField DataField="id_cliente" HeaderText="ID"  />                                                     
                              <asp:BoundField DataField="nombre_cliente" HeaderText="Nombre"/>
                              <asp:BoundField DataField="apellido_cliente" HeaderText="Apellido" />
                              <asp:BoundField DataField="telefono_cliente" HeaderText="Telefono" />
                              <asp:BoundField DataField="movil_cliente" HeaderText="Movil" />
                              <asp:BoundField DataField="plano_cliente" HeaderText="Plano" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                              <asp:BoundField DataField="ciudad_cliente" HeaderText="ID" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                              <asp:BoundField DataField="colonia_cliente" HeaderText="Movil" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                              <asp:BoundField DataField="calle_cliente" HeaderText="Calle" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                              <asp:BoundField DataField="entreCalles_cliente" HeaderText="Entre Calles" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                              <asp:BoundField DataField="numeroDir_cliente" HeaderText="Numero Dir" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                              <asp:BoundField DataField="postal_cliente" HeaderText="CP" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                              <asp:BoundField DataField="notas_cliente" HeaderText="CP" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                              <asp:BoundField DataField="referencias_direccion_cliente" HeaderText="Ref" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                              <asp:BoundField DataField="id_ruta" HeaderText="Ref" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                              <asp:BoundField DataField="envioEspecial_cliente" HeaderText="Ref" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                              <asp:BoundField DataField="precioEnvio_cliente" HeaderText="Ref" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                              <asp:BoundField DataField="descuentoEspecial_cliente" HeaderText="Ref" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                              <asp:BoundField DataField="valorDescuento_cliente" HeaderText="Ref" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                              <asp:BoundField DataField="cantidad_compras" HeaderText="Compras" />
                          </Columns>
                      </asp:GridView>
                      </div>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Cerrar</button>
                  </div>
                </div>
              </div>
            </div>

            <!-- Modal Last 3 buys details -->
            <div class="modal fade" id="modalLastBuyDetailsGrid" tabindex="-1" role="dialog" aria-labelledby="myBuyDetailsLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myBuyDetailsLabel">Detalles de pedido</h4>
                  </div>
                  <div class="modal-body">
                      <%--Details here--%>
                      <asp:PlaceHolder runat="server" ID="buyDetailsHolder">
                          <div class="row" id="order1">
                              <div class="col-md-5 name">
                                  Cantidad:
                              </div>
                              <div class="col-md-7 value">
                                  <asp:Label runat="server" ClientIDMode="Static" ID="lbl_qtyproduct"></asp:Label>
                              </div>
                              <div class="col-md-5 name">
                                  Producto:
                              </div>
                              <div class="col-md-7 value">
                                  <asp:Label runat="server" ClientIDMode="Static" ID="lbl_product"></asp:Label>
                              </div>
                              <hr />
                          </div>
                          <p></p>
                          <div class="row hidden" id="order2">
                              <div class="col-md-5 name">
                                  Cantidad:
                              </div>
                              <div class="col-md-7 value">
                                  <asp:Label ClientIDMode="Static" runat="server" ID="lbl_qtyproduct2"></asp:Label>
                              </div>
                              <div class="col-md-5 name">
                                  Producto:
                              </div>
                              <div class="col-md-7 value">
                                  <asp:Label ClientIDMode="Static" runat="server" ID="lbl_product2"></asp:Label>
                              </div>
                              <hr />
                          </div>
                          <p></p>
                          <div class="row hidden" id="order3">
                              <div class="col-md-5 name">
                                  Cantidad:
                              </div>
                              <div class="col-md-7 value">
                                  <asp:Label ClientIDMode="Static" runat="server" ID="lbl_qtyproduct3"></asp:Label>
                              </div>
                              <div class="col-md-5 name">
                                  Producto:
                              </div>
                              <div class="col-md-7 value">
                                  <asp:Label ClientIDMode="Static" runat="server" ID="lbl_product3"></asp:Label>
                              </div>
                          </div>
                          <p></p>
                          <div class="row hidden" id="order4">
                              <div class="col-md-5 name">
                                  Cantidad:
                              </div>
                              <div class="col-md-7 value">
                                  <asp:Label ClientIDMode="Static" runat="server" ID="lbl_qtyproduct4"></asp:Label>
                              </div>
                              <div class="col-md-5 name">
                                  Producto:
                              </div>
                              <div class="col-md-7 value">
                                  <asp:Label ClientIDMode="Static" runat="server" ID="lbl_product4"></asp:Label>
                              </div>
                          </div>
                          <p></p>
                          <div class="row hidden" id="order5">
                              <div class="col-md-5 name">
                                  Cantidad:
                              </div>
                              <div class="col-md-7 value">
                                  <asp:Label ClientIDMode="Static" runat="server" ID="lbl_qtyproduct5"></asp:Label>
                              </div>
                              <div class="col-md-5 name">
                                  Producto:
                              </div>
                              <div class="col-md-7 value">
                                  <asp:Label ClientIDMode="Static" runat="server" ID="lbl_product5"></asp:Label>
                              </div>
                          </div>
                          <p></p>
                          <div class="row hidden" id="order6">
                              <div class="col-md-5 name">
                                  Cantidad:
                              </div>
                              <div class="col-md-7 value">
                                  <asp:Label ClientIDMode="Static" runat="server" ID="lbl_qtyproduct6"></asp:Label>
                              </div>
                              <div class="col-md-5 name">
                                  Producto:
                              </div>
                              <div class="col-md-7 value">
                                  <asp:Label ClientIDMode="Static" runat="server" ID="lbl_product6"></asp:Label>
                              </div>
                          </div>
                          <p></p>
                          <div class="row hidden" id="order7">
                              <div class="col-md-5 name">
                                  Cantidad:
                              </div>
                              <div class="col-md-7 value">
                                  <asp:Label ClientIDMode="Static" runat="server" ID="lbl_qtyproduct7"></asp:Label>
                              </div>
                              <div class="col-md-5 name">
                                  Producto:
                              </div>
                              <div class="col-md-7 value">
                                  <asp:Label ClientIDMode="Static" runat="server" ID="lbl_product7"></asp:Label>
                              </div>
                          </div>
                          <p></p>
                          <div class="row hidden" id="order8">
                              <div class="col-md-5 name">
                                  Cantidad:
                              </div>
                              <div class="col-md-7 value">
                                  <asp:Label ClientIDMode="Static" runat="server" ID="lbl_qtyproduct8"></asp:Label>
                              </div>
                              <div class="col-md-5 name">
                                  Producto:
                              </div>
                              <div class="col-md-7 value">
                                  <asp:Label ClientIDMode="Static" runat="server" ID="lbl_product8"></asp:Label>
                              </div>
                          </div>
                          <p></p>
                          <div class="row hidden" id="order9">
                              <div class="col-md-5 name">
                                  Cantidad:
                              </div>
                              <div class="col-md-7 value">
                                  <asp:Label ClientIDMode="Static" runat="server" ID="lbl_qtyproduct9"></asp:Label>
                              </div>
                              <div class="col-md-5 name">
                                  Producto:
                              </div>
                              <div class="col-md-7 value">
                                  <asp:Label ClientIDMode="Static" runat="server" ID="lbl_product9"></asp:Label>
                              </div>
                          </div>

                      </asp:PlaceHolder>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Cerrar</button>
                  </div>
                </div>
              </div>
            </div>

        </div><!-- /.col-lg-6 -->

        <div class="col-lg-12">            
            <asp:Button CssClass="pull-right btn btn-success" runat="server" id="submitBtn" Text="Sumbit" UseSubmitBehavior="true" OnClientClick="return ValidateForm();" OnClick="submitBtn_Click"/>
        </div>

        <script src="js/modernizr.custom.js" type="text/javascript"></script>
        <script type="text/javascript" src="js/jquery.plugin.min.js"></script> 
        <script type="text/javascript" src="js/jquery.datepick.js"></script>
        <script type="text/javascript" src="js/jquery.datepick-es.js"></script>
        <script>

            if (!Modernizr.touch || !Modernizr.inputtypes.date) {
                //alert("called");
                //$('#edit_OrderDate').datepick({ dateFormat: "dd/mm/yy" });                

                $('#orderDate').datepick($.extend({
                    renderer: $.datepick.themeRollerRenderer,
                    altFormat: 'DD, d MM, yyyy'
                },
                $.datepick.regionalOptions['es']));
            }

            function isNumberKey(evt) {
                var charCode = (evt.which) ? evt.which : event.keyCode;
                if (charCode != 46 && charCode > 31
                  && (charCode < 48 || charCode > 57))
                    return false;

                return true;
            }

            /* ------ Start Client-Side Form Validate ------ */
            function ValidateForm() {

                if ($('#ruteDropD').val() == 0) {
                    $('#clientError').removeClass('hidden');
                    $('#clientErrorMsg').html('Elije una ruta');
                    return false;
                }
                
                //if ($('#brandDropD').val() == 0) {
                //    $('#clientError').removeClass('hidden');
                //    $('#clientErrorMsg').html('Elije una marca');
                //    return false;
                //}
                if ($('#productDropD').val() == 0) {
                    $('#clientError').removeClass('hidden');
                    $('#clientErrorMsg').html('Elije un producto');
                    return false;
                }
                
                if ($('#brandDropD').val() == 0) {
                    $('#clientError').removeClass('hidden');
                    $('#clientErrorMsg').html('Elije una marca');
                    return false;
                }
                
                for (var i = 2; i < 10; i++)
                {
                    if ($('#productDropD' + i).val() == 0 && $('#qtyP'+i).val() > 0) {
                        $('#clientError').removeClass('hidden')
                        $('#clientErrorMsg').html('Producto ' + i + ' invalido');
                        return false;
                    }
                }

                return true;
            }
            /* ------ End Client-Side Form Validate ------ */

            /* ------ Start ClientsGrid click to collapse ------ */
            $("#clientsGrid tr").click(function (e) {
                $('#infoClientSpan').click();
                $('#dirClientSpan').click();
            });
            /* ------ End ClientsGrid click to collapse ------ */

            /* ------ Start cog spin when loading ClientsGrid ------ */
            $('#firstNameSearch').click(function (e) {
                $('#faFirstName').removeClass('fa-search').addClass('fa-cog fa-spin');
            });

            $("#lastNameSearch").click(function (e) {
                $('#faLastName').removeClass('fa-search').addClass('fa-cog fa-spin');
            });

            $("#phoneSearch").click(function (e) {
                $('#faPhone').removeClass('fa-search').addClass('fa-cog fa-spin');
            });

            $("#mobileSearch").click(function (e) {
                $('#faMobile').removeClass('fa-search').addClass('fa-cog fa-spin');
            });
            /* ------ End cog spin when loading ClientsGrid ------ */
            
            // Click Status: Programado
            $(function () {
                $('#option1').click();
            });

            /* ------ Start Clickable Collapsable panels ------ */
            $(document).on('click', '.panel-heading.clickable', function (e) {
                    var $this = $(this);
                    if (!$this.hasClass('panel-collapsed')) {
                        $this.parents('.panel').find('.panel-body').slideUp();
                        $this.addClass('panel-collapsed');
                        $this.children('span').find('i').removeClass('fa-chevron-up').addClass('fa-chevron-down');
                    } else {
                        $this.parents('.panel').find('.panel-body').slideDown();
                        $this.removeClass('panel-collapsed');
                        $this.children('span').find('i').removeClass('fa-chevron-down').addClass('fa-chevron-up');
                    }
            })
            /* ------ End Clickable Collapsable panels ------ */

            /* ------ Start Add/Remove product inputs ------ */
            $('.shipbox').click(function () {
                $('#productsSelectDiv').trigger('change');
            });
            $('.discbox').click(function () {
                $('#productsSelectDiv').trigger('change');
            });

            var productInputCount = 1;
            $('#removeProductInputBtn').prop('disabled', true);
            function addProductInput() {
                productInputCount++;
                var rowString = '#rowP' + productInputCount;
                var hrString = '#hrProduct' + productInputCount;
                var qtyPString = "#qtyP" + productInputCount;
                $(rowString).removeClass('hidden');
                $(hrString).removeClass('hidden');

                $(qtyPString).attr('min', 1);
                $(qtyPString).val('1');

                $('#removeProductInputBtn').prop('disabled', false);
            }

            function removeProductInput() {
                if (productInputCount != 1) {
                    var rowString = '#rowP' + productInputCount;
                    var hrString = '#hrProduct' + productInputCount;
                    var productDropD = '#productDropD' + productInputCount;
                    var typeDropD = '#typeDropD' + productInputCount;
                    
                    var qtyPString = "#qtyP" + productInputCount;
                    $(productDropD + ' option:eq(0)').prop('selected', 'selected');
                    $(typeDropD + ' option:eq(0)').prop('selected', 'selected');

                    $("#productsSelectDiv").trigger('change');

                    $(rowString).addClass('hidden');
                    $(hrString).addClass('hidden');

                    $(qtyPString).attr('min', 0);
                    $(qtyPString).val(0);

                    productInputCount--;

                    if(productInputCount == 1)
                        $('#removeProductInputBtn').prop('disabled', true);
                }
            }
            /* ------ End Add/Remove product inputs ------ */

            /* ------ Start Calculate product inputs ------ */
            var productPrice = 0.0;
            var productPrice2 = 0.0;
            var productPrice3 = 0.0;
            var productPrice4 = 0.0;
            var productPrice5 = 0.0;
            var productPrice6 = 0.0;
            var productPrice7 = 0.0;
            var productPrice8 = 0.0;
            var productPrice9 = 0.0;

            var typePrice = 0.0;
            var typePrice2 = 0.0;
            var typePrice3 = 0.0;
            var typePrice4 = 0.0;
            var typePrice5 = 0.0;
            var typePrice6 = 0.0;
            var typePrice7 = 0.0;
            var typePrice8 = 0.0;
            var typePrice9 = 0.0;

            var shippingPrice = parseFloat($('#shippingPrice').val());
            var discPrice = parseFloat($('#discPrice').val());

            var totalProductPrice = 0.0;
            var subTotal = 0.0;
            $("#productsSelectDiv").change(function () {
                //currentTotal = $('#productDropD').val()
                productPrice = parseFloat($('#productDropD').val());
                productPrice2 = parseFloat($('#productDropD2').val());
                productPrice3 = parseFloat($('#productDropD3').val());
                productPrice4 = parseFloat($('#productDropD4').val());
                productPrice5 = parseFloat($('#productDropD5').val());
                productPrice6 = parseFloat($('#productDropD6').val());
                productPrice7 = parseFloat($('#productDropD7').val());
                productPrice8 = parseFloat($('#productDropD8').val());
                productPrice9 = parseFloat($('#productDropD9').val());

                typePrice = parseFloat($('#typeDropD').val());
                typePrice2 = parseFloat($('#typeDropD2').val());
                typePrice3 = parseFloat($('#typeDropD3').val());
                typePrice4 = parseFloat($('#typeDropD4').val());
                typePrice5 = parseFloat($('#typeDropD5').val());
                typePrice6 = parseFloat($('#typeDropD6').val());
                typePrice7 = parseFloat($('#typeDropD7').val());
                typePrice8 = parseFloat($('#typeDropD8').val());
                typePrice9 = parseFloat($('#typeDropD9').val());

                productPrice = productPrice + ((typePrice/100) * productPrice);
                productPrice2 = productPrice2 + ((typePrice2/100) * productPrice2);
                productPrice3 = productPrice3 + ((typePrice3/100) * productPrice3);
                productPrice4 = productPrice4 + ((typePrice4/100) * productPrice4);
                productPrice5 = productPrice5 + ((typePrice5/100) * productPrice5);
                productPrice6 = productPrice6 + ((typePrice6/100) * productPrice6);
                productPrice7 = productPrice7 + ((typePrice7/100) * productPrice7);
                productPrice8 = productPrice8 + ((typePrice8/100) * productPrice8);
                productPrice9 = productPrice9 + ((typePrice9/100) * productPrice9);

                //unitPriceProduct
                // Set to Hidden Inputs [per unit]
                $('#unitPriceProduct').val(productPrice);
                $('#unitPriceProduct2').val(productPrice2);
                $('#unitPriceProduct3').val(productPrice3);
                $('#unitPriceProduct4').val(productPrice4);
                $('#unitPriceProduct5').val(productPrice5);
                $('#unitPriceProduct6').val(productPrice6);
                $('#unitPriceProduct7').val(productPrice7);
                $('#unitPriceProduct8').val(productPrice8);
                $('#unitPriceProduct9').val(productPrice9);

                productPrice = productPrice * parseFloat($('#qtyP').val());
                productPrice2 = productPrice2 * parseFloat($('#qtyP2').val());
                productPrice3 = productPrice3 * parseFloat($('#qtyP3').val());
                productPrice4 = productPrice4 * parseFloat($('#qtyP4').val());
                productPrice5 = productPrice5 * parseFloat($('#qtyP5').val());
                productPrice6 = productPrice6 * parseFloat($('#qtyP6').val());
                productPrice7 = productPrice7 * parseFloat($('#qtyP7').val());
                productPrice8 = productPrice8 * parseFloat($('#qtyP8').val());
                productPrice9 = productPrice9 * parseFloat($('#qtyP9').val());

                // Set individual prices
                $("#price_p1").text(productPrice.toFixed(3));
                $("#price_p2").text(productPrice2.toFixed(3));
                $("#price_p3").text(productPrice3.toFixed(3));
                $("#price_p4").text(productPrice4.toFixed(3));
                $("#price_p5").text(productPrice5.toFixed(3));
                $("#price_p6").text(productPrice6.toFixed(3));
                $("#price_p7").text(productPrice7.toFixed(3));
                $("#price_p8").text(productPrice8.toFixed(3));
                $("#price_p9").text(productPrice9.toFixed(3));

                if ($('.shipbox').prop('checked')) {
                    shippingPrice = parseFloat($('#shippingPrice').val());
                }
                else
                    shippingPrice = 0.0;

                if ($('.discbox').prop('checked')) {
                    discPrice = parseFloat($('#discPrice').val());
                    subTotal = productPrice + productPrice2 + productPrice3 + productPrice4 + productPrice5 + productPrice6 + productPrice7 + productPrice8 + productPrice9;
                    totalProductPrice = (subTotal - (subTotal * (discPrice / 100))) + shippingPrice;
                }
                else {
                    discPrice = 0.0;
                    subTotal = productPrice + productPrice2 + productPrice3 + productPrice4 + productPrice5 + productPrice6 + productPrice7 + productPrice8 + productPrice9;
                    totalProductPrice = subTotal + shippingPrice;
                }

                //totalProductPrice = productPrice + productPrice2 + productPrice3 + productPrice4 + productPrice5 + productPrice6 + productPrice7 + productPrice8 + productPrice9 + shippingPrice;
                $('#labelCurrentTotal').text('$' + totalProductPrice.toFixed(2));

                // Set to Hidden Inputs
                $('#productPrice').val(productPrice);
                $('#productPrice2').val(productPrice2);
                $('#productPrice3').val(productPrice3);
                $('#productPrice4').val(productPrice4);
                $('#productPrice5').val(productPrice5);
                $('#productPrice6').val(productPrice6);
                $('#productPrice7').val(productPrice7);
                $('#productPrice8').val(productPrice8);
                $('#productPrice9').val(productPrice9);
                $('#finalSubTotalPrice').val(subTotal);
                $('#totalProductPrice').val(totalProductPrice);
                $('#finalshippingPrice').val(shippingPrice);
                $('#finaldiscPrice').val(discPrice);

            });
            /* ------ End Calculate product inputs ------ */

            /* ------ Start Managing last 3 buys ------ */

            $(".detailsBtn").click(function () {
                var data = [];
                $(this).parent().parent('tr').find('td').each(function () {
                    var textval = $(this).text(); // this will be the text of each <td>
                    data.push(textval);
                });
                var i;
                var n = 2;

                // Hide order again in order to show only what is needed
                for (i = 0; i < 9; i++) {
                    $('#order' + n).addClass('hidden');
                    n++
                }

                //data[3] = Total
                //data[4] = Product
                //data[5] = Type
                //data[6] = Qty

                $('#lbl_product').text(data[4] + " [" + data[5] + "]");
                $('#lbl_qtyproduct').text(data[6]);

                
                var n_product = 7;
                var n_type = 8;
                var n_qty = 9;
                var n = 2;
                for (i = 0; i < 9; i++) {
                    if (data[n_product].trim().length == 0) {
                        break;
                    }

                    $('#lbl_product' + n).text(data[n_product] + " [" + data[n_type] + "]");
                    $('#lbl_qtyproduct' + n).text(data[n_qty]);

                    $('#order' + n).removeClass('hidden');
                    n++;
                    n_product = n_product + 3;
                    n_type = n_type + 3;
                    n_qty = n_qty + 3;
                }

                data;
                $('#modalLastBuyDetailsGrid').modal('show');
            });

            /* ------ End  Managing last 3 buys ------ */

            /* -------- Start Button Checkbox for shipping price --------*/

            $(function () {
                $('.button-checkbox').each(function () {

                    // Settings
                    var $widget = $(this),
                        $button = $widget.find('button'),
                        $checkbox = $widget.find('input:checkbox'),
                        color = $button.data('color'),
                        settings = {
                            on: {
                                icon: 'fa fa-check-square-o'
                            },
                            off: {
                                icon: 'fa fa-square-o'
                            }
                        };

                    // Event Handlers
                    $button.on('click', function () {
                        $checkbox.prop('checked', !$checkbox.is(':checked'));
                        $checkbox.triggerHandler('change');
                        $('#productsSelectDiv').trigger('change');
                        updateDisplay();
                    });
                    $checkbox.on('change', function () {
                        updateDisplay();
                    });

                    // Actions
                    function updateDisplay() {
                        var isChecked = $checkbox.is(':checked');

                        // Set the button's state
                        $button.data('state', (isChecked) ? "on" : "off");

                        // Set the button's icon
                        $button.find('.state-icon')
                            .removeClass()
                            .addClass('state-icon ' + settings[$button.data('state')].icon);

                        // Update the button's color
                        if (isChecked) {
                            $button
                                .removeClass('btn-default')
                                .addClass('btn-' + color + ' active');

                            if ($('#shipBtn').hasClass('btn-success'))
                                $('#price_shipping').text('+ $' + $('#shippingPrice').val()).addClass('text-success');
                            if ($('#discBtn').hasClass('btn-success'))
                                $('#disc_price').text('-' + $('#discPrice').val() + '%').addClass('text-info')

                        }
                        else {
                            $button
                                .removeClass('btn-' + color + ' active')
                                .addClass('btn-default');

                            if ($('#shipBtn').hasClass('btn-default'))
                                $('#price_shipping').text('$0').removeClass('text-success');
                            if ($('#discBtn').hasClass('btn-default'))
                                $('#disc_price').text('0%').removeClass('text-info');
                        }
                    }

                    // Initialization
                    function init() {

                        updateDisplay();

                        // Inject the icon if applicable
                        if ($button.find('.state-icon').length == 0) {
                            $button.prepend('<i class="state-icon ' + settings[$button.data('state')].icon + '"></i> ');
                        }
                    }
                    init();
                });
            });

            /* -------- End Button Checkbox for shipping price --------*/

            /* -------- Masks --------*/
            $.mask.definitions['A'] = '[A-Z]';
            $("#plano").mask("999a9");
            $("#postalCode").mask("99999");
            /* -------- /Masks --------*/

            // Tooltips
            $(document).ready(function () {
                $("[rel=tooltip]").tooltip({ placement: 'left' });
            });
            // Tooltips
            $(document).ready(function () {
                $("[rel=tooltip-top]").tooltip({ placement: 'top' });
            });

        </script>
    </div> <!-- /.wrapper -->
</asp:Content>