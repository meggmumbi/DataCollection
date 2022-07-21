using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class FactualErrors : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void savedetails_Click(object sender, EventArgs e)
        {
            try
            {
                string tfeedbackNo = Request.QueryString["feedbackNo"];
                string tSectionCode = tsubCode.Text.Trim();
                string FindingResponse = tresponse.Text.Trim();
                int tFindingResponse = 0;
                if(FindingResponse == "No Factual Error")
                {
                    tFindingResponse = 1;
                }
                if (FindingResponse == "Factual Error")
                {
                    tFindingResponse = 2;
                }
                string tInstitutionResponse = tinsresponse.Text.Trim();

                string status = new Config().ObjNav().FnInsertCorrectionOfFuctualErrorsLines(tfeedbackNo, tSectionCode, tFindingResponse, tInstitutionResponse);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-info'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void PreviousPage_Click(object sender, EventArgs e)
        {
            string feedbackNo = Request.QueryString["feedbackNo"];
            Response.Redirect("OpenCorrectionOfFuctualErrors.aspx");
        }

        protected void submit_Click(object sender, EventArgs e)
        {
            try
            {
                string feedbackNo = Request.QueryString["feedbackNo"].Trim();
                String status = new Config().ObjNav().FnSubmitCorrectionFactualErrors(feedbackNo);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] +
                                         "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] +
                                         "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                     "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }

        protected void printFactualErrrors_Click(object sender, EventArgs e)
        {
            string feedbackNo = Request.QueryString["feedbackNo"];
            Response.Redirect("CorrectionOfFuctualErrorsReport.aspx?feedbackNo=" + feedbackNo);
        }
    }
}