<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="admin_orders.aspx.cs" Inherits="ShopPay.Admin.admin_orders" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        async function updateFavorite(flag, id_doc) {
            let response = await fetch('./../updateFavorite.ashx?check=' + flag + '&doc=' + id_doc);
            let text = await response.text(); // прочитать тело ответа как текст
        }
    </script>
    <div>
        Фильтр
        <asp:Label ID="FiltrLableCustomer" runat="server">Пользователь</asp:Label><asp:TextBox runat="server" ID="FiltrCustomer"></asp:TextBox>

        <asp:Label ID="FiltrLableBegDate" runat="server">Заказы за пероид с</asp:Label><asp:TextBox runat="server" ID="FiltrBegDate"></asp:TextBox>
        <asp:Label ID="FiltrLableEndDate" runat="server">по</asp:Label><asp:TextBox runat="server" ID="FiltrEndDate"></asp:TextBox>
    </div>
    <div>

        Список заказов
    <asp:GridView runat="server" ID="GridViewDocs" DataKeyNames="id_order" DataSourceID="SqlDataSourceDocs" AutoGenerateColumns="false" OnRowDataBound="GridViewDocs_RowDataBound">
        <Columns>
            <asp:TemplateField HeaderText="Заказ">
                <ItemTemplate>
                    <asp:HyperLink ID="HrefNameDoc" runat="server" Text='<%#"Заказ №"+ Eval("id_order").ToString()+" от "+ DateTime.Parse(Eval("date_order").ToString()).ToString("dd.MM.yyyy") %>' href='<%# "../docs/order?id="+Eval("id_order") %>'></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Сумма">
                <ItemTemplate>
                    <asp:Label ID="LabelCost" runat="server" Text='<%# Eval("allCost") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Статус">
                <ItemTemplate>
                    <asp:Label ID="LabelStatus" runat="server" Text='<%# Eval("status") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
<%--                    <asp:Button ID="ButtonCommand1" runat="server" CommandName="DeleteOrder" Text="Удалить" OnClientClick="return confirm('Удалить заказ?');" Visible='<%# Eval("status").ToString()!="Оплачен" %>' CommandArgument='<%# Eval("id_order") %>' />--%>
                    <asp:Button ID="ButtonCommand2" runat="server" CommandName="PayOrder" Text="Оплачено"  Visible='<%# Eval("status").ToString()!="Оплачен" %>' CommandArgument='<%# Eval("id_order") %>' />
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>

    </asp:GridView>
    </div>

    <asp:SqlDataSource ID="SqlDataSourceDocs" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
        SelectCommand="select * from Docs_Orders where 
        (@customer=' ' or customer=@customer)
        order by date_order desc">
        
        <SelectParameters>
            <asp:ControlParameter Name="customer" DefaultValue=" " ControlID="FiltrCustomer" />
        </SelectParameters>

    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceTags" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
        SelectCommand="select id_tag, '#'+tag_name tag_name from Docs_tags"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceSections" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
        SelectCommand="select id_section, section_name from Docs_DocSections"></asp:SqlDataSource>

</asp:Content>

