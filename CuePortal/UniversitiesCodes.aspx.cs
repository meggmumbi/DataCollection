using System;
using System.IO;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class UniversitiesCodes : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            var userType = Convert.ToString(Session["UserType"]);
            var univer = Convert.ToString(Session["UniversityCode"]);
        }
        protected void download_Click(object sender, EventArgs e)
        {

        }
    }
}
