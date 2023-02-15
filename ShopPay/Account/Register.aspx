<%@ Page Title="Регистрация" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="ShopPay.Account.Register" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">

    <div class="register_user">



        <section id="header">
            <div class="container-fluid text-center">
                <h3>Администрирование.  Создание новой учетной записи</h3>
            </div>
        </section>
        <section id="grid_content">
            <grid_form_imput>
                <div class="form-horizontal">
                    <asp:ValidationSummary runat="server" CssClass="text-danger" />
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-3 control-label">Адрес электронной почты</asp:Label>
                        <div class="col-md-9">
                            <asp:TextBox runat="server" ID="Email" CssClass="form-control" TextMode="Email" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                                CssClass="text-danger" ErrorMessage="Поле адреса электронной почты заполнять обязательно." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-3 control-label">Пароль</asp:Label>
                        <div class="col-md-9">
                            <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
                                CssClass="text-danger" ErrorMessage="Поле пароля заполнять обязательно." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-3 control-label">Подтверждение пароля</asp:Label>
                        <div class="col-md-9">
                            <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                                CssClass="text-danger" Display="Dynamic" ErrorMessage="Поле подтверждения пароля заполнять обязательно." />
                            <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                                CssClass="text-danger" Display="Dynamic" ErrorMessage="Пароль и его подтверждение не совпадают." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="TextBoxNameCustomer" CssClass="col-md-3 control-label">Как к Вам обрашаться (ФИО, ник и т.п.) </asp:Label>
                        <div class="col-md-9">
                            <asp:TextBox runat="server" ID="TextBoxNameCustomer"  CssClass="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="TextBoxInfo" CssClass="col-md-3 control-label">Дополнительная информация (организация и т.п.) </asp:Label>
                        <div class="col-md-9">
                            <asp:TextBox runat="server" ID="TextBoxInfo"  CssClass="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="TextBoxNameCustomer" CssClass="col-md-3 control-label">Телефон для связи </asp:Label>
                        <div class="col-md-9">
                            <asp:TextBox runat="server" ID="TextBoxPhone"  CssClass="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-3 col-md-9">
                            <asp:Button runat="server" OnClick="CreateUser_Click" Text="Регистрация" CssClass="btn btn-success" />
                        </div>
                    </div>
                </div>
            </grid_form_imput>
        </section>

        <%--<h2><%: Title %>.</h2>--%>
        <p class="text-danger">
            <asp:Literal runat="server" ID="ErrorMessage" />
        </p>

        <%--<div class="form-horizontal">
        <h4>Создание новой учетной записи</h4>
        <hr />
    </div>--%>
    </div>
</asp:Content>
