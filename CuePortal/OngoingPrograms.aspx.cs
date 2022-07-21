using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class OngoingPrograms : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


        }
        protected void ConfirmPayments_Click(object sender, EventArgs e)
        {
            try
            {
                string accreditationNo = accreditationnumber.Text.Trim();
                accreditationNo = accreditationNo.Replace('/', '_');
                accreditationNo = accreditationNo.Replace(':', '_');
                string path1 = Config.FilesLocation() + "Unprocessed Program Card/";
                string str1 = Convert.ToString(accreditationNo);
                string folderName = path1 + str1 + "/";
                bool paymentsDocUploaded = false;
                try
                {
                    if (paymentdocument.HasFile)
                    {
                        string extension = System.IO.Path.GetExtension(paymentdocument.FileName);
                        if (new Config().IsAllowedExtension(extension))
                        {
                            string filename = "PaymentDocument" + extension;
                            if (!Directory.Exists(folderName))
                            {
                                Directory.CreateDirectory(folderName);
                            }
                            if (File.Exists(folderName + filename))
                            {
                                File.Delete(folderName + filename);
                            }
                            paymentdocument.SaveAs(folderName + filename);
                            if (File.Exists(folderName + filename))
                            {
                                paymentsDocUploaded = true;
                            }
                        }
                        else
                        {
                            feedback.InnerHtml = ("The file extension of the facilities document is not allowed");
                        }

                    }
                }
                catch (Exception)
                {
                    feedback.InnerHtml = ("The Payments Details Could Not Be Captured Kindly Contact the System Administrator");
                }
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string applicationnumber = accreditationnumber.Text.Trim();
                string paymentreference = paymentsref.Text.Trim();
                string status = new Config().ObjNav().ConfirmPaymentsProgramme(applicationnumber, paymentsDocUploaded, paymentreference, userCode, password);
                string[] info = status.Split('*');
                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            catch (Exception y)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + y.Message + "</div>";
            }
        }
        //protected void ProformaInvoice_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        string accreditationNo = Request.QueryString["accreditation"].Trim();
        //        accreditationNo = accreditationNo.Replace('/', '_');
        //        accreditationNo = accreditationNo.Replace(':', '_');
        //        // string path1 = Config.FilesLocation() + "Unprocessed Program Card/";
        //        string str1 = Convert.ToString(accreditationNo);
        //        //string folderName = path1 + str1 + "/";
        //        Response.ContentType = "Application/pdf";
        //        Response.AppendHeader("Content-Disposition", "attachment; filename=str1.pdf");
        //        Response.TransmitFile(Server.MapPath("~/Downloads/str1.pdf"));
        //        Response.End();
        //    }
        //    catch (Exception)
        //    {
        //        proformafeedback.InnerHtml = "<div class='alert alert-danger'>" + "The Proforma Invoice Has not been Generated.Kindly Completed the Application to Generated Proforma Invoice" + "</div>";

        //    }
        //}
    }
}
