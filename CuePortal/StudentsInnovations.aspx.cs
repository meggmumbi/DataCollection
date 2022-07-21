using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class StudentsInnovations : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                var nav = Config.ReturnNav();

                var domains = nav.programdomains;

                domain.DataSource = domains;
                domain.DataValueField = "Code";
                domain.DataTextField = "Description";
                domain.DataBind();
                var campuses = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                campus.DataSource = campuses;
                campus.DataValueField = "No";
                campus.DataTextField = "Description";
                campus.DataBind();
            }
          
    }
        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            int tcategory = 1;// subdomain.SelectedIndex;
            string tdomain = domain.SelectedValue;
            string tdoi = "";
            string tsubdomain = "";
            string tcampus = campus.SelectedValue;
            int tpublicationType = 0;
            string ttitle = title.Text.Trim();
            string tdescription = "";
            string tlink = link.Text.Trim();
            string tpatentingOrganisation = patentingOrganisation.Text.Trim();
            string tcopyrightNo = copyrightNo.Text.Trim();
            string tpatentYear = patentYear.Text.Trim();
            string tauthors = authors.Text.Trim();
            string userCode = Convert.ToString(Session["Code"]);
            string password = Convert.ToString(Session["Password"]);
            bool hasErrors = false;
            int myYear = 0;
            try
            {
                if (tpatentYear.Length > 0)
                {
                    myYear = Convert.ToInt32(tpatentYear);

                }


            }
            catch (Exception t)
            {
                hasErrors = true;
                feedback.InnerHtml = "<div class='alert alert-danger'>Please enter a valid year for Patent / Copyright Year</div>";
            }
            if (!hasErrors)
            {
                string status = new Config().ObjNav()
              .AddStudentsResearch(tcategory, tdomain, tsubdomain, tcampus, tpublicationType, ttitle, tdescription, tlink,
                  tpatentingOrganisation, tcopyrightNo, myYear, tauthors, tdoi, userCode, password);
                string[] info = status.Split('*');
                if (status == "success")
                {
                    feedback.InnerHtml = "<div class='alert alert-success'>The Students Innovations was successfully Submitted</div>";
                }
                else
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + status + "</div>";
                }
            }


        }
        protected void deleteInnovation_Click(object sender, EventArgs e)
        {
            try
            {
                string tremoveinnovationCode = removeinnovationCode.Text.Trim();
                int mremoveinnovationCode = Convert.ToInt32(tremoveinnovationCode);
                bool status = new Config().ObjNav()
                   .DeleteStudentsResearch(mremoveinnovationCode, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
               if (status)
                {
                    feedback.InnerHtml = "<div class='alert alert-success'> The Student Innovation Details was successfully deleted  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {

                    feedback.InnerHtml = "<div class='alert alert-danger'> The Student Innovation Details could not be deleted.Kindly ensure that the Data collection period is still open<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}