using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class NonAcademicStaff : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            var nav = Config.ReturnNav();
            if (!IsPostBack)
            {
                List<string> genders = new List<string>();
                genders.Add("---Select Gender-----");
                genders.Add("Male");
                genders.Add("Female");
                genders.Add("Intersex");
                gender.DataSource = genders;
                gender.DataBind();

                List<string> qualifications = new List<string>();
                qualifications.Add("----Select the Highest Acaademic Qualification------");
                qualifications.Add("Bachelors");
                qualifications.Add("Masters");
                qualifications.Add("Doctorate");
                qualifications.Add("Postgraduate Diploma");
                qualifications.Add("Diploma");
                qualifications.Add("Certificate");
                qualifications.Add("None");
                highestAcademicQualification.DataSource = qualifications;
                highestAcademicQualification.DataBind();

                List<string> terms = new List<string>();
                terms.Add("---Select Terms of Service----");
                terms.Add("Permanent");
                terms.Add("Contract");
                termsOfService.DataSource = terms;
                termsOfService.DataBind();

                var ranks = nav.StaffRanks.ToList();
                staffrank.DataSource = ranks;
                staffrank.DataTextField = "Description";
                staffrank.DataValueField = "Code";
                staffrank.DataBind();


                var counties = nav.homecounties.ToList().OrderBy(r => r.County_Name);
                homeCounty.DataSource = counties;
                homeCounty.DataValueField = "Code";
                homeCounty.DataTextField = "County_Name";
                homeCounty.DataBind();

                var countries = nav.countries.ToList().OrderBy(r => r.Name);
                nationality.DataSource = countries;
                nationality.DataValueField = "Code";
                nationality.DataTextField = "Name";
                nationality.DataBind();

                var campuses = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                campus.DataSource = campuses;
                campus.DataTextField = "Description";
                campus.DataValueField = "No";
                campus.DataBind();


                var ethinBackgrounddetails = nav.Ethnicity.ToList().OrderBy(r=>r.Ethnicity_Background);
                ethnicBackground.DataSource = ethinBackgrounddetails;
                ethnicBackground.DataTextField = "Ethnicity_Background";
                ethnicBackground.DataValueField = "Code";
                ethnicBackground.DataBind();

                var disabilities = nav.Disabilities.ToList().OrderBy(r => r.Description);
                disabilityDescription.DataSource = disabilities;
                disabilityDescription.DataValueField = "Code";
                disabilityDescription.DataTextField = "Description";
                disabilityDescription.DataBind();
            }

        }

        protected void submit_Click(object sender, EventArgs e)
        {

            try
            {
                string message = "";
                bool error = false;
                int submissiontype = 0;
                string tIdNumber = idNumber.Text.Trim();
                string tPayrollNo = payrollNumber.Text.Trim();
                string tSurName = lastName.Text.Trim();
                string tMiddleName = middleName.Text.Trim();
                string tFirstName = firstName.Text.Trim();
                int tGender = gender.SelectedIndex;
                string tEthnicBackground = ethnicBackground.Text.Trim();
                string tdateOfBirth = dob.Text.Trim();
                if (tdateOfBirth.Length < 1)
                {
                    error = true;
                    message = "Please Enter  valid Date for Date of Birth ";
                }
                DateTime tDob = new DateTime();
                tDob = DateTime.ParseExact(tdateOfBirth, "d/M/yyyy", CultureInfo.InvariantCulture);
                string tCounty = homeCounty.SelectedValue;
                string nationalityCode = nationality.SelectedValue;
                string tDisabilityDescription = disabilityDescription.SelectedValue.Trim();
                string tDisabilityRegistration = disabilityCode.Text.Trim();
                string tPayroll = payrollNumber.Text.Trim();
                int tqualifications = highestAcademicQualification.SelectedIndex;
                string trank = staffrank.SelectedValue;
                string ttdateOfAppointment = dateOfAppointment.Text.Trim();
                int ttermsOfService = termsOfService.SelectedIndex;
                if (ttdateOfAppointment.Length < 1)
                {
                    error = true;
                    message = "Please Enter  valid Date for Date of Appointment ";
                }
                DateTime tdateOfAppointment = new DateTime();
                tdateOfAppointment = DateTime.ParseExact(ttdateOfAppointment, "d/M/yyyy", CultureInfo.InvariantCulture);
                DateTime tdateOfCurrentAppointment = new DateTime();
                tdateOfCurrentAppointment = DateTime.ParseExact(dateOfCurrentAppointment.Text.Trim(), "d/M/yyyy", CultureInfo.InvariantCulture);
                string tCampus = campus.SelectedValue;
                if (tCampus.Length < 1)
                {
                    error = true;
                    message = "Please Select  valid value for University Campus ";
                }
                if (tPayroll.Length < 1)
                {
                    error = true;
                    message = "Please Enter  valid value for the Payroll Number ";
                }
                if (trank.Length < 1)
                {
                    error = true;
                    message = "Please Select  valid value for Non-Teaching Staff Rank ";
                }
                if (tCounty.Length < 1)
                {
                    error = true;
                    message = "Please Select  valid value for Non-Teaching Staff Home County";
                }
                if (tEthnicBackground.Length < 1)
                {
                    error = true;
                    message = "Please Select  valid value for Non-Teaching Staff Ethnic Background";
                }
                if (tDisabilityRegistration.Length < 1)
                {
                    tDisabilityRegistration = "";
                }
                if (tDisabilityDescription.Length < 1)
                {
                    error = true;
                    message = "Please Enter  valid value for Non-Teaching Staff Disability Description";
                }
                if (tFirstName.Length < 1)
                {
                    error = true;
                    message = "Please Enter   valid value for Non-Teaching Staff First Name";
                }
                if (tMiddleName.Length < 1)
                {
                    tMiddleName = " ";
                }
                if (tSurName.Length < 1)
                {
                    error = true;
                    message = "Please Enter valid value for Non-Teaching Staff SurName";
                }
                if (nationalityCode.Length < 1)
                {
                    error = true;
                    message = "Please Enter  valid value for Non-Teaching Staff Nationality";
                }
                if (tIdNumber.Length < 1)
                {
                    error = true;
                    message = "Please Enter  valid value for Non-Teaching Staff ID Number/Passport No";
                }
                if (tIdNumber.Length > 20)
                {
                    error = true;
                    message = "Please Enter  valid value for Non-Teaching Staff ID Number/Passport No. The ID Number should be less than 9 Characters ";
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
                     .AddNonAcademicStaff(tIdNumber, tPayrollNo, tSurName, tMiddleName, tFirstName, tGender, tEthnicBackground, tDob, nationalityCode, tCounty, tDisabilityDescription, tDisabilityRegistration, tCampus, tqualifications, trank, tdateOfAppointment, tdateOfCurrentAppointment, ttermsOfService, userCode, password);
                    string[] info = status.Split('*');
                    if (status == "success")
                    {
                        feedback.InnerHtml = "<div class='alert alert-success'>The University Non Teaching staff was successfully Submitted</div>";
                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>The University Non Teaching staff could not be Submitted."+ info[1]+"</div>";
                    }


                }
            }
            catch (Exception y)
            {

                feedback.InnerHtml = "<div class='alert alert-danger'>We experienced an error while adding Non-Teaching Staff. Kindly Fill in all the Non-Teaching Staff Details." + y.Message + "</div>";
                
            }
        }
        protected void deleteStaff_Click(object sender, EventArgs e)
        {
            try
            {
                string tremovestaffCode = removestaffCode.Text.Trim();
                int mremovestaffCode = Convert.ToInt32(tremovestaffCode);
                bool status = new Config().ObjNav()
                   .DeleteNonAcademicStaff(mremovestaffCode, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                //string[] info = status.Split('*');
                if (status == true)
                {
                    feedback.InnerHtml = "<div class='alert alert-success'> The Non-Teaching Staff  Details was successfully deleted  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {

                    feedback.InnerHtml = "<div class='alert alert-danger'> The  Non-Teaching Staff Details could not be deleted.Kindly ensure that the Data collection period is still open<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string DeleteAllStaff(SelectectRecordsModel postData)
        {
            var universityCode = HttpContext.Current.Session["UniversityCode"].ToString();
            var usercode = HttpContext.Current.Session["Code"].ToString();
            var password = HttpContext.Current.Session["Password"].ToString();
            HtmlGenericControl NewControl = new HtmlGenericControl();
            var results = (dynamic)null;
            try
            {
                string results_0 = (dynamic)null;
                string results_1 = (dynamic)null;
                List<string> AllSelectedCategoriesLists = postData.AllSelectedCategories.ToList();
                //Loop and insert records.
                foreach (var iteminlist in AllSelectedCategoriesLists)
                {
                    var selectedStaffID = iteminlist;
                    var status = new Config().ObjNav()
                    .DeleteAllNonTeachingStaff(selectedStaffID, usercode, password);
                    var res = status.Split('*');
                    results = res[0];
                }

            }
            catch (Exception ex)
            {
                results = ex.Message;
            }
            return results;
        }
    }
}