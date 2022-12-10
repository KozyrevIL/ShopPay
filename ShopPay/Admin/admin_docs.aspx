<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="admin_docs.aspx.cs" Inherits="ShopPay.Admin.admin_docs" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="admin_doc">
        <section id="header">
            <div class="container-fluid text-center">
                <h3>Администрирование.  Добавить документ</h3>
            </div>
        </section>

        <section id="grid_content">

            <div class="grid_input_data" name="InsertDoc">
                <div class="item1">
                    <asp:Label runat="server">Описание тэгов</asp:Label>
                    <br />
                    <div style="height: 200px; overflow: scroll">
                        <asp:GridView ID="GridViewTags" runat="server" CssClass="table table-bordered table-hover" DataSourceID="SqlDataSourceTags" AutoGenerateColumns="false" ShowHeader="false">
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
                        <asp:TextBox ID="TagName" runat="server" CssClass="form-control"></asp:TextBox><br />
                        <asp:TextBox ID="TagNote" runat="server" TextMode="MultiLine" CssClass="form-control" ></asp:TextBox>
                        <asp:Button ID="BtnAddTag" runat="server" OnClick="BtnAddTag_Click" Text="Добавить тэг" CssClass="btn btn-default" />
                    </div>
                </div>
                <div class="item2">

                    <div>
                        <asp:Label runat="server">Вид раздела</asp:Label><asp:DropDownList ID="SelectSection" runat="server" DataSourceID="SqlDataSourceSections" DataTextField="section_name" DataValueField="id_section" CssClass="form-control"></asp:DropDownList><br />
                        <asp:Label runat="server">Наименование документа</asp:Label><asp:TextBox ID="DocName" runat="server" CssClass="form-control"></asp:TextBox>

                    </div>
                    <div>
                        <asp:Label runat="server">Описание документа</asp:Label><asp:TextBox ID="DocDescription" runat="server" TextMode="MultiLine" CssClass="form-control" Height=108px></asp:TextBox>
                    </div>
                    <div>
                        <asp:Label runat="server">Содержание документа</asp:Label><asp:TextBox ID="DocContent" runat="server" TextMode="MultiLine" CssClass="form-control" Height=108px></asp:TextBox>
                    </div>
                    <div>
                        <asp:Label runat="server">Дата документа</asp:Label><asp:TextBox ID="DocDate" runat="server" CssClass="form-control"></asp:TextBox><br />
                        <asp:CheckBox ID="CheckActual" runat="server" Text="Актуальность" />
                    </div>
                    <div>
                        <asp:Label runat="server">Цена аренды, руб./мес.</asp:Label><asp:TextBox ID="DocPrice" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div>
                        <asp:Label runat="server">Обложка документа</asp:Label>
                        <asp:FileUpload ID="DocCover" runat="server"></asp:FileUpload>
                        <br />
                        <asp:Label runat="server">Образ документа</asp:Label>
                        <asp:FileUpload ID="DocScan" runat="server"></asp:FileUpload>
                    </div>

                    <div>
                        <asp:Button ID="AddDoc" runat="server" Text="Добавить документ" CssClass="btn btn-success" OnClick="AddDoc_Click" />
                    </div>
                
                </div>
            </div>
        
            <div class="grid_filter_data" name="Filter">
                    <%--Фильтр по разделу--%>
                <div class=" input-group">
                    <asp:DropDownList ID="DropDownSections" runat="server" AppendDataBoundItems="true" DataSourceID="SqlDataSourceSections" DataTextField="section_name" DataValueField="id_section" CssClass=" input-group-addon" Width="245">
                        <asp:ListItem Value="-1">Все разделы</asp:ListItem>
                    </asp:DropDownList>
                    <asp:Button ID="ButtonTagSearch" runat="server" OnClick="ButtonSearch_Click" Text="Применить" CssClass="btn btn-default" />
                </div>
                <div class=" input-group">
                    <asp:TextBox ID="DocMask" runat="server" CssClass="input-group-addon" Width="265"></asp:TextBox>
                    <asp:Button ID="ButtonSearch" runat="server" OnClick="ButtonSearch_Click" Text="Применить" CssClass="btn btn-default" />


                    
                    <asp:Button ID="ButtonFilterClear" runat="server" OnClick="ButtonFilterClear_Click" Text="Сбросить" CssClass="btn btn-default" />
                </div>


            </div>
            


            <div class="grid_view_data">
                <div class="filter_data_ext" name="Filter" style="overflow: auto">
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
                </div>
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
                                    <asp:Label ID="LabelItems" runat="server" Text='<%# Eval("items") %>'></asp:Label>
                                    <asp:Label ID="LabelCover" runat="server" Text='<%# Eval("cover") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Обложка">
                                <ItemTemplate>
                                    <asp:Image ID="ImageCover" runat="server" Height="106" ImageUrl='<%# "~/ImageHandler.ashx?tp=cover&fn="+(Eval("cover").ToString()!=""?Eval("cover").ToString():"empty.jpg") %>' />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:FileUpload ID="FileCover" runat="server" />
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Образ документа">
                                <ItemTemplate>
                                    <asp:HyperLink ID="DocImage" runat="server" NavigateUrl='<%# "~/ImageHandler.ashx?fn="+Eval("items") %>'>Скачать документ</asp:HyperLink>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:FileUpload ID="FileScan" runat="server" />
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Тэги">
                                <ItemTemplate>
                                    <asp:TextBox ID="TagsList" runat="server" Text='<%# Eval("tags") %>' TextMode="MultiLine" ReadOnly="true" Enabled="false"> </asp:TextBox>
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
                            <asp:TemplateField HeaderText="Вид раздела">
                                <ItemTemplate>
                                    <asp:Label ID="LabelSectionDoc" runat="server" Text='<%# Eval("section_name") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownSection" runat="server" DataSourceID="SqlDataSourceSections" DataTextField="section_name" DataValueField="id_section" SelectedValue='<%# Bind("id_section") %>'></asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Актуальность">
                                <ItemTemplate>
                                    <asp:Label ID="LabelActual" runat="server" Text='<%# Eval("isActual").ToString()=="True"?"Актуален":"Неактуален" %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:CheckBox ID="CheckisAsctual" runat="server" Checked='<%# Bind("isActual") %>' />
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Дата документа">
                                <ItemTemplate>
                                    <asp:Label ID="LabelDateDoc" runat="server" Text='<%# Eval("date_doc") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="EditDateDoc" runat="server" Text='<%# Bind("date_doc") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Наименование">
                                <ItemTemplate>
                                    <asp:Label ID="LabelNameDoc" runat="server" Text='<%# Bind("name_doc") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="EditNameDoc" runat="server" Text='<%# Bind("name_doc") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Описание документа">
                                <ItemTemplate>
                                    <asp:Label ID="LabelDescDoc" runat="server" Text='<%# Bind("description") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="EditDescDoc" runat="server" Text='<%# Bind("description") %>' TextMode="MultiLine"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Содержание документа">
                                <ItemTemplate>
                                    <asp:Label ID="LabelContentDoc" runat="server" Text='<%# Bind("doc_content") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="EditContentDoc" runat="server" Text='<%# Bind("doc_content") %>' TextMode="MultiLine"></asp:TextBox>
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
                        <AlternatingRowStyle CssClass="alter_row_style" />
                            <RowStyle CssClass="item_row_style" />
                            <EditRowStyle CssClass="danger" />
                    </asp:GridView>
                </div>
                
            </div>

        </section>

        <section id="data">

            <asp:SqlDataSource ID="SqlDataSourceDocs" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>" 
                SelectCommand="select dd.id_doc,dd.id_section,dd.name_doc,dd.date_doc,dd.issue_doc,dd.num_doc,isnull(dd.isActual,0) isActual,dd.description,dd.items,dd.cover,dd.doc_content,ds.section_name,(SELECT STRING_AGG(t.tag_name,CHAR(10)) 
                FROM Docs_DocTags dt, docs_tags t where dt.id_doc=dd.id_doc and t.id_tag=dt.id_tag) tags,[dbo].[Docs_GetPrice](dd.id_doc,GETDATE()) doc_price
            from Docs_docs dd, Docs_DocSections ds 
            where dd.id_section=ds.id_section 
            and (@mask=' ' or dd.name_doc like '%'+@mask+'%' or dd.description like '%'+@mask+'%')
            and (@section ='-1' or dd.id_section=@section)
            and (@tags=',' or exists (select 'x' from Docs_DocTags where Docs_DocTags.id_doc=dd.id_doc and charindex(','+CONVERT(nvarchar,Docs_DocTags.id_tag)+',',@tags)>0))"
            UpdateCommand="update Docs_docs set name_doc=@name_doc where id_doc=@id_doc"
            DeleteCommand="delete from Docs_docs where id_doc=@id_doc">
            <SelectParameters>
                <asp:ControlParameter ControlID="DocMask" Name="mask" PropertyName="Text" DefaultValue=" " />
                <asp:ControlParameter ControlID="DropDownSections" Name="section" PropertyName="SelectedValue" DefaultValue="-1" />
                <asp:Parameter Name="tags" DefaultValue=","/>
            </SelectParameters>
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
            <asp:SqlDataSource ID="SqlDataSourceSections" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConnectionString %>"
                SelectCommand="select id_section, section_name from Docs_DocSections"></asp:SqlDataSource>

        </section>
        <asp:Label ID="LabelError" runat="server"></asp:Label>

    </div>
</asp:Content>

