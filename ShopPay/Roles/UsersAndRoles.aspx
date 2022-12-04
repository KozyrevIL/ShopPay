<%@ Page Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="True" CodeBehind="UsersAndRoles.aspx.cs" Inherits="Roles_UsersAndRoles" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">


    <div class="users_and_roles">
        <section id="header">
            <div class="container-fluid text-center">
                <h3>Администрирование.  Управление ролями пользователей</h3>
            </div>
        </section>
        <section id="grid_content">
            <grid_form_imput>
                <div class="grid_input_data">
                    <h4>Управление ролями пользователя</h4>
                    <div class="input_data_item1">
                        <b>Выберите пользователя:</b>
                        <asp:DropDownList ID="UserList" runat="server" AutoPostBack="True" CssClass="form-control"
                            DataTextField="UserName" DataValueField="UserName" Width="245px"
                            OnSelectedIndexChanged="UserList_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                    <div class="input_data_item2">
                        <asp:Repeater ID="UsersRoleList" runat="server">
                            <ItemTemplate>
                                <asp:CheckBox runat="server" ID="RoleCheckBox" AutoPostBack="true" Text='<%# Eval("Name") %>' OnCheckedChanged="RoleCheckBox_CheckChanged" />
                                <br />
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
                <div class="grid_view_data">
                    <div>
                        <h4>Назначение пользователей у роли</h4>
                    </div>
                    <div class="view_data_item1" >
                        
                            <b>Выберите роль:</b>
                            <asp:DropDownList ID="RoleList" Width="245px" CssClass="form-control" runat="server" AutoPostBack="true" DataTextField="Name"
                                OnSelectedIndexChanged="RoleList_SelectedIndexChanged">
                            </asp:DropDownList>
                        
                    </div>

                    <div class="view_data_item2" style="overflow: auto">
                        <div style="height:210px;">
                            <b>Пользователи:</b>
                            <asp:GridView ID="RolesUserList" runat="server" AutoGenerateColumns="False"
                                EmptyDataText="Нет пользователей у этой роли." CssClass="table table-secondary  table-hover table-striped"
                                OnRowDeleting="RolesUserList_RowDeleting">
                                <Columns>
                                    <%--<asp:CommandField DeleteText="Удалить" ShowDeleteButton="True" />--%>
                                    <asp:TemplateField HeaderText="Users">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="UserNameLabel" Text='<%# Container.DataItem %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="True" HeaderText="Действие">
                                        <ItemTemplate>
                                            <div class="btn-group">
                                                <asp:LinkButton ID="LinkButtonEdit" runat="server" ToolTip="Редактировать" CommandName="Edit" CausesValidation="false" CssClass="btn btn-success">
                                <i class="glyphicon glyphicon-pencil"></i>
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="LinkButtonDelete" runat="server" OnClientClick="return confirm('Удалить запись?');" ToolTip="Удалить" CommandName="Delete" CausesValidation="false" CssClass="btn  btn-danger">
                                <i class="glyphicon glyphicon-trash"></i>
                                                </asp:LinkButton>
                                            </div>

                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <div class="btn-group">
                                                <asp:LinkButton ID="LinkButtonUpdate" runat="server" ToolTip="Обновить" CommandName="Update" CausesValidation="false" CssClass="btn btn-success">
                                <i class="glyphicon glyphicon-ok"></i>
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="LinkButtonCancel" runat="server" ToolTip="Отменить" CommandName="Cancel" CausesValidation="false" CssClass="btn btn-warning">
                                <i class="glyphicon glyphicon-remove"></i>
                                                </asp:LinkButton>
                                            </div>
                                        </EditItemTemplate>
                                        <ItemStyle Width="100px" />

                                    </asp:TemplateField>
                                </Columns>
                                <AlternatingRowStyle CssClass="alter_row_style" />
                                <RowStyle CssClass="item_row_style" />
                            </asp:GridView>

                            
                        </div>
                    </div>
                    <div class="view_data_item3" >
                        <b>Пользователь:</b>
                        <asp:TextBox ID="UserNameToAddToRole" CssClass="form-control" runat="server"></asp:TextBox>
                        <br />
                        <asp:Button ID="AddUserToRoleButton" CssClass="btn btn-success" runat="server" Text="Добавить пользователя в роль"
                            OnClick="AddUserToRoleButton_Click" />
                    </div>
                </div>
            </grid_form_imput>
        </section>
        <section id="status_data">
            <p>
                Статус: <b><asp:Label ID="ActionStatus" runat="server" CssClass="Important"></asp:Label></b>
            </p>
        </section>
    </div>
  
</asp:Content>


