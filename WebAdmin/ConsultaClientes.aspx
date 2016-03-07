<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ConsultaClientes.aspx.cs" Inherits="WebAdmin.ConsultaClientes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <style type="text/css">

    .highlight
    {
        background-color: #FFFFAF;
    }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <asp:LinkButton CssClass="hidden" runat="server" ID="deleteClient" ClientIDMode="Static" OnClick="deleteClient_Click"></asp:LinkButton>
    <asp:HiddenField runat="server" ID="deleteID" ClientIDMode="Static" />
    <div id="page-wrapper">

        <div class="row">
            <asp:Panel ID="panelMessage" runat="server" Visible="false"> 
            <h4 id="messagesText" class="alert_info" runat="server">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
            </h4> 
        </asp:Panel>
            <div class="col-lg-12">
                <h1>Clientes <small>Administracion de catalogos | Clientes</small></h1>
                <ol class="breadcrumb">
                    <li><a href="Dashboard"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                    <li><a href="#"><i class="fa fa-book"></i> Consultas</a></li>
                    <li class="active"><i class="fa fa-users"></i> Clientes</li>
                </ol>
            </div>
        </div><!-- /.row Titulo de aspx -->


        <div class="bs-example">
            <ul class="nav nav-tabs hidden-print" style="margin-bottom: 15px;">
                <li id="clientsTab" class="active"><a href="#clients" data-toggle="tab">Clientes</a></li>
                <li id="reportsTab"><a href="#Reports" data-toggle="tab">Reportes</a></li>
            </ul>
            <div id="myTabContent" class="tab-content">
                <div class="tab-pane fade active in" id="clients">
                    <div class="form-group input-group">
                        <span class="input-group-addon"><i class="fa fa-search"></i></span>
                        <asp:TextBox ID="txtSearch" runat="server" placeholder="Busqueda" autocomplete="off"/>
                    </div>

                    <div class="col-md-12">
                        <div class="panel panel-primary">
                            <div class="panel-heading clickable">
                                Clientes
                            </div>
                            <!-- /.panel-heading -->
                            <div class="panel-body" style="padding:0px;">
                                <div id="dvGrid" class="table-responsive">
                                    <asp:GridView id="gridView" ClientIDMode="Static"
                                        OnPreRender="gridView_PreRender"
                                        autogeneratecolumns="false"
                                        runat="server"
                                        CssClass="table table-panelfit table-hover table-striped table-bordered"
                                        Font-Size="Small">
                                        <Columns>
                                            <asp:BoundField DataField="id_cliente" ItemStyle-Width="40px" HeaderText="ID" />                                                     
                                            <asp:BoundField DataField="nombre_cliente" ItemStyle-Width="300px" HeaderText="Nombre" ItemStyle-Font-Bold="true"/>
                                            <asp:BoundField DataField="telefono_cliente" ItemStyle-Width="140px" HeaderText="Telefono" />                                                     
                                            <asp:BoundField DataField="plano_cliente" ItemStyle-Width="100px" ItemStyle-Font-Bold="true" HeaderText="Plano"/>
                                            <asp:BoundField DataField="nombre_ruta" ItemStyle-Width="40px" HeaderText="Ruta" />
                                            <asp:BoundField DataField="ciudad_cliente" ItemStyle-Width="130px" HeaderText="Ciudad" />
                                            <asp:BoundField DataField="direccion" ItemStyle-Width="350px" HeaderText="Direccion" />
                                            <asp:BoundField DataField="postal_cliente" ItemStyle-Width="100px" HeaderText="Postal" />
                                            <asp:BoundField DataField="cantidad_compras" ItemStyle-Font-Bold="true" ItemStyle-Width="15px" HeaderText="Compras" />
                                            <asp:BoundField DataField="diasSinCompra" ItemStyle-Font-Bold="true" ItemStyle-Width="50px" HeaderText="DSC" />
                                            <asp:TemplateField ItemStyle-Width="80px" HeaderText="Editar" ItemStyle-CssClass="ignore" HeaderStyle-Wrap="true">
                                                <ItemTemplate>
                                                   <%--<asp:LinkButton runat="server" ForeColor="White" CssClass="btn btn-xs btn-info" CommandName="Select" Font-Underline="false" Font-Overline="false" Font-Size="Small"><i class="fa fa-search-plus icon-white icon-fix"></i> Detalles</asp:LinkButton>--%>
                                                    <button type="button" runat="server" id="btnEdit" class="btn btn-xs btn-info" title="Editar">
                                                        <i class="fa fa-edit"></i> Editar
                                                    </button>
                                                    <%--<span class="label label-default"><asp:LinkButton runat="server" ><i class="fa fa-book icon-fix"></i> Check</asp:LinkButton></span>--%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-Width="100px" HeaderText="Eliminar" ItemStyle-CssClass="ignore" HeaderStyle-Wrap="true">
                                                <ItemTemplate>
                                                   <%--<asp:LinkButton runat="server" ForeColor="White" CssClass="btn btn-xs btn-info" CommandName="Select" Font-Underline="false" Font-Overline="false" Font-Size="Small"><i class="fa fa-search-plus icon-white icon-fix"></i> Detalles</asp:LinkButton>--%>
                                                    <button type="button" runat="server" id="btnRemove" class="btn btn-xs btn-danger" title="Eliminar">
                                                        <i class="fa fa-times"></i> Eliminar
                                                    </button>
                                                    <%--<span class="label label-default"><asp:LinkButton runat="server" ><i class="fa fa-book icon-fix"></i> Check</asp:LinkButton></span>--%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                                <div class="pull-left Pager"></div>
                                <!-- /.table-responsive -->
                            </div>
                            <!-- /.panel-body -->
                        </div>
                        <!-- /.panel -->
                        <div id="loader" class="hidden" style="text-align:center"><img alt="" src="/Images/Loading/loader.gif" /></div>
                    </div>

                    <!-- Modals -->
                    <!-- Confirm delete -->
                    <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="myBuyDetailsLabel" aria-hidden="true">
                        <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title" id="myBuyDetailsLabel">Eliminar</h4>
                            </div>
                            <div class="modal-body">
                                <%--Details here--%>
                                <p>¿Esta seguro que desea eliminar al cliente?</p>
                            </div>
                            <div class="modal-footer">
                            <button id="removeYes" type="button" class="btn btn-primary" data-dismiss="modal">Si</button>
                            <button data-dismiss="modal" aria-hidden="true" class="btn secondary">No</button>
                            </div>
                        </div>
                        </div>
                    </div>
                </div>
                <div class="tab-pane fade" id="Reports">
                <div class="col-sm-12">
                    <div id="pendClients" class="panel panel-default">
                        <div class="panel-heading clickable">
                            <h3 class="panel-title"><i class="fa fa-user"></i> Clientes sin actividad
                                <%--<span id="lastBuysLabel" style="margin-left:10px; margin-bottom:30px;" class="label label-default">Cliente nuevo</span>--%>
                            </h3>
                            <span class="pull-right">
                                Hace días: <asp:TextBox style="width:70px;height: 28px;font-size: 13px;padding-top: 5px;" ID="days" pattern="\d*" onkeypress="return isNumberKey(event)" ClientIDMode="Static" Width="70px" runat="server" TextMode="Number" min="1">1</asp:TextBox> 
                            </span>
                        </div>
                        <div class="panel-body" style="padding:0px;">
                            <div class="table-responsive">
                                <asp:GridView runat="server" ID="inactiveClientsGrid" AutoGenerateColumns="false" ClientIDMode="Static" 
                                    CssClass="table table-panelfit table-hover table-striped table-bordered"
                                    OnPreRender="inactiveClientsGrid_PreRender"
                                    Font-Size="Small">
                                    <Columns>
                                        <asp:BoundField DataField="id_cliente" ItemStyle-Width="40px" ItemStyle-Wrap="true" HeaderText="ID"/>
                                        <asp:BoundField DataField="cantidad_compras" ItemStyle-Width="10px" ItemStyle-Wrap="true" HeaderText="CC"/>
                                        <asp:BoundField DataField="nombre_cliente" ItemStyle-Width="150px" ItemStyle-Wrap="true" HeaderText="Nombre"/>
                                        <asp:BoundField DataField="telefono_cliente" ItemStyle-Width="80px" ItemStyle-Wrap="true" HeaderText="Telefono"/>
                                        <asp:BoundField DataField="UltimaEntrega" ItemStyle-Width="80px" ItemStyle-Wrap="true" HeaderText="Ultima Entrega"/>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                        <%--<asp:GridView runat="server" ID="topClientsGrid" AutoGenerateColumns="false" ClientIDMode="Static" CssClass="table table-panelfit table-hover table-bordered table-responsive">
                            <Columns>
                                <asp:BoundField DataField="id_cliente" ItemStyle-Width="40px" ItemStyle-Wrap="true" HeaderText="ID"/>
                            </Columns>
                        </asp:GridView>--%>
                    </div>
                </div>
                <div class="col-sm-12">
                    <div id="TopClients" class="panel panel-primary">
                        <div class="panel-heading clickable">
                            <h3 class="panel-title"><i class="fa fa-user"></i> Top clientes
                                <%--<span id="lastBuysLabel" style="margin-left:10px; margin-bottom:30px;" class="label label-default">Cliente nuevo</span>--%>
                            </h3>
                            <%--<span class="pull-right"><i id="lastBuysSpan" class="fa fa-chevron-up"></i></span>--%>
                        </div>
                        <div class="panel-body" style="padding:0px;">
                        <div class="table-responsive">
                            <asp:GridView runat="server" ID="topClientsGrid" AutoGenerateColumns="false" ClientIDMode="Static" 
                                ShowHeader="true"
                                CssClass="table table-panelfit table-hover table-striped table-bordered"
                                Font-Size="Small">
                                <Columns>
                                    <asp:BoundField DataField="id_cliente" ItemStyle-Width="40px" ItemStyle-Wrap="true" HeaderText="ID"/>
                                    <asp:BoundField DataField="Name" ItemStyle-Width="10px" ItemStyle-Wrap="true" HeaderText="Nombre"/>
                                    <asp:BoundField DataField="Phone" ItemStyle-Width="150px" ItemStyle-Wrap="true" HeaderText="Telefono"/>
                                    <asp:BoundField DataField="Buys" ItemStyle-Width="15px" ItemStyle-Wrap="true" HeaderText="CC"/>
                                </Columns>
                            </asp:GridView>
                        </div>
                        </div>
			        </div>
                </div>
                </div>
            </div>  
        </div>
    

        <script src="js/Pager/Pager.min.js" type="text/javascript"></script>
        <script type="text/javascript">

            function isNumberKey(evt) {
                var charCode = (evt.which) ? evt.which : event.keyCode;
                if (charCode != 46 && charCode > 31
                  && (charCode < 48 || charCode > 57))
                    return false;
                return true;
            }

            var days = 1;
            $('#days').change(function () {
                //var _this = $(this); // copy of this object for further usage
                if (timeoutReference) clearTimeout(timeoutReference);
                timeoutReference = setTimeout(function () {
                    days = $('#days').val();
                    txtSearch = true;
                    GetInactiveClients();
                }, 100);
            });

            function GetInactiveClients() {

                //Show Loader
                //if ($("[id$=gvCustomers] .loader").length == 0) {
                //    var row = $("[id$=gvCustomers] tr").eq(0).clone(true);
                //    row.addClass("loader");
                //    row.children().remove();
                //    row.append('<td colspan = "999" style = "background-color:white"><img id="loader" alt="" src="103.gif" /></td>');
                //    $("[id$=gvCustomers]").append(row);
                //}

                //$('#loader').removeClass('hidden');

                $.ajax({
                    type: "POST",
                    url: "ConsultaClientes.aspx/GetInactiveClients",
                    data: '{days: "' + days + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnSuccessInactive,
                    failure: function (response) {
                        alert(response.d);
                    },
                    error: function (response) {
                        alert(response.d);
                    }
                });  
            }

            var clientRow;
            function OnSuccessInactive(response) {

                var xmlDocIn = $.parseXML(response.d);
                var xml = $(xmlDocIn);
                var inactiveClients = xml.find("Clientes");
                if (clientRow == null) {
                    clientRow = $("#inactiveClientsGrid tr:last-child").clone(true);
                }
                $("[id*=inactiveClientsGrid] tr").not($("[id*=inactiveClientsGrid] tr:first-child")).remove();
                if (inactiveClients.length > 0) {
                    $.each(inactiveClients, function () {
                        var client = $(this);
                        $("td", clientRow).eq(0).html($(this).find("id_cliente").text());
                        $("td", clientRow).eq(1).html($(this).find("cantidad_compras").text());
                        $("td", clientRow).eq(2).html($(this).find("nombre_cliente").text());
                        //$("td", clientRow).eq(3).html($(this).find("apellido_cliente").text());
                        $("td", clientRow).eq(3).html($(this).find("telefono_cliente").text());
                        $("td", clientRow).eq(4).html($(this).find("UltimaEntrega").text());
                        $("#inactiveClientsGrid").append(clientRow);
                        clientRow = $("#inactiveClientsGrid tr:last-child").clone(true);
                        //if (!$.trim($(this).text())) $(this).remove();
                        $("#inactiveClientsGrid tr:not(:has(td))").hide();
                    });

                } else {
                    //var empty_row = row.clone(true);
                    //$("td:first-child", empty_row).attr("colspan", $("td", row).length);
                    //$("td:first-child", empty_row).attr("align", "center");
                    //$("td:first-child", empty_row).html("No se encontraron mas registros por el criterio dado.");
                    //$("td", empty_row).not($("td:first-child", empty_row)).remove();
                    //$("[id*=inactiveClientsGrid]").append(empty_row);
                }
                $("#inactiveClientsGrid tr:first-child").hide();
                $("#inactiveClientsGrid thead").children('tr').show();
            };

            //-----------------------------------------------------------------
            // Start Clientes Tab stuff

            var pageCount = 1;
            var pageIndex = 1;
            var firstTime = true;
            var txtSearch = false;
            var scrolled = false;
            //Load GridView Rows when DIV is scrolled
            $(window).scroll(function () {
                if (!$('#reportsTab').hasClass('active')) {
                    if ($(window).scrollTop() + $(window).height() == $(document).height()) {
                        GetCustomers();
                    }
                }
            });

            // AJAX Pager and search
            $(function () {
                GetCustomers();
                GetInactiveClients();
            });
            //$("[id*=txtSearch]").on("keyup", function () {
            //    txtSearch = true;
            //    GetCustomers();
            //});
            var timeoutReference;
            $('[id*=txtSearch]').keyup(function () {
                //var _this = $(this); // copy of this object for further usage
                if (timeoutReference) clearTimeout(timeoutReference);
                timeoutReference = setTimeout(function () {
                    txtSearch = true;
                    GetCustomers();
                }, 300);
            });
            function SearchTerm() {
                return jQuery.trim($("[id*=txtSearch]").val());
            };
            function GetCustomers() {
                // first time load, load first page
                if (firstTime) {
                    firstTime = false;
                }
                    // Else: Is a search term, load first page with searchterm
                else if (txtSearch) {
                    pageIndex = 1;
                    //txtSearch = false;
                }
                    // Scroll
                else {
                    pageIndex++;
                }
                if (pageIndex == 2 || pageIndex <= pageCount) {

                    //Show Loader
                    //if ($("[id$=gvCustomers] .loader").length == 0) {
                    //    var row = $("[id$=gvCustomers] tr").eq(0).clone(true);
                    //    row.addClass("loader");
                    //    row.children().remove();
                    //    row.append('<td colspan = "999" style = "background-color:white"><img id="loader" alt="" src="103.gif" /></td>');
                    //    $("[id$=gvCustomers]").append(row);
                    //}

                    $('#loader').removeClass('hidden');

                    $.ajax({
                        type: "POST",
                        url: "ConsultaClientes.aspx/GetClients",
                        data: '{searchTerm: "' + SearchTerm() + '", pageIndex: ' + pageIndex + ', pageSize: ' + 20 + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: OnSuccess,
                        failure: function (response) {
                            alert(response.d);
                        },
                        error: function (response) {
                            alert(response.d);
                        }
                    });
                }
            }

            var row;
            function OnSuccess(response) {

                $('#loader').addClass('hidden');
                if (txtSearch) {
                    $("[id*=gridView] tr").not($("[id*=gridView] tr:first-child")).remove();
                    txtSearch = false;
                }

                var xmlDoc = $.parseXML(response.d);
                var xml = $(xmlDoc);
                pageCount = parseInt(xml.find("PageCount").eq(0).find("PageCount").text());
                if (pageCount == 0)
                    pageCount = 1;
                var customers = xml.find("View_ClienteRutas");
                if (row == null) {
                    row = $("[id*=gridView] tr:last-child").clone(true);
                }
                //$("[id*=gridView] tr").not($("[id*=gridView] tr:first-child")).remove();
                if (customers.length > 0) {
                    $.each(customers, function () {
                        var customer = $(this);
                        $("td", row).eq(0).html($(this).find("id_cliente").text());
                        $("td", row).eq(1).html($(this).find("nombre_cliente").text());
                        //$("td", row).eq(3).html($(this).find("apellido_cliente").text());
                        $("td", row).eq(2).html($(this).find("telefono_cliente").text());
                        $("td", row).eq(3).html($(this).find("plano_cliente").text());
                        $("td", row).eq(4).html($(this).find("nombre_ruta").text());
                        $("td", row).eq(5).html($(this).find("ciudad_cliente").text());
                        $("td", row).eq(6).html($(this).find("direccion").text());
                        $("td", row).eq(7).html($(this).find("postal_cliente").text());
                        $("td", row).eq(8).html($(this).find("cantidad_compras").text());
                        $("td", row).eq(9).html($(this).find("diasSinCompra").text());
                        $("[id*=gridView]").append(row);
                        row = $("[id*=gridView] tr:last-child").clone(true);
                        //if (!$.trim($(this).text())) $(this).remove();
                        $("tr:not(:has(td))").hide();
                    });

                    $("#gridView").find('td').each(function () {
                        var searchPattern;
                        if (!$(this).hasClass('ignore')) {
                            searchPattern = new RegExp('(' + SearchTerm() + ')', 'ig');
                            $(this).html($(this).text().replace(searchPattern, "<span class = 'highlight'>" + SearchTerm() + "</span>"));
                        }
                    });

                } else {
                    //var empty_row = row.clone(true);
                    //$("td:first-child", empty_row).attr("colspan", $("td", row).length);
                    //$("td:first-child", empty_row).attr("align", "center");
                    //$("td:first-child", empty_row).html("No se encontraron mas registros por el criterio dado.");
                    //$("td", empty_row).not($("td:first-child", empty_row)).remove();
                    //$("[id*=gridView]").append(empty_row);
                }
                $("[id*=gridView] tr:first-child").hide();
                $("[id*=gridView] thead").children('tr').show();
            };

            $('#btnEdit').click(function () {
                var a = $(this).parent().siblings(":first").text();
                window.location = 'EditarCliente.aspx?Id=' + a;
            });
            $('#btnRemove').click(function (e) {
                e.preventDefault();

                var id = $(this).parent().siblings(":first").text();
                $('#deleteModal').data('id', id).modal('show');
            });

            $('#removeYes').click(function () {
                var id = $('#deleteModal').data('id');
                $('#deleteID').val(id);
                eval($('#deleteClient').attr('href'));
            });

            // FooTable
            $(function () {
                $('#gridView').footable({
                    breakpoints: {
                        phone: 480,
                        tablet: 1024
                    }
                });
            });

        </script>
    </div> <!-- /.wrapper -->
</asp:Content>
