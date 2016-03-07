<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Inventario.aspx.cs" Inherits="WebAdmin.Inventario" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="/css/neon/neon-core.css">
    <link rel="stylesheet" href="/css/neon/neon.css">
    <link rel="stylesheet" href="/entypo/css/entypo.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <asp:HiddenField runat="server" ClientIDMode="Static" ID="startDate" Value=""/>
    <asp:HiddenField runat="server" ClientIDMode="Static" ID="endDate" Value=""/>

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1>Inventario <small>Prodcutos por ordenar</small></h1>
                <ol class="breadcrumb">
                    <li><a href="Dashboard"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                    <li><a href="#"><i class="fa fa-book"></i> Consultas</a></li>
                    <li class="active"><i class="fa fa-file-text-o"></i> Inventario</li>
                </ol>
            </div>
        </div><!-- /.row Titulo de aspx -->

        <div class="row">
            <span class="pull-right clickable">
		    <div id="dashboard-report-range" class="dashboard-report-range" data-placement="top" data-original-title="Change dashboard date range">
			    <i class="fa fa-calendar"></i>
			    <span id="daterange">
			    </span>
			    <i class="fa fa-angle-down" style="padding-right: 12px;"></i>
		    </div>
	    </span>
        </div>
        <br />
        
        <div id="container" class="row">
	        
        </div>

        <script type="text/javascript">
            
            var items = new Array();
            var htmlTile = new Array();
            var counter = 0;
            function CallGetRequestedItems() {

                $.ajax({
                    type: "POST",
                    url: "Inventario.aspx/GetRequestedItems",
                    data: '{startDate: "' + startDate + '", endDate: "' + endDate + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnSuccessGetRequestedItems,
                    failure: function (response) {
                        alert(response.d);
                    },
                    error: function (response) {
                        alert(response.d);
                    }
                });
                //PageMethods.GetPopularItems(OnSuccessGetPopularItems);
            }
            function OnSuccessGetRequestedItems(response) {
                $('#container').empty();
                for (var i in response.d) {
                    items[i] = response.d[i];
                    htmlTile[i] =
                    '<div class="col-sm-3">' +
		                    '<div class="tile-stats tile-white tile-white-primary clickable myPop" ' +
                            'data-container="body" data-placement="top" data-content="' + items[i].Description + '. Precio: ' + items[i].Price + '">' +
                            '<div class="icon"><i class="entypo-paper-plane"></i></div>' +
                            '<div class="num" data-start="0" data-end="83" data-prefix="-, " data-postfix=" &;" data-duration="1500" data-delay="0">' + items[i].Qty + '</div>' +

                            '<h3>' + items[i].Name + '</h3>' +
                            '<p>' + items[i].Brand + '</p>' +
                        '</div>' +
                    '</div>'

                    $('#container').append(htmlTile[i]);
                    $('.myPop').popover();

                    counter++;
                }

                //Morris.Donut({
                //    element: 'morris-chart-donut',
                //    data: [
                //      { label: items[0].Name, value: items[0].RequestedQty },
                //      { label: items[1].Name, value: items[1].RequestedQty },
                //      { label: items[2].Name, value: items[2].RequestedQty },
                //      { label: items[3].Name, value: items[3].RequestedQty }
                //    ]
                //});
            }

            $(document).ready(function () {
                
            });

            //------------ Date range picker below---------------
            
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

            var today = moment();
            var tomorrow = moment().add('days', 1);

            var picker;
            $('#dashboard-report-range span').html(today.format('MMMM D, YYYY') + ' - ' + tomorrow.format('MMMM D, YYYY'))
            $('#dashboard-report-range').daterangepicker({
                opens: 'left',
                startDate: moment(),
                endDate: moment().add('days', 1),
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
                    'Mañana': [moment().add('days', 1), moment().add('days', 1)],
                    'Proximos 7 Dias': [moment(), moment().add('days', 6)],
                    'Proximos 30 Días': [moment().add('days', 29), moment()],
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
                picker = this;
                //console.log("Callback has been called!");
                $('#dashboard-report-range span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
                startDate = this.startDate.format('DD/MM/YYYY');
                endDate = this.endDate.format('DD/MM/YYYY')
                $('#startDate').val(startDate);
                $('#endDate').val(endDate);
                CallGetRequestedItems();
            });

            // Initialize de date range
            startDate = $("input[name='daterangepicker_start']").val();
            endDate = $("input[name='daterangepicker_end']").val();

            </script>

    </div>
</asp:Content>
