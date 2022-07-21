using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class QAMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String name = Convert.ToString(Session["Name"]);
            String memberNumber = Convert.ToString(Session["Code"]);
            if (String.IsNullOrEmpty(name) || String.IsNullOrEmpty(memberNumber))
            {
                Response.Redirect("Login.aspx");
            }
           

        }
    }
}