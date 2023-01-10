using ShopPay.App_Code;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using System.Web.UI.WebControls;

namespace ShopPay.Admin
{
    public partial class order : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.Params["id"] != null)
                    ViewState["idOrder"] = Request.Params["id"].ToString();
                else
                    ViewState["idOrder"] = "7";
                Orders order = new Orders(int.Parse(ViewState["idOrder"].ToString()));
                SqlDataSourceDocs.SelectParameters["id"].DefaultValue = ViewState["idOrder"].ToString();
                SqlDataSourceDocs.DataBind();
                SqlDataSourceConsults.SelectParameters["id"].DefaultValue = ViewState["idOrder"].ToString();
                SqlDataSourceConsults.DataBind();
                if (GridViewDocs.Rows.Count == 0) orderDocs.Visible = false;
                if (GridViewConsults.Rows.Count == 0) orderConsults.Visible = false;

                AllPrice.Text = order.Cost.ToString();
                PaidOrder.Visible = false;
                if (order.status=="Оплачен")
                {
                    PaidOrder.Visible = true;
                    PayOrder.Visible = false;
                }
                LabelNumOrder.Text = " № " + order.idOrder.ToString();
                LabelDateOrder.Text = " от " + order.dateOrder.ToString("dd.MM.yyyy");
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

        protected void ButtonComand_Command(object sender, CommandEventArgs e)
        {

        }

        protected void ButtonFilterClear_Click(object sender, EventArgs e)
        {

        }

        protected void PayOrder_Click(object sender, EventArgs e)
        {
            Orders order = new Orders(int.Parse(ViewState["idOrder"].ToString()));
            string s = order.payOrderSber(Request.Url.ToString());
            if (s == string.Empty)
                Response.Redirect(order.formURL);
            else
                Response.Redirect(Request.RawUrl);
        }
    }
}