<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GridDrop.aspx.cs" Inherits="WebAdmin.GridDrop" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <asp:DropDownList ID="brandDrop" AppendDataBoundItems="true" ClientIDMode="Static" runat="server" CssClass="form-group">
                                <asp:ListItem>Selecciona marca</asp:ListItem>
                            </asp:DropDownList>
    <asp:Button runat="server" id="deleteBrandBtn" Text="Delete" OnClick="deleteBrandBtn_Click"/>
</asp:Content>
