using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class Approvals : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
     
          

        }

        protected void sendApproval_Click(object sender, EventArgs e)
        {
            try
            {
                string userCode = Convert.ToString(Session["Code"]);
                string password = Convert.ToString(Session["Password"]); ;
                string response = new Config().ObjNav().SendApprovalRequest(userCode, password);
                string[] info = response.Split('*');
                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "</div>";
                if (info[0] == "success")
                {
                    feedback.InnerHtml ="<div class='alert alert-success'>The Approval Request has been sent to the DVC and Notified by Email.Kindly Await for Approval. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
                else
                {
                    feedback.InnerHtml = "<div class='alert alert-success'>The Approval Request has not been sent to the DVC. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }

            }
            catch (Exception t)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>"+t.Message+"</div>";
            }
        }

        protected void cancelApprovalRequest_Click(object sender, EventArgs e)
        {
            try
            {
                string userCode = Convert.ToString(Session["Code"]);
                string password = Convert.ToString(Session["Password"]);
                int entryId = Convert.ToInt32(cancelApprovalEntryId.Text.Trim());
                string response = new Config().ObjNav().CancelApprovalRequest(userCode, password, entryId);
                string[] info = response.Split('*');
                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "</div>";
            }
            catch (Exception t)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "</div>";
            }
        }

        protected void rejectApprovalRequest_Click(object sender, EventArgs e)
        {
            try
            {
                string userCode = Convert.ToString(Session["Code"]);
                string password = Convert.ToString(Session["Password"]);
                string tComment = rejectComment.Text.Trim();
                int entryId = Convert.ToInt32(rejectApprovalEntryId.Text.Trim());
                string response = new Config().ObjNav().ApproveRejectRequest(entryId,userCode, password,false, tComment);
                string[] info = response.Split('*');
                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "</div>";
            }
            catch (Exception t)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "</div>";
            }
        }

        protected void approveApprovalRequest_Click(object sender, EventArgs e)
        {
            try
            {
                string userCode = Convert.ToString(Session["Code"]);
                string password = Convert.ToString(Session["Password"]);
                string tComment = approveComment.Text.Trim();
                int entryId = Convert.ToInt32(approveApprovalEntryId.Text.Trim());
                string response = new Config().ObjNav().ApproveRejectRequest(entryId, userCode, password, true, tComment);
                string[] info = response.Split('*');
                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "</div>";
            }
            catch (Exception t)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "</div>";
            }
        }
    }
}