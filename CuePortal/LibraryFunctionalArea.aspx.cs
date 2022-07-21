using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class LibraryFunctionalArea : System.Web.UI.Page
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
        protected void SubmitFunctionalArea_Click(object sender, EventArgs e)
        {
            string tlibrarycampus = universitylibrarycampus.SelectedValue;
            bool tcirculations = false;
            if (circulations.Checked)
            {
                tcirculations = true;
            }
            bool treferenceinformation = false;
            if (referenceinformation.Checked)
            {
                treferenceinformation = true;
            }
            bool tdigitalsections = false;
            if (digitalsections.Checked)
            {
                tdigitalsections = true;
            }
            bool tlibrarianoffice = false;
            if (librarianoffice.Checked)
            {
                tlibrarianoffice = true;
            }
            bool tstaffworking = false;
            if (staffworking.Checked)
            {
                tstaffworking = true;
            }
            bool ttrechnicalarea = false;
            if (trechnicalarea.Checked)
            {
                ttrechnicalarea = true;
            }
            bool tstackarea = false;
            if (stackarea.Checked)
            {
                tstackarea = true;
            }
            bool treadingsection = false;
            if (readingsection.Checked)
            {
                treadingsection = true;
            }
            bool tluggagearea = false;
            if (luggagearea.Checked)
            {
                tluggagearea = true;
            }
            bool treprographic = false;
            if (reprographic.Checked)
            {
                treprographic = true;
            }

            string userCode = Session["Code"].ToString();
            string password = Session["Password"].ToString();
            string status = new Config().ObjNav().AddLibraryFunctionalAreas(tlibrarycampus, tcirculations, treferenceinformation, tdigitalsections, tlibrarianoffice,
                tstaffworking, ttrechnicalarea, tstackarea, treadingsection, tluggagearea, treprographic, userCode, password);
            string[] info = status.Split('*');
            feedback.InnerHtml = Config.GetAlert(info[0], info[1]);
            if (info[0] == "success")
            {
                feedback.InnerHtml = "<div class='alert alert-success'>The University Library Functional Area Details has been submitted Successfully.</div>";
            }
            else
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>The University Library Functional Area Details was not submitted Successfully.Kindly Try Again</div>";

            }
        }
        protected void EditFunctionalArea_Click(object sender, EventArgs e)
        {
            string tlibrarycampus = editlibraryname.SelectedValue;
            bool tcirculations = false;
            if (editcirculation.Checked)
            {
                tcirculations = true;
            }
            bool treferenceinformation = false;
            if (editreference.Checked)
            {
                treferenceinformation = true;
            }
            bool tdigitalsections = false;
            if (editdigital.Checked)
            {
                tdigitalsections = true;
            }
            bool tlibrarianoffice = false;
            if (editlibrarian.Checked)
            {
                tlibrarianoffice = true;
            }
            bool tstaffworking = false;
            if (editworking.Checked)
            {
                tstaffworking = true;
            }
            bool ttrechnicalarea = false;
            if (edittechnical.Checked)
            {
                ttrechnicalarea = true;
            }
            bool tstackarea = false;
            if (editstackarea.Checked)
            {
                tstackarea = true;
            }
            bool treadingsection = false;
            if (editreading.Checked)
            {
                treadingsection = true;
            }
            bool tluggagearea = false;
            if (editluggage.Checked)
            {
                tluggagearea = true;
            }
            bool treprographic = false;
            if (editreprographic.Checked)
            {
                treprographic = true;
            }

            string userCode = Session["Code"].ToString();
            string password = Session["Password"].ToString();
            string status = new Config().ObjNav().AddLibraryFunctionalAreas(tlibrarycampus, tcirculations, treferenceinformation, tdigitalsections, tlibrarianoffice,
                tstaffworking, ttrechnicalarea, tstackarea, treadingsection, tluggagearea, treprographic, userCode, password);
            string[] info = status.Split('*');
            feedback.InnerHtml = Config.GetAlert(info[0], info[1]);
            if (info[0] == "success")
            {
                feedback.InnerHtml = "<div class='alert alert-success'>The University Library Functional Area Details has been Updated Successfully.</div>";
            }
            else
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>The University Library Functional Area Details was not Updated Successfully.Kindly Try Again</div>";

            }
        }
        protected void deleteLibrary_Click(object sender, EventArgs e)
        {
            try
            {
                string tremoveLibraryCode = removeLibraryCode.Text.Trim();
                int mLibraryCode = Convert.ToInt32(tremoveLibraryCode);
                string status = new Config().ObjNav()
                          .DeleteLibraryFunctionalAreas(mLibraryCode, Session["Code"].ToString(), Session["Password"].ToString());
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