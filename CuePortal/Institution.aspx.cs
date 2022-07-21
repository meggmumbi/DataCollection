using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class Institution : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = Config.ReturnNav();
                string institutionstatus = Convert.ToString(Session["InstitutionStatus"]);
                if (institutionstatus == "Chartered")
                {
                    var accType = nav.AccreditationCategories.Where(x => x.Code == "CINS" || x.Code == "ODELCENTRE" || x.Code == "CCINS");
                    accreditationType.DataSource = accType;
                    accreditationType.DataValueField = "Code";
                    accreditationType.DataTextField = "Description";
                    accreditationType.DataBind();
                }
                if (institutionstatus == "Under LIA")
                {
                    var accType = nav.AccreditationCategories.Where(x => x.Code == "CHARTER" || x.Code == "ODELCENTRE");
                    accreditationType.DataSource = accType;
                    accreditationType.DataValueField = "Code";
                    accreditationType.DataTextField = "Description";
                    accreditationType.DataBind();
                }
                if (institutionstatus == "Constituent College")
                {
                    var accType = nav.AccreditationCategories.Where(x => x.Code == "CHARTER" || x.Code == "ODELCENTRE");
                    accreditationType.DataSource = accType;
                    accreditationType.DataValueField = "Code";
                    accreditationType.DataTextField = "Description";
                    accreditationType.DataBind();
                }
                if (institutionstatus == "Proposed")
                {
                    var accType = nav.AccreditationCategories.Where(x => x.Code == "ODELINST" || x.Code == "TECH" || x.Code == "LIA" || x.Code == "SDAI");
                    accreditationType.DataSource = accType;
                    accreditationType.DataValueField = "Code";
                    accreditationType.DataTextField = "Description";
                    accreditationType.DataBind();
                }
                if (institutionstatus == "Proposed")
                {
                    divsponsor.Visible = true;
                    divesponsor.Visible = false;

                    var sp = nav.SponsorSetup;
                    sponsor.DataSource = sp;
                    sponsor.DataTextField = "Sponsor_Name";
                    sponsor.DataValueField = "Sponsor_Name";
                    sponsor.DataBind();
                }
                else
                {
                    divsponsor.Visible = false;
                    divesponsor.Visible = true;
                }

                var counties = nav.homecounties;
                county.DataSource = counties;
                county.DataValueField = "Code";
                county.DataTextField = "County_Name";
                county.DataBind();

                var postCodes = nav.postcodes;
                postCode.DataSource = postCodes;
                postCode.DataValueField = "Code";
                postCode.DataTextField = "Code";
                postCode.DataBind();

                string customerN = Convert.ToString(Session["UniversityCode"]);
                var customerlist = nav.Customers.Where(x => x.No == customerN);
                foreach (var mydata in customerlist)
                {
                    tCounty.Text = mydata.County_Name;
                    tConstituency.Text = mydata.Constituency_Code_Main_Campus;
                    tPostAddress.Text = mydata.Address;
                    tPostcode.Text = mydata.Post_Code;
                    tCity.Text = mydata.City;
                    tInstitutionweb.Text = mydata.Home_Page;
                    tPhoneno.Text = mydata.Phone_No;
                    tEmail.Text = mydata.E_Mail;
                }

                string applicationNo = "";
                try
                {
                    applicationNo = Request.QueryString["applicationNo"];
                    if (string.IsNullOrEmpty(applicationNo))
                    {
                        applicationNo = "";
                    }
                }
                catch
                {
                    applicationNo = "";
                }
                if (!string.IsNullOrEmpty(applicationNo))
                {
                    var iA = nav.InstitutionAccreditation.Where(x => x.Accreditation_No == applicationNo);
                    foreach(var item in iA)
                    {
                        accreditationType.SelectedValue = item.Accreditation_Code;
                        proposedName.Text = item.Institution_Campus;
                        proposedLocation.Text = item.Proposed_Location;
                        sponsor.SelectedValue = item.Sponsor;
                        //sponsorname.Text = item.
                        try
                        {
                            string tsponsor = sponsor.SelectedValue;
                            if (tsponsor == "Corporate Body")
                            {
                                divsponsorname.Visible = true;
                            }
                            else
                            {
                                divsponsorname.Visible = false;
                            }
                        }
                        catch
                        {

                        }
                    }
                }
            }
        }

        protected void apply_Click(object sender, EventArgs e)
        {
            try
            {
                bool error = false;
                string message = "";
                string tProposedName = proposedName.Text.Trim(),
                // tKraPin = kraPin.Text.Trim(),
                tProposedLocation = proposedLocation.Text.Trim(),
                tCounty = county.SelectedValue,
                taccreditationType = accreditationType.SelectedValue,
                tConstituency = constituency.SelectedValue,
                tsponsor = sponsor.Text.Trim(),
                tPostAddress = postAddress.Text.Trim(),
                tPostCode = postCode.SelectedValue,
                tInstitutionWebsite = institutionWebsite.Text.Trim(),
                tPhoneNumber = phoneNumber.Text.Trim(),
                tsponsorname = sponsorname.Text.Trim(),
                tEmailAddress = emailAddress.Text.Trim();

                if(string.IsNullOrEmpty(tProposedName))
                {
                    error = true;
                    message = "Kindly enter the institution proposed name";
                }

                if (string.IsNullOrEmpty(tProposedLocation))
                {
                    error = true;
                    message = "Kindly enter the institution location to proceed";
                }

                if (!appletter.HasFile)
                {
                    error = true;
                    message = "Kindly attach application document to proceed";
                }

                if (!selfassessment.HasFile)
                {
                    error = true;
                    message = "Kindly attach document to proceed";
                }
                if(string.IsNullOrEmpty(tsponsor))
                {
                    tsponsor = "";
                }
                string docNo = "";
                try
                {
                    docNo = Request.QueryString["applicationNo"];
                    if (string.IsNullOrEmpty(docNo))
                    {
                        docNo = "";
                    }
                }
                catch
                {
                    docNo = "";
                }

                if (error)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + message+ " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    string userCode = Convert.ToString(Session["UniversityCode"]);
                    string password = Convert.ToString(Session["Password"]);
                    string response = new Config().ObjNav().ApplyForAccreditation(docNo, tProposedName, tProposedLocation, tPostAddress, tPostCode, tEmailAddress, taccreditationType, tInstitutionWebsite, tsponsorname, tConstituency, tPhoneNumber, tsponsor, userCode, tCounty);
                    string[] info = response.Split('*');
                    if (info[0] == "success")
                    {
                        Session["applicationNo"] = info[2];
                       
                        bool ApplicationDocUploaded = false;
                        bool SAR = false;
                        string accreditationNo = info[2];
                        accreditationNo = accreditationNo.Replace('/', '_');
                        accreditationNo = accreditationNo.Replace(':', '_');
                        string path1 = Config.FilesLocation() + "Unprocessed Insitution/";
                        string str1 = Convert.ToString(accreditationNo);
                        string folderName = path1 + str1 + "/";
                        try
                        {
                            if (appletter.HasFile)
                            {
                                string extension = System.IO.Path.GetExtension(appletter.FileName);
                                if (extension == ".pdf" || extension == ".PDF" || extension == ".Pdf")
                                {
                                    string filename = "APPLICATION_LETTER" + extension;
                                    if (!Directory.Exists(folderName))
                                    {
                                        Directory.CreateDirectory(folderName);
                                    }
                                    if (File.Exists(folderName + filename))
                                    {
                                        File.Delete(folderName + filename);
                                    }
                                    appletter.SaveAs(folderName + filename);
                                    if (File.Exists(folderName + filename))
                                    {
                                        ApplicationDocUploaded = true;
                                    }
                                }
                                else
                                {
                                    error = true;
                                    message += message.Length > 0 ? "<br>" : "";
                                    message += "The file extension of the Application Letter is not allowed,Kindly upload pdf files only";
                                }

                            }
                            else
                            {
                                error = true;
                                message += message.Length > 0 ? "<br>" : "";
                                message += "The file extension of the Application Letter is not allowed,Kindly upload pdf files only";

                            }
                        }
                        catch (Exception ex)
                        {
                            error = true;
                            message += message.Length > 0 ? "<br>" : "";
                            message += "The file extension of the Application Letter is not allowed,Kindly upload pdf files only" + ex;
                        }

                        try
                        {
                            if (selfassessment.HasFile)
                            {
                                string extension = System.IO.Path.GetExtension(selfassessment.FileName);
                                if (extension == ".pdf" || extension == ".PDF" || extension == ".Pdf")
                                {
                                    string filename = "SELF_ASSESSMENT_REPORT" + extension;
                                    if (!Directory.Exists(folderName))
                                    {
                                        Directory.CreateDirectory(folderName);
                                    }
                                    if (File.Exists(folderName + filename))
                                    {
                                        File.Delete(folderName + filename);
                                    }
                                    selfassessment.SaveAs(folderName + filename);
                                    if (File.Exists(folderName + filename))
                                    {
                                        SAR = true;
                                    }
                                }
                                else
                                {
                                    error = true;
                                    message += message.Length > 0 ? "<br>" : "";
                                    message += "The file extension of the Self Assessment Report is not allowed,Kindly upload pdf files only";
                                }

                            }
                            else
                            {
                                error = true;
                                message += message.Length > 0 ? "<br>" : "";
                                message += "The file extension of the Self Assessment Report is not allowed,Kindly upload pdf files only";

                            }
                        }
                        catch (Exception ex)
                        {
                            error = true;
                            message += message.Length > 0 ? "<br>" : "";
                            message += "The file extension of the Self Assessment Report is not allowed,Kindly upload pdf files only" + ex;
                        }

                        if (ApplicationDocUploaded == true && SAR == true)
                        {
                            error = false;
                            message += message.Length > 0 ? "<br>" : "";
                            //message += "The general details have been saved successfully";
                            feedback.InnerHtml = "<div class='alert alert-success'>General details successfully submitted<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }
                        else
                        {
                            error = true;
                            message += message.Length > 0 ? "<br>" : "";
                            //message += "The documents were not uploaded, kindly try again!";
                            feedback.InnerHtml = "<div class='alert alert-success'>Kindly upload documents to proceed<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }

                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-success'>" + info[2] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
            }
            catch (Exception ex)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>We encountered an error while creating your request. Please try again later" + ex + " </div>";

            }
        }

        protected void terminateapplication_Click(object sender, EventArgs e)
        {
            try
            {
                string txtNoterminate = noterminate.Text.Trim();
                String status = new Config().ObjNav().FnTerminateApplication(txtNoterminate);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    terminate.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
                else
                {
                    terminate.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }
            catch (Exception ex)
            {
                terminate.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void sponsor_SelectedIndexChanged(object sender, EventArgs e)
        {
            string tsponsor = sponsor.SelectedValue;
            if (tsponsor == "Corporate Body" || tsponsor == "Individual")
            {
                divsponsorname.Visible = true;
            }
            else
            {
                divsponsorname.Visible = false;
            }
        }

        protected void accreditationType_SelectedIndexChanged(object sender, EventArgs e)
        {

            if (accreditationType.SelectedValue == "ODELCENTRE")
            {
                documentdata.Text = "Centre Profile";
            }
            if (accreditationType.SelectedValue == "CINS")
            {
                documentdata.Text = "Campus Profile";
            }
            if (accreditationType.SelectedValue == "CHARTER")
            {
                documentdata.Text = "Self Assessment Report";
            }
            if (accreditationType.SelectedValue == "LIA" || accreditationType.SelectedValue == "SDAI" || accreditationType.SelectedValue == "CCINS")
            {
                documentdata.Text = "Proposal Document";
            }
            //populate sponsor
            string institutionstatus = Convert.ToString(Session["InstitutionStatus"]);
            if (institutionstatus != "Proposed")
            {
                if (accreditationType.SelectedValue == "ODELCENTRE" || accreditationType.SelectedValue == "CINS")
                {
                    var nav = Config.ReturnNav();
                    string customerN = Convert.ToString(Session["UniversityCode"]);
                    var customerlist = nav.Customers.Where(x => x.No == customerN);
                    foreach (var mydata in customerlist)
                    {
                        esponsor.Text = mydata.Name;
                    }
                }
                else
                {
                    var nav = Config.ReturnNav();
                    string customerN = Convert.ToString(Session["UniversityCode"]);
                    var customerlist = nav.Customers.Where(x => x.No == customerN);
                    foreach (var mydata in customerlist)
                    {
                        esponsor.Text = mydata.Sponsor;
                    }
                }
            }
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

        protected void county_SelectedIndexChanged(object sender, EventArgs e)
        {
            filterConstituencies();
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

        protected void deleteFile_Click(object sender, EventArgs e)
        {
            try
            {
                String tFileName = fileName.Text.Trim();
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Unprocessed Insitution/";
                string imprestNo = "";
                try
                {
                    imprestNo = Convert.ToString(Session["applicationNo"]);
                    if (string.IsNullOrEmpty(imprestNo))
                    {
                        imprestNo = Request.QueryString["applicationNo"];
                    }
                }
                catch
                {
                    imprestNo = "";
                }
                imprestNo = imprestNo.Replace('/', '_');
                imprestNo = imprestNo.Replace(':', '_');
                String documentDirectory = filesFolder + imprestNo + "/";
                String myFile = documentDirectory + tFileName;
                if (File.Exists(myFile))
                {
                    File.Delete(myFile);
                    if (File.Exists(myFile))
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>The file could not be deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-success'>The file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                else
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>A file with the given name does not exist in the server <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }



            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }

        }
    }
}