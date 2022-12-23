using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Entity.Infrastructure;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Net.Mime.MediaTypeNames;

namespace ShopPay.Admin
{
    public partial class admin_consult : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void AddDoc_Click(object sender, EventArgs e)
        {
            string destDir = Server.MapPath("./../Upload/ImagesDocs");

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SQLConnectionString"].ToString()))
            {
                con.Open();
                try
                {
                    SqlCommand cmd = new SqlCommand("BEGIN TRANSACTION", con);
                    cmd.ExecuteNonQuery();

                    cmd = new SqlCommand("insert into Docs_docs (id_typeProduct, name_doc, description,isActual ) values (2, @name_doc, @description, @isActual)", con);

                    cmd.Parameters.AddWithValue("name_doc", DocName.Text);
                    cmd.Parameters.AddWithValue("description", DocDescription.Text);
                    cmd.Parameters.AddWithValue("isActual", CheckActual.Checked);
                    cmd.ExecuteNonQuery();

                    cmd = new SqlCommand("select @@IDENTITY ", con);
                    string id_doc = cmd.ExecuteScalar().ToString();

                    // Добавим цену в прайс - лист
                    int PriceArenda = 0;
                    if (int.TryParse(DocPrice.Text, out PriceArenda))
                    {
                        cmd = new SqlCommand("insert into Docs_DocsPrice (id_doc,price, date_start) values (@id_doc,@price,GETDATE())", con);
                        cmd.Parameters.AddWithValue("id_doc", id_doc);
                        cmd.Parameters.AddWithValue("price", PriceArenda);
                        cmd.ExecuteNonQuery();
                    }
                    cmd = new SqlCommand("COMMIT", con);
                    cmd.ExecuteNonQuery();
                }
                catch
                {
                    SqlCommand cmd = new SqlCommand("ROLLBACK", con);
                    cmd.ExecuteNonQuery();
                    LabelError.Text = "Ошибка добавления сведений о консультации!";
                }
                finally
                {
                    DocName.Text = string.Empty;
                    //TagNote.Text = string.Empty;
                    con.Close();
                }
                GridViewDocs.DataBind();
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

        protected void GridViewDocs_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
           

            GridViewRow grw = GridViewDocs.Rows[e.RowIndex];
            string id_doc = ((Label)grw.FindControl("LabelIDDoc")).Text;
            string docname = ((TextBox)grw.FindControl("EditNameDoc")).Text;
            string docdesc = ((TextBox)grw.FindControl("EditDescDoc")).Text;
            string docprice = ((TextBox)grw.FindControl("EditPriceDoc")).Text;
            bool isActual = ((CheckBox)grw.FindControl("CheckisActual")).Checked;
                
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SQLConnectionString"].ToString()))
            {
                con.Open();
                try
                {
                    SqlCommand cmd = new SqlCommand("BEGIN TRANSACTION", con);
                    cmd.ExecuteNonQuery();

                    cmd = new SqlCommand("update Docs_docs set name_doc=@name_doc, description=@description, isActual=@isActual where id_doc=@id_doc", con);
                    cmd.Parameters.AddWithValue("name_doc", docname);
                    cmd.Parameters.AddWithValue("description", docdesc);
                    cmd.Parameters.AddWithValue("isActual", isActual);
                    cmd.Parameters.AddWithValue("id_doc", id_doc);
                    cmd.ExecuteNonQuery();

                    int PriceArenda = 0;
                    if (int.TryParse(docprice, out PriceArenda))
                    {
                        cmd = new SqlCommand("delete from Docs_DocsPrice where id_doc=@id_doc", con);
                        cmd.Parameters.AddWithValue("id_doc", id_doc);
                        cmd.ExecuteNonQuery();

                        cmd = new SqlCommand("insert into Docs_DocsPrice (id_doc,price,id_unit,date_start) values (@id_doc,@price,2,GETDATE())", con);
                        cmd.Parameters.AddWithValue("id_doc", id_doc);
                        cmd.Parameters.AddWithValue("price", PriceArenda);
                        cmd.ExecuteNonQuery();
                    }

                    cmd = new SqlCommand("COMMIT", con);
                    cmd.ExecuteNonQuery();
                }
                catch
                {
                    SqlCommand cmd = new SqlCommand("ROLLBACK", con);
                    cmd.ExecuteNonQuery();
                    LabelError.Text = "Ошибка обновления сведений о консультации!";
                    e.Cancel = true;
                }
                finally
                {
                    con.Close();
                }
                GridViewDocs.DataBind();
            }

        }
        protected void ButtonSearch_Click(object sender, EventArgs e)
        {
            GridViewDocs.DataBind();
        }
        protected void ButtonFilterClear_Click(object sender, EventArgs e)
        {
            DocMask.Text = string.Empty;
            GridViewDocs.DataBind();
        }

    }
}