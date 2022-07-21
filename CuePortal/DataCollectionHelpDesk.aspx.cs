using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class DataCollectionHelpDesk : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                sendername.Text = Convert.ToString(Session["Name"]);
                email.Text = Convert.ToString(Session["EmailAddress"]);

                daterequested.Text = Convert.ToDateTime(DateTime.Now).ToString("dd/MM/yyyy");
                timerequested.Text = Convert.ToDateTime(DateTime.Now).ToString("HH:mm tt");

                var nav = Config.ReturnNav();
                var categories = nav.ICTHelpDeskCategory.Where(x=> x.Applies_to_Internal == false).ToList();
                category.DataSource = categories;
                category.DataValueField = "Code";
                category.DataTextField = "Description";
                category.DataBind();
            }
        }

        protected void submit_Click(object sender, EventArgs e)
        {
            try
            {
                string docNo = "";
                string unicode = Convert.ToString(Session["UniversityCode"]);
                string ndate = daterequested.Text.Trim();
                DateTime txtdaterequested = new DateTime();
                try
                {
                    txtdaterequested = DateTime.ParseExact(ndate, "d/M/yyyy", CultureInfo.InvariantCulture);
                }
                catch (Exception)
                {
                }
                string ntime = timerequested.Text.Trim();
                DateTime txttimerequested = new DateTime();
                try
                {
                    txttimerequested = DateTime.ParseExact(ntime, "HH:mm tt", CultureInfo.InvariantCulture);
                }
                catch (Exception)
                {
                }
                string userName = Convert.ToString(Session["Name"]);
                string userEmail = Convert.ToString(Session["EmailAddress"]);
                string txtcategory = category.SelectedValue.Trim();
                string txtdescription = description.Text.Trim();
                bool hasAttachment = false;
                if (attached_file.HasFile)
                {
                    hasAttachment = true;
                }
                else
                {
                    hasAttachment = false;
                }

                string status = new Config().ObjNav().FnSubmitICTHelpDeskRequest(docNo, txtdaterequested, txttimerequested, unicode, userName, userEmail, txtcategory, txtdescription, hasAttachment);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-info'>" + info[1] + "</div>";
                }
                else
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "</div>";
                }
            }
            catch (Exception y)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + y.Message + "</div>";
            }
        }
    }
}