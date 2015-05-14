<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ConsultaPedidos.aspx.cs" Inherits="WebAdmin.ConsultaPedidos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">

    .Pager span
    {
        color: #333;
        background-color: #F7F7F7;
        font-weight: bold;
        text-align: center;
        display: inline-block;
        width: 20px;
        margin-right: 3px;
        line-height: 150%;
        border: 1px solid #ccc;
    }
    .Pager a
    {
        text-align: center;
        display: inline-block;
        width: 20px;
        border: 1px solid #ccc;
        color: #fff;
        color: #333;
        margin-right: 3px;
        line-height: 150%;
        text-decoration: none;
    }

    .highlight
    {
        background-color: #FFFFAF;
    }

    /***
	Dashboard date range panel
	***/
	.breadcrumb .dashboard-date-range  {
		padding-bottom: 8px;
	} 

    .breadcrumb .dashboard-date-range span {
		display: none;
	}	

  	.breadcrumb > .btn-group span {
  		display: none;
  	}

  	.breadcrumb > .btn-group > .btn {
  		padding-left: 7px;
  		padding-right: 7px;
  	}

      /* Dashboard date range panel */
    breadcrumb .dashboard-date-range  {
      position: relative;
      top: -8px;
      margin-right: -30px;
      display: none;
      padding: 9px 9px 8px 9px;
      cursor: pointer;
      color: #fff;
      background-color: #e02222;
    }

    /* hack for chrome and safari */
    @media all and (-webkit-min-device-pixel-ratio:0) {
      .breadcrumb .dashboard-date-range  {
        padding: 9px;
      } 
    }

    .breadcrumb .dashboard-date-range > span {
      font-size: 12px;
      font-weight: 300; 
      color: #fff;
      text-transform: uppercase;
    } 

    .breadcrumb .dashboard-date-range > .fa-calendar {
      text-transform: none;
      color: #fff;
      margin-top: 0px;
      font-size: 14px;
    }

    .breadcrumb .dashboard-date-range > .fa-angle-down {
      color:#fff;
      font-size: 16px;
    }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    
    <asp:HiddenField runat="server" ClientIDMode="Static" ID="startDate" Value=""/>
    <asp:HiddenField runat="server" ClientIDMode="Static" ID="endDate" Value=""/>

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1>Consultas <small>Pedidos</small></h1>
                <ol class="breadcrumb">
                    <li><a href="Dashboard"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                    <li><a href="#"><i class="fa fa-book"></i> Consultas</a></li>
                    <li class="active"><i class="fa fa-truck"></i> Pedidos</li>
                    <span class="pull-right clickable">
						<div id="dashboard-report-range" class="dashboard-report-range" data-placement="top" data-original-title="Change dashboard date range">
							<i class="fa fa-calendar"></i>
							<span id="daterange">
							</span>
							<i class="fa fa-angle-down" style="padding-right: 12px;"></i>
						</div>
					</span>
                </ol>
            </div>
        </div><!-- /.row Titulo de aspx -->

        <div class="form-group input-group">
            <span class="input-group-addon"><i class="fa fa-search"></i></span>
            <asp:TextBox ID="txtSearch" runat="server" placeholder="Busqueda" autocomplete="off"/>
        </div>
        <div class="panel panel-primary">
              <div class="panel-heading">
                  <h3 class="panel-title">Todos los pedidos</h3>
                  <span class="pull-right clickable"><i class="fa fa-chevron-up"></i></span>
              </div>
              <div class="panel-body" style="padding:0px;">
                    <div id="dvGrid" class="table-responsive">
                        <asp:GridView id="gridView" ClientIDMode="Static" 
                            autogeneratecolumns="false"
                            runat="server"
                            CssClass="footable table-panelfit table table-bordered table-hover table-striped"
                            OnPreRender="gridView_PreRender"
                            HeaderStyle-BackColor="WhiteSmoke"
                            HeaderStyle-Font-Size="Small"
                            HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-VerticalAlign="Middle"
                            Font-Size="Small">
                            <Columns>
                                <asp:BoundField DataField="id_pedido" ItemStyle-Wrap="true" HeaderText="ID"/>
                                <asp:BoundField DataField="id_cliente" ItemStyle-Width="40px"  HeaderText="Cliente" />
                                <%--<asp:BoundField DataField="nombre_cliente" ItemStyle-Width="300px"  HeaderText="Nombre"/>--%>
                                <asp:TemplateField ItemStyle-Width="300px">
                                    <HeaderTemplate>
                                        Nombre <i id="nameFilter" class="fa fa-filter"></i>
                                        <div id="nameGroup" class="hidden">
                                            <input id="firstNameFilter" class="form-control input-sm" type="text" placeholder="Nombre">
                                            <input id="lastNameFilter" class="form-control input-sm" type="text" placeholder="Apellido">
                                        </div>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <%# Eval("nombre_cliente") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--<asp:BoundField DataField="apellido_cliente" HeaderStyle-Wrap="true" HeaderText="Apellido" />--%>
                                <asp:BoundField DataField="telefono_cliente" HeaderText="Telefono" />                                                     
                                <asp:BoundField DataField="plano_cliente" ItemStyle-Font-Bold="true" HeaderText="Plano"/>
                                <asp:BoundField DataField="fechaEntrega_orden" ItemStyle-Width="140px" HeaderText="Fecha Entrega"/>
                                <%--<asp:BoundField DataField="direccion" ItemStyle-Width="300px" HeaderText="Direccion" />--%>
                                <asp:TemplateField ItemStyle-Width="300px">
                                    <HeaderTemplate>
                                        Direccion <i id="dirFilter" class="fa fa-filter clickable"></i>
                                        <div id="dirGroup" class="hidden">
                                            <input id="streetFilter" class="form-control input-sm" type="text" placeholder="Calle">
                                            <input id="colonyFilter" class="form-control input-sm" type="text" placeholder="Colonia">
                                        </div>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <%# Eval("direccion") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField ItemStyle-Width="70px" DataField="postal_cliente" HeaderText="Postal" />
                                <asp:BoundField DataField="ciudad_cliente" HeaderText="Ciudad" />
                                <%--<asp:BoundField DataField="horarioEntrega_orden" HeaderText="Horario"/>--%>
                                <asp:TemplateField ItemStyle-Width="130px">
                                    <HeaderTemplate>
                                        Horario <i id="deliverTimeFilter" class="fa fa-filter clickable"></i>
                                        <br />
                                        <asp:DropDownList Font-Size="Small" ID="deliverTimeDropD" ClientIDMode="Static" CssClass="hidden form-control input-sm" runat="server">
                                            <asp:ListItem Value="%">Todos</asp:ListItem>
                                            <asp:ListItem>9am a 12pm</asp:ListItem>
                                            <asp:ListItem>12pm a 2pm</asp:ListItem>
                                            <asp:ListItem>2pm a 4pm</asp:ListItem>
                                            <asp:ListItem>4am a 6pm</asp:ListItem>
                                        </asp:DropDownList>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <%# Eval("horarioEntrega_orden") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField ItemStyle-Font-Bold="true" DataField="totalProductos_orden" HeaderText="Total"/>
                                <%--<asp:BoundField ItemStyle-CssClass="lblStatus" DataField="status_orden" ItemStyle-Font-Bold="true"  HeaderText="Status"/>--%>
                                <asp:TemplateField ItemStyle-Width="190px">
                                    <HeaderTemplate>
                                        Status <i id="statusFilter" class="fa fa-filter clickable"></i>
                                        <br />
                                        <asp:DropDownList Font-Size="Small" ID="statusDropD" ClientIDMode="Static" CssClass="hidden form-control input-sm" runat="server">
                                            <asp:ListItem Value="%">Todos</asp:ListItem>
                                            <asp:ListItem >Programado</asp:ListItem>
                                            <asp:ListItem >Cancelado</asp:ListItem>
                                            <asp:ListItem >En ruta</asp:ListItem>
                                            <asp:ListItem >Entregado & pagado</asp:ListItem>
                                            <asp:ListItem >Entregado & no pagado</asp:ListItem>
                                            <asp:ListItem >Pagado & no entregado</asp:ListItem>
                                            <asp:ListItem >Pendiente</asp:ListItem>
                                        </asp:DropDownList>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <%# Eval("status_orden") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="30px" ItemStyle-CssClass="ignore">
                                    <HeaderTemplate>
                                        <i class="fa fa-search-plus"></i>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                       <%--<asp:LinkButton runat="server" ForeColor="White" CssClass="btn btn-xs btn-info" CommandName="Select" Font-Underline="false" Font-Overline="false" Font-Size="Small"><i class="fa fa-search-plus icon-white icon-fix"></i> Detalles</asp:LinkButton>--%>
                                        <button type="button" runat="server" id="btnRun" class="btn btn-xs btn-info" title="Search">
                                            <i class="fa fa-search-plus"></i>
                                        </button>
                                        <%--<span class="label label-default"><asp:LinkButton runat="server" ><i class="fa fa-book icon-fix"></i> Check</asp:LinkButton></span>--%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                  <%--<div class="pull-left Pager"></div>--%>
                  <!-- /.table-responsive -->
                </div>

        </div>

        <div id="loader" class="hidden" style="text-align:center"><img alt="" src="/Images/Loading/loader.gif" /></div>
        <script type="text/javascript">
            
            var startDate;
            var endDate;

            var d = new Date();
            var month = new Array();
            month[0] = "Enero";
            month[1] = "Febrero";
            month[2] = "Mazo";
            month[3] = "Abril";
            month[4] = "Mayo";
            month[5] = "Junio";
            month[6] = "Julio";
            month[7] = "Agosto";
            month[8] = "Septiembre";
            month[9] = "Octubre";
            month[10] = "Noviembre";
            month[11] = "Diciembre";
            var m = month[d.getMonth()];

            var day = d.getDate();

            if (!(localStorage.getItem('l_startDate')))
                localStorage.setItem('l_startDate', moment().subtract('days', 15));
            if (!(localStorage.getItem('l_endDate')))
                localStorage.setItem('l_endDate', moment().add('days', 15));

            var lastMonth = moment(localStorage.getItem('l_startDate'));
            var thisMonth = moment(localStorage.getItem('l_endDate'));

           $('#dashboard-report-range span').html(lastMonth.format('MMMM D, YYYY') + ' - ' + thisMonth.format('MMMM D, YYYY'))
            $('#dashboard-report-range').daterangepicker({
                opens: 'left',
                //startDate: moment().subtract('days', 15),
                //endDate: moment().add('days', 15),
                startDate: moment(localStorage.getItem('l_startDate')),
                endDate: moment(localStorage.getItem('l_endDate')),
                //minDate: '01/01/2012',
                //maxDate: '12/31/2014',
                //dateLimit: {
                //    days: 60
                //},
                showDropdowns: false,
                showWeekNumbers: true,
                timePicker: false,
                timePickerIncrement: 1,
                timePicker12Hour: true,
                ranges: {
                    'Hoy': [moment(), moment()],
                    'Ayer': [moment().subtract('days', 1), moment().subtract('days', 1)],
                    'Mañana': [moment(), moment().add('days', 1)],
                    'Ultimos 7 Dias': [moment().subtract('days', 6), moment()],
                    'Ultimos 30 Días': [moment().subtract('days', 29), moment()],
                    'Rango de 15 Días': [moment().subtract('days', 15), moment().add('days', 15)],
                    'Este Mes': [moment().startOf('month'), moment().endOf('month')],
                    'Mes Pasado': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
                },
                buttonClasses: ['btn'],
                applyClass: 'btn-success',
                cancelClass: 'default',
                format: 'DD/MM/YYYY',
                separator: ' to ',
                locale: {
                    applyLabel: 'Aplicar',
                    fromLabel: 'Desde',
                    toLabel: 'Hasta',
                    customRangeLabel: 'Rango especifico',
                    daysOfWeek: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa'],
                    monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
                    firstDay: 0
                }
            },
            function (start, end) {
                //console.log("Callback has been called!");
                $('#dashboard-report-range span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
                startDate = start;
                endDate = end;
                //Set Items to localStorage
                localStorage.setItem('l_startDate', startDate);
                localStorage.setItem('l_endDate', endDate);

                txtSearch = true;
                GetCustomers();
            });

            // Initialize de date range
            //startDate = $("input[name='daterangepicker_start']").val();
            //endDate = $("input[name='daterangepicker_end']").val();
            //localStorage.setItem('l_startDate', startDate);
            //localStorage.setItem('l_endDate', endDate);

            // Date range picker
            //$('#reportrange').daterangepicker();

            $('#btnRun').click(function () {
                var a = $(this).parent().siblings(":first").text();
                window.location = 'Detalles.aspx?Id=' + a;
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

            var pageCount = 1;
            var pageIndex = 1;
            var firstTime = true;
            var txtSearch = false;
            var scrolled = false;
            //Load GridView Rows when DIV is scrolled
            $(window).scroll(function () {
                if ($(window).scrollTop() + $(window).height() == $(document).height()) {
                    GetCustomers();
                }
            });

            //$('#load').click(function () {
            //    scrolled = true;
            //    GetCustomers();
            //});

            // AJAX Pager and search
            $(function () {
                GetCustomers();
            });
            //$("[id*=txtSearch]").on("keyup", function () {
            //    txtSearch = true;
            //    GetCustomers(); 
            //});
            var timeoutReference;
            $('[id*=txtSearch]').keyup(function () {
                if (timeoutReference) clearTimeout(timeoutReference);
                timeoutReference = setTimeout(function () {
                    // Set item in localStorage
                    localStorage.setItem('l_searchTerm', $("[id*=txtSearch]").val());
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

                    // Get localStorage
                    if (localStorage.getItem('l_searchTerm')) {
                        $("[id*=txtSearch]").val(localStorage.getItem('l_searchTerm'));
                    }
                    //if (localStorage.getItem('l_pageIndex'))
                    //    pageIndex = localStorage.getItem('l_pageIndex');
                    //if (localStorage.getItem('l_pageSize'))
                    //    pageSize = localStorage.getItem('l_pageSize');
                    if (localStorage.getItem('l_startDate')) {
                        startDate = localStorage.getItem('l_startDate');
                        var sD = moment(startDate);
                        startDate = sD.format('DD/MM/YYYY');
                    }
                    if (localStorage.getItem('l_endDate')) {
                        endDate = localStorage.getItem('l_endDate');
                        var eD = moment(endDate);
                        endDate = eD.format('DD/MM/YYYY');
                    }
                    if (localStorage.getItem('l_deliverFilter')) {
                        deliverTimeFilter = localStorage.getItem('l_deliverFilter');
                        $('#deliverTimeDropD option[value="' + deliverTimeFilter + '"]').attr("selected", "selected");
                    }
                    if (localStorage.getItem('l_statusFilter')) {
                        statusFilter = localStorage.getItem('l_statusFilter');
                        $('#statusDropD option[value="' + statusFilter + '"]').attr("selected", "selected");
                    }

                    //$('#firstNameFilter').val('');
                    //$('#lastNAmeFilter').val('');

                    if (localStorage.getItem('l_streetFilter')) {
                        streetFilter = localStorage.getItem('l_streetFilter');
                        $('#streetFilter').val(streetFilter);
                    }
                    if (localStorage.getItem('l_colonyFilter')) {
                        colonyFilter = localStorage.getItem('l_colonyFilter');
                        $('#colonyFilter').val(colonyFilter);
                    }
                    if (localStorage.getItem('l_firstNameFilter')) {
                        firstNameFilter = localStorage.getItem('l_firstNameFilter');
                        $('#firstNameFilter').val(firstNameFilter);
                    }
                    if (localStorage.getItem('l_lastNameFilter')) {
                        lastNameFilter = localStorage.getItem('l_lastNameFilter');
                        $('#lastNAmeFilter').val(lastNameFilter);
                    }

                    $.ajax({
                        type: "POST",
                        url: "ConsultaPedidos.aspx/GetCustomers",
                        data: '{searchTerm: "' + SearchTerm() + '", pageIndex: ' + pageIndex + ', pageSize: ' + 20 + ', startDate: "' + startDate + '", endDate: "' + endDate + '"' + ', deliverFilter: "' + deliverTimeFilter + '", statusFilter: "' + statusFilter + '", streetFilter: "' + streetFilter + '", colonyFilter: "' + colonyFilter + '", firstNameFilter: "' + firstNameFilter + '", lastNameFilter: "' + lastNameFilter +  '"}',
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

                //Set variables in local storage (HTML5)
                
                //localStorage.setItem('l_pageIndex', pageIndex);
                //localStorage.setItem('l_pageSize', pageSize);
               
                
                if (txtSearch) {
                    $("[id*=gridView] tr").not($("[id*=gridView] tr:first-child")).remove();
                    txtSearch = false;
                }

                $('#loader').addClass('hidden');

                var xmlDoc = $.parseXML(response.d);
                var xml = $(xmlDoc);
                pageCount = parseInt(xml.find("PageCount").eq(0).find("PageCount").text());
                if (pageCount == 0)
                    pageCount = 1;
                var customers = xml.find("View_ClientesPedido");
                if (row == null) {
                    row = $("[id*=gridView] tr:last-child").clone(true);
                }
                //$("[id*=gridView] tr").not($("[id*=gridView] tr:first-child")).remove();
                if (customers.length > 0) {
                    $.each(customers, function () {
                        var customer = $(this);
                        $("td", row).eq(0).html($(this).find("id_pedido").text());
                        $("td", row).eq(1).html($(this).find("id_cliente").text());
                        $("td", row).eq(2).html($(this).find("nombre_cliente").text());
                        //$("td", row).eq(3).html($(this).find("apellido_cliente").text());
                        $("td", row).eq(3).html($(this).find("telefono_cliente").text());
                        $("td", row).eq(4).html($(this).find("plano_cliente").text());
                        $("td", row).eq(5).html($(this).find("fechaEntrega_orden").text());
                        $("td", row).eq(6).html($(this).find("direccion").text());
                        $("td", row).eq(7).html($(this).find("postal_cliente").text());
                        $("td", row).eq(8).html($(this).find("ciudad_cliente").text());
                        $("td", row).eq(9).html($(this).find("horarioEntrega_orden").text());
                        $("td", row).eq(10).html($(this).find("totalProductos_orden").text());
                        $("td", row).eq(11).html($(this).find("status_orden").text());
                        $("[id*=gridView]").append(row);
                        row = $("[id*=gridView] tr:last-child").clone(true);
                        //if (!$.trim($(this).text())) $(this).remove();
                        $("tr:not(:has(td))").hide();
                    });

                    //$("#gridView").find('td').each(function () {
                    //    var searchPattern;
                    //    if (!$(this).hasClass('ignore')) {
                    //        searchPattern = new RegExp('(' + SearchTerm() + ')', 'ig');
                    //        $(this).html($(this).text().replace(searchPattern, "<span class = 'highlight'>" + SearchTerm() + "</span>"));
                    //    }
                    //    if ($(this).val().toLowerCase == 'no atendido') {
                    //        $(this).closest('tr').addClass('danger');
                    //    }
                    //});

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

            // Collapsable panels
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
            });

            //Grid filters
            $('#deliverTimeFilter').click(function () {
                if ($('#deliverTimeDropD').hasClass('hidden')) {
                    $('#deliverTimeDropD').removeClass('hidden');
                }
                else {
                    $('#deliverTimeDropD').addClass('hidden');
                    //$('#deliverTimeDropD option:first-child').attr("selected", "selected");
                    $('#deliverTimeDropD').trigger('change');
                }
            });

            $('#statusFilter').click(function () {
                if ($('#statusDropD').hasClass('hidden')) {
                    $('#statusDropD').removeClass('hidden');
                }
                else {
                    $('#statusDropD').addClass('hidden');
                    //$('#statusDropD option:first-child').attr("selected", "selected");
                    $('#statusDropD').trigger('change');
                }
            });

            $('#dirFilter').click(function () {
                if ($('#dirGroup').hasClass('hidden')) {
                    $('#dirGroup').removeClass('hidden');
                }
                else {
                    $('#dirGroup').addClass('hidden');
                    //$('#streetFilter').val('');
                    //$('#colonyFilter').val('');
                    $('#dirGroup').trigger('change');
                }
            });

            $('#nameFilter').click(function () {
                if ($('#nameGroup').hasClass('hidden')) {
                    $('#nameGroup').removeClass('hidden');
                }
                else {
                    $('#nameGroup').addClass('hidden');
                    //$('#firstNameFilter').val('');
                    //$('#lastNAmeFilter').val('');
                    $('#nameGroup').trigger('change');
                }
            });


            var deliverTimeFilter = '%';
            var statusFilter = '%';
            var streetFilter = '%';
            var colonyFilter = '%';
            var firstNameFilter = '%';
            var lastNameFilter = '%';
            //Filters events
            $('#deliverTimeDropD').change(function () {
                txtSearch = true;
                deliverTimeFilter = $('#deliverTimeDropD').val();
                // Set item to localStorage
                localStorage.setItem('l_deliverFilter', deliverTimeFilter);
                //alert(deliverTimeFilter);
                GetCustomers();
            });
            $('#statusDropD').change(function () {
                txtSearch = true;
                statusFilter = $('#statusDropD').val();
                localStorage.setItem('l_statusFilter', statusFilter);
                GetCustomers();
            });
            $('#streetFilter').keyup(function () {
                //var _this = $(this); // copy of this object for further usage
                if (timeoutReference) clearTimeout(timeoutReference);
                timeoutReference = setTimeout(function () {
                    streetFilter = $("#streetFilter").val();
                    localStorage.setItem('l_streetFilter', streetFilter);
                    txtSearch = true;
                    GetCustomers();
                }, 300);
            });
            $('#colonyFilter').keyup(function () {
                //var _this = $(this); // copy of this object for further usage
                if (timeoutReference) clearTimeout(timeoutReference);
                timeoutReference = setTimeout(function () {
                    colonyFilter = $("#colonyFilter").val();
                    localStorage.setItem('l_colonyFilter', colonyFilter);
                    txtSearch = true;
                    GetCustomers();
                }, 300);
            });
            $('#dirGroup').change(function () {
                txtSearch = true;
                streetFilter = '%';
                colonyFilter = '%';
                //statusFilter = $('#statusDropD').val()
                GetCustomers();
            });
            $('#firstNameFilter').keyup(function () {
                //var _this = $(this); // copy of this object for further usage
                if (timeoutReference) clearTimeout(timeoutReference);
                timeoutReference = setTimeout(function () {
                    firstNameFilter = $("#firstNameFilter").val();
                    localStorage.setItem('l_firstNameFilter', firstNameFilter);
                    txtSearch = true;
                    GetCustomers();
                }, 300);
            });
            $('#lastNameFilter').keyup(function () {
                //var _this = $(this); // copy of this object for further usage
                if (timeoutReference) clearTimeout(timeoutReference);
                timeoutReference = setTimeout(function () {
                    lastNameFilter = $("#lastNameFilter").val();
                    localStorage.setItem('l_lastNameFilter', lastNameFilter);
                    txtSearch = true;
                    GetCustomers();
                }, 300);
            });
            $('#nameGroup').change(function () {
                txtSearch = true;
                firstNameFilter = '%';
                lastNameFilter = '%';
                //statusFilter = $('#statusDropD').val()
                GetCustomers();
            });

            // Leaving page event

        </script>
    </div>
</asp:Content>
