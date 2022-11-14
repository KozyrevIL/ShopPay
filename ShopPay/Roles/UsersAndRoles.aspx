<%@ Page Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="True" CodeBehind="UsersAndRoles.aspx.cs" Inherits="Roles_UsersAndRoles" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h2>Управление ролями пользователей</h2>
    <p align="center">
        <asp:Label ID="ActionStatus" runat="server" CssClass="Important"></asp:Label>
    </p>
    <h3>Управление ролями у пользователя</h3>
    <p>
        <b>Выберите пользователя:</b>
        <asp:DropDownList ID="UserList" runat="server" AutoPostBack="True" 
            DataTextField="UserName" DataValueField="UserName" 
            onselectedindexchanged="UserList_SelectedIndexChanged">
        </asp:DropDownList>
    </p>
    <p>
        <asp:Repeater ID="UsersRoleList" runat="server">
            <ItemTemplate>
                <asp:CheckBox runat="server" ID="RoleCheckBox" AutoPostBack="true" Text='<%# Eval("Name") %>' OnCheckedChanged="RoleCheckBox_CheckChanged" />
                <br />
            </ItemTemplate>
        </asp:Repeater>
    </p>
    
    <h3>Назначение пользователей у роли</h3>
    <p>
        <b>Выберите роль:</b>
        <asp:DropDownList ID="RoleList" runat="server" AutoPostBack="true" DataTextField="Name"
            onselectedindexchanged="RoleList_SelectedIndexChanged">
        </asp:DropDownList>
    </p>
    <p>
        <asp:GridView ID="RolesUserList" runat="server" AutoGenerateColumns="False" 
            EmptyDataText="Нет пользователей у этой роли." 
            onrowdeleting="RolesUserList_RowDeleting">
            <Columns>
                <asp:CommandField DeleteText="Удалить" ShowDeleteButton="True" />
                <asp:TemplateField HeaderText="Users">
                    <ItemTemplate>
                        <asp:Label runat="server" id="UserNameLabel" Text='<%# Container.DataItem %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </p>
    <p>
        <b>Пользователь:</b>
        <asp:TextBox ID="UserNameToAddToRole" runat="server"></asp:TextBox>
        <br />
        <asp:Button ID="AddUserToRoleButton" runat="server" Text="Добавить пользователя в роль" 
            onclick="AddUserToRoleButton_Click" />
    </p>
</asp:Content>


