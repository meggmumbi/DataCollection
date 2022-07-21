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
    public partial class FullTimeAcademicStaffSize : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


            if (!IsPostBack)
            {
                var nav = Config.ReturnNav();
                List<string> genders = new List<string>();
                genders.Add("-----Select Teaching Staff Gender------");
                genders.Add("Male");
                genders.Add("Female");
                genders.Add("Intersex");
                gender.DataSource = genders;
                gender.DataBind();


                var counties = nav.homecounties.ToList().OrderBy(r => r.County_Name);
                homeCounty.DataSource = counties;
                homeCounty.DataValueField = "Code";
                homeCounty.DataTextField = "County_Name";
                homeCounty.DataBind();

                List<string> submissiontypes = new List<string>();
                submissiontypes.Add("Original");
                submissiontypes.Add("Amendment");
                submissiontype.DataSource = submissiontypes;
                submissiontype.DataBind();


                var countries = nav.countries.ToList().OrderBy(r => r.Name);
                nationality.DataSource = countries;
                nationality.DataValueField = "Code";
                nationality.DataTextField = "Name";
                nationality.DataBind();

                List<string> terms = new List<string>();
                terms.Add("----Select Terms of Service----");
                terms.Add("Full Time");
                terms.Add("Part Time");
                stafftermsOfService.DataSource = terms;
                stafftermsOfService.DataBind();

                List<string> highestQualifications = new List<string>();
                highestQualifications.Add("--Select Highest Academic Qualifications-----");
                highestQualifications.Add("Bachelors");
                highestQualifications.Add("Masters");
                highestQualifications.Add("Doctorate");
                highestQualifications.Add("Postgraduate Diploma");
                highestQualifications.Add("Diploma");
                highestQualifications.Add("Certificate");
                highestAcademicQualification.DataSource = highestQualifications;
                highestAcademicQualification.DataBind();

                var campuses = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"])); ;
                campus.DataSource = campuses;
                campus.DataTextField = "Description";
                campus.DataValueField = "No";
                campus.DataBind();
                var domains = nav.programdomains;
                programDomain.DataSource = domains;
                programDomain.DataTextField = "Description";
                programDomain.DataValueField = "Code";
                programDomain.DataBind();

                var ranks = nav.StaffRanks;
                staffrankcode.DataSource = ranks;
                staffrankcode.DataTextField = "Description";
                staffrankcode.DataValueField = "Code";
                staffrankcode.DataBind();

                var disabilities = nav.Disabilities.ToList().OrderBy(r => r.Description);
                diabilityDescription.DataSource = disabilities;
                diabilityDescription.DataValueField = "Description";
                diabilityDescription.DataTextField = "Description";
                diabilityDescription.DataBind();

                var ethinBackgrounddetails = nav.Ethnicity;
                ethinBackground.DataSource = ethinBackgrounddetails;
                ethinBackground.DataTextField = "Ethnicity_Background";
                ethinBackground.DataValueField = "Code";
                ethinBackground.DataBind();


            }

        }


        protected void submit_Click(object sender, EventArgs e)
        {
            try
            {
                int submissiontypes = submissiontype.SelectedIndex;
                string message = "";
                bool error = false;
                string tIdNumber = idNumber.Text.Trim();
                string nationalityCode = nationality.SelectedValue;
                string tSurName = lastName.Text.Trim();
                string tMiddleName = middleName.Text.Trim();
                string tFirstName = firstName.Text.Trim();
                string tDisabilityDescription = diabilityDescription.SelectedValue;
                string disabilityRegistrationCode = disabilityCode.Text.Trim();
                int tGender = gender.SelectedIndex;
                string tEthnicBackground = ethinBackground.SelectedValue;
                DateTime tDob = new DateTime();
                tDob = DateTime.ParseExact(dob.Text.Trim(), "d/M/yyyy", CultureInfo.InvariantCulture);
                string tCounty = homeCounty.SelectedValue;
                string tProgramDomain = programDomain.SelectedValue;

                DateTime firstAppointment = new DateTime();
                firstAppointment = DateTime.ParseExact(dateOfCurrentAppointment.Text.Trim(), "d/M/yyyy",

                CultureInfo.InvariantCulture);
                DateTime currentAppointment = new DateTime();
                currentAppointment = DateTime.ParseExact(dateOfCurrentAppointment.Text.Trim(), "d/M/yyyy", CultureInfo.InvariantCulture);
                string tRank = staffrankcode.SelectedValue;
                int tHighestAcademic = highestAcademicQualification.SelectedIndex;
                string tPayroll = payrollNumber.Text.Trim();
                int tTerms = stafftermsOfService.SelectedIndex;
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
                if (tRank.Length < 1)
                {
                    error = true;
                    message = "Please Select  valid value for Teaching Staff Rank ";
                }
                if (tProgramDomain.Length < 1)
                {
                    error = true;
                    message = "Please Select  valid value for Teaching Staff Programme Domain";
                }
                if (tCounty.Length < 1)
                {
                    error = true;
                    message = "Please Select  valid value for Teaching Staff Home County";
                }
                if (tEthnicBackground.Length < 1)
                {
                    error = true;
                    message = "Please Select  valid value for Teaching Staff Ethnic Background";
                }
                if (disabilityRegistrationCode.Length < 1)
                {
                    disabilityRegistrationCode = "";
                    //error = true;
                    //message = "Please Enter  valid value for Teaching Staff Disability Code";
                }
                if (tDisabilityDescription.Length < 1)
                {
                    error = true;
                    message = "Please Enter  valid value for Teaching Staff Disability Description";
                }
                if (tFirstName.Length < 1)
                {
                    error = true;
                    message = "Please Enter   valid value for Teaching Staff First Name";
                }
                if (tMiddleName.Length < 1)
                {
                    tMiddleName = "";
                }
                if (tSurName.Length < 1)
                {
                    error = true;
                    message = "Please Enter valid value for Teaching Staff SurName";
                }
                if (nationalityCode.Length < 1)
                {
                    error = true;
                    message = "Please Enter  valid value for Teaching Staff Nationality";
                }
                if (tIdNumber.Length < 1)
                {
                    error = true;
                    message = "Please Enter  valid value for Teaching Staff ID Number/Passport No";
                }
                if (tIdNumber.Length > 20)
                {
                    error = true;
                    message = "Please Enter valid value for Teaching Staff ID Number/Passport No. The Number of Characters should be less than 9 Characters";
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
                    .AddAcademicStaff(tIdNumber, tPayroll, tFirstName, tMiddleName, tSurName, tGender,
                        tEthnicBackground, tDob, nationalityCode, tCounty,
                        tDisabilityDescription, disabilityRegistrationCode, tProgramDomain, tRank,
                        firstAppointment, tTerms, tHighestAcademic, tCampus, currentAppointment, submissiontypes, userCode, password);
                    if (status == "success")
                    {
                        feedback.InnerHtml =
                            "<div class='alert alert-success'>The university academic staff details was successfully Submitted</div>";
                        idNumber.Text = "";
                        nationality.SelectedIndex = 0;
                        lastName.Text = "";
                        middleName.Text = "";
                        firstName.Text = "";
                        disabilityCode.Text = "";
                        gender.SelectedIndex = 0;
                        dob.Text = "";
                        homeCounty.SelectedIndex = 0;
                        programDomain.SelectedIndex = 0;
                        dateOfAppointment.Text = "";
                        staffrankcode.SelectedIndex = 0;
                        highestAcademicQualification.SelectedIndex = 0;
                        payrollNumber.Text = "";
                        stafftermsOfService.SelectedIndex = 0;
                        campus.SelectedIndex = 0;
                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>" + status + "</div>";
                    }
                }
            }
            catch (Exception y)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>We experienced an error while adding Teaching Staff. Kindly Fill in all the Teaching Staff Details." + y.Message + "</div>";
            }
        }
        protected void deleteStaff_Click(object sender, EventArgs e)
        {
            try
            {
                int tremovestaffCode = Convert.ToInt32(removestaffCode.Text.Trim());
                string tremovepayrolcode = removepayrolcode.Text.Trim();
                string tremovestaffid = removestaffid.Text.Trim();
                bool status = new Config().ObjNav()
                   .DeleteAcademicStaff(tremovestaffCode, tremovestaffid, tremovepayrolcode, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                if (status == true)
                {
                    feedback.InnerHtml = "<div class='alert alert-success'> The Teaching Staff  Details was successfully deleted  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {

                    feedback.InnerHtml = "<div class='alert alert-danger'> The  Teaching Staff Details could not be deleted.Kindly ensure that the Data collection period is still open<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

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
                    .DeleteAllAcademicStaff(selectedStaffID, usercode, password);
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