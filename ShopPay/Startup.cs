using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(ShopPay.Startup))]
namespace ShopPay
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
