using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace ShopPay
{
    /// <summary>
    /// Сводное описание для updateFavorite
    /// </summary>
    public class updateFavorite : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string _checked = context.Request.Params["check"].ToString();
            string id_doc=context.Request.Params["doc"].ToString();
            string user = context.User.Identity.Name;
            string SqlText = "insert into Docs_Favorits (id_doc,customer) values (@id_doc, @customer)";
            if (_checked=="false")
            {
                SqlText = "delete from Docs_Favorits where id_doc=@id_doc and customer=@customer";
            }

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SQLConnectionString"].ToString()))
            {
                con.Open();
                try
                {
                    SqlCommand cmd = new SqlCommand(SqlText, con);
                    cmd.Parameters.AddWithValue("id_doc", id_doc);
                    cmd.Parameters.AddWithValue("customer", user);
                    cmd.ExecuteNonQuery();
                }
                finally
                {
                    con.Close();
                }
            }



            context.Response.ContentType = "text/plain";
            context.Response.Write("updated");
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}