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
    public partial class AuditRoadmapLines : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void savedetails_Click(object sender, EventArgs e)
        {
            try
            {
                string mRemarks = remarks.Text.Trim();
                string mSectioncode = tsextioncode.Text.Trim();
                int mStatus = status.SelectedIndex;
                string mEffectiveDate = effectivedate.Text.Trim();
                string mSectDesc = tsectiondesc.Text.Trim();
                DateTime tEffectiveDate = new DateTime();
                tEffectiveDate = DateTime.ParseExact(mEffectiveDate, "M/d/yyyy", CultureInfo.InvariantCulture);

                string RoadmapNo = Request.QueryString["RoadmapNo"].Trim();
                RoadmapNo = RoadmapNo.Replace('/', '_');
                RoadmapNo = RoadmapNo.Replace(':', '_');
                string path1 = Config.FilesLocation() + "Audit Exit Roadmap/";
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
                    feedback.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
                    string status = new Config().ObjNav().FnInsertAuditRoadmapLines(RoadmapNo, mSectioncode, mRemarks, mStatus, tEffectiveDate, DocUploaded);
                    string[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-success'>" + mSectDesc + " details have been successfully saved, kindly procced and respond to the other audit criteria<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>Something went wrong, kindly try again! <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void GoToHomepage_Click(object sender, EventArgs e)
        {
            Response.Redirect("QualityAudit.aspx");
        }

        protected void submitresponse_Click(object sender, EventArgs e)
        {
            try
            {
                string RoadmapNo = Request.QueryString["RoadmapNo"];
                string universitynumber = Convert.ToString(Session["UniversityCode"]);
                string status = new Config().ObjNav().FnSubmitRoadmap(RoadmapNo, universitynumber);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    feedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                    "setTimeout(function() { window.location.replace('QualityAudit.aspx') }, 5000);", true);
                }
                else
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>Something went wrong, kindly try again! <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void ViewRoadmapDetails_Click(object sender, EventArgs e)
        {
            string RoadmapNo = Request.QueryString["RoadmapNo"];
            Response.Redirect("RoadmapReport.aspx?RoadmapNo=" + RoadmapNo);
        }
    }
}