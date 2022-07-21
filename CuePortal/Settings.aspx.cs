using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class Settings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            string email = emailaddress.Text.Trim();
            string current = currentPassword.Text.Trim();
            string newPass = newPassword.Text.Trim();
            string confirmPass = confirmPassword.Text.Trim();
            feedback.InnerHtml = "";
            currentPassword.Text = "";
            newPassword.Text = "";
            confirmPassword.Text = "";
            if (current.Length < 4 || newPass.Length < 4 || confirmPass.Length < 4)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>All passwords must be at least 4 characters</div>";
            }
            else if (newPass != confirmPass)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>Password must be equal to confirm password</div>";
            }
            else
            {
                //change pass
                string status = new Config().ObjNav().FnResetPassword(email, current, newPass, confirmPass);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    feedback.InnerHtml = "<div class='alert alert-success'>Congratulations, Your password has been Reset</div>";
                }
                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "</div>";
            }
        }
    }
}