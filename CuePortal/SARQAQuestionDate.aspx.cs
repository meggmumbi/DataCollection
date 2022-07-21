using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class SARQAQuestionDate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string SARNo = Request.QueryString["SARNo"];
                string sectionCode = Request.QueryString["sectionID"];
                string questionCode = Request.QueryString["questionID"];

                string allData = new Config().ObjNav().FnGetAllAuditLinesDetails(SARNo, sectionCode, questionCode);
                String[] info1 = allData.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                if (info1 != null)
                {
                    foreach (var data in info1)
                    {
                        String[] arr = data.Split('*');
                        sectionname.InnerText = arr[2];
                        lblquestionname.InnerText = arr[4];
                        questionname.Text = arr[7];
                    }
                }
            }
        }

        protected void backtoquestions_Click(object sender, EventArgs e)
        {
            string SARNo = Request.QueryString["SARNo"];
            string sectionID = Request.QueryString["sectionID"];
            string Type = Request.QueryString["Type"];
            Response.Redirect("SARQAQuestionsNew.aspx?SARNo=" + SARNo + "&&Type=" + Type + "&&sectionID=" + sectionID);
        }

        protected void save_Click(object sender, EventArgs e)
        {
            try
            {
                string SARNo = Request.QueryString["SARNo"];
                string sectionCode = Request.QueryString["sectionID"];
                string questionCode = Request.QueryString["questionID"];
                int lineno = Convert.ToInt32(Request.QueryString["lineno"]);
                string tquestionname = questionname.Text.Trim();
                string status = new Config().ObjNav().FnSaveAuditDate(SARNo, lineno, sectionCode, questionCode, tquestionname);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception m)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}