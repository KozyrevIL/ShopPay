<%@ Page Title="Управление учетной записью" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="ShopPay.Account.Manage" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>

    <div>
        <asp:PlaceHolder runat="server" ID="successMessage" Visible="false" ViewStateMode="Disabled">
            <p class="text-success"><%: SuccessMessage %></p>
        </asp:PlaceHolder>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="form-horizontal">
                <h4>Изменение параметров учетной записи</h4>
                <hr />
                <dl class="dl-horizontal">
                    <dt>Пароль:</dt>
                    <dd>
                        <asp:HyperLink NavigateUrl="/Account/ManagePassword" Text="[Изменить]" Visible="false" ID="ChangePassword" runat="server" />
                        <asp:HyperLink NavigateUrl="/Account/ManagePassword" Text="[Создать]" Visible="false" ID="CreatePassword" runat="server" />
                    </dd>
                    <%-- %><dt>Внешние имена входа:</dt>
                    <dd><%: LoginsCount %>
                        <asp:HyperLink NavigateUrl="/Account/ManageLogins" Text="[Управление]" runat="server" />

                    </dd>
                    --%>
                    <%--
                        Phone Numbers can used as a second factor of verification in a two-factor authentication system.
                        See <a href="https://go.microsoft.com/fwlink/?LinkId=403804">this article</a>
                        for details on setting up this ASP.NET application to support two-factor authentication using SMS.
                        Uncomment the following blocks after you have set up two-factor authentication
                    --%>
                    <%--
                    <dt>Phone Number:</dt>
                    <% if (HasPhoneNumber)
                       { %>
                    <dd>
                        <asp:HyperLink NavigateUrl="/Account/AddPhoneNumber" runat="server" Text="[Добавить]" />
                    </dd>
                    <% }
                       else
                       { %>
                    <dd>
                        <asp:Label Text="" ID="PhoneNumber" runat="server" />
                        <asp:HyperLink NavigateUrl="/Account/AddPhoneNumber" runat="server" Text="[Изменить]" /> &nbsp;|&nbsp;
                        <asp:LinkButton Text="[Удалить]" OnClick="RemovePhone_Click" runat="server" />
                    </dd>
                    <% } %>
                    --%>
                    <dt>Дополнительные сведения</dt>
                    <dd>
                        <asp:Label ID="labelFIO" runat="server" Text="Обращение"></asp:Label>
                        <asp:TextBox ID="TextFIO" runat="server"></asp:TextBox>
                        <asp:Label ID="label1" runat="server" Text="Телефон"></asp:Label>
                        <asp:TextBox ID="TextPhone" runat="server"></asp:TextBox>
                        <asp:Label ID="label2" runat="server" Text="Дополнительная информация"></asp:Label>
                        <asp:TextBox ID="TextInfo" runat="server"></asp:TextBox>
                        <asp:Button ID="SaveInfo" runat="server" Text="Записать" OnClick="SaveInfo_Click" />
                    </dd>
                </dl>
            </div>
        </div>
    </div>
    <div>
        <asp:Label ID="LabelError" runat="server"></asp:Label>

    </div>

</asp:Content>
