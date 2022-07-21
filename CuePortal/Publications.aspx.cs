using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class Publications : System.Web.UI.Page
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

              //  LoadDomains();
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
            //try
            //{
            //    string entryNo = Request.QueryString["entry"];

            //    if (!(string.IsNullOrEmpty(entryNo)))
            //    {
            //        int entry = Convert.ToInt32(entryNo);
            //        bool deleted = new Config().ObjNav()
            //         .DeleteResearch(entry, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
            //        if (deleted)
            //        {
            //            feedback.InnerHtml = "<div class='alert alert-success'>The Staff Publications was successfully deleted</div>";
            //        }
            //        }

            //    }
            //catch (Exception y)
            //{

            //}
            
    }

    //protected void domainChange(object sender, EventArgs e)
    //    {
    //        LoadDomains();
    //    }

    //    public void LoadDomains()
    //    {
    //        var nav = Config.ReturnNav();
    //        var domains = nav.SubDomains.Where(r=>r.Domain==domain.SelectedValue);

    //        subdomain.DataSource = domains;
    //        subdomain.DataValueField = "Code";
    //        subdomain.DataTextField = "Description";
    //        subdomain.DataBind();
    //    }
        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            int tcategory = 0;// subdomain.SelectedIndex;
            string tdoi = doinumber.Text.Trim();
            string tdomain = domain.SelectedValue;
            string tsubdomain ="";
            string tcampus = campus.SelectedValue;
            int tpublicationType = publicationType.SelectedIndex;
            string ttitle = title.Text.Trim();
            string tdescription = "Test";
            string tlink = link.Text.Trim();
            string tpatentingOrganisation = patentingOrganisation.Text.Trim();
            string tcopyrightNo ="";
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
                /*
               publicationType : Text;title : Text;description : Text;link : Text;patentingOrganisation : Text;patentNo : Text;patentYear : Integer;authorIds : Text;userName : Text;password : Text)
                */
                string status = new Config().ObjNav()
                .AddResearch(0, tdomain, tsubdomain, tcampus, tpublicationType , ttitle, tdescription, tlink,
                    tpatentingOrganisation, tcopyrightNo, myYear, tauthors, tdoi, userCode, password);
                if (status == "success")
                {
                    feedback.InnerHtml = "<div class='alert alert-success'>The Staff Publication was successfully Submitted</div>";
                }
                else
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>"+ status+"</div>";
                }

            }
           
         
        }
        protected void deletePublication_Click(object sender, EventArgs e)
        {
            try
            {
                string tremovepublicationCode = removepublicationCode.Text.Trim();
                int mremovepublicationCode = Convert.ToInt32(tremovepublicationCode);
                bool status = new Config().ObjNav()
                   .DeleteResearch(mremovepublicationCode, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                //string[] info = status.Split('*');
                if (status == true)
                {
                    feedback.InnerHtml = "<div class='alert alert-success'> The Staff Publications Details was successfully deleted  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {

                    feedback.InnerHtml = "<div class='alert alert-danger'> The Staff Publications Details could not be deleted.Kindly ensure that the Data collection period is still open<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}