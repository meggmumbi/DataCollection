using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class Affliations : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = Config.ReturnNav();
                var countries = nav.countries;
                affiliationcountry.DataSource = countries;
                affiliationcountry.DataValueField = "Code";
                affiliationcountry.DataTextField = "Name";
                affiliationcountry.DataBind();

                editaffiliationscountry.DataSource = countries;
                editaffiliationscountry.DataValueField = "Code";
                editaffiliationscountry.DataTextField = "Name";
                editaffiliationscountry.DataBind();

            }
        }
        protected void SaveAffiliations_Click(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string universityCode = Convert.ToString(Session["UniversityCode"]);
                string country = affiliationcountry.SelectedValue;
                string ttxtaffiliations = "";
                try
                {
                    ttxtaffiliations = txtaffiliations.Text.Trim();
                    if (ttxtaffiliations.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the Affiliation/Linkages & Collaboration";
                }
                string torganisationname = "";
                try
                {
                    torganisationname = organisationname.Text.Trim();
                    if (torganisationname.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter a valid value for the Organisation Name";
                }
                if (error)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    string status = new Config().ObjNav()
                    .AddAffiliations(universityCode, ttxtaffiliations, country, torganisationname);
                    string[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    if (info[0] == "success")
                    {
                        feedback.InnerHtml =
                            "<div class='alert alert-success'>The university affiliations details was successfully updated <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        feedback.InnerHtml =
                            "<div class='alert alert-danger'>The university affiliations details details was not updated  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        protected void deleteAffiliation_Click(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string tremoveaffiliationCode = removeaffiliationCode.Text.Trim();
                int mremoveaffiliationCode = Convert.ToInt32(tremoveaffiliationCode);
                bool status = new Config().ObjNav()
                    .DeleteAffiliations(mremoveaffiliationCode, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                //string[] info = status.Split('*');
                //feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                if (status == true)
                {
                    feedback.InnerHtml = "<div class='alert alert-success'> The University Affiliation Details was successfully deleted  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {

                    feedback.InnerHtml = "<div class='alert alert-success'> The University Affiliation Details could not be deleted.Kindly ensure that the Datatc collection period is still open<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void EditAffiliations_Click(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string universityCode = Convert.ToString(Session["UniversityCode"]);
                int teditaffiliationcode = Convert.ToInt32(editaffiliationcode.Text.Trim());
                string teditorganisationname = editorganisationname.Text.Trim();
                string teditaffiliationscountry = editaffiliationscountry.SelectedValue;
                string teditAffiliation = "";
                try
                {
                    teditAffiliation = editAffiliation.Text.Trim();
                    if (teditAffiliation.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the Affiliation/Linkages & Collaboration";
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
                        .EditAffiliations(universityCode, teditaffiliationcode, teditAffiliation, teditAffiliation, teditorganisationname, userCode, password);
                    string[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    if (info[0] == "success")
                    {
                        feedback.InnerHtml = "<div class='alert alert-success'>The University Affiliations was successfully updated</div>";
                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>The University Affiliations could not be updated</div>";
                    }
                }

            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}


