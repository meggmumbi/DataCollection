using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class SuccessFullAppeals : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                List<string> verditcts = new List<string>();
                verditcts.Add("Warning");
                verditcts.Add("Expulsion");
                verditcts.Add("Suspension");
                verdict1.DataSource = verditcts;
                verdict1.DataBind();

                List<string> verditcts1= new List<string>();
                verditcts1.Add("Warning");
                verditcts1.Add("Expulsion");
                verditcts1.Add("Suspension");
                verdict.DataSource = verditcts1;
                verdict.DataBind();
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
            string tDescription = caseDescription.Text.Trim();
            if (tDescription.Length < 1)
            {
                error = true;
                message = "Please Enter a Valid Appeal Case Description";
            }
            string tcasereferenceid = casereferenceid.Text.Trim();
            if (tcasereferenceid.Length < 1)
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
                error = true;
                message = "Please Enter a Valid Student Middle Name";
            }
            string tStudentLName = studentLastName.Text.Trim();
            if (tStudentLName.Length < 1)
            {
                error = true;
                message = "Please Enter a Valid Student Last Name";
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

                DateTime mCaseDate = DateTime.ParseExact(tCaseDate, "yyyy-M-d", CultureInfo.InvariantCulture);
                DateTime mVerdictDate = DateTime.ParseExact(tVerdictDate, "yyyy-M-d", CultureInfo.InvariantCulture);
                string userCode = Convert.ToString(Session["Code"]);
                string password = Convert.ToString(Session["Password"]);
                added = new Config().ObjNav()
                    .AddSuccessfulAppeals(tStudentId, tStudentAdm, tStudentFName, tStudentMName, tStudentLName, tDescription, mCaseDate, tVerdict, mVerdictDate, tcasereferenceid, userCode, password);
                if (added == "success")
                {
                    feedback.InnerHtml = "<div class='alert alert-success'>The Successful Students Appeals  details was successfully submitted</div>";
                }
                else
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>The Successful Students Appeals  could not be submitted. Kindly Ensure that the Case Reference Number is the same with the Discpline Case already Uploaded.</div>";
                }
            }
        }
        protected void edit_Click(object sender, EventArgs e)
        {
            string message = "";
            bool error = false;
            bool added = false;
            string tId = caseid.Text.Trim();

            int mId = Convert.ToInt32(tId);
            string tStudentId = studentsid.Text.Trim();
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
            string tCaseRefernce = casereferenceNo.Text.Trim();
            if (tCaseRefernce.Length < 1)
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
                message = "Please Enter a Valid Student Verdict Date";
            }
            if (error)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            else
            {
                DateTime mCaseDate = DateTime.ParseExact(tCaseDate, "yyyy-M-d", CultureInfo.InvariantCulture);
                DateTime mVerdictDate = DateTime.ParseExact(tVerdictDate, "yyyy-M-d", CultureInfo.InvariantCulture);
                string userCode = Convert.ToString(Session["Code"]);
                string password = Convert.ToString(Session["Password"]);
                added = new Config().ObjNav()
                    .EditDisciplineCase(mId, tCaseRefernce, tStudentId, tDescription, mCaseDate, tVerdict, mVerdictDate, userCode, password);
                if (added)
                {
                    feedback.InnerHtml = "<div class='alert alert-success'>The Students Appeals details  was successfully updated</div>";
                }
                else
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>The Case Reference Number Was not found.Kindly Ensure that the Appeals details is linked to a Case</div>";
                }
            }
        }
        protected void deleteAppeals_Click(object sender, EventArgs e)
        {
            try
            {
                string tremoveappealCode = removeappealCode.Text.Trim();
                int mremoveappealCode = Convert.ToInt32(tremoveappealCode);
                bool status = new Config().ObjNav()
                     .DeleteAppeals(mremoveappealCode, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                if (status)
                {
                    feedback.InnerHtml = "<div class='alert alert-success'> The Student Appeals Details was successfully deleted  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {

                    feedback.InnerHtml = "<div class='alert alert-danger'> The Student Appeals could not be deleted.Kindly ensure that the Data collection period is still open<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}