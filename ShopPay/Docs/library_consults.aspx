<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="library_consults.aspx.cs" Inherits="ShopPay.Admin.library_consults" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        async function updateFavorite(flag, id_doc) {
            let response = await fetch('./../updateFavorite.ashx?check='+flag+'&doc='+id_doc);
            let text = await response.text(); // прочитать тело ответа как текст
        }
    </script>


    <div class="library_consult">
        <section id="header">
            <div class="container-fluid text-center">
                <h3>Консультации</h3>
            </div>
        </section>
      

       <section id="grid_content">

         
            <div class="grid_view_data">
                <div class="grid_filter_data" name="Filter">

                    <div class="input-group">
                        <h3>Поиск по маске</h3>
                        <asp:TextBox ID="DocMask" runat="server" CssClass="form-control"></asp:TextBox>
                        <div class="input-group-btn bottom ">
                            <h3> &nbsp</h3>
                        <asp:Button ID="ButtonSearch" runat="server" CssClass="btn btn-success" OnClick="ButtonSearch_Click" Text="Применить" />  
                        <asp:Button ID="ButtonFilterClear" runat="server" OnClick="ButtonFilterClear_Click" Text="Сбросить" CssClass="btn btn-danger"  /></div>
                    </div>
                </div>
                <div class="gw">
                    <asp:GridView runat="server" ID="GridViewDocs" CssClass="table table-bordered table-hover" DataKeyNames="id_doc" DataSourceID="SqlDataSourceDocs" AutoGenerateColumns="false" OnRowDataBound="GridViewDocs_RowDataBound">
                        <Columns>
                            <asp:TemplateField HeaderText="Наименование консультации">
                                <ItemTemplate>
                                    <asp:Label ID="LabelNameDoc" runat="server" Text='<%# Bind("name_doc") %>'></asp:Label>
                                    <br />
                                    Краткое описание вопросов консультации
                    <br />
                                    <asp:Label ID="LabelDescDoc" runat="server" Text='<%# Bind("description") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Актуальность" Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="LabelActual" runat="server" Text='<%# Eval("isActual").ToString()=="True"?"Актуален":"Неактуален" %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Цена">
                                <ItemTemplate>
                                    <asp:Label ID="LabelPriceDoc" runat="server" Text='<%# Eval("doc_price") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Действие">
                                <ItemTemplate>
                                    <asp:Button ID="ButtonComand" runat="server" CssClass="btn btn-success" CommandName='pay' Text='Заказать' CommandArgument='<%# Eval("id_doc").ToString() %>' OnCommand="ButtonComand_Command" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle BackColor="#729C3B" ForeColor="White" />
                    </asp:GridView>
                </div>
            </div>

            <div>
                <asp:Label ID="LabelError" runat="server"></asp:Label>

            </div>

        </section>

        <section id="data">
            <asp:SqlDataSource ID="SqlDataSourceDocs" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
                SelectCommand="select dd.id_doc,dd.name_doc,isnull(dd.isActual,0) isActual,dd.description,[dbo].[Docs_GetPrice](dd.id_doc,GETDATE()) doc_price from Docs_docs dd where dd.deleted is null and dd.id_typeProduct=2 and isActual=1 and (@mask=' ' or dd.name_doc like '%'+@mask+'%' or dd.description like '%'+@mask+'%')"
                >
                <SelectParameters>
                    <asp:ControlParameter ControlID="DocMask" Name="mask" PropertyName="Text" DefaultValue=" " />
                </SelectParameters>
            </asp:SqlDataSource>

        </section>
    </div>
       
    
  

</asp:Content>

