using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class CorrectionOfFuctualErrors : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //    var nav = Config.ReturnNav();
                //    string PeerCode = Convert.ToString(Session["UniversityCode"]);
                //    //&& x.ApprovalStatus == "Approved"
                //    //x.Account_No == PeerCode &&
                //    //& x.Project_Subtype == "Institution Quality Audit"
                //    var txtworkorder = nav.AllJobs.Where(x =>x.Bill_to_Customer_No == PeerCode && x.Project_Type == "Quality Audit").ToList();
                //    workorder.DataSource = txtworkorder;
                //    workorder.DataTextField = "Description";
                //    workorder.DataValueField = "No";
                //    workorder.DataBind();
            }
        }

        //protected void next_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        string message = "";
        //        bool error = false;
        //        string tWorkorder = workorder.SelectedValue;
        //        if (string.IsNullOrEmpty(tWorkorder))
        //        {
        //            error = true;
        //            message = "Please select project";
        //        }
        //        if (error)
        //        {
        //            headerfeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //        }
        //        else
        //        {
        //            String feedbackNo = "";
        //            Boolean newfeedbackNo = false;
        //            try
        //            {

        //                feedbackNo = Request.QueryString["feedbackNo"];
        //                if (String.IsNullOrEmpty(feedbackNo))
        //                {
        //                    feedbackNo = "";
        //                    newfeedbackNo = true;
        //                }
        //            }
        //            catch (Exception)
        //            {

        //                feedbackNo = "";
        //                newfeedbackNo = true;
        //            }

        //            string peercode = Convert.ToString(Session["UniversityCode"]);
        //            string status = new Config().ObjNav().FnCreateCorrectionOfFuctualErrors(feedbackNo, tWorkorder, peercode);
        //            String[] info = status.Split('*');
        //            if (info[0] == "success")
        //            {
        //                if (newfeedbackNo)
        //                {
        //                    feedbackNo = info[2];
        //                }
        //                Response.Redirect("CorrectionOfFuctualErrors.aspx?step=2&&feedbackNo=" + feedbackNo);
        //            }
        //            else
        //            {
        //                headerfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        headerfeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //    }
        //}


        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string InsertComponentItems(List<FeedbackModel> cmpitems)
        {
            string tfeedbackNo = "", tSectionCode = "", tInstitutionResponse = "";
            int tFindingResponse = 0;
            string results_0 = (dynamic)null;
            try
            {

                //Check for NULL.
                if (cmpitems == null)
                    cmpitems = new List<FeedbackModel>();

                //Loop and insert records.
                foreach (FeedbackModel oneitem in cmpitems)
                {
                    tfeedbackNo = oneitem.TfeedbackNo;
                    tSectionCode = oneitem.TSectionCode;
                    tFindingResponse = oneitem.TFindingResponse;
                    tInstitutionResponse = oneitem.TInstitutionResponse;
                    if (string.IsNullOrWhiteSpace(tInstitutionResponse))
                    {
                        results_0 = "Please enter institution response!";
                        return results_0;
                    }
                    if (Convert.ToString(tFindingResponse) == null || Convert.ToString(tFindingResponse) == "--Select--")
                    {
                        results_0 = "Please select finding response!";
                        return results_0;
                    }

                    string status = new Config().ObjNav().FnInsertCorrectionOfFuctualErrorsLines(tfeedbackNo, tSectionCode, tFindingResponse, tInstitutionResponse);
                    string[] info = status.Split('*');
                    results_0 = info[0];
                }
            }
            catch (Exception ex)
            {
                results_0 = ex.Message;
            }
            return results_0;
        }

        protected void PreviousPage_Click(object sender, EventArgs e)
        {
            string feedbackNo = Request.QueryString["feedbackNo"];
            Response.Redirect("OpenCorrectionOfFuctualErrors.aspx");
        }
        //protected void workorder_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    string jobno = workorder.SelectedValue;
        //    var nav = Config.ReturnNav();
        //    var jobs = nav.ResourceAllocation.Where(x => x.Job_No == jobno);
        //    foreach (var tJob in jobs)
        //    {
        //        programmename.Text = tJob.Job_Task_Description;
        //    }
        //}
    }
}