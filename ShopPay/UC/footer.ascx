<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="footer.ascx.cs" Inherits="ShopPay.UC.footer" %>

<footer>
    <div class="footer_content">
        <div class="footer_menu">
            <div class="menu_text">
                <ul>
                    <li><a runat="server" href="~/Docs/library_docs.aspx">Все Документы</a></li>
                    <li><a runat="server" href="~/Default.aspx">Мои документы</a></li>
                    <li><a runat="server" href="~/Docs/library_consults.aspx">Консультации</a></li>
                    <li><a runat="server" href="~/Docs/listOrders.aspx">Заказы</a></li>
                    <li><a runat="server" href="./../desc.aspx">Контакты</a></li>

                </ul>
            </div>

        </div>
        <div class="footer_politics">
            <h2>Центр охраны труда «РОСТ оставляет за собой право вносить изменения в информацию, размещенную данном на сайте.
                            <br />
                Информация, размещенная на сайте не является публичной офертой, определяемой положениями Статьи 437 ГК РФ.
            </h2>

        </div>
        <div class="footer_copyright">
            © 2022–<%: DateTime.Now.Year %>  Все права защищены. Создание и продвижение сайтов: stiv.simil@mail.ru
               
        </div>
    </div>
</footer>
