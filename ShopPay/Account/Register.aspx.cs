using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using ShopPay.App_Code;
using ShopPay.Models;
using System;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace ShopPay.Account
{
    public partial class Register : Page
    {
        private string GetRoleClient()
        {
            try
            {
                var roleStore = new RoleStore<IdentityRole>(new ApplicationDbContext());
                var roleManager = new RoleManager<IdentityRole>(roleStore);
                if (roleManager.FindByName("Client") == null)
                {
                    roleManager.Create(new IdentityRole("Client"));
                }
                return "Client";
            }
            catch
            {
                return string.Empty;
            }
            
        }
        protected void CreateUser_Click(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var signInManager = Context.GetOwinContext().Get<ApplicationSignInManager>();
            var user = new ApplicationUser() { UserName = Email.Text, Email = Email.Text };
            IdentityResult result = manager.Create(user, Password.Text);
            
            if (result.Succeeded)
            {
                // Добавляем Client по умолчанию ***********************************
                var IUser = manager.FindByName(Email.Text);
                string roleClient = GetRoleClient();
                if (roleClient!=string.Empty)  manager.AddToRole(IUser.Id, "Client");
                //******************************************************************
                // Дополнительные сведения о включении подтверждения учетной записи и сброса пароля см. на странице https://go.microsoft.com/fwlink/?LinkID=320771.
                //string code = manager.GenerateEmailConfirmationToken(user.Id);
                //string callbackUrl = IdentityHelper.GetUserConfirmationRedirectUrl(code, user.Id, Request);
                //manager.SendEmail(user.Id, "Подтверждение учетной записи", "Подтвердите вашу учетную запись, щелкнув <a href=\"" + callbackUrl + "\">здесь</a>.");

                // Запишем дополнительные данные пользователя
                ClassCustomer classCustomer = new ClassCustomer(Email.Text,Context);
                classCustomer.customerInfo.FIO = TextBoxNameCustomer.Text;
                classCustomer.customerInfo.phone = TextBoxPhone.Text;
                classCustomer.customerInfo.Info = TextBoxInfo.Text;
                classCustomer.customerInfo.UpdateCustomerInfo(Email.Text);

                signInManager.SignIn( user, isPersistent: false, rememberBrowser: false);
                IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
            }
            else 
            {
                ErrorMessage.Text = result.Errors.FirstOrDefault();
            }
        }
    }
}