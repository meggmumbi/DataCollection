using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class RecreationalFacilities : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                var nav = Config.ReturnNav();
                var categories = nav.ResourceCategorization.Where(r => r.Department == "Recreational Facilities");
                typeOfFacility.DataSource = categories;
                typeOfFacility.DataValueField = "Category";
                typeOfFacility.DataTextField = "Category";
                typeOfFacility.DataBind();
            

                var campuses = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                campus.DataSource = campuses;
                campus.DataTextField = "Description";
                campus.DataValueField = "No";
                campus.DataBind();

                List<string> allLocations = new List<string>();
                allLocations.Add("In-Campus");
                allLocations.Add("Off-Campus");
                location.DataSource = allLocations;
                location.DataBind();


                List<string> origin = new List<string>();
                origin.Add("University Owned");
                origin.Add("Leased");
                ownership.DataSource = origin;
                ownership.DataBind();


                var teditType = nav.ResourceCategorization.Where(r => r.Department == "Recreational Facilities");
                editType.DataSource = teditType;
                editType.DataValueField = "Id";
                editType.DataTextField = "Category";
                editType.DataBind();


                var teditCampusName = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                editCampusName.DataSource = teditCampusName;
                editCampusName.DataTextField = "Description";
                editCampusName.DataValueField = "No";
                editCampusName.DataBind();

                List<string> teditLocation = new List<string>();
                teditLocation.Add("In Campus");
                teditLocation.Add("Off Campus");
                editLocation.DataSource = teditLocation;
                editLocation.DataBind();

                List<string> teditOwnership = new List<string>();
                teditOwnership.Add("University Owned");
                teditOwnership.Add("Leased");
                editOwnership.DataSource = teditOwnership;
                editOwnership.DataBind();
                
                var facilitycategories = nav.ResourcesSubCategories.Where(r => r.Category == typeOfFacility.SelectedValue);
                subcategories.DataSource = facilitycategories;
                subcategories.DataValueField = "SubCategory";
                subcategories.DataTextField = "SubCategory";
                subcategories.DataBind();

                var CategoriesCode = typeOfFacility.SelectedValue;
                try
                {
                    if (!(string.IsNullOrEmpty(CategoriesCode)))
                    {
                        filterfacilitytypes();
                    }
                }
                catch (Exception t)
                {

                }
            }
        }

        public void filterfacilitytypes()
        {
            var nav = Config.ReturnNav();
            var categories = nav.ResourcesSubCategories.Where(r => r.Category == typeOfFacility.SelectedValue);
            subcategories.DataSource = categories;
            subcategories.DataValueField = "SubCategory";
            subcategories.DataTextField = "SubCategory";
            subcategories.DataBind();
        }

        protected void facilities_SelectedIndexChanged(object sender, EventArgs e)
        {
            filterfacilitytypes();
        }
        protected void deleteRecreation_Click(object sender, EventArgs e)
            {
            try
            {
                string tremoveRecerationCode = removeRecerationCode.Text.Trim();
                int mRecerationalcode = Convert.ToInt32(tremoveRecerationCode);
                string status = new Config().ObjNav()
                          .DeleteRecreation(mRecerationalcode, Session["Code"].ToString(), Session["Password"].ToString());
                string[] info = status.Split('*');
                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }



        }

        protected void addRecreation_Click(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string tCampus ="";
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
                string tCategory = "";
                try
                {
                    tCategory = typeOfFacility.SelectedValue.Trim();
                    if (tCategory.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please Select the Facilty type"; 
                }
                string tsubCategory = "";
                try
                {
                    tsubCategory = subcategories.SelectedValue.Trim();
                    if (tsubCategory.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please Select the Facilty Sub-Categories";
                }
                string tlocation = "";
                try
                {
                    tlocation = location.SelectedValue.Trim();
                    if (tlocation.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the Facility Location"; 
                }
                string townership = "";
                try
                {
                    townership = ownership.SelectedValue.Trim();
                    if (tlocation.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the ownership status of the Facility";
                }
                string tquantity = quantity.Text.Trim();
                int mquantity = 0;
                try
                {
                    mquantity = Convert.ToInt32(tquantity);
                }
                catch (Exception)
                {
                    mquantity = 0;
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
                        .AddRecreation(tCampus, tlocation, tCategory, mquantity, townership, tsubCategory, userCode, password);
                    string[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception y)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + y.Message + "</div>";
            }
        }
        protected void EditRecreations(object sender, EventArgs e)
        {
            string universityCode = Convert.ToString(Session["UniversityCode"]);
            string teditCampusName = editCampusName.SelectedValue;
            string teditType = editType.SelectedValue;
            string teditLocation = editLocation.SelectedValue;
            int teditQunatity =Convert.ToInt32(editQunatity.Text.Trim());
            string teditOwnership = editOwnership.SelectedValue;
            string userCode = Convert.ToString(Session["Code"]);
            string password = Convert.ToString(Session["Password"]);
            string status = new Config().ObjNav()
                .EditRecreatonal(universityCode, teditCampusName, teditType, teditLocation, teditQunatity, teditOwnership, userCode, password);
            string[] info = status.Split('*');
            feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            if (info[0] == "success")
            {
                feedback.InnerHtml = "<div class='alert alert-success'>The University Recreational Facility Details was successfully updated</div>";
            }
            else
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>The University Recreational Facility Details could not be updated</div>";
            }
        }
    }

}