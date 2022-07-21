using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class UniversityComments : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        
    }
    protected void SubmitComments_Click(object sender, EventArgs e)
    {
        try
        {
                string taddComment = txtaddComment.Text.Trim();
                string university = Convert.ToString(Session["UniversityCode"]);
                string userCode = Convert.ToString(Session["Code"]);
                string status = new Config().ObjNav()
                .AddComments(userCode, university, taddComment);
            if (status !="success")
            {
                feedback.InnerHtml =
                    "<div class='alert alert-success'>Thank you. You comments were succsefully submited to CUE<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            else
            {
                feedback.InnerHtml =
                    "<div class='alert alert-danger'>Your comments could not be submitted<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        catch (Exception m)
        {
            feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        }

    }
}
}