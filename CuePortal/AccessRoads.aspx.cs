using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class AccessRoads : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                var nav = Config.ReturnNav();
                var categories = nav.ResourceCategorization.Where(r => r.Department == "Access Roads");
                roadstatus.DataSource = categories;
                roadstatus.DataValueField = "Category";
                roadstatus.DataTextField = "Category";
                roadstatus.DataBind();

                var campuses = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                campus.DataSource = campuses;
                campus.DataTextField = "Description";
                campus.DataValueField = "No";
                campus.DataBind();

                var teditcampus = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                editcampus.DataSource = teditcampus;
                editcampus.DataTextField = "Description";
                editcampus.DataValueField = "No";
                editcampus.DataBind();


                var teditStatus = nav.ResourceCategorization.Where(r => r.Department == "Access Roads");
                editStatus.DataSource = teditStatus;
                editStatus.DataValueField = "Id";
                editStatus.DataTextField = "Category";
                editStatus.DataBind();
            }
        }
        protected void deleteAccessRoads_Click(object sender, EventArgs e)
        {
            try
            {
                //removeLandCode
                string tremoveroadaccessCode = removeroadaccessCode.Text.Trim();
                int mroadCode = Convert.ToInt32(tremoveroadaccessCode);
                string status = new Config().ObjNav()
                          .DeleteAccessRoads(mroadCode, Session["Code"].ToString(), Session["Password"].ToString());
                string[] info = status.Split('*');
                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        public void addAccessRoads_Click(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string tCampus = ""; ;
                try
                {
                    tCampus = campus.SelectedValue.Trim();
                    if (tCampus.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please select the Campus Name"; ;
                }
                string tstatus = "";
                try
                {
                    tstatus = roadstatus.SelectedValue.Trim();
                    if (tstatus.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please Select the Road Status"; ;
                }
                string tdescription = "";
                try
                {
                    tdescription = description.Text.Trim();
                    if (tdescription.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the Access Road Description"; ;
                }
                string tdistance = distance.Text.Trim();
                try
                {
                    tdistance = distance.Text.Trim();
                    if (tdistance.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the Distance from the Main Road"; ;
                }
                if (error)
                {
                    feedback.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
                    string userCode = Session["Code"].ToString();
                    string password = Session["Password"].ToString();
                    string status = new Config().ObjNav()
                        .AddAccessRoads(tCampus, tstatus, tdescription, tdistance, userCode, password);
                    string[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception y)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + y.Message + "</div>";
            }
        }
        protected void EditAccessRoads(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string universityCode = Convert.ToString(Session["UniversityCode"]);
                string teditcampus = "";
                try
                {
                    teditcampus = editcampus.SelectedValue;
                    if (teditcampus.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please select the Campus Name"; ;
                }
                string teditStatus = "";
                try
                {
                    teditStatus = editStatus.SelectedValue;
                    if (teditStatus.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please Select the Road Status"; ;
                }
                string teditDescription = "";
                try
                {
                    teditDescription = editDescription.Text.Trim();
                    if (teditDescription.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the Access Road Description"; ;
                }
                string teditDistance = "";
                try
                {
                    teditDistance = editDistance.Text.Trim();
                    if (teditDistance.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the Distance from the Main Road"; ;
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
                        .EditRoadAccess(universityCode, teditcampus, teditStatus, teditDescription, teditDistance, userCode, password);
                    if (status != "Success")
                    {
                        feedback.InnerHtml = "<div class='alert alert-success'>The Utility was successfully updated</div>";
                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>The Utility could not be updated</div>";
                    }
                }
            }
            catch (Exception)
            {

            }

        }
    }
}
