using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class Buildings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                var nav = Config.ReturnNav();
                var categories = nav.ResourceCategorization.Where(r => r.Department == "Building");
                category.DataSource = categories;
                category.DataValueField ="Category";
                category.DataTextField = "Category";
                category.DataBind();

                editBuildingtype.DataSource = categories;
                editBuildingtype.DataValueField = "Category";
                editBuildingtype.DataTextField = "Category";
                editBuildingtype.DataBind();

                //var campuse = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                //editCampusName.DataSource = campuse;
                //editCampusName.DataTextField = "Description";
                //editCampusName.DataValueField = "No";
                //editCampusName.DataBind();

                var campuses = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                campus.DataSource = campuses;
                campus.DataTextField = "Description";
                campus.DataValueField = "No";
                campus.DataBind();
                editCampusName.DataSource = campuses;
                editCampusName.DataTextField = "Description";
                editCampusName.DataValueField = "No";
                editCampusName.DataBind();

                var facilitycategories = nav.ResourcesSubCategories.Where(r => r.Category == category.SelectedValue);
                buildingsubcategories.DataSource = facilitycategories;
                buildingsubcategories.DataValueField ="SubCategory";
                buildingsubcategories.DataTextField = "SubCategory";
                buildingsubcategories.DataBind();
            }
        }
        public void filterfacilitytypes()
        {
            var nav = Config.ReturnNav();
            var categories = nav.ResourcesSubCategories.Where(r => r.Category == category.SelectedValue);
            buildingsubcategories.DataSource = categories;
            buildingsubcategories.DataValueField = "SubCategory";
            buildingsubcategories.DataTextField = "SubCategory";
            buildingsubcategories.DataBind();
        }

        protected void facilities_SelectedIndexChanged(object sender, EventArgs e)
        {
            filterfacilitytypes();
        }
        protected void deleteBuilding_Click(object sender, EventArgs e)
        {
            try
            {
                //removeLandCode
                string tremoveBuildingCode = removeBuildingCode.Text.Trim();
                int mBuildingCode = Convert.ToInt32(tremoveBuildingCode);
                string status = new Config().ObjNav()
                          .DeleteBuilding(mBuildingCode, Session["Code"].ToString(), Session["Password"].ToString());
                string[] info = status.Split('*');
                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

    }
        public void editBuilding_Click(object sender,EventArgs e)
        {
            try
            {
                string tCampus = editCampusName.SelectedValue.Trim();
                string tCategory = editBuildingtype.SelectedValue;
                string tDescription = editDescription.Text.Trim();
                string tCapacity = editCapacity.Text.Trim();
                string tFloors = noOfFloors.Text.Trim();
                decimal teditSize = Convert.ToDecimal(editSize.Text.Trim());
                string tLocation = editLocation.Text.Trim();
                string teditBuilding = editBuilding.Text.Trim();
                int teditrooms = Convert.ToInt32(editrooms.Text.Trim());
                int mBuilding = Convert.ToInt32(teditBuilding);
                bool error = false;
                string message = "";
                int mCapacity = 0;         
            try
            {
                mCapacity = Convert.ToInt32(tCapacity);
                if (mCapacity < 1)
                {
                    throw new Exception();
                }
            }
            catch (Exception)
            {
                error = true;
                message = "Please provide a valid value for capacity";
            }
           
            if (error)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + message + "</div>";
            }
                else
                {
                    string userCode = Session["Code"].ToString();
                    string password = Session["Password"].ToString();
                    string status = new Config().ObjNav()
                        .EditBuilding(mBuilding,tCampus, tCategory, tDescription, mCapacity, tLocation, teditSize, teditrooms,userCode, password);
                    string[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception y)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + y.Message + "</div>";
            }       
    
}
       
        protected void addBuilding_Click(object sender, EventArgs e)
        {
           try
            {
                string tCampus = campus.SelectedValue.Trim();
                string tCategory = category.SelectedValue;
                string tDescription = name.Text.Trim();
                string tCapacity = capacity.Text.Trim();
                string tFloors = noOfFloors.Text.Trim();
                string tSizeMetres = size.Text.Trim();
                string tLocation = block.Text.Trim();
                string tnoofrooms = noofrooms.Text.Trim();
                bool tProvisionPWD = provisionForPWD.Checked;
                bool error = false;
                string message = "";
                int mCapacity = 0;
                int mFloors = 0;
                decimal mSize = 0;
                int mnoofrooms = 0;
                try
                {
                    mCapacity = Convert.ToInt32(tCapacity);
                    if (mCapacity < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please provide a valid value for capacity";
                }
                try
                {
                    mFloors = Convert.ToInt32(tFloors);
                    if (mFloors < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please provide a valid value for No. of floors";
                }
                try
                {
                    mSize = Convert.ToDecimal(tSizeMetres);
                    if (mSize < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please provide a valid value for size (sq Metres)";
                }
                if (error)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + message + "</div>";
                }
                try
                {
                    mnoofrooms = Convert.ToInt32(tnoofrooms);
                    if (mnoofrooms < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please provide a valid value for No. of Rooms";
                }
                if (error)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + message + "</div>";
                }
                else
                {
                    string userCode = Session["Code"].ToString();
                    string password = Session["Password"].ToString();
                    string status = new Config().ObjNav()
                        .AddBuilding(tCampus, tCategory, tDescription, mCapacity, mFloors, mSize, tLocation, tProvisionPWD, mnoofrooms,userCode, password);
                    string[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception y)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>"+y.Message+"</div>";
            }
        }
    }
}