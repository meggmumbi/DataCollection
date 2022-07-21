using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class Graduation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          
            var nav = Config.ReturnNav();

            List<string> genders = new List<string>();

          

            var programs = nav.Programs.Where( r =>   r.Accreditation_Status == "CUE Accredited" &&r.Institution_Code == Convert.ToString(Session["UniversityCode"]));
            program.DataSource = programs;
            program.DataTextField = "Description";
            program.DataValueField = "Code";
            program.DataBind();

            editProgram.DataSource = programs;
            editProgram.DataTextField = "Description";
            editProgram.DataValueField = "Code";
            editProgram.DataBind();
            
        }

    

        protected void addGraduation_Click(object sender, EventArgs e)
        {
            //feedback
            string tStudentId = studentId.Text.Trim();
            string tAdmNo = admNo.Text.Trim();
            string tFName = firstName.Text.Trim();
            string tMName = middleName.Text.Trim();
            string tLName = lastName.Text.Trim();
            string tProgram = program.SelectedValue;
            string tCredit = credit.Text.Trim();
            string tDate = graduationDate.Text.Trim();
            DateTime tGraduationDate = new DateTime();
            bool error = false;
            string message = "";
            if (string.IsNullOrEmpty(tStudentId))
            {
                error = true;
                message = "Please provide a valid student Id/Passport No";
            }
            if ((string.IsNullOrEmpty(tFName) && string.IsNullOrEmpty(tMName)) || (string.IsNullOrEmpty(tMName) && string.IsNullOrEmpty(tLName)) || (string.IsNullOrEmpty(tFName) && string.IsNullOrEmpty(tLName)))
            {
                error = true;
                message += message.Length > 0 ? "<br>" : "";
                message += "A student must have at least two names";
            }
           if (string.IsNullOrEmpty(tProgram))
            {
                error = true;
                message += message.Length > 0 ? "<br>" : "";
                message += "Program Code is mandatory";
            }
            try
            {
                tGraduationDate = DateTime.ParseExact(tDate, "d/M/yyyy", CultureInfo.InvariantCulture);
            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 0 ? "<br>" : "";
                message += "Please provide a valid graduation date";
            }
            if (error)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>"+message+"</div>";
            }
            else
            {
                string status = new Config().ObjNav()
                    .AddGraduation(tStudentId, tAdmNo, tFName, tMName, tLName, tProgram, tCredit, tGraduationDate,
                        Session["Code"].ToString(), Session["Password"].ToString());
                string[] info = status.Split('*');
                if (status == "success")
                {
                    feedback.InnerHtml = "<div class='alert alert-success'>The Graduation Details was successfully Submitted</div>";
                }
                else
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + status + "</div>";
                }
            }
           
        }
        protected void deleteGraduation_Click(object sender, EventArgs e)
        {
            try
            {
                string tremovegraduationCode = removeentryCode.Text.Trim();
                int mremovegraduationCode = Convert.ToInt32(tremovegraduationCode);
                bool status = new Config().ObjNav()
                     .DeleteGraduation(mremovegraduationCode, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                if (status == true)
                {
                    feedback.InnerHtml = "<div class='alert alert-success'> The Student  Graduation Details was successfully deleted  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {

                    feedback.InnerHtml = "<div class='alert alert-danger'> The  Student Graduation Details could not be deleted.Kindly ensure that the Data collection period is still open.There is no Open Invitation Notice for Data Collection<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void EditGraduation_Click(object sender, EventArgs e)
        {
            //feedback
            string tStudentId = editStudentId.Text.Trim();
            string tAdmNo = editAdmNo.Text.Trim();
            string tFName = editFirstName.Text.Trim();
            string tMName = editMiddleName.Text.Trim();
            string tLName = editLastName.Text.Trim();
            string tProgram = editProgram.SelectedValue;
            string tCredit = editCredit.Text.Trim();
            string tDate = editGraduationDate.Text.Trim();
            DateTime tGraduationDate = new DateTime();
            bool error = false;
            string message = "";
            if (string.IsNullOrEmpty(tStudentId))
            {
                error = true;
                message = "Please provide a valid student Id/Passport No";
            }
            if ((string.IsNullOrEmpty(tFName) && string.IsNullOrEmpty(tMName)) || (string.IsNullOrEmpty(tMName) && string.IsNullOrEmpty(tLName)) || (string.IsNullOrEmpty(tFName) && string.IsNullOrEmpty(tLName)))
            {
                error = true;
                message += message.Length > 0 ? "<br>" : "";
                message += "A student must have at least two names";
            }
            if (string.IsNullOrEmpty(tProgram))
            {
                error = true;
                message += message.Length > 0 ? "<br>" : "";
                message += "Program Code is mandatory";
            }
            try
            {
                tGraduationDate = DateTime.ParseExact(tDate, "d/M/yyyy", CultureInfo.InvariantCulture);
            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 0 ? "<br>" : "";
                message += "Please provide a valid graduation date";
            }
            if (error)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + message + "</div>";
            }
            else
            {
                string status = new Config().ObjNav()
                    .AddGraduation(tStudentId, tAdmNo, tFName, tMName, tLName, tProgram, tCredit, tGraduationDate,
                        Session["Code"].ToString(), Session["Password"].ToString());
                string[] info = status.Split('*');
                if (status == "success")
                {
                    feedback.InnerHtml = "<div class='alert alert-success'>The Graduation Details was successfully Updated</div>";
                }
                else
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + status + "</div>";
                }
            }

        }
    }
}