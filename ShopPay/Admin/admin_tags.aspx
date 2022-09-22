<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="admin_tags.aspx.cs" Inherits="ShopPay.Admin.admin_tags" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div>
    Добавить "тэг"
    <asp:Label runat="server">Имя тэга</asp:Label><asp:TextBox ID="TagName" runat="server"></asp:TextBox>
    <br />
    <asp:Label runat="server">Описание тэга</asp:Label><asp:TextBox ID="TagNote" runat="server" TextMode="MultiLine"></asp:TextBox>
    <br />
    <asp:Button ID="AddTag" runat="server" Text="Добавить" OnClick="AddTag_Click"/>
    <br />
</div>

        <asp:GridView runat="server" ID="GridViewTags" DataKeyNames="id_tag" DataSourceID="SqlDataSourceTags" AutoGenerateColumns="false">
            <Columns>
                <asp:CommandField ButtonType="Button" ShowDeleteButton="True" ShowEditButton="True" />
                <asp:BoundField DataField="id_tag" ReadOnly="true" />
                <asp:BoundField DataField="tag_name" />
                <asp:BoundField DataField="tag_note" />
            </Columns>
        </asp:GridView>

<asp:SqlDataSource ID="SqlDataSourceTags" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
    SelectCommand="select * from Docs_tags order by tag_name" 
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

</asp:Content>

