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
    public partial class LibraryStaff : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var nav = Config.ReturnNav();
            if (!IsPostBack)
            {
                List<string> genders = new List<string>();
                genders.Add("---Select Gender-------");
                genders.Add("Male");
                genders.Add("Female");
                genders.Add("Intersex");
                staffgender.DataSource = genders;
                staffgender.DataBind();

                List<string> librarystaffsstatus = new List<string>();
                librarystaffsstatus.Add("-----Select Library Staff Status-------");
                librarystaffsstatus.Add("Active");
                librarystaffsstatus.Add("Inactive");
                librarystaffsstatus.Add("Deceased"); ;
                librarystaffstatus.DataSource = librarystaffsstatus;
                librarystaffstatus.DataBind();
                
                List<string> highestQualifications = new List<string>();
                highestQualifications.Add("-------Select Qualification-------");
                highestQualifications.Add("Bachelors");
                highestQualifications.Add("Masters");
                highestQualifications.Add("Doctorate");
                highestQualifications.Add("Postgraduate Diploma");
                highestQualifications.Add("Diploma");
                highestQualifications.Add("Certificate");
                highestAcademicQualification.DataSource = highestQualifications;
                highestAcademicQualification.DataBind();

                List<string> thighestspecialization = new List<string>();
                thighestspecialization.Add("-------Select Qualification-------");
                thighestspecialization.Add("Bachelors");
                thighestspecialization.Add("Masters");
                thighestspecialization.Add("Doctorate");
                thighestspecialization.Add("Postgraduate Diploma");
                thighestspecialization.Add("Diploma");
                thighestspecialization.Add("Certificate");
                highestspecialization.DataSource = thighestspecialization;
                highestspecialization.DataBind();

                List<string> tsecondhighestcode = new List<string>();
                tsecondhighestcode.Add("-------Select Qualification-------");
                tsecondhighestcode.Add("Bachelors");
                tsecondhighestcode.Add("Bachelors");
                tsecondhighestcode.Add("Masters");
                tsecondhighestcode.Add("Doctorate");
                tsecondhighestcode.Add("Postgraduate Diploma");
                tsecondhighestcode.Add("Diploma");
                tsecondhighestcode.Add("Certificate");
                secondhighestcode.DataSource = tsecondhighestcode;
                secondhighestcode.DataBind();

                List<string> tsecondhighestspecialization = new List<string>();
                tsecondhighestspecialization.Add("-------Select Qualification-------");
                tsecondhighestspecialization.Add("Bachelors");
                tsecondhighestspecialization.Add("Masters");
                tsecondhighestspecialization.Add("Doctorate");
                tsecondhighestspecialization.Add("Postgraduate Diploma");
                tsecondhighestspecialization.Add("Diploma");
                tsecondhighestspecialization.Add("Certificate");
                secondhighestspecialization.DataSource = tsecondhighestspecialization;
                secondhighestspecialization.DataBind();

                var campuses = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"])); ;
                campus.DataSource = campuses;
                campus.DataTextField = "Description";
                campus.DataValueField = "No";
                campus.DataBind();

                var countries = nav.countries.ToList().OrderBy(r => r.Name);
                staffNationality.DataSource = countries;
                staffNationality.DataValueField = "Code";
                staffNationality.DataTextField = "Name";
                staffNationality.DataBind();

                var ethinBackgrounddetails = nav.Ethnicity;
                stafethnicbackground.DataSource = ethinBackgrounddetails;
                stafethnicbackground.DataTextField = "Ethnicity_Background";
                stafethnicbackground.DataValueField = "Code";
                stafethnicbackground.DataBind();

                var counties = nav.homecounties.ToList().OrderBy(r => r.County_Name);
                staffhomecounty.DataSource = counties;
                staffhomecounty.DataValueField = "Code";
                staffhomecounty.DataTextField = "County_Name";
                staffhomecounty.DataBind();

                List<string> terms = new List<string>();
                terms.Add("Permanent");
                terms.Add("Contract");
                termsofservice.DataSource = terms;
                termsofservice.DataBind();


                var disabilitiesdetails = nav.Disabilities.ToList().OrderBy(r => r.Description);
                disabilitydescription.DataSource = disabilitiesdetails;
                disabilitydescription.DataValueField = "Code";
                disabilitydescription.DataTextField = "Description";
                disabilitydescription.DataBind();

            }
        }
        protected void submit_Click(object sender, EventArgs e)
        {
            try
            {
                DateTime dateOfBirth = new DateTime();
                bool error = false;
                string message = "";
                try
                {

                    dateOfBirth = DateTime.ParseExact(dob.Text.Trim(), "d/M/yyyy", CultureInfo.InvariantCulture);
                }
                catch (Exception y)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>Please select a valid date of birth <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    error = true;
                }
               
                    int submissioncategory = 0;
                    string tIdNo = idNumber.Text.Trim();
                    if (tIdNo.Length < 1)
                    {
                        error = true;
                        message = "Please Enter a Valid Library Staff ID No/Passport Number";
                    }
                    string tFName = firstName.Text.Trim();
                    if (tFName.Length < 1)
                    {
                        error = true;
                        message = "Please Enter a Valid Library Staff First Name";
                    }
                    string tMName = middleName.Text.Trim();
                    if (tMName.Length < 1)
                    {
                    tMName = "";
                    }
                    string tLName = lastName.Text.Trim();
                    if (tLName.Length < 1)
                    {
                        error = true;
                        message = "Please Enter a Valid Library Staff Last Name";
                    }
                    string tPosition = position.Text.Trim();
                    if (tPosition.Length < 1)
                    {
                        error = true;
                        message = "Please Enter a Valid Library Staff Position in the Library";
                    }
                    string tstaffpayroll = staffpayroll.Text.Trim();
                    if (tstaffpayroll.Length < 1)
                    {
                        error = true;
                        message = "Please Enter a Valid Library Staff Payroll Number";
                    }
                    int tHighest = highestAcademicQualification.SelectedIndex;
                    int tstaffgender= staffgender.SelectedIndex;
                    string tCampus = campus.SelectedValue;
                    string tstafethnicbackground = stafethnicbackground.SelectedValue;
                    string tstaffhomecounty = staffhomecounty.SelectedValue;
                    string tstaffNationality = staffNationality.SelectedValue;
                    string tdisabilitydescription = disabilitydescription.SelectedValue;
                    string tdisabilitycode = disabilitycode.Text.Trim();
                    int ttermsofservice = termsofservice.SelectedIndex;
                    DateTime tstaffdateoffirstappointment = new DateTime();
                    try
                    {

                        tstaffdateoffirstappointment = DateTime.ParseExact(staffdateoffirstappointment.Text.Trim(), "d/M/yyyy", CultureInfo.InvariantCulture);
                    }
                    catch (Exception y)
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>Please select a valid date of  Date of First Appointment</div>";

                        error = true;
                    }
                    DateTime tstaffofcurrrentappointment = new DateTime();
                    try
                    {

                        tstaffofcurrrentappointment = DateTime.ParseExact(staffofcurrrentappointment.Text.Trim(), "d/M/yyyy", CultureInfo.InvariantCulture);
                    }
                    catch (Exception y)
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>Please select a valid date of Date of Current Appointment </div>";

                        error = true;
                  }
                 if (error)
                 {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                 }
                 else
                 {
                  
                    string tlibrarystaffstatus = librarystaffstatus.SelectedValue;
                    int highestacademicqualificationspecializationcode = highestspecialization.SelectedIndex;
                    int secondhighestacademicqualification = secondhighestcode.SelectedIndex;
                    int secondhighestacademicqualificationcode = secondhighestspecialization.SelectedIndex;
                    string userCode = Convert.ToString(Session["Code"]);
                    string password = Convert.ToString(Session["Password"]);
                    string status = new Config().ObjNav()
                        .AddLibraryStaff(userCode, password, tIdNo, tFName, tMName, tLName, dateOfBirth, tPosition, tHighest, highestacademicqualificationspecializationcode, secondhighestacademicqualification, secondhighestacademicqualificationcode,
                            tCampus, submissioncategory, tstaffdateoffirstappointment, tstaffpayroll, tstaffofcurrrentappointment, tdisabilitydescription, tdisabilitycode, tstaffNationality, tstafethnicbackground, tstaffhomecounty, tlibrarystaffstatus, ttermsofservice, tstaffgender);
                    if (status == "success")
                    {
                        feedback.InnerHtml ="<div class='alert alert-success'>The University Library Staff Details was successfully Submitted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        feedback.InnerHtml ="<div class='alert alert-danger'>The University Library Staff Details could not be Submitted"+ status+ "</div>";
                    }
                }

            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        protected void delete_Click(object sender, EventArgs e)
        {
            try
            {
                int tIdNo = Convert.ToInt32(staffEntry.Text.Trim());
                string universityCode = Convert.ToString(Session["UniversityCode"]);
                string response = new Config().ObjNav().DeleteLibraryStaff(universityCode, tIdNo);
                string[] info = response.Split('*');
                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
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
                    .DeleteAllLibraryStaff(selectedStaffID, usercode, password);
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