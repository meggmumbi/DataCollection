using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class FinanceDocuments : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void upload_Click(object sender, EventArgs e)
        {
            string filesFolder = ConfigurationManager.AppSettings["FilesLocation"] ;
            string filelocations = filesFolder + "Customer Card" + "/";
            String universityNo = Convert.ToString(Session["UniversityCode"]);
            universityNo = universityNo.Replace('/', '_');
            universityNo = universityNo.Replace(':', '_');
            String documentDirectory = filelocations + universityNo + "/" + "Financial Documents" + "/";
            string myName = "";
            if (auditedBooks.HasFile&& auditedBooks1.HasFile && balanceSheet1.HasFile&& balanceSheet.HasFile)
            {
                try
                {

                    if (Directory.Exists(filelocations))
                    {

                        string tAuditedBooks1 = System.IO.Path.GetExtension(auditedBooks1.FileName);
                        string tAuditedBooks = System.IO.Path.GetExtension(auditedBooks.FileName);
                        string tBalanceSheet = System.IO.Path.GetExtension(balanceSheet.FileName);
                        string tBalanceSheet1 = System.IO.Path.GetExtension(balanceSheet1.FileName);
                        string auditedExtension = System.IO.Path.GetExtension(auditedBooks.FileName);
                        string auditedExtension1 = System.IO.Path.GetExtension(auditedBooks1.FileName);
                        string balanceSheetExtension = System.IO.Path.GetExtension(balanceSheet.FileName);
                        string balanceSheetExtension1 = System.IO.Path.GetExtension(balanceSheet1.FileName);
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
                            if (new Config().IsAllowedExtension(auditedExtension)&& new Config().IsAllowedExtension(auditedExtension1) && new Config().IsAllowedExtension(balanceSheetExtension1) && new Config().IsAllowedExtension(balanceSheetExtension))
                            {

                                string auditedBooksFile = Session["UniversityCode"] + "_Audited_Financial_Performance_" + auditedBooks.FileName;
                                string auditedBooksFile1 = Session["UniversityCode"] + "_Current_Financial_Performance_" + auditedBooks1.FileName;
                                string balanceSheetFile = Session["UniversityCode"] + "_Audited_Financial_Position_" + balanceSheet.FileName;
                                string balanceSheetFile1 = Session["UniversityCode"] + "_Current_Financial_Position_" + balanceSheet1.FileName;
                                auditedBooksFile = auditedBooksFile.Replace(':', '_');
                                auditedBooksFile1 = auditedBooksFile1.Replace(':', '_');
                                balanceSheetFile = balanceSheetFile.Replace(':', '_');
                                balanceSheetFile1 = balanceSheetFile1.Replace(':', '_');
                                auditedBooksFile = documentDirectory + auditedBooksFile;
                                auditedBooksFile1 = documentDirectory + auditedBooksFile1;
                                balanceSheetFile = documentDirectory + balanceSheetFile;
                                balanceSheetFile1 = documentDirectory + balanceSheetFile1;
                                myName = balanceSheetFile + "and" + auditedBooksFile;
                                auditedBooks.SaveAs(auditedBooksFile);
                                auditedBooks1.SaveAs(auditedBooksFile1);
                                balanceSheet.SaveAs(balanceSheetFile);
                                balanceSheet1.SaveAs(balanceSheetFile1);
                                if (File.Exists(auditedBooksFile) && File.Exists(balanceSheetFile)&& File.Exists(balanceSheetFile1)&& File.Exists(auditedBooksFile1))
                                {
                                    feedback.InnerHtml =
                                        "<div class='alert alert-success'>The University Financial documents were successfully uploaded. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                }
                                else
                                {
                                    feedback.InnerHtml =
                                        "<div class='alert alert-danger'>The University Financial document could not be uploaded. " + myName + " Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                }


                            }
                            else
                            {
                                feedback.InnerHtml = "<div class='alert alert-danger'>The University Financial documents' file extension is not allowed. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                            }

                        }
                        else
                        {
                            feedback.InnerHtml = "<div class='alert alert-danger'>The University Financial documents folder defined does not exist in the server. Please contact support. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }

                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>We could not create a directory for your documents. Please try again Later" +
                                                                                    "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    }
                }
                catch (Exception ex)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>The University Financial documents could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

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
                String documentDirectory = filelocations + universityNo + "/" + "Financial Documents" + "/";
                String myFile = documentDirectory + tFileName;
                if (File.Exists(myFile))
                {
                    File.Delete(myFile);
                    if (File.Exists(myFile))
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>The University Financial Documents file  could not be deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-success'>The University Financial Documents file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
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

            //removeNumber
            //removeWorkType



        }
        protected void DownloadFile_Click(object sender, EventArgs e)
        {
           
            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Customer Card/";
            String universityNumber = Convert.ToString(Session["UniversityCode"]);
            universityNumber = universityNumber.Replace('/', '_');
            universityNumber = universityNumber.Replace(':', '_');
            String documentDirectory = filesFolder + universityNumber + "/" + "Financial Documents" + "/";
            string tfileNametoDownload = documentDirectory + fileNametoDownload.Text.Trim();
            string tfilename= fileNametoDownload.Text.Trim();
            if (tfileNametoDownload != string.Empty)
            {
              
                WebClient req = new WebClient();
                HttpResponse response = HttpContext.Current.Response;
                var bytes = File.ReadAllBytes(tfileNametoDownload);
                response.OutputStream.Write(bytes, 0, bytes.Length);
                response.ContentType = "application/pdf";
                response.Clear();
                response.ClearContent();
                response.ClearHeaders();
                response.Buffer = true;
                response.AddHeader("Content-Disposition", "attachment;filename=tfileNametoDownload");
                response.End();
            }
        }
    }
}