using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class Schools : System.Web.UI.Page
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
            //         .DeleteSchools(entry, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
            //        if (deleted)
            //        {
            //            feedback.InnerHtml = "<div class='alert alert-success'>The University Schoool details was successfully deleted</div>";
            //        }
            //    }

            //}
            //catch (Exception y)
            //{

            //}

        }
        protected void SaveSchool_Onclick(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string universityCode = Convert.ToString(Session["UniversityCode"]);
             
                string ttxtschool = "";
                try
                {
                    ttxtschool = txtschool.Text.Trim();
                    if (ttxtschool.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the School/Faculty or Institute Name";
                }
                if (error)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    string status = new Config().ObjNav()
                    .AddschoolFaculties(universityCode, ttxtschool);
                    string[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    if (info[0] == "success")
                    {
                        feedback.InnerHtml =
                            "<div class='alert alert-success'>The University School/Faculty or Institute details was successfully Submitted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        feedback.InnerHtml =
                            "<div class='alert alert-danger'>The university School/Faculty or Institute  details was not updated  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        protected void EditSchool_Click(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string universityCode = Convert.ToString(Session["UniversityCode"]);
                int teditschoolcode = Convert.ToInt32(editschoolcode.Text.Trim());
                string teditSchool = "";
                try
                {
                    teditSchool = editSchool.Text.Trim();
                    if (teditSchool.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the School/Faculty or Institute Name";
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
                        .EditSchool(universityCode, teditschoolcode, teditSchool, userCode, password);
                    string[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    if (info[0] == "success")
                    {
                        feedback.InnerHtml = "<div class='alert alert-success'>The University School/Faculties was successfully updated</div>";
                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>The University School/Faculties could not be updated</div>";
                    }
                }
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void deleteschool_Click(object sender, EventArgs e)
        {
            try
            {
                string tremoveschoolCode = removeschoolCode.Text.Trim();
                int mremoveschoolCode = Convert.ToInt32(tremoveschoolCode);
                bool status = new Config().ObjNav()
                    .DeleteSchools(mremoveschoolCode, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                if (status == true)
                {
                    feedback.InnerHtml = "<div class='alert alert-success'> The University School Details was successfully deleted  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {

                    feedback.InnerHtml = "<div class='alert alert-success'> The University School Details could not be deleted.Kindly ensure that the Datatc collection period is still open<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

    }

}
