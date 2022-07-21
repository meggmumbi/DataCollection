using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
namespace CicPortal
{
    public partial class ProgramQA : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                var nav = Config.ReturnNav();
               // string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();

                if (!IsPostBack)
                {
                    var stakeholderslists = nav.stakeholders;
                    stakeholderslist.DataSource = stakeholderslists;
                    stakeholderslist.DataValueField = "Code";
                    stakeholderslist.DataTextField = "Description";
                    stakeholderslist.DataBind();

                    List<string> yearofstudys = new List<string>();
                    yearofstudys.Add("-------Select Year of Study-------");
                    yearofstudys.Add("Year 1");
                    yearofstudys.Add("Year 2");
                    yearofstudys.Add("Year 3");
                    yearofstudys.Add("Year 4");
                    yearofstudys.Add("Year 5");
                    yearofstudys.Add("Year 6");
                    yearofstudys.Add("Year 7");
                    yearofstudys.Add("Year 8");
                    yearofstudys.Add("Year 9");
                    yearofstudy.DataSource = yearofstudys;
                    yearofstudy.DataBind();


                    List<string> highestacademiclevels = new List<string>();
                    highestacademiclevels.Add("PHD");
                    highestacademiclevels.Add("Bachelors");
                    highestacademiclevels.Add("Masters");
                    highestacademiclevels.Add("Doctorate");
                    highestacademiclevels.Add("Postgraduate Diploma");
                    highestacademiclevels.Add("Diploma");
                    highestacademiclevels.Add("Certificate");
                    highestacademiclevel.DataSource = highestacademiclevels;
                    highestacademiclevel.DataBind();

                    List<string> termsofemployments = new List<string>();
                    termsofemployments.Add("Full-Time");
                    termsofemployments.Add("Part-Time");
                    termsofemployment.DataSource = termsofemployments;
                    termsofemployment.DataBind();

                    List<string> itemsusages= new List<string>();
                    itemsusages.Add("Specific to Department");
                    itemsusages.Add("Shared");
                    itemsusage.DataSource = itemsusages;
                    itemsusage.DataBind();

                    List<string> researchmethodyears = new List<string>();
                    researchmethodyears.Add("-------Select Year of Study-------");
                    researchmethodyears.Add("Year 1");
                    researchmethodyears.Add("Year 2");
                    researchmethodyears.Add("Year 3");
                    researchmethodyears.Add("Year 4");
                    researchmethodyears.Add("Year 5");
                    researchmethodyears.Add("Year 6");
                    researchmethodyears.Add("Year 7");
                    researchmethodyears.Add("Year 8");
                    researchmethodyears.Add("Year 9");
                    researchmethodyear.DataSource = researchmethodyears;
                    researchmethodyear.DataBind();

                    List<string> semesters = new List<string>();
                    semesters.Add("-------Select Semester-------");
                    semesters.Add("Semester 1");
                    semesters.Add("Semester 2");
                    semesters.Add("Semester 3");
                    semesters.Add("Semester 4");
                    semester.DataSource = semesters;
                    semester.DataBind();

                    List<string> reasearchmethodsemesters = new List<string>();
                    reasearchmethodsemesters.Add("-------Select Semester-------");
                    reasearchmethodsemesters.Add("Semester 1");
                    reasearchmethodsemesters.Add("Semester 2");
                    reasearchmethodsemesters.Add("Semester 3");
                    reasearchmethodsemesters.Add("Semester 4");
                    reasearchmethodsemester.DataSource = reasearchmethodsemesters;
                    reasearchmethodsemester.DataBind();

                    List<string> basicintermediates = new List<string>();
                    basicintermediates.Add("-------Select Course Types-------");
                    basicintermediates.Add("Common");
                    basicintermediates.Add("Core");
                    basicintermediates.Add("Specialization");
                    basicintermediates.Add("Electives");
                    basicintermediate.DataSource = basicintermediates;
                    basicintermediate.DataBind();

                    var courses = nav.Programs.Where(r => r.Institution_Code == Convert.ToString(Session["UniversityCode"]));
                    coursescode.DataSource = courses;
                    coursescode.DataValueField = "Code";
                    coursescode.DataTextField = "Description";
                    coursescode.DataBind();

                    var domains = nav.programdomains;
                    academicProgrammeDomain.DataSource = domains;
                    academicProgrammeDomain.DataValueField = "Code";
                    academicProgrammeDomain.DataTextField = "Description";
                    academicProgrammeDomain.DataBind();


                    editprogrammedomain.DataSource = domains;
                    editprogrammedomain.DataValueField = "Code";
                    editprogrammedomain.DataTextField = "Description";
                    editprogrammedomain.DataBind();
                    
                }
                try
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    if (string.IsNullOrEmpty(qaNo))
                    {
                        throw new Exception();
                    }
                    else
                    {
                        var step = Request.QueryString["step"];
                        int currentStep = 0;
                        int maxStep = 19;
                        try
                        {
                            currentStep = Convert.ToInt32(step);
                        }
                        catch (Exception)
                        {
                            currentStep = 1;
                        }
                        if (currentStep < 1)
                        {
                            currentStep = 1;
                        }
                        if (currentStep == 2)
                        {
                            var stakeHolders = nav.stakeholders;
                            foreach (var stakeHolder in stakeHolders)
                            {
                                HtmlTableRow row = new HtmlTableRow();
                                HtmlTableCell cell = new HtmlTableCell();
                                cell.InnerText = stakeHolder.Description;
                                row.Cells.Add(cell);

                                HtmlTableCell isStakeHolder = new HtmlTableCell();
                                CheckBox isStakeHolderCheck = new CheckBox();
                                isStakeHolderCheck.ID = "isstakeholder" + stakeHolder.Code;
                                isStakeHolder.Controls.Add(isStakeHolderCheck);
                                row.Cells.Add(isStakeHolder);

                                HtmlTableCell isEngaged = new HtmlTableCell();
                                CheckBox isEngagedCheck = new CheckBox();
                                isEngagedCheck.ID = "isengaged" + stakeHolder.Code;
                                isEngaged.Controls.Add(isEngagedCheck);
                                row.Cells.Add(isEngaged);

                                HtmlTableCell isAnalyzed = new HtmlTableCell();
                                CheckBox isAnalyzedCheck = new CheckBox();
                                isAnalyzedCheck.ID = "isanalyzed" + stakeHolder.Code;
                                isAnalyzed.Controls.Add(isAnalyzedCheck);
                                row.Cells.Add(isAnalyzed);
                                knownStakeHolders.Rows.Add(row);
                            }
                            //var editstakeHolders = nav.stakeholders;
                            //foreach (var editstakeHolder in editstakeHolders)
                            //{
                            //    HtmlTableRow row = new HtmlTableRow();
                            //    HtmlTableCell cell = new HtmlTableCell();
                            //    cell.InnerText = editstakeHolder.Description;
                            //    row.Cells.Add(cell);

                            //    HtmlTableCell isStakeHolder = new HtmlTableCell();
                            //    CheckBox isStakeHolderCheck = new CheckBox();
                            //    isStakeHolderCheck.ID = "isstakeholder1" + editstakeHolder.Code;
                            //    isStakeHolder.Controls.Add(isStakeHolderCheck);
                            //    row.Cells.Add(isStakeHolder);

                            //    HtmlTableCell isEngaged = new HtmlTableCell();
                            //    CheckBox isEngagedCheck = new CheckBox();
                            //    isEngagedCheck.ID = "isengaged1" + editstakeHolder.Code;
                            //    isEngaged.Controls.Add(isEngagedCheck);
                            //    row.Cells.Add(isEngaged);

                            //    HtmlTableCell isAnalyzed = new HtmlTableCell();
                            //    CheckBox isAnalyzedCheck = new CheckBox();
                            //    isAnalyzedCheck.ID = "isanalyzed1" + editstakeHolder.Code;
                            //    isAnalyzed.Controls.Add(isAnalyzedCheck);
                            //    row.Cells.Add(isAnalyzed);
                            //    editknownstakeholders.Rows.Add(row);
                            //}
                        }

                    }
                }
                catch (Exception k)
                {

                }
            }
            catch (Exception)
            {
                Response.Redirect("ProgramQA.aspx");
            }

        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string InsertStudentsProfile(List<StudentProfile> profile)
        {
            var QualityAuditNo = HttpContext.Current.Session["QualityAuditNos"].ToString();
            var results = (dynamic)null;
            try
            {
                //bool categories = Convert.ToBoolean(category);
                //Check for NULL.
                if (profile == null)
                {
                    profile = new List<StudentProfile>();
                }
                //Loop and insert records.
                foreach (StudentProfile profiles in profile)
                {
                    string tacademicyears = profiles.academicyear;
                    string tgovernmentmale = profiles.governmentmale;
                    string tgovernmentfemale = profiles.governmentfemale;
                    string tselffemale = profiles.selffemale;
                    string tselfmale = profiles.selfmale;
                    string tkenyanstudents = profiles.kenyanstudents;
                    string tinternationalstudents = profiles.internationalstudents;
                    var userCode = HttpContext.Current.Session["Code"].ToString();
                    var password = HttpContext.Current.Session["Password"].ToString();
                    var status = new Config().ObjNav()
                          .AddStudentProfileDetails(QualityAuditNo, tacademicyears, tgovernmentmale, tgovernmentfemale, tselfmale, tselffemale, tkenyanstudents, tinternationalstudents, userCode, password);
                    string[] info = status.Split('*');
                    results = info[0];
                }

            }
            catch (Exception ex)
            {
                results = ex.Message;
            }
            return results;
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string InsertDidacticAidsTools(List<DidacticAids> didactic)
        {
            var universityCode = HttpContext.Current.Session["UniversityCode"].ToString();
            var QualityAuditNo = HttpContext.Current.Session["QualityAuditNos"].ToString();

            var results = (dynamic)null;
            try
            {
                //bool categories = Convert.ToBoolean(category);
                //Check for NULL.
                if (didactic == null)
                {
                    didactic = new List<DidacticAids>();
                }
                //Loop and insert records.
                foreach (DidacticAids didactics in didactic)
                {
                    string tdidacticaids = didactics.didactictools;
                    string ttotalnumber = didactics.totalnumber;
                    string tspecifictoDepartment = didactics.specifictoDepartment;
                    string tusageshared = didactics.usageshared;
                    var userCode = HttpContext.Current.Session["Code"].ToString();
                    var password = HttpContext.Current.Session["Password"].ToString();
                    var status = new Config().ObjNav().AddDidacticAidsTools(QualityAuditNo, tdidacticaids, ttotalnumber, tspecifictoDepartment, tusageshared, userCode, password);
                    string[] info = status.Split('*');
                    results = info[0];
                }

            }
            catch (Exception ex)
            {
                results = ex.Message;
            }
            return results;
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string InsertFulltimeAcademicStaffSize(List<FullTimeStaffs> fulltime)
        {
            var universityCode = HttpContext.Current.Session["UniversityCode"].ToString();
            var results = (dynamic)null;
            try
            {
                //bool categories = Convert.ToBoolean(category);
                //Check for NULL.
                if (fulltime == null)
                {
                    fulltime = new List<FullTimeStaffs>();
                }
                //Loop and insert records.
                foreach (FullTimeStaffs fulltimes in fulltime)
                {
                    string tdesignation = fulltimes.designation;
                    string tdesignationmalebelow30 = fulltimes.designationmalebelow30;
                    string tdesignationfemalebelow30 = fulltimes.designationfemalebelow30;
                    string tdesignationintersexbelow30 = fulltimes.designationintersexbelow30;
                    string tdesignationmalebetween3139 = fulltimes.designationmalebetween3139;
                    string tdesignationfemalebetween3139 = fulltimes.designationfemalebetween3139;
                    string tdesignationintersexbetween3139 = fulltimes.designationintersexbetween3139;
                    string tdesignationmalebetween4049 = fulltimes.designationmalebetween4049;
                    string tdesignationfemalebetween4049 = fulltimes.designationfemalebetween4049;
                    string tdesignationintersexbetween4049 = fulltimes.designationintersexbetween4049;
                    string tdesignationmalebetween5059 = fulltimes.designationmalebetween5059;
                    string tdesignationfemalebetween5059 = fulltimes.designationfemalebetween5059;
                    string tdesignationintersexbetween5059 = fulltimes.designationintersexbetween5059;
                    string tdesignationmaleabove60 = fulltimes.designationmaleabove60;
                    string tdesignationfemaleabove60 = fulltimes.designationfemaleabove60;
                    string tdesignationintersexabove60 = fulltimes.designationintersexabove60;
                    var userCode = HttpContext.Current.Session["Code"].ToString();
                    var password = HttpContext.Current.Session["Password"].ToString();
                    var status = new Config().ObjNav()
                          .AddFullTimeAcademicStaffSize(universityCode, tdesignation, tdesignationmalebelow30, tdesignationfemalebelow30, tdesignationintersexbelow30,
                          tdesignationfemalebetween3139, tdesignationmalebetween3139, tdesignationintersexbetween3139, tdesignationmalebetween4049, tdesignationfemalebetween4049,
                         tdesignationintersexbetween4049, tdesignationfemalebetween5059, tdesignationmalebetween5059, tdesignationintersexbetween5059, tdesignationmaleabove60,
                        tdesignationfemaleabove60, tdesignationintersexabove60, userCode, password);
                    string[] info = status.Split('*');
                    results = info[0];
                }

            }
            catch (Exception ex)
            {
                results = ex.Message;
            }
            return results;
        }
        protected void next_Click(object sender, EventArgs e)
        {
            int step = 0;
            string QualityAuditNo = "";
            try
            {
                step = Convert.ToInt32(Request.QueryString["step"].Trim());
                QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                Session["QualityAuditNos"] = QualityAuditNo;
            }
            catch (Exception)
            {
                step = 0;
                QualityAuditNo = "";
            }
            step += 1;
            Response.Redirect("ProgramQA.aspx?QualityAuditNo=" + QualityAuditNo + "&step=" + step);

        }

        protected void previous_Click(object sender, EventArgs e)
        {
            int step = 0;
            string QualityAuditNo = "";
            try
            {
                step = Convert.ToInt32(Request.QueryString["step"].Trim());
                QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                Session["QualityAuditNos"] = QualityAuditNo;
            }
            catch (Exception)
            {
                step = 0;
                QualityAuditNo = "";
            }
            step -= 1;
            Response.Redirect("ProgramQA.aspx?QualityAuditNo=" + QualityAuditNo + "&step=" + step);
        }
        protected void FirstStep_Click(object sender, EventArgs e)
        {
            try
            {
                //string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .ValidateProgrammeBasicInformation(userCode, password);
                if (status == "success")
                {
                    try
                    {
                        string university = Convert.ToString(Session["UniversityCode"]);
                        string QualityAuditNo = new Config().ObjNav().GetQualityAuditNumber(university);
                        Session["QualityAuditNos"] = QualityAuditNo;
                        if (QualityAuditNo != "")
                        {
                            Response.Redirect("ProgramQA.aspx?QualityAuditNo=" + QualityAuditNo + "&step=2");
                        }
                        else
                        {
                            basicinformations.InnerHtml = "<div class='alert alert-danger'>" + "There is no Open Quality Audit Application Entry.Kindly Submit Quality Audit Basic Information Details to Initiate New Programme Quality Audit  Application" + "</div>";
                        }

                    }
                    catch (Exception y)
                    {
                        basicinformations.InnerHtml = "<div class='alert alert-danger'>" + "There is no Open Quality Audit Application Entry.Kindly Submit Quality Audit Basic Information Details to Initiate New Programme Quality Audit  Application" + "</div>";
                    }
                }
                else
                {
                    basicinformations.InnerHtml = "<div class='alert alert-danger'>" + "There is no Open Accreditation Application Entry.Kindly Submit Accreditation General Details to Initiate New Programme Accreditation Application" + "</div>";
                }
            }
            catch (Exception y)
            {
                basicinformations.InnerHtml = "<div class='alert alert-danger'>" + y.Message + "</div>";
            }

        }

        protected void addBackgoundInformation_Click(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string tnameofprogramme = "";
                string tacademicProgrammeDomain = "";
                string taccreditationDate = "";
                bool trequiresApproval = false;
                bool tapprovedByProfessionalBody = false;
                bool tapprovedByProfessionalEvidence = false;
                string tprofessionalBodyApprovalDate = "";
                string tprofessionalBody = "";
                string tuniversityniche = "";
                string QualityAuditNo = "";
                try
                {
                    QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                    if (string.IsNullOrEmpty(QualityAuditNo))
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    QualityAuditNo = "";
                }
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
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid Brief description of the niche of the university";
                }
                try
                {
                    tnameofprogramme = nameofprogramme.Text.Trim();
                    if (tnameofprogramme.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {

                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid  Name of the Programme";
                }
                try
                {
                    tacademicProgrammeDomain = academicProgrammeDomain.Text.Trim();
                    if (tacademicProgrammeDomain.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {

                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please select the Academic Programme Domain";
                }
                try
                {
                    if (requiresApproval.Checked == true)
                    {
                        trequiresApproval = true;
                    }
                    else
                    {
                        trequiresApproval = false;
                    }
                }
                catch (Exception)
                {

                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please check if Academic Programme require approval by a relevant professional body";
                }
                try
                {
                    if (approvedByProfessionalBody.Checked == true)
                    {
                        tapprovedByProfessionalBody = true;
                    }
                    else
                    {
                        tapprovedByProfessionalBody = false;
                    }
                }
                catch (Exception)
                {

                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please check if Academic Programme require approval by a relevant professional body";
                }
                //try
                //{
                //    taccreditationDate = accreditationDate.Text.Trim();
                //    if (taccreditationDate.Length < 1)
                //    {
                //        throw new Exception();
                //    }
                //}
                //catch (Exception)
                //{

                //    error = true;
                //    message += message.Length > 0 ? "<br" : "";
                //    message += "Please enter the Date of Accreditation/Approval";
                //}
                try
                {
                    tprofessionalBodyApprovalDate = professionalBodyApprovalDate.Text.Trim();
                    if (tprofessionalBodyApprovalDate.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {

                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter the Date of approval by the relevant professional body";
                }
                try
                {
                    tprofessionalBody = professionalBody.Text.Trim();
                    if (tprofessionalBody.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {

                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please Indicate the name of the Professional body";
                }
                if (error)
                {
                    basicinformations.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
                    string status = new Config().ObjNav()
                        .AddBasicInformation(QualityAuditNo, tnameofprogramme, tacademicProgrammeDomain, taccreditationDate, trequiresApproval, tapprovedByProfessionalEvidence, tapprovedByProfessionalBody, tprofessionalBody, tprofessionalBodyApprovalDate, tuniversityniche, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    basicinformations.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        basicinformations.InnerHtml = Config.GetAlert(info[0], info[1]);

                    }
                }
            }
            catch (Exception y)
            {
                basicinformations.InnerHtml = "<div class='alert alert-danger'>" + y.Message + "</div>";
            }
        }
        protected void UpdateBasicInformations_Click(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string tnameofprogramme = "";
                string tacademicProgrammeDomain = "";
                string taccreditationDate = "";
                bool trequiresApproval = false;
                bool tapprovedByProfessionalBody = false;
                bool tapprovedByProfessionalEvidence = false;
                string tprofessionalBodyApprovalDate = "";
                string tprofessionalBody = "";
                string tuniversityniche = "";
                string QualityAuditNo = qualityauditnumber.Text.Trim();
                //try
                //{
                //    QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                //    if (string.IsNullOrEmpty(QualityAuditNo))
                //    {
                //        throw new Exception();
                //    }
                //}
                //catch (Exception)
                //{
                //    QualityAuditNo = "";
                //}
                try
                {
                    tuniversityniche = edituniversityniche.Text.Trim();
                    if (tuniversityniche.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {

                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid Brief description of the niche of the university";
                }
                try
                {
                    tnameofprogramme = editNameofAcademicProgramme.Text.Trim();
                    if (tnameofprogramme.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {

                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid  Name of the Programme";
                }
                try
                {
                    tacademicProgrammeDomain = editprogrammedomain.Text.Trim();
                    if (tacademicProgrammeDomain.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {

                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please select the Academic Programme Domain";
                }
                try
                {
                    if (editrequireapprovals.Checked == true)
                    {
                        trequiresApproval = true;
                    }
                    else
                    {
                        trequiresApproval = false;
                    }
                }
                catch (Exception)
                {

                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please check if Academic Programme require approval by a relevant professional body";
                }
                try
                {
                    if (editapprovedbyprofessionalbody.Checked == true)
                    {
                        tapprovedByProfessionalBody = true;
                    }
                    else
                    {
                        tapprovedByProfessionalBody = false;
                    }
                }
                catch (Exception)
                {

                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please check if Academic Programme require approval by a relevant professional body";
                }
                //try
                //{
                //    taccreditationDate = accreditationDate.Text.Trim();
                //    if (taccreditationDate.Length < 1)
                //    {
                //        throw new Exception();
                //    }
                //}
                //catch (Exception)
                //{

                //    error = true;
                //    message += message.Length > 0 ? "<br" : "";
                //    message += "Please enter the Date of Accreditation/Approval";
                //}
                try
                {
                    tprofessionalBodyApprovalDate = editdateprofessionalbodyapproval.Text.Trim();
                    if (tprofessionalBodyApprovalDate.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {

                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter the Date of approval by the relevant professional body";
                }
                try
                {
                    tprofessionalBody = editprofessionalbosyname.Text.Trim();
                    if (tprofessionalBody.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {

                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please Indicate the name of the Professional body";
                }
                if (error)
                {
                    basicinformations.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
                    string status = new Config().ObjNav()
                        .EditBasicInformation(QualityAuditNo, tnameofprogramme, tacademicProgrammeDomain, taccreditationDate, trequiresApproval, tapprovedByProfessionalEvidence, tapprovedByProfessionalBody, tprofessionalBody, tprofessionalBodyApprovalDate, tuniversityniche, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    basicinformations.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        basicinformations.InnerHtml = Config.GetAlert(info[0], info[1]);

                    }
                }
            }
            catch (Exception y)
            {
                basicinformations.InnerHtml = "<div class='alert alert-danger'>" + y.Message + "</div>";
            }
        }
        protected void deleteprogramdidacticstrenths_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeleteprogramdidacticstrenthsCode = Convert.ToInt32(deleteprogramdidacticstrenthsCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteProgrammeDidecticStrengths(QualityAuditNo, tdeleteprogramdidacticstrenthsCode, userCode, password);
                string[] info = status.Split('*');
                didacticfeedbackstrenght.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deleteprogramdidacticstrenthsCode.Text = "";
                }
            }
            catch (Exception y)
            {
                didacticfeedbackstrenght.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deletestudentsevaluations_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeleteprogramdidacticstrenthsCode = Convert.ToInt32(deleteprogramdidacticstrenthsCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteProgrammeDidecticStrengths(QualityAuditNo, tdeleteprogramdidacticstrenthsCode, userCode, password);
                string[] info = status.Split('*');
                didacticfeedbackstrenght.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deleteprogramdidacticstrenthsCode.Text = "";
                }
            }
            catch (Exception y)
            {
                didacticfeedbackstrenght.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deletestudentsevaluationsstrength_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeletestudentsevaluationsstrengthCode = Convert.ToInt32(deletestudentsevaluationsstrengthCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteStudentsEvaluationsStrengths(QualityAuditNo, tdeletestudentsevaluationsstrengthCode, userCode, password);
                string[] info = status.Split('*');
                studentevaluationstrengthsfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deletestudentsevaluationsstrengthCode.Text = "";
                }
            }
            catch (Exception y)
            {
                studentevaluationstrengthsfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deletestudentsevaluationsweaknesses_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeletestudentsevaluationsweaknessesCode = Convert.ToInt32(deletestudentsevaluationsweaknessesCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteStudentsEvaluationsWeakness(QualityAuditNo, tdeletestudentsevaluationsweaknessesCode, userCode, password);
                string[] info = status.Split('*');
                studentsevaluationweaknessfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deletestudentsevaluationsweaknessesCode.Text = "";
                }
            }
            catch (Exception y)
            {
                studentsevaluationweaknessfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deletecurriculumndesignweaknessinfo_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeletecurriculumndesignweaknessinfoCode = Convert.ToInt32(deletecurriculumndesignweaknessinfoCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteCurriculumnDesignWeakness(QualityAuditNo, tdeletecurriculumndesignweaknessinfoCode, userCode, password);
                string[] info = status.Split('*');
                curriculumndesignweaknessfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deletestudentsevaluationsweaknessesCode.Text = "";
                }
            }
            catch (Exception y)
            {
                curriculumndesignweaknessfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deletecurriculumndesignstrengthsinfo_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeletecurriculumndesignstrengthsinfoCode = Convert.ToInt32(deletecurriculumndesignstrengthsinfoCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteCurriculumnDesignStrengths(QualityAuditNo, tdeletecurriculumndesignstrengthsinfoCode, userCode, password);
                string[] info = status.Split('*');
                curriculumndesignstrengthsfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deletecurriculumndesignstrengthsinfoCode.Text = "";
                }
            }
            catch (Exception y)
            {
                curriculumndesignstrengthsfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deleteBenchmarkingweaknessinfo_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeleteBenchmarkingweaknessinfoCode = Convert.ToInt32(deleteBenchmarkingweaknessinfoCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteBenchmarkingWeakness(QualityAuditNo, tdeleteBenchmarkingweaknessinfoCode, userCode, password);
                string[] info = status.Split('*');
                benchmarkingweaknessfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deleteBenchmarkingweaknessinfoCode.Text = "";
                }
            }
            catch (Exception y)
            {
                benchmarkingweaknessfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deleteBenchmarkingstrenghtsinfo_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeleteBenchmarkingstrenghtsinfoCode = Convert.ToInt32(deleteBenchmarkingstrenghtsinfoCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteBenchmarkingStrengths(QualityAuditNo, tdeleteBenchmarkingstrenghtsinfoCode, userCode, password);
                string[] info = status.Split('*');
                benchmarkingstrengthsfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deleteBenchmarkingstrenghtsinfoCode.Text = "";
                }
            }
            catch (Exception y)
            {
                benchmarkingstrengthsfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deletegraduateweaknesssinfo_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeletegraduateweaknesssinfoCode = Convert.ToInt32(deletegraduateweaknesssinfoCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteGraduatesWeakness(QualityAuditNo, tdeletegraduateweaknesssinfoCode, userCode, password);
                string[] info = status.Split('*');
                graduatesweaknessfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deletegraduateweaknesssinfoCode.Text = "";
                }
            }
            catch (Exception y)
            {
                graduatesweaknessfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deletesatisfactionsstrengthsinfo_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeletesatisfactionsstrengthsinfoCode = Convert.ToInt32(deletesatisfactionsstrengthsinfoCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteStakeholdersSatisfactionStrengths(QualityAuditNo, tdeletesatisfactionsstrengthsinfoCode, userCode, password);
                string[] info = status.Split('*');
                satisfactionsstrengthsfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deletesatisfactionsstrengthsinfoCode.Text = "";
                }
            }
            catch (Exception y)
            {
                satisfactionsstrengthsfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deletesatisfactionsweaknessesinfo_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeletesatisfactionsweaknessesinfoCode = Convert.ToInt32(deletesatisfactionsweaknessesinfoCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteStakeholdersSatisfactionWeakness(QualityAuditNo, tdeletesatisfactionsweaknessesinfoCode, userCode, password);
                string[] info = status.Split('*');
                satisfactionsweaknessfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deletesatisfactionsweaknessesinfoCode.Text = "";
                }
            }
            catch (Exception y)
            {
                satisfactionsweaknessfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deletegraduatestrenghtsinfo_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeletegraduatestrenghtsinfoCode = Convert.ToInt32(deletegraduatestrenghtsinfoCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteGraduatesStrengths(QualityAuditNo, tdeletegraduatestrenghtsinfoCode, userCode, password);
                string[] info = status.Split('*');
                graduatesstrengthsfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deletegraduatestrenghtsinfoCode.Text = "";
                }
            }
            catch (Exception y)
            {
                graduatesstrengthsfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deletestudentsdevelopmentweaknessinfo_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeletestudentsdevelopmentweaknessinfoCode = Convert.ToInt32(deletestudentsdevelopmentweaknessinfoCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteStudentDevelopmentActivitiesWeakness(QualityAuditNo, tdeletestudentsdevelopmentweaknessinfoCode, userCode, password);
                string[] info = status.Split('*');
                studentsdevelopmentweaknessfeeback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deletestudentsdevelopmentweaknessinfoCode.Text = "";
                }
            }
            catch (Exception y)
            {
                studentsdevelopmentweaknessfeeback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deletestudentsdevelopmentstrengthinfo_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeletestudentsdevelopmentstrengthinfoCode = Convert.ToInt32(deletestudentsdevelopmentstrengthinfoCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteStudentDevelopmentActivitiesStrengths(QualityAuditNo, tdeletestudentsdevelopmentstrengthinfoCode, userCode, password);
                string[] info = status.Split('*');
                studentdevelopmentstrengthfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deletestudentsdevelopmentstrengthinfoCode.Text = "";
                }
            }
            catch (Exception y)
            {
                studentdevelopmentstrengthfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deletefacilitiesweaknesses_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeletefacilitiesweaknessesCode = Convert.ToInt32(deletefacilitiesweaknessesCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteFacilitiesStWeakness(QualityAuditNo, tdeletefacilitiesweaknessesCode, userCode, password);
                string[] info = status.Split('*');
                facilitiesweaknessfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deleteprogramdidacticstrenthsCode.Text = "";
                }
            }
            catch (Exception y)
            {
                facilitiesweaknessfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deletefacilitiesstrengths_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeletefacilitiesstrengthsCode = Convert.ToInt32(deletefacilitiesstrengthsCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteFacilitiesStrengths(QualityAuditNo, tdeletefacilitiesstrengthsCode, userCode, password);
                string[] info = status.Split('*');
                facilitiesstrengthfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deleteprogramdidacticstrenthsCode.Text = "";
                }
            }
            catch (Exception y)
            {
                facilitiesstrengthfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deletestudentssupportweaknes_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeletestudentssupportweaknesCode = Convert.ToInt32(deletestudentssupportweaknesCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .Deletestudentsupportweakness(QualityAuditNo, tdeletestudentssupportweaknesCode, userCode, password);
                string[] info = status.Split('*');
                studentsupportweaknessfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deletestudentssupportweaknesCode.Text = "";
                }
            }
            catch (Exception y)
            {
                studentsupportweaknessfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deletestudentsupportstrenght_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeletestudentsupportstrenghtCode = Convert.ToInt32(deletestudentsupportstrenghtCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .Deletestudentsupportstrengths(QualityAuditNo, tdeletestudentsupportstrenghtCode, userCode, password);
                string[] info = status.Split('*');
                studentssupportstrengthfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deleteprogramdidacticstrenthsCode.Text = "";
                }
            }
            catch (Exception y)
            {
                studentssupportstrengthfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deleteteachingsmaterial_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeleteteachingsmaterialCode = Convert.ToInt32(deleteteachingsmaterialCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteTeachingMaterials(QualityAuditNo, tdeleteteachingsmaterialCode, userCode, password);
                string[] info = status.Split('*');
                feedbackequipment.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deleteteachingsmaterialCode.Text = "";
                }
            }
            catch (Exception y)
            {
                feedbackequipment.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deleteStudentsprofileweakness_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeleteStudentsprofileweaknessCode = Convert.ToInt32(deleteStudentsprofileweaknessCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .Deletestudentprofileweakness(QualityAuditNo, tdeleteStudentsprofileweaknessCode, userCode, password);
                string[] info = status.Split('*');
                studentprofileweaknessfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deleteStudentsprofileweaknessCode.Text = "";
                }
            }
            catch (Exception y)
            {
                studentprofileweaknessfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deletestudentssupportsdetail_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeletestudentssupportsdetailCode = Convert.ToInt32(deletestudentssupportsdetailCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .Deletestudentsupport(QualityAuditNo, tdeletestudentssupportsdetailCode, userCode, password);
                string[] info = status.Split('*');
                supportstudentsfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deletestudentssupportsdetailCode.Text = "";
                }
            }
            catch (Exception y)
            {
                supportstudentsfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deleteStudentsprofilestrengths_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeleteStudentsprofilestrengthsCode = Convert.ToInt32(deleteStudentsprofilestrengthsCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .Deletestudentprofilestrengths(QualityAuditNo, tdeleteStudentsprofilestrengthsCode, userCode, password);
                string[] info = status.Split('*');
                studentprofilestrengthfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deleteStudentsprofilestrengthsCode.Text = "";
                }
            }
            catch (Exception y)
            {
                studentprofilestrengthfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deleteQualitySupportStaffstrengths_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeletequalitysupportstaffstrengthsCode = Convert.ToInt32(deletequalitysupportstaffstrengthsCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .Deletestudentprofileweakness(QualityAuditNo, tdeletequalitysupportstaffstrengthsCode, userCode, password);
                string[] info = status.Split('*');
                qualitysupportstrengthfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deletequalitysupportstaffstrengthsCode.Text = "";
                }
            }
            catch (Exception y)
            {
                qualitysupportstrengthfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deleteQualitySupportstaffWeakness_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeletequalitysupportstaffweaknessCode = Convert.ToInt32(deletequalitysupportstaffweaknessCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .Deletequalitysupportstaffweakness(QualityAuditNo, tdeletequalitysupportstaffweaknessCode, userCode, password);
                string[] info = status.Split('*');
                qualitysupportweaknessfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deletequalitysupportstaffweaknessCode.Text = "";
                }
            }
            catch (Exception y)
            {
                qualitysupportweaknessfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deleteStudentProfile_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeleteStudentsProfileCode = Convert.ToInt32(deleteStudentsProfileCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .Deletestudentsprofile(QualityAuditNo, tdeleteStudentsProfileCode, userCode, password);
                string[] info = status.Split('*');
                studentprofilefeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deletequalitysupportstaffweaknessCode.Text = "";
                }
            }
            catch (Exception y)
            {
                studentprofilefeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deletequalitystaffweakness_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeletequalitystaffweaknessCode = Convert.ToInt32(deletequalitystaffweaknessCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteTeachingStaffWeakness(QualityAuditNo, tdeletequalitystaffweaknessCode, userCode, password);
                string[] info = status.Split('*');
                qualitystaffweaknesfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deletequalitystaffweaknessCode.Text = "";
                }
            }
            catch (Exception y)
            {
                qualitystaffweaknesfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deleteNonTeachingStaff_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeleteNonTeachingStaffCode = Convert.ToInt32(deleteNonTeachingStaffCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .Deletequalitysupportstaff(QualityAuditNo, tdeleteNonTeachingStaffCode, userCode, password);
                string[] info = status.Split('*');
                nonteachingstafffeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deleteNonTeachingStaffCode.Text = "";
                }
            }
            catch (Exception y)
            {
                nonteachingstafffeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deletequalitystaffstrength_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeletequalitystaffstrengthCode = Convert.ToInt32(deletequalitystaffstrengthCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteTeachingStaffStrengths(QualityAuditNo, tdeletequalitystaffstrengthCode, userCode, password);
                string[] info = status.Split('*');
                qualitystaffstrengthfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deletequalitystaffstrengthCode.Text = "";
                }
            }
            catch (Exception y)
            {
                qualitystaffstrengthfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deleteAntiPlagiarismDetails_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeleteAntiPlagiarismDetailsCode = Convert.ToInt32(deleteAntiPlagiarismDetailsCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteProgrammeDidecticStrengths(QualityAuditNo, tdeleteAntiPlagiarismDetailsCode, userCode, password);
                string[] info = status.Split('*');
                antiplagiarismfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deleteAntiPlagiarismDetailsCode.Text = "";
                }
            }
            catch (Exception y)
            {
                antiplagiarismfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deletestudentsassments_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeletestudentsassmentsCode = Convert.ToInt32(deletestudentsassmentsCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteStudentsAssesments(QualityAuditNo, tdeletestudentsassmentsCode, userCode, password);
                string[] info = status.Split('*');
                assessmentfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deletestudentsassmentsCode.Text = "";
                }
            }
            catch (Exception y)
            {
                assessmentfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deletestudentsassesweaknesses_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeletestudentsassesweaknessesCode = Convert.ToInt32(deletestudentsassesweaknessesCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteStudentsAssesmentsWeakness(QualityAuditNo, tdeletestudentsassesweaknessesCode, userCode, password);
                string[] info = status.Split('*');
                studentassessmentweaknessfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deletestudentsassesweaknessesCode.Text = "";
                }
            }
            catch (Exception y)
            {
                studentassessmentweaknessfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deleteProgrammeLeader_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeleteProgrammeLeaderCode = Convert.ToInt32(deleteProgrammeLeaderCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteProgrammeLeader(QualityAuditNo, tdeleteProgrammeLeaderCode, userCode, password);
                string[] info = status.Split('*');
                academicleaderfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deleteProgrammeLeaderCode.Text = "";
                }
            }
            catch (Exception y)
            {
                academicleaderfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deletestudentsassesmentstrengths_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeletestudentsassesmentstrengthsCode = Convert.ToInt32(deletestudentsassesmentstrengthsCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteStudentsAssesmentsStrengths(QualityAuditNo, tdeletestudentsassesmentstrengthsCode, userCode, password);
                string[] info = status.Split('*');
                studentsassessmentfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deletestudentsassesmentstrengthsCode.Text = "";
                }
            }
            catch (Exception y)
            {
                studentsassessmentfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deletedidacticweaknessesCode_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeletedidacticweaknessesCode = Convert.ToInt32(deletedidacticweaknessesCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteProgrammeDidecticWeakness(QualityAuditNo, tdeletedidacticweaknessesCode, userCode, password);
                string[] info = status.Split('*');
                didacticweaknessesfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deletedidacticweaknessesCode.Text = "";
                }
            }
            catch (Exception y)
            {
                didacticweaknessesfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deletestakeholders_Click(object sender, EventArgs e)
        {
            try
            {
                int tstakeholdercode = Convert.ToInt32(stakeholdercode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteStakeholders(QualityAuditNo, tstakeholdercode, userCode, password);
                string[] info = status.Split('*');
                feedbackstakeholder.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    stakeholdercode.Text = "";
                }
            }
            catch (Exception y)
            {
                feedbackstakeholder.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deletedidacticconceptstrengths_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeletedidacticconceptstrengthsCode = Convert.ToInt32(deletedidacticconceptstrengthsCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteProgrammeInternshipStrengths(QualityAuditNo, tdeletedidacticconceptstrengthsCode, userCode, password);
                string[] info = status.Split('*');
                internshipfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deletedidacticconceptstrengthsCode.Text = "";
                }
            }
            catch (Exception y)
            {
                internshipfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deletedidacticconceptweakness_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeletedidacticconceptweaknessCode = Convert.ToInt32(deletedidacticconceptweaknessCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteProgrammeInternshipWeakness(QualityAuditNo, tdeletedidacticconceptweaknessCode, userCode, password);
                string[] info = status.Split('*');
                wekanessesfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deletedidacticconceptweaknessCode.Text = "";
                }
            }
            catch (Exception y)
            {
                wekanessesfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deleteprogrammecontentstrengths_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeleteprogrammecontentstrengthsCode = Convert.ToInt32(deleteprogrammecontentstrengthsCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteProgrammeContentStrengths(QualityAuditNo, tdeleteprogrammecontentstrengthsCode, userCode, password);
                string[] info = status.Split('*');
                contentstrenthfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deleteprogrammecontentstrengthsCode.Text = "";
                }
            }
            catch (Exception y)
            {
                contentstrenthfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deleteprogrammecontentweakness_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeleteprogrammecontentweaknessCode = Convert.ToInt32(deleteprogrammecontentweaknessCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteProgrammeContentWeakness(QualityAuditNo, tdeleteprogrammecontentweaknessCode, userCode, password);
                string[] info = status.Split('*');
                contentweaknessfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deleteprogrammecontentweaknessCode.Text = "";
                }
            }
            catch (Exception y)
            {
                contentweaknessfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deleteorganizationalprogrammestrengths_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeleteorganizationalprogrammestrengthsCode = Convert.ToInt32(deleteorganizationalprogrammestrengthsCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteProgrammeOrganizationsStrengths(QualityAuditNo, tdeleteorganizationalprogrammestrengthsCode, userCode, password);
                string[] info = status.Split('*');
                programorganizationstrengthfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deleteorganizationalprogrammestrengthsCode.Text = "";
                }
            }
            catch (Exception y)
            {
                programorganizationstrengthfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deleteorganizationalprogrammeweakness_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeleteorganizationalprogrammeweaknessCode = Convert.ToInt32(deleteorganizationalprogrammeweaknessCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteProgrammeOrganizationsWeakness(QualityAuditNo, tdeleteorganizationalprogrammeweaknessCode, userCode, password);
                string[] info = status.Split('*');
                organizationweaknessfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deleteorganizationalprogrammestrengthsCode.Text = "";
                }
            }
            catch (Exception y)
            {
                organizationweaknessfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deleteprogrammedescriptionsstrenths_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeleteprogrammedescriptionsstrenthsCode = Convert.ToInt32(deleteprogrammedescriptionsstrenthsCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteProgrammeSpecificationsStrengths(QualityAuditNo, tdeleteprogrammedescriptionsstrenthsCode, userCode, password);
                string[] info = status.Split('*');
                specificationstrengthfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deleteprogrammedescriptionsstrenthsCode.Text = "";
                }
            }
            catch (Exception y)
            {
                specificationstrengthfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deleteprogrammedescriptionsweakness_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeleteprogrammedescriptionsweaknessCode = Convert.ToInt32(deleteprogrammedescriptionsweaknessCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteProgrammeSpecificationsWeakness(QualityAuditNo, tdeleteprogrammedescriptionsweaknessCode, userCode, password);
                string[] info = status.Split('*');
                specificationweaknessfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deleteprogrammedescriptionsweaknessCode.Text = "";
                }
            }
            catch (Exception y)
            {
                specificationweaknessfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deleteCourseDistributions_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeleteprogrammeorganizationsCode = Convert.ToInt32(deleteprogrammeorganizationsCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteCourseDistributions(QualityAuditNo, tdeleteprogrammeorganizationsCode, userCode, password);
                string[] info = status.Split('*');
                coursesdistribution.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deleteprogrammeorganizationsCode.Text = "";
                }
            }
            catch (Exception y)
            {
                coursesdistribution.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deleteprogrammecontacthours_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeleteprogrammecontacthoursCode = Convert.ToInt32(deleteprogrammecontacthoursCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteContactHours(QualityAuditNo, tdeleteprogrammecontacthoursCode, userCode, password);
                string[] info = status.Split('*');
                contacthoursfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deleteprogrammeorganizationsCode.Text = "";
                }
            }
            catch (Exception y)
            {
                contacthoursfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deleteoutcomestrengths_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeleteOutcomeStrengthsCode = Convert.ToInt32(deleteOutcomeStrengthsCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteAchievementsOutcomeStrengths(QualityAuditNo, tdeleteOutcomeStrengthsCode, userCode, password);
                string[] info = status.Split('*');
                ountcomestrengthfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deleteOutcomeStrengthsCode.Text = "";
                }
            }
            catch (Exception y)
            {
                ountcomestrengthfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deletelearningaspects_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeletelearningaspectsCode = Convert.ToInt32(deletelearningaspectsCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteAspectsDetails(QualityAuditNo, tdeletelearningaspectsCode, userCode, password);
                string[] info = status.Split('*');
                aspectdecsiptionfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deletelearningaspectsCode.Text = "";
                }
            }
            catch (Exception y)
            {
                aspectdecsiptionfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deleteprogrammeobjectives_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeleteprogrammeobjectivesCode = Convert.ToInt32(deleteprogrammeobjectivesCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteProgrammeObjectives(QualityAuditNo, tdeleteprogrammeobjectivesCode, userCode, password);
                string[] info = status.Split('*');
                Objectivefeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deletelearningaspectsCode.Text = "";
                }
            }
            catch (Exception y)
            {
                Objectivefeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deleteExpectedOutcomeWeakness_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeleteOutcomeWeaknessCode = Convert.ToInt32(deleteOutcomeWeaknessCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteAchievementsOutcomeWeakness(QualityAuditNo, tdeleteOutcomeWeaknessCode, userCode, password);
                string[] info = status.Split('*');
                weaknessesfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deleteOutcomeWeaknessCode.Text = "";
                }
            }
            catch (Exception y)
            {
                weaknessesfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deleteCommunications_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeletecommunicationsCode = Convert.ToInt32(deletecommunicationsCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteOutcomeCommications(QualityAuditNo, tdeletecommunicationsCode, userCode, password);
                string[] info = status.Split('*');
                communicationfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    stakeholdercode.Text = "";
                }
            }
            catch (Exception y)
            {
                communicationfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        //protected void deleteoutcomestrengths_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        int tdeleteOutcomeStrengthsCode = Convert.ToInt32(deleteOutcomeStrengthsCode.Text.Trim());
        //        string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
        //        string userCode = Session["Code"].ToString();
        //        string password = Session["Password"].ToString();
        //        string status = new Config().ObjNav()
        //            .DeleteOutcomeCommications(QualityAuditNo, tdeleteOutcomeStrengthsCode, userCode, password);
        //        string[] info = status.Split('*');
        //        ountcomestrengthfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
        //        if (info[0] == "success")
        //        {
        //            deleteOutcomeStrengthsCode.Text = "";
        //        }
        //    }
        //    catch (Exception y)
        //    {
        //        ountcomestrengthfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
        //    }
        //}
        protected void deletestakeholderStrength_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeletestakeholderstrengthcode = Convert.ToInt32(deletestakeholderstrengthcode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteStakeholdersStrengths(QualityAuditNo, tdeletestakeholderstrengthcode, userCode, password);
                string[] info = status.Split('*');
                feedbackstakeholder.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    stakeholdercode.Text = "";
                }
            }
            catch (Exception y)
            {
                feedbackstakeholder.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deletestakeholderWeakness_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeletestakeholderweaknesscode = Convert.ToInt32(deletestakeholderweaknesscode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteStakeholdersWeakness(QualityAuditNo, tdeletestakeholderweaknesscode, userCode, password);
                string[] info = status.Split('*');
                feedbackstakeholder.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    stakeholdercode.Text = "";
                }
            }
            catch (Exception y)
            {
                feedbackstakeholder.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deleteGenericOutcome_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeletegenericCode = Convert.ToInt32(deletegenericCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteGenericOutcome(QualityAuditNo, tdeletegenericCode, userCode, password);
                string[] info = status.Split('*');
                feebackgenericoutcome.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deletegenericCode.Text = "";
                }
            }
            catch (Exception y)
            {
                feebackgenericoutcome.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deleteProfessionalOutcome_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeleteprofessionalCode = Convert.ToInt32(deleteprofessionalCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteProfessionalOutcome(QualityAuditNo, tdeleteprofessionalCode, userCode, password);
                string[] info = status.Split('*');
                feedbackprofessional.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deleteprofessionalCode.Text = "";
                }
            }
            catch (Exception y)
            {
                feedbackprofessional.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deleteneedsRequirements_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeleteneedsrequirementsCode = Convert.ToInt32(deleteneedsrequirementsCode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteNeedsDemandsRequirements(QualityAuditNo, tdeleteneedsrequirementsCode, userCode, password);
                string[] info = status.Split('*');
                specificneedsfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deleteneedsrequirementsCode.Text = "";
                }
            }
            catch (Exception y)
            {
                specificneedsfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deleteotherstakeholders_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeleteotherstakeholdercode = Convert.ToInt32(deleteotherstakeholdercode.Text.Trim());
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteotherStakeholders(QualityAuditNo, tdeleteotherstakeholdercode, userCode, password);
                string[] info = status.Split('*');
                feedbackOthers.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    deleteotherstakeholdercode.Text = "";
                }
            }
            catch (Exception y)
            {
                feedbackstakeholder.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void editBasicProgrammeInformations_Click(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string tnameofprogramme = "";
                string tacademicProgrammeDomain = "";
                string taccreditationDate = "";
                bool trequiresApproval = false;
                bool tapprovedByProfessionalBody = false;
                bool tapprovedByProfessionalEvidence = false;
                string tprofessionalBodyApprovalDate = "";
                string tprofessionalBody = "";
                string tuniversityniche = "";
                string QualityAuditNo = qualityauditnumber.Text.Trim();
                try
                {
                    tuniversityniche = edituniversityniche.Text.Trim();
                    if (tuniversityniche.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {

                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid Brief description of the niche of the university";
                }
                try
                {
                    tnameofprogramme = editNameofAcademicProgramme.Text.Trim();
                    if (tnameofprogramme.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {

                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid  Name of the Programme";
                }
                try
                {
                    tacademicProgrammeDomain = editprogrammedomain.Text.Trim();
                    if (tacademicProgrammeDomain.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {

                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please select the Academic Programme Domain";
                }
                try
                {
                    if (editrequireapprovals.Checked == true)
                    {
                        trequiresApproval = true;
                    }
                    else
                    {
                        trequiresApproval = false;
                    }
                }
                catch (Exception)
                {

                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please check if Academic Programme require approval by a relevant professional body";
                }
                try
                {
                    if (approvedByProfessionalBody.Checked == true)
                    {
                        tapprovedByProfessionalBody = true;
                    }
                    else
                    {
                        tapprovedByProfessionalBody = false;
                    }
                }
                catch (Exception)
                {

                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please check if Academic Programme require approval by a relevant professional body";
                }
                //try
                //{
                //    tprofessionalBodyApprovalDate = editprofessionalbodyapproval.Text.Trim();
                //    if (tprofessionalBodyApprovalDate.Length < 1)
                //    {
                //        throw new Exception();
                //    }
                //}
                //catch (Exception)
                //{

                //    error = true;
                //    message += message.Length > 0 ? "<br" : "";
                //    message += "Please enter the Date of approval by the relevant professional body";
                //}
                try
                {
                    tprofessionalBody = editprofessionalbosyname.Text.Trim();
                    if (tprofessionalBody.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {

                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please Indicate the name of the Professional body";
                }
                if (error)
                {
                    basicinformations.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
                    string status = new Config().ObjNav()
                        .EditBasicInformation(QualityAuditNo, tnameofprogramme, tacademicProgrammeDomain, taccreditationDate, trequiresApproval, tapprovedByProfessionalEvidence, tapprovedByProfessionalBody, tprofessionalBody, tprofessionalBodyApprovalDate, tuniversityniche, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    basicinformations.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        basicinformations.InnerHtml = Config.GetAlert(info[0], info[1]);

                    }
                }
            }
            catch (Exception y)
            {
                basicinformations.InnerHtml = "<div class='alert alert-danger'>" + y.Message + "</div>";
            }
        }
        protected void saveStakeHolders_Click(object sender, EventArgs e)
        {
            foreach (HtmlTableRow row in knownStakeHolders.Rows)
            {
                try
                {
                    HtmlTableCellCollection cells = row.Cells;
                    HtmlTableCell stakeholderCell = cells[1]; //is stakeholder
                    CheckBox isStakeHolder = (CheckBox)stakeholderCell.Controls[0];
                    HtmlTableCell engagedCell = cells[2]; //is engaged
                    CheckBox isEngaged = (CheckBox)engagedCell.Controls[0];
                    HtmlTableCell analyzedcell = cells[3]; //is engaged
                    CheckBox isAnalyzed = (CheckBox)analyzedcell.Controls[0];
                    string stakeHolderCode = isStakeHolder.ID.Replace("isstakeholder", "");
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    Boolean tStakeHolder = isStakeHolder.Checked;
                    Boolean tEngaged = isEngaged.Checked;
                    Boolean tAnalyzed = isAnalyzed.Checked;
                    string tNo = isStakeHolder.ID;
                    tNo = isEngaged.ID;
                    tNo = isAnalyzed.ID;

                    string status = new Config().ObjNav()
                        .AddKnownStakeHolder(qaNo, stakeHolderCode, tStakeHolder, tEngaged, tAnalyzed, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    feedbackstakeholder.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
                catch (Exception y)
                {
                    feedbackstakeholder.InnerHtml = "<div class='alert alert-danger'>" + y.Message + "</div>";
                }
            }

        }
        protected void AddOtherStakeholder_Click(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool error = false;
                string tStakeholder = otherStakeHolderName.Text.Trim();
                bool tstakeengaged = false;
                bool tanalyzeneeds = false;
                string totherStakeHolderName = "";
                try
                {
                    if (analyzeneeds.Checked == false && stakeengaged.Checked == false)
                    {
                        feedbackOthers.InnerHtml = "<div class='alert alert-danger'>Kindly check  Analyzed or Engaged Option before you proceed</div>";
                        return;
                    }
                    if (analyzeneeds.Checked == true)
                    {
                        tanalyzeneeds = true;
                    }
                    if (stakeengaged.Checked == true)
                    {
                        tstakeengaged = true;
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Kindly check  analyzed Option and Engaged Option before you proceed";
                }

                try
                {
                    totherStakeHolderName = otherStakeHolderName.Text.Trim();
                    if (totherStakeHolderName.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {

                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please Enter Stakeholder Name";
                }
                if (error)
                {
                    feedbackOthers.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                            .AddNewStakeHolder(qaNo, tStakeholder, tstakeengaged, tanalyzeneeds, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    feedbackOthers.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        otherStakeHolderName.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                feedbackOthers.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addStakeHolderStrength_Click(object sender, EventArgs e)
        {
            try
            {
                string tstakeHolderStrength = stakeHolderStrength.Text.Trim();
                if (string.IsNullOrEmpty(tstakeHolderStrength))
                {
                    StrenghtsFeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for stakeholder Key strength");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav().AddStrengthOrWeakness(qaNo, 0, tstakeHolderStrength, Convert.ToString(Session["Code"]),
                                    Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    StrenghtsFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        stakeHolderStrength.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                StrenghtsFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addFacilitiesStrenght_Click(object sender, EventArgs e)
        {
            try
            {
                string tfacilitiesstrength = facilitiesstrength.Text.Trim();
                if (string.IsNullOrEmpty(tfacilitiesstrength))
                {
                    facilitiesstrengthfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Facilities Key strength");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav().AddFacilitiesStrength(qaNo,tfacilitiesstrength, Convert.ToString(Session["Code"]),
                                    Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    facilitiesstrengthfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        facilitiesstrength.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                facilitiesstrengthfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addFacilitiesWeaknesses_Click(object sender, EventArgs e)
        {
            try
            {
                string tfacilitiesweakness = facilitiesweakness.Text.Trim();
                if (string.IsNullOrEmpty(tfacilitiesweakness))
                {
                    facilitiesweaknessfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Facilities Key Weakness");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav().AddFacilitiesWeakness(qaNo, tfacilitiesweakness, Convert.ToString(Session["Code"]),
                                    Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    facilitiesweaknessfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        facilitiesstrength.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                facilitiesweaknessfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addStakeHolderWeakness_Click(object sender, EventArgs e)
        {
            try
            {
                string tWeakness = stakeholderWeakness.Text.Trim();
                if (string.IsNullOrEmpty(tWeakness))
                {
                    WeaknessesFeedbacks.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for stakeholder weakness");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddStrengthOrWeakness(qaNo, 1, tWeakness, Convert.ToString(Session["Code"]),
                                    Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    WeaknessesFeedbacks.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        stakeholderWeakness.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                WeaknessesFeedbacks.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addStudentProfileStrenght_Click(object sender, EventArgs e)
        {
            try
            {
                string tStudentsprofilestrength = Studentsprofilestrength.Text.Trim();
                if (string.IsNullOrEmpty(tStudentsprofilestrength))
                {
                    studentprofilestrengthfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Student Profile Strength");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddStudentProfileStrength(qaNo, tStudentsprofilestrength, Convert.ToString(Session["Code"]),
                                    Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    studentprofilestrengthfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        Studentsprofilestrength.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                studentprofilestrengthfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addStudentProfileWeaknesses_Click(object sender, EventArgs e)
        {
            try
            {
                string tstudentprofileweakness = studentprofileweakness.Text.Trim();
                if (string.IsNullOrEmpty(tstudentprofileweakness))
                {
                    studentprofileweaknessfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Student Profile Weakness");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddStudentProfileWeakness(qaNo, tstudentprofileweakness, Convert.ToString(Session["Code"]),
                                    Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    studentprofileweaknessfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        studentprofileweakness.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                studentprofileweaknessfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addStudentsSupportStrenght_Click(object sender, EventArgs e)
        {
            try
            {
                string tstudentsupportstrength = studentsupportstrength.Text.Trim();
                if (string.IsNullOrEmpty(tstudentsupportstrength))
                {
                    studentssupportstrengthfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Student Support Strength");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddStudentSupportStrength(qaNo, tstudentsupportstrength, Convert.ToString(Session["Code"]),
                                    Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    studentssupportstrengthfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        Studentsprofilestrength.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                studentssupportstrengthfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addStudentSupportWeaknesses_Click(object sender, EventArgs e)
        {
            try
            {
                string tstudentsupportweakness = studentsupportweakness.Text.Trim();
                if (string.IsNullOrEmpty(tstudentsupportweakness))
                {
                    studentsupportweaknessfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Student Support Weakness");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddStudentSupportWeakness(qaNo, tstudentsupportweakness, Convert.ToString(Session["Code"]),
                                    Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    studentsupportweaknessfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        Studentsprofilestrength.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                studentsupportweaknessfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addQualityStaffStrenght_Click(object sender, EventArgs e)
        {
            try
            {
                string tqualitystaffstrength = qualitystaffstrength.Text.Trim();
                if (string.IsNullOrEmpty(tqualitystaffstrength))
                {
                    qualitystaffstrengthfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Quality Staff Strength");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddQualityStaffStrength(qaNo,tqualitystaffstrength, Convert.ToString(Session["Code"]),
                                    Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    qualitystaffstrengthfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        qualitystaffstrength.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                qualitystaffstrengthfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }

        protected void addQualitystaffWeaknesses_Click(object sender, EventArgs e)
        {
            try
            {
                string tqualitystaffweaknes = qualitystaffweaknes.Text.Trim();
                if (string.IsNullOrEmpty(tqualitystaffweaknes))
                {
                    qualitystaffweaknesfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Quality Staff weakness");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddQualityStaffWeakness(qaNo, tqualitystaffweaknes, Convert.ToString(Session["Code"]),
                                    Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    qualitystaffweaknesfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        qualitystaffstrength.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                qualitystaffweaknesfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void ValidateStakeholders_Click(object sender, EventArgs e)
        {
            try
            {
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .ValidateStakeholderRequirements(QualityAuditNo, userCode, password);
                if (status == "success")
                {
                    Response.Redirect("ProgramQA.aspx?QualityAuditNo=" + QualityAuditNo + "&step=3");
                }
                else
                {
                    string[] info = status.Split('*');
                    feedbackstakeholder.InnerHtml = Config.GetAlert(info[0], info[1]);

                }
            }
            catch (Exception y)
            {
                feedbackstakeholder.InnerHtml = "<div class='alert alert-danger'>" + y.Message + "</div>";
            }


        }
        protected void ValidateExpectedLearningOutcomes_Click(object sender, EventArgs e)
        {
            try
            {
                string QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .ValidateExpectedLearningOutcomes(QualityAuditNo, userCode, password);
                if (status == "success")
                {
                    Response.Redirect("ProgramQA.aspx?QualityAuditNo=" + QualityAuditNo + "&step=4");
                }
                else
                {
                    string[] info = status.Split('*');
                    feebackgenericoutcome.InnerHtml = Config.GetAlert(info[0], info[1]);

                }
            }
            catch (Exception y)
            {
                feebackgenericoutcome.InnerHtml = "<div class='alert alert-danger'>" + y.Message + "</div>";
            }


        }
        protected void addGenericOutCome_Click(object sender, EventArgs e)
        {
            try
            {
                string tgenericlearningoutcome = genericlearningoutcome.Text.Trim();
                if (string.IsNullOrEmpty(tgenericlearningoutcome))
                {
                    feebackgenericoutcome.InnerHtml = Config.GetAlert("danger", "Please provide a valid value Generic Expected Learning Outcomes");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string userCode = Session["Code"].ToString();
                    string password = Session["Password"].ToString();
                    string status = new Config().ObjNav()
                            .AddGenericOutcome(qaNo, tgenericlearningoutcome, userCode, password);
                    string[] info = status.Split('*');
                    feebackgenericoutcome.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        genericlearningoutcome.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                feebackgenericoutcome.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addProffessionalOutCome_Click(object sender, EventArgs e)
        {
            try
            {
                string tproffessionallearningoutcomee = proffessionallearningoutcome.Text.Trim();
                if (string.IsNullOrEmpty(tproffessionallearningoutcomee))
                {
                    feedbackprofessional.InnerHtml = Config.GetAlert("danger", "Please provide a valid value Professional/Discipline Specific Expected Learning Outcomes");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string userCode = Session["Code"].ToString();
                    string password = Session["Password"].ToString();
                    string status = new Config().ObjNav()
                            .AddProffessionalOutcome(qaNo, tproffessionallearningoutcomee, userCode, password);
                    string[] info = status.Split('*');
                    feedbackprofessional.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        genericlearningoutcome.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                feedbackprofessional.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void adddetails_Click(object sender, EventArgs e)
        {
            try
            {

                bool treflectrequirements = false;
                if (reflectrequirements.Checked == true)
                {
                    treflectrequirements = true;
                }
                else
                {
                    treflectrequirements = false;
                }
                string texpectedlearningfits = expectedlearningfits.Text.Trim();
                if (string.IsNullOrEmpty(texpectedlearningfits))
                {
                    genericlearningoutcomedetails.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for How do the Expected Learning Outcomes fit into the University mission");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string userCode = Session["Code"].ToString();
                    string password = Session["Password"].ToString();
                    string status = new Config().ObjNav()
                            .AddExpectedLearningOutcomeDetails(qaNo, texpectedlearningfits, treflectrequirements, userCode, password);
                    string[] info = status.Split('*');
                    genericlearningoutcomedetails.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        genericlearningoutcome.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                genericlearningoutcomedetails.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addSpecificNeedsDemands_Click(object sender, EventArgs e)
        {
            try
            {
                string tstakeholderslist = stakeholderslist.SelectedValue;
                string tneedsdemands = needsdemands.Text.Trim();
                if (string.IsNullOrEmpty(tneedsdemands))
                {
                    specificneedsfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Needs, demands, or requirements");
                }
                string taddressingrequirements = addressingrequirements.Text.Trim();
                if (string.IsNullOrEmpty(taddressingrequirements))
                {
                    specificneedsfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for How stakeholder requirements are addressed in the Expected Learning Outcomes");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string userCode = Session["Code"].ToString();
                    string password = Session["Password"].ToString();
                    string status = new Config().ObjNav()
                            .AddNeedsRequirements(qaNo, tstakeholderslist, tneedsdemands, taddressingrequirements, userCode, password);
                    string[] info = status.Split('*');
                    specificneedsfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        needsdemands.Text = "";
                        addressingrequirements.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                specificneedsfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addCommunicationDetails_Click(object sender, EventArgs e)
        {
            try
            {
                bool tmemos = false;
                if (memos.Checked == true)
                {
                    tmemos = true;
                }
                else
                {
                    tmemos = false;
                }
                bool tnewsletters = false;
                if (newsletters.Checked == true)
                {
                    tnewsletters = true;
                }
                else
                {
                    tnewsletters = false;
                }

                bool tmeetings = false;
                if (meetings.Checked == true)
                {
                    tmeetings = true;
                }
                else
                {
                    tmeetings = false;
                }
                bool tconferences = false;
                if (conferences.Checked == true)
                {
                    tconferences = true;
                }
                else
                {
                    tconferences = false;
                }
                string tthercommunis = othercommunis.Text.Trim();
                string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                        .AddCommunicationDetails(qaNo, tmemos, tnewsletters, tmeetings, tconferences, tthercommunis, userCode, password);
                string[] info = status.Split('*');
                communicationfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    othercommunis.Text = "";
                }
            }
            catch (Exception y)
            {
                communicationfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addOutcomeStrenght_Click(object sender, EventArgs e)
        {
            try
            {
                string toutcomestrength = outcomestrength.Text.Trim();
                if (string.IsNullOrEmpty(toutcomestrength))
                {
                    ountcomestrengthfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for key strengths on achievements of expected learning outcomes");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddOutComesStrength(qaNo, toutcomestrength, Convert.ToString(Session["Code"]),
                                    Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    ountcomestrengthfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        stakeholderWeakness.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                ountcomestrengthfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addSpecificationstrength_Click(object sender, EventArgs e)
        {
            try
            {
                string tspecificationstrength = specificationstrength.Text.Trim();
                if (string.IsNullOrEmpty(tspecificationstrength))
                {
                    specificationstrengthfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for key Strengths on Programme Description/Specification");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddProgramSpecificationStrength(qaNo, tspecificationstrength, Convert.ToString(Session["Code"]),
                                    Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    specificationstrengthfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        stakeholderWeakness.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                specificationstrengthfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addSpecificationWeakness_Click(object sender, EventArgs e)
        {
            try
            {
                string tspecificationweakness = specificationweakness.Text.Trim();
                if (string.IsNullOrEmpty(tspecificationweakness))
                {
                    specificationweaknessfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for key Weakness on Programme Description/Specification");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddProgramSpecificationWeakness(qaNo, tspecificationweakness, Convert.ToString(Session["Code"]),
                                    Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    specificationweaknessfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        stakeholderWeakness.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                specificationweaknessfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addProgramContentStrenght_Click(object sender, EventArgs e)
        {
            try
            {
                string tprogramcontentstrength = programcontentstrength.Text.Trim();
                if (string.IsNullOrEmpty(tprogramcontentstrength))
                {
                    contentstrenthfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for key Strength on Programme Content");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddProgramContentStrength(qaNo, tprogramcontentstrength, Convert.ToString(Session["Code"]),
                                    Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    contentstrenthfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        programcontentstrength.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                contentstrenthfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addProgramContentWeaknesses_Click(object sender, EventArgs e)
        {
            try
            {
                string tprogramcontentweakness = programcontentweakness.Text.Trim();
                if (string.IsNullOrEmpty(tprogramcontentweakness))
                {
                    contentweaknessfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for key Weakness on Programme Content");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddProgramContentWeakness(qaNo, tprogramcontentweakness, Convert.ToString(Session["Code"]),
                                    Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    contentweaknessfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        programcontentstrength.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                contentweaknessfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addWeaknesses_Click(object sender, EventArgs e)
        {
            try
            {
                string toutcomeweaknesses = outcomeweaknesses.Text.Trim();
                if (string.IsNullOrEmpty(toutcomeweaknesses))
                {
                    weaknessesfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for key weakness on achievements of expected learning outcomes");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddOutComesWeakness(qaNo, toutcomeweaknesses, Convert.ToString(Session["Code"]),
                                    Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    weaknessesfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        outcomeweaknesses.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                weaknessesfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addAspectDescription_Click(object sender, EventArgs e)
        {
            try
            {
                string tknowledgeaspect = knowledgeaspect.Text.Trim();
                if (string.IsNullOrEmpty(tknowledgeaspect))
                {
                    aspectdecsiptionfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Knowledge and understanding");
                }
                string tcognitiveskills = cognitiveskills.Text.Trim();
                if (string.IsNullOrEmpty(tcognitiveskills))
                {
                    aspectdecsiptionfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Cognitive skills (e.g. methodologies, critical analysis)");
                }
                string tsubjectaspects = subjectaspects.Text.Trim();
                if (string.IsNullOrEmpty(tknowledgeaspect))
                {
                    aspectdecsiptionfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Subject specific skills (e.g. laboratory skills, clinical skills)");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddAspectDesciption(qaNo, tknowledgeaspect, tcognitiveskills, tsubjectaspects, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    aspectdecsiptionfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        outcomeweaknesses.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                aspectdecsiptionfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addProgrammeObjective_Click(object sender, EventArgs e)
        {
            try
            {
                string tobjectiveinstructions = objectiveinstructions.Text.Trim();
                if (string.IsNullOrEmpty(tobjectiveinstructions))
                {
                    Objectivefeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for  State the Academic Programme Objectives");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddProgrammeObjective(qaNo, tobjectiveinstructions, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    Objectivefeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        objectiveinstructions.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                Objectivefeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addDistributionCourses_Click(object sender, EventArgs e)
        {
            try
            {
                string tyearofstudy = yearofstudy.SelectedValue;
                if (string.IsNullOrEmpty(tyearofstudy))
                {
                    Objectivefeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for  Year of Study");
                }
                string tsemester = semester.SelectedValue;
                if (string.IsNullOrEmpty(tsemester))
                {
                    Objectivefeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for  Semester");
                }
                string tcoursescode = coursescode.SelectedValue;
                if (string.IsNullOrEmpty(tcoursescode))
                {
                    Objectivefeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for  Course or Unit");
                }
                string tbasicintermediate = basicintermediate.SelectedValue;
                if (string.IsNullOrEmpty(tbasicintermediate))
                {
                    Objectivefeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Basic/Intermediate/Specialist/Optional");
                }
                string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                string status = new Config().ObjNav()
                            .AddCoursesDistribution(qaNo, tyearofstudy, tsemester, tcoursescode, tbasicintermediate, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                string[] info = status.Split('*');
                coursesdistribution.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    // objectiveinstructions.Text = "";
                }

            }
            catch (Exception y)
            {
                coursesdistribution.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addProgrammeDetails_Click(object sender, EventArgs e)
        {
            try
            {
                string tinstructionalhours = instructionalhours.Text.Trim();
                if (string.IsNullOrEmpty(tinstructionalhours))
                {
                    instructinaldetailsreasons.InnerHtml = Config.GetAlert("danger", "Please provide How many instructional hours are allocated to the Academic Programme");
                }
                string tprogrammerationale = programmerationale.Text.Trim();
                if (string.IsNullOrEmpty(tprogrammerationale))
                {
                    instructinaldetailsreasons.InnerHtml = Config.GetAlert("danger", "Please provide valide value for the rationale for the chosen structure of the Academic Programme");
                }
                bool tprogrammestructure = false;
                if (programmestructure.Checked == true)
                {
                    tprogrammestructure = true;
                }
                else
                {
                    tprogrammestructure = false;
                }
                string tstructurechanges = structurechanges.Text.Trim();
                if (string.IsNullOrEmpty(tstructurechanges))
                {
                    instructinaldetailsreasons.InnerHtml = Config.GetAlert("danger", "Please provide valide value for change(s) and reason(s) for the  the Academic Programme Structure");
                }
                string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                string status = new Config().ObjNav()
                            .AddInstructionalHoursDetails(qaNo, tinstructionalhours, tprogrammerationale, tprogrammestructure, tstructurechanges, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                string[] info = status.Split('*');
                instructinaldetailsreasons.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    // objectiveinstructions.Text = "";
                }

            }
            catch (Exception y)
            {
                instructinaldetailsreasons.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addContactHoursDetails_Click(object sender, EventArgs e)
        {
            try
            {
                string tsubjectarea = subjectarea.Text.Trim();
                if (string.IsNullOrEmpty(tsubjectarea))
                {
                    contacthoursfeedback.InnerHtml = Config.GetAlert("danger", "Please provide valide value for the Subject Area:");
                }
                string tunits = units.Text.Trim();
                if (string.IsNullOrEmpty(tunits))
                {
                    contacthoursfeedback.InnerHtml = Config.GetAlert("danger", "Please provide valide value for the Unit:");
                }
                string tcontacthours = contacthours.Text.Trim();
                if (string.IsNullOrEmpty(tcontacthours))
                {
                    contacthoursfeedback.InnerHtml = Config.GetAlert("danger", "Please provide valide value for the Contact Hours per Subject Area:");
                }
                string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                string status = new Config().ObjNav()
                            .AddCourseHoursDistribution(qaNo, tsubjectarea, tunits, tcontacthours, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                string[] info = status.Split('*');
                contacthoursfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    // objectiveinstructions.Text = "";
                }

            }
            catch (Exception y)
            {
                contacthoursfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addInstructionalHoursDetails_Click(object sender, EventArgs e)
        {
            try
            {
                string tlabaratoryhpurs = labaratoryhpurs.Text.Trim();
                if (string.IsNullOrEmpty(tlabaratoryhpurs))
                {
                    instructionalhousfeedback.InnerHtml = Config.GetAlert("danger", "Please provide valide value for the Laboratory/Farm sessions:");
                }
                string tpracticumhours = practicumhours.Text.Trim();
                if (string.IsNullOrEmpty(tpracticumhours))
                {
                    instructionalhousfeedback.InnerHtml = Config.GetAlert("danger", "Please provide valide value for the Practicum/Industrial attachment:");
                }
                string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                string status = new Config().ObjNav()
                            .AddInstructionalHours(qaNo, tlabaratoryhpurs, tpracticumhours, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                string[] info = status.Split('*');
                instructionalhousfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    // objectiveinstructions.Text = "";
                }

            }
            catch (Exception y)
            {
                instructionalhousfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addCommunication_Click(object sender, EventArgs e)
        {
            try
            {

                bool tpubliceademic = false;
                if (publiceademic.Checked == false)
                {
                    academicpublicfeedback.InnerHtml = "<div class='alert alert-danger'>Kindly check whether has the University made public the academic programme/description</div>";
                    return;
                }
                else
                {
                    tpubliceademic = true;
                }

                bool tstaff = false;
                if (staff.Checked == false)
                {
                    academicpublicfeedback.InnerHtml = "<div class='alert alert-danger'>Kindly check whether  the University has communicated to Staff </div>";
                    return;
                }
                else
                {
                    tstaff = true;
                }
                bool tstudents = false;
                if (students.Checked == false)
                {
                    academicpublicfeedback.InnerHtml = "<div class='alert alert-danger'>Kindly check whether the University has communicated to Students </div>";
                    return;
                }
                else
                {
                    tstudents = true;
                }
                bool temployers = false;
                if (employers.Checked == false)
                {
                    academicpublicfeedback.InnerHtml = "<div class='alert alert-danger'>Kindly check whether the University has communicated to Employers </div>";
                    return;
                }
                else
                {
                    temployers = true;
                }
                bool tstatutorybodies = false;
                if (statutorybodies.Checked == false)
                {
                    academicpublicfeedback.InnerHtml = "<div class='alert alert-danger'>Kindly check whether the University has Communicated to Statutory bodies that accredit higher Education Programmes	 </div>";
                    return;
                }
                else
                {
                    tstatutorybodies = true;
                }
                bool tproffessionalbodies = false;
                if (proffessionalbodies.Checked == false)
                {
                    academicpublicfeedback.InnerHtml = "<div class='alert alert-danger'>Kindly check whether the University has Communicated to Regulatory/professional bodies (where applicable) </div>";
                    return;
                }
                else
                {
                    tproffessionalbodies = true;
                }
                string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                string status = new Config().ObjNav()
                            .AddProgrammeCommunicationDetails(qaNo, tpubliceademic, tstaff, tstudents, temployers, tstatutorybodies, tproffessionalbodies, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                string[] info = status.Split('*');
                academicpublicfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    // objectiveinstructions.Text = "";
                }

            }
            catch (Exception y)
            {
                academicpublicfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addProgrammeContent_Click(object sender, EventArgs e)
        {
            try
            {
                bool tprogrammereviewd = false;

                if (programmereviewd.Checked == true)
                {
                    tprogrammereviewd = true;
                }

                string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                string status = new Config().ObjNav()
                            .AddProgrammeContent(qaNo, tprogrammereviewd, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                string[] info = status.Split('*');
                programmereviewedfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    // objectiveinstructions.Text = "";
                }

            }
            catch (Exception y)
            {
                programmereviewedfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addOrganizationProgramme_Click(object sender, EventArgs e)
        {
            try
            {
                if (semesterprogramme.Checked == true && trimestersprogramme.Checked == true && quartersprogramme.Checked == true)
                {
                    academicorganizationfeedback.InnerHtml = "<div class='alert alert-danger'>Kindly check only one academic calendar in which the Academic Programme is organised before you proceed</div>";
                    return;
                }
                bool tsemesterprogramme = false;
                if (semesterprogramme.Checked == true)
                {
                    tsemesterprogramme = true;
                }
                bool ttrimestersprogramme = false;
                if (trimestersprogramme.Checked == true)
                {
                    ttrimestersprogramme = true;
                }
                bool tquartersprogramme = false;
                if (quartersprogramme.Checked == true)
                {
                    tquartersprogramme = true;
                }
                bool tcreditspointsdepartment = false;
                if (creditspointsdepartment.Checked == true)
                {
                    tcreditspointsdepartment = true;
                }
                bool tstudentsfeedback = false;
                if (studentsfeedback.Checked == true)
                {
                    tstudentsfeedback = true;
                }
                bool tacademicstafffeedback = false;
                if (academicstafffeedback.Checked == true)
                {
                    tacademicstafffeedback = true;
                }
                bool talumnifeedback = false;
                if (alumnifeedback.Checked == true)
                {
                    talumnifeedback = true;
                }
                string tothersprogramme = othersprogramme.Text.Trim();
                string tcreditscalculation = creditscalculation.Text.Trim();
                string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                string status = new Config().ObjNav()
                            .AddProgrammeOrganization(qaNo, tsemesterprogramme, ttrimestersprogramme, tquartersprogramme, tothersprogramme, tcreditspointsdepartment, tcreditscalculation, tstudentsfeedback,
                            tacademicstafffeedback, talumnifeedback, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                string[] info = status.Split('*');
                academicorganizationfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    // objectiveinstructions.Text = "";
                }

            }
            catch (Exception y)
            {
                academicorganizationfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addDedacticConcept_Click(object sender, EventArgs e)
        {
            try
            {
                bool tlecture = false;
                if (lecture.Checked == true)
                {
                    tlecture = true;
                }
                bool tdiscussion = false;
                if (discussion.Checked == true)
                {
                    tdiscussion = true;
                }
                bool tquestion = false;
                if (question.Checked == true)
                {
                    tquestion = true;
                }
                bool tbrainstorming = false;
                if (brainstorming.Checked == true)
                {
                    tbrainstorming = true;
                }
                bool tbuzzgroups = false;
                if (buzzgroups.Checked == true)
                {
                    tbuzzgroups = true;
                }
                bool troleplays = false;
                if (roleplays.Checked == true)
                {
                    troleplays = true;
                }
                bool tclassexperiment = false;
                if (classexperiment.Checked == true)
                {
                    tclassexperiment = true;
                }
                bool tcasestudymethod = false;
                if (casestudymethod.Checked == true)
                {
                    tcasestudymethod = true;
                }
                bool tdemonstration = false;
                if (demonstration.Checked == true)
                {
                    tdemonstration = true;
                }
                bool tfieldstudy = false;
                if (fieldstudy.Checked == true)
                {
                    tfieldstudy = true;
                }
                bool tictacademic = false;
                if (ictacademic.Checked == true)
                {
                    tictacademic = true;
                }
                bool tresearchcademic = false;
                if (researchcademic.Checked == true)
                {
                    tresearchcademic = true;
                }
                bool tcoursemethods = false;
                if (coursemethods.Checked == true)
                {
                    tcoursemethods = true;
                }
                bool trequireattachment = false;
                if (requireattachment.Checked == true)
                {
                    trequireattachment = true;
                }
                bool tinternshipcompulsory = false;
                if (internshipcompulsory.Checked == true)
                {
                    tinternshipcompulsory = true;
                }
                string tresearchmethodyear = researchmethodyear.SelectedValue;
                string treasearchmethodsemester = reasearchmethodsemester.SelectedValue;
                string tindustrialattachment = industrialattachment.Text.Trim();
                string tdurations = durations.Text.Trim();
                string tcreditpoints = creditpoints.Text.Trim();
                string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                string status = new Config().ObjNav()
                            .AddDidacticConcept(qaNo, tlecture, tdiscussion, tquestion, tbrainstorming, tbuzzgroups, troleplays, tclassexperiment, tcasestudymethod, tdemonstration,
                            tfieldstudy, tictacademic, tresearchcademic, tresearchmethodyear, tcoursemethods, treasearchmethodsemester, trequireattachment,
                            tindustrialattachment, tdurations, tcreditpoints, tinternshipcompulsory, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                string[] info = status.Split('*');
                didecticconceptfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    // objectiveinstructions.Text = "";
                }

            }
            catch (Exception y)
            {
                didecticconceptfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addInternshipStregnth_Click(object sender, EventArgs e)
        {
            try
            {
                string tinternshipstrength = internshipstrength.Text.Trim();
                if (string.IsNullOrEmpty(tinternshipstrength))
                {
                    internshipfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Internship Strenght");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddInternshipStrenghts(qaNo, tinternshipstrength, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    internshipfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        outcomeweaknesses.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                internshipfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addInternshipWeakness_Click(object sender, EventArgs e)
        {
            try
            {
                string tinternshipweakness = internshipweakness.Text.Trim();
                if (string.IsNullOrEmpty(tinternshipweakness))
                {
                    wekanessesfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Internship Strenght");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddInternshipWeaknesses(qaNo, tinternshipweakness, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    wekanessesfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        outcomeweaknesses.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                wekanessesfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addDidacticStrengths_Click(object sender, EventArgs e)
        {
            try
            {
                string tdidacticstrenght = didacticstrenght.Text.Trim();
                if (string.IsNullOrEmpty(tdidacticstrenght))
                {
                    didacticfeedbackstrenght.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for strengths  of your other didactic and pedagogical approaches of the academic programme");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddOtherDidecticStrength(qaNo, tdidacticstrenght, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    didacticfeedbackstrenght.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        outcomeweaknesses.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                didacticfeedbackstrenght.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addStudentsEvaluationStrenght_Click(object sender, EventArgs e)
        {
            try
            {
                string tstudentevaluationstrengths = studentevaluationstrengths.Text.Trim();
                if (string.IsNullOrEmpty(tstudentevaluationstrengths))
                {
                    studentevaluationstrengthsfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for strengths  of Students Evaluations");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddStudentsEvalautionStrength(qaNo, tstudentevaluationstrengths, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    studentevaluationstrengthsfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        studentevaluationstrengths.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                studentevaluationstrengthsfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addStudentsEvaluationsWeaknesses_Click(object sender, EventArgs e)
        {
            try
            {
                string tstudentsevaluationweakness = studentsevaluationweakness.Text.Trim();
                if (string.IsNullOrEmpty(tstudentsevaluationweakness))
                {
                    studentsevaluationweaknessfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Weakness  of Students Evaluations");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddStudentsEvaluationWeakness(qaNo, tstudentsevaluationweakness, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    studentsevaluationweaknessfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        studentsevaluationweakness.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                studentsevaluationweaknessfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addCurriculumndesignStrengths_Click(object sender, EventArgs e)
        {
            try
            {
                string tcurriculumndesignstrengths = curriculumndesignstrengths.Text.Trim();
                if (string.IsNullOrEmpty(tcurriculumndesignstrengths))
                {
                    curriculumndesignstrengthsfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Strengths  of Curriculum Design and Evaluations");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddCurriculumnDesignStrength(qaNo, tcurriculumndesignstrengths, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    curriculumndesignstrengthsfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        curriculumndesignstrengths.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                curriculumndesignstrengthsfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addStudentsDevelopmentStrenght_Click(object sender, EventArgs e)
        {
            try
            {
                string tstudentdevelopmentstrength = studentdevelopmentstrength.Text.Trim();
                if (string.IsNullOrEmpty(tstudentdevelopmentstrength))
                {
                    studentdevelopmentstrengthfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Strengths  of Staff Development Activities");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddStudentsDevelopmentStrength(qaNo, tstudentdevelopmentstrength, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    studentdevelopmentstrengthfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        studentdevelopmentstrength.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                studentdevelopmentstrengthfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addBenchmarkingStrenght_Click(object sender, EventArgs e)
        {
            try
            {
                string tbenchmarkingstrengths = benchmarkingstrengths.Text.Trim();
                if (string.IsNullOrEmpty(tbenchmarkingstrengths))
                {
                    benchmarkingstrengthsfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Strengths  of  Benchmarking");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddBenchmarkingStrength(qaNo, tbenchmarkingstrengths, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    benchmarkingstrengthsfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        benchmarkingstrengths.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                benchmarkingstrengthsfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addBenchmarkingWeaknesses_Click(object sender, EventArgs e)
        {
            try
            {
                string tbenchmarkingweakness = benchmarkingweakness.Text.Trim();
                if (string.IsNullOrEmpty(tbenchmarkingweakness))
                {
                    benchmarkingweaknessfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Weakness  of  Benchmarking");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddBenchmarkingtWeakness(qaNo, tbenchmarkingweakness, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    benchmarkingweaknessfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        benchmarkingstrengths.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                benchmarkingweaknessfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addGraduatesWeaknesses_Click(object sender, EventArgs e)
        {
            try
            {
                string tgraduateachievementsweakness = graduateachievementsweakness.Text.Trim();
                if (string.IsNullOrEmpty(tgraduateachievementsweakness))
                {
                    graduatesweaknessfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Weakness  of  Grdauates Achievements");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddGraduatesWeakness(qaNo, tgraduateachievementsweakness, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    graduatesweaknessfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        graduateachievementsweakness.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                graduatesweaknessfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addStakeholdersSatisfactionsStrenght_Click(object sender, EventArgs e)
        {
            try
            {
                string tsatisfactionsstrengths = satisfactionsstrengths.Text.Trim();
                if (string.IsNullOrEmpty(tsatisfactionsstrengths))
                {
                    satisfactionsstrengthsfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Strengths  of  Stakeholder Satisfactions");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddStakeholdersSatisfactionsStrength(qaNo, tsatisfactionsstrengths, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    satisfactionsstrengthsfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        satisfactionsstrengths.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                satisfactionsstrengthsfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addStakholdersSatisfactionsWeaknesses_Click(object sender, EventArgs e)
        {
            try
            {
                string tsatisfactionsweakness = satisfactionsweakness.Text.Trim();
                if (string.IsNullOrEmpty(tsatisfactionsweakness))
                {
                    satisfactionsweaknessfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Weakness  of  Stakeholder Satisfactions");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddStakeholdersSatisfactionsWeakness(qaNo, tsatisfactionsweakness, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    satisfactionsweaknessfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        satisfactionsweakness.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                satisfactionsweaknessfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addGraduatesStrenght_Click(object sender, EventArgs e)
        {
            try
            {
                string tgraduatesachievementstrengths = graduatesachievementstrengths.Text.Trim();
                if (string.IsNullOrEmpty(tgraduatesachievementstrengths))
                {
                    graduatesstrengthsfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Strengths  of  Grdauates Achievements");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddGraduatesStrength(qaNo, tgraduatesachievementstrengths, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    graduatesstrengthsfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        graduatesachievementstrengths.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                graduatesweaknessfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addStudentsDevelopmentWeaknesses_Click(object sender, EventArgs e)
        {
            try
            {
                string tstudentsdevelopmentweakness = studentsdevelopmentweakness.Text.Trim();
                if (string.IsNullOrEmpty(tstudentsdevelopmentweakness))
                {
                    studentsdevelopmentweaknessfeeback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Weakness  of Staff Development Activities");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddStudentsDevelopmentWeakness(qaNo, tstudentsdevelopmentweakness, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    studentsdevelopmentweaknessfeeback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        studentsdevelopmentweakness.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                studentsdevelopmentweaknessfeeback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addCurriculumnDesignWeaknesses_Click(object sender, EventArgs e)
        {
            try
            {
                string tcurriculumndesignweakness = curriculumndesignweakness.Text.Trim();
                if (string.IsNullOrEmpty(tcurriculumndesignweakness))
                {
                    curriculumndesignweaknessfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Weakness  of Curriculum Design and Evaluations");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddCurriculumnDesignWeakness(qaNo, tcurriculumndesignweakness, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    curriculumndesignweaknessfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        curriculumndesignweakness.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                curriculumndesignweaknessfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addDidacticWeaknesses_Click(object sender, EventArgs e)
        {
            try
            {
                string tdidacticweaknesses = didacticweaknesses.Text.Trim();
                if (string.IsNullOrEmpty(tdidacticweaknesses))
                {
                    didacticweaknessesfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Weakness of your other didactic and pedagogical approaches of the academic programme");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddOtherDidecticWeaknesses(qaNo, tdidacticweaknesses, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    didacticweaknessesfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        outcomeweaknesses.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                didacticweaknessesfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addOrganizationStrength_Click(object sender, EventArgs e)
        {
            try
            {
                string torganizationstrength = organizationstrength.Text.Trim();
                if (string.IsNullOrEmpty(torganizationstrength))
                {
                    programorganizationstrengthfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Organization of the Programme Strength");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddProgramOrganizationStrength(qaNo, torganizationstrength, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    programorganizationstrengthfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        outcomeweaknesses.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                programorganizationstrengthfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addassesmenstrength_Click(object sender, EventArgs e)
        {
            try
            {
                string tstudentsassesmentstrength = studentsassesmentstrength.Text.Trim();
                if (string.IsNullOrEmpty(tstudentsassesmentstrength))
                {
                    studentsassessmentfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Key strengths  on Student Assessment on the Programme");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddStudentsAssesmentStrength(qaNo, tstudentsassesmentstrength, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    studentsassessmentfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        outcomeweaknesses.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                studentsassessmentfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addSupportStaffStrenght_Click(object sender, EventArgs e)
        {
            try
            {
                string tqualitysupportstaffstrength = qualitysupportstaffstrength.Text.Trim();
                if (string.IsNullOrEmpty(tqualitysupportstaffstrength))
                {
                    qualitysupportstrengthfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Key strengths  Quality of Support Staff");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddQualityStaffStrength(qaNo, tqualitysupportstaffstrength, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    qualitysupportstrengthfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        qualitysupportstaffstrength.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                qualitysupportstrengthfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addSupportStaffWeaknesses_Click(object sender, EventArgs e)
        {
            try
            {
                string tqualitysupportstaffweakness = qualitysupportstaffweakness.Text.Trim();
                if (string.IsNullOrEmpty(tqualitysupportstaffweakness))
                {
                    qualitysupportweaknessfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Key strengths  Quality of Support Staff");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddQualityStaffWeakness(qaNo, tqualitysupportstaffweakness, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    qualitysupportweaknessfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        qualitysupportstaffweakness.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                qualitysupportweaknessfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addassessmentWeaknesses_Click(object sender, EventArgs e)
        {
            try
            {
                string tstudentassesmentweakness = studentassesmentweakness.Text.Trim();
                if (string.IsNullOrEmpty(tstudentassesmentweakness))
                {
                    studentassessmentweaknessfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Key weakness  on Student Assessment on the Programme");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddStudentsAssesmentWeakness(qaNo, tstudentassesmentweakness, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    studentassessmentweaknessfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        outcomeweaknesses.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                studentassessmentweaknessfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addOrganizationWeaknesses_Click(object sender, EventArgs e)
        {
            try
            {
                string torganizationweakness = organizationweakness.Text.Trim();
                if (string.IsNullOrEmpty(torganizationweakness))
                {
                    organizationweaknessfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Organization of the Programme Weakness");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddProgramOrganizationWeakness(qaNo, torganizationweakness, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    organizationweaknessfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        outcomeweaknesses.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                organizationweaknessfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addStudentAssessment_Click(object sender, EventArgs e)
        {
            try
            {
                bool tsitcats = false;
                if (sitcats.Checked == true)
                {
                    tsitcats = true;
                }
                bool ttakecats = false;
                if (takecats.Checked == true)
                {
                    ttakecats = true;
                }
                bool ttermpapers = false;
                if (termpapers.Checked == true)
                {
                    ttermpapers = true;
                }
                bool tsitinexams = false;
                if (sitinexams.Checked == true)
                {
                    tsitinexams = true;
                }
                bool tresitexams = false;
                if (resitexams.Checked == true)
                {
                    tresitexams = true;
                }
                bool tretakeexams = false;
                if (retakeexams.Checked == true)
                {
                    tretakeexams = true;
                }
                bool tsupexams = false;
                if (supexams.Checked == true)
                {
                    tsupexams = true;
                }
                bool tusegpasystem = false;
                if (usegpasystem.Checked == true)
                {
                    tusegpasystem = true;
                }
                string texamreleasetime = examreleasetime.Text.Trim();
                if (string.IsNullOrEmpty(texamreleasetime))
                {
                    assessmentfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Exams Release Durations");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string status = new Config().ObjNav()
                                .AddStudentsAssessment(qaNo, tsitcats, ttakecats, ttermpapers, tsitinexams, tresitexams, tretakeexams, tsupexams, texamreleasetime, tusegpasystem, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    assessmentfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        outcomeweaknesses.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                assessmentfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addProgrammeGrading_Click(object sender, EventArgs e)
        {
            try
            {
                string tgradAscorerange = gradAscorerange.Text.Trim();
                string tgradeAgpapoints = gradeAgpapoints.Text.Trim();
                string tgradeBscorerange = gradeBscorerange.Text.Trim();
                string tgradeBgpapoints = gradeBgpapoints.Text.Trim();
                string tgradeCscorerange = gradeBscorerange.Text.Trim();
                string tgradeCgpapoints = gradeCgpapoints.Text.Trim();
                string tgradeDscorerange = gradeDscorerange.Text.Trim();
                string tgradeDgpapoints = gradeDgpapoints.Text.Trim();
                string tgradeEscorerange = gradeEscorerange.Text.Trim();
                string tgradeEgpapoints = gradeEgpapoints.Text.Trim();

                if (string.IsNullOrEmpty(tgradAscorerange))
                {
                    gradingsystemfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Internship Strenght");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string universityNumber = Convert.ToString(Session["UniversityCode"]);
                    string status = new Config().ObjNav()
                                .AddProgrammeGrading(qaNo, universityNumber, tgradAscorerange, tgradeAgpapoints, tgradeBscorerange, tgradeBgpapoints, tgradeCscorerange, tgradeCgpapoints, tgradeDscorerange,
                                tgradeDgpapoints, tgradeEscorerange, tgradeEgpapoints);
                    string[] info = status.Split('*');
                    gradingsystemfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        outcomeweaknesses.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                gradingsystemfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addAntiPlagiarismDetails_Click(object sender, EventArgs e)
        {
            try
            {
                bool tpassfailcriteria = false;
                if (passfailcriteria.Checked == true)
                {
                    tpassfailcriteria = true;
                }
                bool tmemocommunication = false;
                if (memocommunication.Checked == true)
                {
                    tmemocommunication = true;
                }
                bool tnewslettercommunications = false;
                if (newslettercommunications.Checked == true)
                {
                    tnewslettercommunications = true;
                }
                bool tmeetingscommunications = false;
                if (meetingscommunications.Checked == true)
                {
                    tmeetingscommunications = true;
                }
                bool tconferencecommunication = false;
                if (conferencecommunication.Checked == true)
                {
                    tconferencecommunication = true;
                }
                bool tannouncementscommunication = false;
                if (announcementscommunication.Checked == true)
                {
                    tannouncementscommunication = true;
                }
                bool tstudentshandbook = false;
                if (studentshandbook.Checked == true)
                {
                    tstudentshandbook = true;
                }
                bool tstudentswebsite = false;
                if (studentswebsite.Checked == true)
                {
                    tstudentswebsite = true;
                }
                bool tcapturingcompalints = false;
                if (capturingcompalints.Checked == true)
                {
                    tcapturingcompalints = true;
                }
                bool texaminationboard = false;
                if (examinationboard.Checked == true)
                {
                    texaminationboard = true;
                }
                bool tantiplagiarismpolicy = false;
                if (antiplagiarismpolicy.Checked == true)
                {
                    tantiplagiarismpolicy = true;
                }
                bool tantiplagiarismsoftware = false;
                if (antiplagiarismsoftware.Checked == true)
                {
                    tantiplagiarismsoftware = true;
                }
                bool tcurbantiplagiarims = false;
                if (curbantiplagiarims.Checked == true)
                {
                    tcurbantiplagiarims = true;
                }
                string totherspecify = otherspecify.Text.Trim();
                if (string.IsNullOrEmpty(totherspecify))
                {
                    antiplagiarismfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Exams Release Durations");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string universityNumber = Convert.ToString(Session["UniversityCode"]);
                    string status = new Config().ObjNav()
                                .AddAntiPlagiarismDetails(qaNo, universityNumber, tpassfailcriteria, tmemocommunication, tnewslettercommunications, tmeetingscommunications, tconferencecommunication,
                               tannouncementscommunication, tstudentshandbook, tstudentswebsite, totherspecify, tcapturingcompalints, texaminationboard, tantiplagiarismpolicy,
                               tantiplagiarismsoftware, tcurbantiplagiarims);
                    string[] info = status.Split('*');
                    antiplagiarismfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        outcomeweaknesses.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                antiplagiarismfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addAcademicLeaderDetails_Click(object sender, EventArgs e)
        {
            try
            {
                string tidnumber = idnumber.Text.Trim();
                string tfullnames = fullnames.Text.Trim();
                string tteachingexperience = teachingexperience.Text.Trim();
                string tbachelorsspecialization = bachelorsspecialization.Text.Trim();
                string tmastersspecialization = mastersspecialization.Text.Trim();
                string tdoctoratespecialization = doctoratespecialization.Text.Trim();
                string ttermsofemployment = termsofemployment.Text.Trim();
                string thighestacademiclevel = highestacademiclevel.Text.Trim();

                if (string.IsNullOrEmpty(thighestacademiclevel))
                {
                    academicleaderfeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Internship Strenght");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string universityNumber = Convert.ToString(Session["UniversityCode"]);
                    string status = new Config().ObjNav()
                                .AddAcademicLeaderDetails(qaNo, tidnumber, tfullnames, tteachingexperience, tbachelorsspecialization, tmastersspecialization, tdoctoratespecialization
                                , ttermsofemployment, thighestacademiclevel, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                    string[] info = status.Split('*');
                    academicleaderfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        outcomeweaknesses.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                academicleaderfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addNonTeachingStaff_Click(object sender, EventArgs e)
        {
            try
            {
                string tlabaratorystaff = labaratorystaff.Text.Trim();
                string tcomputerlabstaff = computerlabstaff.Text.Trim();
                string tadministrativesatff = administrativesatff.Text.Trim();
                string tworkshopstaff = workshopstaff.Text.Trim();
                string teducationcomstaff = educationcomstaff.Text.Trim();
                if (string.IsNullOrEmpty(teducationcomstaff))
                {
                    nonteachingstafffeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for Internship Strenght");
                }
                else
                {
                    string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                    string universityNumber = Convert.ToString(Session["UniversityCode"]);
                    string status = new Config().ObjNav()
                                .AddNonTeachingStaffSize(qaNo, tlabaratorystaff, tcomputerlabstaff, tadministrativesatff, tworkshopstaff, teducationcomstaff, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));

                    string[] info = status.Split('*');
                    nonteachingstafffeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        outcomeweaknesses.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                nonteachingstafffeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addStudentProfile_Click(object sender, EventArgs e)
        {
            try
            {
                bool tprospectusforprogramme = false;
                if (prospectusforprogramme.Checked == true)
                {
                    tprospectusforprogramme = true;
                }
                bool tstudentsorientation = false;
                if (studentsorientation.Checked == true)
                {
                    tstudentsorientation = true;
                }
                bool tstudentscoaching = false;
                if (studentscoaching.Checked == true)
                {
                    tstudentscoaching = true;
                }
                bool tpeercounselling = false;
                if (peercounselling.Checked == true)
                {
                    tpeercounselling = true;
                }
                bool topenforaproffessional = false;
                if (openforaproffessional.Checked == true)
                {
                    topenforaproffessional = true;
                }
                bool topenforarelevantindustry = false;
                if (openforarelevantindustry.Checked == true)
                {
                    topenforarelevantindustry = true;
                }
                bool tcantwithstudents = false;
                if (cantwithstudents.Checked == true)
                {
                    tcantwithstudents = true;
                }
                bool tremedialpreventiveactions = false;
                if (remedialpreventiveactions.Checked == true)
                {
                    tremedialpreventiveactions = true;
                }
                bool torientationfirstyearstudents = false;
                if (orientationfirstyearstudents.Checked == true)
                {
                    torientationfirstyearstudents = true;
                }
                bool torientationdavancedstudents = false;
                if (orientationdavancedstudents.Checked == true)
                {
                    torientationdavancedstudents = true;
                }
                bool tpotentailstudentsengaged = false;
                if (potentailstudentsengaged.Checked == true)
                {
                    tpotentailstudentsengaged = true;
                }
                bool tpotentialstudentsevaluate = false;
                if (potentialstudentsevaluate.Checked == true)
                {
                    tpotentialstudentsevaluate = true;
                }
                bool tdepartmentfacilities = false;
                if (departmentfacilities.Checked == true)
                {
                    tdepartmentfacilities = true;
                }
                bool tcentrallyfacilities = false;
                if (centrallyfacilities.Checked == true)
                {
                    tcentrallyfacilities = true;
                }
                bool tcourseoptionadvice = false;
                if (courseoptionadvice.Checked == true)
                {
                    tcourseoptionadvice = true;
                }
                bool tinterruptionadvice = false;
                if (interruptionadvice.Checked == true)
                {
                    tinterruptionadvice = true;
                }
                bool tcareerprespectsinformation = false;
                if (careerprespectsinformation.Checked == true)
                {
                    tcareerprespectsinformation = true;
                }
                bool tstudentslabourmarket = false;
                if (studentslabourmarket.Checked == true)
                {
                    tstudentslabourmarket = true;
                }
                bool test = false;
                string totherspecifys = otherspecifys.Text.Trim();
                string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                string status = new Config().ObjNav()
                            .AddStudentSupportDetails(qaNo, tprospectusforprogramme, tstudentsorientation, tstudentscoaching, tpeercounselling, topenforaproffessional, topenforarelevantindustry, tcantwithstudents, tremedialpreventiveactions, totherspecifys,
                            torientationfirstyearstudents, torientationdavancedstudents, tpotentailstudentsengaged, tpotentialstudentsevaluate, tdepartmentfacilities, tcentrallyfacilities, tcourseoptionadvice,
                            tinterruptionadvice, tcareerprespectsinformation, tstudentslabourmarket, test, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                string[] info = status.Split('*');
                supportstudentsfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    // objectiveinstructions.Text = "";
                }

            }
            catch (Exception y)
            {
                supportstudentsfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addStudentsEvaluations_Click(object sender, EventArgs e)
        {
            try
            {
                bool tevaluateprogramme = false;
                if (evaluateprogramme.Checked == true)
                {
                    tevaluateprogramme = true;
                }
                bool tevaluateprogrammefacilities = false;
                if (evaluateprogrammefacilities.Checked == true)
                {
                    tevaluateprogrammefacilities = true;
                }
                bool tevaluatedeliverymethods = false;
                if (evaluatedeliverymethods.Checked == true)
                {
                    tevaluatedeliverymethods = true;
                }
                bool tevaluateinsturtors = false;
                if (evaluateinsturtors.Checked == true)
                {
                    tevaluateinsturtors = true;
                }
                bool tstudentsevaluationoutcomes = false;
                if (studentsevaluationoutcomes.Checked == true)
                {
                    tstudentsevaluationoutcomes = true;
                }
                bool tstaffevaluationoutcomes = false;
                if (staffevaluationoutcomes.Checked == true)
                {
                    tstaffevaluationoutcomes = true;
                }
                bool tsemesterly = false;
                if (semesterly.Checked == true)
                {
                    tsemesterly = true;
                }
                bool tsemiannuallys = false;
                if (semiannuallys.Checked == true)
                {
                    tsemiannuallys = true;
                }
                bool tannuallys = false;
                if (annuallys.Checked == true)
                {
                    tannuallys = true;
                }
                bool tonceprogramme = false;
                if (onceprogramme.Checked == true)
                {
                    tonceprogramme = true;
                }
                bool tnever = false;
                if (never.Checked == true)
                {
                    tnever = true;
                }
                bool tstaffevaluationoutcome = false;
                if (studentsthefolloingsem.Checked == true)
                {
                    tstaffevaluationoutcome = true;
                }
                bool tstudentsonceprogram = false;
                if (studentsonceprogram.Checked == true)
                {
                    tstudentsonceprogram = true;
                }
                bool tstudentsnever = false;
                if (studentsnever.Checked == true)
                {
                    tstudentsnever = true;
                }
                bool tstafffollowingsem = false;
                if (stafffollowingsem.Checked == true)
                {
                    tstafffollowingsem = true;
                }
                bool tstaffonceprogramme = false;
                if (staffonceprogramme.Checked == true)
                {
                    tstaffonceprogramme = true;
                }
                bool tstaffnever = false;
                if (staffnever.Checked == true)
                {
                    tstaffnever = true;
                }
                string totherspecifyevaluation = otherspecifyevaluation.Text.Trim();
                string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                string status = new Config().ObjNav()
                            .AddStudentEvaluation(qaNo, tevaluateprogramme, tevaluateprogrammefacilities, tevaluatedeliverymethods, tevaluateinsturtors, tstudentsevaluationoutcomes, tstaffevaluationoutcomes, totherspecifyevaluation, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                string[] info = status.Split('*');
                studentevaluationfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    outcomeweaknesses.Text = "";
                }

            }
            catch (Exception y)
            {
                studentevaluationfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addCurriculumnEvaluation_Click(object sender, EventArgs e)
        {
            try
            {
                bool tneedassessment = false;
                if (needassessment.Checked == true)
                {
                    tneedassessment = true;
                }
                bool tnicheofuniversity = false;
                if (nicheofuniversity.Checked == true)
                {
                    tnicheofuniversity = true;
                }
                bool temployertracerstudies = false;
                if (employertracerstudies.Checked == true)
                {
                    temployertracerstudies = true;
                }
                bool tbenchmarkinginstructions = false;
                if (benchmarkinginstructions.Checked == true)
                {
                    tbenchmarkinginstructions = true;
                }
                bool tcollaboratiionwithinternational = false;
                if (collaboratiionwithinternational.Checked == true)
                {
                    tcollaboratiionwithinternational = true;
                }
                bool tcourselevelevaluation = false;
                if (courselevelevaluation.Checked == true)
                {
                    tcourselevelevaluation = true;
                }
                bool tcurriculmnevaluationlevel = false;
                if (curriculmnevaluationlevel.Checked == true)
                {
                    tcurriculmnevaluationlevel = true;
                }
                bool tstudentsinvolvedevaluation = false;
                if (studentsinvolvedevaluation.Checked == true)
                {
                    tstudentsinvolvedevaluation = true;
                }
                bool tstudentslecturersknow = false;
                if (studentslecturersknow.Checked == true)
                {
                    tstudentslecturersknow = true;
                }
                bool tappliedsubsequentreviews = false;
                if (appliedsubsequentreviews.Checked == true)
                {
                    tappliedsubsequentreviews = true;
                }
                string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                string status = new Config().ObjNav()
                            .AddCurriculumnDesignDetails(qaNo, tneedassessment, tnicheofuniversity, temployertracerstudies, tbenchmarkinginstructions, tcollaboratiionwithinternational, tcurriculmnevaluationlevel, tcourselevelevaluation, tstudentsinvolvedevaluation, tstudentslecturersknow, tappliedsubsequentreviews, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                string[] info = status.Split('*');
                curriculumnevaluationfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    outcomeweaknesses.Text = "";
                }

            }
            catch (Exception y)
            {
                curriculumnevaluationfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addStaffDevelopmentActivities_Click(object sender, EventArgs e)
        {
            try
            {
                bool tcurriculumndesign = false;
                if (curriculumndesign.Checked == true)
                {
                    tcurriculumndesign = true;
                }
                bool ttestdevelopment = false;
                if (testdevelopment.Checked == true)
                {
                    ttestdevelopment = true;
                }
                bool tteachingskills = false;
                if (teachingskills.Checked == true)
                {
                    tteachingskills = true;
                }
                bool tictintergration = false;
                if (ictintergration.Checked == true)
                {
                    tictintergration = true;
                }
                bool textendteachingabilities = false;
                if (extendteachingabilities.Checked == true)
                {
                    textendteachingabilities = true;
                }
                bool tpursuefurtherstudies = false;
                if (pursuefurtherstudies.Checked == true)
                {
                    tpursuefurtherstudies = true;
                }

                string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                string status = new Config().ObjNav()
                            .AddStaffDevelopmentActivities(qaNo, tcurriculumndesign, ttestdevelopment, tteachingskills, tictintergration, textendteachingabilities, tpursuefurtherstudies, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                string[] info = status.Split('*');
                staffdevelopmentfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    outcomeweaknesses.Text = "";
                }

            }
            catch (Exception y)
            {
                staffdevelopmentfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addBenchmarkingDetails_Click(object sender, EventArgs e)
        {
            try
            {
                bool tpolicybenchmarking = false;
                if (policybenchmarking.Checked == true)
                {
                    tpolicybenchmarking = true;
                }
                bool tbenchmarkinganalysed = false;
                if (benchmarkinganalysed.Checked == true)
                {
                    tbenchmarkinganalysed = true;
                }
                bool tbenchmarkingusedbymarnagement = false;
                if (benchmarkingusedbymarnagement.Checked == true)
                {
                    tbenchmarkingusedbymarnagement = true;
                }

                string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                string status = new Config().ObjNav()
                            .AddBenchmarking(qaNo, tpolicybenchmarking, tbenchmarkinganalysed, tbenchmarkingusedbymarnagement, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                string[] info = status.Split('*');
                benchmarkingfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    outcomeweaknesses.Text = "";
                }

            }
            catch (Exception y)
            {
                benchmarkingfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addGraduatesAcheievement_Click(object sender, EventArgs e)
        {
            try
            {
                bool ttrackingprogress = false;
                if (trackingprogress.Checked == true)
                {
                    ttrackingprogress = true;
                }
                bool tdropoutsawareness = false;
                if (dropoutsawareness.Checked == true)
                {
                    tdropoutsawareness = true;
                }
                bool tdropoutreasonsdocumented = false;
                if (dropoutreasonsdocumented.Checked == true)
                {
                    tdropoutreasonsdocumented = true;
                }
                bool ttrackinginforused = false;
                if (trackinginforused.Checked == true)
                {
                    ttrackinginforused = true;
                }
                bool temploymentrateawareness = false;
                if (employmentrateawareness.Checked == true)
                {
                    temploymentrateawareness = true;
                }
                bool tbelow25unemployment = false;
                if (below25unemployment.Checked == true)
                {
                    tbelow25unemployment = true;
                }
                bool tbetween2550unemplyment = false;
                if (between2550unemplyment.Checked == true)
                {
                    tbetween2550unemplyment = true;
                }
                bool tbetween5175unemployment = false;
                if (between5175unemployment.Checked == true)
                {
                    tbetween5175unemployment = true;
                }
                bool tover75unemployment = false;
                if (over75unemployment.Checked == true)
                {
                    tover75unemployment = true;
                }
                string tfinancialchallenges = financialchallenges.Text.Trim();
                string tpoorsecondary = poorsecondary.Text.Trim();
                string tconflictwithwork = conflictwithwork.Text.Trim();
                string texaminationchallenges = examinationchallenges.Text.Trim();
                string tlackofqualitytime = lackofqualitytime.Text.Trim();
                string tlackofpeersupport = lackofpeersupport.Text.Trim();
                string thealthissues = healthissues.Text.Trim();
                string tdisciplinarygrounds = disciplinarygrounds.Text.Trim();
                string totherspecifygraduates = otherspecifygraduates.Text.Trim();
                string tlabaratorystaff = labaratorystaff.Text.Trim();
                string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                string status = new Config().ObjNav()
                            .AddGraduatesAchievement(qaNo, ttrackingprogress, tdropoutsawareness, tdropoutreasonsdocumented, tfinancialchallenges, tpoorsecondary, tconflictwithwork, texaminationchallenges,
                           tlackofqualitytime, tlackofpeersupport, thealthissues, tdisciplinarygrounds, totherspecifygraduates, ttrackinginforused, temploymentrateawareness,
                           tbelow25unemployment, tbetween2550unemplyment, tbetween5175unemployment, tover75unemployment, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                string[] info = status.Split('*');
                graduatefeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    outcomeweaknesses.Text = "";
                }

            }
            catch (Exception y)
            {
                graduatefeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addStakeholdersSatisfaction_Click(object sender, EventArgs e)
        {
            try
            {
                bool tcourseopinion = false;
                if (courseopinion.Checked == true)
                {
                    tcourseopinion = true;
                }
                bool tprogrammeopinion = false;
                if (programmeopinion.Checked == true)
                {
                    tprogrammeopinion = true;
                }
                bool tteachingopinion = false;
                if (teachingopinion.Checked == true)
                {
                    tteachingopinion = true;
                }
                bool texaminationsopinion = false;
                //if (examinationsopinion.Checked == true)
                //{
                //    texaminationsopinion = true;
                //}
                bool tstudentscomplaints = false;
                if (studentscomplaints.Checked == true)
                {
                    tstudentscomplaints = true;
                }
                bool tcomplaintsfeedback = false;
                if (complaintsfeedback.Checked == true)
                {
                    tcomplaintsfeedback = true;
                }
                bool tgraduationopinion = false;
                if (graduationopinion.Checked == true)
                {
                    tgraduationopinion = true;
                }
                bool tannallyinterview = false;
                if (annallyinterview.Checked == true)
                {
                    tannallyinterview = true;
                }
                bool teverytwoyears = false;
                if (everytwoyears.Checked == true)
                {
                    tcomplaintsfeedback = true;
                }
                bool tneverinterviewed = false;
                if (neverinterviewed.Checked == true)
                {
                    tneverinterviewed = true;
                }
                bool talumniprogrammereview = false;
                if (alumniprogrammereview.Checked == true)
                {
                    talumniprogrammereview = true;
                }
                bool tlabourmarketcontacts = false;
                if (labourmarketcontacts.Checked == true)
                {
                    tlabourmarketcontacts = true;
                }
                bool tlabourmarketfeedback = false;
                if (labourmarketfeedback.Checked == true)
                {
                    tlabourmarketfeedback = true;
                }
                bool tlabourmarketfeedbackutilization = false;
                if (labourmarketfeedbackutilization.Checked == true)
                {
                    tlabourmarketfeedbackutilization = true;
                }
                string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                string status = new Config().ObjNav()
                            .AddStakeholdersSatisfaction(qaNo, tcourseopinion, tprogrammeopinion, tteachingopinion, texaminationsopinion, tstudentscomplaints, tcomplaintsfeedback,
                            tcomplaintsfeedback, tgraduationopinion, tannallyinterview, teverytwoyears, tneverinterviewed, talumniprogrammereview, tlabourmarketcontacts, tlabourmarketfeedback, tlabourmarketfeedbackutilization, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                string[] info = status.Split('*');
                stakeholderssatisfactionfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    outcomeweaknesses.Text = "";
                }

            }
            catch (Exception y)
            {
                stakeholderssatisfactionfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addTeachingEquipments_Click(object sender, EventArgs e)
        {
            try
            {
                string titemname = itemname.Text.Trim();
                string titemnumber = itemnumber.Text.Trim();
                string titemsusage = itemsusage.SelectedValue;
                string titemusageshared = "";
                string qaNo = Request.QueryString["QualityAuditNo"].Trim();
                string status = new Config().ObjNav()
                        .AddTeachingEquipments(qaNo, titemname, titemnumber, titemsusage, titemusageshared, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                string[] info = status.Split('*');
                feedbackequipment.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    otherStakeHolderName.Text = "";
                }
            }
            catch (Exception y)
            {
                feedbackequipment.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
    }
}

