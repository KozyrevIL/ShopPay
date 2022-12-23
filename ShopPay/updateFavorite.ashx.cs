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

            string SqlText = string.Empty;
            string result = string.Empty;

            switch (_checked)
            {
                case "true":
                    SqlText = "insert into Docs_Favorits (id_doc,customer) values (@id_doc, @customer)";
                    result = " Добавлено в Избранное";
                    break;
                case "false":
                    SqlText = "delete from Docs_Favorits where id_doc=@id_doc and customer=@customer";
                    result = " Удалено из Избранного";
                    break;
                case "cart":
                    SqlText = @"IF NOT EXISTS (SELECT * FROM Docs_cart WHERE id_doc=@id_doc and customer=@customer)
 insert into Docs_cart (id_doc,customer,qty_time) values (@id_doc, @customer, 1)";
                    result = " Добавлено в Корзину";
                    break;
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
//                    result = "Документ добавлен " + result;
                }
                catch
                {
                    result = "Ошибка!";
                }
                finally
                {
                    con.Close();
                }
            }



            context.Response.ContentType = "text/plain";
            context.Response.Write(result);
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