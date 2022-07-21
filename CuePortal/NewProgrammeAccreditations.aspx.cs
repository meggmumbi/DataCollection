using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace CicPortal
{
    public partial class NewProgrammeAccreditations : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = Config.ReturnNav();
                var domains = nav.programdomains;
                programDomain.DataSource = domains;
                programDomain.DataValueField = "Code";
                programDomain.DataTextField = "Description";
                programDomain.DataBind();

                List<string> programLevels = new List<string>();
                programLevels.Add("--Select--");
                programLevels.Add("Bachelors");
                programLevels.Add("Masters");
                programLevels.Add("Doctorate");
                programLevels.Add("Postgraduate");
                programLevels.Add("Diploma");
                programLevels.Add("Certificate");
                programLevel.DataSource = programLevels;
                programLevel.DataBind();
            }
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string SubmitSelectedCategories(List<ProgramsModel> targetNumber)
        {

            HtmlGenericControl NewControl = new HtmlGenericControl();
            var results = (dynamic)null;
            int category = 0;
            try
            {
                if (targetNumber == null)
                {
                    targetNumber = new List<ProgramsModel>();
                }
                foreach (ProgramsModel target in targetNumber)
                {

                    string programNo = target.TargetNumber;
                    string applicationNo = target.ApplicationNo;
                    var UniversityCode = HttpContext.Current.Session["UniversityCode"].ToString();
                    //var applicationNo = HttpContext.Current.Session["applicationNo"].ToString();

                    string status = new Config().ObjNav().FnSubmitSelectedPrograms(UniversityCode, applicationNo, programNo);
                    string[] info = status.Split('*');
                    NewControl.ID = "feedback";
                    NewControl.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    results = info[0];
                }

            }
            catch (Exception ex)
            {
                results = ex.Message;
            }
            return results;
        }

        protected void addprogramDetails_Click(object sender, EventArgs e)
        {
            try
            {
                string tdesc = programName.Text;
                string tdomain = programDomain.SelectedValue;
                int tprogramLevel = Convert.ToInt32(programLevel.SelectedIndex);
                decimal tduration = Convert.ToDecimal(duration.Text);
                string applicationNo = Request.QueryString["applicationNo"].Trim();
                string unicode = Convert.ToString(Session["UniversityCode"]);

                string status = new Config().ObjNav().FnNewProgrammeDetails(applicationNo, unicode, tdesc, tprogramLevel, tdomain, tduration);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                        generalFeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + "</div>";
                }
                else
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "</div>";
                }
            }
            catch (Exception y)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + y.Message + "</div>";
            }
        }

        protected void previous_Click(object sender, EventArgs e)
        {
            string applicationNo = Request.QueryString["applicationNo"].Trim();
            Response.Redirect("InstitutionAccreditationBundledProgrammes.aspx?applicationNo=" + applicationNo);
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
                    generalFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
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
                    generalFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                    "setTimeout(function() { window.location.replace('Accreditation.aspx') }, 15000);", true);
                }
            }
            catch (Exception ex)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}