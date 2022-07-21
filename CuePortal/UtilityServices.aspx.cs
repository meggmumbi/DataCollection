using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class UtilityServices : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = Config.ReturnNav();
                var categories = nav.ResourceCategorization.Where(r => r.Department == "Utility Services");
                category.DataSource = categories;
                category.DataValueField = "Category";
                category.DataTextField = "Category";
                category.DataBind();

                editCategory.DataSource = categories;
                editCategory.DataValueField = "Category";
                editCategory.DataTextField = "Category";
                editCategory.DataBind();


                var campuses = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                campus.DataSource = campuses;
                campus.DataTextField = "Description";
                campus.DataValueField = "No";
                campus.DataBind();



                List<string> allStatus = new List<string>();
                allStatus.Add("Working");
                allStatus.Add("Not Working");
                utilstatus.DataSource = allStatus;
                utilstatus.DataBind();


                List<string> teditStatus = new List<string>();
                teditStatus.Add("Working");
                teditStatus.Add("Not Working");
                editStatus.DataSource = teditStatus;
                editStatus.DataBind();


                var teditcampus = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                editcampus.DataSource = teditcampus;
                editcampus.DataTextField = "Description";
                editcampus.DataValueField = "No";
                editcampus.DataBind();
            }
        }
        protected void deleteUtility_Click(object sender, EventArgs e)
        {
            try
            {
                string tremoveUtilityCode = removeUtilityCode.Text.Trim();
                int mUtilityCode = Convert.ToInt32(tremoveUtilityCode);
                string status = new Config().ObjNav()
                          .DeleteUtilityService(mUtilityCode, Session["Code"].ToString(), Session["Password"].ToString());
                string[] info = status.Split('*');
                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        protected void addUtility_Click(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string tcampus ="";
                try
                {
                    tcampus = campus.Text.Trim();
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
                string tcategory = "";
                try
                {
                    tcategory = category.Text.Trim();
                    if (tcategory.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please select the Category"; ;
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
                    message = "Please enter the Name/Description"; ;
                }
                string tutilstatus = "";
                try
                {
                    tutilstatus = utilstatus.Text.Trim();
                    if (tutilstatus.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please select the Utility Status"; ;
                }
                string tcapacity = "";
                try
                {
                    tcapacity = capacity.Text.Trim();
                    if (tcapacity.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the Capacity"; ;
                }
                string tserviceProvider = "";
                try
                {
                    tserviceProvider = serviceProvider.Text.Trim();
                    if (tserviceProvider.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the Service Provider"; ;
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
                        .AddUtilityService(tcampus, tcategory, tdescription, tutilstatus, tcapacity, tserviceProvider, userCode, password);
                    string[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    if (info[0] == "success")
                    {
                        feedback.InnerHtml =
                            "<div class='alert alert-success'>The University utility services was successfully Submitted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        feedback.InnerHtml =
                            "<div class='alert alert-danger'>The University utility services could not be Submitted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }

            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        protected void delete_Click(object sender, EventArgs e)
        {
            try
            {
                string tremoveSanitationCode = removeUtilityCode.Text.Trim();
                int mutility = Convert.ToInt32(tremoveSanitationCode);
                string status = new Config().ObjNav()
                          .DeleteUtilityService(mutility, Session["Code"].ToString(), Session["Password"].ToString());
                string[] info = status.Split('*');
                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void EditUtility(object sender, EventArgs e)
        {
            string universityCode = Convert.ToString(Session["UniversityCode"]);
            string teditcampus = editcampus.SelectedValue;
            string teditCategory = editCategory.SelectedValue;
            string teditStatus = editStatus.SelectedValue;
            string teditDescription = editDescription.Text.Trim();
            string teditCapacity = editCapacity.Text.Trim();
            string teditService = editService.Text.Trim();
            string userCode = Convert.ToString(Session["Code"]);
            string password = Convert.ToString(Session["Password"]);
            string status = new Config().ObjNav()
                .EditUtility(universityCode, teditcampus, teditCategory, teditDescription,teditStatus, teditCapacity, teditService, userCode, password);
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
}