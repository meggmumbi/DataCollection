using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class VisionMission : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    protected void SaveMission_Click(object sender, EventArgs e)
    {
            try
            {
                string message = "";
                bool error = false;
                string universityCode = Convert.ToString(Session["UniversityCode"]);
                string tvision = "";
                try
                {
                    tvision = txtvission.Text.Trim();
                    if (tvision.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the University Vision";
                }
                string tmission = "";
                try
                {
                    tmission = txtmission.Text.Trim();
                    if (tmission.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the University Mission";
                }
                string taims = "";
                try
                {
                    taims = txtaims.Text.Trim();
                    if (taims.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the University Aims/Objectives";
                }
                if (error)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    string userCode = Convert.ToString(Session["Code"]);
                    string password = Convert.ToString(Session["Password"]);
                    string status = new Config().ObjNav().AddMissionDetails(universityCode, tvision, tmission, taims);
                    string[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    if (info[0] == "success")
                    {
                        feedback.InnerHtml =
                         "<div class='alert alert-success'>The University mission & vission details was successfully updated <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        feedback.InnerHtml =
                            "<div class='alert alert-danger'>The University mission & vission details was not updated  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

     }
        protected void UpdateVissionMission_Click(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string universityCode = Convert.ToString(Session["UniversityCode"]);
                string tvision = "";
                try
                {
                    tvision = editvission.Text.Trim();
                    if (tvision.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the University Vision";
                }
                string tmission = "";
                try
                {
                    tmission = editmission.Text.Trim();
                    if (tmission.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the University Mission";
                }
                string taims = "";
                try
                {
                    taims = editaims.Text.Trim();
                    if (taims.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the University Aims/Objectives";
                }
                if (error)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    string userCode = Convert.ToString(Session["Code"]);
                    string password = Convert.ToString(Session["Password"]);
                    string status = new Config().ObjNav().AddMissionDetails(universityCode, tvision, tmission, taims);
                    string[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    if (info[0] == "success")
                    {
                        feedback.InnerHtml =
                         "<div class='alert alert-success'>The University mission & vission details was successfully updated <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        feedback.InnerHtml =
                            "<div class='alert alert-danger'>The University mission & vission details was not updated  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
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