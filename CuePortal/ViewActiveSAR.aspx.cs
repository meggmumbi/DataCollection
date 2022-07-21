using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class ViewActiveSAR : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = Config.ReturnNav();
                string SARNo = Request.QueryString["SARNo"];
                string universityCode = Convert.ToString(Session["UniversityCode"]);
                var sar = nav.AuditRequisitionHeader.Where(x => x.Code == SARNo && x.Institution_Code == universityCode).ToList();
                foreach (var mSar in sar)
                {
                    description.Text = mSar.Description;
                    programmename.Text = mSar.Programme_Name;
                    institutionname.Text = mSar.Institution_Name;
                    startdate.Text = Convert.ToDateTime(mSar.Audit_Plan_Start_Date).ToString("dd/MM/yyyy");
                    enddate.Text = Convert.ToDateTime(mSar.Audit_Plan_End_Date).ToString("dd/MM/yyyy");
                }

            }
        }

        protected void engagementletter_Click(object sender, EventArgs e)
        {
            string SARNo = Request.QueryString["SARNo"];
            Response.Redirect("QAEngagementLetter.aspx?SARNo=" + SARNo);
        }

        protected void previouspage_Click(object sender, EventArgs e)
        {
            Response.Redirect("QualityAudit.aspx");
        }

        //protected void respondtoinvitation_Click(object sender, EventArgs e)
        //{
        //    string SARNo = Request.QueryString["SARNo"];
        //    Response.Redirect("AuditRequisitionsDetails.aspx?AuditNo=" + SARNo);
        //}
    }
}