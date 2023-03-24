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
                string urlOrder = Request.Url.ToString().Replace("listOrders", "").Replace("listOrders.aspx", "") + "order?id=" + e.CommandArgument.ToString() + "&waitingPay";
                string s = order.payOrderSber(urlOrder);
                if (s == string.Empty)
                    Response.Redirect(order.formURL);
                else
                    StatusMessage("error_custom", s, null);

                GridViewDocs.DataBind();
            }
        }
        protected void ButtonFilterClear_Click(object sender, EventArgs e)
        {

        }

        protected void PayOrder_Click(object sender, EventArgs e)
        {
        }
        protected void StatusMessage(string type_message, string text_info, Exception ex)
        {

            switch (type_message)
            {
                case "info":
                    StatusAlert.Attributes.Add("class", "alert alert-success alert-dismissible");
                    StatusAlert.Visible = true;

                    LabelStatus.CssClass = "alert alert-success";
                    LabelStatus.Visible = true;
                    LabelStatus.Text = text_info;
                    break;
                case "error":
                    StatusAlert.Attributes.Add("class", "alert alert-danger alert-dismissible");
                    StatusAlert.Visible = true;

                    LabelStatus.CssClass = "alert alert-danger";
                    LabelStatus.Visible = true;
                    LabelStatus.Text = "ОШИБКА! Запись не добавлена или добавлена некорректно. " + ex.Message.ToString();
                    break;
                case "error_custom":
                    StatusAlert.Attributes.Add("class", "alert alert-danger alert-dismissible");
                    StatusAlert.Visible = true;

                    LabelStatus.CssClass = "alert alert-danger";
                    LabelStatus.Visible = true;
                    LabelStatus.Text = text_info;
                    break;
            }


        }

    }
}