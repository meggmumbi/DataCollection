using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class UniversityViceChancellor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            var nav = Config.ReturnNav();
            if (!IsPostBack)
            {
                List<string> txtqualification = new List<string>();
                txtqualification.Add("PHD");
                txtqualification.Add("Bachelors");
                txtqualification.Add("Masters");
                txtqualification.Add("Doctorate");
                txtqualification.Add("Postgraduate Diploma");
                txtqualification.Add("Diploma");
                txtqualification.Add("Certificate");
                txtqualifications.DataSource = txtqualification;
                txtqualifications.DataBind();

                List<string> editqualification = new List<string>();
                editqualification.Add("PHD");
                editqualification.Add("Bachelors");
                editqualification.Add("Masters");
                editqualification.Add("Doctorate");
                editqualification.Add("Postgraduate Diploma");
                editqualification.Add("Diploma");
                editqualification.Add("Certificate");
                editqualifications.DataSource = editqualification;
                editqualifications.DataBind();


                var country = nav.countries.ToList().OrderBy(r => r.Name);
                editNationality.DataSource = country;
                editNationality.DataValueField = "Code";
                editNationality.DataTextField = "Name";
                editNationality.DataBind();


                var countries = nav.countries.ToList().OrderBy(r => r.Name);
                txtnationality.DataSource = countries;
                txtnationality.DataValueField = "Code";
                txtnationality.DataTextField = "Name";
                txtnationality.DataBind();

            }
            //try
            //{
            //    string entryNo = Request.QueryString["entry"];

            //    if (!(string.IsNullOrEmpty(entryNo)))
            //    {
            //        int entry = Convert.ToInt32(entryNo);
            //        bool deleted = new Config().ObjNav()
            //         .DeleteChancellors(entry, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
            //        if (deleted)
            //        {
            //            feedback.InnerHtml = "<div class='alert alert-success'>The University Chancellor details was successfully deleted</div>";
            //        }
            //    }

            //}
            //catch (Exception y)
            //{

            //}


        }
        protected void EditChancellor_Onclick(object sender, EventArgs e)
        {
            string universityCode = Convert.ToString(Session["UniversityCode"]);
            string teditName = editName.Text.Trim();
            string teditNationality = editNationality.Text.Trim();
            DateTime teditDate = new DateTime();
            teditDate = DateTime.ParseExact(editDate.Text.Trim(), "d/M/yyyy", CultureInfo.InvariantCulture);
            string teditqualifications = editqualifications.Text.Trim();
            string userCode = Convert.ToString(Session["Code"]);
            string password = Convert.ToString(Session["Password"]);
            string status = new Config().ObjNav()
                .EditChancellors(universityCode, teditName, teditqualifications, teditDate, teditNationality, userCode, password);
            string[] info = status.Split('*');
            feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            if (info[0] == "success")
            {
                feedback.InnerHtml = "<div class='alert alert-success'>The University Chancellor Details was successfully updated</div>";
            }
            else
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>The University Chancellor Details  could not be updated</div>";
            }
        }
        protected void AddChancellor_Onclick(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string universityCode = Convert.ToString(Session["UniversityCode"]);
                //string ttxtchancellorname = txtchancellorname.Text.Trim();
                string ttxtchancellorname = "";
                try
                {
                    ttxtchancellorname = txtchancellorname.Text.Trim();
                    if (ttxtchancellorname.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {

                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid value for Chancellor";
                }

                //string ttxtqualifications = txtqualifications.Text.Trim();
                DateTime ttxtdateofappointment = new DateTime();
                ttxtdateofappointment = DateTime.ParseExact(txtdateofappointment.Text.Trim(), "d/M/yyyy", CultureInfo.InvariantCulture);

                string ttxtqualifications = "";
                try
                {
                    ttxtqualifications = txtqualifications.Text.Trim();
                    if (ttxtqualifications.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {

                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid value for Highets Academic Qualification";
                }
                // string ttxtnationality = txtnationality.Text.Trim();
                string ttxtnationality = "";
                try
                {
                    ttxtnationality = txtnationality.SelectedValue.Trim();
                    if (ttxtnationality.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {

                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid value for Nationality Name";
                }
                int tyearsserved =0;
                try
                {
                    tyearsserved =Convert.ToInt32(yearsserved.Text.Trim());
                    if (tyearsserved < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {

                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid value for Years Served";
                }
                if (error)
                {
                    feedback.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
                    string status = new Config().ObjNav()
                        .AddUniversityViceChancellors(universityCode, ttxtchancellorname, ttxtqualifications, ttxtdateofappointment, ttxtnationality, tyearsserved);
                    string[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    if (info[0] == "success")
                    {
                        feedback.InnerHtml =
                            "<div class='alert alert-success'>The university Chancellor details was successfully Submitted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        feedback.InnerHtml =
                            "<div class='alert alert-danger'>The university Chancellor details was not updated  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }

            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        protected void deleteChancellor_Onclick(object sender, EventArgs e)
        {
            try
            {
                string tremovechancellornamescode = removechancellornamescode.Text.Trim();
                int mremovechancellornamescode = Convert.ToInt32(tremovechancellornamescode);
                bool status = new Config().ObjNav()
                    .DeleteChancellors(mremovechancellornamescode, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                if (status == true)
                {
                    feedback.InnerHtml = "<div class='alert alert-success'> The University Sponsor Details was successfully deleted  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {

                    feedback.InnerHtml = "<div class='alert alert-success'> The University Sponsor Details could not be deleted.Kindly ensure that the Datatc collection period is still open<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

    }
}