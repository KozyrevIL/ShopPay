using Microsoft.AspNet.Identity;
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
    public partial class viewer_doc : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.Params["iddoc"] != null)
                {
                    string id_doc = Request.Params["iddoc"].ToString();
                    string nameDoc = string.Empty;
                    string dateDoc = string.Empty;
                    string actualDoc = string.Empty;
                    string descDoc = string.Empty;
                    string contentDoc = string.Empty;
                    string priceDoc = string.Empty;
                    string cover = string.Empty;

                    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SQLConnectionString"].ToString()))
                    {
                        con.Open();
                        try
                        {
                            SqlCommand cmd = new SqlCommand(@"SELECT id_doc,id_section,name_doc,date_doc,issue_doc,num_doc,iif(isnull(isActual,0)=1,'Актуален','Неактуален') isActual,description,items,isnull(cover,'empty.jpg') cover,doc_content,[dbo].[Docs_GetPrice](id_doc,GETDATE()) doc_price FROM Docs_docs where id_doc=" + id_doc, con);

                            SqlDataReader sdr = cmd.ExecuteReader();
                            if (sdr.HasRows)
                            {
                                if (sdr.Read())
                                {
                                    nameDoc = sdr["name_doc"].ToString();
                                    dateDoc = sdr["date_doc"].ToString();
                                    actualDoc = sdr["isActual"].ToString();
                                    descDoc = sdr["description"].ToString();
                                    contentDoc = sdr["doc_content"].ToString();
                                    cover = sdr["cover"].ToString();
                                    priceDoc = sdr["doc_price"].ToString();
                                }
                            }
                            sdr.Close();
                        }
                        catch
                        { }
                        finally
                        {
                            con.Close();
                        }
                    }
                    ImageCover.ImageUrl = "~/ImageHandler.ashx?tp=cover&fn=" + cover;
                    NameDoc.Text = nameDoc;
                    DateDoc.Text = dateDoc;
                    ActualDoc.Text = actualDoc;
                    DescrDoc.Text = descDoc;
                    ContentDoc.Text = contentDoc;
                    PriceDoc.Text = priceDoc;

                    ButtonFavortite.OnClientClick = "updateFavorite('true'," + id_doc + ");";
                    ButtonCart.OnClientClick= "updateFavorite('cart'," + id_doc + ");";
                }
            }
        }

        protected void ButtonFavortite_Click(object sender, EventArgs e)
        {

        }

        protected void ButtonBasket_Click(object sender, EventArgs e)
        {

        }
    }
}