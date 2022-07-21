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
    public partial class VerificationsofAcademicResources : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void SendFeedback_Click(object sender, EventArgs e)
        {
            try
            {
                string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                string tverificationNumber = verificationNumber.Text.Trim();
                string tsubcomponentcode = subcomponentcode.Text.Trim();
                string tcomponentcode = componentcode.Text.Trim();
                string tuniversityfeedback = universityfeedback.Text.Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav().FnSubmitUniversityAccreditationFeedback(accreditationNo, tverificationNumber, tcomponentcode, tsubcomponentcode, tuniversityfeedback);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    universityfeedback.Text = "";
                    string filesFolder = ConfigurationManager.AppSettings["FilesLocation"];
                    string filelocations = filesFolder + "Prog Site Insp Comments Card" + "/";
                    tverificationNumber = verificationNumber.Text.Trim();
                    tverificationNumber = tverificationNumber.Replace('/', '_');
                    tverificationNumber = tverificationNumber.Replace(':', '_');
                    String documentDirectory = filelocations + tverificationNumber + "/";
                    string myName = "";
                    string subcode = tsubcomponentcode;
                    if (evidences.HasFile)
                    {
                        try
                        {
                            if (Directory.Exists(filelocations))
                            {
                                string tevidences = System.IO.Path.GetExtension(evidences.FileName);
                                Boolean createDirectory = true;
                                try
                                {
                                    if (!Directory.Exists(documentDirectory))
                                    {
                                        Directory.CreateDirectory(documentDirectory);
                                    }
                                }
                                catch (Exception)
                                {
                                    createDirectory = false;
                                    feedback.InnerHtml = "<div class='alert alert-danger'>We could not create a directory for your documents. Please try again" +
                                                                    "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                                }
                                if (createDirectory)
                                {
                                    if (new Config().IsAllowedExtension(tevidences))
                                    {

                                        string evidencesFile = Session["UniversityCode"] + "_" + tverificationNumber + '_' + subcode + '_' + tevidences + "_Evidence_" + evidences.FileName;
                                        evidencesFile = evidencesFile.Replace(':', '_');
                                        evidencesFile = documentDirectory + evidencesFile;
                                        myName = evidencesFile;
                                        evidences.SaveAs(evidencesFile);
                                        if (File.Exists(evidencesFile))
                                        {
                                            feedback.InnerHtml =
                                                "<div class='alert alert-success'>The Evidence had been successfully Submitted. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                            universityfeedback.Text.Trim();
                                        }
                                        else
                                        {
                                            feedback.InnerHtml =
                                                "<div class='alert alert-danger'>The evidence could not be uploaded. " + myName + " Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                        }


                                    }
                                    else
                                    {
                                        feedback.InnerHtml = "<div class='alert alert-danger'>The documents' file extension is not allowed. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                    }

                                }
                                else
                                {
                                    feedback.InnerHtml = "<div class='alert alert-danger'>The documents folder defined does not exist in the server. Please contact support. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                }

                            }
                        }
                        catch (Exception ex)
                        {
                            feedback.InnerHtml = "<div class='alert alert-danger'>The documents could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                        }
                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>Please select the evidence to upload.  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    }


                }
                else
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception y)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + y.Message + "</div>";
            }
        }

        protected void submitfeedbacktocue_Click(object sender, EventArgs e)
        {
            try
            {
                string accreditationNo = Request.QueryString["accreditationNo"];
                string universitycode = Convert.ToString(Session["UniversityCode"]);

                string status = new Config().ObjNav().FnSendNotification(universitycode, accreditationNo);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    feedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                    "setTimeout(function() { window.location.replace('Accreditation.aspx') }, 4000);", true);
                }
                else
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }
            catch (Exception y)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + y.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}