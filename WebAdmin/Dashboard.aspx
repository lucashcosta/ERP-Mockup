<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="WebAdmin.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div id="page-wrapper">
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="product1"/>
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="product2"/>
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="product3"/>
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="product4"/>
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="productPrice1"/>
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="productPrice2"/>
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="productPrice3"/>
        <asp:HiddenField runat="server" ClientIDMode="Static" ID="productPrice4"/>

        <div class="row">
          <div class="col-lg-12">
            <h1>Dashboard <small>Statistics Overview</small></h1>
            <ol class="breadcrumb">
              <li class="active"><i class="fa fa-dashboard"></i> Dashboard</li>
            </ol>
            <div class="alert alert-success alert-dismissable">
              <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
              Bienvenido <strong><%=HttpContext.Current.User.Identity.Name %></strong>
            </div>
          </div>
        </div><!-- /.row -->

        <div class="row">
          <div class="col-lg-3">
            <div class="panel panel-info">
              <div class="panel-heading">
                <div class="row">
                  <div class="col-xs-6">
                    <i class="fa fa-comments fa-5x"></i>
                  </div>
                  <div class="col-xs-6 text-right">
                    <p class="announcement-heading">0</p>
                    <p class="announcement-text">Nuevas ordenes</p>
                  </div>
                </div>
              </div>
                <div class="panel-footer announcement-bottom">
                  <div class="row">
                    <div class="col-xs-6">
                      Ver Ordenes
                    </div>
                    <div class="col-xs-6 text-right">
                      <i class="fa fa-arrow-circle-right"></i>
                    </div>
                  </div>
                </div>
            </div>
          </div>
          <div class="col-lg-3">
            <div class="panel panel-warning">
              <div class="panel-heading">
                <div class="row">
                  <div class="col-xs-6">
                    <i class="fa fa-check fa-5x"></i>
                  </div>
                  <div class="col-xs-6 text-right">
                    <p class="announcement-heading">0</p>
                    <p class="announcement-text">Entregadas</p>
                  </div>
                </div>
              </div>
                <div class="panel-footer announcement-bottom">
                  <div class="row">
                    <div class="col-xs-6">
                      Ver mas
                    </div>
                    <div class="col-xs-6 text-right">
                      <i class="fa fa-arrow-circle-right"></i>
                    </div>
                  </div>
                </div>
            </div>
          </div>
          <div class="col-lg-3">
            <div class="panel panel-danger">
              <div class="panel-heading">
                <div class="row">
                  <div class="col-xs-6">
                    <i class="fa fa-tasks fa-5x"></i>
                  </div>
                  <div class="col-xs-6 text-right">
                    <p class="announcement-heading">0</p>
                    <p class="announcement-text">Pendientes</p>
                  </div>
                </div>
              </div>
                <div class="panel-footer announcement-bottom">
                  <div class="row">
                    <div class="col-xs-6">
                      Ver pendientes
                    </div>
                    <div class="col-xs-6 text-right">
                      <i class="fa fa-arrow-circle-right"></i>
                    </div>
                  </div>
                </div>
            </div>
          </div>
          <div class="col-lg-3">
            <div class="panel panel-success">
              <div class="panel-heading">
                <div class="row">
                  <div class="col-xs-6">
                    <i class="fa fa-comments fa-5x"></i>
                  </div>
                  <div class="col-xs-6 text-right">
                    <p class="announcement-heading">0</p>
                    <p class="announcement-text">Ordenes pagadas</p>
                  </div>
                </div>
              </div>
                <div class="panel-footer announcement-bottom">
                  <div class="row">
                    <div class="col-xs-6">
                      Ver ordenes
                    </div>
                    <div class="col-xs-6 text-right">
                      <i class="fa fa-arrow-circle-right"></i>
                    </div>
                  </div>
                </div>
            </div>
          </div>
        </div><!-- /.row -->

        <div class="row">
          <div class="col-lg-12">
            <div class="panel panel-primary">
              <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-bar-chart-o"></i> Pedidos</h3>
              </div>
              <div class="panel-body">
                <div id="morris-chart-area"></div>
              </div>
            </div>
          </div>
        </div><!-- /.row -->

        <div class="row">
          <div class="col-lg-4">
            <div class="panel panel-primary">
              <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-long-arrow-right"></i> Productos mas solicitados</h3>
              </div>
              <div class="panel-body">
                <div id="morris-chart-donut"></div>
                <div class="text-right">
                  <a href="#" onclick="return CallGetPopularItems();">Ver detalles <i class="fa fa-arrow-circle-right"></i></a>
                </div>
              </div>
            </div>
          </div>
          <div class="col-lg-4">
            <div class="panel panel-primary">
              <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-clock-o"></i> Actividad reciente</h3>
              </div>
              <div class="panel-body">
                <div class="list-group">
                  <a href="#" class="list-group-item">
                    <span class="badge">just now</span>
                    <i class="fa fa-calendar"></i> Nuevos pedidos
                  </a>
                  <a href="#" class="list-group-item">
                    <span class="badge">23 minutes ago</span>
                    <i class="fa fa-truck"></i> Orden 392 entregada
                  </a>
                  <a href="#" class="list-group-item">
                    <span class="badge">46 minutes ago</span>
                    <i class="fa fa-money"></i> Invoice 653 pagado
                  </a>
                  <a href="#" class="list-group-item">
                    <span class="badge">1 hour ago</span>
                    <i class="fa fa-user"></i> Nuevo cliente añadido
                  </a>
                  <a href="#" class="list-group-item">
                    <span class="badge">two days ago</span>
                    <i class="fa fa-check"></i> Completed task: "Completar pendiente orden 144"
                  </a>
                </div>
                <div class="text-right">
                  <a href="#">Ver actividad <i class="fa fa-arrow-circle-right"></i></a>
                </div>
              </div>
            </div>
          </div>

          <%--<div class="col-lg-4">
            <div class="panel panel-primary">
              <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-money"></i> Recent Transactions</h3>
              </div>
              <div class="panel-body">
                <div class="table-responsive">
                  <table class="table table-bordered table-hover table-striped tablesorter">
                    <thead>
                      <tr>
                        <th>Order # <i class="fa fa-sort"></i></th>
                        <th>Order Date <i class="fa fa-sort"></i></th>
                        <th>Order Time <i class="fa fa-sort"></i></th>
                        <th>Amount (USD) <i class="fa fa-sort"></i></th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <td>3326</td>
                        <td>10/21/2013</td>
                        <td>3:29 PM</td>
                        <td>$321.33</td>
                      </tr>
                      <tr>
                        <td>3325</td>
                        <td>10/21/2013</td>
                        <td>3:20 PM</td>
                        <td>$234.34</td>
                      </tr>
                      <tr>
                        <td>3324</td>
                        <td>10/21/2013</td>
                        <td>3:03 PM</td>
                        <td>$724.17</td>
                      </tr>
                      <tr>
                        <td>3323</td>
                        <td>10/21/2013</td>
                        <td>3:00 PM</td>
                        <td>$23.71</td>
                      </tr>
                      <tr>
                        <td>3322</td>
                        <td>10/21/2013</td>
                        <td>2:49 PM</td>
                        <td>$8345.23</td>
                      </tr>
                      <tr>
                        <td>3321</td>
                        <td>10/21/2013</td>
                        <td>2:23 PM</td>
                        <td>$245.12</td>
                      </tr>
                      <tr>
                        <td>3320</td>
                        <td>10/21/2013</td>
                        <td>2:15 PM</td>
                        <td>$5663.54</td>
                      </tr>
                      <tr>
                        <td>3319</td>
                        <td>10/21/2013</td>
                        <td>2:13 PM</td>
                        <td>$943.45</td>
                      </tr>
                    </tbody>
                  </table>
                </div>
                <div class="text-right">
                  <a href="#">View All Transactions <i class="fa fa-arrow-circle-right"></i></a>
                </div>
              </div>
            </div>
          </div>--%>
        </div><!-- /.row -->

      </div><!-- /#page-wrapper -->

    <!-- Page Specific Plugins -->
    <script src="js/tablesorter/jquery.tablesorter.js"></script>
    <script src="js/tablesorter/tables.js"></script>
    <script>
        var items = new Array();
        var sellsMonths = new Array();

        // -------------- Get popular items donut chart
        function CallGetPopularItems() {
            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/GetPopularItems",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccessGetPopularItems,
                failure: function (response) {
                    alert(response.d);
                },
                error: function (response) {
                    alert(response.d);
                }
            });
            //PageMethods.GetPopularItems(OnSuccessGetPopularItems);
        }
        function OnSuccessGetPopularItems(response) {
            for (var i in response.d) {
                //alert(response[i].Name + " " + response[i].RequestedQty);
                items[i] = response.d[i];
            }

            Morris.Donut({
                element: 'morris-chart-donut',
                data: [
                  { label: items[0].Name, value: items[0].RequestedQty },
                  { label: items[1].Name, value: items[1].RequestedQty },
                  { label: items[2].Name, value: items[2].RequestedQty },
                  { label: items[3].Name, value: items[3].RequestedQty }
                ]
            });
        }

        // -------------- Get sells chart area
        function CallGetSells() {
            $.ajax({
                type: "POST",
                url: "Dashboard.aspx/GetSellsByMonth",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccessGetSellsByMonth,
                failure: function (response) {
                    alert(response.d);
                },
                error: function (response) {
                    alert(response.d);
                }
            });
        }

        function OnSuccessGetSellsByMonth(response) {
            for (var i in response.d) {
                //alert(response[i].Name + " " + response[i].RequestedQty);
                sellsMonths[i] = response.d[i];
            }

            Morris.Line({
                element: 'morris-chart-area',
                data: [
                  { d: '2014-01', w: sellsMonths[0].Qty },
                  { d: '2014-02', w: sellsMonths[1].Qty },
                  { d: '2014-03', w: sellsMonths[2].Qty },
                  { d: '2014-04', w: sellsMonths[3].Qty },
                  { d: '2014-05', w: sellsMonths[4].Qty },
                  { d: '2014-06', w: sellsMonths[5].Qty },
                  { d: '2014-07', w: sellsMonths[6].Qty },
                  { d: '2014-08', w: sellsMonths[7].Qty },
                  { d: '2014-09', w: sellsMonths[8].Qty },
                  { d: '2014-10', w: sellsMonths[9].Qty },
                  { d: '2014-11', w: sellsMonths[10].Qty },
                  { d: '2014-12', w: sellsMonths[11].Qty },
                ],
                xkey: 'd',
                ykeys: ['w'],
                xLabelFormat: function (d) {
                    return d.getDate() + '/' + (d.getMonth() + 1) + '/' + d.getFullYear();
                },
                xLabels: 'day',
                labels: ['Compras'],
                //lineColors: ['#167f39'],
                lineWidth: 2,
                dateFormat: function (x) {
                    var IndexToMonth = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"];
                    var month = IndexToMonth[new Date(x).getMonth()];
                    var year = new Date(x).getFullYear();
                    return year + ' ' + month;
                },
                xLabelFormat: function (x) {
                    var IndexToMonth = ["Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"];
                    var month = IndexToMonth[x.getMonth()];
                    var year = x.getFullYear();
                    return month;
                },
            });
        }

        // Howto morris line
        //Morris.Line({
        //    element: 'line-example',
        //    data: [
        //      { d: '2012-04-18', w: 0, n: 1, t: 1 },
        //      { d: '2012-05-17', w: 0, n: 1, t: 1 },
        //      { d: '2012-06-15', w: 1, n: 0, t: 1 },
        //      { d: '2012-07-18', w: 0, n: 1, t: 1 },
        //      { d: '2012-08-17', w: 0, n: 1, t: 1 },
        //      { d: '2012-09-15', w: 1, n: 0, t: 1 },
        //      { d: '2012-10-18', w: 0, n: 1, t: 1 },
        //      { d: '2012-11-17', w: 0, n: 1, t: 1 },
        //      { d: '2012-12-15', w: 1, n: 0, t: 1 },
        //    ],
        //    xkey: 'd',
        //    ykeys: ['w', 'n', 't'],
        //    xLabelFormat: function (d) {
        //        return d.getDate() + '/' + (d.getMonth() + 1) + '/' + d.getFullYear();
        //    },
        //    xLabels: 'day',
        //    labels: ['Winners', 'Non-winners', 'Total'],
        //    lineColors: ['#167f39', '#990000', '#000099'],
        //    lineWidth: 2,
        //    dateFormat: function (x) {
        //        var IndexToMonth = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"];
        //        var month = IndexToMonth[new Date(x).getMonth()];
        //        var year = new Date(x).getFullYear();
        //        return year + ' ' + month;
        //    },
        //    xLabelFormat: function (x) {
        //        var IndexToMonth = ["Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"];
        //        var month = IndexToMonth[x.getMonth()];
        //        var year = x.getFullYear();
        //        return month;
        //    },
        //});

        $(document).ready(function () {
            CallGetPopularItems();
            CallGetSells();
        });
    </script>
</asp:Content>
