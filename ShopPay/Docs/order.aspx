﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="order.aspx.cs" Inherits="ShopPay.Admin.order" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        async function updateFavorite(flag, id_doc) {
            let response = await fetch('./../updateFavorite.ashx?check=' + flag + '&doc=' + id_doc);
            let text = await response.text(); // прочитать тело ответа как текст
        }
    </script>
    <div>
        Заказ
        <asp:Label ID="LabelNumOrder" runat="server"></asp:Label> 
        <asp:Label ID="LabelDateOrder" runat="server"></asp:Label> 
    <asp:GridView runat="server" ID="GridViewDocs" DataKeyNames="id_order" DataSourceID="SqlDataSourceDocs" AutoGenerateColumns="false" OnRowDataBound="GridViewDocs_RowDataBound">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Image ID="ImageCover" runat="server" ImageUrl='<%# "~/ImageHandler.ashx?tp=cover&fn="+Eval("cover") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Label ID="LabelNameDoc" runat="server" Text='<%# Bind("name_doc") %>'></asp:Label>
                    <br />
                    Краткое описание
                    <br />
                    <asp:Label ID="LabelDescDoc" runat="server" Text='<%# Bind("description") %>'></asp:Label>
                    <br />
                    Дата документа:
                    <asp:Label ID="LabelDateDoc" runat="server" Text='<%# Eval("date_doc") %>'></asp:Label>
                    <br />
                    Статус:
                    <asp:Label ID="LabelActual" runat="server" Text='<%# Eval("isActual").ToString()=="True"?"Актуален":"Неактуален" %>'></asp:Label>
                    <br />
                    Вид раздела:
                    <asp:Label ID="LabelSection" runat="server" Text='<%# Eval("section_name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Период доступности">
                <ItemTemplate>
                    <asp:Label ID="LabelPriceDoc" runat="server" Text='<%# Eval("period") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>

    </asp:GridView>
    </div>

    <div>
        Стоимость 
        <br />
        <asp:Label runat="server" ID="AllPrice" ></asp:Label> руб.
        <br />
        <asp:Button ID="PayOrder" runat="server" Text="Оплатить заказ" OnClick="PayOrder_Click"/>
        <asp:Label ID="PaidOrder" runat="server" Text ="Заказ опалачен"></asp:Label>
    </div>
    <asp:SqlDataSource ID="SqlDataSourceDocs" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
        SelectCommand="select o.id_order, oi.id_item, dd.id_doc,dd.id_section,dd.name_doc,dd.date_doc,dd.issue_doc
        ,dd.num_doc,isnull(dd.isActual,0) isActual,dd.description,dd.items
        ,isnull(dd.cover,'empty.jpg') cover,dd.doc_content, ds.section_name,
		iif(period_end is null,str(qty_time)+' мес.', 'до '+CONVERT(NVARCHAR(10),period_end)) period 
        from Docs_docs dd, 
		Docs_DocSections ds, Docs_Orders o, Docs_OrderItems oi     
        where  
		o.id_order = @id
        and oi.id_order=o.id_order
		and dd.id_doc= oi.id_doc
        and dd.id_section = ds.id_section
        ">
        <SelectParameters>
            <asp:Parameter Name="id" />
        </SelectParameters>

    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceTags" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
        SelectCommand="select id_tag, '#'+tag_name tag_name from Docs_tags"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceSections" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
        SelectCommand="select id_section, section_name from Docs_DocSections"></asp:SqlDataSource>

</asp:Content>
