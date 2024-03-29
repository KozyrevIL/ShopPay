﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="order.aspx.cs" Inherits="ShopPay.Admin.order" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        async function updateFavorite(flag, id_doc) {
            let response = await fetch('./../updateFavorite.ashx?check=' + flag + '&doc=' + id_doc);
            let text = await response.text(); // прочитать тело ответа как текст
        }
    </script>

    <div id="order" class="order">
        <section class="container_global grid">
            <section class="header" id="header">
                <div class="container-fluid text-center">
                    <h3>Заказ
                    <asp:Label ID="LabelNumOrder" runat="server"></asp:Label>
                        <asp:Label ID="LabelDateOrder" runat="server"></asp:Label></h3>
                </div>
            </section>
            <section class="container_data grid">

                <div class="item_gridview" id="grid_content">

                    <div class="grid_1" runat="server" id="orderDocs">
                        Документы
    <asp:GridView runat="server" ID="GridViewDocs" CssClass="table table-bordered table-hover" DataKeyNames="id_order" DataSourceID="SqlDataSourceDocs" AutoGenerateColumns="false" OnRowDataBound="GridViewDocs_RowDataBound">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Image ID="ImageCover" runat="server" ImageUrl='<%# "~/ImageHandler.ashx?tp=cover&fn="+Eval("cover") %>' Width="173" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Label ID="LabelNameDoc" runat="server" Text='<%# Bind("name_doc") %>'></asp:Label>
                    <br />
                    Краткое описание:
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
        <HeaderStyle BackColor="#729C3B" ForeColor="White" />
    </asp:GridView>
                    </div>
                    <div class="grid_2" runat="server" id="orderConsults">
                        Консультации
    <asp:GridView runat="server" ID="GridViewConsults" CssClass="table table-bordered table-hover" DataKeyNames="id_order" DataSourceID="SqlDataSourceConsults" AutoGenerateColumns="false" OnRowDataBound="GridViewDocs_RowDataBound">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Label ID="LabelNameDoc" runat="server" Text='<%# Bind("name_doc") %>'></asp:Label>
                    <br />
                    Обсуждаемые вопросы:
                    <br />
                    <asp:Label ID="LabelDescDoc" runat="server" Text='<%# Bind("description") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Количество">
                <ItemTemplate>
                    <asp:Label ID="qtyItem" runat="server" Text='<%# Eval("qty_time") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <HeaderStyle BackColor="#729C3B" ForeColor="White" />
    </asp:GridView>
                    </div>

                </div>
                <div class="item_price">
                    <div class="container_item_price">
                        <h3>ИТОГО:</h3>
                        <p>
                            <asp:Label ID="AllPrice" runat="server" CssClass="text_pay"></asp:Label>
                            руб</p>

                        <asp:Button ID="PayOrder" runat="server" Text="Оплатить заказ" CssClass="btn btn-default btn-block btn_pay" OnClick="PayOrder_Click" />
                        <asp:Label ID="PaidOrder" runat="server" Text="Заказ оплачен"></asp:Label>

                    </div>

                </div>
            </section>




        </section>



    </div>
    <div role="alert" id="StatusAlert" style="position: absolute; top: 0px; right: 0px;" runat="server">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>

        <asp:Label ID="LabelStatus" runat="server" Visible="true" EnableViewState="false"></asp:Label>
    </div>



    <asp:SqlDataSource ID="SqlDataSourceDocs" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
        SelectCommand="select o.id_order, oi.id_item, dd.id_doc,dd.id_section,dd.name_doc,dd.date_doc,dd.issue_doc
        ,dd.num_doc,isnull(dd.isActual,0) isActual,dd.description,dd.items
        ,isnull(dd.cover,'empty.jpg') cover,dd.doc_content, ds.section_name,
		iif(period_end is null,str(qty_time)+' мес.', 'до '+CONVERT(NVARCHAR(10),period_end)) period, oi.qty_time 
        from Docs_docs dd, 
		Docs_DocSections ds, Docs_Orders o, Docs_OrderItems oi     
        where  
		o.id_order = @id
        and dd.id_typeProduct = 1
        and oi.id_order=o.id_order
		and dd.id_doc= oi.id_doc
        and dd.id_section = ds.id_section
        ">
        <SelectParameters>
            <asp:Parameter Name="id" />
        </SelectParameters>

    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceConsults" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
        SelectCommand="select o.id_order, oi.id_item, dd.id_doc,dd.name_doc
        ,dd.description, oi.qty_time
        from Docs_docs dd, Docs_Orders o, Docs_OrderItems oi     
        where  
		o.id_order = @id
        and dd.id_typeProduct = 2
        and oi.id_order=o.id_order
		and dd.id_doc= oi.id_doc
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

