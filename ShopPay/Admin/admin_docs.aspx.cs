using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ShopPay.Admin
{
    public partial class admin_docs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void AddDoc_Click(object sender, EventArgs e)
        {



            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SQLConnectionString"].ToString()))
            {
                con.Open();
                try
                {
                    SqlCommand cmd = new SqlCommand("insert into Docs_docs (name_doc,num_doc,date_doc,issue_doc,description) values (@name_doc,@num_doc,@date_doc,@issue_doc,@description)", con);
                    cmd.Parameters.AddWithValue("name_doc", DocName.Text);
                    cmd.Parameters.AddWithValue("num_doc", DocName.Text);
                    cmd.Parameters.AddWithValue("date_doc", DocName.Text);
                    cmd.Parameters.AddWithValue("issue_doc", DocName.Text);
                    cmd.Parameters.AddWithValue("description", DocName.Text);
                    cmd.Parameters.AddWithValue("name_doc", DocName.Text);
                    cmd.Parameters.AddWithValue("items", DocName.Text);
                    cmd.ExecuteNonQuery();
                }
                finally
                {
                    DocName.Text = string.Empty;
                    //TagNote.Text = string.Empty;
                    con.Close();
                }
                GridViewTags.DataBind();
            }

        }
    }
}