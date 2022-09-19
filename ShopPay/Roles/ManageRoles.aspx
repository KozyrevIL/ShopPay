<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="True" CodeBehind="ManageRoles.aspx.cs" Inherits="ShopPay.Account.ManageRoles" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Управление ролями.</h2>
    <div>
        <asp:TextBox ID="TextRole" runat="server" > </asp:TextBox>
        <asp:Button ID="BtnAddRole" runat="server" Text="Добавить" OnClick="BtnAddRole_Click"/>
        <section id="RolesForm">

            <asp:GridView runat="server" ID="GridRoles" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="ID" />
                    <asp:BoundField DataField="Name" />
                </Columns>
            </asp:GridView>

        </section>
    </div>
</asp:Content>
