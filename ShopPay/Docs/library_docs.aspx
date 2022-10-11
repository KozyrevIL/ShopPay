<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="library_docs.aspx.cs" Inherits="ShopPay.Admin.library_docs" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
                <asp:Label ID="LabelError" runat="server"></asp:Label>
                <br />
                Фильтр по разделу
                <br />
        <asp:DropDownList ID="DropDownSections" runat="server" AppendDataBoundItems="true" DataSourceID="SqlDataSourceSections" DataTextField="section_name" DataValueField="id_section">
            <asp:ListItem Value="-1">Все разделы</asp:ListItem>
        </asp:DropDownList>
                <asp:TextBox ID="DocMask" runat="server"></asp:TextBox>
        <asp:Button ID="ButtonSearch" runat="server" OnClick="ButtonSearch_Click" Text="Применить"/>

                <br />
        Расширенный фильтр
                <br />
        
                    <asp:GridView ID="GridViewTags" runat="server" DataSourceID="SqlDataSourceTags" AutoGenerateColumns="false" ShowHeader="false">
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
        <asp:Button ID="ButtonTagSearch" runat="server" OnClick="ButtonSearch_Click" Text="Применить"/>
        <br />
        </div>
    <asp:GridView runat="server" ID="GridViewDocs" DataKeyNames="id_doc" DataSourceID="SqlDataSourceDocs" AutoGenerateColumns="false" OnRowDataBound="GridViewDocs_RowDataBound">
        <Columns>
            <asp:TemplateField Visible="false">
                <ItemTemplate>
                    <asp:Label ID="LabelIDDoc" runat="server" Text='<%# Eval("id_doc") %>'></asp:Label>
                    <asp:Label ID="LabelItems" runat="server" Text='<%# Eval("items") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:HyperLink ID="DocImage" runat="server" NavigateUrl='<%# "~/ImageHandler.ashx?fn="+Eval("items") %>' >Образ документа</asp:HyperLink>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:FileUpload ID="FileScan" runat="server" />
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Label ID="LabelNameDoc" runat="server" Text='<%# Bind("name_doc") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="EditNameDoc" runat="server" Text='<%# Bind("name_doc") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Label ID="LabelNumDoc" runat="server" Text='<%# Bind("num_doc") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="EditNumDoc" runat="server" Text='<%# Bind("num_doc") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Label ID="LabelDateDoc" runat="server" Text='<%# Eval("date_doc","dd.MM.yyyy") %>' ></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="EditDateDoc" runat="server" Text='<%# Bind("date_doc") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Label ID="LabelIssueDoc" runat="server" Text='<%# Bind("issue_doc") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="EditIssueDoc" runat="server" Text='<%# Bind("issue_doc") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Label ID="LabelDescDoc" runat="server" Text='<%# Bind("description") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="EditDescDoc" runat="server" Text='<%# Bind("description") %>' TextMode="MultiLine"></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="DocIsAvailable" />
        </Columns>

    </asp:GridView>

    <asp:SqlDataSource ID="SqlDataSourceDocs" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
        SelectCommand="select dd.*, [dbo].[Docs_DocIsAvailable](id_doc,@customer) DocIsAvailable from Docs_docs dd">
        <SelectParameters>
            <asp:Parameter Name="customer" /> 
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceTags" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
        SelectCommand="select id_tag, '#'+tag_name tag_name from Docs_tags"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceSections" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
        SelectCommand="select id_section, section_name from Docs_DocSections"></asp:SqlDataSource>

</asp:Content>

