<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Rutas.aspx.cs" Inherits="WebAdmin.Rutas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div id="page-wrapper">
        
        <div class="row">
            <div class="col-lg-12">
                <h1>Rutas <small>Administracion de catalogos | Rutas</small></h1>
                <ol class="breadcrumb">
                    <li><a href="Dashboard"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                    <li><a href="#"><i class="fa fa-book"></i> Catalogos</a></li>
                    <li class="active"><i class="fa fa-arrows"></i> Rutas</li>
                </ol>
            </div>
        </div><!-- /.row Titulo de aspx -->

        <div class="col-lg-4">
            <div class="panel panel-danger">
              <div class="panel-heading">
                  <h3 class="panel-title">Eliminar Ruta</h3>
                  <span class="pull-right clickable"><i class="fa fa-chevron-up"></i></span>
              </div>
              <div class="panel-body">
                <div class="table-responsive">
                    <asp:DropDownList ID="dropDelete" AppendDataBoundItems="true" ClientIDMode="Static" runat="server" CssClass="table table-hover table-striped tablesorter">
                            <asp:ListItem Value="0">Selecciona una ruta</asp:ListItem>
                    </asp:DropDownList>
                    <asp:Button runat="server" id="deleteBtn" Text="Eliminar" OnClick="deleteBtn_Click"/>
                </div>
              </div>
            </div>
            <div class="panel panel-success">
              <div class="panel-heading">
                  <h3 class="panel-title">Agregar nueva ruta</h3>
                  <span class="pull-right clickable"><i class="fa fa-chevron-up"></i></span>
              </div>
              <div class="panel-body">
                  <div class="input-group">
                      <span class="input-group-addon"><i class="fa fa-arrows"></i></span>
                      <asp:TextBox ID="InputField" runat="server" CssClass="form-control" placeholder="Nombre" ClientIDMode="Static">
                      </asp:Textbox>
                  </div>
                  <p></p>
                  <div class="input-group">
                      <span class="input-group-addon"><i class="fa fa-list-alt"></i></span>
                      <asp:TextBox ID="DescField" runat="server" CssClass="form-control" placeholder="Descripcion (opcional)" ClientIDMode="Static">
                      </asp:Textbox>
                  </div>
                  <p></p>
                  <asp:Button runat="server" id="addBtn" Text="Agregar" OnClick="addBtn_Click"/>
              </div>
            </div>
            <div class="panel panel-warning">
              <div class="panel-heading">
                  <h3 class="panel-title">Propiedades de ruta</h3>
                  <span class="pull-right clickable"><i class="fa fa-chevron-up"></i></span>
              </div>
              <div class="panel-body">
                  <asp:DropDownList ID="DropEdit" onchange="changeEdit()" AppendDataBoundItems="true" ClientIDMode="Static" runat="server" CssClass="table table-hover table-striped tablesorter">
                      <asp:ListItem Value="0">Selecciona una ruta</asp:ListItem>
                  </asp:DropDownList>
                  <div id="updateFeilds" class="hidden">
                        <%--<div class="input-group">
                          <span class="input-group-addon"><i class="fa fa-ticket"></i></span>
                          <asp:TextBox ID="editProdName" runat="server" CssClass="form-control" placeholder="Nombre" ClientIDMode="Static">
                          </asp:Textbox>
                        </div>--%>
                        <div class="input-group">
                          <span class="input-group-addon"><i class="fa fa-list-alt"></i></span>
                          <asp:TextBox ID="editDesc" runat="server" CssClass="form-control" placeholder="Descripcion" ClientIDMode="Static">
                          </asp:Textbox>
                        </div>
                    </div>
                    <p></p>
                    <asp:Button runat="server" id="updateBtn" Text="Actualizar" OnClick="updateBtn_Click"/>
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
                        <asp:GridView id="gridView" ClientIDMode="Static" 
                            autogeneratecolumns="false"
                            runat="server"
                            CssClass="table table-hover table-striped table-bordered">
                            <Columns>
                                <asp:BoundField DataField="id" HeaderText="ID" />                                                     
                                <asp:BoundField DataField="nombre" HeaderText="Nombre"/>
                                <asp:BoundField DataField="descripcion" HeaderText="Descripcion" />
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
                var a = $("#productDropEdit").val()
                if ($("#productDropEdit").val() == 0)
                    $("#updateFeilds").addClass('hidden');
                else
                    $("#updateFeilds").removeClass('hidden');
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
