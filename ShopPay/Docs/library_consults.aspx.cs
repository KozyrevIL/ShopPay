using Microsoft.AspNet.Identity;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace ShopPay.Admin
{
    public partial class library_consults : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }
        }



        protected void GridViewDocs_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }


        protected void ButtonSearch_Click(object sender, EventArgs e)
        {
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
            DocMask.Text = string.Empty;
            GridViewDocs.DataBind();
        }
    }
}