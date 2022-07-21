using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class Sponsors : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //try
            //{
            //    string entryNo = Request.QueryString["entry"];

            //    if (!(string.IsNullOrEmpty(entryNo)))
            //    {
            //        int entry = Convert.ToInt32(entryNo);
            //        bool deleted = new Config().ObjNav()
            //         .DeleteSponsors(entry, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
            //        if (deleted)
            //        {
            //            feedback.InnerHtml = "<div class='alert alert-success'>The University Sponsor details was successfully deleted</div>";
            //        }
            //    }

            //}
            //catch (Exception y)
            //{

            //}

        }
        protected void SaveSponsor_Click(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string universityCode = Convert.ToString(Session["UniversityCode"]);
                string ttxtsponsor = "";
                try
                {
                    ttxtsponsor = txtsponsor.Text.Trim();
                    if (ttxtsponsor.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the Sponsor Name";
                }
                if (error)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    string status = new Config().ObjNav()
                    .AddSponsors(universityCode, ttxtsponsor);
                    string[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    if (info[0] == "success")
                    {
                        feedback.InnerHtml =
                            "<div class='alert alert-success'>The university Sponsor details was successfully submitted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        feedback.InnerHtml =
                            "<div class='alert alert-danger'>The university Sponsor details  was not submitted  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        protected void EditSponsors(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string universityCode = Convert.ToString(Session["UniversityCode"]);
                string teditName = "";
                try
                {
                    teditName = editName.Text.Trim();
                    if (teditName.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the Sponsor Name";
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
                        .EditSponsor(universityCode, teditName, userCode, password);
                    string[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    if (info[0] == "success")
                    {
                        feedback.InnerHtml = "<div class='alert alert-success'>The University Sponsor Details was successfully updated</div>";
                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>The  University Sponsor Details could not be updated</div>";
                    }
                }
            }
            catch (Exception)
            {

            }
        }
        protected void deleteSponsor_Click(object sender, EventArgs e)
        {
            try
            {
                string tremovesponsorCode = removesponsorCode.Text.Trim();
                int mremovesponsorCode = Convert.ToInt32(tremovesponsorCode);
                bool status = new Config().ObjNav()
                    .DeleteSponsors(mremovesponsorCode, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                if (status == true)
                {
                    feedback.InnerHtml = "<div class='alert alert-success'> The University Sponsor Details was successfully deleted  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {

                    feedback.InnerHtml = "<div class='alert alert-danger'> The University Sponsor Details could not be deleted.Kindly ensure that the Datatc collection period is still open<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}