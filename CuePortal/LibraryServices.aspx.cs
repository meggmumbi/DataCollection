using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class LibraryServices : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                var nav = Config.ReturnNav();
                var universityCampus = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                universitylibrarycampus.DataSource = universityCampus;
                universitylibrarycampus.DataValueField = "No";
                universitylibrarycampus.DataTextField = "Description";
                universitylibrarycampus.DataBind();

                editlibraryname.DataSource = universityCampus;
                editlibraryname.DataValueField = "No";
                editlibraryname.DataTextField = "Description";
                editlibraryname.DataBind();
            }
        }
        protected void SubmitServices_Click(object sender, EventArgs e)
        {
            string tlibrarycampus = universitylibrarycampus.SelectedValue;
            bool tinformationliteracy = false;
            if (informationliteracy.Checked)
            {
                tinformationliteracy = true;
            }
            bool treferenceinformation = false;
            if (referenceinformation.Checked)
            {
                treferenceinformation = true;
            }
            bool tcirculations = false;
            if (circulations.Checked)
            {
                tcirculations = true;
            }
            bool tawareness = false;
            if (awareness.Checked)
            {
                tawareness = true;
            }
            bool tinterlibraryuloans = false;
            if (interlibraryuloans.Checked)
            {
                tinterlibraryuloans = true;
            }
            bool treprographic = false;
            if (reprographic.Checked)
            {
                treprographic = true;
            }
            bool tmultimedia = false;
            if (multimedia.Checked)
            {
                tmultimedia = true;
            }
            bool tknowledgemanagement = false;
            if (knowledgemanagement.Checked)
            {
                tknowledgemanagement = true;
            }
            bool tpreservation = false;
            if (preservation.Checked)
            {
                tpreservation = true;
            }
            bool tarchivings = false;
            if (archiving.Checked)
            {
                tarchivings = true;
            }
            bool tinformation = false;
            if (information.Checked)
            {
                tinformation = true;
            }
           
            string userCode = Session["Code"].ToString();
            string password = Session["Password"].ToString();
            string status = new Config().ObjNav().AddLibraryServices(tlibrarycampus, tinformationliteracy, treferenceinformation, tcirculations, tawareness,
                tinterlibraryuloans, treprographic, tmultimedia, tknowledgemanagement, tpreservation, tarchivings, userCode, password);
            string[] info = status.Split('*');
            feedback.InnerHtml = Config.GetAlert(info[0], info[1]);
            if (info[0] == "success")
            {
                feedback.InnerHtml = "<div class='alert alert-success'>The University Library Services Details has been submitted Successfully.</div>";
            }
            else
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>The University Library Services Details was not submitted Successfully.Kindly Try Again</div>";

            }
        }
        protected void UpdateLibraryServices_Click(object sender, EventArgs e)
        {
            string tlibraryname = editlibraryname.SelectedValue;
            bool tinformationliteracy = false;
            if (editinfromationliteracy.Checked)
            {
                tinformationliteracy = true;
            }
            bool treferenceinformation = false;
            if (editreferencinformation.Checked)
            {
                treferenceinformation = true;
            }
            bool tcirculations = false;
            if (editcirculation.Checked)
            {
                tcirculations = true;
            }
            bool tawareness = false;
            if (editawareness.Checked)
            {
                tawareness = true;
            }
            bool tinterlibraryuloans = false;
            if (editlibraryloans.Checked)
            {
                tinterlibraryuloans = true;
            }
            bool treprographic = false;
            if (editreprographic.Checked)
            {
                treprographic = true;
            }
            bool tmultimedia = false;
            if (editmultimedia.Checked)
            {
                tmultimedia = true;
            }
            bool tknowledgemanagement = false;
            if (editknowledgemanagement.Checked)
            {
                tknowledgemanagement = true;
            }
            bool tpreservation = false;
            if (editpreservation.Checked)
            {
                tpreservation = true;
            }
            
            bool tarchivings = false;
            if (editarchiving.Checked)
            {
                tarchivings = true;
            }
            bool teditinginformation = false;
            if (editinginformation.Checked)
            {
                teditinginformation = true;
            }
            string userCode = Session["Code"].ToString();
            string password = Session["Password"].ToString();
            string status = new Config().ObjNav().AddLibraryServices(tlibraryname, tinformationliteracy, treferenceinformation, tcirculations, tawareness,
                tinterlibraryuloans, treprographic, tmultimedia, tknowledgemanagement, tpreservation, tarchivings, userCode, password);
            string[] info = status.Split('*');
            feedback.InnerHtml = Config.GetAlert(info[0], info[1]);
            if (info[0] == "success")
            {
                feedback.InnerHtml = "<div class='alert alert-success'>The University Library Services Details has been Updated Successfully.</div>";
            }
            else
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>The University Library Services Details was not Updated Successfully.Kindly Try Again</div>";

            }
        }
        protected void deleteLibrary_Click(object sender, EventArgs e)
        {
            try
            {
                string tremoveLibraryCode = removeLibraryCode.Text.Trim();
                int mLibraryCode = Convert.ToInt32(tremoveLibraryCode);
                string status = new Config().ObjNav()
                          .DeleteLibraryServices(mLibraryCode, Session["Code"].ToString(), Session["Password"].ToString());
                string[] info = status.Split('*');
                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
    }
}