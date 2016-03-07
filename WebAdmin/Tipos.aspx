<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Tipos.aspx.cs" Inherits="WebAdmin.Tipos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div id="page-wrapper">
        
        <div id="typeNameError" class="alert alert-danger hidden">
              Da un nombre al tipo de agua <span id="brandHideError" class="pull-right fa fa-times hideError"></span>
        </div>     

        <div class="row">
            <div class="col-lg-12">
                <h1>Tipos <small>Administracion de catalogos | Tipos de prodcuto</small></h1>
                <ol class="breadcrumb">
                    <li><a href="Dashboard"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                    <li><a href="#"><i class="fa fa-book"></i> Catalogos</a></li>
                    <li class="active"><i class="fa fa-tags"></i> Tipo</li>
                </ol>
            </div>
        </div><!-- /.row Titulo de aspx -->

        <div class="col-lg-4">
            <div class="panel panel-danger">
              <div class="panel-heading">
                  <h3 class="panel-title">Eliminar Tipo de producto</h3>
                  <span class="pull-right clickable"><i class="fa fa-chevron-up"></i></span>
              </div>
              <div class="panel-body">
                    <asp:DropDownList ID="typeDrop" AppendDataBoundItems="true" ClientIDMode="Static" runat="server" CssClass="table table-hover table-striped tablesorter">
                            <asp:ListItem Value="0">Selecciona tipo de producto</asp:ListItem>
                    </asp:DropDownList>
                    <asp:Button runat="server" id="deleteTypedBtn" Text="Eliminar" OnClick="deleteTypedBtn_Click"/>
              </div>
            </div>
            <div class="panel panel-success">
              <div class="panel-heading">
                  <h3 class="panel-title">Agregar Tipo de producto</h3>
                  <span class="pull-right clickable"><i class="fa fa-chevron-up"></i></span>
              </div>
              <div class="panel-body">
                  <div class="input-group">
                      <span class="input-group-addon"><i class="fa fa-tags"></i></span>
                      <asp:TextBox ID="InputField" runat="server" CssClass="form-control" placeholder="Nombre" ClientIDMode="Static">
                      </asp:Textbox>
                  </div>
                  <p></p>
                  <div class="input-group">
                      <span class="input-group-addon">%</span>
                      <asp:TextBox ID="percentInputField" pattern="\d*" runat="server" CssClass="form-control" onkeypress="return isNumberKey(event)" placeholder="Aumento en porcentaje (opcional)" ClientIDMode="Static">
                      </asp:Textbox>
                  </div>
                  <p></p>
                  <div class="input-group">
                      <span class="input-group-addon"><i class="fa fa-list-alt"></i></span>
                      <asp:TextBox ID="DescField" runat="server" CssClass="form-control" placeholder="Descripcion (opcional)" ClientIDMode="Static">
                      </asp:Textbox>
                  </div>
                  <p></p>
                  <asp:Button runat="server" id="adddBtn" Text="Agregar" OnClientClick="return ValidateType();" OnClick="adddBtn_Click"/>
              </div>
            </div>
            <div class="panel panel-warning">
              <div class="panel-heading">
                  <h3 class="panel-title">Estado de marca</h3>
                  <span class="pull-right clickable"><i class="fa fa-chevron-up"></i></span>
              </div>
              <div class="panel-body">
                  <asp:DropDownList ID="DropEdit" onchange="changeEdit()" AppendDataBoundItems="true" ClientIDMode="Static" runat="server" CssClass="table table-hover table-striped tablesorter">
                      <asp:ListItem Value="0">Selecciona un tipo de producto</asp:ListItem>
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
                        <asp:GridView id="TiposGridView" ClientIDMode="Static" 
                            autogeneratecolumns="false"
                            runat="server"
                            CssClass="table table-hover table-striped table-bordered">
                            <Columns>
                                <asp:BoundField DataField="id_tipo" HeaderText="ID" />                                                     
                                <asp:BoundField DataField="nombre_tipo" HeaderText="Nombre"/>
                                <asp:BoundField DataField="descripcion_tipo" HeaderText="Descripcion" />
                                <asp:BoundField DataField="aumentoPorcentaje_tipo" HeaderText="Aumento (%)" />
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
            function ValidateType() {
                if ($('#InputField').val().trim() <= 0) {
                    var body = $("html, body");
                    body.animate({ scrollTop: 0 }, '500', 'swing');
                    $('#typeNameError').removeClass('hidden');
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

            function isNumberKey(evt) {
                var charCode = (evt.which) ? evt.which : event.keyCode
                if (charCode > 31 && (charCode < 48 || charCode > 57))
                    return false;
                return true;
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
