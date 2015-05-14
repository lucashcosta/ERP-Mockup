<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditarCliente.aspx.cs" Inherits="WebAdmin.EditarCliente" EnableEventValidation = "false" ValidateRequest="false"%>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" type="text/css" href="/css/jquery.datepick.css"> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div id="page-wrapper">
        <asp:Panel ID="panelMessage" runat="server" Visible="false"> 
            <h4 id="messagesText" class="alert-info" runat="server">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <asp:Label ID="lblMessage" ClientIDMode="Static" runat="server" Text=""></asp:Label>
            </h4> 
        </asp:Panel>

        <div class="row">
            <div class="col-lg-12">
                <h1>Cliente <small>Detalles de Cliente</small></h1>
                <ol class="breadcrumb">
                    <li><a href="Dashboard"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                    <li><a href="#"><i class="fa fa-book"></i> Catalogos</a></li>
                    <li><a href="Clientes"><i class="fa fa-users"></i> Clientes</a></li>
                    <li class="active"><i class="fa fa-search-plus"></i> Detalles</li>
                </ol>
            </div>
        </div><!-- /.row Titulo de aspx -->
         <div class="bs-example">
             <ul class="nav nav-tabs" style="margin-bottom: 15px;">
                  <%--<li><a href="#detalles" data-toggle="tab">Detalles</a></li>--%>
                  <li class="active"><a href="#editOrder" data-toggle="tab">Editar Cliente</a></li>
                  <li><a href="#func" data-toggle="tab">Funciones</a></li>
                  <li><a href="#hist" data-toggle="tab">Historial</a></li>
             </ul>
             <div id="myTabContent" class="tab-content">
                 <div class="tab-pane fade active in" id="editOrder">
                     <div class="col-md-12">
                        <div class="panel panel-success">
                          <div class="panel-heading clickable">
                              <h3 class="panel-title">Modificar cliente</h3>
                              <span class="pull-right"><i class="fa fa-chevron-up"></i></span>
                          </div>
                          <div class="panel-body">
                              <div class="input-group has-feedback">
                                  <span class="input-group-addon"><i class="fa fa-user"></i></span>
                                  <asp:TextBox ID="firstNameInput" rel="tooltip-top" title="Nombre(s)" runat="server" CssClass="form-control required" placeholder="Nombre" ClientIDMode="Static" >
                                  </asp:Textbox>
                                  <span class="input-group-addon"><i class="fa fa-asterisk"></i></span>
                              </div>
                              <p></p>
                              <div class="input-group">
                                  <span class="input-group-addon"><i class="fa fa-user"></i></span>
                                  <asp:TextBox ID="lastNameInput" rel="tooltip-top" title="Apellido(s)" runat="server" CssClass="form-control required" placeholder="Apellido" ClientIDMode="Static" >
                                  </asp:Textbox>
                                  <span class="input-group-addon"><i class="fa fa-asterisk"></i></span>
                              </div>
                              <p></p>
                              <div class="input-group">
                                  <span class="input-group-addon"><i class="fa fa-phone"></i></span>
                                  <asp:TextBox ID="phoneInput" rel="tooltip-top" title="Telefono" runat="server" CssClass="form-control required" placeholder="Telefono" ClientIDMode="Static" >
                                  </asp:Textbox>
                                  <span class="input-group-addon"><i class="fa fa-asterisk"></i></span>
                              </div>
                              <p></p>
                              <div class="input-group">
                                  <span class="input-group-addon"><i class="fa fa-mobile icon-fix"></i></span>
                                  <asp:TextBox ID="mobileInput" rel="tooltip-top" title="Movíl" runat="server" CssClass="form-control" placeholder="Movil" ClientIDMode="Static" >
                                  </asp:Textbox>
                              </div>
                              <p></p>
                              <div class="input-group">
                                  <span class="input-group-addon"><i class="fa fa-map-marker icon-red"></i></span>
                                  <asp:TextBox ID="planoInput" rel="tooltip-top" title="Plano [###A#]" runat="server" CssClass="form-control" placeholder="Plano" ClientIDMode="Static" >
                                  </asp:Textbox>
                              </div>
                              <p></p>
                              <div class="input-group">
                                  <asp:TextBox ID="cityInput" rel="tooltip-top" title="Ciudad" runat="server" CssClass="form-control required" placeholder="Ciudad" ClientIDMode="Static" >
                                  </asp:Textbox>
                                  <span class="input-group-addon"><i class="fa fa-asterisk"></i></span>
                              </div>
                              <p></p>
                              <div class="input-group">
                                  <asp:TextBox ID="colonyInput" rel="tooltip-top" title="Colonia" runat="server" CssClass="form-control required" placeholder="Colonia" ClientIDMode="Static" >
                                  </asp:Textbox>
                                  <span class="input-group-addon"><i class="fa fa-asterisk"></i></span>
                              </div>
                              <p></p>
                              <div class="form-group">
                                  <asp:TextBox ID="streetInput" rel="tooltip-top" title="Calle" runat="server" CssClass="form-control" placeholder="Calle" ClientIDMode="Static" >
                                  </asp:Textbox>
                              </div>
                              <p></p>
                              <div class="input-group">
                                  <asp:TextBox ID="dirNumberInput" rel="tooltip-top" title="Numero (Direccion)" runat="server" CssClass="form-control required" placeholder="Numero (direccion)" ClientIDMode="Static" >
                                  </asp:Textbox>
                                  <span class="input-group-addon"><i class="fa fa-asterisk"></i></span>
                              </div>
                              <p></p>
                              <div class="form-group">
                                  <asp:TextBox ID="betStreetsInput" rel="tooltip-top" title="Entre calles" runat="server" CssClass="form-control" placeholder="Entre calles" ClientIDMode="Static" >
                                  </asp:Textbox>
                              </div>
                              <p></p>
                              <div class="form-group">
                                  <asp:TextBox ID="postalInput" pattern="\d*" rel="tooltip-top" title="Código Postal [#####]" onkeypress="return isNumberKey(event)" runat="server" CssClass="form-control" placeholder="Codigo Postal" ClientIDMode="Static" >
                                  </asp:Textbox>
                              </div>
                              <p></p>
                              <div class="form-group">
                                  <asp:DropDownList rel="tooltip-top" title="Ruta"  AppendDataBoundItems=True CssClass="form-control" runat="server" ID="ruteInputDropD" ClientIDMode="Static">
                                      <asp:ListItem Value="0" Text="Ruta"></asp:ListItem>
                                  </asp:DropDownList>
                              </div>
                              <p></p>
                              <div class="form-group">
                                  <asp:TextBox TextMode="MultiLine" rel="tooltip-top" title="Referencias de direccion" ID="dirRefInput" runat="server" CssClass="form-control" placeholder="Referencias direccion" ClientIDMode="Static" >
                                  </asp:TextBox>
                              </div>
                              <p></p>
                              <div class="form-group">
                                  <asp:TextBox TextMode="MultiLine" ID="notesInput" rel="tooltip-top" title="Notas de cliente" runat="server" CssClass="form-control" placeholder="Notas" ClientIDMode="Static" >
                                  </asp:TextBox>
                              </div>
                              <p></p>
                              <div class="form-group" runat="server" id="refContactoDiv" data-placement="left" >
                                    <%--<label class="">Como se entero de nosotros</label>--%>
                                    <asp:DropDownList ClientIDMode="Static" AppendDataBoundItems=True ID="contactRefDropD" runat="server" CssClass="form-control" >
                                        <asp:ListItem Value="">Medio por el cual se entero de nosotros</asp:ListItem>
                                        <asp:ListItem>TV</asp:ListItem>
                                        <asp:ListItem>Radio</asp:ListItem>
                                        <asp:ListItem>Internet</asp:ListItem>
                                        <asp:ListItem>Recomendado</asp:ListItem>
                                    </asp:DropDownList>
                              </div>
                              <p></p>
                              <div class="form-group">
                                  <span class="button-checkbox">
                                      <button type="button" id="shipBtn" class="btn" data-color="success">Envío especial</button>
                                      <input runat="server" type="checkbox" id="shipbox" class="hidden" />
                                      <p></p>
                                      <span class="form-group">
                                          <asp:TextBox runat="server" ID="shipValue" ClientIDMode="Static" onkeypress="return isNumberKey(event)" CssClass="hidden form-control" Width="150px" rel="tooltip-top" title="Precio de envío" placeholder="Precio de envío"></asp:TextBox>
                                      </span>
                                  </span>
                              </div>
                              <div class="form-group">
                                  <span class="button-checkbox">
                                      <button type="button" id="discBtn" class="btn" data-color="success">Descuenta pedido</button>
                                      <input runat="server" type="checkbox" id="discbox" class="hidden" />
                                      <p></p>
                                      <span class="form-group">
                                          <asp:TextBox runat="server" MaxLength="2" ID="discValue" ClientIDMode="Static" onkeypress="return isNumberKey(event)" CssClass="hidden form-control" Width="150px" rel="tooltip-top" title="Descuento en porcentage" placeholder="Descuento"></asp:TextBox>
                                      </span>
                                  </span>
                              </div>
                              <asp:Button runat="server" id="updateBtn" Text="Actualizar" OnClientClick="return validateInputs();" OnClick="updateBtn_Click"/>
                          </div>
                        </div>
                      </div>
                 </div>
                 <div class="tab-pane fade" id="func">
                     <div class="col-md-12">
                        <div class="panel panel-primary">
                          <div class="panel-heading clickable">
                              <h3 class="panel-title">Frecuencia</h3>
                              <span class="pull-right"><i class="fa fa-chevron-up"></i></span>
                          </div>
                          <div class="panel-body">
                              <div class="col-md-6">
                                  <div class="form-group" id="estimatedTimeDiv" data-placement="left">
                                      <label class="">Lapso para autogenerar pedido</label>
                                      <input name="" type="number" id="estimatedTime" pattern="\d*" onkeypress="return isNumberKey(event)" class="form-control" placeholder="Dias" min="0">
                                      <label class="">Empezando desde</label>
                                      <%--<asp:DropDownList runat="server" ID="freqSinceDropD" ClientIDMode="Static"  CssClass="form-control">
                                          <asp:ListItem Value="1">Su ultimo pedido</asp:ListItem>
                                          <asp:ListItem Value="0">Elegir fecha</asp:ListItem>
                                      </asp:DropDownList>--%>
                                      <asp:TextBox TextMode="Date" ClientIDMode="Static" ID="orderDate" name="orderDate" runat="server" class="form-control" placeholder="Fechad de la orden"></asp:TextBox>
                                 </div>
                              </div>
                              <div class="col-md-6">
                                  <div class="form-group" id="ss" data-placement="left">
                                      <label class="">Contenido base de pedido</label>
                                      <div class="table-responsive">
                                          <asp:GridView runat="server" ID="lastBuysGrid" OnRowDataBound="lastBuysGrid_RowDataBound" AutoGenerateColumns="false" ClientIDMode="Static" CssClass="table table-panelfit table-hover table-bordered table-responsive">
                                              <Columns>

                                                  <asp:BoundField DataField="id_pedido" HeaderText="ID"/>
                                                  <asp:BoundField DataField="fechaEntrega_orden" HeaderText="Fecha entrega" />
                                                  <asp:BoundField DataField="status_orden" HeaderText="Status" />
                                                  <asp:BoundField DataField="totalProductos_orden" HeaderText="Total" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />

                                                  <asp:BoundField DataField="producto_orden" HeaderText="Producto" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                                                  <asp:BoundField DataField="tipoProducto_orden" HeaderText="Tipo" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                                                  <asp:BoundField DataField="cantidadProducto_orden" HeaderText="Cantidad" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />

                                                  <asp:BoundField DataField="producto2_orden" HeaderText="Producto" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                                                  <asp:BoundField DataField="tipoProducto2_orden" HeaderText="Tipo" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                                                  <asp:BoundField DataField="cantidadProducto2_orden" HeaderText="Cantidad" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />

                                                  <asp:BoundField DataField="producto3_orden" HeaderText="Producto" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                                                  <asp:BoundField DataField="tipoProducto3_orden" HeaderText="Tipo" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                                                  <asp:BoundField DataField="cantidadProducto3_orden" HeaderText="Cantidad" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />

                                                  <asp:BoundField DataField="producto4_orden" HeaderText="Producto" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                                                  <asp:BoundField DataField="tipoProducto4_orden" HeaderText="Tipo" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                                                  <asp:BoundField DataField="cantidadProducto4_orden" HeaderText="Cantidad" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />

                                                  <asp:BoundField DataField="producto5_orden" HeaderText="Producto" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                                                  <asp:BoundField DataField="tipoProducto5_orden" HeaderText="Tipo" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                                                  <asp:BoundField DataField="cantidadProducto5_orden" HeaderText="Cantidad" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />

                                                  <asp:BoundField DataField="producto6_orden" HeaderText="Producto" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                                                  <asp:BoundField DataField="tipoProducto6_orden" HeaderText="Tipo" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                                                  <asp:BoundField DataField="cantidadProducto6_orden" HeaderText="Cantidad" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />

                                                  <asp:BoundField DataField="producto7_orden" HeaderText="Producto" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                                                  <asp:BoundField DataField="tipoProducto7_orden" HeaderText="Tipo" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                                                  <asp:BoundField DataField="cantidadProducto7_orden" HeaderText="Cantidad" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />

                                                  <asp:BoundField DataField="producto8_orden" HeaderText="Producto" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                                                  <asp:BoundField DataField="tipoProducto8_orden" HeaderText="Tipo" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                                                  <asp:BoundField DataField="cantidadProducto8_orden" HeaderText="Cantidad" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />

                                                  <asp:BoundField DataField="producto9_orden" HeaderText="Producto" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                                                  <asp:BoundField DataField="tipoProducto9_orden" HeaderText="Tipo" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                                                  <asp:BoundField DataField="cantidadProducto9_orden" HeaderText="Cantidad" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />

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
                                      <div class="row" id="selectionorder1">
                                            <div class="col-md-5 name">
                                                Cantidad:
                                            </div>
                                            <div class="col-md-7 value">
                                                <asp:Label runat="server" ClientIDMode="Static" ID="lbl_selectionqtyproduct"></asp:Label>
                                            </div>
                                          <div class="col-md-5 name">
                                              Producto:
                                          </div>
                                          <div class="col-md-7 value">
                                              <asp:Label runat="server" ClientIDMode="Static" ID="lbl_selectionproduct"></asp:Label>
                                          </div>
                                          <hr />
                                        </div>
                                        <p></p>
                                        <div class="row hidden" id="selectionorder2">
                                            <div class="col-md-5 name">
                                                Cantidad:
                                            </div>
                                            <div class="col-md-7 value">
                                                <asp:Label ClientIDMode="Static" runat="server" ID="lbl_selectionqtyproduct2"></asp:Label>
                                            </div>
                                            <div class="col-md-5 name">
                                                Producto:
                                            </div>
                                            <div class="col-md-7 value">
                                                <asp:Label ClientIDMode="Static" runat="server" ID="lbl_selectionproduct2"></asp:Label>
                                            </div>
                                            <hr />
                                        </div>
                                        <p></p>
                                        <div class="row hidden" id="selectionorder3">
                                            <div class="col-md-5 name">
                                                Cantidad:
                                            </div>
                                            <div class="col-md-7 value">
                                                <asp:Label ClientIDMode="Static" runat="server" ID="lbl_selectionqtyproduct3"></asp:Label>
                                            </div>
                                            <div class="col-md-5 name">
                                                Producto:
                                            </div>
                                            <div class="col-md-7 value">
                                                <asp:Label ClientIDMode="Static" runat="server" ID="lbl_selectionproduct3"></asp:Label>
                                            </div>
                                        </div>
                                        <p></p>
                                        <div class="row hidden" id="selectionorder4">
                                            <div class="col-md-5 name">
                                                Cantidad:
                                            </div>
                                            <div class="col-md-7 value">
                                                <asp:Label ClientIDMode="Static" runat="server" ID="lbl_selectionqtyproduct4"></asp:Label>
                                            </div>
                                            <div class="col-md-5 name">
                                                Producto:
                                            </div>
                                            <div class="col-md-7 value">
                                                <asp:Label ClientIDMode="Static" runat="server" ID="lbl_selectionproduct4"></asp:Label>
                                            </div>
                                        </div>
                                        <p></p>
                                        <div class="row hidden" id="selectionorder5">
                                            <div class="col-md-5 name">
                                                Cantidad:
                                            </div>
                                            <div class="col-md-7 value">
                                                <asp:Label ClientIDMode="Static" runat="server" ID="lbl_selectionqtyproduct5"></asp:Label>
                                            </div>
                                            <div class="col-md-5 name">
                                                Producto:
                                            </div>
                                            <div class="col-md-7 value">
                                                <asp:Label ClientIDMode="Static" runat="server" ID="lbl_selectionproduct5"></asp:Label>
                                            </div>
                                        </div>
                                        <p></p>
                                        <div class="row hidden" id="selectionorder6">
                                            <div class="col-md-5 name">
                                                Cantidad:
                                            </div>
                                            <div class="col-md-7 value">
                                                <asp:Label ClientIDMode="Static" runat="server" ID="lbl_selectionqtyproduct6"></asp:Label>
                                            </div>
                                            <div class="col-md-5 name">
                                                Producto:
                                            </div>
                                            <div class="col-md-7 value">
                                                <asp:Label ClientIDMode="Static" runat="server" ID="lbl_selectionproduct6"></asp:Label>
                                            </div>
                                        </div>
                                        <p></p>
                                        <div class="row hidden" id="selectionorder7">
                                            <div class="col-md-5 name">
                                                Cantidad:
                                            </div>
                                            <div class="col-md-7 value">
                                                <asp:Label ClientIDMode="Static" runat="server" ID="lbl_selectionqtyproduct7"></asp:Label>
                                            </div>
                                            <div class="col-md-5 name">
                                                Producto:
                                            </div>
                                            <div class="col-md-7 value">
                                                <asp:Label ClientIDMode="Static" runat="server" ID="lbl_selectionproduct7"></asp:Label>
                                            </div>
                                        </div>
                                        <p></p>
                                        <div class="row hidden" id="selectionorder8">
                                            <div class="col-md-5 name">
                                                Cantidad:
                                            </div>
                                            <div class="col-md-7 value">
                                                <asp:Label ClientIDMode="Static" runat="server" ID="lbl_selectionqtyproduct8"></asp:Label>
                                            </div>
                                            <div class="col-md-5 name">
                                                Producto:
                                            </div>
                                            <div class="col-md-7 value">
                                                <asp:Label ClientIDMode="Static" runat="server" ID="lbl_selectionproduct8"></asp:Label>
                                            </div>
                                        </div>
                                        <p></p>
                                        <div class="row hidden" id="selectionorder9">
                                            <div class="col-md-5 name">
                                                Cantidad:
                                            </div>
                                            <div class="col-md-7 value">
                                                <asp:Label ClientIDMode="Static" runat="server" ID="lbl_selectionqtyproduct9"></asp:Label>
                                            </div>
                                            <div class="col-md-5 name">
                                                Producto:
                                            </div>
                                            <div class="col-md-7 value">
                                                <asp:Label ClientIDMode="Static" runat="server" ID="lbl_selectionproduct9"></asp:Label>
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
                              </div>
                              <div class="col-md-12">
                                  <asp:Button CssClass="pull-right btn btn-success" runat="server" id="addFuncBtn" ClientIDMode="Static" Text="Agregar función"/>
                              </div>
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
        <script type="text/javascript">

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

            function validateInputs() {
                if ($('#shipBtn').hasClass('btn-success')) {
                    if ($('#shipValue').val().trim().length <= 0) {
                        $('#shipValue').parent().addClass('has-error');
                        return false;
                    }
                }
                else {
                    $('#shipValue').parent().removeClass('has-error');
                }

                if ($('#discBtn').hasClass('btn-success')) {
                    if ($('#discValue').val().trim().length <= 0) {
                        $('#discValue').parent().addClass('has-error');
                        return false;
                    }
                }
                else {
                    $('#discValue').parent().removeClass('has-error');
                }

                var bool = true;
                $(".required").each(function () {
                    if ($(this).val().trim().length == 0) {
                        $(this).parent().removeClass('has-success');
                        $(this).parent().addClass('has-error');
                        bool = false;
                    }
                });
                return bool;
            }

            $(".required").focusout(function () {
                if ($(this).val().trim().length == 0) {
                    $(this).parent().removeClass('has-success');
                    $(this).parent().addClass('has-error');
                }
                else {
                    $(this).parent().addClass('has-success');
                    $(this).parent().removeClass('has-error');
                }
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
                        }
                        else {
                            $button
                                .removeClass('btn-' + color + ' active')
                                .addClass('btn-default');
                        }

                        if ($('#shipBtn').hasClass('btn-' + color)) {
                            $('#shipValue').removeClass('hidden');
                        }
                        else {
                            $('#shipValue').addClass('hidden');
                        }

                        if ($('#discBtn').hasClass('btn-' + color)) {
                            $('#discValue').removeClass('hidden');
                        }
                        else {
                            $('#discValue').addClass('hidden');
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
            $("#planoInput").mask("999a9");
            $("#postalInput").mask("99999");
            //$("#discValue").mask("99%");
            /* -------- /Masks --------*/

            // Tooltips
            $(document).ready(function () {
                $("[rel=tooltip]").tooltip({ placement: 'left' });
            });
            // Tooltips
            $(document).ready(function () {
                $("[rel=tooltip-top]").tooltip({ placement: 'top' });
            });

            /* ------ Start Managing last 5 buys ------ */
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

            /* ------ End  Managing last 5 buys ------ */

            /* ------ Start Managing last 5 buys selection ------ */
            var dataSelect = [];
            $(".baseRow").click(function () {
                
                $(this).find('td').each(function () {
                    var textval = $(this).text(); // this will be the text of each <td>
                    dataSelect.push(textval);
                });

                var i;
                var n = 2;

                // Hide order again in order to show only what is needed
                for (i = 0; i < 9; i++) {
                    $('#selectionorder' + n).addClass('hidden');
                    n++
                }

                //data[3] = Total
                //data[4] = Product
                //data[5] = Type
                //data[6] = Qty

                $('#lbl_selectionproduct').text(dataSelect[4] + " [" + dataSelect[5] + "]");
                $('#lbl_selectionqtyproduct').text(dataSelect[6]);


                var n_product = 7;
                var n_type = 8;
                var n_qty = 9;
                var n = 2;
                for (i = 0; i < 9; i++) {
                    if (dataSelect[n_product].trim().length == 0) {
                        break;
                    }

                    $('#lbl_selectionproduct' + n).text(dataSelect[n_product] + " [" + dataSelect[n_type] + "]");
                    $('#lbl_selectionqtyproduct' + n).text(dataSelect[n_qty]);

                    $('#selectionorder' + n).removeClass('hidden');
                    n++;
                    n_product = n_product + 3;
                    n_type = n_type + 3;
                    n_qty = n_qty + 3;
                }

            });
            /* ------ End  Managing last 5 buys selection ------ */

            /* ------ Start Calling button event to add a funciton ------ */
            function getParameterByName(name) {
                name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
                var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
                    results = regex.exec(location.search);
                return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
            }

            $("#addFuncBtn").click(function () {

                var clientId = getParameterByName('Id');
                var dateInput = $("#orderDate").val();
                var addDays = $("#estimatedTime").val();

                if (clientId.trim() == "" || dateInput.trim() == "" || addDays.trim() == "")
                    return false;

                $.ajax({
                    type: "POST",
                    url: "EditarCliente.aspx/StackRequest",
                    data: '{reqId: ' + dataSelect[0] + ', clientId: ' + clientId + ', dateInput: "' + dateInput + '", addDays: ' + addDays + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnSuccessFunc,
                    failure: function (response) {
                        alert(response.d);
                    },
                    error: function (response) {
                        alert(response.d);
                    }
                });
            });

            function OnSuccessFunc(response) {
                if (response.d == 1)
                    alert("Agregado");
            }

            /* ------ End Calling button event to add a funciton ------ */

        </script>

    </div>
</asp:Content>
