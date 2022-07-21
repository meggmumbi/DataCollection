using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class Land : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = Config.ReturnNav();
                var ownerships = nav.ResourceCategorization.Where(r => r.Department == "Land");
                ownership.DataSource = ownerships;
                ownership.DataValueField = "Id";
                ownership.DataTextField = "Category";
                ownership.DataBind();

                editOwnershipStatus.DataSource = ownerships;
                editOwnershipStatus.DataValueField = "Id";
                editOwnershipStatus.DataTextField = "Category";
                editOwnershipStatus.DataBind();

                var campuses = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                campus.DataSource = campuses;
                campus.DataTextField = "Description";
                campus.DataValueField = "No";
                campus.DataBind();


                editCampus.DataSource = campuses;
                editCampus.DataTextField = "Description";
                editCampus.DataValueField = "No";
                editCampus.DataBind();
            }




        }

        protected void deleteLand_Click(object sender, EventArgs e)
        {
            try {
                string tRemoveLandCode = removeLandCode.Text.Trim();
                int mLandCode = Convert.ToInt32(tRemoveLandCode);
                string status =  new Config().ObjNav()
                      .DeleteLand(mLandCode, Session["Code"].ToString(),Session["Password"].ToString());
                string[] info = status.Split('*');
                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //if (status == "success")
                //{
                //    feedback.InnerHtml = "<div class='alert alert-success'> The University land Details was successfully deleted  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //}
                //else{

                //    feedback.InnerHtml = "<div class='alert alert-danger'> The University land Details could not be deleted.Kindly ensure that the Data collection period is still open<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                //}
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            string tCampus = string.IsNullOrEmpty(campus.SelectedValue) ? "" : campus.SelectedValue;
            string tOwnership = string.IsNullOrEmpty(ownership.SelectedValue) ? "" : ownership.SelectedValue;
            string tSize = string.IsNullOrEmpty(landSize.Text) ? "" : landSize.Text;
            string tLrNumber = string.IsNullOrEmpty(lRNumber.Text) ? "" : lRNumber.Text;
            string message = "";
            bool error = false;
            int mOwnership = 0;
            decimal mSize = 0;
            try
            {
                if (tCampus.Length<1)
                {
                    error = true;
                    message = "Please select the campus";
                }
                if (tLrNumber.Length<1)
                {
                    error = true;
                    message = "Please enter the land's LR Number";
                }
                try
                {
                    mSize = Convert.ToDecimal(tSize);
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter a valid value for land size";
                }
                try
                {
                    mOwnership = Convert.ToInt32(tOwnership);
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please select a valid value for ownership status";
                }
                if(!titleDeed.HasFile)
                {
                    error = true;
                    message = "Please upload Title Deed/Lease Agreement(Copy), it cannot be empty!";
                }
                if (error)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    string status = new Config().ObjNav()
                        .AddLand(tCampus, tOwnership, mSize, tLrNumber, Session["Code"].ToString(),
                            Session["Password"].ToString());
                    string[] info = status.Split('*');
                    feedback.InnerHtml ="<div class='alert alert-success'>The University Land Details were successfully Submitted. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    if (info[0] == "success")
                    {
                        string filesFolder = ConfigurationManager.AppSettings["FilesLocation"];
                        string filelocations = filesFolder + "Customer Card" + "/";
                        String universityNo = Convert.ToString(Session["UniversityCode"]);
                        universityNo = universityNo.Replace('/', '_');
                        universityNo = universityNo.Replace(':', '_');
                        String documentDirectory = filelocations + universityNo + "/";
                        string myName = "";
                        if (titleDeed.HasFile)
                        {
                            try
                            {
                                if (Directory.Exists(filelocations))
                                {
                                    string tTitleDeed = System.IO.Path.GetExtension(titleDeed.FileName);
                                    string titleExtension = System.IO.Path.GetExtension(titleDeed.FileName);
                                    Boolean createDirectory = true;
                                    try
                                    {
                                        if (!Directory.Exists(documentDirectory))
                                        {
                                            Directory.CreateDirectory(documentDirectory);
                                        }
                                    }
                                    catch (Exception)
                                    {
                                        createDirectory = false;
                                        feedback.InnerHtml = "<div class='alert alert-danger'>We could not create a directory for your documents. Please try again" +
                                                                        "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                                    }
                                    if (createDirectory)
                                    {
                                        if (new Config().IsAllowedExtension(titleExtension))
                                        {

                                            string titleDeedFile =  Session["UniversityCode"] + "_" + tLrNumber + "_TitleDeed_" + titleDeed.FileName;
                                            titleDeedFile = titleDeedFile.Replace(':', '_');
                                            titleDeedFile = documentDirectory + titleDeedFile;
                                            myName = titleDeedFile;
                                            titleDeed.SaveAs(titleDeedFile);
                                            if (File.Exists(titleDeedFile))
                                            {
                                                feedback.InnerHtml =
                                                    "<div class='alert alert-success'>The University Land Details were successfully Submitted. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                            }
                                            else
                                            {
                                                feedback.InnerHtml =
                                                    "<div class='alert alert-danger'>The title deed could not be uploaded. " + myName + " Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                            }


                                        }
                                        else
                                        {
                                            feedback.InnerHtml = "<div class='alert alert-danger'>The documents' file extension is not allowed. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                        }

                                    }
                                    else
                                    {
                                        feedback.InnerHtml = "<div class='alert alert-danger'>The documents folder defined does not exist in the server. Please contact support. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                    }

                                }
                            }
                            catch (Exception ex)
                            {
                                feedback.InnerHtml = "<div class='alert alert-danger'>The documents could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                            }
                        }
                        else
                        {
                            feedback.InnerHtml = "<div class='alert alert-danger'>Please select the title deed/Lease agreement to upload.  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                        }
                    }
                }

                
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }


        }
        protected void editLand_Click(object sender, EventArgs e)
        {
            //campus, ownership status, size, lr number
            string tCampus = string.IsNullOrEmpty(editCampus.SelectedValue) ? "" : editCampus.SelectedValue;
            string tOwnership = string.IsNullOrEmpty(editOwnershipStatus.SelectedValue) ? "" : editOwnershipStatus.SelectedValue;
            string tSize = string.IsNullOrEmpty(editLandSize.Text) ? "" : editLandSize.Text;
            string tLrNumber = string.IsNullOrEmpty(editLRNumber.Text) ? "" : editLRNumber.Text;
            string message = "";
            bool error = false;
            int mOwnership = 0;
            decimal mSize = 0;
            try
            {
                string teditLandCode = editLandCode.Text.Trim();
                int mLandCode = Convert.ToInt32(teditLandCode);
                if (tCampus.Length<1)
                {
                    error = true;
                    message = "Please select the campus";
                }if (tLrNumber.Length<1)
                {
                    error = true;
                    message = "Please enter the land's LR Number";
                }
                try
                {
                    mSize = Convert.ToDecimal(tSize);
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter a valid value for land size";
                }
                try
                {
                    mOwnership = Convert.ToInt32(tOwnership);
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please select a valid value for ownership status";
                }
                if (error)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    string status = new Config().ObjNav()
                        .EditLand(mLandCode, tCampus, mOwnership, mSize, tLrNumber, Session["Code"].ToString(),
                            Session["Password"].ToString());
                    string[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    if (info[0] == "success")
                    {
                        string filesFolder = ConfigurationManager.AppSettings["FilesLocation"];
                        string myName = "";
                        string filelocations = filesFolder + "Customer Card"+"/" + Session["UniversityCode"] + "/";
                        if (editTitle.HasFile)
                        {
                            try
                            {
                                if (Directory.Exists(filelocations))
                                {
                                    string tTitleDeed = System.IO.Path.GetExtension(editTitle.FileName);
                                    string titleExtension = System.IO.Path.GetExtension(editTitle.FileName);
                                    if (new Config().IsAllowedExtension(titleExtension))
                                    {

                                        string titleDeedFile = Session["UniversityCode"] + tLrNumber + "_TitleDeed_" + editTitle.FileName;
                                        titleDeedFile = titleDeedFile.Replace(':', '_');
                                        titleDeedFile = filelocations + titleDeedFile;
                                        myName = titleDeedFile;
                                        editTitle.SaveAs(titleDeedFile);
                                        if (File.Exists(titleDeedFile))
                                        {
                                            feedback.InnerHtml =
                                                "<div class='alert alert-success'>The University Land Details were successfully Submitted. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                        }
                                        else
                                        {
                                            feedback.InnerHtml =
                                                "<div class='alert alert-danger'>The title deed could not be uploaded. " + myName + " Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                        }


                                    }
                                    else
                                    {
                                        feedback.InnerHtml = "<div class='alert alert-danger'>The documents' file extension is not allowed. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                    }

                                }
                                else
                                {
                                    feedback.InnerHtml = "<div class='alert alert-danger'>The documents folder defined does not exist in the server. Please contact support. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                }

                            }
                            catch (Exception ex)
                            {
                                feedback.InnerHtml = "<div class='alert alert-danger'>The documents could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                            }
                        }
                        else
                        {
                            feedback.InnerHtml = "<div class='alert alert-danger'>Please select the title deed/Lease agreement to upload.  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                        }
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