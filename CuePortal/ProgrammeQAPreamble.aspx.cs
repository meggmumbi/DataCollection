﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class ProgrammeQAPreamble : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Proceed_Onclick(object sender, EventArgs e)
        {
            Response.Redirect("ProgrammeActiveQASAR.aspx");
        }
    }
}