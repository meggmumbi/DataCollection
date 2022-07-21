using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class ChooseServiceMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string name = Convert.ToString(Session["Name"]);
            string memberNumber = Convert.ToString(Session["Code"]);
            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(memberNumber))
            {
                Response.Redirect("Login.aspx");
            }
           

        }
    }
}