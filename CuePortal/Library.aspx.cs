using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class Library : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


            if (!IsPostBack)
            {
                var nav = Config.ReturnNav();
                var campuses = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                campus.DataSource = campuses;
                campus.DataTextField = "Description";
                campus.DataValueField = "No";
                campus.DataBind();

                var teditcampus = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                editcampus.DataSource = teditcampus;
                editcampus.DataTextField = "Description";
                editcampus.DataValueField = "No";
                editcampus.DataBind();
            }


        }
        protected void previous_Click(object sender, EventArgs e)
        {
            int step = 1;
            try
            {
                step = Convert.ToInt32(Request.QueryString["step"].Trim());
            }
            catch (Exception)
            {
                step = 1;
            }
            step -= 1;
            Response.Redirect("Library.aspx?step=" + step);
        }
        protected void next_Click(object sender, EventArgs e)
        {
            int step = 1;
            try
            {
                step = Convert.ToInt32(Request.QueryString["step"].Trim());
            }
            catch (Exception)
            {
                step = 1;
            }
            step += 1;
            Response.Redirect("Library.aspx?step=" + step);
        }
        protected void deleteLibrary_Click(object sender, EventArgs e)
        {
            try
            {
                string tremoveLibraryCode = removeLibraryCode.Text.Trim();
                int mLibraryCode = Convert.ToInt32(tremoveLibraryCode);
                string status = new Config().ObjNav()
                          .DeleteLibrary(mLibraryCode, Session["Code"].ToString(), Session["Password"].ToString());
                string[] info = status.Split('*');
                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        protected void addLibrary_Click(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string tcampus = "";
                try
                {
                    tcampus = campus.SelectedValue;
                    if (tcampus.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please select the Campus Name";
                }
                string tdescription = "";
                try
                {
                    tdescription = description.Text.Trim();
                    if (tdescription.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the Library Name/Description";
                }
                string tsittingCapacity = "";
                try
                {
                    tsittingCapacity = sittingCapacity.Text.Trim();
                    if (tsittingCapacity.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the Library Sitting Capacity";
                }
             
               
                int tnoOfVolumes = 0;
                try
                {
                    tnoOfVolumes = Convert.ToInt32(noOfVolumes.Text.Trim());
                    if (tnoOfVolumes < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the Library No. of Volumes";
                }

                int tnoOfTitles = 0;
                try
                {
                    tnoOfTitles = Convert.ToInt32(noOfTitles.Text.Trim());
                    if (tnoOfTitles < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please Enter the Library No. of Titles";
                }
                string tbandwidth = "";
                try
                {
                    tbandwidth = bandwidth.Text.Trim();
                    if (tbandwidth.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the Library Bandwidth Allocation";
                }
                int tnoOfStaff = 0;
                try
                {
                    tnoOfStaff = Convert.ToInt32(noOfStaff.Text.Trim());
                    if (tnoOfStaff < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the Number of Library Staff Working in the Library";
                }
                
                int tcomputers = 0;
                try
                {
                    tcomputers = Convert.ToInt32(computers.Text.Trim());
                    if (tcomputers < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the No. of Computers in the Library";
                }
                string tdataccess = "";
                try
                {
                    tdataccess = dataccess.Text.Trim();
                    if (tdataccess.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the number of Active Data Access Points";
                }
                bool tadvisorycommittee = false;

                if (advisorycommittee.Checked)
                {
                    tadvisorycommittee = true;
                }

                bool tmanagementcommittee = false;

                if (managementcommittee.Checked)
                {
                    tmanagementcommittee = true;
                }

                bool tantiPlagiarism = false;

                if (antiPlagiarism.Checked)
                {
                    tantiPlagiarism = true;
                }
                bool tdigitalRepository = false;

                if (digitalRepository.Checked)
                {
                    tdigitalRepository = true;
                }

                bool tsecuritysystem = false;

                if (securitysystem.Checked)
                {
                    tsecuritysystem = true;
                }
                bool toffcampussystem = false;

                if (offcampussystem.Checked)
                {
                    toffcampussystem = true;
                }
                bool topac = false;

                if (opac.Checked)
                {
                    topac = true;
                }
                if (error)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    string userCode = Convert.ToString(Session["Code"]);
                    string password = Convert.ToString(Session["Password"]);
                    string status = new Config().ObjNav()
                      .AddLibrary(tcampus, tdescription, tsittingCapacity,tnoOfVolumes, tnoOfTitles, tbandwidth, tnoOfStaff, tcomputers,
                          tdataccess, tmanagementcommittee, tadvisorycommittee, tantiPlagiarism, tdigitalRepository, tsecuritysystem, toffcampussystem, topac,userCode, password);
                    string[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    if (info[0] == "success")
                    {

                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>" + status + "</div>";
                    }
                 }
                
            }
            catch (Exception y)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + y.Message + "</div>";

            }

        }
     
        protected void EditLibrary(object sender, EventArgs e)
        {
            string universityCode = Convert.ToString(Session["UniversityCode"]);
            string teditcampus = editcampus.SelectedValue;
            string teditDescription = editdescription.Text.Trim();
            string teditSitting = editSitting.Text.Trim();
            string teditfunctional = editfunctional.Text.Trim();
            int teditVolume = Convert.ToInt32(editVolume.Text.Trim());
            int teditTitle =Convert.ToInt32(editTitle.Text.Trim());
           // string teditService = editService.Text.Trim();
            string teditbandwith = editbandwith.Text.Trim();
            int teditStaff =Convert.ToInt32(editStaff.Text.Trim());
            string teditQualification = editQualification.Text.Trim();
            int teditComputers =Convert.ToInt32(editComputers.Text.Trim());
            string teditAccespoints = editAccespoints.Text.Trim();
            bool teditlibrarycommittee = false;

            if (editlibrarycommittee.Checked)
            {
                teditlibrarycommittee = true;
            }

            bool teditlibraryadvisorycommittee = false;

            if (editlibraryadvisorycommittee.Checked)
            {
                teditlibraryadvisorycommittee = true;
            }
            bool teditantiplagiarism = false;

            if (editantiplagiarism.Checked)
            {
                teditantiplagiarism = true;
            }
            bool teditdigitalrepo = false;

            if (editdigitalrepo.Checked)
            {
                teditdigitalrepo = true;
            }

            bool teditsecurity = false;

            if (editsecurity.Checked)
            {
                teditsecurity = true;
            }
            bool teditoffcampussystem = false;

            if (editoffcampussystem.Checked)
            {
                teditoffcampussystem = true;
            }
            bool teditopacs = false;

            if (editopacs.Checked)
            {
                teditopacs = true;
            }
            string userCode = Convert.ToString(Session["Code"]);
            string password = Convert.ToString(Session["Password"]);
            string status = new Config().ObjNav()
                .EditLibrary(universityCode, teditcampus, teditDescription, teditSitting, teditfunctional, teditVolume, teditTitle, teditbandwith, teditStaff, teditQualification,
                teditComputers, teditAccespoints, teditlibrarycommittee, teditlibraryadvisorycommittee, teditantiplagiarism, teditdigitalrepo, teditsecurity, teditoffcampussystem, teditopacs,userCode, password);
            string[] info = status.Split('*');
            feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            if (info[0] == "success")
            {
                feedback.InnerHtml = "<div class='alert alert-success'>The University Library Details were successfully Updated. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            else
            {
                feedback.InnerHtml = "<div class='alert alert-success'>The University Library Details were not successfully Updated. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
     
    }
}
  