using Microsoft.AspNet.Identity;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace ShopPay.Admin
{
    public partial class library_docs : System.Web.UI.Page
    {
        private string SQLMINE=@"select 
dd.id_doc,dd.id_section,dd.name_doc,dd.date_doc,dd.issue_doc,dd.num_doc,isnull(dd.isActual,0) isActual,dd.description,dd.items
        ,isnull(dd.cover,'empty.jpg') cover,dd.doc_content, ds.section_name
        ,[dbo].[Docs_DocIsAvailable](dd.id_doc,@customer) DocisAvailable
        ,[dbo].[Docs_GetPrice](dd.id_doc,GETDATE()) doc_price        
        ,isnull((select CONVERT(BIT,1) from Docs_Favorits df where df.id_doc=dd.id_doc and df.customer=@customer),CONVERT(BIT,0)) favorite
from Docs_OrderItems oi, Docs_Orders o, Docs_docs dd, Docs_DocSections ds  
where dd.id_typeProduct=1 and
o.id_order=oi.id_order and 
o.status='Оплачен' and 
CONVERT(DATE,GETDATE()) <= oi.period_end and
dd.id_doc = oi.id_doc and
dd.id_section = ds.id_section and
        (@mask=' ' or dd.name_doc like '%'+@mask+'%' or dd.description like '%'+@mask+'%')
        and (@section ='-1' or dd.id_section=@section)
        and (@tags=',' or exists (select 'x' from Docs_DocTags where Docs_DocTags.id_doc=dd.id_doc and charindex(','+CONVERT(nvarchar,Docs_DocTags.id_tag)+',',@tags)>0))";

        private string SQLALL = @"select dd.id_doc,dd.id_section,dd.name_doc,dd.date_doc,dd.issue_doc,dd.num_doc,isnull(dd.isActual,0) isActual,dd.description,dd.items
        ,isnull(dd.cover,'empty.jpg') cover,dd.doc_content, ds.section_name
        ,[dbo].[Docs_DocIsAvailable](dd.id_doc,@customer) DocisAvailable
        ,[dbo].[Docs_GetPrice](dd.id_doc,GETDATE()) doc_price        
        ,isnull((select CONVERT(BIT,1) from Docs_Favorits df where df.id_doc=dd.id_doc and df.customer=@customer),CONVERT(BIT,0)) favorite
        from Docs_docs dd, Docs_DocSections ds 
        where  dd.id_typeProduct=1 and
        dd.id_section=ds.id_section and
        (@mask=' ' or dd.name_doc like '%'+@mask+'%' or dd.description like '%'+@mask+'%')
        and (@section ='-1' or dd.id_section=@section)
        and (@tags=',' or exists (select 'x' from Docs_DocTags where Docs_DocTags.id_doc=dd.id_doc and charindex(','+CONVERT(nvarchar,Docs_DocTags.id_tag)+',',@tags)>0))";


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string filter = "all";
                ViewState["SqlText"] = SQLALL;
                if (Request.Params["filter"] != null)
                    filter = Request.Params["filter"].ToString();
                if (filter == "mine")
                {
                    ViewState["SqlText"] = SQLMINE;
                    SqlDataSourceDocs.SelectCommand = SQLMINE;
                    SqlDataSourceDocs.SelectParameters["customer"].DefaultValue = Context.User.Identity.GetUserName();
                    SqlDataSourceDocs.DataBind();
                    if (GridViewDocs.Rows.Count == 0)
                    {
                        ViewState["SqlText"] = SQLALL;
                    }
                }
            }
            SqlDataSourceDocs.SelectParameters["customer"].DefaultValue = Context.User.Identity.GetUserName();
            SqlDataSourceDocs.SelectCommand = ViewState["SqlText"].ToString();
            SqlDataSourceDocs.DataBind();
        }



        protected void GridViewDocs_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowState == DataControlRowState.Edit)
            {
                GridView gw = (GridView)e.Row.FindControl("GridViewEditTags");
                string id_doc = ((Label)e.Row.FindControl("LabelIDDoc")).Text;

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SQLConnectionString"].ToString()))
                {
                    con.Open();
                    try
                    {

                        SqlDataAdapter adapter = new SqlDataAdapter(@"select id_tag, isnull((select 1 from Docs_DocTags dt where dt.id_doc = " + id_doc + " and dt.id_tag = t.id_tag),0) chkTag, '#' + t.tag_name tag_name from Docs_tags t", con);
                        DataTable dataTable = new DataTable();
                        adapter.Fill(dataTable);
                        gw.DataSource = dataTable;
                        gw.DataBind();
                    }
                    finally
                    {
                        con.Close();
                    }
                }

            }
        }


        protected void ButtonSearch_Click(object sender, EventArgs e)
        {
            string FilterTags = ",";
            foreach (GridViewRow gr in GridViewFilterTags.Rows)
            {
                Label IDTag = (Label)gr.FindControl("LabelIdTag");
                CheckBox cbTag = (CheckBox)gr.FindControl("CheckTag");
                if (IDTag == null) continue;
                if (cbTag == null) continue;
                if (cbTag.Checked)
                {
                    FilterTags += IDTag.Text + ",";
                }
            }

            SqlDataSourceDocs.SelectParameters["tags"].DefaultValue = FilterTags;
            GridViewDocs.DataBind();

        }

        protected void ButtonComand_Command(object sender, CommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "pay":
                    Response.Redirect("viewer_doc?iddoc=" + e.CommandArgument);
                    break;
                case "archive":
                    break;
            }
        }

        protected void ButtonFilterClear_Click(object sender, EventArgs e)
        {
            string FilterTags = ",";
            DocMask.Text = string.Empty;
            DropDownSections.SelectedIndex = 0;

            foreach (GridViewRow gr in GridViewFilterTags.Rows)
            {
                CheckBox cbTag = (CheckBox)gr.FindControl("CheckTag");
                if (cbTag == null) continue;
                cbTag.Checked = false;
            }
            SqlDataSourceDocs.SelectParameters["tags"].DefaultValue = FilterTags;
            GridViewDocs.DataBind();

        }
    }
}