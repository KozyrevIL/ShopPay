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
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SqlDataSourceDocs.SelectParameters["customer"].DefaultValue = Context.User.Identity.GetUserName();
                SqlDataSourceDocs.DataBind();
            }
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