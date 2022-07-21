using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Services.Protocols;
using System.Web.UI;
using System.Web.UI.WebControls;



namespace CicPortal
{
    public partial class Signup : System.Web.UI.Page
    {
       
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = Config.ReturnNav();
               
                List<string> sponsors = new List<string>();
                sponsors.Add("Government");
                sponsors.Add("Individual");
                sponsor.DataSource = sponsors;
                sponsor.DataBind();
                var counties = nav.homecounties;
                county.DataSource = counties;
                county.DataValueField = "Code";
                county.DataTextField = "County_Name";
                county.DataBind();
                filterConstituencies();
                 var postCodes = nav.postcodes;
                postCode.DataSource = postCodes;
                postCode.DataValueField = "Code";
                postCode.DataTextField = "Code";
                postCode.DataBind();
                UpdateCity();

            }
            
        }


        protected void signup_Click(object sender, EventArgs e)
        {
            try
            {
                string tProposedName = proposedName.Text.Trim(),
                    tKraPin = kraPin.Text.Trim(),
                    tProposedLocation = proposedLocation.Text.Trim(),
                    tCounty = county.SelectedValue,
                    tConstituency = constituency.SelectedValue,
                    tPostAddress = postAddress.Text.Trim(),
                    tPostCode = postCode.SelectedValue,
                    tInstitutionWebsite = institutionWebsite.Text.Trim(),
                    tPhoneNumber = phoneNumber.Text.Trim(),
                    tEmailAddress = emailAddress.Text.Trim(),
                    tPassword = password.Text.Trim(),
                    tConfirmPassword = confirmPassword.Text.Trim();
                int tSponsor = sponsor.SelectedIndex;
                string status = new Config().ObjNav()
                    .InstitutionSignup(tProposedName, tKraPin,
                        tProposedLocation, tSponsor, tCounty, tConstituency, tPostAddress, tPostCode,
                        tInstitutionWebsite,
                        tPhoneNumber, tEmailAddress, tPassword, tConfirmPassword);
                string[] info = status.Split('*');
                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " </div>";
            }
                 catch (Exception t)
             {
                 feedback.InnerHtml = "<div class='alert alert-danger'>We encountered an error while signing you up. Please try again later. </div>";
             }
           
        }

        protected void postCode_SelectedIndexChanged(object sender, EventArgs e)
        {
            UpdateCity();
        }

        public void UpdateCity()
        {
            var nav = Config.ReturnNav();
            var cities = nav.postcodes.Where(r => r.Code == postCode.SelectedValue);
            foreach (var myCity in cities)
            {
                city.Text = myCity.City;
            }
        }
        protected void county_SelectedIndexChanged(object sender, EventArgs e)
        {
            filterConstituencies();
        }
        public void filterConstituencies()
        {
            var nav = Config.ReturnNav();
            var cities = nav.constituencies.Where(r => r.County == county.SelectedValue);
            constituency.DataSource = cities;
            constituency.DataValueField = "Code";
            constituency.DataTextField = "Description";
            constituency.DataBind();
        }
    }

}