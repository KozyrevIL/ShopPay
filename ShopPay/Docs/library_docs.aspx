<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="library_docs.aspx.cs" Inherits="ShopPay.Admin.library_docs" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        async function updateFavorite(flag, id_doc) {
            let response = await fetch('./../updateFavorite.ashx?check='+flag+'&doc='+id_doc);
            let text = await response.text(); // прочитать тело ответа как текст
        }
    </script>
    <div>
        <asp:Label ID="LabelError" runat="server"></asp:Label>
        <br />
        Фильтр по разделу
                <br />
        <asp:DropDownList ID="DropDownSections" runat="server" AppendDataBoundItems="true" DataSourceID="SqlDataSourceSections" DataTextField="section_name" DataValueField="id_section">
            <asp:ListItem Value="-1">Все разделы</asp:ListItem>
        </asp:DropDownList>
        <asp:TextBox ID="DocMask" runat="server"></asp:TextBox>
        <asp:Button ID="ButtonSearch" runat="server" OnClick="ButtonSearch_Click" Text="Применить" />

        <br />
        Расширенный фильтр
        <br />

        <asp:GridView ID="GridViewFilterTags" runat="server" DataSourceID="SqlDataSourceTags" AutoGenerateColumns="false" ShowHeader="false">
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
        <asp:Button ID="ButtonTagSearch" runat="server" OnClick="ButtonSearch_Click" Text="Применить" />
        <asp:Button ID="ButtonFilterClear" runat="server" OnClick="ButtonFilterClear_Click" Text="Сбросить" />
        <br />
    </div>
    <asp:GridView runat="server" ID="GridViewDocs" DataKeyNames="id_doc" DataSourceID="SqlDataSourceDocs" AutoGenerateColumns="false" OnRowDataBound="GridViewDocs_RowDataBound">
        <Columns>
            <asp:TemplateField HeaderText="Обложка">
                <ItemTemplate>
                    <asp:Image ID="ImageCover" runat="server" ImageUrl='<%# "~/ImageHandler.ashx?tp=cover&fn="+Eval("cover") %>' />
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
            <asp:TemplateField HeaderText="Статус">
                <ItemTemplate>
                    <asp:Label ID="LabelStatus" runat="server" Text='<%# Eval("DocisAvailable").ToString()=="True"?"Оплачен":"Не доступен" %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Цена">
                <ItemTemplate>
                    <asp:Label ID="LabelPriceDoc" runat="server" Text='<%# Eval("doc_price") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Избранное">
                <ItemTemplate>
                    <asp:CheckBox ID="CheckFavorite" runat="server" Checked='<%# Eval("favorite") %>' OnClick='<%# "updateFavorite(this.checked,"+Eval("id_doc").ToString()+");" %>' ></asp:CheckBox>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Документ">
                <ItemTemplate>
                    <asp:HyperLink ID="DocImage" runat="server" NavigateUrl='<%# "~/ImageHandler.ashx?fn="+Eval("items") %>'>Образ документа</asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Действие">
                <ItemTemplate>
                    <asp:Button ID="ButtonComand" runat="server" CommandName='<%# Eval("DocisAvailable").ToString()=="False"?"pay":"archive" %>' Text='<%# Eval("DocisAvailable").ToString()=="False"?"Купить":"Убрать в архив" %>' CommandArgument='<%# Eval("id_doc").ToString() %>' OnCommand="ButtonComand_Command" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>

    </asp:GridView>

    <asp:SqlDataSource ID="SqlDataSourceDocs" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
        SelectCommand="select dd.id_doc,dd.id_section,dd.name_doc,dd.date_doc,dd.issue_doc,dd.num_doc,isnull(dd.isActual,0) isActual,dd.description,dd.items
        ,isnull(dd.cover,'empty.jpg') cover,dd.doc_content, ds.section_name
        ,[dbo].[Docs_DocIsAvailable](dd.id_doc,@customer) DocisAvailable
        ,[dbo].[Docs_GetPrice](dd.id_doc,GETDATE()) doc_price        
        ,isnull((select CONVERT(BIT,1) from Docs_Favorits df where df.id_doc=dd.id_doc and df.customer=@customer),CONVERT(BIT,0)) favorite
        from Docs_docs dd, Docs_DocSections ds 
        where  dd.id_section=ds.id_section and
        (@mask=' ' or dd.name_doc like '%'+@mask+'%' or dd.description like '%'+@mask+'%')
        and (@section ='-1' or dd.id_section=@section)
        and (@tags=',' or exists (select 'x' from Docs_DocTags where Docs_DocTags.id_doc=dd.id_doc and charindex(','+CONVERT(nvarchar,Docs_DocTags.id_tag)+',',@tags)>0))">
        <SelectParameters>
            <asp:Parameter Name="customer" />
            <asp:ControlParameter ControlID="DocMask" Name="mask" PropertyName="Text" DefaultValue=" " />
            <asp:ControlParameter ControlID="DropDownSections" Name="section" PropertyName="SelectedValue" DefaultValue="-1" />
            <asp:Parameter Name="tags" DefaultValue=","/>
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceTags" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
        SelectCommand="select id_tag, '#'+tag_name tag_name from Docs_tags"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceSections" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
        SelectCommand="select id_section, section_name from Docs_DocSections"></asp:SqlDataSource>

</asp:Content>

