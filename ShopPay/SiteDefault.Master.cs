﻿using Microsoft.AspNet.Identity;
using ShopPay.App_Code;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ShopPay
{
    public partial class SiteDefault : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            section_admin.Visible = (new ClassCustomer(Context.User.Identity.GetUserName(), Context)).ExistsRole("Administrator");
        }
    }
}