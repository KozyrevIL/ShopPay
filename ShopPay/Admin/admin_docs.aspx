<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="admin_docs.aspx.cs" Inherits="ShopPay.Admin.admin_docs" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
<%--        <asp:UpdatePanel runat="server">
            <ContentTemplate>--%>
                <asp:Label ID="LabelError" runat="server"></asp:Label>
                <br />
                Добавить документ
                <br />
                <asp:Label runat="server">Наименование документа</asp:Label><asp:TextBox ID="DocName" runat="server"></asp:TextBox>
                <br />
                <asp:Label runat="server">Номер документа</asp:Label><asp:TextBox ID="DocNum" runat="server"></asp:TextBox>
                <br />
                <asp:Label runat="server">Дата документа</asp:Label><asp:TextBox ID="DocDate" runat="server"></asp:TextBox>
                <br />
                <asp:Label runat="server">Документ выдан</asp:Label><asp:TextBox ID="DocIssue" runat="server"></asp:TextBox>
                <br />
                <asp:Label runat="server">Описание документа</asp:Label><asp:TextBox ID="DocDescription" runat="server" TextMode="MultiLine"></asp:TextBox>
                <br />
                <asp:Label runat="server">Образ документа</asp:Label>
                <asp:FileUpload ID="DocScan" runat="server"></asp:FileUpload>
                <br />
                <asp:Label runat="server">Описание тэгов</asp:Label>
                <br />
                <div style="height: 150px; overflow: scroll">
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
                    Новый тэг:
                    <br />
                    <asp:TextBox ID="TagName" runat="server"></asp:TextBox><br />
                    <asp:TextBox ID="TagNote" runat="server" TextMode="MultiLine"></asp:TextBox>
                    <asp:Button ID="BtnAddTag" runat="server" OnClick="BtnAddTag_Click" Text="Добавить тэг" />
                </div>
                <asp:Button ID="AddDoc" runat="server" Text="Добавить документ" OnClick="AddDoc_Click" />
<%--            </ContentTemplate>
        </asp:UpdatePanel>--%>
        <br />
    </div>

    <asp:GridView runat="server" ID="GridViewDocs" DataKeyNames="id_doc" DataSourceID="SqlDataSourceDocs" AutoGenerateColumns="false" OnRowDataBound="GridViewDocs_RowDataBound" OnRowUpdating="GridViewDocs_RowUpdating">
        <Columns>

            <asp:CommandField ButtonType="Button" ShowDeleteButton="True" ShowEditButton="True" />

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
            <asp:TemplateField HeaderText="Тэги">
                <ItemTemplate>
                    <asp:TextBox ID="TagsList" runat="server" Text='<%# Eval("tags") %>' TextMode="MultiLine" ReadOnly="true" > </asp:TextBox>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:GridView ID="GridViewEditTags" runat="server" AutoGenerateColumns="false" ShowHeader="false">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:CheckBox ID="CheckEditTag" runat="server" Checked='<%# Eval("chkTag").ToString()=="1" %>' />
                                    <asp:Label ID="LabelEditIdTag" runat="server" Text='<%#Eval("id_tag") %>' Visible="false"></asp:Label>
                                    <asp:Label ID="LabelEditTag" runat="server" Text='<%#Eval("tag_name") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    
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
        </Columns>

    </asp:GridView>

    <asp:SqlDataSource ID="SqlDataSourceDocs" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
        SelectCommand="select dd.*, (SELECT STRING_AGG(t.tag_name,CHAR(10)) FROM Docs_DocTags dt, docs_tags t where dt.id_doc=dd.id_doc and t.id_tag=dt.id_tag) tags from Docs_docs dd"
        UpdateCommand="update Docs_docs set name_doc=@name_doc where id_doc=@id_doc"
        DeleteCommand="delete from Docs_docs where id_doc=@id_doc">
        <UpdateParameters>
            <asp:Parameter Name="@name_doc" />
            <asp:Parameter Name="@id_doc" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="@id_doc" />
        </DeleteParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceTags" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
        SelectCommand="select id_tag, '#'+tag_name tag_name from Docs_tags"></asp:SqlDataSource>

</asp:Content>

