<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="library_all_docs.aspx.cs" Inherits="ShopPay.Admin.library_all_docs" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="library_docs">
        <section id="header">
            <div class="container-fluid text-center">
                <h3>Библиотека документов</h3>
            </div>
        </section>
      

       <section id="grid_content">

         
            <div class="grid_filter_data" name="Filter">
                <h3>Расширенный фильтр</h3>
  
                <br />
                    <asp:GridView ID="GridViewFilterTags" runat="server" CssClass="table table-bordered table-hover" DataSourceID="SqlDataSourceTags" AutoGenerateColumns="false" ShowHeader="false">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:CheckBox ID="CheckTag" runat="server" />
                                    <asp:Label ID="LabelIdTag" runat="server" Text='<%#Eval("id_tag") %>' Visible="false"></asp:Label>
                                    <asp:Label ID="LabelTag" runat="server" Text='<%#Eval("tag_name") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
 <asp:Button ID="ButtonTagSearch" runat="server" OnClick="ButtonSearch_Click" Text="Поиск по тэгам" CssClass="btn btn-info"  />
               
            </div>

            <div class="grid_view_data">
                <div class="filter_data_ext" name="Filter">

                    <div class="input-group">
                        <h3>Фильтр по разделу</h3>
                            <asp:DropDownList ID="DropDownSections" runat="server" AppendDataBoundItems="true" DataSourceID="SqlDataSourceSections" DataTextField="section_name" DataValueField="id_section" CssClass="form-control" Width="245px">
                                <asp:ListItem Value="-1">Все разделы</asp:ListItem>
                            </asp:DropDownList>
                    </div>
                    <div class="input-group">
                        <h3>Поиск по маске</h3>
                        <asp:TextBox ID="DocMask" runat="server" CssClass="form-control"></asp:TextBox>
                        <div class="input-group-btn bottom ">
                            <h3> &nbsp</h3>
                        <asp:Button ID="ButtonSearch" runat="server" CssClass="btn btn-info" OnClick="ButtonSearch_Click" Text="Применить" />  
                        <asp:Button ID="ButtonFilterClear" runat="server" OnClick="ButtonFilterClear_Click" Text="Сбросить" CssClass="btn btn-danger"  /></div>
                    </div>
                </div>
                <div class="gw">
                    <asp:GridView runat="server" ID="GridViewDocs" CssClass="table table-bordered table-hover" DataKeyNames="id_doc" DataSourceID="SqlDataSourceDocs" AutoGenerateColumns="false" OnRowDataBound="GridViewDocs_RowDataBound">
                        <Columns>
                            <asp:TemplateField HeaderText="Обложка">
                                <ItemTemplate>
                                    <asp:Image ID="ImageCover" runat="server" ImageUrl='<%# "~/ImageHandler.ashx?tp=cover&fn="+Eval("cover") %>' Height="106" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Дата документа">
                                <ItemTemplate>
                                    <asp:Label ID="LabelDateDoc" runat="server" Text='<%# Eval("date_doc") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Вид раздела">
                                <ItemTemplate>
                                    <asp:Label ID="LabelSection" runat="server" Text='<%# Eval("section_name") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Наименование документа">
                                <ItemTemplate>
                                    <asp:Label ID="LabelNameDoc" runat="server" Text='<%# Bind("name_doc") %>'></asp:Label>
                                    <br />
                                    Краткое описание
                    <br />
                                    <asp:Label ID="LabelDescDoc" runat="server" Text='<%# Bind("description") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Актуальность">
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
                                    <asp:LinkButton ID="ButtonComand" runat="server" Text="Перейти в магазин" CssClass="btn btn-success" PostBackUrl="~/Docs/library_docs.aspx?filter=mine" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle BackColor="#729C3B" ForeColor="White" />
                    </asp:GridView>
                </div>
            </div>

            

        </section>
        
        <section id="data">
            <asp:SqlDataSource ID="SqlDataSourceDocs" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
                SelectCommand="select dd.id_doc,dd.id_section,dd.name_doc,dd.date_doc,dd.issue_doc,dd.num_doc,isnull(dd.isActual,0) isActual,dd.description,dd.items,isnull(dd.cover,'empty.jpg') cover,dd.doc_content, ds.section_name
        ,[dbo].[Docs_GetPrice](dd.id_doc,GETDATE()) doc_price        
        from Docs_docs dd, Docs_DocSections ds 
        where  dd.id_typeProduct=1 and
        dd.id_section=ds.id_section and
        (@mask=' ' or dd.name_doc like '%'+@mask+'%' or dd.description like '%'+@mask+'%')
        and (@section ='-1' or dd.id_section=@section)
        and (@tags=',' or exists (select 'x' from Docs_DocTags where Docs_DocTags.id_doc=dd.id_doc and charindex(','+CONVERT(nvarchar,Docs_DocTags.id_tag)+',',@tags)>0))">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DocMask" Name="mask" PropertyName="Text" DefaultValue=" " />
                    <asp:ControlParameter ControlID="DropDownSections" Name="section" PropertyName="SelectedValue" DefaultValue="-1" />
                    <asp:Parameter Name="tags" DefaultValue="," />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSourceTags" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
                SelectCommand="select id_tag, '#'+tag_name tag_name from Docs_tags"></asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSourceSections" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
                SelectCommand="select id_section, section_name from Docs_DocSections"></asp:SqlDataSource>

        </section>
        <div>
            <asp:Label ID="LabelError" runat="server"></asp:Label>

        </div>
    </div>
       
    
  

</asp:Content>

