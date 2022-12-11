<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="cart.aspx.cs" Inherits="ShopPay.Admin.cart" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        async function updateFavorite(flag, id_doc) {
            let response = await fetch('./../updateFavorite.ashx?check=' + flag + '&doc=' + id_doc);
            let text = await response.text(); // прочитать тело ответа как текст
        }
    </script>
    <div class="cart">
        <section id="header">
            <div class="container-fluid text-center">
                <h3>Корзина</h3>
            </div>
        </section>
        <section id="grid_content">
            <asp:GridView runat="server" ID="GridViewDocs" DataKeyNames="id" DataSourceID="SqlDataSourceDocs" AutoGenerateColumns="false" OnRowDataBound="GridViewDocs_RowDataBound">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <div  style="padding:20px">
                                <asp:Image ID="ImageCover" runat="server" Height="200px" ImageUrl='<%# "~/ImageHandler.ashx?tp=cover&fn="+Eval("cover") %>' />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <div style="padding: 20px">
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
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Цена">
                        <ItemTemplate>
                            <div style="padding: 20px">
                                <div style="font-size:24px">
                                <asp:Label ID="LabelPriceDoc" runat="server" Text='<%# Eval("doc_price") %>'></asp:Label> руб.</div>
                                <br />
                                <asp:Button ID="ButtonComand1" runat="server" CommandName="Delete" Text="Убрать из корзины" CssClass="btn btn-danger" OnClientClick="return confirm('Удалить документ из корзины?');" />
                                <asp:Button ID="ButtonComand2" runat="server" CommandName="delCart" Text="Отложить" CssClass="btn btn-warning" OnCommand="ButtonComand_Command" />
                            </div>
                        </ItemTemplate>
                        
                    </asp:TemplateField>
                    

                </Columns>
                <HeaderStyle BackColor="#729C3B" ForeColor="White" />
            </asp:GridView>
        </section>


    
    </div>

    <div>
        <h4><b>Стоимость</b> </h4>
        
        <h5>ПЕРИОД:</h5>
       
        <asp:Button ID="minusMonth" runat="server" CssClass="btn btn-info" Text="-" OnClick="minusMonth_Click"/><asp:Label ID="qtyMonth" runat="server"></asp:Label> мес. <asp:Button ID="plusMonth" runat="server" CssClass="btn btn-info" Text="+" OnClick="plusMonth_Click"/>
       
       <h4> <b>ИТОГО:</b></h4>
        <div style="font-size:24px">
        <asp:Label runat="server" ID="AllPrice" ></asp:Label> руб.</div>
        
        <asp:Button ID="CreateOrder" CssClass="btn btn-success"  runat="server" Text="Оформить заказ" OnClick="CreateOrder_Click"/>
    </div>
    <asp:SqlDataSource ID="SqlDataSourceDocs" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
        SelectCommand="select dc.id, dd.id_doc,dd.id_section,dd.name_doc,dd.date_doc,dd.issue_doc
        ,dd.num_doc,isnull(dd.isActual,0) isActual,dd.description,dd.items
        ,isnull(dd.cover,'empty.jpg') cover,dd.doc_content, ds.section_name
        ,[dbo].[Docs_DocIsAvailable](dd.id_doc,@customer) DocisAvailable
        ,[dbo].[Docs_GetPrice](dd.id_doc,GETDATE()) doc_price        
        from Docs_docs dd, Docs_DocSections ds, Docs_cart dc  
        where  dd.id_section=ds.id_section
        and dc.id_doc=dd.id_doc
        and dc.customer=@customer
        "
        DeleteCommand="delete from Docs_Cart where id=@id">
        <SelectParameters>
            <asp:Parameter Name="customer" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="id" />
        </DeleteParameters>

    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceTags" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
        SelectCommand="select id_tag, '#'+tag_name tag_name from Docs_tags"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceSections" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
        SelectCommand="select id_section, section_name from Docs_DocSections"></asp:SqlDataSource>

</asp:Content>

