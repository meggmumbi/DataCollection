using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class AuditRequisitionsDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = Config.ReturnNav();
                string SARNo = Request.QueryString["SARNo"];
                string universityCode = Convert.ToString(Session["UniversityCode"]);
                var sar = nav.AuditRequisitionHeader.Where(x => x.Engagement_ID == SARNo && x.Institution_Code == universityCode && x.Document_Type == "Engagement Response").ToList();
                foreach (var mSar in sar)
                {
                    description.Text = mSar.Description;
                    institutionname.Text = mSar.Institution_Name;
                    programmename.Text = mSar.Programme_Name;
                    startdate.Text = Convert.ToDateTime(mSar.Audit_Plan_Start_Date).ToString("dd/MM/yyyy");
                    enddate.Text = Convert.ToDateTime(mSar.Audit_Plan_End_Date).ToString("dd/MM/yyyy");

                    Session["EngagementId"] = mSar.Code;
                }

            }
        }

        protected void PrintDocument_Click(object sender, EventArgs e)
        {
            string AuditNo = Request.QueryString["AuditNo"];
            Response.Redirect("QAInvitationDocument.aspx?AuditNo=" + AuditNo);
        }

        protected void previouspage_Click(object sender, EventArgs e)
        {
            Response.Redirect("QualityAudit.aspx");
        }

        protected void buttonaddcontactperson_Click(object sender, EventArgs e)
        {
            try
            {
                string EngagementId = Convert.ToString(Session["EngagementId"]);
                string mContact = auditeename.Text.Trim();
                string mtengagement = tengagement.Text.Trim();
                string mtemail = temail.Text.Trim();
                string mtphone = tphone.Text.Trim();

                string status = new Config().ObjNav().FnAddAuditeeCMNTeam(EngagementId, mContact, mtengagement, mtemail, mtphone);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    contactpersons.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    contactpersons.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }
            catch (Exception y)
            {
                contactpersons.InnerHtml = "<div class='alert alert-danger'>" + y.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void buttonapprovecontactperson_Click(object sender, EventArgs e)
        {
            try
            {
                string mtxtdoclinenoapprove = txtdoclinenoapprove.Text.Trim();
                string mtxtresource = txtresource.Text.Trim();

                string status = new Config().ObjNav().FnapproveAuditCMNTeam(mtxtdoclinenoapprove, mtxtresource);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    terminate.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    terminate.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }
            catch (Exception y)
            {
                terminate.InnerHtml = "<div class='alert alert-danger'>" + y.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void RejectContactPerson_Click(object sender, EventArgs e)
        {
            try
            {
                string mtxtdoclinenoreject = txtdoclinenoreject.Text.Trim();
                string mtxtresourceperson = txtresourceperson.Text.Trim();
                string mtxtreason = txtreason.Text.Trim();

                string status = new Config().ObjNav().FnrejectAuditCMNTeam(mtxtdoclinenoreject, mtxtresourceperson, mtxtreason);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    terminate.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    terminate.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }
            catch (Exception y)
            {
                terminate.InnerHtml = "<div class='alert alert-danger'>" + y.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void removeauditee_Click(object sender, EventArgs e)
        {
            try
            {
                int mtxtlineno = Convert.ToInt32(txtlineno.Text.Trim());
                string mtxtdocno = txtdocno.Text.Trim();

                string status = new Config().ObjNav().FnRemoveAuditeeCMNTeam(mtxtlineno, mtxtdocno);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    contactpersons.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    contactpersons.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }
            catch (Exception y)
            {
                contactpersons.InnerHtml = "<div class='alert alert-danger'>" + y.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void editauditee_Click(object sender, EventArgs e)
        {
            try
            {
                string mtdocno = tdocno.Text.Trim();
                int mtlineno = Convert.ToInt32(tlineno.Text.Trim());
                string mtname = tname.Text.Trim();
                string mtjobtitle = tjobtitle.Text.Trim();
                string mttemail = ttemail.Text.Trim();
                string mttphone = ttphone.Text.Trim();

                string status = new Config().ObjNav().FnEditAuditeeCMNTeam(mtlineno, mtdocno, mtname, mtjobtitle, mttemail, mttphone);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    contactpersons.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    contactpersons.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }
            catch (Exception y)
            {
                contactpersons.InnerHtml = "<div class='alert alert-danger'>" + y.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void submitInvitation_Click(object sender, EventArgs e)
        {
            try
            {
                string EngagementId = Convert.ToString(Session["EngagementId"]);
                string universityCode = Convert.ToString(Session["UniversityCode"]);
                string status = new Config().ObjNav().FnSubmitQAInvitation(EngagementId, universityCode);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    feedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    //ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                    //"setTimeout(function() { window.location.replace('QualityAudit.aspx') }, 5000);", true);
                }
                else
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}