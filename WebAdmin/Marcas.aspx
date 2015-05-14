<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Marcas.aspx.cs" Inherits="WebAdmin.Catalogos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div id="page-wrapper">
        
        <div class="row">
            <div class="col-lg-12">
                <h1>Marcas <small>Administracion de catalogos</small></h1>
                <ol class="breadcrumb">
                    <li><a href="index.html"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                    <li><a href="index.html"><i class="fa fa-book"></i> Catalogos</a></li>
                    <li class="active"><i class="fa fa-star"></i> Marcas</li>
                </ol>
            </div>
        </div><!-- /.row Titulo de aspx -->

        <div class="col-lg-4">
            <div class="panel panel-danger">
              <div class="panel-heading">
                  <h3 class="panel-title">Eliminar Marca</h3>
                  <span class="pull-right clickable"><i class="fa fa-chevron-up"></i></span>
              </div>
              <div class="panel-body">
                    <asp:DropDownList ID="brandDrop" AppendDataBoundItems="true" ClientIDMode="Static" runat="server" CssClass="table table-hover table-striped tablesorter">
                            <asp:ListItem Value="0">Selecciona marca</asp:ListItem>
                    </asp:DropDownList>
                    <asp:Button runat="server" id="deleteBrandBtn" Text="Eliminar" OnClick="deleteBrandBtn_Click"/>
              </div>
            </div>
            <div class="panel panel-success">
              <div class="panel-heading">
                  <h3 class="panel-title">Agregar Marca</h3>
                  <span class="pull-right clickable"><i class="fa fa-chevron-up"></i></span>
              </div>
              <div class="panel-body">
                  <div class="input-group">
                      <span class="input-group-addon"><i class="fa fa-star"></i></span>
                      <asp:TextBox ID="brandInputField" runat="server" CssClass="form-control" placeholder="Nombre" ClientIDMode="Static">
                      </asp:Textbox>
                  </div>
                  <p></p>
                  <div class="input-group">
                      <span class="input-group-addon"><i class="fa fa-list-alt"></i></span>
                      <asp:TextBox ID="brandDescField" runat="server" CssClass="form-control" placeholder="Descripcion (opcional)" ClientIDMode="Static">
                      </asp:Textbox>
                  </div>
                  <p></p>
                  <asp:Button runat="server" id="addBrandBtn" Text="Agregar" OnClick="addBrandBtn_Click"/>
              </div>
            </div>
            <div class="panel panel-warning">
              <div class="panel-heading">
                  <h3 class="panel-title">Propiedades de marca</h3>
                  <span class="pull-right clickable"><i class="fa fa-chevron-up"></i></span>
              </div>
              <div class="panel-body">
                  <asp:DropDownList ID="brandDropEdit" onchange="changeEdit()" AppendDataBoundItems="true" ClientIDMode="Static" runat="server" CssClass="table table-hover table-striped tablesorter">
                      <asp:ListItem Value="0">Selecciona una marca</asp:ListItem>
                  </asp:DropDownList>
                  <div id="updateFeilds" class="hidden">
                        <%--<div class="input-group">
                          <span class="input-group-addon"><i class="fa fa-ticket"></i></span>
                          <asp:TextBox ID="editProdName" runat="server" CssClass="form-control" placeholder="Nombre" ClientIDMode="Static">
                          </asp:Textbox>
                        </div>--%>
                        <div class="input-group">
                          <span class="input-group-addon"><i class="fa fa-list-alt"></i></span>
                          <asp:TextBox ID="editBrandDesc" runat="server" CssClass="form-control" placeholder="Descripcion" ClientIDMode="Static">
                          </asp:Textbox>
                        </div>
                    </div>
                    <p></p>
                    <asp:Button runat="server" id="updateBrandBtn" Text="Actualizar" OnClick="updateBrandBtn_Click"/>
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
                        <asp:GridView id="MarcasGridView" ClientIDMode="Static" 
                            autogeneratecolumns="false"
                            runat="server"
                            CssClass="table table-hover table-striped table-bordered">
                            <Columns>
                                <asp:BoundField DataField="id_marca" HeaderText="ID" />                                                     
                                <asp:BoundField DataField="nombre_marca" HeaderText="Nombre"/>
                                <asp:BoundField DataField="descripcion_marca" HeaderText="Descripcion"/>
                                <asp:BoundField DataField="estaPublicado_marca" HeaderText="Estado" Visible="false"/>
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
