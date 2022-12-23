<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="admin_consult.aspx.cs" Inherits="ShopPay.Admin.admin_consult" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="admin_doc">
        <section id="header">
            <div class="container-fluid text-center">
                <h3>Администрирование. Справочник консультаций</h3>
            </div>
        </section>

        <section id="grid_content">

            <div class="grid_input_data" name="InsertDoc">
                <div class="item1">

                    <div>
                        <asp:Label runat="server">Название консультации</asp:Label><asp:TextBox ID="DocName" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div>
                        <asp:Label runat="server">Краткое описание возможных вопросов для рассмотрения</asp:Label><asp:TextBox ID="DocDescription" runat="server" TextMode="MultiLine" CssClass="form-control" Height="108px"></asp:TextBox>
                    </div>
                    <div>
                        <asp:CheckBox ID="CheckActual" runat="server" Text="Консультация оказывается" Checked="true" />
                    </div>
                    <div>
                        <asp:Label runat="server">Цена за 1 консультацию, руб.</asp:Label><asp:TextBox ID="DocPrice" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div>
                        <asp:Button ID="AddDoc" runat="server" Text="Добавить консультацию" CssClass="btn btn-success" OnClick="AddDoc_Click" />
                    </div>

                </div>
                <div class="item2">

                    <div class="grid_filter_data" name="Filter">
                        <%--Фильтр по разделу--%>
                        <div class=" input-group">
                            <asp:TextBox ID="DocMask" runat="server" CssClass="input-group-addon" Width="265"></asp:TextBox>
                            <asp:Button ID="ButtonSearch" runat="server" OnClick="ButtonSearch_Click" Text="Применить" CssClass="btn btn-info" />
                            <asp:Button ID="ButtonFilterClear" runat="server" OnClick="ButtonFilterClear_Click" Text="Сбросить" CssClass="btn btn-danger" />
                        </div>


                    </div>

                    <div class="grid_view_data">
                        <div class="gw">
                            <asp:GridView runat="server" ID="GridViewDocs" DataKeyNames="id_doc" DataSourceID="SqlDataSourceDocs" AutoGenerateColumns="false" CssClass="table table-secondary table-bordered table-hover table-striped" OnRowDataBound="GridViewDocs_RowDataBound" OnRowUpdating="GridViewDocs_RowUpdating">
                                <Columns>

                                    <asp:TemplateField ShowHeader="True" HeaderText="Действие">
                                        <ItemTemplate>
                                            <div class="btn-group">
                                                <asp:LinkButton ID="LinkButtonEdit" runat="server" ToolTip="Редактировать" CommandName="Edit" CausesValidation="false" CssClass="btn btn-success">
                                    <i class="glyphicon glyphicon-pencil"></i>
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="LinkButtonDelete" runat="server" OnClientClick="return confirm('Удалить запись?');" ToolTip="Удалить" CommandName="Delete" CausesValidation="false" CssClass="btn  btn-danger">
                                    <i class="glyphicon glyphicon-trash"></i>
                                                </asp:LinkButton>
                                            </div>

                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <div class="btn-group">
                                                <asp:LinkButton ID="LinkButtonUpdate" runat="server" ToolTip="Обновить" CommandName="Update" CausesValidation="false" CssClass="btn btn-success">
                                    <i class="glyphicon glyphicon-ok"></i>
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="LinkButtonCancel" runat="server" ToolTip="Отменить" CommandName="Cancel" CausesValidation="false" CssClass="btn btn-success">
                                    <i class="glyphicon glyphicon-remove"></i>
                                                </asp:LinkButton>
                                            </div>
                                        </EditItemTemplate>
                                        <ItemStyle Width="100px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelIDDoc" runat="server" Text='<%# Eval("id_doc") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Актуальность">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelActual" runat="server" Text='<%# Eval("isActual").ToString()=="True"?"Актуален":"Неактуален" %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:CheckBox ID="CheckisActual" runat="server" Checked='<%# Bind("isActual") %>' />
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Название">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelNameDoc" runat="server" Text='<%# Bind("name_doc") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="EditNameDoc" runat="server" Text='<%# Bind("name_doc") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Краткое описание рассматриваемых вопросов">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelDescDoc" runat="server" Text='<%# Bind("description") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="EditDescDoc" runat="server" Text='<%# Bind("description") %>' TextMode="MultiLine"></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Цена">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelPriceDoc" runat="server" Text='<%# Bind("doc_price") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="EditPriceDoc" runat="server" Text='<%# Bind("doc_price") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle BackColor="#729C3B" ForeColor="White" />
                                <AlternatingRowStyle CssClass="alter_row_style" />
                                <RowStyle CssClass="item_row_style" />
                                <EditRowStyle CssClass="danger" />
                            </asp:GridView>
                        </div>
                    </div>

                </div>
            </div>
        </section>

        <section id="data">

            <asp:SqlDataSource ID="SqlDataSourceDocs" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
                SelectCommand="select dd.id_doc,dd.name_doc,isnull(dd.isActual,0) isActual,dd.description,[dbo].[Docs_GetPrice](dd.id_doc,GETDATE()) doc_price from Docs_docs dd where dd.id_typeProduct=2 and (@mask=' ' or dd.name_doc like '%'+@mask+'%' or dd.description like '%'+@mask+'%')"
                UpdateCommand="update Docs_docs set name_doc=@name_doc where id_doc=@id_doc"
                DeleteCommand="delete from Docs_docs where id_doc=@id_doc">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DocMask" Name="mask" PropertyName="Text" DefaultValue=" " />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="@name_doc" />
                    <asp:Parameter Name="@id_doc" />
                </UpdateParameters>
                <DeleteParameters>
                    <asp:Parameter Name="@id_doc" />
                </DeleteParameters>
            </asp:SqlDataSource>

        </section>
        <asp:Label ID="LabelError" runat="server"></asp:Label>

    </div>
</asp:Content>

