<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CierreCaja.aspx.cs" Inherits="WebAdmin.Reportes.CierreCaja" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <link href="/css/bootstrap-table.css" rel="stylesheet" type="text/css" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div id="page-wrapper">
        <div class="row">
            <asp:Panel ID="panelMessage" runat="server" Visible="false"> 
            <h4 id="messagesText" class="alert_info" runat="server">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
            </h4> 
        </asp:Panel>
            <div class="col-lg-12">
                <h1>Cierres de caja <small>Administracion de caja</small></h1>
                <ol class="breadcrumb">
                    <li><a href="Dashboard"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                    <li><a href="#"><i class="fa fa-book"></i> Reportes</a></li>
                    <li class="active"><i class="fa fa-users"></i> Caja</li>
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
        <h3>Total: <strong><small id="moneyBox" class="text-success"></small></strong></h3>
        <table id="thetable" class="table table-responsive table-hover"></table>
    </div>

    <!-- Table -->
    <script src="/js/bootstrap-table.js" type="text/javascript"></script>
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

        var lastMonth = new moment(localStorage.getItem('l_startDate'));
        var thisMonth = new moment(localStorage.getItem('l_endDate'));

        $('#dashboard-report-range span').html(lastMonth.format('MMMM D, YYYY'))
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
            locale: {
                applyLabel: 'Aplicar',
                fromLabel: 'Desde',
                toLabel: 'Hasta',
                customRangeLabel: 'Rango especifico',
                daysOfWeek: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa'],
                monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
                firstDay: 0
            },
            showDropdowns: false,
            showWeekNumbers: true,
            timePicker: false,
            timePickerIncrement: 1,
            timePicker12Hour: true,
            singleDatePicker: true,
            buttonClasses: ['btn'],
            applyClass: 'btn-success',
            cancelClass: 'default',
            format: 'DD/MM/YYYY',
        },
        function (start, end) {
            //console.log("Callback has been called!");
            $('#dashboard-report-range span').html(start.format('MMMM D, YYYY'));
            startDate = start;
            //Set Items to localStorage
            localStorage.setItem('l_startDate', startDate);

            GetBox(startDate);
        });

        GetBox(startDate);

        function GetBox(date) {
            if (localStorage.getItem('l_startDate')) {
                startDate = localStorage.getItem('l_startDate');
                var sD = moment(startDate);
                date = sD.format('DD/MM/YYYY');
            }
            else {
                date = moment().format("DD/MM/YYYY");
            }

            $.ajax({
                type: "POST",
                url: "CierreCaja.aspx/GetBox",
                data: "{date: '" + date + "'}",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                traditional: true,
                success: OnSuccessGetBox,
                failure: function (response) {
                    alert("Fail: " + response.d);
                },
                error: function (response) {
                    alert("Error: " + response.d);
                }
            });
        }

        function OnSuccessGetBox(response) {
            var boxItems = JSON.parse(response.d);
            populateTable(boxItems.BoxItemsTable);
            $("#moneyBox").text("$" + boxItems.Total);
        }

        function populateTable(data) {
            var table = $('#thetable').bootstrapTable({
                columns: [{
                    field: 'Id',
                    title: 'ID'
                }, {
                    field: 'FullName',
                    title: 'Cliente'
                }, {
                    field: 'Total',
                    title: 'Efectivo'
                }],
            });

            table.bootstrapTable('load', data);
        }

    </script>    
</asp:Content>