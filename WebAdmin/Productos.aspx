<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Productos.aspx.cs" Inherits="WebAdmin.Tipos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div id="page-wrapper">
        
        <div id="productNameError" class="alert alert-danger hidden">
              Da un nombre al producto <span id="brandHideError" class="pull-right fa fa-times hideError"></span>
        </div>        
        
        <div id="priceError" class="alert alert-danger hidden">
              Precio del producto no peude estar vacio <span id="distNamedHideError" class="pull-right fa fa-times hideError"></span>
        </div> 
             
        <div class="row">
            <div class="col-lg-12">
                <h1>Productos <small>Administracion de catalogos | Prodcutos</small></h1>
                <ol class="breadcrumb">
                    <li><a href="Dashboard"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                    <li><a href="#"><i class="fa fa-book"></i> Catalogos</a></li>
                    <li class="active"><i class="fa fa-ticket"></i> Tipo</li>
                </ol>
            </div>
        </div><!-- /.row Titulo de aspx -->

        <div class="col-lg-4">
            <div class="panel panel-danger">
              <div class="panel-heading">
                <h3 class="panel-title">Eliminar un producto</h3>
                  <span class="pull-right clickable"><i class="fa fa-chevron-up"></i></span>
              </div>
              <div class="panel-body">
                    <asp:DropDownList ID="productDrop" AppendDataBoundItems="true" ClientIDMode="Static" runat="server" CssClass="form-control">
                            <asp:ListItem Value="0">Selecciona tipo de producto</asp:ListItem>
                    </asp:DropDownList>
                  <p></p>
                    <asp:Button runat="server"  id="deleteProductdBtn" Text="Eliminar" OnClick="deleteProductdBtn_Click"/>
              </div>
            </div>
            <div class="panel panel-success">
              <div class="panel-heading">
                <h3 class="panel-title">Agregar un producto</h3>
                  <span class="pull-right clickable"><i class="fa fa-chevron-up"></i></span>
              </div>
              <div class="panel-body">
                  <!-- Remove brand select in order to get the distribuitor brand of the user -->
                  <% if (User.Identity.Name.Equals("admin"))
                     {
                         brandInputFieldDiv.Visible = true;
                         autoBrand.Visible = false; 
                     }%>
                  <div runat="server" visible="false" id="brandInputFieldDiv" class="input-group">
                      <asp:DropDownList ID="brandInputField" AppendDataBoundItems="true" ClientIDMode="Static" runat="server" CssClass="form-control" >
                            <asp:ListItem Value="0">Selecciona una marca</asp:ListItem>
                    </asp:DropDownList>
                  </div>
                  <div runat="server" id="autoBrand" class="input-group">
                      Marca: <asp:Label runat="server" ID="userBrand"></asp:Label>
                  </div>
                  <p></p>
                  <div class="input-group">
                      <span class="input-group-addon"><i class="fa fa-star"></i></span>
                      <asp:TextBox ID="prodInputField" runat="server" CssClass="form-control" placeholder="Nombre" ClientIDMode="Static">
                      </asp:Textbox>
                  </div>
                  <p></p>
                  <div class="input-group">
                      <span class="input-group-addon"><i class="fa fa-dollar"></i></span>
                      <asp:TextBox ID="prodPriceField" runat="server" CssClass="form-control" placeholder="Precio" ClientIDMode="Static">
                      </asp:Textbox>
                  </div>
                  <p></p>
                  <div class="input-group">
                      <span class="input-group-addon"><i class="fa fa-list-alt"></i></span>
                      <asp:TextBox ID="prodDescField" runat="server" CssClass="form-control" placeholder="Descripcion (opcional)" ClientIDMode="Static">
                      </asp:Textbox>
                  </div>
                  <p></p>
                  <asp:Button runat="server" id="addProdBtn" OnClientClick="return validateProducts();" Text="Agregar" OnClick="addProdBtn_Click"/>
              </div>
            </div>
            <div class="panel panel-warning">
              <div class="panel-heading">
                <h3 class="panel-title">Modificar propiedades</h3>
                  <span class="pull-right clickable"><i class="fa fa-chevron-up"></i></span>
              </div>
              <div class="panel-body">
                    <asp:DropDownList ID="productDropEdit" onchange="changeEdit()" AppendDataBoundItems="true" ClientIDMode="Static" runat="server" CssClass="form-control" >
                            <asp:ListItem Value="0">Selecciona un producto</asp:ListItem>
                    </asp:DropDownList>
                    <div id="updateFeilds" class="hidden">
                        <%--<div class="input-group">
                          <span class="input-group-addon"><i class="fa fa-ticket"></i></span>
                          <asp:TextBox ID="editProdName" runat="server" CssClass="form-control" placeholder="Nombre" ClientIDMode="Static">
                          </asp:Textbox>
                        </div>--%>
                        <p></p>
                        <div class="input-group">
                          <span class="input-group-addon"><i class="fa fa-dollar"></i></span>
                          <asp:TextBox ID="editProdPrice" runat="server" CssClass="form-control" placeholder="Precio" ClientIDMode="Static">
                          </asp:Textbox>
                        </div>
                        <p></p>
                        <div class="input-group">
                          <span class="input-group-addon"><i class="fa fa-list-alt"></i></span>
                          <asp:TextBox ID="editProdDesc" runat="server" CssClass="form-control" placeholder="Descripcion" ClientIDMode="Static">
                          </asp:Textbox>
                        </div>
                    </div>
                    <p></p>
                    <asp:Button runat="server" id="updaeProdBtn" Text="Actualizar" OnClick="updaeProdBtn_Click"/>
              </div>
            </div>
          </div>
        <div class="col-lg-8">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    Marcas
                </div>
                <!-- /.panel-heading -->
                <div class="panel-body">
                    <div id="dvGrid" class="table-responsive">
                        <asp:GridView id="ProductosGridView" ClientIDMode="Static" 
                            autogeneratecolumns="false"
                            runat="server"
                            CssClass="table table-hover table-striped table-bordered">
                            <Columns>
                                <asp:BoundField DataField="id_producto" HeaderText="ID" />                                                     
                                <asp:BoundField DataField="nombre_producto" HeaderText="Nombre"/>
                                <asp:BoundField DataField="descripcion_producto" HeaderText="Descripcion" />
                                <asp:BoundField DataField="precioUnitario_producto" HeaderText="Precio" />
                                <asp:BoundField DataField="nombre_marca" HeaderText="Marca" /> 
                            </Columns>
                        </asp:GridView>
                    </div>
                    <!-- /.table-responsive -->
                </div>
                <!-- /.panel-body -->
            </div>
            <!-- /.panel -->
        </div>

        <script type="text/javascript">
            function changeEdit() {
                var a  = $("#productDropEdit").val()
                if ($("#productDropEdit").val() != 0)
                    $("#updateFeilds").removeClass('hidden');
                else
                    $("#updateFeilds").addClass('hidden');
            }

            function validateProducts() {
                if ($('#prodInputField').val().trim() <= 0) {
                    $('#productNameError').removeClass('hidden');
                    return false;
                }

                if ($('#prodPriceField').val() == 0) {
                    $('#priceError').removeClass('hidden');
                    return false;
                }

                return true;
            }

            $('.hideError').on('click', function () {
                $(this).parent().addClass('hidden');
            });

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

        </script>

        </div> <!-- / wrapper -->
</asp:Content>
