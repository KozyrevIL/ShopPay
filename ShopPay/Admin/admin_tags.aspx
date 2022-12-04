<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" MaintainScrollPositionOnPostback="true" AutoEventWireup="true" CodeBehind="admin_tags.aspx.cs" Inherits="ShopPay.Admin.admin_tags" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="tags">


        <section id="header">
            <div class="container-fluid text-center">
                <h3>Администрирование.  Добавить метку документа</h3>
            </div>
        </section>


        <section id="grid_content">

            <grid_form_imput>
                <div class="grid_input_data">

                    <div class="form-group">
                        <asp:Label runat="server">Имя тэга</asp:Label>
                        <asp:TextBox ID="TagName" runat="server" CssClass="form-control" Width="250px"></asp:TextBox>
                        <br />
                        <asp:Label runat="server">Описание тэга</asp:Label>
                        <asp:TextBox ID="TagNote" runat="server" TextMode="MultiLine" CssClass="form-control" Width="250px" Height="80px"></asp:TextBox>
                        <br />
                        <asp:Button ID="AddTag" runat="server" Text="Добавить" CssClass="btn btn-success" OnClick="AddTag_Click" />
                    </div>
                </div>
                
                <div class="grid_view_data" style="overflow: auto" >
                    
                    
                        <asp:GridView runat="server" ID="GridViewTags" DataKeyNames="id_tag" CssClass="table table-secondary  table-hover table-striped" DataSourceID="SqlDataSourceTags" AutoGenerateColumns="false">
                            <HeaderStyle CssClass=" table table-info" />
                            <Columns>

                                <asp:BoundField DataField="id_tag" ReadOnly="true" HeaderText="N" />
                                <asp:BoundField DataField="tag_name" ControlStyle-CssClass="form-control" HeaderText="Наименование" />
                                <asp:BoundField DataField="tag_note" ControlStyle-CssClass="form-control" HeaderText="Описание" />
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
                                            <asp:LinkButton ID="LinkButtonCancel" runat="server" ToolTip="Отменить" CommandName="Cancel" CausesValidation="false" CssClass="btn btn-warning">
                                <i class="glyphicon glyphicon-remove"></i>
                                            </asp:LinkButton>
                                        </div>
                                    </EditItemTemplate>
                                    <ItemStyle Width="100px" />

                                </asp:TemplateField>

                            </Columns>
                            <AlternatingRowStyle CssClass="alter_row_style" />
                            <RowStyle CssClass="item_row_style" />
                            <EditRowStyle CssClass="danger" />
                        </asp:GridView>
                    
                   
                </div>
            </grid_form_imput>

        </section>

        <section id="data">


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

        </section>

    </div>

</asp:Content>

