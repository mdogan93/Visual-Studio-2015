using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity;
using Microsoft.Owin.Security;

public partial class Pages_Account_Register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        UserStore<IdentityUser> userStore = new UserStore<IdentityUser>();
        userStore.Context.Database.Connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["PixAdvertConnectionString"].ConnectionString;


        UserManager<IdentityUser> manager = new UserManager<IdentityUser>(userStore);

        IdentityUser user = new IdentityUser();

        user.UserName=txtUserName.Text;
        if(txtPassword.Text == txtConfirmPassword.Text)
        {
            try
            {
                // Create user object 
                IdentityResult result = manager.Create(user, txtPassword.Text);
                if (result.Succeeded)
                {

                    UserInfoModel model = new UserInfoModel();
                    WebShop_UserInformation info = new WebShop_UserInformation {
                        Address = txtAddress.Text,
                        FirstName = txtFirstName.Text,
                        LastName = txtLastName.Text,
                        PostalCode = Convert.ToInt32(txtPostalCode.Text),
                        GUID = user.Id
                    };
                    model.InsertUserInformation(info);


                    // store user in db 
                    var authenticationManager = HttpContext.Current.GetOwinContext().Authentication;
                    // set login new user by cookie
                    var userIdentity = manager.CreateIdentity(user, DefaultAuthenticationTypes.ApplicationCookie);

                    // login and redirect
                    authenticationManager.SignIn(new AuthenticationProperties(), userIdentity);

                    Response.Redirect("~/Index.aspx");
                
                }
                else
                {
                    litStatusMessage.Text = result.Errors.FirstOrDefault();
                }
            }
            catch
            {
                litStatusMessage.Text = e.ToString();
            }
        }
 

    }


}