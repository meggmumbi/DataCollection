using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class QualityAudit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           // var nav = Config.ReturnNav();
           // try
           // {
           //     Boolean changed = Convert.ToBoolean(Session["ChangedPassword"]);
           //     if (!changed)
           //     {
           //       //  Response.Redirect("Settings.aspx");
           //     }
           // }
           // catch (Exception)
           // {
           ////     Response.Redirect("Settings.aspx");
           // }
           // if (!IsPostBack)
           // {
           //     List<String> categories= new List<string>();
           //     categories.Add("Public Chartered University");
           //     categories.Add("Public University Constituent College");
           //     categories.Add("Private Chartered University");
           //     categories.Add("Private Constituent College");
           //     categories.Add("Operating with Letter of Interim Authority");
           //     statusCategory.DataSource = categories;
           //     statusCategory.DataBind();
           //     List<String> sponsors = new List<string>();
           //     sponsors.Add("GOVERNMENT");
           //     sponsors.Add("INDIVIDUAL");
           //     sponsors.Add("NON GOVERNMENT ORGANIZATION");
           //     sponsors.Add("RELIGIOUS ORGANIZATION");
           //     institutionSponsor.DataSource = sponsors;
           //     institutionSponsor.DataBind();
           //     var postCodes = nav.postcodes;
           //     institutionPostCode.DataSource = postCodes;
           //     institutionPostCode.DataValueField = "Code";
           //     institutionPostCode.DataTextField = "Code";
           //     institutionPostCode.DataBind();

           //     var constituencies = nav.constituencies;
           //     mainCampusConstituency.DataSource = constituencies;
           //     mainCampusConstituency.DataValueField = "Code";
           //     mainCampusConstituency.DataTextField = "Description";
           //     mainCampusConstituency.DataBind();

           //     var counties = nav.homecounties.ToList().OrderBy(r=>r.County_Name);
           //     mainCampusCounty.DataSource = counties;
           //     mainCampusCounty.DataValueField = "Code";
           //     mainCampusCounty.DataTextField = "County_Name";
           //     mainCampusCounty.DataBind();

           //     var domains = nav.programdomains;
           //     vcDomainOfSpecialization.DataSource = domains;
           //     vcDomainOfSpecialization.DataValueField = "Code";
           //     vcDomainOfSpecialization.DataTextField = "Description";
           //     vcDomainOfSpecialization.DataBind();

           //     List<String> levels = new List<string>();
           //     levels.Add("Certificate");
           //     levels.Add("Diploma");
           //     levels.Add("Bachelors");
           //     levels.Add("Postgraduate Diploma");
           //     levels.Add("Masters");
           //     levels.Add("Doctorate");
           //     vcHighestAcademicLevel.DataSource = levels;
           //     vcHighestAcademicLevel.DataBind();
           //     //,,,, , 
           //     var profiles = nav.UniversityProfile.Where(r => r.No == Convert.ToString(Session["UniversityCode"]));
           //     foreach (var profile in profiles)
           //     {
           //         universityName.InnerText = profile.Name;
           //         statusCategory.SelectedValue = profile.Status_Category;
           //         institutionSponsor.SelectedValue = profile.Sponsor_of_Institution;
           //         institutionEmailAddress.Text = profile.E_Mail;
           //         institutionPhoneNumber.Text = profile.Phone_No;
           //         institutionPostAddress.Text = profile.Address;
           //         institutionPostCode.SelectedValue = profile.Post_Code;
           //         mainCampusCounty.SelectedValue = profile.County_of_Main_Campus;
           //         mainCampusConstituency.SelectedValue = profile.Constituency_of_Main_Campus;
           //         mainCampusTown.Text = profile.Town_of_Main_Campus;
           //         vcName.Text = profile.VC_Name;
           //         vcHighestAcademicLevel.SelectedValue = profile.VC_Highest_Academic;
           //         vcDomainOfSpecialization.SelectedValue = profile.VC_Specialization_Domain;
           //         vcOfficialEmail.Text = profile.VC_Official_Email_Address;
           //         vcOfficialPhone.Text = profile.VC_Official_Phone;


           //     }
           // }
            
        }

    //    protected void editGeneralDetails_Click(object sender, EventArgs e)
    //    {
    //        // statusCategory institutionSponsor institutionEmailAddress institutionPhoneNumber
    //        //institutionPostAddress institutionPostCode mainCampusCounty mainCampusConstituency 
    //        //mainCampusTown
    //        String universityCode = Convert.ToString(Session["UniversityCode"]);
    //        int tStatus = statusCategory.SelectedIndex;
    //        int tSponsor = institutionSponsor.SelectedIndex;
    //        String tEmail = institutionEmailAddress.Text.Trim();
    //        String tPhone = institutionPhoneNumber.Text.Trim();
    //        String tPostAddress = institutionPostAddress.Text.Trim();
    //        String tPostCode = institutionPostCode.SelectedValue.Trim();
    //        String tCounty= mainCampusCounty.SelectedValue.Trim();
    //        String tConstituency = mainCampusConstituency.SelectedValue.Trim();
    //        String tTown = mainCampusTown.Text.Trim();
    //        String response = new Config().ObjNav().EditGeneralDetails(universityCode, tStatus, tSponsor,
    //            tEmail, tPhone, tPostAddress, tPostCode, tCounty, tConstituency, tTown);
    //        String[] info = response.Split('*');
    //        feedback.InnerHtml = "<div class ='alert alert-"+info[0]+"'>"+info[1]+"</div>";

    //    }

    //    protected void editVcDetails_Click(object sender, EventArgs e)
    //    {
    //        String universityCode = Convert.ToString(Session["UniversityCode"]);
    //        // vcName vcHighestAcademicLevel vcDomainOfSpecialization vcOfficialEmail vcOfficialPhone
    //        String tVcName = vcName.Text.Trim();
    //        int tHighest = vcHighestAcademicLevel.SelectedIndex;
    //        String tDomain = vcDomainOfSpecialization.SelectedValue.Trim();
    //        String tEmail = vcOfficialEmail.Text.Trim();
    //        String tPhone = vcOfficialPhone.Text.Trim();
    //        String response = new Config().ObjNav().EditVCDetails(universityCode, tVcName, tHighest,
    //            tDomain, tEmail, tPhone);
    //        String[] info = response.Split('*');
    //        feedback.InnerHtml = "<div class ='alert alert-" + info[0] + "'>" + info[1] + "</div>";

    //    }
    }
}