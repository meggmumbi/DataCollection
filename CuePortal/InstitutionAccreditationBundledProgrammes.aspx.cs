using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class InstitutionAccreditationBundledProgrammes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void SubmitProgrammeApplication_Click(object sender, EventArgs e)
        {
            try
            {
                string UniversityCode = Convert.ToString(Session["UniversityCode"]);
                // string universityname = Convert.ToString(Session["applicationNo"]);
                string applicationNo = Request.QueryString["applicationNo"];

                string response = new Config().ObjNav().FnSendMailProgramApplication(UniversityCode, applicationNo);
                string[] info = response.Split('*');
                if (info[0] == "success")
                {
                    feedbackdata.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                    "setTimeout(function() { window.location.replace('Accreditation.aspx') }, 15000);", true);
                }
            }
            catch (Exception ex)
            {
                feedbackdata.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void removeprogram_Click(object sender, EventArgs e)
        {
            try
            {
                string UniversityCode = Convert.ToString(Session["UniversityCode"]);
                string applicationNo = programNo.Text;
                string insNo = "";

                string response = new Config().ObjNav().FnRemoveSelectedPrograms(UniversityCode, insNo, applicationNo);
                string[] info = response.Split('*');
                if (info[0] == "success")
                {
                    feedbackdata.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                feedbackdata.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void previous_Click(object sender, EventArgs e)
        {
            Response.Redirect("Institution.aspx");
        }
    }
}