﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class OpenCorrectionOfFuctualErrors : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void gotohomepage_Click(object sender, EventArgs e)
        {
            Response.Redirect("QualityAudit.aspx");
        }
    }
}