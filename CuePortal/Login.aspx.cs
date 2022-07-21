using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Services.Protocols;
using System.Web.UI;
using System.Web.UI.WebControls;



namespace CicPortal
{
    public partial class Login : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Unnamed1_Click(object sender, EventArgs e)
        {


        }

        protected void login_Click(object sender, EventArgs e)
        {
            try
            {
                string mUsername = username.Text.Trim();
                string mPassword = password.Text.Trim();
                bool error = false;
                if (mUsername.Length <1)
                {
                    error = true;
                    feedback.InnerHtml = "<div class='alert alert-danger'>Please Email address cannot be Empty</div>";
                }
                if (mPassword.Length < 4)
                {
                    error = true;
                    feedback.InnerHtml = "<div class='alert alert-danger'>Please input a Correct Password to Access the System</div>";
                }
                if (!error)
                {
                    bool exists = false;
                    bool accountactivated = false;
                    var nav = Config.ReturnNav();
                    var users = nav.UniversityUsers.Where(r => r.Authentication_Email == mUsername && r.Password_Value == mPassword && r.State == "Enabled" && r.UniversityCode!="");
                    foreach (var user in users)
                    {
                        if (user.PasswordChanged == true)
                        {
                            exists = true;
                            accountactivated = true;
                            Session["Name"] = user.User_Name;
                            Session["EmailAddress"] = user.Authentication_Email;
                            Session["Code"] = user.Entry_No;
                            Session["Password"] = user.Password_Value;
                            Session["UserType"] = user.UserType;
                            Session["UniversityCode"] = user.UniversityCode;
                            Session["UniversityName"] = user.University_Name;
                            Session["type"] = "old";
                            Session["InstitutionStatus"] = user.Instiution_Status;
                            Response.Redirect("ChooseService.aspx");
                        }
                        else
                        {
                            exists = true;
                            accountactivated = true;
                            Session["Name"] = user.User_Name;
                            Session["Code"] = user.Entry_No;
                            Session["EmailAddress"] = user.Authentication_Email;
                            Session["Password"] = user.Password_Value;
                            Session["UserType"] = user.UserType;
                            Session["UniversityCode"] = user.UniversityCode;
                            Session["UniversityName"] = user.University_Name;
                            Session["type"] = "old";
                            Response.Redirect("ChangePassword.aspx");
                        }
                    }
                    if (!exists)
                    {
                        var users3 = nav.UniversityUsers.Where(r => r.Authentication_Email == mUsername && r.Password_Value == mPassword && r.State == "Disabled" && r.UniversityCode != "");
                        foreach (var user in users3)
                        {
                            feedback.InnerHtml = "<div class='alert alert-danger'>The University User Account with the given Credentials was Deactivated.Kindly Contact CUE for Account Activation</div>";

                        }
                    }
                    if (!exists && !accountactivated)
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>The University User Account with the given Credentials does not exist.Kindly Fill in all the details in the Account Request form to Request for your Account Creation</div>";
                    }
                }

            }
            catch (Exception ex)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>We experienced an error while Login you in. Kindly try again Later.</div>";

            }
        }
    }
}