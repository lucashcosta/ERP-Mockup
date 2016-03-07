﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ConsultaClientesPosibles.aspx.cs" Inherits="WebAdmin.ConsultaClientesPosibles" %>
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
                <h1>Clientes <small>Clientes potenciales</small></h1>
                <ol class="breadcrumb">
                    <li><a href="Dashboard"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                    <li><a href="#"><i class="fa fa-book"></i> Reportes</a></li>
                    <li class="active"><i class="fa fa-users"></i> Clientes potenciales por pedido</li>
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
        <div id="resultClients">

        </div>
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

            $("#resultClients").empty();
            GetOrderClients(startDate);
        });

        GetOrderClients(startDate);

        function GetOrderClients(date) {
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
                url: "ConsultaClientesPosibles.aspx/GetClientsOfOrders",
                data: "{date: '" + date + "'}",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                traditional: true,
                success: OnSuccessGetOrderClients,
                failure: function (response) {
                    alert("Fail: " + response.d);
                },
                error: function (response) {
                    alert("Error: " + response.d);
                }
            });
        }

        function OnSuccessGetOrderClients(response) {
            var clientRelations = JSON.parse(response.d);
            clientRelations.forEach(function (client) {
                getCloseClients(client, startDate);
            });
            //populateTable(boxItems);
            //$("#moneyBox").text("$" + boxItems.Total);
        }

        var colony = true;
        var rute = false;
        function getCloseClients(client, date) {
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
                url: "ConsultaClientesPosibles.aspx/GetCloseClients",
                data: "{client:" + JSON.stringify(client) + ", colony:" + colony + ", rute:" + rute + ", date:'" + date + "'}",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                traditional: true,
                success: OnSuccessGetCloseClients,
                failure: function (response) {
                    alert("Fail: " + response.d);
                },
                error: function (response) {
                    alert("Error: " + response.d);
                }
            });
        }

        // Store colonies/rutes to detect when repeated
        var registryClientPlaces = new Array();
        function OnSuccessGetCloseClients(response) {
            // IMPORTANT!!
            // The last item is the client who everyone is relating to
            var possibleClients = JSON.parse(response.d);
            if ((possibleClients.length - 1) == 0)
                return;

            if (arrayContains(possibleClients[0].Colonia.toLowerCase(), registryClientPlaces)) {
                // Some other client already used this colony
                var indexOfClient = registryClientPlaces.indexOf(possibleClients[0].Colonia.toLowerCase());
                pushClientWithCommonPlace(indexOfClient, possibleClients[(possibleClients.length - 1)]);
                return;
            }
            else {
                registryClientPlaces.push(possibleClients[0].Colonia.toLowerCase());
            }

            generateTable(possibleClients);
        }

        function arrayContains(needle, arrhaystack) {
            return (arrhaystack.indexOf(needle) > -1);
        }

        function pushClientWithCommonPlace(indexOfClient, clientWithOrder) {
            $("#resultClients").children().eq(indexOfClient).find('#titleIcon').removeClass('fa-user').addClass('fa-users');
            $("#resultClients").children().eq(indexOfClient).find('#clientWithOrder').append(", " + clientWithOrder.FullName);
        }

        function generateTable(data) {
            var html;
            html += "<br/>";
            html = "<div class='panel panel-primary'>";
            html += "<div class='panel-heading clickable'>";
            html += "<h4 class='panel-title'> <p id='clientWithOrder'><i id='titleIcon' class='fa fa-user'></i> Pedido de: " + prettyString((data[(data.length - 1)].FullName)) + "</p></h4>";
            html += "<span class='pull-right clickable'><i class='fa fa-chevron-up'></i></span>"
            html += "<h4 class='panel-title' style='margin-top:10px'>Clientes cercanos: <strong>" + (data.length - 1) + "</strong></h4>";
            html += "</div>";
            html += "<div class='panel-body' style='padding: 0px;'>";
            html += "<table class='table-panelfit table table-bordered table-hover table-striped table-responsive fixed-column'>";
            html += "<thead>";
            html += "<tr>";
            html += "<th>Nombre</th>";
            html += "<th>Colonia</th>";
            html += "<th>Ruta</th>";
            html += "<th>Telefono</th>";
            html += "<th>Movil</th>";
            html += "<th>Postal</th>";
            html += "</tr>";
            html += "</thead>";

            html += "<tbody>";
            for (var i = 0; i < (data.length - 1); i++) {
                html += "<tr>";
                html += "<td> <a href='/EditarCliente.aspx?Id=" + data[i].Id + "'><i class='fa fa-user icon-green'></i> " + prettyString(data[i].FullName) + "</a></td>";
                html += "<td><strong>" + prettyString(data[i].Colonia) + "</strong></td>";
                html += "<td>" + prettyString(data[i].Ruta) + "</td>";
                html += "<td>" + data[i].Phone + "</td>";
                html += "<td>" + data[i].Mobile + "</td>";
                html += "<td>" + data[i].Postal + "</td>";
                html += "</tr>";
            }

            html += "</tbody>";
            html += "</table>"
            html += "</div>";
            html += "</div>"

            //html += "<strong><p class='text-right text-success'> Gran total: " + boxItems.Total + "</p></strong>"

            $("#resultClients").append(html);
        }

        function prettyString(str) {
            str = str.toLowerCase().replace(/\b[a-z]/g, function (letter) {
                return letter.toUpperCase();
            });

            return str;
        }

        $(document).on('click', '.panel-heading span.clickable', function (e) {
            var $this = $(this);
            if (!$this.hasClass('panel-collapsed')) {
                $this.parents('.panel').find('.panel-body').slideUp();
                $this.addClass('panel-collapsed');
                $this.find('i.fa-chevron-up').removeClass('fa-chevron-up').addClass('fa-chevron-down');
            } else {
                $this.parents('.panel').find('.panel-body').slideDown();
                $this.removeClass('panel-collapsed');
                $this.find('i.fa-chevron-down').removeClass('fa-chevron-down').addClass('fa-chevron-up');
            }
        })

        $(document).on('click', '.panel-heading.clickable', function (e) {
            var $this = $(this);
            if (!$this.hasClass('panel-collapsed')) {
                $this.parents('.panel').find('.panel-body').slideUp();
                $this.addClass('panel-collapsed');
                $this.find('i.fa-chevron-up').removeClass('fa-chevron-up').addClass('fa-chevron-down');
            } else {
                $this.parents('.panel').find('.panel-body').slideDown();
                $this.removeClass('panel-collapsed');
                $this.find('i.fa-chevron-down').removeClass('fa-chevron-down').addClass('fa-chevron-up');
            }
        })

    </script>    
</asp:Content>