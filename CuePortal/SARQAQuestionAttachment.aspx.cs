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
    public partial class SARQAQuestionAttachment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string SARNo = Request.QueryString["SARNo"];
                string sectionCode = Request.QueryString["sectionID"];
                string questionCode = Request.QueryString["questionID"];

                string allData = new Config().ObjNav().FnGetAllAuditLinesDetails(SARNo, sectionCode, questionCode);
                String[] info1 = allData.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                if (info1 != null)
                {
                    foreach (var data in info1)
                    {
                        String[] arr = data.Split('*');
                        sectionname.InnerText = arr[2];
                        lblquestionname.InnerText = arr[4];
                    }
                }
            }
        }

        protected void uploadDocument_Click(object sender, EventArgs e)
        {
            int lineno = Convert.ToInt32(Request.QueryString["lineno"]);
            string SARNo = Request.QueryString["SARNo"];
            string sectID = Request.QueryString["sectionID"];
            string questionID = Request.QueryString["questionID"];
            string accreditationNo = Request.QueryString["SARNo"];
            string sectname = "";
            string questionname = "";
            string allData = new Config().ObjNav().FnGetAllAuditLinesDetails(SARNo, sectID, questionID);
            String[] info1 = allData.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
            if (info1 != null)
            {
                foreach (var data in info1)
                {
                    String[] arr = data.Split('*');
                    sectname = arr[2];
                    questionname = arr[4];
                }
            }
            accreditationNo = accreditationNo.Replace('/', '_');
            accreditationNo = accreditationNo.Replace(':', '_');
            string path1 = Config.FilesLocation() + "Institution Audit Response/";
            string str1 = Convert.ToString(accreditationNo);
            string folderName = path1 + str1 + "/";
            string qName = docname.Text.Trim();
            try
            {
                if (document.HasFile)
                {
                    string extension = System.IO.Path.GetExtension(document.FileName);
                    if (extension == ".pdf" || extension == ".PDF" || extension == ".Pdf")
                    {
                        string filename = sectname + "_" + qName + "_" + "Attachment" + extension;
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
                            string fullpath = folderName + filename;
                            string txtdesc = desc.Text.Trim();
                            string status = new Config().ObjNav().FnSaveAuditOpenEnded(SARNo, lineno, sectID, questionID, txtdesc, fullpath);
                            String[] info = status.Split('*');
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
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The file extension of the Application Letter is not allowed,Kindly upload pdf files only <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The file extension of the Application Letter is not allowed,Kindly upload pdf files only <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void backtoquestions_Click(object sender, EventArgs e)
        {
            string SARNo = Request.QueryString["SARNo"];
            string sectionID = Request.QueryString["sectionID"];
            string Type = Request.QueryString["Type"];
            Response.Redirect("SARQAQuestionsNew.aspx?SARNo=" + SARNo + "&&Type=" + Type + "&&sectionID=" + sectionID);
        }

        protected void deleteFile_Click(object sender, EventArgs e)
        {
            try
            {
                String tFileName = fileName.Text.Trim();
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Institution Audit Response/";
                String imprestNo = Request.QueryString["SARNo"];
                imprestNo = imprestNo.Replace('/', '_');
                imprestNo = imprestNo.Replace(':', '_');
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
    }
}