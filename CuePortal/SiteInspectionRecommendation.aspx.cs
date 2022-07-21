using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class SiteInspectionRecommendation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void savedetails_Click(object sender, EventArgs e)
        {
            try
            {
                string mRemarks = remarks.Text.Trim();
                int mSectioncode = Convert.ToInt32(tsextioncode.Text.Trim());
                int mStatus = status.SelectedIndex;
                string mEffectiveDate = effectivedate.Text.Trim();
                string mSectDesc = tsectiondesc.Text.Trim();
                DateTime tEffectiveDate = new DateTime();
                tEffectiveDate = DateTime.ParseExact(mEffectiveDate, "M/d/yyyy", CultureInfo.InvariantCulture);

                string RoadmapNo = Request.QueryString["docNo"].Trim();
                RoadmapNo = RoadmapNo.Replace('/', '_');
                RoadmapNo = RoadmapNo.Replace(':', '_');
                string path1 = Config.FilesLocation() + "Overall Evaluation Card/";
                string str1 = Convert.ToString(RoadmapNo);
                string sect = mSectDesc;
                string folderName = path1 + str1 + "/";
                bool DocUploaded = false;

                bool error = false;
                string message = "";
                try
                {
                    if (attachment.HasFile)
                    {
                        string extension = System.IO.Path.GetExtension(attachment.FileName);
                        if (extension == ".pdf" || extension == ".PDF" || extension == ".Pdf")
                        {
                            string filename = sect + "_" + "Evidence" + extension;
                            if (!Directory.Exists(folderName))
                            {
                                Directory.CreateDirectory(folderName);
                            }
                            if (File.Exists(folderName + filename))
                            {
                                File.Delete(folderName + filename);
                            }
                            attachment.SaveAs(folderName + filename);

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
                }
                catch (Exception ex)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "The file extension of the document is not allowed,Kindly upload pdf files only" + ex;
                }

                if (error)
                {
                    feedback.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
                    if (DocUploaded == true)
                    {

                        string status = new Config().ObjNav().FnInsertRecommendationLines(RoadmapNo, mSectioncode, mRemarks, tEffectiveDate, mStatus);
                        string[] info = status.Split('*');
                        feedback.InnerHtml = "<div class='alert alert-success'>" + mSectDesc + " details have been successfully saved, kindly procced and respond to the other recommendation criteria<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>Kindly upload document to proceed! <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
            }
            catch (Exception ex)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>Something went wrong, kindly try again! "+ex.Message+"<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void Previous_Click(object sender, EventArgs e)
        {
            Response.Redirect("InstitutionAccTechnicalReports.aspx");
        }

        protected void submittocue_Click(object sender, EventArgs e)
        {
            try
            {
                string docNo = Request.QueryString["docNo"];
                string status = new Config().ObjNav().FnSubmitRecommendationToCUE(docNo);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    feedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>Something went wrong, kindly try again! " + ex.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}