<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebAdmin.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <script src="js/TweenLite/TweenLite.js"></script>
    <script src="js/jquery-1.11.0.js"></script>
    <script src="js/bootstrap.js"></script>
    <link href="css/bootstrap-yeti.css" rel="stylesheet"/>
    <link href="css/login.css" rel="stylesheet"/>
</head>
<body>
    <form id="loginForm" runat="server">
        <div class="container">
            <div class="row vertical-offset-100">
    	        <div class="col-sm-4 col-sm-offset-4">
    		        <div class="panel panel-default">
			  	        <div class="panel-heading">
			    	        <h3 class="panel-title">Ingresar</h3>
			 	        </div>
			  	        <div class="panel-body">
                              <div class="form-group">
                                  <%--<input class="form-control" placeholder="Usuario" name="email" type="text"/>--%>
                                  <asp:TextBox runat="server" ID="txt_user" placeholder="Usuario" CssClass="form-control"></asp:TextBox>
			    		        </div>
			    		        <div class="form-group">
			    			        <%--<input class="form-control" placeholder="Contraseña" name="password" type="password" value=""/>--%>
                                    <asp:TextBox runat="server" ID="txt_passw" placeholder="Contraseña" CssClass="form-control"></asp:TextBox>
			    		        </div>
			    		        <%--<div class="checkbox">
			    	    	        <label>
			    	    		        <input name="remember" type="checkbox" value="Remember Me"/> Remember Me
			    	    	        </label>
			    	            </div>--%>
                              <%--<input class="btn btn-lg btn-success btn-block" type="submit" value="Login"/>--%>
                              <asp:LinkButton ID="loginLinkBtn" CssClass="btn btn-lg btn-success btn-block" runat="server" Text="Login" OnClick="loginLinkBtn_Click" />
			            </div>
			        </div>
		        </div>
            </div>
        </div>
    </form>
    <script>
        $(document).ready(function () {
            $(document).mousemove(function (e) {
                TweenLite.to($('body'),
                   .5,
                   {
                       css:
                         {
                             'background-position': parseInt(event.pageX / 8) + "px " + parseInt(event.pageY / 12) + "px, " + parseInt(event.pageX / 15) + "px " + parseInt(event.pageY / 15) + "px, " + parseInt(event.pageX / 30) + "px " + parseInt(event.pageY / 30) + "px"
                         }
                   });
            });
        });
    </script>
</body>
</html>
