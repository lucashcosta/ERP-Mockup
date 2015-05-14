<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Distribuidores.aspx.cs" Inherits="WebAdmin.Distribuidores" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div id="page-wrapper">
        <div id="brandErrorMsg" class="alert alert-danger hidden">
              Elije una marca <span id="brandHideError" class="pull-right fa fa-times hideError"></span>
        </div>        
        <div id="distNameErrorMsg" class="alert alert-danger hidden">
              Da un nombre al distribuidor <span id="distNamedHideError" class="pull-right fa fa-times hideError"></span>
        </div> 
        <div class="row">
            <div class="col-lg-12">
                <h1>Distribuidores <small>Administracion de catalogos | Distribuidores</small></h1>
                <ol class="breadcrumb">
                    <li><a href="Dashboard"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                    <li><a href="#"><i class="fa fa-book"></i> Catalogos</a></li>
                    <li class="active"><i class="fa fa-building-o"></i> Distribuidores</li>
                </ol>
            </div>
        </div><!-- /.row Titulo de aspx -->

        <div class="col-lg-4">
            <div class="panel panel-danger">
              <div class="panel-heading">
                <h3 class="panel-title">Eliminar distribuidor</h3>
                  <span class="pull-right clickable"><i class="fa fa-chevron-up"></i></span>
              </div>
              <div class="panel-body">
                    <asp:DropDownList ID="productDrop" AppendDataBoundItems="true" ClientIDMode="Static" runat="server" CssClass="form-control">
                            <asp:ListItem Value="0">Selecciona un distribuidor</asp:ListItem>
                    </asp:DropDownList>
                  <p></p>
                    <asp:Button runat="server"  id="deleteProductdBtn" Text="Eliminar" OnClick="deleteProductdBtn_Click"/>
              </div>
            </div>
            <div class="panel panel-success">
              <div class="panel-heading">
                <h3 class="panel-title">Agregar distribuidor</h3>
                  <span class="pull-right clickable"><i class="fa fa-chevron-up"></i></span>
              </div>
              <div class="panel-body">
                  <div class="input-group">
                      <asp:DropDownList ID="brandInputField" AppendDataBoundItems="true" ClientIDMode="Static" runat="server" CssClass="form-control" >
                            <asp:ListItem Value="0">Enlace con una marca</asp:ListItem>
                      </asp:DropDownList>
                  </div>
                  <p></p>
                  <div class="input-group">
                      <span class="input-group-addon"><i class="fa fa-building-o"></i></span>
                      <asp:TextBox ID="prodNameField" runat="server" CssClass="form-control" placeholder="Nombre" ClientIDMode="Static">
                      </asp:Textbox>
                  </div>
                  <p></p>
                  <div class="input-group">
                      <span class="input-group-addon"><i class="fa fa-list-alt"></i></span>
                      <asp:TextBox TextMode="MultiLine" ID="prodDirField" runat="server" CssClass="form-control" placeholder="Direccion" ClientIDMode="Static">
                      </asp:TextBox>
                  </div>
                  <p></p>
                  <asp:Button runat="server" id="addProdBtn" Text="Agregar" OnClientClick="return validateDist();" OnClick="addProdBtn_Click"/>
              </div>
            </div>
            <div class="panel panel-warning">
              <div class="panel-heading">
                <h3 class="panel-title">Modificar propiedades</h3>
                  <span class="pull-right clickable"><i class="fa fa-chevron-up"></i></span>
              </div>
              <div class="panel-body">
                    <asp:DropDownList ID="productDropEdit" onchange="changeEdit()" AppendDataBoundItems="true" ClientIDMode="Static" runat="server" CssClass="form-control" >
                            <asp:ListItem Value="0">Selecciona un distribuidor</asp:ListItem>
                    </asp:DropDownList>
                    <div id="updateFeilds" class="hidden">
                        <%--<div class="input-group">
                          <span class="input-group-addon"><i class="fa fa-building-o"></i></span>
                          <asp:TextBox ID="editProdName" runat="server" CssClass="form-control" placeholder="Nombre" ClientIDMode="Static">
                          </asp:Textbox>
                        </div>--%>
                        <p></p>
                        <div class="input-group">
                          <span class="input-group-addon"><i class="fa fa-building-o"></i></span>
                          <asp:TextBox ID="editProdName" runat="server" CssClass="form-control" placeholder="Nombre" ClientIDMode="Static">
                          </asp:Textbox>
                        </div>
                        <p></p>
                        <div class="input-group">
                          <span class="input-group-addon"><i class="fa fa-list-alt"></i></span>
                          <asp:TextBox TextMode="MultiLine" ID="editProdDir" runat="server" CssClass="form-control" placeholder="Direccion" ClientIDMode="Static">
                          </asp:TextBox>
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
                    Distribuidores
                </div>
                <!-- /.panel-heading -->
                <div class="panel-body">
                    <div id="dvGrid" class="table-responsive">
                        <asp:GridView id="ProductosGridView" ClientIDMode="Static" 
                            autogeneratecolumns="false"
                            runat="server"
                            CssClass="table table-hover table-striped table-bordered">
                            <Columns>
                                <asp:BoundField DataField="id_distribuidor" HeaderText="ID" />                                                     
                                <asp:BoundField DataField="nombre_distribuidor" HeaderText="Nombre"/>
                                <asp:BoundField DataField="id_marca" HeaderText="ID Marca" />
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

            function validateDist() {
                if ($('#brandInputField').val() == 0) {
                    $('#brandErrorMsg').removeClass('hidden');
                    return false;
                }

                if ($('#prodNameField').val().trim() <= 0) {
                    $('#distNameErrorMsg').removeClass('hidden');
                    return false;
                }

                return true;
            }

            $('.hideError').on('click', function () {
                $(this).parent().addClass('hidden');
            });

            function changeEdit() {
                var a = $("#productDropEdit").val()
                if ($("#productDropEdit").val() != 0)
                    $("#updateFeilds").removeClass('hidden');
                else
                    $("#updateFeilds").addClass('hidden');
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

        </script>

        </div> <!-- / wrapper -->
</asp:Content>