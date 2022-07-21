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
    public partial class LibraryPolicies : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                var nav = Config.ReturnNav();
                var universityLibrarydetails = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                librarycampus.DataSource = universityLibrarydetails;
                librarycampus.DataValueField = "Description";
                librarycampus.DataTextField = "Description";
                librarycampus.DataBind();
            }
        }
        protected void upload_Click(object sender, EventArgs e)
        {
            string tlibrarynames = librarycampus.SelectedValue;
            string filesFolder = ConfigurationManager.AppSettings["FilesLocation"];
            string filelocations = filesFolder + "Customer Card" + "/";
            String universityNo = Convert.ToString(Session["UniversityCode"]);
            universityNo = universityNo.Replace('/', '_');
            universityNo = universityNo.Replace(':', '_');
            String documentDirectory = filelocations + universityNo + "/" + "Library Policies" + "/";
            string myName = "";
            bool tfilerepositorypolicy = false;
            if (filerepositorypolicy.Checked)
            {
                tfilerepositorypolicy = true;

            }
            bool trulerequlationpolicy = false;
            if (rulerequlationpolicy.Checked)
            {
                trulerequlationpolicy = true;
            }
            bool tcirculationpolicy = false;
            if (circulationpolicy.Checked)
            {
                tcirculationpolicy = true;
            }
            bool tdisasterpolicy = false;
            if (disasterpolicy.Checked)
            {
                tdisasterpolicy = true;
            }
            bool tictpolicy = false;
            if (ictpolicy.Checked)
            {
                tictpolicy = true;
            }
            bool tmanagementpolicy = false;
            if (managementpolicy.Checked)
            {
                tmanagementpolicy = true;
            }
            if (literacypolicy.HasFile)
            {
                try
                {

                    if (Directory.Exists(filelocations))
                    {
                        string tliteracypolicy = System.IO.Path.GetExtension(literacypolicy.FileName);
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
                            documentsFeedback.InnerHtml = "<div class='alert alert-danger'>We could not create a directory for your documents. Please try again" +
                                                            "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                        }
                        if (createDirectory)
                        {
                            if (new Config().IsAllowedExtension(tliteracypolicy))
                            {
                                string literacypolicyFile = "Library Policy" + '_' + literacypolicy.FileName;
                                literacypolicyFile = literacypolicyFile.Replace(':', '_');
                                literacypolicyFile = documentDirectory + literacypolicyFile;
                                myName = literacypolicyFile;
                                literacypolicy.SaveAs(literacypolicyFile);
                                if (File.Exists(literacypolicyFile))
                                {
                                    bool attached = true;
                                    string userCode = Session["Code"].ToString();
                                    string password = Session["Password"].ToString();
                                    string status = new Config().ObjNav()
                                    .AddLibraryPolicies(userCode, password, attached, tfilerepositorypolicy, trulerequlationpolicy,
                                    tcirculationpolicy, tdisasterpolicy, tictpolicy, tmanagementpolicy);
                                    string[] info = status.Split('*');
                                    if (info[0] == "success")
                                    {
                                        documentsFeedback.InnerHtml = "<div class='alert alert-success'>The University Library Policies were successfully uploaded. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                    }
                                    else
                                    {
                                        documentsFeedback.InnerHtml = "<div class='alert alert-danger'>The University Library Policies  could not be uploaded. " + myName + " Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                    }


                                }
                                else
                                {
                                    documentsFeedback.InnerHtml = "<div class='alert alert-danger'>The University Library Policies  file extension is not allowed. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                }

                            }
                            else
                            {
                                documentsFeedback.InnerHtml = "<div class='alert alert-danger'>The University Library Policies folder defined does not exist in the server. Please contact support. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                            }
                        }
                    }

                }
                catch (Exception ex)
                {
                    documentsFeedback.InnerHtml = "<div class='alert alert-danger'>The University Financial documentsLibrary Policies could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            else
            {

                documentsFeedback.InnerHtml = "<div class='alert alert-danger'>Please select the Library Policy documents to upload. All the Policy Documents are required <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


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
                String documentDirectory = filelocations + universityNo + "/" + "Library Policies" + "/";
                String myFile = documentDirectory + tFileName;
                if (File.Exists(myFile))
                {
                    File.Delete(myFile);
                    if (File.Exists(myFile))
                    {
                        documentsFeedback.InnerHtml = "<div class='alert alert-danger'>The University Library Policy file  could not be deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        documentsFeedback.InnerHtml = "<div class='alert alert-success'>The University Library Policy  file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                else
                {
                    documentsFeedback.InnerHtml = "<div class='alert alert-danger'>A file with the given name does not exist in the server <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }



            }
            catch (Exception m)
            {
                documentsFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

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
                String documentDirectory = filelocations + universityNo + "/" + "Library Policies" + "/";
                String myFile = documentDirectory + tFileName;
                if (File.Exists(myFile))
                {
                    Response.ContentType = "application/pdf";
                    Response.AppendHeader("Content-Disposition", "attachment; filename=" + tFileName);
                    Response.TransmitFile(Server.MapPath(myFile));
                    Response.End();
                    if (File.Exists(myFile))
                    {
                        documentsFeedback.InnerHtml = "<div class='alert alert-danger'>The University Library Policy file  could not be deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        documentsFeedback.InnerHtml = "<div class='alert alert-success'>The University Library Policy  file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                else
                {
                    documentsFeedback.InnerHtml = "<div class='alert alert-danger'>A file with the given name does not exist in the server <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }



            }
            catch (Exception m)
            {
                documentsFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }
    }
}