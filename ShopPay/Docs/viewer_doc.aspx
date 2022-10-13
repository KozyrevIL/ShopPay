<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="viewer_doc.aspx.cs" Inherits="ShopPay.Admin.viewer_doc" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>

        <asp:Image ID="ImageCover" runat="server" ImageUrl="" />

        <h3><asp:Label ID="PriceDoc" runat="server"></asp:Label> руб.</h3>
        <asp:Button ID="ButtonFavortite" runat="server" OnClick="ButtonFavortite_Click" Text="В избранное"/>
        <asp:Button ID="ButtonBasket" runat="server" OnClick="ButtonBasket_Click" Text="В корзину"/>
        <h2>
            <asp:Label ID="NameDoc" runat="server"></asp:Label>
        </h2>
        <br />
        <asp:Label ID="DescrDoc" runat="server"></asp:Label>

        Дата документа:
        <asp:Label ID="DateDoc" runat="server"></asp:Label>
        <br />
        Статус:
        <asp:Label ID="ActualDoc" runat="server"></asp:Label>
        <br />
        <h2>
            Содержание документа:
        </h2>
        <br />
        <asp:Label ID="ContentDoc" runat="server"></asp:Label>
</asp:Content>

