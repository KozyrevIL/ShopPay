using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using ShopPay.Models;

namespace ShopPay.Account
{
    public partial class ManageRoles : System.Web.UI.Page
    {
        private List<IdentityRole> LoadListRoles()
        {
            var roleStore = new RoleStore<IdentityRole>(new ApplicationDbContext());
            var roleManager = new RoleManager<IdentityRole>(roleStore);
            return roleManager.Roles.ToList();

        }
        protected void Page_Load(object sender, EventArgs e)
        {
            GridRoles.DataSource = LoadListRoles();
            GridRoles.DataBind();
        }

        protected void BtnAddRole_Click(object sender, EventArgs e)
        {
            var roleStore = new RoleStore<IdentityRole>(new ApplicationDbContext());
            var roleManager = new RoleManager<IdentityRole>(roleStore);
            var newnRole = new IdentityRole(TextRole.Text);
            if (!roleManager.RoleExists(newnRole.Name))
            {
                roleManager.Create(newnRole);
            }
            GridRoles.DataSource = LoadListRoles();
            GridRoles.DataBind();
        }

        protected void GridRoles_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }
    }
}