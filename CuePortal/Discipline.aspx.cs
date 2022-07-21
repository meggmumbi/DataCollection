using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class Discipline : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                List<string> verditcts = new List<string>();
                verditcts.Add("Warning");
                verditcts.Add("Expulsion");
                verditcts.Add("Suspension");
                verditcts.Add("Others");
                verdict.DataSource = verditcts;
                verdict.DataBind();

                List<string> verditcts1 = new List<string>();
                verditcts1.Add("Warning");
                verditcts1.Add("Expulsion");
                verditcts1.Add("Suspension");
                verditcts1.Add("Others");
                verdict1.DataSource = verditcts1;
                verdict1.DataBind();
            }


        }
        protected void submit_Click(object sender, EventArgs e)
        {
            string message = "";
            bool error = false;
            string added = "";
            string tStudentId = studentId.Text.Trim();
            if (tStudentId.Length < 1)
            {
                error = true;
                message = "Please Enter a Valid Student ID No/Passport No.";
            }
            string tcaserefence = casereferencenumber.Text.Trim();
            if (tcaserefence.Length < 1)
            {
                error = true;
                message = "Please Enter a Valid Student Case Reference Number";
            }
            string tStudentAdm = studentAdm.Text.Trim();
            if (tStudentAdm.Length < 1)
            {
                error = true;
                message = "Please Enter a Valid Student Admission Number";
            }
            string tStudentFName = studentFirstName.Text.Trim();
            if (tStudentFName.Length < 1)
            {
                error = true;
                message = "Please Enter a Valid Student First Name";
            }
            string tStudentMName = studentMiddleName.Text.Trim();
            if (tStudentMName.Length < 1)
            {
                tStudentMName = "";
            }
            string tStudentLName = studentLastName.Text.Trim();
            if (tStudentLName.Length < 1)
            {
                error = true;
                message = "Please Enter a Valid Student Last Name";
            }
            string tDescription = caseDescription.Text.Trim();
            if (tDescription.Length < 1)
            {
                error = true;
                message = "Please Enter a Valid  Case Description";
            }
            string tCaseDate = caseDate.Text.Trim();
            if (tCaseDate.Length < 1)
            {
                error = true;
                message = "Please Enter a Valid Student Case Date";
            }
            int tVerdict = verdict.SelectedIndex;
            string tVerdictDate = verdictDate.Text.Trim();
            if (tVerdictDate.Length < 1)
            {
                error = true;
                message = "Please Enter a Valid Student Verdict Date";
            }
            if (error)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            else
            {

                DateTime mCaseDate = DateTime.ParseExact(tCaseDate, "d/M/yyyy", CultureInfo.InvariantCulture);
                DateTime mVerdictDate = DateTime.ParseExact(tVerdictDate, "d/M/yyyy", CultureInfo.InvariantCulture);
                string userCode = Convert.ToString(Session["Code"]);
                string password = Convert.ToString(Session["Password"]);
                added = new Config().ObjNav()
                    .AddDisciplineCase(tStudentId, tStudentAdm, tStudentFName, tStudentMName, tStudentLName, tDescription, mCaseDate, tVerdict, mVerdictDate, tcaserefence, userCode, password);
                if (added == "success")
                {
                    feedback.InnerHtml = "<div class='alert alert-success'>The Student Discipline Case  Details was successfully Submitted</div>";
                }
                else
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>The Students Discipline Case Details could not be Submitted</div>";
                }
            }
        }
        protected void edit_Click(object sender, EventArgs e)
        {
            string message = "";
            bool error = false;
            bool added = false;
            string tId = caseId.Text.Trim();
            int mId = Convert.ToInt32(tId);
            string tStudentId = studentId1.Text.Trim();
            if (tStudentId.Length < 1)
            {
                error = true;
                message = "Please Enter a Valid Student ID No/Passport No.";
            }
            string tDescription = caseDescription1.Text.Trim();
            if (tDescription.Length < 1)
            {
                error = true;
                message = "Please Enter a Valid Appeal Case Description";
            }
            string tcasereference = casereference.Text.Trim();
            if (tcasereference.Length < 1)
            {
                error = true;
                message = "Please Enter a Valid Student Case Reference Number";
            }
            string tCaseDate = caseDate1.Text.Trim();
            if (tCaseDate.Length < 1)
            {
                error = true;
                message = "Please Enter a Valid Student Case Date";
            }
            int tVerdict = verdict1.SelectedIndex;
            string tVerdictDate = verdictDate1.Text.Trim();
            if (tVerdictDate.Length < 1)
            {
                error = true;
                message = "Please Enter a Valid Student Case Verdict Date";
            }
            if (error)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            else
            {
                DateTime mCaseDate = DateTime.ParseExact(tCaseDate, "d-M-yyyy", CultureInfo.InvariantCulture);
                DateTime mVerdictDate = DateTime.ParseExact(tVerdictDate, "d-M-yyyy", CultureInfo.InvariantCulture);
                string userCode = Convert.ToString(Session["Code"]);
                string password = Convert.ToString(Session["Password"]);
                added = new Config().ObjNav()
                    .EditDisciplineCase(mId, tcasereference, tStudentId, tDescription, mCaseDate, tVerdict, mVerdictDate, userCode, password);
                if (added)
                {
                    feedback.InnerHtml = "<div class='alert alert-success'>The Student Discipline Case Details was successfully updated</div>";
                }
                else
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>The Student Discipline Case Details could not be updated</div>";
                }
            }
        }
        protected void deleteDiscipline_Click(object sender, EventArgs e)
        {
            try
            {
                string tremovedisciplineCode = removedisciplineCode.Text.Trim();
                int mremovedisciplineCode = Convert.ToInt32(tremovedisciplineCode);
                bool status = new Config().ObjNav()
                     .DeleteDisciplineCase(mremovedisciplineCode, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                if (status)
                {
                    feedback.InnerHtml = "<div class='alert alert-success'>The Student Discipline Details was successfully deleted  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {

                    feedback.InnerHtml = "<div class='alert alert-danger'>The Student Discipline could not be deleted.Kindly ensure that the Data collection period is still open<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}