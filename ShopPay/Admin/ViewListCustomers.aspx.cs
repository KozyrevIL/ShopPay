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

namespace ShopPay.Account
{
    public partial class ViewListCustomers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ButtonSearch_Click(object sender, EventArgs e)
        {
            GridViewCustomers.DataBind();
        }
        protected void ButtonFilterClear_Click(object sender, EventArgs e)
        {
            FiltrMask.Text = string.Empty;
            GridViewCustomers.DataBind();
        }

    }
}