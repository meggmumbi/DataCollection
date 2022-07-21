using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class Sanitation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                var nav = Config.ReturnNav();
                var categories = nav.ResourceCategorization.Where(r => r.Department == "Sanitation");
                type.DataSource = categories;
                type.DataValueField = "Category";
                type.DataTextField = "Category";
                type.DataBind();

                var campuses = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                campus.DataSource = campuses;
                campus.DataTextField = "Description";
                campus.DataValueField = "No";
                campus.DataBind();


                var CampusName = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                editCampusName.DataSource = CampusName;
                editCampusName.DataTextField = "Description";
                editCampusName.DataValueField = "No";
                editCampusName.DataBind();

                var types = nav.ResourceCategorization.Where(r => r.Department == "Sanitation");
                editType.DataSource = types;
                editType.DataValueField = "Category";
                editType.DataTextField = "Category";
                editType.DataBind();


            }

        }

        protected void addSanitation_Click(object sender, EventArgs e)
        {

            try
            {
                string message = "";
                bool error = false;
                string tcampus = "";
                try
                {
                    tcampus = campus.SelectedValue;
                    if (tcampus.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please select the Campus Name"; ;
                }
                string tquantity = "";
                try
                {
                    tquantity = quantity.Text.Trim();
                    if (tquantity.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the Number/Quantity"; ;
                }
                string tCampus = campus.SelectedValue;
                try
                {
                    tquantity = quantity.Text.Trim();
                    if (tquantity.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the Number/Quantity:"; ;
                }
                string ttype = "";
                try
                {
                    ttype = type.SelectedValue;
                    if (ttype.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please select the Type"; ;
                }
                string tlocation = "";
                try
                {
                    tlocation = location.Text.Trim();
                    if (tlocation.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the Location/Block"; ;
                }
                if (error)
                {
                    feedback.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
                    string userCode = Convert.ToString(Session["Code"]);
                    string password = Convert.ToString(Session["Password"]);
                    string status = new Config().ObjNav()
                        .AddSanitation(tcampus, ttype, tquantity, tlocation, userCode, password);
                    string[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    if (info[0] == "success")
                    {
                        feedback.InnerHtml = "<div class='alert alert-success'>The  University Sanitation facility was successfully submitted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>The University Sanitation facility could not be submitted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }

            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        protected void deleteSanitation_Click(object sender, EventArgs e)
        {
            try
            {
                string tremoveSanitationCode = removeSanitationCode.Text.Trim();
                int msanitationCode = Convert.ToInt32(tremoveSanitationCode);
                string status = new Config().ObjNav()
                          .DeleteSanitation(msanitationCode, Session["Code"].ToString(), Session["Password"].ToString());
                string[] info = status.Split('*');
                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }

        }
        protected void EditSanitations(object sender, EventArgs e)
        {
            string universityCode = Convert.ToString(Session["UniversityCode"]);
            string teditCampusName = editCampusName.SelectedValue;
            string teditType = editType.SelectedValue;
            string teditname = editname.Text.Trim();
            string teditLocation = editLocation.Text.Trim();
            string userCode = Convert.ToString(Session["Code"]);
            string password = Convert.ToString(Session["Password"]);
            string status = new Config().ObjNav()
                .EditSanitations(teditCampusName, teditType, teditname, teditLocation, userCode, password);
            string[] info = status.Split('*');
            if (status == "success")
            {
                feedback.InnerHtml = "<div class='alert alert-success'>The University Sanitation facility was successfully updated</div>";
            }
            else
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>The University Sanitation  facility could not be updated</div>";
            }
        }


    }
}