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
    public partial class DiplomaCertificateStudents : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void upload_Click(object sender, EventArgs e)
        {
            string filesFolder = ConfigurationManager.AppSettings["FilesLocation"];
            string filelocations = filesFolder + "Customer Card/";
            String universityNo = Convert.ToString(Session["UniversityCode"]);
            universityNo = universityNo.Replace('/', '_');
            universityNo = universityNo.Replace(':', '_');
            String documentDirectory = filelocations + universityNo + "/" + "DiplomaStudents/";
            string myName = "";
            if (organorgram.HasFile)
            {
                try
                {
                    if (Directory.Exists(filelocations))
                    {
                        string torganorgram = System.IO.Path.GetExtension(organorgram.FileName);
                        string organorgramExtension = System.IO.Path.GetExtension(organorgram.FileName);
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
                            if (new Config().IsAllowedExtension(organorgramExtension))
                            {

                                string organorgramFile = Session["UniversityCode"] + "_DiplomaStudents_" + organorgram.FileName;
                                organorgramFile = organorgramFile.Replace(':', '_');
                                organorgramFile = documentDirectory + organorgramFile;
                                myName = organorgramFile;
                                organorgram.SaveAs(organorgramFile);
                                if (File.Exists(organorgramFile))
                                {
                                    feedback.InnerHtml =
                                        "<div class='alert alert-success'>The University Diploma and Certificate Students document was successfully uploaded. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                }
                                else
                                {
                                    feedback.InnerHtml =
                                        "<div class='alert alert-danger'>The document could not be uploaded. " + myName + " Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
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
                feedback.InnerHtml = "<div class='alert alert-danger'>Please select the documents to upload. Both are required <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            }
        }
        protected void deleteFile_Click(object sender, EventArgs e)
        {
            try
            {
                String tFileName = fileName.Text.Trim();
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"];
                string filelocations = filesFolder + "Customer Card" + "/";
                String universityNo = Convert.ToString(Session["UniversityCode"]);
                universityNo = universityNo.Replace('/', '_');
                universityNo = universityNo.Replace(':', '_');
                String documentDirectory = filelocations + universityNo + "/" + "DiplomaStudents" + "/";
                String myFile = documentDirectory + tFileName;
                if (File.Exists(myFile))
                {
                    File.Delete(myFile);
                    if (File.Exists(myFile))
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>The University Diploma and Certificate Students file  could not be deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-success'>The University Diploma and Certificate Students file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
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
        protected void downloadFile_Click(object sender, EventArgs e)
        {
            try
            {
                String tFileName = downloadfilename.Text.Trim();
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"];
                string filelocations = filesFolder + "Customer Card" + "/";
                String universityNo = Convert.ToString(Session["UniversityCode"]);
                universityNo = universityNo.Replace('/', '_');
                universityNo = universityNo.Replace(':', '_');
                String documentDirectory = filelocations + universityNo + "/" + "DiplomaStudents" + "/";
                String myFile = documentDirectory + tFileName;
                if (File.Exists(myFile))
                {
                    Response.ContentType = "application/pdf";
                    Response.AppendHeader("Content-Disposition", "attachment; filename=" + tFileName);
                    Response.TransmitFile(Server.MapPath(myFile));
                    Response.End();
                    if (File.Exists(myFile))
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>The University Diploma and Certificate Students file  could not be Downloaded <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-success'>The University Diploma and Certificate Students  file was successfully Downloaded <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
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