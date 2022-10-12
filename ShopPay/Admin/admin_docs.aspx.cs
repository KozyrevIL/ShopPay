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
    public partial class admin_docs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void AddDoc_Click(object sender, EventArgs e)
        {
            int fileLength = DocScan.PostedFile.ContentLength;
            if (fileLength == 0)
            {
                LabelError.Text = "Не указан образ документа!";
                return;
            }
            string destDir = Server.MapPath("./../Upload/ImagesDocs");
            string GUIDFile = Guid.NewGuid().ToString() + Path.GetExtension(DocScan.PostedFile.FileName);

            string FileTempDir = Path.Combine(destDir, GUIDFile);
            DocScan.PostedFile.SaveAs(FileTempDir);

            int fileLengthCover = DocCover.PostedFile.ContentLength;
            string FileTempDirCover = string.Empty;
            if (fileLengthCover != 0)
            {
                string destDirCover = Server.MapPath("./../Upload/ImagesCovers");
                string GUIDFileCover = Guid.NewGuid().ToString() + Path.GetExtension(DocCover.PostedFile.FileName);

                FileTempDirCover = Path.Combine(destDirCover, GUIDFileCover);
                DocCover.PostedFile.SaveAs(FileTempDirCover);
            }
            string id_section = SelectSection.SelectedValue;

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SQLConnectionString"].ToString()))
            {
                con.Open();
                try
                {
                    SqlCommand cmd = new SqlCommand("BEGIN TRANSACTION", con);
                    cmd.ExecuteNonQuery();

                    cmd = new SqlCommand("insert into Docs_docs (id_section, name_doc,date_doc,description,items,cover) values (@id_section, @name_doc,@date_doc,@description,@items,@cover)", con);

                    cmd.Parameters.AddWithValue("id_section", id_section);
                    cmd.Parameters.AddWithValue("name_doc", DocName.Text);
                    cmd.Parameters.AddWithValue("date_doc", DocDate.Text);
                    cmd.Parameters.AddWithValue("description", DocDescription.Text);
                    cmd.Parameters.AddWithValue("items",Path.GetFileName(FileTempDir));
                    if (FileTempDirCover == string.Empty)
                        cmd.Parameters.AddWithValue("cover", DBNull.Value);
                    else
                        cmd.Parameters.AddWithValue("cover", Path.GetFileName(FileTempDirCover));

                    cmd.ExecuteNonQuery();

                    cmd = new SqlCommand("select @@IDENTITY ", con);
                    string id_doc = cmd.ExecuteScalar().ToString();
                    cmd = new SqlCommand("insert into Docs_DocTags (id_doc,id_tag) values (@id_doc,@id_tag)", con);
                    foreach (GridViewRow gr in GridViewTags.Rows)
                    {
                        Label IDTag = (Label)gr.FindControl("LabelIdTag");
                        CheckBox cbTag = (CheckBox)gr.FindControl("CheckTag");
                        if (IDTag == null) continue;
                        if (cbTag == null) continue;
                        if (cbTag.Checked)
                        {
                            cmd.Parameters.Clear();
                            cmd.Parameters.AddWithValue("id_doc", id_doc);
                            cmd.Parameters.AddWithValue("id_tag", IDTag.Text);
                            cmd.ExecuteNonQuery();
                        }
                    }
                    cmd = new SqlCommand("COMMIT", con);
                    cmd.ExecuteNonQuery();
                }
                catch
                {
                    SqlCommand cmd = new SqlCommand("ROLLBACK", con);
                    cmd.ExecuteNonQuery();
                    LabelError.Text = "Ошибка добавления документа";
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

        protected void BtnAddTag_Click(object sender, EventArgs e)
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
            GridView GVT = (GridView)grw.FindControl("GridViewEditTags");
            string id_doc = ((Label)grw.FindControl("LabelIDDoc")).Text;
            string id_section = ((DropDownList)grw.FindControl("DropDownSection")).SelectedValue;
            string filePath = ((Label) grw.FindControl("LabelItems")).Text;
            string filePathCover = ((Label)grw.FindControl("LabelCover")).Text;
            FileUpload FileUpload = (FileUpload)grw.FindControl("FileScan");
            FileUpload FileCover = (FileUpload)grw.FindControl("FileCover");


            string docname = ((TextBox)grw.FindControl("EditNameDoc")).Text;
//            string docnum = ((TextBox)grw.FindControl("EditNumDoc")).Text;
            string docdate = ((TextBox)grw.FindControl("EditDateDoc")).Text;
//            string docissue = ((TextBox)grw.FindControl("EditIssueDoc")).Text;
            string docdesc = ((TextBox)grw.FindControl("EditDescDoc")).Text;

            string destDir = Server.MapPath("./../Upload/ImagesDocs");
            string OldfilePath = Path.Combine(destDir, filePath);
            string NewfilePath = OldfilePath;

            int fileLength = FileUpload.PostedFile.ContentLength;
            if (fileLength != 0)
            {

                string GUIDFile = Guid.NewGuid().ToString() + Path.GetExtension(FileUpload.PostedFile.FileName);
                NewfilePath = Path.Combine(destDir, GUIDFile);
                FileUpload.PostedFile.SaveAs(NewfilePath);
            }

            string destDirCover = Server.MapPath("./../Upload/ImagesCovers");
            string OldfilePathCover = Path.Combine(destDirCover, filePathCover);
            string NewfilePathCover = OldfilePathCover;

            int fileLengthCover = FileCover.PostedFile.ContentLength;
            if (fileLengthCover != 0)
            {

                string GUIDFileCover = Guid.NewGuid().ToString() + Path.GetExtension(FileCover.PostedFile.FileName);
                NewfilePathCover = Path.Combine(destDirCover, GUIDFileCover);
                FileCover.PostedFile.SaveAs(NewfilePathCover);
            }


            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SQLConnectionString"].ToString()))
            {
                con.Open();
                try
                {
                    SqlCommand cmd = new SqlCommand("BEGIN TRANSACTION", con);
                    cmd.ExecuteNonQuery();

                    cmd = new SqlCommand("update Docs_docs set name_doc=@name_doc, id_section=@id_section, date_doc=@date_doc, description=@description, items=@items, cover=@cover where id_doc=@id_doc", con);
                    cmd.Parameters.AddWithValue("name_doc", docname);
                    cmd.Parameters.AddWithValue("id_section", id_section);
                    //                  cmd.Parameters.AddWithValue("num_doc", docnum);
                   cmd.Parameters.AddWithValue("date_doc", docdate);
                    //                  cmd.Parameters.AddWithValue("issue_doc", docissue);
                    cmd.Parameters.AddWithValue("description", docdesc);
                    cmd.Parameters.AddWithValue("items",Path.GetFileName(NewfilePath));

                    if (NewfilePathCover == string.Empty)
                        cmd.Parameters.AddWithValue("cover", DBNull.Value);
                    else
                        cmd.Parameters.AddWithValue("cover", Path.GetFileName(NewfilePathCover));

                    cmd.Parameters.AddWithValue("id_doc", id_doc);

                    cmd.ExecuteNonQuery();

                    cmd = new SqlCommand("delete from Docs_DocTags where id_doc="+id_doc, con);
                    cmd.ExecuteNonQuery();

                    cmd = new SqlCommand("insert into Docs_DocTags (id_doc,id_tag) values (@id_doc,@id_tag)", con);
                    foreach (GridViewRow gr in GVT.Rows)
                    {
                        Label IDTag = (Label)gr.FindControl("LabelEditIdTag");
                        CheckBox cbTag = (CheckBox)gr.FindControl("CheckEditTag");
                        if (IDTag == null) continue;
                        if (cbTag == null) continue;
                        if (cbTag.Checked)
                        {
                            cmd.Parameters.Clear();
                            cmd.Parameters.AddWithValue("id_doc", id_doc);
                            cmd.Parameters.AddWithValue("id_tag", IDTag.Text);
                            cmd.ExecuteNonQuery();
                        }
                    }
                    cmd = new SqlCommand("COMMIT", con);
                    cmd.ExecuteNonQuery();
                    try
                    {
                        if (OldfilePath!= NewfilePath)
                        File.Delete(OldfilePath);
                    }
                    catch { }
                    if (OldfilePathCover != string.Empty)
                        try
                        {
                            if (OldfilePathCover != NewfilePathCover)

                                File.Delete(OldfilePath);
                        }
                        catch { }

                }
                catch
                {
                    SqlCommand cmd = new SqlCommand("ROLLBACK", con);
                    cmd.ExecuteNonQuery();
                    LabelError.Text = "Ошибка обновления документа";
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