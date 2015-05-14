<%@ Page Title="Log in" Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebAdmin.Account.Login" %>
<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <script src="/js/TweenLite/TweenLite.js"></script>
    <script src="/js/jquery-1.11.0.js"></script>
    <script src="/js/bootstrap.js"></script>
    <link href="/css/bootstrap-yeti.css" rel="stylesheet"/>
    <link href="/css/login.css" rel="stylesheet"/>

</head>
    <body>
        <form runat="server">
    <section id="loginForm">
       <%-- <h2>Use a local account to log in.</h2>--%>
        <asp:Login runat="server" ViewStateMode="Disabled" RenderOuterTable="false" DestinationPageUrl="~/Dashboard">
            <LayoutTemplate>
                <%--<p class="validation-summary-errors">
                    <asp:Literal runat="server" ID="FailureText" />
                </p>--%>
                <fieldset>

                    <!-- Comienza -->
                    <div class="container">
                        <div class="row vertical-offset-100">
    	                    <div class="col-md-4 col-md-offset-4">
    		                    <div class="panel panel-default">
			  	                    <div class="panel-heading">
			    	                    <h3 class="panel-title">Ingresar</h3>
			 	                    </div>
			  	                    <div class="panel-body">
                                          <asp:Panel runat="server" ID="loginPanel" DefaultButton="loginLinkBtn">
                                        <fieldset>
			    	  	                    <div class="form-group">
                                                  <%--<input class="form-control" placeholder="Usuario" name="email" type="text"/>--%>
                                                  <%--<asp:Label runat="server" AssociatedControlID="UserName">User name</asp:Label>--%>
                                                  <asp:TextBox runat="server" ID="UserName" placeholder="Usuario" CssClass="form-control" />
                                                  <%--<asp:RequiredFieldValidator runat="server" ControlToValidate="UserName" CssClass="field-validation-error" ErrorMessage="The user name field is required." />--%>
			    		                    </div>
			    		                    <div class="form-group">
                                                <%--<input class="form-control" placeholder="Contraseña" name="password" type="password" value=""/>--%>
                                                <%--<asp:Label runat="server" AssociatedControlID="Password">Password</asp:Label>--%>
                                                <asp:TextBox runat="server" ID="Password" TextMode="Password"  placeholder="Contraseña" CssClass="form-control"/>
                                                <%--<asp:RequiredFieldValidator runat="server" ControlToValidate="Password" CssClass="field-validation-error" ErrorMessage="The password field is required." />--%>
			    		                    </div>
			    		                    <!--<div class="checkbox">-->
			    	    	                    <%--<label>
			    	    		                    <input name="remember" type="checkbox" value="Remember Me"/> Remember Me
			    	    	                    </label>--%>
                                                <%--<asp:CheckBox runat="server" ID="RememberMe" CssClass="css-checkbox" />
                                                <asp:Label runat="server" AssociatedControlID="RememberMe" CssClass="checkbox ">Recuerdame</asp:Label>--%>
			    	                        <!--</div>-->
			    		                    <%--<input class="btn btn-lg btn-success btn-block" type="submit" value="Login"/>--%>
                                            <asp:LinkButton ID="loginLinkBtn" CssClass="btn btn-lg btn-success btn-block" runat="server" CommandName="Login" Text="Login" />
                                            <p style="color:white;" class="validation-summary-errors">
                                                <asp:Literal runat="server" ID="Literal1" />
                                            </p>
                                            </asp:Panel>
			    	                    </fieldset>
			                        </div>
			                    </div>
		                    </div>
                        </div>
                    </div>
                    <!-- Termina -->
                </fieldset>
            </LayoutTemplate>
        </asp:Login>
<%--        <p>
            <asp:HyperLink runat="server" ID="RegisterHyperLink" ViewStateMode="Disabled">Register</asp:HyperLink>
            if you don't have an account.
        </p>--%>
    </section>

<%--    <section id="socialLoginForm">
        <h2>Use another service to log in.</h2>
        <uc:OpenAuthProviders runat="server" ID="OpenAuthLogin" />
    </section>--%>
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
        </form>
    </body>
</html>
