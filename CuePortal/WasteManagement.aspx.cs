using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class WasteManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


            if (!IsPostBack)
            {
                var nav = Config.ReturnNav();
                var categories = nav.ResourceCategorization.Where(r => r.Department == "Waste Managemnet Facilities");
                category.DataSource = categories;
                category.DataValueField = "Category";
                category.DataTextField = "Category";
                category.DataBind();

                var campuses = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                campus.DataSource = campuses;
                campus.DataTextField = "Description";
                campus.DataValueField = "No";
                campus.DataBind();


                var teditCampusName = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                editCampusName.DataSource = teditCampusName;
                editCampusName.DataTextField = "Description";
                editCampusName.DataValueField = "No";
                editCampusName.DataBind();

                var teditcategory = nav.ResourceCategorization.Where(r => r.Department == "Waste Managemnet Facilities");
                editcategory.DataSource = teditcategory;
                editcategory.DataValueField = "Id";
                editcategory.DataTextField = "Category";
                editcategory.DataBind();

                var facilitycategories = nav.ResourcesSubCategories.Where(r => r.Category == category.SelectedValue);
                wastesubcategories.DataSource = facilitycategories;
                wastesubcategories.DataValueField = "SubCategory";
                wastesubcategories.DataTextField = "SubCategory";
                wastesubcategories.DataBind();
            }
        }
         protected void deleteWaste_Click(object sender, EventArgs e)
        {
            try
            {
                //removeLandCode
                string tremoveWasteCode = removeWasteCode.Text.Trim();
                int mWasteCode = Convert.ToInt32(tremoveWasteCode);
                string status = new Config().ObjNav()
                          .DeleteWasteManagement(mWasteCode, Session["Code"].ToString(), Session["Password"].ToString());
                string[] info = status.Split('*');
                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        public void filterfacilitytypes()
        {
            var nav = Config.ReturnNav();
            var categories = nav.ResourcesSubCategories.Where(r => r.Category == category.SelectedValue);
            wastesubcategories.DataSource = categories;
            wastesubcategories.DataValueField ="SubCategory";
            wastesubcategories.DataTextField = "SubCategory";
            wastesubcategories.DataBind();
        }

        protected void facilities_SelectedIndexChanged(object sender, EventArgs e)
        {
            filterfacilitytypes();
        }
        protected void addWaste_Click(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string tCampus = "";
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
                    message = "Please select the Campus Name"; 
                }
                string tCategory = "";
                try
                {
                    tCategory = category.SelectedValue.Trim();
                    if (tCategory.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please select the Category Name"; 
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
                    message = "Please enter the NEMA Disposal Method/Description"; 
                }
                string twastesubcategories = "";
                try
                {
                    twastesubcategories = wastesubcategories.SelectedValue;
                    if (twastesubcategories.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please select the Waste Management Facility Sub-Categories"; 
                }
                string twastecapacity = "";
                try
                {
                    twastecapacity = wastecapacity.Text.Trim();
                    if (twastecapacity.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the Capacity";
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
                        .AddWasteManagement(tCampus, tCategory, tdescription, twastesubcategories, twastecapacity, userCode, password);
                    string[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception y)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + y.Message + "</div>";
            }
        }
        protected void EditWasteManagement(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string universityCode = Convert.ToString(Session["UniversityCode"]);
                string teditCampusName = "";
                try
                {
                    teditCampusName = editCampusName.SelectedValue;
                    if (teditCampusName.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please select the Campus Name"; ;
                }
                string teditcategory = "";
                try
                {
                    teditcategory = editcategory.SelectedValue;
                    if (teditcategory.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please select the Category Name"; ;
                }
                string teditmethod = editmethod.Text.Trim();
                try
                {
                    teditmethod = editmethod.Text.Trim();
                    if (teditmethod.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the NEMA Disposal Method/Description";
                }
                string teditanyother ="";
                try
                {
                    teditanyother = editanyother.Text.Trim();
                    if (teditanyother.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter any hazardous material(s))";
                }
                string teditcapacity = "";
                try
                {
                    teditcapacity = editcapacity.Text.Trim();
                    if (teditcapacity.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter Waste Capacity)";
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
                        .EditWasteManagement(universityCode, teditCampusName, teditcategory, teditmethod, teditanyother, teditcapacity, userCode, password);
                    string[] info = status.Split('*');
                    if (status == "Success")
                    {
                        feedback.InnerHtml = "<div class='alert alert-success'>The Waste Managment details was successfully updated</div>";
                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>The Waste Managment details could not be updated</div>";
                    }
                }
            }
            catch (Exception)
            {

            }
            
        }
    }

}
