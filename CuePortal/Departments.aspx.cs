using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class Departments : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
         
            if (!IsPostBack)
            {
                var nav = Config.ReturnNav();

                var schools = nav.UniversitySchoolsFaculties.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"])); ;
                txtschool.DataSource = schools;
                txtschool.DataValueField = "School_Code";
                txtschool.DataTextField = "School_Name";
                txtschool.DataBind();

                editSchool.DataSource = schools;
                editSchool.DataValueField = "School_Code";
                editSchool.DataTextField = "School_Name";
                editSchool.DataBind();

                //try
                //{
                //    string entryNo = Request.QueryString["entry"];

                //    if (!(string.IsNullOrEmpty(entryNo)))
                //    {
                //        int entry = Convert.ToInt32(entryNo);
                //        bool deleted = new Config().ObjNav()
                //         .DeleteDepartments(entry, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                //        if (deleted)
                //        {
                //            feedback.InnerHtml = "<div class='alert alert-success'>The University Department details was successfully deleted</div>";
                //        }
                //    }

                //}
                //catch (Exception y)
                //{

                //}

            }
        }
        protected void SaveDepartment_Click(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string universityCode = Convert.ToString(Session["UniversityCode"]);
                // string ttxtschool = txtschool.SelectedValue;
                string ttxtschool = "";
                try
                {
                    ttxtschool = txtschool.SelectedValue;
                    if (ttxtschool.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please select the School/Faculty or Institute Name";
                }
                //    string ttxtdepartment = txtdepartment.Text.Trim();
                string ttxtdepartment = "";
                try
                {
                    ttxtdepartment = txtdepartment.Text.Trim();
                    if (ttxtdepartment.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the Department Name";
                }
                if (error)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    string status = new Config().ObjNav()
                    .AddDepartments(universityCode, ttxtschool, ttxtdepartment);
                    string[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    if (info[0] == "success")
                    {
                        feedback.InnerHtml =
                            "<div class='alert alert-success'>The university  department details was successfully submitted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        feedback.InnerHtml =
                            "<div class='alert alert-danger'>The university department details was not submitted  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        protected void EditDepartment_Click(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string universityCode = Convert.ToString(Session["UniversityCode"]);
                int teditdepartmentcode = Convert.ToInt32(editdepartmentcode.Text.Trim());
                string teditDepartment = "";
                try
                {
                    teditDepartment = editDepartment.Text.Trim();
                    if (teditDepartment.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please select the School/Faculty or Institute Name";
                }
                // string teditSchool = editSchool.Text.Trim();
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
                    message = "Please select the School/Faculty or Institute Name";
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
                        .EditDepartment(universityCode, teditdepartmentcode, teditSchool, teditDepartment, userCode, password);
                    string[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    if (info[0] == "success")
                    {
                        feedback.InnerHtml = "<div class='alert alert-success'>The University Department Details was successfully updated</div>";
                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>The University Department Details could not be updated</div>";
                    }
                }
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void deleteDepartment_Click(object sender, EventArgs e)
        {
            try
            {
                string tremovedepartmentCode = removedepartmentCode.Text.Trim();
                int mremovedepartmentCode = Convert.ToInt32(tremovedepartmentCode);
                bool status = new Config().ObjNav()
                    .DeleteDepartments(mremovedepartmentCode, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                if (status == true)
                {
                    feedback.InnerHtml = "<div class='alert alert-success'> The University Department Details was successfully deleted  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {

                    feedback.InnerHtml = "<div class='alert alert-success'> The University Department Details could not be deleted.Kindly ensure that the Datatc collection period is still open<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}