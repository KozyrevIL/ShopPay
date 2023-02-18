<%@ Page Title="Управление учетной записью" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="ShopPay.Account.Manage" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">

    <div class="manager_user">

        <section id="header">
            <div class="container-fluid text-center">
                <h3>Администрирование.  Управление учетной записью</h3>
            </div>
        </section>
        <section id="grid_content">
            <grid_form_imput>
                <div class="form-horizontal">

                    <div class="form-group">
                        <asp:Label runat="server" CssClass="col-md-3 control-label">Пароль:</asp:Label>
                        <div class="col-md-9">
                            <asp:HyperLink NavigateUrl="/Account/ManagePassword" Text="[Изменить]" Visible="false" ID="ChangePassword" runat="server" />
                            <asp:HyperLink NavigateUrl="/Account/ManagePassword" Text="[Создать]" Visible="false" ID="CreatePassword" runat="server" />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="labelFIO" runat="server" Text="Обращение" CssClass="col-md-3 control-label" ></asp:Label>
                        <div class="col-md-9">
                            <asp:TextBox ID="TextFIO" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="label1" runat="server" Text="Телефон" CssClass="col-md-3 control-label"></asp:Label>
                        <div class="col-md-9">
                            <asp:TextBox ID="TextPhone" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="label2" runat="server" Text="Дополнительная информация" CssClass="col-md-3 control-label"></asp:Label>
                        <div class="col-md-9">
                            <asp:TextBox ID="TextInfo" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-3 col-md-9">
                            <asp:Button ID="SaveInfo" runat="server" CssClass="btn btn-success" Text="Записать" OnClick="SaveInfo_Click" />
                        </div>
                    </div>

                </div>
            </grid_form_imput>
        </section>
        <div>
            <asp:Label ID="LabelError" runat="server"></asp:Label>

        </div>
        <div>
            <asp:PlaceHolder runat="server" ID="successMessage" Visible="false" ViewStateMode="Disabled">
                <p class="text-success"><%: SuccessMessage %></p>
            </asp:PlaceHolder>
        </div>
    </div>

</asp:Content>
