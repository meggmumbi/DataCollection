using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class Functions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [System.Web.Services.WebMethod]
        public static string AddLanguage(string allStudents)
        {
            
        //new Config().ObjNav().AddStudentDraft(languagecode,customer);
            return "victor";

        }
        [System.Web.Services.WebMethod]
        public static string Empty()
        {
            
        //new Config().ObjNav().AddStudentDraft(languagecode,customer);
            return "victor";

        }
    }
}