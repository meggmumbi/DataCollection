using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class Resources : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          //  new Config().ObjNav().AddStudentDraft("1234", "victor");
            var nav = Config.ReturnNav();
          //  var counties = nav.cou
          List<string> categories = new List<string>();
            categories.Add("Lecture Rooms");
            categories.Add("Lecture Theatres");
            categories.Add("Seminar Rooms");
            categories.Add("Laboratories");
            categories.Add("Specialised labs");
            categories.Add("Computer Rooms");
            categories.Add("Auditorium");
            categories.Add("Academic Staff Offices");
            categories.Add("Administrative Staff Offices");
            categories.Add("Library");
            categories.Add("Student Center");
            categories.Add("Other");
            adminSpaceCategory.DataSource = categories;
            adminSpaceCategory.DataBind();
            var campuses = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
            adminSpacecampus.DataSource = campuses;
            adminSpacecampus.DataTextField = "Description";
            adminSpacecampus.DataValueField = "No";
            adminSpacecampus.DataBind();




        }

        protected void clerkApprove_Click(object sender, EventArgs e)
        {
            bool response =  new Config().ObjNav().Approve("finance", Session["Code"].ToString() , Session["Password"].ToString(), true);
        }

        protected void clerkReject_Click(object sender, EventArgs e)
        {
            bool response = new Config().ObjNav().Approve("finance", Session["Code"].ToString(), Session["Password"].ToString(), false);
        }

        protected void dvcApprove_Click(object sender, EventArgs e)
        {
            bool response = new Config().ObjNav().Approve("finance", Session["Code"].ToString(), Session["Password"].ToString(), true);
        }

        protected void dvcReject_Click(object sender, EventArgs e)
        {
            bool response = new Config().ObjNav().Approve("finance", Session["Code"].ToString(), Session["Password"].ToString(), false);
        }

        protected void vcApprove_Click(object sender, EventArgs e)
        {
            bool response = new Config().ObjNav().Approve("finance", Session["Code"].ToString(), Session["Password"].ToString(), true);
        }

        protected void vcReject_Click(object sender, EventArgs e)
        {
            bool response = new Config().ObjNav().Approve("finance", Session["Code"].ToString(), Session["Password"].ToString(), false);
        }

        protected void Unnamed1_Click(object sender, EventArgs e)
        {
          /*  new Config().ObjNav()
                .AddStudentDraft(idNumber.Text.Trim(), lastName.Text.Trim(), middleName.Text.Trim(),
                    firstName.Text.Trim(), 1, new DateTime(), homeCounty.SelectedValue, "", nationality.SelectedValue, 1,
                    "", yearOfStudy.SelectedValue, disabilityCode.Text.Trim(), "", false, program.Text.Trim(),
                    programLevel.Text.Trim(), new DateTime(), nationality.SelectedValue, Session["Code"].ToString());
       */ }

        protected void Unnamed1_Click1(object sender, EventArgs e)
        {
            try
            {
                decimal space = Convert.ToDecimal(spaceSq.Text.Trim());
                bool added = new Config().ObjNav()
                    .AddAdminSpace(adminSpaceCategory.SelectedValue, space, adminSpacecampus.SelectedValue);
                if (added)
                {
                    feedback.InnerHtml = "<div class='alert alert-success'>The admin space was successfully added</div>";
                }
                else
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>The admin space could not be added. Please try again later</div>";
                }
            }catch(Exception y)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>We encountered an error while processing your request. Please try again later</div>";
            }
        }
    }
}