using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class ProgrammeAccreditationMessage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string AssitanceRequest(string tuseremailaddress, string tcueemailaddress, string temailsubject, string temailassistance)
        {
            var results = (dynamic)null;
            try
            {

                var userCode = HttpContext.Current.Session["Code"].ToString();
                var password = HttpContext.Current.Session["Password"].ToString();
                string status = new Config().ObjNav().FnProgrammeUserHelpEmailRequest(userCode, password, tuseremailaddress, temailsubject, temailassistance);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    results = info[0];
                }
                else
                {
                    results = info[1];
                }

            }
            catch (Exception ex)
            {
                results = ex.Message;
            }
            return results;
        }

        protected void sendMessage_Click(object sender, EventArgs e)
        {
            try
            {
                var userCode = Convert.ToString( Session["Code"]);
                var password = Convert.ToString(Session["Password"]);
                var tuseremailaddress = Convert.ToString(Session["EmailAddress"]);
                string temailsubject = messageSubject.Text.Trim();
                string temailassistance = messageDescription.Text.Trim();

                string status = new Config().ObjNav().FnProgrammeUserHelpEmailRequest(userCode, password, tuseremailaddress, temailsubject, temailassistance);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    messagefeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + "</div>";
                }
                else
                {
                    messagefeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "</div>";
                }
            }
            catch(Exception m)
            {
                messagefeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + "</div>";
            }
        }

        protected void homepage_Click(object sender, EventArgs e)
        {
            Response.Redirect("Accreditation.aspx");
        }
    }
}