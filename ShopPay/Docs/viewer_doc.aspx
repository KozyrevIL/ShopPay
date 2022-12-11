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
        <section id="header">
            <div class="container-fluid text-center">
                <h3>Заказ</h3>
            </div>
        </section>
        <section id="grid_content">

            <div class="grid_view_img">
                <asp:Image ID="ImageCover" runat="server" ImageUrl="" />
            </div>
            <div class="grid_view_data">
                <h2>
                    <asp:Label ID="NameDoc" runat="server"></asp:Label>
                </h2>
                <h3>
                    <asp:Label ID="PriceDoc" runat="server"></asp:Label>
                    руб./мес.</h3>

                Дата документа:
                <asp:Label ID="DateDoc" runat="server"></asp:Label>
                <br />
                Статус:
                <asp:Label ID="ActualDoc" runat="server"></asp:Label>
                <br />
                <h2>Содержание документа:
                </h2>
                <br />
                <asp:Label ID="ContentDoc" runat="server"></asp:Label>

                <asp:Label ID="DescrDoc" runat="server" class="card-text"></asp:Label>
              
            </div>
            <div class="grid_view_btn">
                <asp:Button ID="ButtonFavortite" runat="server" CssClass="btn btn-info" Text="В избранное" />
                <asp:Button ID="ButtonCart" runat="server" Text="В корзину" CssClass="btn btn-success" />
            </div>


        </section>
    </div>
       
       
</asp:Content>

