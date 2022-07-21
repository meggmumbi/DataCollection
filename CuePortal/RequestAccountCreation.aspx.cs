using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class RequestAccountCreation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
                //List<string> institutionType = new List<string>();
                //institutionType.Add("----Select Institution Category------");
                //institutionType.Add("New Institution");
                //institutionType.Add("Existing Institution");
                //txtinstitutionType.DataSource = institutionType;
                //txtinstitutionType.DataBind();

                var nav = Config.ReturnNav();
                var countries = nav.countries;
                country.DataSource = countries;
                country.DataValueField = "Code";
                country.DataTextField = "Name";
                country.DataBind();

                var postCodes = nav.postcodes;
                postcode.DataSource = postCodes;
                postcode.DataValueField = "Code";
                postcode.DataTextField = "Code";
                postcode.DataBind();


                var alluniversities = nav.Universities.Where(x=> x.Type == "Institution");
                universityname.DataSource = alluniversities;
                universityname.DataValueField = "No";
                universityname.DataTextField = "Name";
                universityname.DataBind();

                List<string> universityroles = new List<string>();
                universityroles.Add("Data Officer");
                universityroles.Add("DVC");
                universityroles.Add("VC");
                userrole.DataSource = universityroles;
                userrole.DataBind();


                List<string> institutiontype = new List<string>();
                institutiontype.Add("New Institution");
                institutiontype.Add("Existing Institution");
                insttype.DataSource = institutiontype;
                insttype.DataBind();
                UpdateCity();
            }
        }
        public void Register_Click(object sender, EventArgs e)
        {
            //try
            //{

            //    bool error = false;
            //    string message = "";
            //    string taddnumber = "";
            //    try
            //    {
            //        taddnumber = idnumber.Text.Trim();
            //    }
            //    catch (Exception t)
            //    {
            //        error = true;
            //        message = "Please Enter a Valid Value for ID No./Passport No.";
            //    }
            //    string tfirstname = "";
            //    try
            //    {
            //        tfirstname = firstname.Text.Trim();
            //    }
            //    catch (Exception t)
            //    {
            //        error = true;
            //        message = "Please Enter a Valid Value for First Name";
            //    }
            //    string tmiddlname =middlname.Text.Trim();
            //    //  try
            //    //  {
            //    //    tmiddlname = middlname.Text.Trim();
            //    //  }
            //    //catch (Exception t)
            //    //{
            //    //    error = true;
            //    //    message = "Please Enter a Valid Value for Middle Name";
            //    //}
            //    string tlastname = "";
            //    try
            //    {
            //        tlastname = lastname.Text.Trim();
            //    }
            //    catch (Exception t)
            //    {
            //        error = true;
            //        message = "Please Enter a Valid Value for Last Name";
            //    }
            //    string tphonenumber = "";
            //    try
            //    {
            //        tphonenumber = phonenumber.Text.Trim();
            //    }
            //    catch (Exception t)
            //    {
            //        error = true;
            //        message = "Please Enter a Valid Value for Phone Number";
            //    }
            //    string temailaddress = "";
            //    try
            //    {
            //        temailaddress = emailaddress.Text.Trim();
            //        //var nav = Config.ReturnNav();
            //        //var emaildomain = temailaddress.Split('@');
            //        //var requests = nav.University_Emails_Domains.Where(r => r.University_Domain == emaildomain);
            //        var addr = new System.Net.Mail.MailAddress(temailaddress);
            //        if(addr.Address == temailaddress)
            //        {
            //            temailaddress = emailaddress.Text.Trim();
            //        }
            //        else
            //        {
            //            error = true;
            //            message = "Please Enter a Valid  University Email Address";

            //        }
                    
            //    }
            //    catch (Exception t)
            //    {
            //        error = true;
            //        message = "Please Enter a Valid Value for Email Address";
            //    }
            //    string taddress = "";
            //    try
            //    {
            //        taddress = address.Text.Trim();
            //    }
            //    catch (Exception t)
            //    {
            //        error = true;
            //        message = "Please Enter a Valid Value for Address";
            //    }
            //    string tpostcode = "";
            //    try
            //    {
            //        tpostcode = postcode.SelectedValue;
            //    }
            //    catch (Exception t)
            //    {
            //        error = true;
            //        message = "Please Enter a Valid Value for Post Code";
            //    }
            //    string tcity = "";
            //    try
            //    {
            //        tcity = city.Text.Trim();
            //    }
            //    catch (Exception t)
            //    {
            //        error = true;
            //        message = "Please Enter a Valid Value for City";
            //    }
            //    string tcountry = "";
            //    try
            //    {
            //        tcountry = country.SelectedValue;
            //    }
            //    catch (Exception t)
            //    {
            //        error = true;
            //        message = "Please Enter a Valid Value for Country";
            //    }
            //    string tuserrole = "";
            //    try
            //    {
            //        tuserrole = userrole.SelectedValue;
            //    }
            //    catch (Exception t)
            //    {
            //        error = true;
            //        message = "Please Enter a Valid Value for User Role";
            //    }
            //    string tuniversityname = "";
            //    try
            //    {
            //        tuniversityname = universityname.Text.Trim();
            //    }
            //    catch (Exception t)
            //    {
            //        error = true;
            //        message = "Please Enter a Valid Value for University Name";
            //    }
            //    if (error)
            //    {
            //        feedback.InnerHtml = Config.GetAlert("danger", message);
            //    }
            //    else
            //    {
            //        string status = new Config().ObjNav().Fnuseraccountcreation(taddnumber, tfirstname, tmiddlname, tlastname, tphonenumber, temailaddress, taddress, tpostcode, tcity, tcountry, tuserrole, tuniversityname);
            //        string[] info = status.Split('*');
            //        feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //        if (info[0] == "success")
            //        {
            //            feedback.InnerHtml = "<div class='alert alert-success'>The User Account  Details were successfully Submitted.Kindly wait for Account Verification from CUE <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //            Response.Redirect("Login.aspx");
            //        }
            //        else
            //        {
            //            feedback.InnerHtml = "<div class='alert alert-danger'>The User Account  Details were  not successfully Submitted.Kindly Try Again Later <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            //        }
            //    }
            //}
            //catch (Exception ex)
            //{
            //    feedback.InnerHtml = Config.GetAlert("danger", ex.Message);
            //}
       }
        protected void postCode_SelectedIndexChanged(object sender, EventArgs e)
        {
            UpdateCity();
        }

        public void UpdateCity()
        {
            var nav = Config.ReturnNav();
            var cities = nav.postcodes.Where(r => r.Code == postcode.SelectedValue);
            foreach (var myCity in cities)
            {
                city.Text = myCity.City;
            }
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static  string RequesttoCreateAccount(int tinsttype, string taddnumber, string tfirstname, string tmiddlname, string tlastname, string tphonenumber, string temailaddress, string taddress, string tpostcode, string tcity, string tcountry, int tuserrole, string tuniversityname)
        {
            var results = (dynamic)null;
            try
            {
                var validateUniversityName = "";
               
                    validateUniversityName = tuniversityname;
                    var validatetemailaddress = temailaddress.Trim();
                    string[] EmailContents = validatetemailaddress.Split('@');
                    string Useremaildomain = EmailContents[1];
                    var nav = Config.ReturnNav();
                    var Universityemaildomains = new Config().ObjNav().FngetUniversityDomain(validateUniversityName);
                    string Universityemaildomain = Convert.ToString(Universityemaildomains).Trim();
                    if (Useremaildomain != Universityemaildomain)
                    {
                        throw new System.ArgumentException("Please Provide  Valid University Official Email Address", "University Email Address");
                    }
                    tuniversityname = "";
                       // txtproposedname.Text.Trim();
                    var addr = new System.Net.Mail.MailAddress(temailaddress);
                    string status = new Config().ObjNav().Fnuseraccountcreation(taddnumber, tfirstname, tmiddlname, tlastname, tphonenumber, temailaddress, taddress, tpostcode, tcity, tcountry, tuserrole, tuniversityname);
                    string[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        results = info[0];
                    }
                    else
                    {
                        results = info[1];
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
