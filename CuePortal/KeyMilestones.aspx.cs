using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class KeyMilestones : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void SaveMilestone_Click(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string universityCode = Convert.ToString(Session["UniversityCode"]);
                string ttxtyear = "";
                try
                {
                    ttxtyear = txtyear.Text.Trim();
                    var thisyear = DateTime.Now.Year;
                    if (ttxtyear.Length !=4 && ttxtyear.Length > thisyear)
                    {
                        throw new Exception();
                    }

                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter Valid value for Year";
                }
                string ttxtmilestone = "";
                try
                {
                    ttxtmilestone = txtmilestone.Text.Trim();
                    if (ttxtmilestone.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the Key Milestone Description";
                }
                if (error)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    
                    string status = new Config().ObjNav()
                    .AddMilestone(universityCode, ttxtyear, ttxtmilestone);
                    string[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    if (info[0] == "success")
                    {
                        feedback.InnerHtml =
                            "<div class='alert alert-success'>The university milestone details was successfully Submitted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        feedback.InnerHtml =
                            "<div class='alert alert-danger'>The university milestone details details was not Submitted  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        protected void EditKeyMilstones(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string universityCode = Convert.ToString(Session["UniversityCode"]);
                int miletonecode =Convert.ToInt32(editcode.Text.Trim());
                string teditYear = "";
                try
                {
                    teditYear = editYear.Text.Trim();
                    if (teditYear.Length != 4)
                    {
                        throw new Exception();

                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter a Valid Year";
                }
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
                    message = "Please enter the Key Milestone Description";
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
                        .EditKeyMilestones(universityCode, miletonecode, teditYear, teditName, userCode, password);
                    string[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    if (info[0] == "success")
                    {
                        feedback.InnerHtml = "<div class='alert alert-success'>The University Milestones was successfully updated</div>";
                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>The University Milestones could not be updated</div>";
                    }
                }
            }
            catch (Exception)
            {

            }
        }
        protected void deleteKeyMilestone_Click(object sender, EventArgs e)
        {
            try
            {
                string tremovekeymilestoneCode = removekeymilestoneCode.Text.Trim();
                int mremovekeymilestoneCode = Convert.ToInt32(tremovekeymilestoneCode);
                string status = new Config().ObjNav()
                    .Deletekeymilestone(mremovekeymilestoneCode, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                string[] info = status.Split('*');
                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                if (status == "success")
                {
                    feedback.InnerHtml = "<div class='alert alert-success'> The University Key Milestones Details was successfully deleted  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {

                    feedback.InnerHtml = "<div class='alert alert-danger'> The UniversityKey Milestones Details could not be deleted.Kindly ensure that the Data collection period is still open<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

    }

}
