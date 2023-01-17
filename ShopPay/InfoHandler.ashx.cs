using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Net.Configuration;
using System.Web.UI;


namespace ShopPay
{
    /// <summary>
    /// Сводное описание для InfoHandler
    /// </summary>
    public class InfoHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string typeInfo = context.Request.Params["info"].ToString();
            string result = string.Empty;
            switch (typeInfo)
            {
                case "qtyCart":
                    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SQLConnectionString"].ToString()))
                    {
                        con.Open();
                        try
                        {
                            SqlCommand cmd = new SqlCommand("select count(*) from Docs_Cart where customer=@customer ", con);
                            cmd.Parameters.AddWithValue("customer", HttpContext.Current.User.Identity.Name);
                            result = cmd.ExecuteScalar()?.ToString() ?? "0";
                        }
                        finally
                        {
                            con.Close();
                        }
                    }

                    break;
            }

            context.Response.Write(result);
            context.Response.End();
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