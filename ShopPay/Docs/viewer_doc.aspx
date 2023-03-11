<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="viewer_doc.aspx.cs" Inherits="ShopPay.Admin.viewer_doc" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        async function updateFavorite(flag, id_doc) {
            let response = await fetch('./../updateFavorite.ashx?check=' + flag + '&doc=' + id_doc);
            let text = await response.text(); // прочитать тело ответа как текст
            alert(text);
        }

    </script>
    <div class="viewer_doc">

        <section class="container_global grid">
            <section class="header">
                <h2><asp:Label ID="HeadLabel" runat="server" Text="Документ"></asp:Label></h2>
            </section>
            <section class="container_data grid">
                <div class="item_img">
                    <asp:Image ID="ImageCover" runat="server" ImageUrl=""  />
                </div>
                <div class="item_text">

                    <h3><b>Наименование:</b>
                    </h3>
                    <p><asp:Label ID="NameDoc" runat="server"></asp:Label></p>
                   
                    <p>
                        <asp:Label ID="LabelDataDoc" runat="server"><b>Дата документа:</b></asp:Label>
                        <asp:Label ID="DateDoc" runat="server"></asp:Label>
                    </p>
                    
                    <b>Статус:</b>
                    <asp:Label ID="ActualDoc" runat="server"></asp:Label>
                   
                    <div class="item_text_2">
                        <h3><b>Описание:</b>
                        </h3>
                        <p>
                            <asp:Label ID="ContentDoc" runat="server"></asp:Label>
                            <asp:Label ID="DescrDoc" runat="server" class="card-text"></asp:Label>
                        </p>
                    </div>
                   
                </div>
                <div class="item_price grid">
                    <div class="container_item_price">
                        <h3>ИТОГО:</h3>
                        <p><asp:Label ID="PriceDoc" runat="server" CssClass="text_pay"></asp:Label> руб/мес</p>
                        
                        <asp:Button ID="ButtonCart" runat="server" Text="В корзину" CssClass="btn btn-default btn-block btn_pay" />
                        <asp:Button ID="ButtonFavortite" runat="server" CssClass="btn btn-default btn-block btn_pay" Text="В избранное" />
                    </div>
                   
                </div>
            </section>
        </section>
      


        <%--<section id="header" class="header">
            <div class="container-fluid text-center">
                <h3><asp:Label ID="HeadLabel" runat="server" Text="Документ"></asp:Label></h3>
            </div>
        </section>
        <section id="grid_content">
            <div runat="server" id="divImage" class="grid_view_img" style="width: 173px">
                <asp:Image ID="ImageCover" runat="server" ImageUrl="" Width="173" />
            </div>
            <div class="grid_view_data">
                <h3>Наименование документа:
                </h3>
                <br />
                <asp:Label ID="NameDoc" runat="server"></asp:Label>
                <br />
                <br />
                <b>Цена:</b>
                <asp:Label ID="PriceDoc" runat="server"></asp:Label>руб./мес.<br />
                <asp:Label ID="LabelDataDoc" runat="server"><b>Дата документа:</b></asp:Label>
                <asp:Label ID="DateDoc" runat="server"></asp:Label>
                <br />
                <b>Статус:</b>
                <asp:Label ID="ActualDoc" runat="server"></asp:Label>
                <br />
                <br />
                <br />
                <h3>Содержание документа:
                </h3>
                <br />
                <h4>
                    <asp:Label ID="ContentDoc" runat="server"></asp:Label>
                    <asp:Label ID="DescrDoc" runat="server" class="card-text"></asp:Label>
                </h4>
            </div>
            <div class="grid_view_btn">
                <asp:Button ID="ButtonFavortite" runat="server" CssClass="btn btn-info" Text="В избранное" />
                <asp:Button ID="ButtonCart" runat="server" Text="В корзину" CssClass="btn btn-success" />
            </div>
        </section>--%>
    </div>
       
       
</asp:Content>

