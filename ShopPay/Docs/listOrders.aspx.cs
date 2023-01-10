using Microsoft.AspNet.Identity;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using ShopPay.App_Code;

namespace ShopPay.Admin
{
    public partial class listOrders : System.Web.UI.Page
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

        }

        protected void ButtonComand_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "PayOrder")
            {
                Orders order = new Orders(int.Parse(e.CommandArgument.ToString()));
                string s = order.payOrderSber(Request.Url.ToString());
                if (s == string.Empty)
                    Response.Redirect(order.formURL);
                else
                    Response.Redirect(Request.RawUrl);
            }
        }
        protected void ButtonFilterClear_Click(object sender, EventArgs e)
        {

        }

        protected void PayOrder_Click(object sender, EventArgs e)
        {
        }
    }
}