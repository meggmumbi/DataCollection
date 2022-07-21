using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class AmendmentsApprovalRequest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var nav = Config.ReturnNav();
            var invitations = nav.DataCollectionInvitations.Where(r => r.Submission_Type == "Original" && r.Published == true && r.Document_Status == "Published" && r.Approval_Status == "Released");
            invitation.DataSource = invitations;
            invitation.DataValueField = "Notice_No";
            invitation.DataTextField = "Notice_No";
            invitation.DataBind();

        }
        protected void previous_Click(object sender, EventArgs e)
        {
            int step = 1;
            try
            {
                step = Convert.ToInt32(Request.QueryString["step"].Trim());
            }
            catch (Exception)
            {
                step = 1;
            }
            step -= 1;
            Response.Redirect("AmendmentsApprovalRequest.aspx?step=" + step);
        }
        protected void next_Click(object sender, EventArgs e)
        {
            int step = 1;
            try
            {
                step = Convert.ToInt32(Request.QueryString["step"].Trim());
            }
            catch (Exception)
            {
                step = 1;
            }
            step += 1;
            Response.Redirect("AmendmentsApprovalRequest.aspx?step=" + step);
        }
        protected void Submit_Click(object sender, EventArgs e)
        {
            try
            {
                bool error = false;
                string message = "";
                string tinvitation = "";
                try
                {
                    tinvitation = invitation.SelectedValue.Trim();
                    if (tinvitation.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please provide a valid value for Invitation Number";
                }
                string tamendmentsdetails = "";
                try
                {
                    tamendmentsdetails = amendmentsdetails.Text.Trim();
                    if (tamendmentsdetails.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please provide a valid value for Amendments Reasons/Description";
                }
                if (error)
                {
                    feedbackamendments.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    string userCode = Convert.ToString(Session["Code"]);
                    string password = Convert.ToString(Session["Password"]);
                    string status = new Config().ObjNav()
                    .AddAmendmentsRequest(tamendmentsdetails, tinvitation, userCode, password);
                    string[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        feedbackamendments.InnerHtml = "<div class='alert alert-success'>The University Amendments Request was successfully Submitted. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        Response.Redirect("AmendmentsApprovalRequest.aspx?step=2");
                    }
                    else
                    {
                        feedbackamendments.InnerHtml = "<div class='alert alert-danger'>The University Amendments Request was not successfully Submitted. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    }
                }
            }
            catch (Exception ex)
            {
                feedbackamendments.InnerHtml = "<div class='alert alert-success'>The Amendments Request Details Could not be Submited due to " + ex.Message + " < a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string SubmitDatasetCodes(DatasetCodes postData)
        {
                var universityCode = HttpContext.Current.Session["UniversityCode"].ToString();
                var results = (dynamic)null;              
                try
                {

                List<string> AllDatasetlist = postData.AllDatasecodes.ToList();

                foreach (var iteminlist in AllDatasetlist)
                {

                       var datasetcodeValue = iteminlist;
                       string currentYear = DateTime.Now.Year.ToString();
                        int year = Convert.ToInt32(currentYear);
                        var userCode = HttpContext.Current.Session["Code"].ToString();
                        var password = HttpContext.Current.Session["Password"].ToString();
                        var status = new Config().ObjNav().FnAddAmendmentDatasetCodes(datasetcodeValue, userCode, password);
                        string[] info = status.Split('*');
                        results = info[0];
                }

                }
                catch (Exception ex)
                {
                    results = ex.Message;
                }
            return results;
          }            
        
    }

}
