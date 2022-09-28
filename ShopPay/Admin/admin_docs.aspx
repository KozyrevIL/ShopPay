<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="admin_docs.aspx.cs" Inherits="ShopPay.Admin.admin_docs" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div>
    Добавить документ
    <asp:Label runat="server">Наименование документа</asp:Label><asp:TextBox ID="DocName" runat="server"></asp:TextBox>
    <br />
    <asp:Label runat="server">Номер документа</asp:Label><asp:TextBox ID="DocNum" runat="server"></asp:TextBox>
    <br />
    <asp:Label runat="server">Дата документа</asp:Label><asp:TextBox ID="DocDate" runat="server"></asp:TextBox>
    <br />
    <asp:Label runat="server">Документ выдан</asp:Label><asp:TextBox ID="DocIssue" runat="server"></asp:TextBox>
    <br />
    <asp:Label runat="server">Образ документа</asp:Label><asp:FileUpload ID="DocScan" runat="server"></asp:FileUpload>
    <br />
    <asp:Label runat="server">Описание тэгов</asp:Label>
    <br />
    <asp:GridView ID="GridViewTags" runat="server" DataSourceID="SqlDataSourceTags" AutoGenerateColumns="false">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:CheckBox ID="CheckTag" runat="server" /> <asp:Label ID="LabelTag" runat="server" Text='<%#Eval("tag_name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:Button ID="AddDoc" runat="server" Text="Добавить" OnClick="AddDoc_Click"/>
    <br />
</div>

        <asp:GridView runat="server" ID="GridViewDocs" DataKeyNames="id_tag" DataSourceID="SqlDataSourceDocs" AutoGenerateColumns="false">
            <Columns>
                <asp:CommandField ButtonType="Button" ShowDeleteButton="True" ShowEditButton="True" />
                <asp:BoundField DataField="id_doc" ReadOnly="true" />
                <asp:BoundField DataField="name_doc" />
                <asp:BoundField DataField="num_doc" />
                <asp:BoundField DataField="date_doc" />
                <asp:BoundField DataField="issue_doc" />
                <asp:BoundField DataField="description" />
            </Columns>
        </asp:GridView>

<asp:SqlDataSource ID="SqlDataSourceDocs" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
    SelectCommand="select * from Docs_docs" 
    UpdateCommand="update Docs_tags set tag_name=@tag_name, tag_note=@tag_note where id_tag=@id_tag" 
    DeleteCommand="delete from Docs_tags where id_tag=@id_tag">
    <UpdateParameters>
        <asp:Parameter Name="@tag_name" />
        <asp:Parameter Name="@tag_note" />
        <asp:Parameter Name="@id_tag" />
    </UpdateParameters>
    <DeleteParameters>
        <asp:Parameter Name="@id_tag" />
    </DeleteParameters>
</asp:SqlDataSource>
   
    <asp:SqlDataSource ID="SqlDataSourceTags" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
        SelectCommand="select '#'+tag_name tag_name from Docs_tags">

    </asp:SqlDataSource>

</asp:Content>

