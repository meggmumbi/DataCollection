using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class Accreditation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var nav = Config.ReturnNav();
            try
            {
                bool changed = Convert.ToBoolean(Session["ChangedPassword"]);
                if (!changed)
                {
                  //  Response.Redirect("Settings.aspx");
                }
            }
            catch (Exception)
            {
           //     Response.Redirect("Settings.aspx");
            }
            if (!IsPostBack)
            {
                List<string> categories= new List<string>();
                categories.Add("Public Chartered University");
                categories.Add("Public University Constituent College");
                categories.Add("Private Chartered University");
                categories.Add("Private Constituent College");
                categories.Add("Operating with Letter of Interim Authority");
                //statusCategory.DataSource = categories;
                //statusCategory.DataBind();
                List<string> sponsors = new List<string>();
                sponsors.Add("GOVERNMENT");
                sponsors.Add("INDIVIDUAL");
                sponsors.Add("NON GOVERNMENT ORGANIZATION");
                sponsors.Add("RELIGIOUS ORGANIZATION");
              
                }
            }
            
        }
    
}
