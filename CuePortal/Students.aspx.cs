using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class Students : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


            if (!IsPostBack)
            {
                var nav = Config.ReturnNav();
                List<string> genders = new List<string>();
                genders.Add("---Select Student Gender-------");
                genders.Add("Male");
                genders.Add("Female");
                genders.Add("Intersex");
                gender.DataSource = genders;
                gender.DataBind();

                List<string> resident = new List<string>();
                resident.Add("---Select Student Residential Status------");
                resident.Add("University Accommodation");
                resident.Add("Private Accommodation");
                resident.Add("University Partnership");
                residents.DataSource = resident;
                residents.DataBind();

                List<string> submissiontypes = new List<string>();
                submissiontypes.Add("Original");
                submissiontypes.Add("Amendment");
                submissioncategory.DataSource = submissiontypes;
                submissioncategory.DataBind();

                var counties = nav.homecounties.ToList().OrderBy(r => r.County_Name);
                homeCounty.DataSource = counties;
                homeCounty.DataValueField = "Code";
                homeCounty.DataTextField = "County_Name";
                homeCounty.DataBind();

                var nationalities = nav.countries.ToList().OrderBy(r => r.Name);
                nationality.DataSource = nationalities;
                nationality.DataValueField = "Code";
                nationality.DataTextField = "Name";
                nationality.DataBind();

                List<string> students = new List<string>();
                students.Add("----Select Student Status----");
                students.Add("Active");
                students.Add("Deceased");
                students.Add("Transferred");
                students.Add("Absconded");
                students.Add("Deferred");
                students.Add("Expelled");
                studentstatus.DataSource = students;
                studentstatus.DataBind();

                List<string> sponsorships = new List<string>();
                sponsorships.Add("----Select Sponsorship Type--------");
                sponsorships.Add("Government Sponsored");
                sponsorships.Add("Self Sponsored");
                sponsorships.Add("Other");
                sponsorship.DataSource = sponsorships;
                sponsorship.DataBind();

                var programs = nav.Programs.Where(r => r.Accreditation_Status == "CUE Accredited" && r.Institution_Code == Convert.ToString(Session["UniversityCode"]));
                program.DataSource = programs;
                program.DataTextField = "Description";
                program.DataValueField = "Code";
                program.DataBind();
                var campuses = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                campus.DataSource = campuses;
                campus.DataTextField = "Description";
                campus.DataValueField = "No";
                campus.DataBind();

                var disabilities = nav.Disabilities.ToList().OrderBy(r => r.Description);
                disabilityDescription.DataSource = disabilities;
                disabilityDescription.DataValueField = "Code";
                disabilityDescription.DataTextField = "Description";
                disabilityDescription.DataBind();

                var ethnicities = nav.Ethnicity.ToList().OrderBy(r => r.Ethnicity_Background);
                ethnicBackground.DataSource = ethnicities;
                ethnicBackground.DataValueField ="Code";
                ethnicBackground.DataTextField ="Ethnicity_Background";
                ethnicBackground.DataBind();



            }

        }
        protected void deleteStudent_Click(object sender, EventArgs e)
        {
            try
            {
                string tremovestudentCode = removestudentCode.Text.Trim();
                int mremovestudentCode = Convert.ToInt32(tremovestudentCode);
                bool status = new Config().ObjNav()
                     .DeleteStudent(mremovestudentCode, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                if (status == true)
                {
                    feedback.InnerHtml = "<div class='alert alert-success'> The Student  Details was successfully deleted  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {

                    feedback.InnerHtml = "<div class='alert alert-danger'> The  Student Details could not be deleted.Kindly ensure that the Data collection period is still open.There is no Open Invitation Notice for Data Collection<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void clerkApprove_Click(object sender, EventArgs e)
        {
            bool response = new Config().ObjNav().Approve("students", Session["Code"].ToString(), Session["Password"].ToString(), true);
        }

        protected void clerkReject_Click(object sender, EventArgs e)
        {
            bool response = new Config().ObjNav().Approve("students", Session["Code"].ToString(), Session["Password"].ToString(), false);
        }

        protected void dvcApprove_Click(object sender, EventArgs e)
        {
            bool response = new Config().ObjNav().Approve("students", Session["Code"].ToString(), Session["Password"].ToString(), true);
        }

        protected void dvcReject_Click(object sender, EventArgs e)
        {
            bool response = new Config().ObjNav().Approve("students", Session["Code"].ToString(), Session["Password"].ToString(), false);
        }

        protected void vcApprove_Click(object sender, EventArgs e)
        {
            bool response = new Config().ObjNav().Approve("students", Session["Code"].ToString(), Session["Password"].ToString(), true);
        }

        protected void vcReject_Click(object sender, EventArgs e)
        {
            bool response = new Config().ObjNav().Approve("students", Session["Code"].ToString(), Session["Password"].ToString(), false);
        }

        protected void addstudentsDetails_Click(object sender, EventArgs e)
        {
            try
            {
               int submissiontype = submissioncategory.SelectedIndex;
                string message = "";
                bool error = false;
                string tdateofadmission = dateOfAdmission.Text.Trim();
                if (tdateofadmission.Length < 1)
                {
                    error = true;
                    message = "Please Enter a Valid  Date of Admission";
                }
                string tdateofbirth = dob.Text.Trim();
                if (tdateofadmission.Length < 1)
                {
                    error = true;
                    message = "Please Enter a Valid  Date of Birth";
                }
                DateTime mdob = new DateTime();
                string tAdmNo = admNo.Text.Trim();
                mdob = DateTime.ParseExact(tdateofbirth, "d/M/yyyy", CultureInfo.InvariantCulture);

                DateTime mDateOfAdmission = new DateTime();
                mDateOfAdmission = DateTime.ParseExact(tdateofadmission, "d/M/yyyy", CultureInfo.InvariantCulture);

                int myYear = Convert.ToInt32(yearOfStudy.Text.Trim());
                int tGender = gender.SelectedIndex;
                string campusCode = campus.SelectedValue.Trim();
                int tSponsorship = sponsorship.SelectedIndex;
                string tDisabilityDescription = disabilityDescription.SelectedValue;
                string tEthnicBackground = ethnicBackground.SelectedValue;
                int tstudentstatus = studentstatus.SelectedIndex;
                int tresidents = residents.SelectedIndex;
                string tlastname = lastName.Text.Trim();
                string tmiddlename = middleName.Text.Trim();
                string tfirstname = firstName.Text.Trim();
                string tdisabilitycode = disabilityCode.Text.Trim();
                string tprogramname = program.SelectedValue;
                string tstudentid = idNumber.Text.Trim();
              
                if (tstudentid.Length < 1 )
                {
                    error = true;
                    message = "Please Enter a valid Student ID Number";
                }
                if (tstudentid.Length > 20)
                {
                    error = true;
                    message = "Please Enter a valid Student ID Number. The Student ID Number Should be Less than 20 Characters";
                }
                if (tlastname.Length < 1)
                {
                    error = true;
                    message = "Please Enter Student Last Name ";
                }
                if (tmiddlename.Length < 1)
                {
                    tmiddlename = "";
                }
                if (tfirstname.Length < 1)
                {
                    error = true;
                    message = "Please Enter Student First Name ";
                }
                if (tdisabilitycode.Length < 1)
                {
                    tdisabilitycode = "";
                }

                if (tAdmNo.Length < 1)
                {
                    error = true;
                    message = "Please Enter Student Admission Number";
                }
                if (myYear< 1)
                {
                    error = true;
                    message = "Please enter the Year ";
                }
                if (tEthnicBackground.Length < 1)
                {
                    error = true;
                    message = "Please select student Ethnic Background";
                }
                if (tDisabilityDescription.Length < 1)
                {
                    error = true;
                    message = "Please select student Ethnic Background";
                }
                if (tDisabilityDescription.Length < 1)
                {
                    error = true;
                    message = "Please select student Ethnic Background";
                }
                if (error)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {

                    string status = new Config().ObjNav()
                   .AddStudentDraft(tstudentid, tAdmNo, tlastname, tmiddlename,tfirstname, tGender, mdob, homeCounty.SelectedValue, tEthnicBackground,
                    nationality.SelectedValue, tSponsorship, myYear, tDisabilityDescription, tdisabilitycode, tprogramname
                    , mDateOfAdmission, campusCode, tresidents, tstudentstatus, submissiontype, Session["Code"].ToString(), Session["Password"].ToString());
                    string[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        feedback.InnerHtml = "<div class='alert alert-success'>The University Student details was successfully submitted</div>";
                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>The University Student details could not be submitted"+ info[1] +"</div>";
                    }
                }
            }

            catch (Exception y)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>We experienced an error while adding the student. Kindly Fill in all the students Details." + y.Message + "</div>";
            }
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string DeleteAllStudents(SelectectRecordsModel postData)
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
                    .DeleteAllStudentsEntries(selectedStaffID, usercode, password);
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