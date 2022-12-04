<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="True" CodeBehind="ManageRoles.aspx.cs" Inherits="ShopPay.Account.ManageRoles" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    <div class="manage_roles">
        <section id="header">
            <div class="container-fluid text-center">
                <h3>Управление ролями</h3>
            </div>
        </section>
        <section id="grid_content">
            <grid_form_imput>

                <div class="grid_input_data">


                    <asp:TextBox ID="TextRole" runat="server" CssClass="form-control"> </asp:TextBox>
                    <asp:Button ID="BtnAddRole" runat="server" Text="Добавить роль" OnClick="BtnAddRole_Click" CssClass="btn btn-success" />
                </div>

                
                <div class="grid_view_data" style="overflow: auto">
                    <asp:GridView runat="server" ID="GridRoles" DataKeyNames="ID" CssClass="table table-secondary  table-hover table-striped" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="Name"  HeaderText="Наименование"/>
                            <asp:BoundField DataField="ID" HeaderText="ID" />
                            
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

          
            </grid_form_imput>
           
           
        </section>
    </div>


   
</asp:Content>
