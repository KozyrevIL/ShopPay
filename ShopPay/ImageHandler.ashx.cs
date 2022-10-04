using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace ShopPay
{
    /// <summary>
    /// Сводное описание для ImageHandler
    /// </summary>
    public class ImageHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string fileName = context.Request.Params["fn"].ToString();
            string fileStorage = HttpContext.Current.Server.MapPath("~/Upload/ImagesDocs");
            string fullFileName = Path.Combine(fileStorage, fileName);
            FileInfo fileInfo = new FileInfo(fullFileName);
            context.Response.Clear();
            context.Response.AddHeader("Content-Disposition", "attachment; filename=" + fileInfo.Name);
            context.Response.AddHeader("Content-Length", fileInfo.Length.ToString());
            context.Response.ContentType = "application/octet-stream";
            context.Response.WriteFile(fileInfo.FullName);
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