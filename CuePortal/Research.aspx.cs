using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class Research : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = Config.ReturnNav();
                
                var domains = nav.programdomains;

                domain.DataSource = domains;
                domain.DataValueField = "Code";
                domain.DataTextField = "Description";
                domain.DataBind();

                LoadDomains();
                List<string> publicationTypes = new List<string>();
                publicationTypes.Add("Book");
                publicationTypes.Add("Journal");
                publicationTypes.Add("Audio-Visual");
                publicationType.DataSource = publicationTypes;
                publicationType.DataBind();
                var campuses = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"])); 
                campus.DataSource = campuses;
                campus.DataValueField = "No";
                campus.DataTextField = "Description";
                campus.DataBind();

            }

        }

        protected void domainChange(object sender, EventArgs e)
        {
            LoadDomains();
        }

        public void LoadDomains()
        {
            var nav = Config.ReturnNav();
            var domains = nav.SubDomains.Where(r=>r.Domain==domain.SelectedValue);

            subdomain.DataSource = domains;
            subdomain.DataValueField = "Code";
            subdomain.DataTextField = "Description";
            subdomain.DataBind();
        }
        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            int tcategory = 0;// subdomain.SelectedIndex;
            string tdomain = domain.SelectedValue;
            string tcampus = campus.SelectedValue;
            int tpublicationType = publicationType.SelectedIndex;
            string ttitle = title.Text.Trim();
            string tdescription = description.Text.Trim();
            string tlink = link.Text.Trim();
            string tpatentingOrganisation = patentingOrganisation.Text.Trim();
            string tcopyrightNo = copyrightNo.Text.Trim();
            string tpatentYear = patentYear.Text.Trim();
            string tauthors = authors.Text.Trim();

            string userCode = Convert.ToString(Session["Code"]);
            string password = Convert.ToString(Session["Password"]);
            bool hasErrors = false;
            int myYear = 0;
            try
            {
                if (tpatentYear.Length>0)
                {
                    myYear = Convert.ToInt32(tpatentYear);

                }
                

            }
            catch (Exception t)
            {
                hasErrors = true;
                feedback.InnerHtml = "<div class='alert alert-danger'>Please enter a valid year for Patent / Copyright Year</div>";
            }
            if (!hasErrors)
            {
              /*  String status = new Config().ObjNav()
                .AddResearch(tcategory + "", tdomain, tcampus, tpublicationType + "", ttitle, tdescription, tlink,
                    tpatentingOrganisation, tcopyrightNo, myYear, tauthors, userCode, password);
                String[] info = status.Split('*');
                feedback.InnerHtml = "<div class='alert alert-"+ info[0]+ "'>"+ info[1]+ "</div>";
                */
            }
           
         
        }
    }
}