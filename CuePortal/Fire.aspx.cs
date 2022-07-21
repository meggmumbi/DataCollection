using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class Fire : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = Config.ReturnNav();
                var categories = nav.ResourceCategorization.Where(r => r.Department == "Fire");
                fireClass.DataSource = categories;
                fireClass.DataValueField = "Category";
                fireClass.DataTextField = "Category";
                fireClass.DataBind();

                var campuses = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                campus.DataSource = campuses;
                campus.DataTextField = "Description";
                campus.DataValueField = "No";
                campus.DataBind();

                elevatedCampus.DataSource = campuses;
                elevatedCampus.DataTextField = "Description";
                elevatedCampus.DataValueField = "No";
                elevatedCampus.DataBind();

                editelevetedwatercampus.DataSource = campuses;
                editelevetedwatercampus.DataTextField = "Description";
                editelevetedwatercampus.DataValueField = "No";
                editelevetedwatercampus.DataBind();

                var teditclass = nav.ResourceCategorization.Where(r => r.Department == "Fire");
                editclass.DataSource = teditclass;
                editclass.DataValueField = "Category";
                editclass.DataTextField = "Category";
                editclass.DataBind();

                var teditCampus = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                editCampus.DataSource = teditCampus;
                editCampus.DataTextField = "Description";
                editCampus.DataValueField = "No";
                editCampus.DataBind();
            }
        }
        protected void deleteFire_Click(object sender, EventArgs e)
        {
            try
            {
                string tremoveFireCode = removeFireCode.Text.Trim();
                int mFireCode = Convert.ToInt32(tremoveFireCode);
                string status = new Config().ObjNav()
                          .DeleteFire(mFireCode, Session["Code"].ToString(), Session["Password"].ToString());
                string[] info = status.Split('*');
                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
                   
        }
        protected void deleteElevetedWater_Click(object sender, EventArgs e)
        {
         try
            {
                int televetedwatercode = Convert.ToInt32(elevetedwatercode.Text.Trim());
                string status = new Config().ObjNav()
                          .DeleteEelevatedWater(televetedwatercode, Session["Code"].ToString(), Session["Password"].ToString());
                string[] info = status.Split('*');
                elevetedwaterfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            catch (Exception m)
            {
                elevetedwaterfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }


        }
        public void addFire_Click(object sender, EventArgs e)
        {
            string tCampus = string.IsNullOrEmpty(campus.SelectedValue) ? "" : campus.SelectedValue;

            string tfireClass = string.IsNullOrEmpty(fireClass.SelectedValue) ? "" : fireClass.SelectedValue;
            string tblock = string.IsNullOrEmpty(block.Text) ? "" : block.Text;
            string tnoOfDevices = string.IsNullOrEmpty(noOfDevices.Text) ? "" : noOfDevices.Text;
            DateTime Inspection = new DateTime();
            Inspection = DateTime.ParseExact(lastInspection.Text.Trim(), "d/M/yyyy", CultureInfo.InvariantCulture);
            string message = "";
            bool error = false;
            bool tbiodata = false;
            if (biodata.Checked)
            {
                tbiodata = true;
            }
            bool tbiometricregistrations = false;
            if (biometricregistrations.Checked)
            {
                tbiometricregistrations = true;
            }
            bool tfunctionalrecords = false;
            if (functionalrecords.Checked)
            {
                tfunctionalrecords = true;
            }
            int devices = 0;
            try
            {
                devices = Convert.ToInt32(tnoOfDevices);
            }
            catch (Exception)
            {
                devices = 0;
            }
            try
            {
                if (tCampus.Length < 1)
                {
                    error = true;
                    message = "Please select the campus";
                }
                if (tnoOfDevices.Length < 1)
                {
                    error = true;
                    message = "Please enter the No. of devices";
                }
                if (error)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    string status = new Config().ObjNav()
                        .AddFire(tCampus, tfireClass, tblock, devices, Inspection, Session["Code"].ToString(), Session["Password"].ToString());
                    string[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    if (info[0] == "success")
                    {
                        string filesFolder = ConfigurationManager.AppSettings["FilesLocation"];
                        string myName = "";
                        string filelocations = filesFolder + "Customer Card" + "/";
                        String universityNo = Convert.ToString(Session["UniversityCode"]);
                        universityNo = universityNo.Replace('/', '_');
                        universityNo = universityNo.Replace(':', '_');
                        String documentDirectory = filelocations + universityNo + "/";
                        if (fireCompliance.HasFile)
                        {
                            try
                            {
                                if (Directory.Exists(filelocations))
                                {
                                    string tfireCompliance = System.IO.Path.GetExtension(fireCompliance.FileName);
                                    string titleExtension = System.IO.Path.GetExtension(fireCompliance.FileName);
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

                                            string fireComplianceFile = Session["UniversityCode"] + "_FireCompliance_" + fireCompliance.FileName;
                                            fireComplianceFile = fireComplianceFile.Replace(':', '_');
                                            fireComplianceFile = documentDirectory + fireComplianceFile;
                                            myName = fireComplianceFile;
                                            fireCompliance.SaveAs(fireComplianceFile);
                                            if (File.Exists(fireComplianceFile))
                                            {
                                                feedback.InnerHtml =
                                                    "<div class='alert alert-success'>The University Fire Fighting Details was Successfully Submitted . <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                            }
                                            else
                                            {
                                                feedback.InnerHtml =
                                                    "<div class='alert alert-danger'>The fire compliance certificate could not be uploaded. " + myName + " Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
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
                            feedback.InnerHtml = "<div class='alert alert-danger'>Please select the Fire Compliance Certificate to upload.  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                        }
                    }
                }


            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }


        }
        protected void EditSafety(object sender, EventArgs e)
        {
            try
            {
                string universityCode = Convert.ToString(Session["UniversityCode"]);
                string teditCampus = editCampus.SelectedValue;
                string teditclass = editclass.SelectedValue;
                string teditlocation = editlocation.Text.Trim();
                int tnoofdevices = Convert.ToInt32(devices.Text.Trim());
                DateTime mtdateofinspection = new DateTime();
                mtdateofinspection = DateTime.ParseExact(dateofinspection.Text.Trim(), "d/M/yyyy", CultureInfo.InvariantCulture);
                string userCode = Convert.ToString(Session["Code"]);
                string password = Convert.ToString(Session["Password"]);
                string status = new Config().ObjNav()
                    .EditFire(universityCode, teditCampus, teditclass, teditlocation, mtdateofinspection, tnoofdevices, userCode, password);
                string[] info = status.Split('*');
                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                if (info[0] == "success")
                {
                    string filesFolder = ConfigurationManager.AppSettings["FilesLocation"];
                    string myName = "";
                    if (editfilecompliance.HasFile)
                    {
                        try
                        {
                            if (Directory.Exists(filesFolder))
                            {
                                string tfireCompliance = System.IO.Path.GetExtension(editfilecompliance.FileName);
                                string titleExtension = System.IO.Path.GetExtension(editfilecompliance.FileName);
                                if (new Config().IsAllowedExtension(titleExtension))
                                {

                                    string fireComplianceFile = Session["UniversityCode"] + "_" + editfilecompliance.FileName;
                                    fireComplianceFile = fireComplianceFile.Replace(':', '_');
                                    fireComplianceFile = filesFolder + fireComplianceFile;
                                    myName = fireComplianceFile;
                                    fireCompliance.SaveAs(fireComplianceFile);
                                    if (File.Exists(fireComplianceFile))
                                    {
                                        feedback.InnerHtml =
                                            "<div class='alert alert-success'>The University Fire Fighting Details was Successfully Updated . <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                    }
                                    else
                                    {
                                        feedback.InnerHtml =
                                            "<div class='alert alert-danger'>The Fire Compliance Certificate could not be uploaded. " + myName + " Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
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
                        feedback.InnerHtml = "<div class='alert alert-danger'>Please select the Fire Compliance Certificate to upload.  <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                    }
                }
            }

            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }


        }
        protected void addElevetedWaterDetails_Click(object sender, EventArgs e)
        {
            string universityCode = Convert.ToString(Session["UniversityCode"]);
            string televatedCampus = elevatedCampus.SelectedValue;
            decimal televatedvolume = Convert.ToDecimal(elevatedvolume.Text.Trim());
            string userCode = Convert.ToString(Session["Code"]);
            string password = Convert.ToString(Session["Password"]);
            string status = new Config().ObjNav()
                .AddEelevatedWater(televatedCampus, televatedvolume, userCode, password);
            string[] info = status.Split('*');
            elevetedwaterfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            if (info[0] == "success")
            {
                elevetedwaterfeedback.InnerHtml = "<div class='alert alert-success'>The Volume of Elevated water for Fire fighting was successfully Submitted</div>";
            }
            else
            {
                elevetedwaterfeedback.InnerHtml = "<div class='alert alert-danger'>TThe Volume of Elevated water for Fire fighting  could not be Submitted</div>";
            }
        }
        protected void updateElevetedWater_Click(object sender, EventArgs e)
        {
            string universityCode = Convert.ToString(Session["UniversityCode"]);
            int teditelevetedwatercode = Convert.ToInt32(editelevetedwatercode.Text.Trim());
            string teditCampus = editelevetedwatercampus.SelectedValue;
            decimal teditelevetedwater =Convert.ToDecimal(editelevetedwater.Text.Trim());
            string userCode = Convert.ToString(Session["Code"]);
            string password = Convert.ToString(Session["Password"]);
            string status = new Config().ObjNav()
                .EditEelevatedWater(teditCampus, teditelevetedwatercode, teditelevetedwater, userCode, password);
            string[] info = status.Split('*');
            elevetedwaterfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            if (info[0] == "success")
            {
                elevetedwaterfeedback.InnerHtml = "<div class='alert alert-success'>The Volume of Elevated water for Fire fighting was successfully Updated</div>";
            }
            else
            {
                elevetedwaterfeedback.InnerHtml = "<div class='alert alert-danger'>The Volume of Elevated water for Fire fighting  could not be updated</div>";
            }
        }
    }

}
