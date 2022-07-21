using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class RoadmapReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    string RoadmapNo = Request.QueryString["RoadmapNo"];
                    String status = new Config().ObjNav().FnViewRoadmapPrintout(RoadmapNo);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        payslipFrame.Attributes.Add("src", ResolveUrl(info[2]));
                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                                             "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                catch (Exception t)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>Your payslip could not be generated " + t.Message + "</div>";
                }
            }
        }

        protected void GoToPreviousPage_Click(object sender, EventArgs e)
        {
            Response.Redirect("QualityAudit.aspx");
        }
    }
}