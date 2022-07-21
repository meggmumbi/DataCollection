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
    public partial class QAqestions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void previouspage_Click(object sender, EventArgs e)
        {
            Response.Redirect("QualityAudit.aspx");
        }

        protected void attachdocument_Click(object sender, EventArgs e)
        {
            try
            {
                string accreditationNo = Request.QueryString["SARNo"];
                accreditationNo = accreditationNo.Replace('/', '_');
                accreditationNo = accreditationNo.Replace(':', '_');
                string path1 = Config.FilesLocation() + "Institution Audit Response/";
                string str1 = Convert.ToString(accreditationNo);
                //string doc = "PAYMENT_DOCUMENT";
                //+"_" + doc
                string folderName = path1 + str1 + "/";
                bool DocUploaded = false;
                bool error = false;
                string message = "";
                try
                {
                    if (document.HasFile)
                    {
                        string extension = System.IO.Path.GetExtension(document.FileName);
                        if (extension == ".pdf" || extension == ".PDF" || extension == ".Pdf")
                        {
                            string filename = "PAYMENT_DOCUMENT" + extension;
                            if (!Directory.Exists(folderName))
                            {
                                Directory.CreateDirectory(folderName);
                            }
                            if (File.Exists(folderName + filename))
                            {
                                File.Delete(folderName + filename);
                            }
                            document.SaveAs(folderName + filename);
                            if (File.Exists(folderName + filename))
                            {
                                DocUploaded = true;
                            }
                        }
                        else
                        {
                            error = true;
                            message += message.Length > 0 ? "<br>" : "";
                            message += "The file extension of the document is not allowed,Kindly upload pdf files only";
                        }

                    }
                    else
                    {
                        error = true;
                        message += message.Length > 0 ? "<br>" : "";
                        message += "The file extension of the document is not allowed,Kindly upload pdf files only";

                    }
                }
                catch (Exception ex)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "The file extension of the document is not allowed,Kindly upload pdf files only" + ex;
                }

                if (error)
                {
                    message += "The file extension of the document is not allowed,Kindly upload pdf files only";
                }
                else
                {
                    String SARNo = Request.QueryString["SARNo"];
                    string status = new Config().ObjNav().FnCheckAuditPaymentDocument(SARNo, DocUploaded);
                    string[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
            }
            catch (Exception ex)
            {
                documentsfeedback.InnerHtml = ex.Message;
            }

        }
        protected void deleteFile_Click(object sender, EventArgs e)
        {
            try
            {
                String tFileName = txtfileName.Text.Trim();
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Institution Audit Response/";
                String imprestNo = Request.QueryString["SARNo"];
                imprestNo = imprestNo.Replace('/', '_');
                imprestNo = imprestNo.Replace(':', '_');
                //string doc = "PAYMENT_DOCUMENT";
                //+"_" + doc
                String documentDirectory = filesFolder + imprestNo + "/";
                String myFile = documentDirectory + tFileName;
                if (File.Exists(myFile))
                {
                    File.Delete(myFile);
                    if (File.Exists(myFile))
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The file could not be deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-success'>The file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>A file with the given name does not exist in the server <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }
            catch (Exception m)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }

        }

        protected void SubmitSAR_Click(object sender, EventArgs e)
        {
            try
            {
                bool error = false;
                string message = "";


                string allData = new Config().ObjNav().FnGetAllAuditLines(Request.QueryString["SARNo"]);
                String[] info1 = allData.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                if (info1 != null)
                {
                    foreach (var data in info1)
                    {
                        String[] arr = data.Split('*');
                        if (arr[1].Length < 0)
                        {
                            error = true;
                            message = "Kindly make sure your answer all the questions before submitting your SAR to CUE!";
                        }
                    }
                }
                if(error)
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-success'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    string SARNo = Request.QueryString["SARNo"];
                    string universityCode = Convert.ToString(Session["UniversityCode"]);
                    string status = new Config().ObjNav().FnSubmitQASARResponse(SARNo, universityCode);
                    string[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
            }
            catch (Exception ex)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void print_Click(object sender, EventArgs e)
        {
            string tAccreditationNo = Request.QueryString["SARNo"].Trim();
            Response.Redirect("DownloadSAR.aspx?accreditationNo=" + tAccreditationNo);
        }
    }
}