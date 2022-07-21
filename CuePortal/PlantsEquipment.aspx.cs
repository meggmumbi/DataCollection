using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class PlantsEquipment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


            if (!IsPostBack)
            {
                var nav = Config.ReturnNav();
                var categories = nav.ResourceCategorization.Where(r => r.Department == "Plants and Capital Equipment");
                type.DataSource = categories;
                type.DataValueField = "Category";
                type.DataTextField = "Category";
                type.DataBind();


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


                var teditTypes = nav.ResourceCategorization.Where(r => r.Department == "Plants and Capital Equipment");
                editTypes.DataSource = teditTypes;
                editTypes.DataValueField = "Category";
                editTypes.DataTextField = "Category";
                editTypes.DataBind();
            }



        }
        protected void deletePlants_Click(object sender, EventArgs e)
        {
            try
            {
                string tremoveplantCode = removeplantCode.Text.Trim();
                int mplantCode = Convert.ToInt32(tremoveplantCode);
                string status = new Config().ObjNav()
                          .DeletePlantsEquipments(mplantCode, Session["Code"].ToString(), Session["Password"].ToString());
                string[] info = status.Split('*');
                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        public void addPlantsEquipment_Click(object sender, EventArgs e)
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
                    message = "Please select the Campus Name"; ;
                }
                string tCategory = "";
                try
                {
                    tCategory = type.SelectedValue.Trim();
                    if (tCategory.Length < 1)
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
                    message = "Please enter the Plant Equipment Location/Block"; ;
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
                        .AddPlantsEquipment(tCampus, tCategory, mquantity, tlocation, userCode, password);
                    string[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                }
            }
            catch (Exception y)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + y.Message + "</div>";
            }
        }
        protected void EditPlantsEquipments(object sender, EventArgs e)
        {
            string universityCode = Convert.ToString(Session["UniversityCode"]);
            string teditcampus = editcampus.SelectedValue;
            string teditTypes = editTypes.SelectedValue;
            int teditQuantity = Convert.ToInt32(editQuantity.Text.Trim());
            string teditLocation = editLocation.Text.Trim();
            string userCode = Convert.ToString(Session["Code"]);
            string password = Convert.ToString(Session["Password"]);
            string status = new Config().ObjNav()
                .EditPlantsEquipments(universityCode, teditcampus, teditTypes, teditQuantity, teditLocation, userCode, password);
            string[] info = status.Split('*');
            feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            if (info[0] == "success")
            {
                feedback.InnerHtml = "<div class='alert alert-success'>The Plants Equipments was successfully updated</div>";
            }
            else
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>The Plants Equipments could not be updated</div>";
            }
        }
    }
}

