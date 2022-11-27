<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="listOrders.aspx.cs" Inherits="ShopPay.Admin.listOrders" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        async function updateFavorite(flag, id_doc) {
            let response = await fetch('./../updateFavorite.ashx?check=' + flag + '&doc=' + id_doc);
            let text = await response.text(); // прочитать тело ответа как текст
        }
    </script>
    <div>
        Список заказов
    <asp:GridView runat="server" ID="GridViewDocs" DataKeyNames="id_order" DataSourceID="SqlDataSourceDocs" AutoGenerateColumns="false" OnRowDataBound="GridViewDocs_RowDataBound">
        <Columns>
            <asp:TemplateField HeaderText="Заказ">
                <ItemTemplate>
                    <asp:HyperLink ID="HrefNameDoc" runat="server" Text='<%#"Заказ №"+ Eval("id_order").ToString()+" от "+ DateTime.Parse(Eval("date_order").ToString()).ToString("dd.MM.yyyy") %>' href='<%# "order?id="+Eval("id_order") %>'></asp:HyperLink>
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
                    <asp:Button ID="ButtonCommand1" runat="server" CommandName="DeleteOrder" Text="Удалить" OnClientClick="return confirm('Удалить заказ?');" Visible='<%# Eval("status").ToString()!="Оплачен" %>' CommandArgument='<%# Eval("id_order") %>' />
                    <asp:Button ID="ButtonCommand2" runat="server" CommandName="PayOrder" Text="Оплатить"  Visible='<%# Eval("status").ToString()!="Оплачен" %>' CommandArgument='<%# Eval("id_order") %>' />
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>

    </asp:GridView>
    </div>

    <asp:SqlDataSource ID="SqlDataSourceDocs" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
        SelectCommand="select * from Docs_Orders where customer=@customer order by date_order desc">
        
        <SelectParameters>
            <asp:Parameter Name="customer" />
        </SelectParameters>

    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceTags" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
        SelectCommand="select id_tag, '#'+tag_name tag_name from Docs_tags"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceSections" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
        SelectCommand="select id_section, section_name from Docs_DocSections"></asp:SqlDataSource>

</asp:Content>

