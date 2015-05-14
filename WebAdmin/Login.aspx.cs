using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace WebAdmin
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.Page.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();
            }
        }

        protected void loginLinkBtn_Click(object sender, EventArgs e)
        {
            if (Membership.ValidateUser(txt_user.Text, txt_passw.Text))
                FormsAuthentication.RedirectFromLoginPage(txt_user.Text, false);
        }
    }
}