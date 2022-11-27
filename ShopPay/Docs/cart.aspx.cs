﻿using Microsoft.AspNet.Identity;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using ShopPay.App_Code;

namespace ShopPay.Admin
{
    public partial class cart : System.Web.UI.Page
    {
        private int CalculateAllPrice(string sMonth)
        {
            int intPrice=0;
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SQLConnectionString"].ToString()))
            {
                con.Open();
                try
                {

                    SqlCommand cmd = new SqlCommand(@"select sum([dbo].[Docs_GetPrice](id_doc,GETDATE())) from Docs_Cart where customer=@customer", con);
                    cmd.Parameters.AddWithValue("customer", Context.User.Identity.GetUserName());
                    string sPrice = cmd.ExecuteScalar()?.ToString() ?? "0";
                    int intMonth = 1;
                    int.TryParse(sMonth, out intMonth);
                    int.TryParse(sPrice, out intPrice);
                    intPrice =  intPrice * intMonth;
                }
                finally
                {
                    con.Close();
                }
            }
            return intPrice;

        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SqlDataSourceDocs.SelectParameters["customer"].DefaultValue = Context.User.Identity.GetUserName();
                SqlDataSourceDocs.DataBind();
                qtyMonth.Text = "1";
            }
            AllPrice.Text = CalculateAllPrice(qtyMonth.Text).ToString();
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

        protected void minusMonth_Click(object sender, EventArgs e)
        {
            int intMonth = 1;
            int.TryParse(qtyMonth.Text, out intMonth);
            intMonth--;
            if (intMonth < 1) intMonth = 1;
            qtyMonth.Text = intMonth.ToString();
            AllPrice.Text = CalculateAllPrice(intMonth.ToString()).ToString();

        }

        protected void plusMonth_Click(object sender, EventArgs e)
        {

            int intMonth = 1;
            int.TryParse(qtyMonth.Text, out intMonth);
            intMonth ++;
            qtyMonth.Text = intMonth.ToString();
            AllPrice.Text = CalculateAllPrice(intMonth.ToString()).ToString();
        }

        protected void CreateOrder_Click(object sender, EventArgs e)
        {
            int intMonth = 1;
            int.TryParse(qtyMonth.Text, out intMonth);
            float.TryParse(AllPrice.Text, out float allCost);
            Orders order = new Orders(Context.User.Identity.GetUserName(), intMonth, allCost, true);
            if (order.idOrder > 0) Response.Redirect("~/Order.aspx?id=" + order.idOrder.ToString());
        }
    }
}