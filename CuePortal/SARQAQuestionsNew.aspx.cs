using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class SARQAQuestionsNew : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void back_Click(object sender, EventArgs e)
        {
            string SARNo = Request.QueryString["SARNo"];
            string sectionID = Request.QueryString["sectionID"];
            string Type = Request.QueryString["Type"];
            //+ "&&sectionID=" + sectionID
            Response.Redirect("QAqestions.aspx?SARNo=" + SARNo + "&&Type=" + Type);
        }

        protected void btn_Open_Ended_Click(object sender, EventArgs e)
        {
            try
            {

            }
            catch(Exception m)
            {
                gradingSystemFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void btn_Closed_Ended_Click(object sender, EventArgs e)
        {
            try
            {

            }
            catch (Exception m)
            {
                gradingSystemFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void btn_Date_Click(object sender, EventArgs e)
        {
            try
            {

            }
            catch (Exception m)
            {
                gradingSystemFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void btn_Attachment_Click(object sender, EventArgs e)
        {
            try
            {

            }
            catch (Exception m)
            {
                gradingSystemFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}