﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class QAEngagementLetter : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string SARNo = Request.QueryString["SARNo"];
                String status = new Config().ObjNav().FnAuditEngagementLetter(SARNo);
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
}