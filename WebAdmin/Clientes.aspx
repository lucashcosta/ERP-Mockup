<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Clientes.aspx.cs" Inherits="WebAdmin.Clientes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <asp:HiddenField runat="server" ID="deleteID" ClientIDMode="Static" />
    <div id="page-wrapper">

        <div id="ruteErrorMsg" class="alert alert-danger hidden">
              Elije una ruta <span id="ruteHideError" class="pull-right fa fa-times hideError"></span>
        </div>

        <div class="row">
            <asp:Panel ID="panelMessage" runat="server" Visible="false"> 
            <h4 id="messagesText" class="alert_info" runat="server">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
            </h4> 
        </asp:Panel>
            <div class="col-lg-12">
                <h1>Clientes <small>Administracion de clientes</small></h1>
                <ol class="breadcrumb">
                    <li><a href="Dashboard"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                    <li><a href="#"><i class="fa fa-book"></i> Catalogos</a></li>
                    <li class="active"><i class="fa fa-users"></i> Clientes</li>
                </ol>
            </div>
        </div><!-- /.row Titulo de aspx -->

        <%--<div class="form-group input-group">
                    <span class="input-group-addon"><i class="fa fa-search"></i></span>
                    <asp:TextBox ID="txtSearch" runat="server" placeholder="Busqueda" autocomplete="off"/>
        </div>--%>

        
        <div class="col-md-12">
            <div class="panel panel-success">
              <div class="panel-heading clickable">
                  <h3 class="panel-title">Agregar nuevo cliente</h3>
                  <span class="pull-right"><i class="fa fa-chevron-up"></i></span>
              </div>
              <div class="panel-body">
                  <div class="input-group">
                      <span class="input-group-addon"><i class="fa fa-user"></i></span>
                      <asp:TextBox ID="firstNameInput" runat="server" CssClass="form-control required" placeholder="Nombre" ClientIDMode="Static" >
                      </asp:Textbox>
                      <span class="input-group-addon"><i class="fa fa-asterisk"></i></span>
                  </div>
                  <p></p>
                  <div class="input-group">
                      <span class="input-group-addon"><i class="fa fa-user"></i></span>
                      <asp:TextBox ID="lastNameInput" runat="server" CssClass="form-control required" placeholder="Apellido" ClientIDMode="Static" >
                      </asp:Textbox>
                      <span class="input-group-addon"><i class="fa fa-asterisk"></i></span>
                  </div>
                  <p></p>
                  <div class="input-group">
                      <span class="input-group-addon"><i class="fa fa-phone"></i></span>
                      <asp:TextBox ID="phoneInput" runat="server" CssClass="form-control required" placeholder="Telefono" ClientIDMode="Static" >
                      </asp:Textbox>
                      <span class="input-group-addon"><i class="fa fa-asterisk"></i></span>
                  </div>
                  <p></p>
                  <div class="input-group">
                      <span class="input-group-addon"><i class="fa fa-mobile icon-fix"></i></span>
                      <asp:TextBox ID="mobileInput" runat="server" CssClass="form-control" placeholder="Movil" ClientIDMode="Static" >
                      </asp:Textbox>
                  </div>
                  <p></p>
                  <div class="input-group">
                      <span class="input-group-addon"><i class="fa fa-map-marker icon-red"></i></span>
                      <asp:TextBox ID="planoInput" rel="tooltip-top" title="Plano [###A#]" runat="server" CssClass="form-control" placeholder="Plano" ClientIDMode="Static" >
                      </asp:Textbox>
                  </div>
                  <p></p>
                  <div class="form-group">
                      <asp:TextBox ID="streetInput" runat="server" CssClass="form-control" placeholder="Calle" ClientIDMode="Static" >
                      </asp:Textbox>
                  </div>
                  <p></p>
                  <div class="input-group">
                      <asp:TextBox ID="dirNumberInput" runat="server" CssClass="form-control required" placeholder="Numero (direccion)" ClientIDMode="Static" >
                      </asp:Textbox>
                      <span class="input-group-addon"><i class="fa fa-asterisk"></i></span>
                  </div>
                  <p></p>
                  <div class="input-group">
                      <asp:TextBox ID="colonyInput" runat="server" CssClass="form-control required" placeholder="Colonia" ClientIDMode="Static" >
                      </asp:Textbox>
                      <span class="input-group-addon"><i class="fa fa-asterisk"></i></span>
                  </div>
                  <p></p>
                  <div class="input-group">
                      <asp:TextBox ID="cityInput" runat="server" CssClass="form-control required" placeholder="Ciudad" ClientIDMode="Static" >
                      </asp:Textbox>
                      <span class="input-group-addon"><i class="fa fa-asterisk"></i></span>
                  </div>
                  <p></p>                  
                  <div class="form-group">
                      <asp:TextBox ID="betStreetsInput" runat="server" CssClass="form-control" placeholder="Entre calles" ClientIDMode="Static" >
                      </asp:Textbox>
                  </div>
                  <p></p>
                  <div class="form-group">
                      <asp:TextBox ID="postalInput" pattern="\d*" rel="tooltip-top" title="Codigo Postal [#####]" onkeypress="return isNumberKey(event)" runat="server" CssClass="form-control" placeholder="Codigo Postal" ClientIDMode="Static" >
                      </asp:Textbox>
                  </div>
                  <p></p>
                  <div class="form-group">
                      <asp:DropDownList rel="tooltip-top" title="Ruta"  AppendDataBoundItems=True CssClass="form-control required" runat="server" ID="ruteInputDropD" ClientIDMode="Static">
                          <asp:ListItem Value="0" Text="Ruta"></asp:ListItem>
                      </asp:DropDownList>
                  </div>
                  <p></p>
                  <div class="form-group">
                      <asp:TextBox TextMode="MultiLine" ID="dirRefInput" runat="server" CssClass="form-control" placeholder="Referencias direccion" ClientIDMode="Static" >
                      </asp:TextBox>
                  </div>
                  <p></p>
                  <div class="form-group">
                      <asp:TextBox TextMode="MultiLine" ID="notesInput" runat="server" CssClass="form-control" placeholder="Notas" ClientIDMode="Static" >
                      </asp:TextBox>
                  </div>
                  <p></p>
                  <div class="form-group" runat="server" id="refContactoDiv" data-placement="left" >
                        <%--<label class="">Como se entero de nosotros</label>--%>
                        <asp:DropDownList ClientIDMode="Static" AppendDataBoundItems=True ID="contactRefInput" runat="server" CssClass="form-control" >
                            <asp:ListItem Value="">Medio por el cual se entero de nosotros</asp:ListItem>
                        </asp:DropDownList>
                  </div>
                  <p></p>
                  <div class="form-group">
                      <span class="button-checkbox">
                          <button type="button" id="shipBtn" class="btn" data-color="success">Precio de envío especial</button>
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
                              <asp:TextBox runat="server" ID="discValue" ClientIDMode="Static" onkeypress="return isNumberKey(event)" CssClass="hidden form-control" Width="150px" rel="tooltip-top" title="Descuento en porcentage" placeholder="Descuento"></asp:TextBox>
                          </span>
                      </span>
                  </div>
                  <div class="form-group">
                      <span class="button-checkbox">
                          <button type="button" id="facBtn" class="btn" data-color="success">Factura</button>
                          <input runat="server" type="checkbox" id="facbox" class="hidden" />
                          <p></p>
                          <span class="form-group hidden" id="facgroup">
                              <asp:TextBox runat="server" ID="facName" ClientIDMode="Static" CssClass="form-control" placeholder="Nombre o Razon Social"></asp:TextBox>
                              <asp:TextBox runat="server" ID="facDir" ClientIDMode="Static" CssClass="form-control" placeholder="Direccion"></asp:TextBox>
                              <asp:TextBox runat="server" ID="facRFC" ClientIDMode="Static" CssClass="form-control" placeholder="RFC"></asp:TextBox>
                          </span>
                      </span>
                  </div>
                  <asp:Button runat="server" id="addBtn" Text="Agregar" OnClientClick="return validateInputs();" OnClick="addBtn_Click"/>
              </div>
            </div>
          </div>

        <script src="js/Pager/Pager.min.js" type="text/javascript"></script>
        <script type="text/javascript">

            $('#btnEdit').click(function () {
                var a = $(this).parent().siblings(":first").text();
                window.location = 'EditarCliente.aspx?Id=' + a;
            });
            $('#btnRemove').click(function () {
                var a = $(this).parent().siblings(":first").text();
                $('#deleteID').val(a);
                eval($('#deleteClient').attr('href'));
            });

            function changeEdit() {
                var a = $("#productDropEdit").val()
                if ($("#productDropEdit").val() == 0)
                    $("#updateFeilds").addClass('hidden');
                else
                    $("#updateFeilds").removeClass('hidden');
            }

            function isNumberKey(evt) {
                var charCode = (evt.which) ? evt.which : event.keyCode;
                if (charCode != 46 && charCode > 31
                  && (charCode < 48 || charCode > 57))
                    return false;

                return true;
            }

            
            function validateInputs() {

                if ($('#ruteInputDropD').val() == "0") {
                    var body = $("html, body");
                    body.animate({ scrollTop: 0 }, '500', 'swing');
                    $('#ruteErrorMsg').removeClass('hidden');
                    return false;
                }

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

            $('.hideError').on('click', function () {
                $(this).parent().addClass('hidden');
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

                        if ($('#facBtn').hasClass('btn-' + color)) {
                            $('#facgroup').removeClass('hidden');
                        }
                        else {
                            $('#facgroup').addClass('hidden');
                            $('#facName').val('');
                            $('#facDir').val('');
                            $('#facRFC').val('');
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
            $("#planoInput").mask("999a9");
            $("#postalInput").mask("99999");
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

        </div> <!-- / wrapper -->
</asp:Content>
