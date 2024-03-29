﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="cart.aspx.cs" Inherits="ShopPay.Admin.cart" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        async function updateFavorite(flag, id_doc) {
            let response = await fetch('./../updateFavorite.ashx?check=' + flag + '&doc=' + id_doc);
            let text = await response.text(); // прочитать тело ответа как текст
        }
        function minusFunc(elem) {
            var eQty = elem.parentElement.querySelector(".qtyItem");
            var qty = Number(eQty.innerText);
            qty = qty - 1;
            if (qty < 1) qty = 1;
            eQty.innerText = qty.toString();
        }
        function plusFunc(elem) {
            var eQty = elem.parentElement.querySelector(".qtyItem");
            var qty = Number(eQty.innerText);
            qty = qty + 1;
            eQty.innerText = qty.toString();
        }
    </script>
    <div class="cart">

        <section class="container_global grid">
            <section class="header" id="header">
                <div class="container-fluid text-center">
                    <h3>Корзина</h3>
                </div>
            </section>

            <section class="container_data grid">
                <div class="item_gridview" id="grid_content">
                    <div class="grid_1" id="divCartDocs" runat="server">
                        <h4>Библиотека документов</h4>

                        <asp:GridView runat="server" ID="GridViewDocs" Width="100%" CssClass="table table-secondary table-bordered table-hover table-striped gridview_global"  DataKeyNames="id" DataSourceID="SqlDataSourceDocs" AutoGenerateColumns="false" OnRowDataBound="GridViewDocs_RowDataBound">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Image ID="ImageCover" runat="server" ImageUrl='<%# "~/ImageHandler.ashx?tp=cover&fn="+Eval("cover") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="id_cart" runat="server" Text='<%# Eval("id") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <h4><b>Наименование:</b>
                                        </h4>
                                        <asp:Label ID="LabelNameDoc" runat="server" Text='<%# Bind("name_doc") %>'></asp:Label>
                                        <p>
                                            <h4><b>Краткое описание:</b></h4>

                                            <asp:Label ID="LabelDescDoc" runat="server" Text='<%# Bind("description") %>'></asp:Label>
                                        </p>
                                        <b>Дата документа:</b>
                                        <asp:Label ID="LabelDateDoc" runat="server" Text='<%# Eval("date_doc") %>'></asp:Label>
                                        <p>
                                            <b>Статус:</b>

                                            <asp:Label ID="LabelActual" runat="server" Text='<%# Eval("isActual").ToString()=="True"?"Актуален":"Неактуален" %>'></asp:Label>
                                        </p>
                  
                                        
                                        <b>Вид раздела:</b>

                                        <asp:Label ID="LabelSection" runat="server" Text='<%# Eval("section_name") %>'></asp:Label>

                                    </ItemTemplate>
                                    <%--<ItemStyle Width="100%" />--%>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Цена">
                                    <ItemTemplate>
                                       
                                                <asp:Label ID="LabelPriceDoc" runat="server" Text='<%# Eval("doc_price") %>'></asp:Label>
                                                руб.
                                       
                                    </ItemTemplate>
                                    <ItemStyle Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Количество">
                                    <ItemTemplate>
                                        <asp:Button ID="minusMonth" runat="server" CssClass="btn btn-info" Text="-" OnClick="minusMonth_Click" />
                                        <asp:Label ID="qtyItem" runat="server" Text='<%# Eval("qty_time") %>'></asp:Label>
                                        <asp:Button ID="plusMonth" runat="server" CssClass="btn btn-info" Text="+" OnClick="plusMonth_Click" />
                                    </ItemTemplate>
                                    <ItemStyle Width="120px" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Действие">
                                    <ItemTemplate>
                                        <asp:Button ID="ButtonComand1" runat="server" CommandName="Delete" Text="Убрать из корзины" CssClass="btn btn-danger" OnClientClick="return confirm('Удалить документ из корзины?');" />
                                        <asp:Button ID="ButtonComand2" runat="server" CommandName="delCart" Text="Отложить" CssClass="btn btn-warning" OnCommand="ButtonComand_Command" />
                                    </ItemTemplate>
                                    <ItemStyle Width="271px" />
                                </asp:TemplateField>

                            </Columns>
                            <HeaderStyle CssClass="gridview_header" />
                        </asp:GridView>
                    </div>
                    <div class="grid_2" id="divCartConsults" runat="server">
                        <h4>Консультации</h4>

                        <asp:GridView runat="server" ID="GridViewConsult" Width="100%" CssClass="table table-secondary table-bordered table-hover table-striped gridview_global" DataKeyNames="id" DataSourceID="SqlDataSourceConsults" AutoGenerateColumns="false">
                            <Columns>
                                <asp:TemplateField Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="id_cart" runat="server" Text='<%# Eval("id") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                         <h4><b>Наименование:</b>
                                        </h4>
                                        <asp:Label ID="LabelNameDoc" runat="server" Text='<%# Bind("name_doc") %>'></asp:Label>
                                        <p><h4><b>Краткое описание:</b></h4>
                                            <asp:Label ID="LabelDescDoc" runat="server" Text='<%# Bind("description") %>'></asp:Label>

                                        </p>
                                      
                                        
                   
                                        
                                    </ItemTemplate>
                                  
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Цена">
                                    <ItemTemplate>
                                                <asp:Label ID="LabelPriceDoc" runat="server" Text='<%# Eval("doc_price") %>'></asp:Label>
                                                руб.
                                    </ItemTemplate>
                                    <ItemStyle Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Количество">
                                    <ItemTemplate>
                                        <asp:Button ID="minusMonth" runat="server" CssClass="btn btn-info" Text="-" OnClick="minusMonth_Click" />
                                        <asp:Label ID="qtyItem" runat="server" Text='<%# Eval("qty_time") %>'></asp:Label>
                                        <asp:Button ID="plusMonth" runat="server" CssClass="btn btn-info" Text="+" OnClick="plusMonth_Click" />
                                    </ItemTemplate>
                                    <ItemStyle Width="120px" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Действие">
                                    <ItemTemplate>
                                        <asp:Button ID="ButtonComand1" runat="server" CommandName="Delete" Text="Убрать из корзины" CssClass="btn btn-danger" OnClientClick="return confirm('Удалить заказ консультации из корзины?');" />
                                    </ItemTemplate>

                                </asp:TemplateField>


                            </Columns>
                            <HeaderStyle  CssClass="gridview_header"/>
                        </asp:GridView>
                    </div>
                </div>
                <div class="item_price">
                    <div class="container_item_price">
                        <h3>ИТОГО:</h3>
                        <p><asp:Label ID="AllPrice" runat="server" CssClass="text_pay"></asp:Label> руб/мес</p>
                        

                        <div runat="server" id="selectCustomer">
                            <h3>Заказ для клиента:</h3>

                            <asp:DropDownList ID="UserList" runat="server" CssClass="form-control" Width="300px" DataTextField="UserName" DataValueField="UserName"></asp:DropDownList>
                        </div>
                        <asp:Button ID="CreateOrder" CssClass="btn btn-default btn-block btn_pay" runat="server" Text="Оформить заказ" OnClick="CreateOrder_Click" />
                    </div>

                </div>
            </section>

            
        </section>


       
      
        

       <%-- <div>
            <h4><b>Стоимость</b> </h4>

            <%--        <h5>ПЕРИОД:</h5>

        <asp:Button ID="minusMonth" runat="server" CssClass="btn btn-info" Text="-" OnClick="minusMonth_Click" /><asp:Label ID="qtyMonth" runat="server"></asp:Label>
        <asp:Button ID="plusMonth" runat="server" CssClass="btn btn-info" Text="+" OnClick="plusMonth_Click" />--%>

            <%--<h4><b>ИТОГО:</b></h4>
            <div style="font-size: 24px">
                <asp:Label runat="server" ID="AllPrice"></asp:Label>
                руб.
            </div>--%>
           <%-- <div runat="server" id="selectCustomer">
                <asp:Label runat="server" ID="labelCustomer" Text="Заказ для клиента: "></asp:Label>
                <asp:DropDownList ID="UserList" runat="server" CssClass="form-control" Width="300px" DataTextField="UserName" DataValueField="UserName"></asp:DropDownList>
            </div>--%>
            <%--<asp:Button ID="CreateOrder" CssClass="btn btn-success" runat="server" Text="Оформить заказ" OnClick="CreateOrder_Click" />--
        </div>--%>
    </div>

  
    <asp:SqlDataSource ID="SqlDataSourceDocs" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
        SelectCommand="select dc.id, dd.id_doc,dd.id_section,dd.name_doc,dd.date_doc,dd.issue_doc,dc.qty_time
        ,dd.num_doc,isnull(dd.isActual,0) isActual,dd.description,dd.items
        ,isnull(dd.cover,'empty.jpg') cover,dd.doc_content, ds.section_name
        ,[dbo].[Docs_DocIsAvailable](dd.id_doc,@customer) DocisAvailable
        ,[dbo].[Docs_GetPrice](dd.id_doc,GETDATE()) doc_price        
        from Docs_docs dd, Docs_DocSections ds, Docs_cart dc  
        where  
        dd.id_typeProduct=1
        and dd.id_section=ds.id_section
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

    <asp:SqlDataSource ID="SqlDataSourceConsults" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
        SelectCommand="select dc.id,dd.id_doc,dd.name_doc,dc.qty_time
        ,isnull(dd.isActual,0) isActual,dd.description
        ,[dbo].[Docs_GetPrice](dd.id_doc,GETDATE()) doc_price        
        from Docs_docs dd, Docs_cart dc  
        where  
        dd.id_typeProduct=2
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

