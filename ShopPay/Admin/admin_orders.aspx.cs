using Microsoft.AspNet.Identity.Owin;
using ShopPay.App_Code;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace ShopPay.Admin
{
    public partial class admin_orders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //SqlDataSourceDocs.SelectParameters["customer"].DefaultValue = Context.User.Identity.GetUserName(); 
                //SqlDataSourceDocs.DataBind();
                BindUsersToUserList();
            }
        }
        private void BindUsersToUserList()
        {
            // Get all of the user accounts
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();

            ListCustomers.DataSource = manager.Users.ToList();
            ListCustomers.DataBind();
        }

        protected void ButtonComand_Command(object sender, CommandEventArgs e)
        {

        }

        protected void ButtonFilterClear_Click(object sender, EventArgs e)
        {

        }

        protected void PayOrder_Click(object sender, EventArgs e)
        {

        }

        protected void ButtonSearch_Click(object sender, EventArgs e)
        {
            SqlDataSourceDocs.DataBind();
        }

        protected void ButtonFilterClear_Click1(object sender, EventArgs e)
        {
            FiltrCustomer.Text = string.Empty;
            FiltrBegDate.Text = string.Empty;
            FiltrEndDate.Text = string.Empty;
            SqlDataSourceDocs.DataBind();
        }

        protected void GridViewOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string id = e.CommandArgument.ToString();
            Orders order = new Orders();
            if (order.PayOrder(int.Parse(id)))
            {
                GridViewOrders.DataBind();
            }

        }

        protected void ButtonCheckPay_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SQLConnectionString"].ToString()))
            {
                con.Open();
                try
                {
                    SqlDataAdapter sa = new SqlDataAdapter("select id_order from Docs_Orders where status='Сформирован' and OrderID is not null", con);
                    DataTable dt = new DataTable();
                    sa.Fill(dt);
                    foreach (DataRow dr in dt.Rows)
                    {
                        int id_order = int.Parse(dr["id_order"].ToString());
                        Orders order = new Orders(id_order);
                        order.CheckPayOrder();
                    }
                }
                finally
                {
                    con.Close();
                }
            }
            GridViewOrders.DataBind();
        }
    }
}