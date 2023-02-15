<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="ViewListCustomers.aspx.cs" Inherits="ShopPay.Account.ViewListCustomers" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="admin_consult">
        <section id="header">
            <div class="container-fluid text-center">
                <h3>Администрирование. Список пользователей</h3>
            </div>
        </section>

        <section id="grid_content">

                <div class="item2">

                    <div class="grid_filter_data" name="Filter">
                        <%--Фильтр по Имени--%>
                        <div class=" input-group">
                            <asp:TextBox ID="FiltrMask" runat="server" CssClass="input-group-addon" Width="265"></asp:TextBox>
                            <asp:Button ID="ButtonSearch" runat="server" OnClick="ButtonSearch_Click" Text="Применить" CssClass="btn btn-info" />
                            <asp:Button ID="ButtonFilterClear" runat="server" OnClick="ButtonFilterClear_Click" Text="Сбросить" CssClass="btn btn-danger" />
                        </div>


                    </div>
                    </div>
                    <div class="grid_view_data">
                        <div class="gw">
                            <asp:GridView runat="server" ID="GridViewCustomers" DataKeyNames="customer" DataSourceID="SqlDataSourceCustomers" AutoGenerateColumns="false" CssClass="table table-secondary table-bordered table-hover table-striped" >
                                <Columns>

                                    <asp:TemplateField HeaderText="Login/EMail">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelEMail" runat="server" Text='<%# Eval("customer") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Обращение">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelAppealTo" runat="server" Text='<%# Eval("FIO") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:CheckBox ID="CheckisActual" runat="server" Checked='<%# Bind("isActual") %>' />
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Доп. информация">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelInfo" runat="server" Text='<%# Eval("info") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Телефон">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelPhone" runat="server" Text='<%# Eval("phone") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle BackColor="#729C3B" ForeColor="White" />
                                <AlternatingRowStyle CssClass="alter_row_style" />
                                <RowStyle CssClass="item_row_style" />
                                <EditRowStyle CssClass="danger" />
                            </asp:GridView>
                        </div>
                    </div>

        </section>

        <section id="data">

            <asp:SqlDataSource ID="SqlDataSourceCustomers" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
                SelectCommand="select customer, FIO, phone, Info from DOCS_customers where (@mask=' ' or customer like '%'+@mask+'%' or Info like '%'+@mask+'%' or phone like '%'+@mask+'%' or FIO like '%'+@mask+'%')"
                >
                <SelectParameters>
                    <asp:ControlParameter ControlID="FiltrMask" Name="mask" PropertyName="Text" DefaultValue=" " />
                </SelectParameters>
            </asp:SqlDataSource>

        </section>
        <asp:Label ID="LabelError" runat="server"></asp:Label>

    </div>
</asp:Content>

