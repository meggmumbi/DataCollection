using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class RequestProgram : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = Config.ReturnNav();
                var campuses = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                campus.DataSource = campuses;
                campus.DataValueField = "No";
                campus.DataTextField = "Description";
                campus.DataBind();
                var domains = nav.programdomains;
                programDomain.DataSource = domains;
                programDomain.DataValueField = "Code";
                programDomain.DataTextField = "Description";
                programDomain.DataBind();
                List<string> programLevels = new List<string>();
                programLevels.Add("");
                programLevels.Add("Bachelors");
                programLevels.Add("Masters");
                programLevels.Add("Doctorate");
                programLevels.Add("Postgraduate");
                programLevels.Add("Diploma");
                programLevels.Add("Certificate");
                programLevel.DataSource = programLevels;
                programLevel.DataBind();
                institution.Text = Convert.ToString(Session["UniversityName"]);
            }
      
    }

        protected void apply_Click(object sender, EventArgs e)
        {
            try
            {
                string tCampus = campus.SelectedValue;
                string tProgramName = programName.Text.Trim();
                string tDomain = programDomain.SelectedValue;
                int tProgramLevel = programLevel.SelectedIndex;
                string tPaymentRef = paymentReference.Text.Trim();
                string response = new Config().ObjNav()
                    .ApplyForProgramAccreditation(Convert.ToString(Session["Code"]), tCampus, tProgramName, tDomain,
                        tProgramLevel, tPaymentRef);
                string[] info = response.Split('*');
                feedback.InnerHtml = "<div class='alert alert-"+info[0]+"'>"+info[1]+" </div>";

            }
            catch (Exception t)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>We encountered an error while processing your reques. Please try again later. "+t.Message+"</div>";
            }
        }
    }
}