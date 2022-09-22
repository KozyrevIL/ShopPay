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
    public partial class admin_tags : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void AddTag_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SQLConnectionString"].ToString()))
            {
                con.Open();
                try
                {
                    SqlCommand cmd = new SqlCommand("insert into Docs_tags (tag_name,tag_note) values (@tag_name,@tag_note)", con);
                    cmd.Parameters.AddWithValue("tag_name", TagName.Text);
                    cmd.Parameters.AddWithValue("tag_note", TagNote.Text);
                    cmd.ExecuteNonQuery();
                }
                finally
                {
                    TagName.Text = string.Empty;
                    TagNote.Text = string.Empty;
                    con.Close();
                }
                GridViewTags.DataBind();
            }

        }
    }
}