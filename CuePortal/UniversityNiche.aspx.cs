using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class UniversityNiche : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SavePhilosophy_Click(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string universityCode = Convert.ToString(Session["UniversityCode"]);
                string tuniversityniche = "";
                try
                {
                    tuniversityniche = universityniche.Text.Trim();
                    if (tuniversityniche.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the Philosophical Basis/Niche of the University";
                }
                if (error)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    string status = new Config().ObjNav()
                    .AddPhilosophy(universityCode, tuniversityniche);
                    string[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    if (info[0] == "success")
                    {
                        feedback.InnerHtml =
                            "<div class='alert alert-success'>The university philosophical basis details was successfully updated <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        feedback.InnerHtml =
                            "<div class='alert alert-danger'>The university  philosophical basis details was not updated  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        protected void EditUniversityNiche_Click(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string universityCode = Convert.ToString(Session["UniversityCode"]);
                // string teditnichedetails = editnichedetails.Text.Trim();
                string teditnichedetails = "";
                try
                {
                    teditnichedetails = editnichedetails.Text.Trim();
                    if (teditnichedetails.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the Philosophical Basis/Niche of the University";
                }
                if (error)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    string status = new Config().ObjNav()
                       .Editphylosophy(universityCode, teditnichedetails);
                    string[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    if (info[0] == "success")
                    {
                        feedback.InnerHtml = "<div class='alert alert-success'>The University Philosophical Basis Details was successfully updated</div>";
                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>The  University Philosophical Basis Details could not be updated</div>";
                    }
                }
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
    }
}