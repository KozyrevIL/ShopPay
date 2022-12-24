using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using ShopPay;
using ShopPay.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Roles_UsersAndRoles : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            // Bind the users and roles
            BindUsersToUserList();
            BindRolesToList();

            // Check the selected user's roles
            CheckRolesForSelectedUser();

            // Display those users belonging to the currently selected role
            DisplayUsersBelongingToRole();
        }
    }

    private void BindRolesToList()
    {
        // Get all of the roles
        var roleStore = new RoleStore<IdentityRole>(new ApplicationDbContext());
        var roleManager = new RoleManager<IdentityRole>(roleStore);
        List<IdentityRole> roles = roleManager.Roles.ToList();

        UsersRoleList.DataSource = roles;
        UsersRoleList.DataBind();

        RoleList.DataSource = roles;
        RoleList.DataBind();
    }

    #region 'By User' Interface-Specific Methods
    private void BindUsersToUserList()
    {
        // Get all of the user accounts
        var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
        
        UserList.DataSource = manager.Users.ToList();
        UserList.DataBind();
    }

    protected void UserList_SelectedIndexChanged(object sender, EventArgs e)
    {
        CheckRolesForSelectedUser(); 
    }

    private void CheckRolesForSelectedUser()
    {
        // Determine what roles the selected user belongs to
        var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();

        string selectedUserName = UserList.SelectedValue;
        IList<string> selectedUsersRoles = manager.GetRoles(manager.FindByName(selectedUserName).Id);

        // Loop through the Repeater's Items and check or uncheck the checkbox as needed
        foreach (RepeaterItem ri in UsersRoleList.Items)
        {
            // Programmatically reference the CheckBox
            CheckBox RoleCheckBox = ri.FindControl("RoleCheckBox") as CheckBox;

            // See if RoleCheckBox.Text is in selectedUsersRoles
            if (selectedUsersRoles.Contains<string>(RoleCheckBox.Text))
                RoleCheckBox.Checked = true;
            else
                RoleCheckBox.Checked = false;
        }
    }
    protected bool AddUserToRole(string UserName, string RoleName)
    {
        try
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var IUser = manager.FindByName(UserName);
            manager.AddToRole(IUser.Id, RoleName);
            return true;
        }
        catch 
        {
            return false;
        }
    }

    protected bool RemoveUserFromRole(string UserName, string RoleName)
    {
        try
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var IUser = manager.FindByName(UserName);
            manager.RemoveFromRole(IUser.Id, RoleName);

            return true;
        }
        catch
        {
            return false;
        }
    }


    protected void RoleCheckBox_CheckChanged(object sender, EventArgs e)
    {

        // Reference the CheckBox that raised this event
        CheckBox RoleCheckBox = sender as CheckBox;

        // Get the currently selected user and role
        string selectedUserName = UserList.SelectedValue;
        string roleName = RoleCheckBox.Text;



        // Determine if we need to add or remove the user from this role
        if (RoleCheckBox.Checked)
        {
            // Add the user to the role
            if (AddUserToRole(selectedUserName, roleName)) 
                ActionStatus.Text = string.Format("Пользователю {0} добавлена роль {1}.", selectedUserName, roleName);
            else
                ActionStatus.Text = string.Format("Ошибка добавления пользователю {0} роли {1}.", selectedUserName, roleName);

        }
        else
        {
            // Remove the user from the role
            if (RemoveUserFromRole(selectedUserName, roleName))
                ActionStatus.Text = string.Format("Пользователь {0} удален из роли {1}.", selectedUserName, roleName);
            else
                ActionStatus.Text = string.Format("Ошибка удалнения пользователя {0} из роли {1}.", selectedUserName, roleName);

        }

        // Refresh the "by role" interface
        DisplayUsersBelongingToRole();
    }
    #endregion

    #region 'By Role' Interface-Specific Methods
    protected void RoleList_SelectedIndexChanged(object sender, EventArgs e)
    {
        DisplayUsersBelongingToRole();
    }

    private void DisplayUsersBelongingToRole()
    {
        // Get the selected role
        string selectedRoleName = RoleList.SelectedValue;
        var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();

        var roleStore = new RoleStore<IdentityRole>(new ApplicationDbContext());
        var roleManager = new RoleManager<IdentityRole>(roleStore);

        // Get the list of usernames that belong to the role
        var usersBelongingToRole = roleManager.FindByName(selectedRoleName).Users;
        List<string> ListUsersInRole = new List<string>();
        foreach (var usr in usersBelongingToRole)
        {
            ListUsersInRole.Add(manager.FindById(usr.UserId).UserName);
        }
        // Bind the list of users to the GridView
        RolesUserList.DataSource = ListUsersInRole;
        RolesUserList.DataBind();
    }

    protected void RolesUserList_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        // Get the selected role
        string selectedRoleName = RoleList.SelectedValue;

        // Reference the UserNameLabel
        Label UserNameLabel = RolesUserList.Rows[e.RowIndex].FindControl("UserNameLabel") as Label;

        // Remove the user from the role
        if (RemoveUserFromRole(UserNameLabel.Text, selectedRoleName))
        {
            // Refresh the GridView
            DisplayUsersBelongingToRole();

            // Display a status message
            ActionStatus.Text = string.Format("Пользователь {0} удален из рошли {1}.", UserNameLabel.Text, selectedRoleName);

            // Refresh the "by user" interface
            CheckRolesForSelectedUser();
        }
        else
        {
            ActionStatus.Text = "Ошибка !!!";
        }

    }

    protected void AddUserToRoleButton_Click(object sender, EventArgs e)
    {
        // Get the selected role and username
        string selectedRoleName = RoleList.SelectedValue;
        string userNameToAddToRole = UserNameToAddToRole.Text;

        // Make sure that a value was entered
        if (userNameToAddToRole.Trim().Length == 0)
        {
            ActionStatus.Text = "You must enter a username in the textbox.";
            return;
        }

        // Make sure that the user exists in the system
        MembershipUser userInfo = Membership.GetUser(userNameToAddToRole);
        if (userInfo == null)
        {
            ActionStatus.Text = string.Format("The user {0} does not exist in the system.", userNameToAddToRole);
            return;
        }

        // Make sure that the user doesn't already belong to this role
        if (Roles.IsUserInRole(userNameToAddToRole, selectedRoleName))
        {
            ActionStatus.Text = string.Format("User {0} already is a member of role {1}.", userNameToAddToRole, selectedRoleName);
            return;
        }

        // If we reach here, we need to add the user to the role
        Roles.AddUserToRole(userNameToAddToRole, selectedRoleName);

        // Clear out the TextBox
        UserNameToAddToRole.Text = string.Empty;

        // Refresh the GridView
        DisplayUsersBelongingToRole();

        // Display a status message
        ActionStatus.Text = string.Format("User {0} was added to role {1}.", userNameToAddToRole, selectedRoleName);

        // Refresh the "by user" interface
        CheckRolesForSelectedUser();
    }
    #endregion
}