using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class UniversityGeneralDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            var nav = Config.ReturnNav();
            try
            {
                bool changed = Convert.ToBoolean(Session["ChangedPassword"]);
                if (!changed)
                {
                    //  Response.Redirect("Settings.aspx");
                }
            }
            catch (Exception)
            {
                //     Response.Redirect("Settings.aspx");
            }
            if (!IsPostBack)
            {
                List<string> categories = new List<string>();
                categories.Add("Public Chartered University");
                categories.Add("Public University Constituent College");
                categories.Add("Private Chartered University");
                categories.Add("Private Constituent College");
                categories.Add("Operating with Letter of Interim Authority");
                statusCategory.DataSource = categories;
                statusCategory.DataBind();
                List<string> sponsors = new List<string>();
                sponsors.Add("GOVERNMENT");
                sponsors.Add("INDIVIDUAL");
                sponsors.Add("NON GOVERNMENT ORGANIZATION");
                sponsors.Add("RELIGIOUS ORGANIZATION");
                institutionSponsor.DataSource = sponsors;
                institutionSponsor.DataBind();
                var postCodes = nav.postcodes;
                institutionPostCode.DataSource = postCodes;
                institutionPostCode.DataValueField = "Code";
                institutionPostCode.DataTextField = "Code";
                institutionPostCode.DataBind();

                var constituencies = nav.constituencies;
                mainCampusConstituency.DataSource = constituencies;
                mainCampusConstituency.DataValueField = "Code";
                mainCampusConstituency.DataTextField = "Description";
                mainCampusConstituency.DataBind();

                var counties = nav.homecounties.ToList().OrderBy(r => r.County_Name);
                mainCampusCounty.DataSource = counties;
                mainCampusCounty.DataValueField = "Code";
                mainCampusCounty.DataTextField = "County_Name";
                mainCampusCounty.DataBind();

                var domains = nav.programdomains;
                vcDomainOfSpecialization.DataSource = domains;
                vcDomainOfSpecialization.DataValueField = "Code";
                vcDomainOfSpecialization.DataTextField = "Description";
                vcDomainOfSpecialization.DataBind();

                List<string> levels = new List<string>();
                levels.Add("Certificate");
                levels.Add("Diploma");
                levels.Add("Bachelors");
                levels.Add("Postgraduate Diploma");
                levels.Add("Masters");
                levels.Add("Doctorate");
                vcHighestAcademicLevel.DataSource = levels;
                vcHighestAcademicLevel.DataBind();
                //,,,, , 
                var profiles = nav.UniversityProfile.Where(r => r.No == Convert.ToString(Session["UniversityCode"]));
                foreach (var profile in profiles)
                {
                    universityName.InnerText = profile.Name;
                    statusCategory.SelectedValue = profile.Status_Category;
                    institutionSponsor.SelectedValue = profile.Sponsor_of_Institution;
                    institutionEmailAddress.Text = profile.E_Mail;
                    institutionPhoneNumber.Text = profile.Phone_No;
                    institutionPostAddress.Text = profile.Address;
                    institutionPostCode.SelectedValue = profile.Post_Code;
                    mainCampusCounty.SelectedValue = profile.County_of_Main_Campus;
                    mainCampusConstituency.SelectedValue = profile.Constituency_of_Main_Campus;
                    mainCampusTown.Text = profile.Town_of_Main_Campus;
                    vcName.Text = profile.VC_Name;
                    vcHighestAcademicLevel.SelectedValue = profile.VC_Highest_Academic;
                    vcDomainOfSpecialization.SelectedValue = profile.VC_Specialization_Domain;
                    vcOfficialEmail.Text = profile.VC_Official_Email_Address;
                    vcOfficialPhone.Text = profile.VC_Official_Phone;


                }
            }

        }

        protected void editGeneralDetails_Click(object sender, EventArgs e)
        {
            // statusCategory institutionSponsor institutionEmailAddress institutionPhoneNumber
            //institutionPostAddress institutionPostCode mainCampusCounty mainCampusConstituency 
            //mainCampusTown
            try
            {
                string message = "";
                bool error = false;
                string universityCode = Convert.ToString(Session["UniversityCode"]);
                int tStatus = statusCategory.SelectedIndex;
                int tSponsor = institutionSponsor.SelectedIndex;
                //  string tEmail = institutionEmailAddress.Text.Trim();
                string tEmail = "";
                try
                {
                    tEmail = institutionEmailAddress.Text.Trim();
                    if (tEmail.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the University Valid Email Address";
                }
                //string tPhone = institutionPhoneNumber.Text.Trim();
                string tPhone = "";
                try
                {
                    tPhone = institutionPhoneNumber.Text.Trim();
                    if (tPhone.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the University Valid Phone Number";
                }
                // string tPostAddress = institutionPostAddress.Text.Trim();
                string tPostAddress = "";
                try
                {
                    tPostAddress = institutionPostAddress.Text.Trim();
                    if (tPostAddress.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the University Valid Post Address";
                }
                //string tPostCode = institutionPostCode.SelectedValue.Trim();
                string tPostCode = "";
                try
                {
                    tPostCode = institutionPostCode.SelectedValue.Trim();
                    if (tPostCode.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the University Valid Post Code";
                }
                // string tCounty = mainCampusCounty.SelectedValue.Trim();
                string tCounty = "";
                try
                {
                    tCounty = mainCampusCounty.SelectedValue.Trim();
                    if (tCounty.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the University Valid County";
                }
                // string tConstituency = mainCampusConstituency.SelectedValue.Trim();
                string tConstituency = "";
                try
                {
                    tConstituency = mainCampusConstituency.SelectedValue.Trim();
                    if (tConstituency.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the University Valid Constituency";
                }
                // string tTown = mainCampusTown.Text.Trim();
                string tTown = "";
                try
                {
                    tTown = mainCampusTown.Text.Trim();
                    if (tTown.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the University Valid Town";
                }
                if (error)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    string response = new Config().ObjNav().EditGeneralDetails(universityCode, tStatus, tSponsor,
                tEmail, tPhone, tPostAddress, tPostCode, tCounty, tConstituency, tTown);
                    string[] info = response.Split('*');
                    feedback.InnerHtml = "<div class ='alert alert-" + info[0] + "'>" + info[1] + "</div>";

                }
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void editVcDetails_Click(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string universityCode = Convert.ToString(Session["UniversityCode"]);
                // vcName vcHighestAcademicLevel vcDomainOfSpecialization vcOfficialEmail vcOfficialPhone
                // string tVcName = vcName.Text.Trim();
                string tVcName = "";
                try
                {
                    tVcName = vcName.Text.Trim();
                    if (tVcName.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the Vice Chancellor Valid Name";
                }

                int tHighest = vcHighestAcademicLevel.SelectedIndex;
                //string tDomain = vcDomainOfSpecialization.SelectedValue.Trim();
                string tDomain = "";
                try
                {
                    tDomain = vcDomainOfSpecialization.SelectedValue.Trim();
                    if (tDomain.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the  Vice Chancellor Valid Domain of Specialization";
                }
                // string tEmail = vcOfficialEmail.Text.Trim();
                string tEmail = "";
                try
                {
                    tEmail = vcOfficialEmail.Text.Trim();
                    if (tEmail.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the  Vice Chancellor Valid Email Address";
                }
                // string tPhone = vcOfficialPhone.Text.Trim();
                string tPhone = "";
                try
                {
                    tPhone = vcOfficialPhone.Text.Trim();
                    if (tPhone.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the  Vice Chancellor Valid Phone Number";
                }
                if (error)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    string response = new Config().ObjNav().EditVCDetails(universityCode, tVcName, tHighest, tDomain, tEmail, tPhone);
                    string[] info = response.Split('*');
                    feedback.InnerHtml = "<div class ='alert alert-" + info[0] + "'>" + info[1] + "</div>";

                }
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}