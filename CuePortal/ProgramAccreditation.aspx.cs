using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using System.Configuration;

namespace CicPortal
{
    public partial class ProgramAccreditation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {

                var nav = Config.ReturnNav();
                var campuses = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                campus.DataSource = campuses;
                campus.DataValueField = "No";
                campus.DataTextField = "Description";
                campus.DataBind();

                campusname.DataSource = campuses;
                campusname.DataValueField = "No";
                campusname.DataTextField = "Description";
                campusname.DataBind();               

                var domains = nav.programdomains;
                programDomain.DataSource = domains;
                programDomain.DataValueField = "Code";
                programDomain.DataTextField = "Description";
                programDomain.DataBind();

                editdomain.DataSource = domains;
                editdomain.DataValueField = "Code";
                editdomain.DataTextField = "Description";
                editdomain.DataBind();

                List<string> classifications = new List<string>();
                classifications.Add("--Select--");
                classifications.Add("First Class");
                classifications.Add("Upper Second Class");
                classifications.Add("Lower Second Class");
                classifications.Add("Pass");
                classifications.Add("No classification");
                txtclassifications.DataSource = classifications;
                txtclassifications.DataBind();

                List<string> classifications1 = new List<string>();
                classifications.Add("--Select--");
                classifications1.Add("First Class");
                classifications1.Add("Upper Second Class");
                classifications1.Add("Lower Second Class");
                classifications1.Add("Pass");
                classifications1.Add("No classification");
                editclassification.DataSource = classifications1;
                editclassification.DataBind();



                List<string> programLevels = new List<string>();
                programLevels.Add("--Select--");
                programLevels.Add("Bachelors");
                programLevels.Add("Masters");
                programLevels.Add("Doctorate");
                programLevels.Add("Postgraduate");
                programLevels.Add("Diploma");
                programLevels.Add("Certificate");
                programLevel.DataSource = programLevels;
                programLevel.DataBind();

                List<string> editlevels = new List<string>();
                editlevels.Add("--Select--");
                editlevels.Add("Bachelors");
                editlevels.Add("Masters");
                editlevels.Add("Doctorate");
                editlevels.Add("Postgraduate");
                editlevels.Add("Diploma");
                editlevels.Add("Certificate");
                editlevel.DataSource = editlevels;
                editlevel.DataBind();

                List<string> rationaleCategories = new List<string>();
                rationaleCategories.Add("Needs assessment/market survey/situation analysis");
                rationaleCategories.Add("Stakeholders Involvement");
                rationaleCategories.Add("Justification of the need for the programme");
                rationaleCategory.DataSource = rationaleCategories;
                rationaleCategory.DataBind();
                editProgramRationaleCategory.DataSource = rationaleCategories;
                editProgramRationaleCategory.DataBind();

                var deliveryModes = nav.DeliveryModeSetup.Where(r => r.Course == false);
                deliveryMode.DataSource = deliveryModes;
                deliveryMode.DataValueField = "Code";
                deliveryMode.DataTextField = "Description";
                deliveryMode.DataBind();

                //var myModes = nav.DeliveryModeSetup.Where(r => r.Course == true);
                //instructionalMode.DataSource = myModes;
                //instructionalMode.DataValueField = "Code";
                //instructionalMode.DataTextField = "Description";
                //instructionalMode.DataBind();

                var courseYears = nav.CourseYears;
                yearCode.DataSource = courseYears;
                yearCode.DataTextField = "Description";
                yearCode.DataValueField = "Code";
                yearCode.DataBind();
                editCourseYearCode.DataSource = courseYears;
                editCourseYearCode.DataTextField = "Description";
                editCourseYearCode.DataValueField = "Code";
                editCourseYearCode.DataBind();

                var courseCategories = nav.CourseCategories;
                courseCategory.DataSource = courseCategories;
                courseCategory.DataTextField = "Description";
                courseCategory.DataValueField = "Code";
                courseCategory.DataBind();

                editCourseCategory.DataSource = courseCategories;
                editCourseCategory.DataTextField = "Description";
                editCourseCategory.DataValueField = "Code";
                editCourseCategory.DataBind();
                // 
                try
                {
                    string ac = Request.QueryString["accreditationNo"].Trim();
                    string outcomes = new Config().ObjNav().FnGetProgrammeOutcomes(ac);
                    List<Student> list = new List<Student>();
                    String[] info = outcomes.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                    if (info != null)
                    {
                        foreach (var allInfo in info)
                        {
                            String[] arr = allInfo.Split('*');
                            Student itm = new Student();
                            itm.Name = arr[1];
                            itm.IdNumber = arr[0];
                            list.Add(itm);
                        }
                    }
                    coloOutcome.DataSource = list;
                    coloOutcome.DataTextField = "Name";
                    coloOutcome.DataValueField = "IdNumber";
                    coloOutcome.DataBind();

                    editColoOutcome.DataSource = list;
                    editColoOutcome.DataTextField = "Name";
                    editColoOutcome.DataValueField = "IdNumber";
                    editColoOutcome.DataBind();
                }
                catch (Exception)
                {


                }
                try
                {
                    var units = nav.ProgramUnits.Where(r => r.Application_No == Request.QueryString["accreditationNo"].Trim());
                    List<Student> list = new List<Student>();
                    foreach (var item in units)
                    {
                        Student itm = new Student();
                        itm.Name = item.Course_Code + " :" + item.Course_Title;
                        itm.IdNumber = item.Course_Code;
                        list.Add(itm);
                    }
                    
                    coloCourse.DataSource = list;
                    coloCourse.DataTextField = "Name";
                    coloCourse.DataValueField = "IdNumber";
                    coloCourse.DataBind();

                    coursescodesref.DataSource = units;
                    coursescodesref.DataTextField = "Course_Title";
                    coursescodesref.DataValueField = "Course_Code";
                    coursescodesref.DataBind();

                    editColoUnit.DataSource = units;
                    editColoUnit.DataTextField = "Course_Title";
                    editColoUnit.DataValueField = "Course_Code";
                    editColoUnit.DataBind();

                    editscoursecode.DataSource = units;
                    editscoursecode.DataTextField = "Course_Title";
                    editscoursecode.DataValueField = "Course_Code";
                    editscoursecode.DataBind();

                    bookCourse.DataSource = units;
                    bookCourse.DataTextField = "Course_Title";
                    bookCourse.DataValueField = "Course_Code";
                    bookCourse.DataBind();
                    editBookCourse.DataSource = units;
                    editBookCourse.DataTextField = "Course_Title";
                    editBookCourse.DataValueField = "Course_Code";
                    editBookCourse.DataBind();
                }
                catch (Exception)
                {



                }
                try
                {
                    string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                    if (accreditationNo.Length > 0)
                    {
                        string empNo = Convert.ToString(Session["UniversityCode"]);

                        philosophy.Text = new Config().ObjNav().FnGetProgrammePhilosopy(accreditationNo, empNo);
                        //philosophy.Text = Regex.Replace(phylosophy, @"[^0-9a-zA-Z]+", " ");

                        admission.Text = new Config().ObjNav().FnGetProgrammeAdmissionRequirements(accreditationNo, empNo);
                        //admission.Text = Regex.Replace(admissions, @"[^0-9a-zA-Z]+", " ");

                        goal.Text = new Config().ObjNav().FnGetProgrammeGoal(accreditationNo, empNo);
                        //goal.Text = Regex.Replace(goals, @"[^0-9a-zA-Z]+", " ");

                        coursereqirement.Text = new Config().ObjNav().FnGetProgrammeCourseRequirement(accreditationNo, empNo);
                        //coursereqirement.Text = Regex.Replace(coursereq, @"[^0-9a-zA-Z]+", " ");

                        courseevaluations.Text = new Config().ObjNav().FnGetProgrammeCourseEvaluation(accreditationNo, empNo);
                        //courseevaluations.Text = Regex.Replace(courseevaluation, @"[^0-9a-zA-Z]+", " ");

                        requlations.Text = new Config().ObjNav().FnGetProgrammeRequirementCreditTransfer(accreditationNo, empNo);
                        //requlations.Text = Regex.Replace(requlationsoncredit, @"[^0-9a-zA-Z]+", " ");

                        var studentasspolicy = new Config().ObjNav().FnGetProgrammeStudentAssPolicy(accreditationNo, empNo);
                        //if (studentasspolicy == "Continuous Assessment Tests")
                        //{
                        //    cats.Checked = true;
                        //}
                        //else if (studentasspolicy == "End-Trimester/Quarter/Semester")
                        //{
                        //    semester.Checked = true;
                        //}
                        //else if (studentasspolicy == "Practicals")
                        //{
                        //    practicals.Checked = true;
                        //}
                        //else if (studentasspolicy == "Other Assessments")
                        //{
                        //    others.Checked = true;
                        //}

                        examinations.Text = new Config().ObjNav().FnGetProgrammeExaminationRequlations(accreditationNo, empNo);
                        //examinations.Text = Regex.Replace(examinationrequlations, @"[^0-9a-zA-Z]+", " ");

                        moderations.Text = new Config().ObjNav().FnGetProgrammeModerationOfExaminations(accreditationNo, empNo);
                        //moderations.Text = Regex.Replace(moderation, @"[^0-9a-zA-Z]+", " ");

                        management.Text = new Config().ObjNav().FnGetProgrammeProgramManagement(accreditationNo, empNo);
                        //management.Text = Regex.Replace(programmngt, @"[^0-9a-zA-Z]+", " ");

                        graduation.Text = new Config().ObjNav().FnGetProgrammeGraduationRequirements(accreditationNo, empNo);
                        //graduation.Text = Regex.Replace(graduationreq, @"[^0-9a-zA-Z]+", " ");

                        description.Text = new Config().ObjNav().FnGetProgrammeDescriptionOfThesis(accreditationNo, empNo);
                        //description.Text = Regex.Replace(thesis, @"[^0-9a-zA-Z]+", " ");


                        string allData = new Config().ObjNav().FnGetOpenPrograms(accreditationNo, empNo);
                        String[] info = allData.Split(new string[] { ":" }, StringSplitOptions.RemoveEmptyEntries);
                        if (info != null)
                        {
                            foreach (var data in info)
                            {
                                String[] arr = data.Split('*');
                                campus.SelectedValue = arr[0];
                                programName.Text = arr[1];
                                isEditing.Visible = true;
                                isEditing.InnerText = "Your are now making changes to the programme:" + arr[1];
                                programDuration.Text = arr[2];
                                programDomain.SelectedValue = arr[3];
                                programLevel.SelectedValue = arr[4];
                                totalcredit.Text = arr[5];
                                totalcourse.Text = arr[6];
                                if (arr[7] == "Yes")
                                {
                                    specializationareas.Checked = true;
                                }
                                else
                                {
                                    specializationareas.Checked = false;
                                }

                                if (arr[8] == "Yes")
                                {
                                    cats.Checked = true;
                                }
                                if (arr[9] == "Yes")
                                {
                                    semester.Checked = true;
                                }
                                if (arr[10] == "Yes")
                                {
                                    practicals.Checked = true;
                                }
                                if (arr[11] == "Yes")
                                {
                                    others.Checked = true;
                                }
                            }
                        }

                        List<Student> list = new List<Student>();
                        var preq = nav.ProgrammeCourseMatrix.Where(x => x.Application_No == accreditationNo).ToList();
                        foreach (var item in preq)
                        {
                            Student sd = new Student();
                            sd.Name = item.Course_Title;
                            sd.Name = item.Course_Code + ' '+ item.Course_Title;
                            list.Add(sd);
                        }
                        prerequisitie.DataSource = list;
                        prerequisitie.DataTextField = "Name";
                        prerequisitie.DataValueField = "PhoneNumber";
                        prerequisitie.DataBind();
                    }
                }
                catch (Exception t)
                {

                }

            }
        }
        protected void CourseUnits_SelectedIndexChanged(object sender, EventArgs e)
        {
            UpdateProgrammeCourses();
        }

        public void UpdateProgrammeCourses()
        {
            var nav = Config.ReturnNav();
            var units = nav.ProgramUnits.Where(r => r.Application_No == Request.QueryString["accreditationNo"].Trim());
            coloCourse.DataSource = units;
            coloCourse.DataTextField = "Course_Title";
            coloCourse.DataValueField = "Course_Code";
            coloCourse.DataBind();

            coursescodesref.DataSource = units;
            coursescodesref.DataTextField = "Course_Title";
            coursescodesref.DataValueField = "Course_Code";
            coursescodesref.DataBind();

            editColoUnit.DataSource = units;
            editColoUnit.DataTextField = "Course_Title";
            editColoUnit.DataValueField = "Course_Code";
            editColoUnit.DataBind();

            editscoursecode.DataSource = units;
            editscoursecode.DataTextField = "Course_Title";
            editscoursecode.DataValueField = "Course_Code";
            editscoursecode.DataBind();

            bookCourse.DataSource = units;
            bookCourse.DataTextField = "Course_Title";
            bookCourse.DataValueField = "Course_Code";
            bookCourse.DataBind();

            editBookCourse.DataSource = units;
            editBookCourse.DataTextField = "Course_Title";
            editBookCourse.DataValueField = "Course_Code";
            editBookCourse.DataBind();
        }
        protected void adddGeneralDetails_Click(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool tspecializationareas = false;
                bool error = false;
                string accreditationNo = "";
                try
                {
                    accreditationNo = Request.QueryString["accreditationNo"].Trim();
                    if (string.IsNullOrEmpty(accreditationNo))
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    accreditationNo = "";
                }

                string tCampus = "";
                try
                {
                    tCampus = campus.SelectedValue;
                    if (tCampus.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please select the Campus Name";
                }

                string tcoursereqirement = "";
                try
                {
                    tcoursereqirement = coursereqirement.Text.Trim();
                    if (tcoursereqirement.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {

                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid value for Course requirement for the Proposed Programme";
                }

                string tcourseevaluations = "";
                try
                {
                    tcourseevaluations = courseevaluations.Text.Trim();
                    if (tcourseevaluations.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {

                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid value for Course Evaluation of the Programme";
                }
                string tphilosophy = "";
                try
                {
                    tphilosophy = philosophy.Text.Trim();
                    if (tphilosophy.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {

                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid value for Philosophy of the Programme";
                }
                string ttotalcredit = "";
                try
                {
                    ttotalcredit = totalcredit.Text.Trim();
                    if (ttotalcredit.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid value for Total Credit Hours/Lecture Hours Required for Graduation";
                }
                int ttotalcourse = 0;
                try
                {
                    ttotalcourse = Convert.ToInt32(totalcourse.Text.Trim());
                    if (ttotalcourse < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid value for Total Course Units Required for Graduation";
                }

                bool tcats = false;
                bool tsem = false;
                bool tprac = false;
                bool tothers = false;

                try
                {
                    if (cats.Checked == false && semester.Checked == false && practicals.Checked == false && others.Checked == false)
                    {
                        error = true;
                        message += message.Length > 0 ? "<br" : "";
                        message += "Kindly Choose at least one of the Student Assessment Policy/Criteria";
                    }
                    if (cats.Checked == true)
                    {
                        tcats = true;
                    }
                    if (semester.Checked == true)
                    {
                        tsem = true;
                    }
                    if (practicals.Checked == true)
                    {
                        tprac = true;
                    }
                    if (others.Checked == true)
                    {
                        tothers = true;
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please provide at least one Student Assessment Policy/Criteria";
                }
                try
                {
                    if (specializationareas.Checked == true)
                    {
                        tspecializationareas = true;

                    }
                    else
                    {
                        tspecializationareas = false;

                    }

                }
                catch (Exception ex)
                {
                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += ex;
                }
                string tadmission = "";
                try
                {
                    tadmission = admission.Text.Trim();
                    if (tadmission.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid value for Admission Requirements for the Proposed Programme";
                }
                string tgoal = "";
                try
                {
                    tgoal = goal.Text.Trim();
                    if (tgoal.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid value for the Goal of the Programme";
                }
                string trequlations = "";
                try
                {
                    trequlations = requlations.Text.Trim();
                    if (trequlations.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid value for Regulations on Credit Transfer in a programme";
                }
                string texaminations = "";
                try
                {
                    texaminations = examinations.Text.Trim();
                    if (texaminations.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid value for Examination Regulations";
                }
                string tmoderations = "";
                try
                {
                    tmoderations = moderations.Text.Trim();
                    if (tmoderations.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid value for Moderation of Examinations";
                }
                string tgraduation = "";
                try
                {
                    tgraduation = graduation.Text.Trim();
                    if (tgraduation.Length < 1)
                    {
                        tgraduation = "";
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid value for Graduation Requirements";
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
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid value for Description of Thesis/Dissertation/Project (as applicable)";
                }
                string tmanagement = "";
                try
                {
                    tmanagement = management.Text.Trim();
                    if (tmanagement.Length < 1)
                    {
                        throw new Exception();
                    }

                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid value for Management and Administration of the Programme";
                }
                string tProgram = "";
                try
                {
                    tProgram = programName.Text.Trim();
                    if (tProgram.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    tProgram = "";
                    error = true;
                    message = "Please enter a valid value for Title of the Proposed Programme";
                }
                int tProgramDuration = 0;
                try
                {
                    tProgramDuration = Convert.ToInt32(programDuration.Text.Trim());
                    if (tProgramDuration < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid value for Duration of the Programme(YRS)";
                }
                string tProgramDomain = "";
                try
                {
                    tProgramDomain = programDomain.SelectedValue;
                    if (tProgramDomain.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please select the Programme Domain Name"; ;
                }
                int tLevel = programLevel.SelectedIndex;
                try
                {
                    tLevel = programLevel.SelectedIndex;
                    if (tLevel < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    tLevel = programLevel.SelectedIndex;
                    error = true;
                    message = "Please select the Programme  Level Name";
                }
                if (error)
                {
                    generalFeedback.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
                    // Boolean tGPA = normalcheckbox.Checked;
                    string userCode = Session["Code"].ToString();
                    string password = Session["Password"].ToString();
                    string status = new Config().ObjNav().AccreditationGeneralDetails(accreditationNo, tCampus, tProgram, tProgramDuration, tProgramDomain,
                        tLevel, tphilosophy, ttotalcredit, ttotalcourse, tadmission, tgoal, trequlations, texaminations, tmoderations, tgraduation, tdescription, tmanagement, tcats, tsem, tprac, tothers, tspecializationareas, tcourseevaluations, tcoursereqirement, userCode, password);
                    string[] info = status.Split('*');
                    generalFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        //if (accreditationNo.Length < 1)
                        //{
                        //    accreditationNo = info[2];
                        //}
                        generalFeedback.InnerHtml = "<div class='alert alert-success'>Accreditation General Details has been submitted Successfully. Kindly Proceed with the Application</div>";

                        // Response.Redirect("ProgramAccreditation.aspx?accreditationNo=" + accreditationNo + "&step=1");
                    }
                }
            }
            catch (Exception y)
            {
                generalFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void editGeneralDetailsProgramme_Click(object sender, EventArgs e)
        {
            try
            {
                string message = "";
                bool tspecializationareas = false;
                bool error = false;
                string accreditationNo = accreditationnumber.Text.Trim();
                //try
                //{
                //    accreditationNo = accreditationnumber.Text.Trim();
                //    if (string.IsNullOrEmpty(accreditationNo))
                //    {
                //        throw new Exception();
                //    }
                //}
                //catch (Exception)
                //{
                //    accreditationNo = "";
                //}
                string tCampus = "";
                try
                {
                    tCampus = campusname.SelectedValue;
                    if (tCampus.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please select the Campus Name";
                }
                string tphilosophy = "";
                try
                {
                    tphilosophy = editphilosophy.Text.Trim();
                    if (tphilosophy.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {

                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid value for Philosophy of the Programme";
                }
                string ttotalcredit = "";
                try
                {
                    ttotalcredit = editcredithours.Text.Trim();
                    if (ttotalcredit.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid value for Total Credit Hours/Lecture Hours Required for Graduation";
                }
                int ttotalcourse = 0;
                try
                {
                    ttotalcourse = Convert.ToInt32(edittotalcourse.Text.Trim());
                    if (ttotalcourse < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid value for Total Course Units Required for Graduation";
                }

                string tassesments = "";
                try
                {
                    if (editcats.Checked == false && editsemester.Checked == false && editpracticals.Checked == false && editotherassessments.Checked == false)
                    {
                        generalFeedback.InnerHtml = "Kindly Choose at least one of the Student Assessment Policy/Criteria";
                    }
                    else if (editcats.Checked == true)
                    {
                        tassesments = "Continuous Assessment Tests";
                    }
                    else if (editsemester.Checked == true)
                    {
                        tassesments = "End-Trimester/Quarter/Semester";
                    }
                    else if (editpracticals.Checked == true)
                    {
                        tassesments = "Practicals";
                    }
                    else if (editotherassessments.Checked == true)
                    {
                        tassesments = "Other Assessments";
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please provide at least one Student Assessment Policy/Criteria";
                }
                string tadmission = "";
                try
                {
                    tadmission = editadmission.Text.Trim();
                    if (tadmission.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid value for Admission Requirements for the Proposed Programme";
                }
                string tgoal = "";
                try
                {
                    tgoal = editgoal.Text.Trim();
                    if (tgoal.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid value for the Goal of the Programme";
                }
                string trequlations = "";
                try
                {
                    trequlations = editrequlations.Text.Trim();
                    if (trequlations.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid value for Regulations on Credit Transfer in a programme";
                }
                string texaminations = "";
                try
                {
                    texaminations = editexaminations.Text.Trim();
                    if (texaminations.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid value for Examination Regulations";
                }
                string tmoderations = "";
                try
                {
                    tmoderations = editmoderations.Text.Trim();
                    if (tmoderations.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid value for Moderation of Examinations";
                }
                string tgraduation = "";
                try
                {
                    tgraduation = editgraduation.Text.Trim();
                    if (tgraduation.Length < 1)
                    {
                        tgraduation = "";
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid value for Graduation Requirements";
                }
                string tdescription = "";
                try
                {
                    tdescription = editdescription.Text.Trim();
                    if (tdescription.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid value for Description of Thesis/Dissertation/Project (as applicable)";
                }
                string tmanagement = "";
                try
                {
                    tmanagement = editmanagement.Text.Trim();
                    if (tmanagement.Length < 1)
                    {
                        throw new Exception();
                    }

                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid value for Management and Administration of the Programme";
                }
                string tProgram = "";
                try
                {
                    tProgram = edittitle.Text.Trim();
                    if (tProgram.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    tProgram = "";
                    error = true;
                    message = "Please enter a valid value for Title of the Proposed Programme";
                }
                int tProgramDuration = 0;
                try
                {
                    tProgramDuration = Convert.ToInt32(editduration.Text.Trim());
                    if (tProgramDuration < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += "Please enter a valid value for Duration of the Programme(YRS)";
                }
                string tProgramDomain = "";
                try
                {
                    tProgramDomain = editdomain.SelectedValue;
                    if (tProgramDomain.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please select the Programme Domain Name"; ;
                }
                int tLevel = editlevel.SelectedIndex;
                try
                {
                    tLevel = editlevel.SelectedIndex;
                    if (tLevel < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    tLevel = editlevel.SelectedIndex;
                    error = true;
                    message = "Please select the Programme  Level Name"; ;
                }
                try
                {
                    if (editspecializationareas.Checked == true)
                    {
                        tspecializationareas = true;

                    }
                    else
                    {
                        tspecializationareas = false;

                    }

                }
                catch (Exception ex)
                {
                    error = true;
                    message += message.Length > 0 ? "<br" : "";
                    message += ex;
                }
                if (error)
                {
                    generalFeedback.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
                    string userCode = Session["Code"].ToString();
                    string password = Session["Password"].ToString();
                    string status = new Config().ObjNav().UpdateaccreditationGeneralDetails(accreditationNo, tCampus, tProgram, tProgramDuration, tProgramDomain,
                        tLevel, tphilosophy, ttotalcredit, ttotalcourse, tadmission, tgoal, trequlations, texaminations, tmoderations, tgraduation, tdescription, tmanagement, tassesments, tspecializationareas, userCode, password);
                    string[] info = status.Split('*');
                    generalFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        //if (accreditationNo.Length < 1)
                        //{
                        //    accreditationNo = info[2];
                        //}
                        generalFeedback.InnerHtml = "<div class='alert alert-success'>Accreditation General Details has been Updated Successfully. Kindly Proceed with the Application</div>";

                        // Response.Redirect("ProgramAccreditation.aspx?accreditationNo=" + accreditationNo + "&step=1");
                    }
                }
            }
            catch (Exception y)
            {
                generalFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
                //accreditationGeneralDetails(accreditationNo : Code[50];campus : Code[50];programName : Text;
                //programDuration : Integer;programDomain : Code[50];gpa : Boolean;userCode : Text;password : Text) status : Text
            }
        }
        protected void previous_Click(object sender, EventArgs e)
        {
            int step = 0;
            string accreditationNo = "";
            try
            {
                step = Convert.ToInt32(Request.QueryString["step"].Trim());
                accreditationNo = Request.QueryString["accreditationNo"].Trim();
            }
            catch (Exception)
            {
                step = 0;
                accreditationNo = "";
            }
            step -= 1;
            Response.Redirect("ProgramAccreditation.aspx?accreditationNo=" + accreditationNo + "&step=" + step);
        }
        protected void next_Click(object sender, EventArgs e)
        {
            int step = 0;
            string accreditationNo = "";
            try
            {
                step = Convert.ToInt32(Request.QueryString["step"].Trim());
                accreditationNo = Request.QueryString["accreditationNo"].Trim();
            }
            catch (Exception)
            {
                step = 0;
                accreditationNo = "";
            }
            step += 1;
            Response.Redirect("ProgramAccreditation.aspx?accreditationNo=" + accreditationNo + "&step=" + step);

        }
        protected void FirstStep_Click(object sender, EventArgs e)
        {
            try
            {
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .ValidateProgrammeGeneralDetails(userCode, password);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    try
                    {
                        string university = Convert.ToString(Session["UniversityCode"]);
                        string accreditationNo = new Config().ObjNav().GetAccreditationNumber(university);
                        if (accreditationNo != "")
                        {
                            Response.Redirect("ProgramAccreditation.aspx?accreditationNo=" + accreditationNo + "&step=2");
                        }
                        else
                        {
                            generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + "There is no Open Accreditation Application Entry.Kindly Submit Accreditation General Details to Initiate New Programme Accreditation Application" + "</div>";
                        }

                    }
                    catch (Exception y)
                    {
                        generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + "There is no Open Accreditation Application Entry.Kindly Submit Accreditation General Details to Initiate New Programme Accreditation Application" + "</div>";
                    }
                }
                else
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + "There is no Open Accreditation Application Entry.Kindly Submit Accreditation General Details to Initiate New Programme Accreditation Application" + "</div>";
                }
            }
            catch (Exception y)
            {
                booksFeedback.InnerHtml = "<div class='alert alert-danger'>" + y.Message + "</div>";
            }

        }
        protected void addrationale_Click(object sender, EventArgs e)
        {
            try
            {
                string tRationaleDescription = "";
                bool error = false;
                try
                {
                    tRationaleDescription = rationaleCategoryDescription.Text.Trim();
                    if (tRationaleDescription.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    rationaleFeedback.InnerHtml = Config.GetAlert("danger", "Please enter the rationale description");
                }
                int nCategory = rationaleCategory.SelectedIndex;
                int tCategory = 0;
                if (nCategory == 1)
                {
                    tCategory = 0;
                }
                if (nCategory == 2)
                {
                    tCategory = 1;
                }
                if (nCategory == 3)
                {
                    tCategory = 2;
                }
                if (!error)
                {
                    string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                    string userCode = Session["Code"].ToString();
                    string password = Session["Password"].ToString();
                    string status = new Config().ObjNav().AddProgramRationale(accreditationNo, tCategory, tRationaleDescription, userCode, password);
                    string[] info = status.Split('*');
                    rationaleFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        rationaleCategoryDescription.Text = "";
                        rationaleCategory.SelectedIndex = 0;
                    }
                }
            }
            catch (Exception y)
            {
                rationaleFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void Validate_Rationale(object sender, EventArgs e)
        {
            //int step = 0;
            try
            {
                //  step = Convert.ToInt32(Request.QueryString["step"].Trim());
                string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .ValidateProgramRationale(accreditationNo, userCode, password);
                if (status == "success")
                {
                    Response.Redirect("ProgramAccreditation.aspx?accreditationNo=" + accreditationNo + "&step=3");
                }
                else
                {
                    rationaleFeedback.InnerHtml = "<div class='alert alert-danger'>" + "Please Select and Fill in all the Programme Rationale Details before your proceed" + "</div>";
                }

            }
            catch (Exception y)
            {
                rationaleFeedback.InnerHtml = "<div class='alert alert-danger'>" + y.Message + "</div>";
            }


        }
        protected void deleteProgramRationale_Click(object sender, EventArgs e)
        {
            try
            {
                int rationaleCode = Convert.ToInt32(deleteRationaleCode.Text.Trim());
                string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteProgramRationale(rationaleCode, accreditationNo, userCode, password);
                string[] info = status.Split('*');
                rationaleFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                if (info[0] == "success")
                {
                    rationaleCategoryDescription.Text = "";
                    rationaleCategory.SelectedIndex = 0;
                }
            }
            catch (Exception y)
            {
                rationaleFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deleteClassification_Click(object sender, EventArgs e)
        {
            try
            {
                int tdeleteclassification = Convert.ToInt32(deleteclassification.Text.Trim());
                string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .DeleteClassification(tdeleteclassification, accreditationNo, userCode, password);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    rationaleFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                }
            }
            catch (Exception y)
            {
                rationaleFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void editProgramRationale_Click(object sender, EventArgs e)
        {
            try
            {
                int rationaleCode = Convert.ToInt32(editRationaleCode.Text.Trim());
                string tRationaleDescription = "";
                bool error = false;
                try
                {
                    tRationaleDescription = editProgramRationaleDescription.Text.Trim();
                    if (tRationaleDescription.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    rationaleFeedback.InnerHtml = Config.GetAlert("danger", "Please enter the rationale description");
                }
                if (!error)
                {
                    int tCategory = editProgramRationaleCategory.SelectedIndex;
                    string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                    string userCode = Session["Code"].ToString();
                    string password = Session["Password"].ToString();
                    string status = new Config().ObjNav()
                        .EditProgramRationale(rationaleCode, accreditationNo, tCategory, tRationaleDescription, userCode, password);
                    string[] info = status.Split('*');
                    rationaleFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        rationaleCategoryDescription.Text = "";
                        rationaleCategory.SelectedIndex = 0;
                    }
                }
            }
            catch (Exception y)
            {
                rationaleFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }

        protected void adOutcome_Click(object sender, EventArgs e)
        {
            try
            {
                string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                bool error = false;
                string message = "";
                string tOutcomeDescription = "";
                try
                {
                    tOutcomeDescription = outcomeDescription.Text.Trim();
                    if (tOutcomeDescription.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 1 ? "<br>" : "";
                    message += "Please enter the outcome description";
                }
                if (error)
                {
                    learningOutcomeFeedback.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
                    string university = Convert.ToString(Session["UniversityCode"]);
                    string status1 = new Config().ObjNav().GetOutComenNumber(university);
                    string outcomNo = status1;
                    string status = new Config().ObjNav().AddLearningOutcome(accreditationNo, tOutcomeDescription, outcomNo, userCode, password);
                    string[] info = status.Split('*');
                    learningOutcomeFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        outcomeDescription.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                learningOutcomeFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void ValidateLearningOutcome_Click(object sender, EventArgs e)
        {
            try
            {
                //  step = Convert.ToInt32(Request.QueryString["step"].Trim());
                string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .ValidateLearningOutcome(accreditationNo, userCode, password);
                if (status == "success")
                {
                    Response.Redirect("ProgramAccreditation.aspx?accreditationNo=" + accreditationNo + "&step=4");
                }
                else
                {
                    learningOutcomeFeedback.InnerHtml = "<div class='alert alert-danger'>" + "Please Fill in at least 4 Programme Learning Outcome Details" + "</div>";
                }

            }
            catch (Exception y)
            {
                learningOutcomeFeedback.InnerHtml = "<div class='alert alert-danger'>" + y.Message + "</div>";
            }

        }
        protected void addSpecialization_Click(object sender, EventArgs e)
        {
            try
            {
                string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                bool error = false;
                string message = "";
                string tspecializations = "";
                string tspecializationdescript = "";
                try
                {
                    tspecializationdescript = specializationdescript.Text.Trim();
                    if (tspecializationdescript.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the Specialization Area";
                }
                try
                {
                    tspecializations = specializations.Text.Trim();
                    if (tspecializations.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 1 ? "<br>" : "";
                    message += "Please enter the specialization description";
                }
                if (error)
                {
                    specializationfeedback.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
                    string status = new Config().ObjNav().AddSpecializationAreas(accreditationNo, tspecializations, tspecializationdescript, userCode, password);

                    string[] info = status.Split('*');
                    specializationfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        specializationdescript.Text = "";
                        specializations.Text = "";
                        specializationfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    }
                }
            }
            catch (Exception y)
            {
                specializationfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void Validate_Specialization(object sender, EventArgs e)
        {
            try
            {
                string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .ValidateSpecializationAreas(accreditationNo, userCode, password);
                if (status == "success")
                {
                    Response.Redirect("ProgramAccreditation.aspx?accreditationNo=" + accreditationNo + "&step=5");
                }
                else
                {
                    specializationfeedback.InnerHtml = "<div class='alert alert-danger'>" + "Please fill in at least 4 of the Programme Specialization Areas before you proceed" + "</div>";
                }

            }
            catch (Exception y)
            {
                learningOutcomeFeedback.InnerHtml = "<div class='alert alert-danger'>" + y.Message + "</div>";
            }
        }
        protected void addDeliveryMode_Click(object sender, EventArgs e)
        {
            try
            {
                string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string tMode = deliveryMode.SelectedValue;
                string status = new Config().ObjNav().AddDeliveryMode(accreditationNo, tMode, userCode, password);
                string[] info = status.Split('*');
                modeOfDeliveryFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
            }
            catch (Exception y)
            {
                modeOfDeliveryFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void Validate_DeliveryMode(object sender, EventArgs e)
        {

            try
            {
                string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .VlidateDeliveryMode(accreditationNo, userCode, password);
                if (status == "success")
                {
                    Response.Redirect("ProgramAccreditation.aspx?accreditationNo=" + accreditationNo + "&step=6");
                }
                else
                {
                    modeOfDeliveryFeedback.InnerHtml = "<div class='alert alert-danger'>" + "Please fill in at least one of the Programme Delivery Mode" + "</div>";
                }

            }
            catch (Exception y)
            {
                modeOfDeliveryFeedback.InnerHtml = "<div class='alert alert-danger'>" + y.Message + "</div>";
            }
        }
        protected void addGrade_Click(object sender, EventArgs e)
        {
            bool error = false;
            string message = "";
            string tGradeCode = "";
            decimal tGpamaximum = 0;
            decimal tGpaminimum = 0;
            decimal tGpa = 0;
            // string tcheckboxstate = "OFF";
            try
            {

                if (chkPassport.Checked == true)
                {
                    tGradeCode = gSystemGradeCode.Text.Trim();
                    tGpa = Convert.ToDecimal(gSystemGPAPoints.Text.Trim());
                    tGpamaximum = Convert.ToDecimal(gPercentage1.Text.Trim());
                    tGpaminimum = Convert.ToDecimal(gPercentage2.Text.Trim());
                }
                if (chkPassport.Checked == false)
                {
                    tGradeCode = gSystemGradeCode.Text.Trim();
                    tGpa = 0;
                    tGpamaximum = Convert.ToDecimal(gPercentage1.Text.Trim());
                    tGpaminimum = Convert.ToDecimal(gPercentage2.Text.Trim());
                    try
                    {
                        tGpamaximum = Convert.ToDecimal(gPercentage1.Text.Trim());
                    }
                    catch (Exception)
                    {
                        error = true;
                        message += message.Length > 0 ? "<br>" : "";
                        message += "Please enter the Maximum Percentage Score";
                    }
                    try
                    {
                        tGpaminimum = Convert.ToDecimal(gPercentage2.Text.Trim());
                    }
                    catch (Exception)
                    {
                        error = true;
                        message += message.Length > 0 ? "<br>" : "";
                        message += "Please enter the Minimum Percentage Score";
                    }
                }
            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 0 ? "<br>" : "";
                message += "Please enter the Grade GPA Score";
            }
            try
            {
                tGradeCode = gSystemGradeCode.Text.Trim();
                if (tGradeCode.Length < 1)
                {
                    throw new Exception();
                }
            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 0 ? "<br>" : "";
                message = "Please enter the correct Grade value";
            }
            if (error)
            {
                gradingSystemFeedback.InnerHtml = Config.GetAlert("danger", message);
            }
            else
            {
                try
                {
                    string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                    string userCode = Session["Code"].ToString();
                    string password = Session["Password"].ToString();
                    string status = new Config().ObjNav().AddGradingSystem(accreditationNo, tGradeCode, tGpaminimum, tGpamaximum, tGpa, userCode, password);
                    string[] info = status.Split('*');
                    if (info[0] == "success")
                    {

                        gPercentage1.Text = "";
                        gPercentage2.Text = "";
                        gSystemGradeCode.Text = "";
                        gSystemGPAPoints.Text = "";
                        gradingSystemFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    }
                    else
                    {
                        gradingSystemFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    }

                }
                catch (Exception y)
                {
                    gradingSystemFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
                }
            }
        }
        protected void Validate_GradingSystem(object sender, EventArgs e)
        {
            try
            {
                string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .ValidateGradingSystem(accreditationNo, userCode, password);
                if (status == "success")
                {
                    Response.Redirect("ProgramAccreditation.aspx?accreditationNo=" + accreditationNo + "&step=7");
                }
                else
                {
                    gradingSystemFeedback.InnerHtml = "<div class='alert alert-danger'>" + "Please fill in  Programme Grading System" + "</div>";
                }

            }
            catch (Exception y)
            {
                gradingSystemFeedback.InnerHtml = "<div class='alert alert-danger'>" + y.Message + "</div>";
            }

        }
        protected void addCourse_Click(object sender, EventArgs e)
        {
            string tCourseCode = "";
            string tCourseTitle = "";
            decimal tCreditHours = 0;
            string tYearCode = "";
            string tCourseCategry = "";
            string tComments = "";
            string tcoursecontent = "";
            string tinstructions = "";
            string tcourseassemnt = "";
            string trecommendedref = "";
            string message = "";
            string tCourseOutcome = "";
            bool error = false;
            bool tdiscoverylearning = false;
            bool tproblembasedlearning = false;
            bool texperientiallearning = false;
            bool tgroupbasedlearning = false;
            bool tleactures = false;
            bool tindependentstudies = false;
            bool tpothers = false;
            string othermethods = "";
            try
            {
                if (discoverylearning.Checked == false && problembasedlearning.Checked == false && experientiallearning.Checked == false && groupbasedlearning.Checked == false && leactures.Checked == false && independentstudies.Checked == false && pothers.Checked == false)
                {
                    courseUnitsFeedback.InnerHtml = "<div class='alert alert-danger'>Kindly Choose at least one Course Instructional Methods</div>";
                    return;
                }
                if (discoverylearning.Checked == true)
                {
                    tdiscoverylearning = true;
                }
                if (problembasedlearning.Checked == true)
                {
                    tproblembasedlearning = true;
                }
                if (experientiallearning.Checked == true)
                {
                    texperientiallearning = true;
                }
                if (groupbasedlearning.Checked == true)
                {
                    tgroupbasedlearning = true;
                }
                if (leactures.Checked == true)
                {
                    tleactures = true;
                }
                if (independentstudies.Checked == true)
                {
                    tindependentstudies = true;
                }
                if (pothers.Checked == true)
                {
                    othermethods = otherinstructionalmethods.Text.Trim();
                }
            }
            catch (Exception ex)
            {
                error = true;
                message += message.Length > 0 ? "<br" : "";
                message += "Kindly Choose at least one Course Instructional Methods." + ex;
            }
            try
            {
                tcourseassemnt = courseassemnt.Text.Trim();
                if (tcourseassemnt.Length < 1)
                {
                    throw new Exception();
                }
            }
            catch (Exception)
            {
                error = true;
                message = "Please enter the Course Assessment";
            }
            try
            {
                tinstructions = instructions.Text.Trim();
                if (tinstructions.Length < 1)
                {
                    throw new Exception();
                }
            }
            catch (Exception)
            {
                error = true;
                message = "Please enter the Instruction Materials";
            }
            try
            {

                tcoursecontent = coursecontent.Text.Trim();
                if (tcoursecontent.Length < 1)
                {
                    throw new Exception();
                }
            }
            catch (Exception)
            {
                error = true;
                message = "Please enter the course Content";
            }
            try
            {
                tCourseCode = courseCode.Text.Trim();
                if (tCourseCode.Length < 1)
                {
                    throw new Exception();
                }
            }
            catch (Exception)
            {
                error = true;
                message = "Please enter the course/unit code";
            }
            try
            {
                tCourseTitle = courseTitle.Text.Trim();
                if (tCourseTitle.Length < 1)
                {
                    throw new Exception();
                }
            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 1 ? "<br>" : "";
                message += "Please enter the course/unit title";
            }
            try
            {
                tCreditHours = Convert.ToDecimal(creditHours.Text.Trim());
            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 1 ? "<br>" : "";
                message += "Please enter a valid value for credit hours";
            }
            try
            {
                tYearCode = yearCode.SelectedValue;
                if (tYearCode.Length < 1)
                {
                    throw new Exception();
                }
            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 1 ? "<br>" : "";
                message += "Please select the year code";
            }
            try
            {
                tCourseCategry = courseCategory.SelectedValue;
                if (tCourseCategry.Length < 1)
                {
                    throw new Exception();
                }
            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 1 ? "<br>" : "";
                message += "Please select the course category";
            }
            try
            {
                tCourseOutcome = courselearningoutcome.Text;
                if (tCourseOutcome.Length < 1)
                {
                    throw new Exception();
                }
            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 1 ? "<br>" : "";
                message += "Please enter course learning outcome";
            }
            int tcoursesemester = Convert.ToInt32(coursesemester.SelectedValue);
            bool tpr = false;
            if (requiresPrerequisites.Checked == true)
            {
                tpr = true;
            }
            string tprerequisities = prerequisitie.SelectedValue;
            if(tprerequisities == "--Select--")
            {
                tprerequisities = "";
            }
            if (error)
            {
                courseUnitsFeedback.InnerHtml = Config.GetAlert("danger", message);
            }
            else
            {
                try
                {
                    string nLO2 = LO2.Text;
                    string nLO3 = LO3.Text;
                    string nLO4 = LO4.Text;
                    string nLO5 = LO5.Text;
                    string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                    string userCode = Session["Code"].ToString();
                    string password = Session["Password"].ToString();
                    string status = new Config().ObjNav().AddUnit(accreditationNo, tCourseCode, tCourseTitle, tCreditHours, tYearCode, tCourseCategry, tcoursecontent, tinstructions, tcourseassemnt, trecommendedref, tdiscoverylearning, tproblembasedlearning, texperientiallearning, tgroupbasedlearning, tindependentstudies, tleactures, othermethods, userCode, password, tCourseOutcome, nLO2, nLO3, nLO4, nLO5, tcoursesemester, tpr, tprerequisities);
                    string[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        courseassemnt.Text = "";
                        courseTitle.Text = "";
                        courseassemnt.Text = "";
                        instructions.Text = "";
                        coursecontent.Text = "";
                        courseCode.Text = "";
                        UpdateProgrammeCourses();
                        courseUnitsFeedback.InnerHtml = "<div class='alert alert-success'>" + "The Course Units for the Proposed Programme was successfully Submitted" + "</div>";

                    }
                    else
                    {
                        courseUnitsFeedback.InnerHtml = "<div class='alert alert-danger'>" + "The Course Units for the Proposed Programme was not Submitted " + info[1] + "</div>";

                    }
                }
                catch (Exception y)
                {
                    courseUnitsFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
                }
            }
        }
        protected void Validate_Course(object sender, EventArgs e)
        {
            try
            {
                string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .ValidateUnit(accreditationNo, userCode, password);
                if (status == "success")
                {
                    Response.Redirect("ProgramAccreditation.aspx?accreditationNo=" + accreditationNo + "&step=8");
                }
                else
                {
                    courseUnitsFeedback.InnerHtml = "<div class='alert alert-danger'>" + "All the units were not successfully Submitted.Kindly Submit all the Programme Unit Details before you proceed" + "</div>";
                }

            }
            catch (Exception y)
            {
                courseUnitsFeedback.InnerHtml = "<div class='alert alert-danger'>" + y.Message + "</div>";
            }
        }
        protected void addCourseReference_Click(object sender, EventArgs e)
        {
            string message = "";
            string trecommendedref = "";
            bool error = false;
            try
            {
                string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                string tcourse = coursescodesref.SelectedValue;
                try
                {
                    trecommendedref = refmaterial.Text.Trim();
                    if (trecommendedref.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 1 ? "<br>" : "";
                    message += "Please Fill in the Recommended Reference Materials:";
                }
                if (error)
                {
                    reffeedback.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
                    string userCode = Session["Code"].ToString();
                    string password = Session["Password"].ToString();
                    string status = new Config().ObjNav().AddReferenceMaterial(accreditationNo, tcourse, trecommendedref, userCode, password);
                    string[] info = status.Split('*');
                    reffeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                }
            }
            catch (Exception y)
            {
                reffeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void addColo_Click(object sender, EventArgs e)
        {

            try
            {
                string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                int tLearningOutcome = Convert.ToInt32(coloOutcome.SelectedValue);
                string tCourseCode = coloCourse.SelectedValue;
                string status = new Config().ObjNav().AddCourseLearningOutcome(accreditationNo, tLearningOutcome, tCourseCode, userCode, password);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    coloFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                }
                else
                {
                    coloFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);

                }

            }
            catch (Exception y)
            {
                coloFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void ValidateCourse_LearningOutcome(object sender, EventArgs e)
        {
            try
            {
                string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string status = new Config().ObjNav()
                    .ValidateCourseLearningOutcome(accreditationNo, userCode, password);
                if (status == "success")
                {
                    Response.Redirect("ProgramAccreditation.aspx?accreditationNo=" + accreditationNo + "&step=10");
                }
                else
                {
                    coloFeedback.InnerHtml = "<div class='alert alert-danger'>" + "The Course Learning Outcome  Details were not Submitted. Kindly submit before you proceed'" + "</div>";
                }

            }
            catch (Exception y)
            {
                coloFeedback.InnerHtml = "<div class='alert alert-danger'>" + y.Message + "</div>";
            }
        }

        //protected void Course_InstuctionMethod(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        string accreditationNo = Request.QueryString["accreditationNo"].Trim();
        //        string userCode = Session["Code"].ToString();
        //        string password = Session["Password"].ToString();
        //        string tMethod = instructionalMode.SelectedValue;
        //        string status = new Config().ObjNav().AddInstructionalMethod(accreditationNo, tMethod, userCode, password);
        //        string[] info = status.Split('*');
        //        instructionalFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
        //    }
        //    catch (Exception y)
        //    {
        //        instructionalFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
        //    }
        //}
        //protected void Validate_CourseMethod(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        string accreditationNo = Request.QueryString["accreditationNo"].Trim();
        //        string userCode = Session["Code"].ToString();
        //        string password = Session["Password"].ToString();
        //        string status = new Config().ObjNav()
        //            .ValidateInstructionalMethod(accreditationNo, userCode, password);
        //        if (status == "success")
        //        {
        //            Response.Redirect("ProgramAccreditation.aspx?accreditationNo=" + accreditationNo + "&step=10");
        //        }
        //        else
        //        {
        //            instructionalFeedback.InnerHtml = "<div class='alert alert-danger'>" + "Please fill in  Programme Course Delivery Mode" + "</div>";
        //        }

        //    }
        //    catch (Exception y)
        //    {
        //        instructionalFeedback.InnerHtml = "<div class='alert alert-danger'>" + y.Message + "</div>";
        //    }

        //}

        protected void addBook_Click(object sender, EventArgs e)
        {
            bool error = false;
            string message = "";
            string tBookTitle = "";
            string tCourseCode = "";
            string tbookAuthors = "";
            string tAuthors = "";
            int tYearOfPublication = 0;
            string tPublishers = "";
            string tUrl = "";
            bool tPrint = false;
            bool tElectronic = false;
            try
            {
                if (bookPrint.Checked == false && bookElectronic.Checked == false)
                {
                    booksFeedback.InnerHtml = "<div class='alert alert-danger'>Kindly check either Print Option or Electronic Option before you proceed</div>";
                    return;
                }
                if (bookElectronic.Checked == true)
                {
                    tElectronic = true;
                    try
                    {
                        tUrl = bookURL.Text.Trim();
                        if (tUrl.Length < 1)
                        {
                            throw new Exception();
                        }
                    }
                    catch (Exception)
                    {
                        error = true;
                        message = "Kindly Enter the Online Access Link before you proceed";
                    }
                }
                if (bookPrint.Checked == true)
                {
                    tPrint = true;
                }

            }
            catch (Exception)
            {
                error = true;
                message = "Kindly check either Print Option or Electronic Option before you proceed";
            }
            try
            {
                tBookTitle = bookTitle.Text.Trim();
                if (tBookTitle.Length < 1)
                {
                    throw new Exception();
                }
            }
            catch (Exception)
            {
                error = true;
                message = "Please enter the book title";
            }
            try
            {
                tCourseCode = bookCourse.SelectedValue;
                if (tCourseCode.Length < 1)
                {
                    throw new Exception();
                }
            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 0 ? "<br>" : "";
                message += "Please Select the Course Code";
            }
            try
            {
                tbookAuthors = bookAuthors.Text.Trim();
                if (tbookAuthors.Length < 1)
                {
                    throw new Exception();
                }
            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 0 ? "<br>" : "";
                message += "Please enter the book Authors";
            }

            try
            {
                tYearOfPublication = Convert.ToInt32(bookYearofPublication.Text.Trim());
            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 0 ? "<br>" : "";
                message += "Please enter the valid book's year of publication";
            }
            try
            {
                tPublishers = bookPublishers.Text.Trim();
            }
            catch (Exception)
            {

            }

            if (error)
            {
                booksFeedback.InnerHtml = Config.GetAlert("danger", message);
            }
            else
            {
                try
                {
                    string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                    string userCode = Session["Code"].ToString();
                    string password = Session["Password"].ToString();
                    string status = new Config().ObjNav().AddBook(accreditationNo, tBookTitle, tCourseCode, tbookAuthors, tYearOfPublication, tPublishers, tUrl, tPrint, tElectronic, userCode, password);
                    string[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        bookTitle.Text = "";
                        bookAuthors.Text = "";
                        bookPublishers.Text = "";
                        bookURL.Text = "";
                        bookYearofPublication.Text = "";
                        bookAuthors.Text = "";
                        bookTitle.Text = "";
                        booksFeedback.InnerHtml = "<div class='alert alert-success'>" + "The Core Course Reading Material was successfully Submitted" + "</div>";

                    }
                    else
                    {
                        booksFeedback.InnerHtml = "<div class='alert alert-success'>" + "The Core Course Reading Material was not Submitted" + info[1] + "</div>";

                    }
                }
                catch (Exception y)
                {
                    booksFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
                }
            }
        }
        protected void Validate_ReadingMaterials(object sender, EventArgs e)
        {
            try
            {
                string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                //string userCode = Session["Code"].ToString();
                //string password = Session["Password"].ToString();
                //string status = new Config().ObjNav()
                //    .ValidateBook(accreditationNo, userCode, password);
                //if (status == "success")
                //{
                Response.Redirect("ProgramAccreditation.aspx?accreditationNo=" + accreditationNo + "&step=9");
                //}
                //else
                //{
                //    booksFeedback.InnerHtml = "<div class='alert alert-danger'>" + "Please fill in  at least 5 Programme Core Reading Materials before you procced!!!" + "</div>";
                //}
            }
            catch (Exception y)
            {
                booksFeedback.InnerHtml = "<div class='alert alert-danger'>" + y.Message + "</div>";
            }


        }
        protected void deleteLearningOutcome_Click(object sender, EventArgs e)
        {
            try
            {
                string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                bool error = false;
                string message = "";
                int tOutComeCode = 0;
                try
                {
                    tOutComeCode = Convert.ToInt32(deleteLearningOutcomeCode.Text.Trim());
                }
                catch (Exception t)
                {
                    error = true;
                    message = "The oucome code could not be found.";
                }

                if (error)
                {
                    learningOutcomeFeedback.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
                    string status = new Config().ObjNav().DeleteLearningOutcome(accreditationNo, tOutComeCode, userCode, password);

                    string[] info = status.Split('*');
                    learningOutcomeFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        //  outcomeNo.Text = "";
                        outcomeDescription.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                learningOutcomeFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deleteReference_Click(object sender, EventArgs e)
        {
            try
            {
                string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                bool error = false;
                string message = "";
                int tRefCode = 0;
                try
                {
                    tRefCode = Convert.ToInt32(referencecode.Text.Trim());
                }
                catch (Exception t)
                {
                    error = true;
                    message = "The Reference code could not be found.";
                }

                if (error)
                {
                    reffeedback.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
                    string status = new Config().ObjNav().DeleteReference(tRefCode, accreditationNo, userCode, password);

                    string[] info = status.Split('*');
                    reffeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        reffeedback.InnerHtml = "<div class='alert alert-success'>The Unit Reference Material was Successfully Deleted</div>";

                    }
                }
            }
            catch (Exception y)
            {
                learningOutcomeFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void editLearningOutcome_Click(object sender, EventArgs e)
        {
            try
            {
                string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                bool error = false;
                string message = "";
                string tOutcomeNo = "";
                string tOutcomeDescription = "";
                int tOutComeCode = 0;
                try
                {
                    tOutComeCode = Convert.ToInt32(editLearningOutcomecode.Text.Trim());
                }
                catch (Exception t)
                {
                    error = true;
                    message = "The oucome code could not be found.";
                }
                //try
                //{
                //    tOutcomeNo = editLearningOutcomeNo.Text.Trim();
                //    if (tOutcomeNo.Length < 1)
                //    {
                //        throw new Exception();
                //    }
                //}
                //catch (Exception)
                //{
                //    error = true;
                //    message += message.Length > 1 ? "<br>" : "";
                //    message += "Please enter the outcome no";
                //}
                try
                {
                    tOutcomeDescription = editLearningOutcomedescription.Text.Trim();
                    if (tOutcomeDescription.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 1 ? "<br>" : "";
                    message += "Please enter the outcome description";
                }
                if (error)
                {
                    learningOutcomeFeedback.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
                    string status = new Config().ObjNav().EditLearningOutcome(accreditationNo, tOutComeCode, tOutcomeDescription, userCode, password);

                    string[] info = status.Split('*');
                    learningOutcomeFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        // outcomeNo.Text = "";
                        outcomeDescription.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                learningOutcomeFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void editSpecialization_Click(object sender, EventArgs e)
        {
            try
            {
                string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                bool error = false;
                string message = "";
                string tSpecialization = "";
                string tSepcializationDescription = "";
                int tspecializationCode = 0;
                try
                {
                    tspecializationCode = Convert.ToInt32(editspecializationcode.Text.Trim());
                }
                catch (Exception t)
                {
                    error = true;
                    message = "The Specialization Code could not be found.";
                }
                try
                {
                    tSpecialization = editspecializationarea.Text.Trim();
                    if (tSpecialization.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 1 ? "<br>" : "";
                    message += "Please enter the Specialization Area";
                }
                try
                {
                    tSepcializationDescription = editspecializationdescription.Text.Trim();
                    if (tSepcializationDescription.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 1 ? "<br>" : "";
                    message += "Please enter the Specialization description";
                }
                if (error)
                {
                    specializationfeedback.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
                    string status = new Config().ObjNav().EditSpecializationAreas(tspecializationCode, accreditationNo, tSpecialization, tSepcializationDescription, userCode, password);

                    string[] info = status.Split('*');
                    specializationfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        editspecializationdescription.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                EditFeedback1.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void editClassification_Click(object sender, EventArgs e)
        {
            try
            {
                string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                bool error = false;
                string message = "";
                decimal teditgradepoints = 0;
                int teditclassification = 0;
                int tentryNumber = 0;
                decimal teditpercentagelevel = 0;
                try
                {
                    tentryNumber = Convert.ToInt32(entryNumber.Text.Trim());
                }
                catch (Exception t)
                {
                    error = true;
                    message = "The Specialization Code could not be found.";
                }
                try
                {
                    teditgradepoints = Convert.ToDecimal(editgradepoints.Text.Trim());
                    if (teditgradepoints < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 1 ? "<br>" : "";
                    message += "Please enter the Specialization Area";
                }
                try
                {
                    teditclassification = editclassification.SelectedIndex;
                    if (teditclassification < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 1 ? "<br>" : "";
                    message += "Please enter the Specialization description";
                }
                try
                {
                    teditpercentagelevel = Convert.ToDecimal(editpercentagelevel.Text.Trim());
                    if (teditpercentagelevel < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 1 ? "<br>" : "";
                    message += "Please enter the Specialization description";
                }
                if (error)
                {
                    specializationfeedback.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
                    string status = new Config().ObjNav().AddClassificationofDegrees(accreditationNo, teditclassification, teditgradepoints, teditpercentagelevel, userCode, password);
                    string[] info = status.Split('*');
                    specializationfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        editspecializationdescription.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                EditFeedback1.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deleteDeliveryMode_Click(object sender, EventArgs e)
        {
            try
            {
                string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                string tMode = removeDeliveryMode.Text.Trim();
                string status = new Config().ObjNav().DeleteDeliveryMode(accreditationNo, tMode, userCode, password);
                string[] info = status.Split('*');
                modeOfDeliveryFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
            }
            catch (Exception y)
            {
                modeOfDeliveryFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deleteSpecializationArea_Click(object sender, EventArgs e)
        {
            try
            {
                string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                int tMode = Convert.ToInt32(deleteSpecializationCode.Text.Trim());
                string status = new Config().ObjNav().DeleteSpecializationArea(accreditationNo, tMode, userCode, password);
                string[] info = status.Split('*');

                specializationfeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
            }
            catch (Exception y)
            {
                specializationfeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void deleteGrade_Click(object sender, EventArgs e)
        {
            bool error = false;
            string message = "";
            int code = 0;
            try
            {
                code = Convert.ToInt32(deleteGradeCode.Text.Trim());
            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 0 ? "<br>" : "";
                message += "The system could not get the code";
            }

            if (error)
            {
                gradingSystemFeedback.InnerHtml = Config.GetAlert("danger", message);
            }
            else
            {
                try
                {
                    string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                    string userCode = Session["Code"].ToString();
                    string password = Session["Password"].ToString();
                    string status = new Config().ObjNav().DeleteGradingSystem(accreditationNo, code, userCode, password);
                    string[] info = status.Split('*');

                    gradingSystemFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);

                }
                catch (Exception y)
                {
                    gradingSystemFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
                }

            }
        }

        protected void editGrade_Click(object sender, EventArgs e)
        {
            bool error = false;
            string message = "";
            string tGradeCode = "";
            decimal tMinimum = 0;
            decimal tMaximum = 0;
            decimal tGpa = 0;
            int code = 0;
            try
            {
                tGradeCode = editGradeGradeCode.Text.Trim();
                if (tGradeCode.Length < 1)
                {
                    throw new Exception();
                }
            }
            catch (Exception)
            {
                error = true;
                message = "Please enter the grade code";
            }
            try
            {
                code = Convert.ToInt32(editGradeCode.Text.Trim());
            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 0 ? "<br>" : "";
                message += "The system could not get the code";
            }
            try
            {
                tMinimum = Convert.ToDecimal(editminimumpercentage.Text.Trim());
            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 0 ? "<br>" : "";
                message += "Please enter the grade minimum score";
            }
            try
            {
                tMaximum = Convert.ToDecimal(editmaximumpercentage.Text.Trim());
            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 0 ? "<br>" : "";
                message += "Please enter the grade maximum score";
            }
            //try
            //{
            //    tGpa = Convert.ToDecimal(editGradeGpa.Text.Trim());
            //}
            //catch (Exception)
            //{
            //    error = true;
            //    message += message.Length > 0 ? "<br>" : "";
            //    message += "Please enter the grade gpa score";
            //}
            if (error)
            {
                gradingSystemFeedback.InnerHtml = Config.GetAlert("danger", message);
            }
            else
            {
                try
                {
                    string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                    string userCode = Session["Code"].ToString();
                    string password = Session["Password"].ToString();

                    string status = new Config().ObjNav().EditGradingSystem(accreditationNo, code, tGradeCode, tMinimum, tMaximum, tGpa, userCode, password);
                    string[] info = status.Split('*');
                    gradingSystemFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                }
                catch (Exception y)
                {
                    gradingSystemFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
                }
            }
        }

        protected void deleteUnit_Click(object sender, EventArgs e)
        {
            int code = 0;
            string message = "";
            bool error = false;

            try
            {
                code = Convert.ToInt32(deleteUnitCode.Text.Trim());
            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 1 ? "<br>" : "";
                message += "The system could not get the code";
            }

            if (error)
            {
                courseUnitsFeedback.InnerHtml = Config.GetAlert("danger", message);
            }
            else
            {
                try
                {
                    string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                    string userCode = Session["Code"].ToString();
                    string password = Session["Password"].ToString();
                    //courseCode  courseTitle creditHours yearCode courseCategory Comments
                    string status = new Config().ObjNav().DeleteUnit(accreditationNo, code, userCode, password);
                    string[] info = status.Split('*');
                    courseUnitsFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                }
                catch (Exception y)
                {
                    courseUnitsFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
                }
            }
        }

        protected void editCourse_Click(object sender, EventArgs e)
        {
            string tCourseCode = "";
            string tCourseTitle = "";
            decimal tCreditHours = 0;
            string tYearCode = "";
            string tCourseCategry = "";
            int code = 0;
            string message = "";
            bool error = false;
            try
            {
                tCourseCode = editCourseCode.Text.Trim();
                if (tCourseCode.Length < 1)
                {
                    throw new Exception();
                }
            }
            catch (Exception)
            {
                error = true;
                message = "Please enter the course/unit code";
            }
            try
            {
                code = Convert.ToInt32(editUnitCode.Text.Trim());
            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 1 ? "<br>" : "";
                message += "The system could not get the code";
            }
            try
            {
                tCourseTitle = editCourseTitle.Text.Trim();
                if (tCourseTitle.Length < 1)
                {
                    throw new Exception();
                }
            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 1 ? "<br>" : "";
                message += "Please enter the course/unit title";
            }
            try
            {
                tCreditHours = Convert.ToDecimal(editCourseCreditHours.Text.Trim());
            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 1 ? "<br>" : "";
                message += "Please enter a valid value for credit hours";
            }
            try
            {
                tYearCode = editCourseYearCode.SelectedValue;
                if (tYearCode.Length < 1)
                {
                    throw new Exception();
                }
            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 1 ? "<br>" : "";
                message += "Please select the year code";
            }
            try
            {
                tCourseCategry = editCourseCategory.SelectedValue;
                if (tCourseCategry.Length < 1)
                {
                    throw new Exception();
                }
            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 1 ? "<br>" : "";
                message += "Please select the course category";
            }
            string tsem = "";
            try
            {
                tsem = editCoursesem.SelectedValue;
                if (tsem.Length < 1)
                {
                    throw new Exception();
                }

            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 1 ? "<br>" : "";
                message += "Please select the Course Semester/Trimister";
            }
            string teditCourseContent = "";
            try
            {
                teditCourseContent = editCourseContent.Text.Trim();
                if (teditCourseContent.Length < 1)
                {
                    throw new Exception();
                }

            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 1 ? "<br>" : "";
                message += "Please enter course content";
            }
            string teditCourseMaterial = "";
            try
            {
                teditCourseMaterial = editCourseMaterial.Text.Trim();
                if (teditCourseMaterial.Length < 1)
                {
                    throw new Exception();
                }

            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 1 ? "<br>" : "";
                message += "Please enter Instructional Materials and/or Equipment";
            }
            string teditCourseAssessment = "";
            try
            {
                teditCourseAssessment = editCourseAssessment.Text.Trim();
                if (teditCourseAssessment.Length < 1)
                {
                    throw new Exception();
                }

            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 1 ? "<br>" : "";
                message += "Please enter Course Assessment";
            }
            string tlo1 = "";
            try
            {
                tlo1 = editLO1.Text.Trim();
                if (tlo1.Length < 1)
                {
                    throw new Exception();
                }

            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 1 ? "<br>" : "";
                message += "Please enter Learning Outcome One";
            }
            string tlo2 = "";
            try
            {
                tlo2 = editLO2.Text.Trim();
                if (tlo2.Length < 1)
                {
                    throw new Exception();
                }

            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 1 ? "<br>" : "";
                message += "Please enter Learning Outcome two";
            }
            string tlo3 = "";
            try
            {
                tlo3 = editLO3.Text.Trim();
                if (tlo3.Length < 1)
                {
                    throw new Exception();
                }

            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 1 ? "<br>" : "";
                message += "Please enter Learning Outcome three";
            }
            bool tdiscoverylearning = false;
            bool tproblembasedlearning = false;
            bool texperientiallearning = false;
            bool tgroupbasedlearning = false;
            bool tleactures = false;
            bool tindependentstudies = false;
            bool tpothers = false;
            string othermethods = "";
            if (editdiscoverylearning.Checked == false && editproblembased.Checked == false && editexperientallearning.Checked == false && editgroupbasedlearning.Checked == false && editlectures.Checked == false && editindependentstudies.Checked == false && editcheckothers.Checked == false)
            {
                courseUnitsFeedback.InnerHtml = "<div class='alert alert-danger'>Kindly Choose at least one Course Instructional Methods</div>";
                return;
            }
            if (editdiscoverylearning.Checked == true)
            {
                tdiscoverylearning = true;
            }
            if (editproblembased.Checked == true) 
            {
                tproblembasedlearning = true;
            }
            if (editexperientallearning.Checked == true)
            {
                texperientiallearning = true;
            }
            if (editgroupbasedlearning.Checked == true)
            {
                tgroupbasedlearning = true;
            }
            if (editlectures.Checked == true)
            {
                tleactures = true;
            }
            if (editindependentstudies.Checked == true)
            {
                tindependentstudies = true;
            }
            if (editcheckothers.Checked == true)
            {
                othermethods = editotherss.Text.Trim();
            }

            if (error)
            {
                courseUnitsFeedback.InnerHtml = Config.GetAlert("danger", message);
            }
            else
            {
                try
                {
                    string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                    string userCode = Session["Code"].ToString();
                    string password = Session["Password"].ToString();
                    string tlo4 = editLO4.Text;
                    string tlo5 = editLO5.Text;
                    string status = new Config().ObjNav().EditUnit(accreditationNo, code, tCourseCode, tCourseTitle, tCreditHours, tYearCode, tCourseCategry, Convert.ToInt32(tsem), teditCourseContent,
                        teditCourseMaterial, teditCourseAssessment, tlo1, tlo2, tlo3, tlo4, tlo5, tdiscoverylearning, tproblembasedlearning, texperientiallearning, tgroupbasedlearning, tindependentstudies, tleactures, othermethods);
                    string[] info = status.Split('*');
                    courseUnitsFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                }
                catch (Exception y)
                {
                    courseUnitsFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
                }
            }
        }
        protected void editCourseRef_Click(object sender, EventArgs e)
        {
            try
            {
                string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                //string trefcode = refcode.Text.Trim();
                string tcourcode = editscoursecode.SelectedValue;
                string treftitle = reftitle.Text.Trim();
                int trefcode = 0;
                try
                {
                    trefcode = Convert.ToInt32(refcode.Text.Trim());
                }
                catch (Exception) { }
                string status = new Config().ObjNav().EditReferenceMaterials(trefcode, accreditationNo, tcourcode, treftitle, userCode, password);
                string[] info = status.Split('*');
                reffeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
            }
            catch (Exception y)
            {
                reffeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void editColo_Click(object sender, EventArgs e)
        {
            try
            {
                string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                int tLearningOutcome = Convert.ToInt32(editColoOutcome.SelectedValue);
                string tCourseCode = editColoUnit.SelectedValue;
                int code = 0;
                try
                {
                    code = Convert.ToInt32(editColoCode.Text.Trim());
                }
                catch (Exception) { }
                string status = new Config().ObjNav().EditCourseLearningOutcome(accreditationNo, code, tLearningOutcome, tCourseCode, userCode, password);
                string[] info = status.Split('*');
                coloFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
            }
            catch (Exception y)
            {
                coloFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }

        protected void deleteColo_Click(object sender, EventArgs e)
        {
            try
            {
                string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                string userCode = Session["Code"].ToString();
                string password = Session["Password"].ToString();
                int code = 0;
                try
                {
                    code = Convert.ToInt32(deletecoloCode.Text.Trim());
                }
                catch (Exception) { }
                string status = new Config().ObjNav().DeleteCourseLearningOutcome(accreditationNo, code, userCode, password);
                string[] info = status.Split('*');
                coloFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
            }
            catch (Exception y)
            {
                coloFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }

        //protected void removeInstructionalMethod_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        string accreditationNo = Request.QueryString["accreditationNo"].Trim();
        //        string userCode = Session["Code"].ToString();
        //        string password = Session["Password"].ToString();
        //        int code = 0;
        //        try
        //        {
        //            code = Convert.ToInt32(editInstructionalMethodCode.Text.Trim());
        //        }
        //        catch (Exception)
        //        {

        //        }
        //        string status = new Config().ObjNav().DeleteInstructionalMethod(accreditationNo, code, userCode, password);
        //        string[] info = status.Split('*');
        //        instructionalFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
        //    }
        //    catch (Exception y)
        //    {
        //        instructionalFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
        //    }
        //}

        protected void Degrees_ClassificationsClick(object sender, EventArgs e)
        {
            bool error = false;
            string message = "";
            int ttxtclassifications = 0;
            decimal tgradepointsaverage = 0;
            decimal tpercentagelevel = 0;
            try
            {
                ttxtclassifications = txtclassifications.SelectedIndex;
                if (ttxtclassifications < 1)
                {
                    throw new Exception();
                }
            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 0 ? "<br>" : "";
                message += "Please Select a valid value for Classifications";
            }
            try
            {
                tgradepointsaverage = Convert.ToDecimal(gradepointsaverage.Text.Trim());
                if(ttxtclassifications != 5)
                {
                    if (tgradepointsaverage < 1)
                    {
                        throw new Exception();
                    }
                }
            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 0 ? "<br>" : "";
                message += "Please enter the Grade Point Average";
            }
            try
            {
                tpercentagelevel = Convert.ToDecimal(percentagelevel.Text.Trim());
                if (ttxtclassifications != 5)
                {
                    if (tpercentagelevel < 1)
                    {
                        throw new Exception();
                    }
                }
            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 0 ? "<br>" : "";
                message += "Please enter the Valid value for Percentage Level";
            }


            if (error)
            {
                classificationsFeedback.InnerHtml = Config.GetAlert("danger", message);
            }
            else
            {
                try
                {
                    string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                    string userCode = Session["Code"].ToString();
                    string password = Session["Password"].ToString();
                    string status = new Config().ObjNav().AddClassificationofDegrees(accreditationNo, ttxtclassifications, tgradepointsaverage, tpercentagelevel, userCode, password);
                    string[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        classificationsFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    }
                    else
                    {
                        classificationsFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    }

                }
                catch (Exception y)
                {
                    classificationsFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
                }
            }
        }
        protected void editBook_Click(object sender, EventArgs e)
        {
            bool error = false;
            string message = "";
            string tBookTitle = "";
            string tCourseCode = "";
            string tAuthors = "";
            int tYearOfPublication = 0;
            string tPublishers = "";
            string tUrl = "";
            bool tPrint = false;
            bool tElectronic = false;
            int code = 0;
            try
            {
                if (editBookPrint.Checked)
                {

                    tPrint = true;
                }
                else
                {

                    booksFeedback.InnerHtml = "<div class='alert alert-danger'>Please Check the Print Option</div>";

                }
                if (editBookElectronic.Checked)
                {

                    tElectronic = true;

                }
                else
                {

                    booksFeedback.InnerHtml = "<div class='alert alert-danger'>Please Check the Electronic Print Option</div>";

                }
            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 0 ? "<br>" : "";
                message += "Please Check the Print Option";
            }
            try
            {
                tBookTitle = editBookTitle.Text.Trim();
                if (tBookTitle.Length < 1)
                {
                    throw new Exception();
                }
            }
            catch (Exception)
            {
                error = true;
                message = "Please enter the book title";
            }
            try
            {
                code = Convert.ToInt32(editBookCode.Text.Trim());
            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 0 ? "<br>" : "";
                message += "The system could not get the book code";
            }
            try
            {
                tCourseCode = editBookCourse.SelectedValue;
                if (tCourseCode.Length < 1)
                {
                    throw new Exception();
                }
            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 0 ? "<br>" : "";
                message += "Please enter the book title";
            }
            try
            {
                tAuthors = editBookAuthors.Text.Trim();
            }
            catch (Exception)
            {

            }
            try
            {
                tYearOfPublication = Convert.ToInt32(editBookPublicationYear.Text.Trim());
            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 0 ? "<br>" : "";
                message += "Please enter the valid book's year of publication";
            }
            try
            {
                tPublishers = editBookPublishers.Text.Trim();
            }
            catch (Exception) { }
            try
            {
                tUrl = editBookURL.Text.Trim();
            }
            catch (Exception)
            {

            }
            if (error)
            {
                booksFeedback.InnerHtml = Config.GetAlert("danger", message);
            }
            else
            {
                try
                {
                    string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                    string userCode = Session["Code"].ToString();
                    string password = Session["Password"].ToString();
                    string status = new Config().ObjNav().EditBook(accreditationNo, code, tBookTitle, tCourseCode, tAuthors
                        , tYearOfPublication, tPublishers, tUrl, tPrint, tElectronic, userCode, password);
                    string[] info = status.Split('*');
                    booksFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                }
                catch (Exception y)
                {
                    booksFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
                }
            }
        }

        protected void deleteBook_Click(object sender, EventArgs e)
        {
            bool error = false;
            string message = "";
            int code = 0;

            try
            {
                code = Convert.ToInt32(deleteBookCode.Text.Trim());
            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 0 ? "<br>" : "";
                message += "The system could not get the book code";
            }

            if (error)
            {
                booksFeedback.InnerHtml = Config.GetAlert("danger", message);
            }
            else
            {
                try
                {
                    string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                    string userCode = Session["Code"].ToString();
                    string password = Session["Password"].ToString();
                    string status = new Config().ObjNav().DeleteBook(accreditationNo, code, userCode, password);
                    string[] info = status.Split('*');
                    booksFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                }
                catch (Exception y)
                {
                    booksFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
                }
            }
        }

        protected void saveApplication_Click(object sender, EventArgs e)
        {
            try
            {

                string accreditationNo = Request.QueryString["accreditationNo"].Trim();
                accreditationNo = accreditationNo.Replace('/', '_');
                accreditationNo = accreditationNo.Replace(':', '_');
                string path1 = Config.FilesLocation() + "Awaiting Completeness Card/";
                string str1 = Convert.ToString(accreditationNo);
                string folderName = path1 + str1 + "/";
                bool facilitiesDocUploaded = false;
                bool applicationLetterUploaded = false;
                bool paymentDocumentUploaded = false;
                bool equipmentDocumentUploaded = false;
                bool coretextDocumentUploaded = false;
                bool academicstaffDocumentUploaded = false;
                bool universitypolicyDocumentUploaded = false;
                bool clearanceDocumentUploaded = false;
                bool senateApprovalDocumentUploaded = false;
                bool supportstaffDocumentUploaded = false;
                bool eveidenceDocumentUploaded = false;
                string policybytes = (dynamic)null;
                string facilitiesbytes = (dynamic)null;
                string equipmentsbytes = (dynamic)null;
                string coreTextsbytes = (dynamic)null;
                string supportStaffbytes = (dynamic)null;
                string academicStaffbytes = (dynamic)null;
                string clearencebytes = (dynamic)null;
                bool tmyCheck = false;
                bool error = false;
                string message = "";
                try
                {
                    if (facilities.HasFile)
                    {
                        string extension = System.IO.Path.GetExtension(facilities.FileName);
                        if (extension == ".pdf" || extension == ".PDF" || extension == ".Pdf")
                        {
                            string filename = "Facilities" + extension;
                            if (!Directory.Exists(folderName))
                            {
                                Directory.CreateDirectory(folderName);
                            }
                            if (File.Exists(folderName + filename))
                            {
                                File.Delete(folderName + filename);
                            }
                            facilities.SaveAs(folderName + filename);
                            //string imagePath = folderName + filename;
                            //System.Drawing.Image img = System.Drawing.Image.FromFile(imagePath);
                            //byte[] ImageuniversityFacilities = ImageToByteArray(img);
                            //facilitiesbytes = Convert.ToBase64String(ImageuniversityFacilities);
                            if (File.Exists(folderName + filename))
                            {
                                facilitiesDocUploaded = true;
                            }
                        }
                        else
                        {
                            error = true;
                            message += message.Length > 0 ? "<br>" : "";
                            message += "The file extension of the Appendix I:Facilities is not allowed,Kindly upload jpg,png,gif or jpeg files";
                        }

                    }
                    else
                    {
                        error = true;
                        message += message.Length > 0 ? "<br>" : "";
                        message += "Kindly Upload the Appendix I:Facilities before you proceed";

                    }
                }
                catch (Exception ex)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Kindly Upload the Appendix I:Facilities before you proceed" + ex;
                }
                try
                {
                    if (needassesmentreport.HasFile)
                    {
                        string extension = System.IO.Path.GetExtension(needassesmentreport.FileName);
                        if (new Config().IsAllowedExtension(extension))
                        {
                            string filename = "Need_Assement_Report" + extension;
                            if (!Directory.Exists(folderName))
                            {
                                Directory.CreateDirectory(folderName);
                            }
                            if (File.Exists(folderName + filename))
                            {
                                File.Delete(folderName + filename);
                            }
                            needassesmentreport.SaveAs(folderName + filename);
                            if (File.Exists(folderName + filename))
                            {
                                applicationLetterUploaded = true;
                            }
                        }
                        else
                        {
                            error = true;
                            message += message.Length > 0 ? "<br>" : "";
                            message += "The file extension of the Need Assement Report  is not allowed";
                        }

                    }
                    else
                    {
                        error = true;
                        message += message.Length > 0 ? "<br>" : "";
                        message += "Kindly Upload the Need Assement Report  before you proceed";
                    }
                }
                catch (Exception)
                {

                }

                try
                {
                    if (equipment.HasFile == true)
                    {
                        string extension = System.IO.Path.GetExtension(equipment.FileName);
                        if (extension == ".pdf" || extension == ".PDF" || extension == ".Pdf")
                        {
                            string filename = "Equipments" + extension;
                            if (!Directory.Exists(folderName))
                            {
                                Directory.CreateDirectory(folderName);
                            }
                            if (File.Exists(folderName + filename))
                            {
                                File.Delete(folderName + filename);
                            }
                            equipment.SaveAs(folderName + filename);
                            //string imagePath = folderName + filename;
                            //System.Drawing.Image img = System.Drawing.Image.FromFile(imagePath);
                            //byte[] ImageuniversityEquipments = ImageToByteArray(img);
                            //equipmentsbytes = Convert.ToBase64String(ImageuniversityEquipments);
                            if (File.Exists(folderName + filename))
                            {
                                equipmentDocumentUploaded = true;
                            }
                        }
                        else
                        {
                            error = true;
                            message += message.Length > 0 ? "<br>" : "";
                            message += "The file extension of the Appendix II: Equipment and Teaching Materials is not allowed,Kindly upload jpg,png,gif or jpeg files";
                        }
                    }
                    else
                    {
                        error = true;
                        message += message.Length > 0 ? "<br>" : "";
                        message += "Kindly Upload the Appendix II: Equipment and Teaching Materials before you proceed";
                    }
                }
                catch (Exception ex)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Kindly Upload the Appendix II: Equipment and Teaching Materials before you proceed" + ex;

                }
                try
                {
                    if (coretext.HasFile == true)
                    {
                        string extension = System.IO.Path.GetExtension(coretext.FileName);
                        if (extension == ".pdf" || extension == ".PDF" || extension == ".Pdf")
                        {
                            string filename = "CoreTexts" + extension;
                            if (!Directory.Exists(folderName))
                            {
                                Directory.CreateDirectory(folderName);
                            }
                            if (File.Exists(folderName + filename))
                            {
                                File.Delete(folderName + filename);
                            }
                            coretext.SaveAs(folderName + filename);
                            //string imagePath = folderName + filename;
                            //System.Drawing.Image img = System.Drawing.Image.FromFile(imagePath);
                            //byte[] ImageuniversityCoreTexts = ImageToByteArray(img);
                            //coreTextsbytes = Convert.ToBase64String(ImageuniversityCoreTexts);
                            if (File.Exists(folderName + filename))
                            {
                                coretextDocumentUploaded = true;
                            }
                        }
                        else
                        {
                            error = true;
                            message += message.Length > 0 ? "<br>" : "";
                            message += "The file extension of the Appendix III: Core-Texts and Journals is not allowed,Kindly upload Pdf files";
                        }

                    }
                    else
                    {
                        error = true;
                        message += message.Length > 0 ? "<br>" : "";
                        message += "Kindly Upload the Appendix III: Core-Texts and Journals before you proceed";
                    }
                }
                catch (Exception ex)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Kindly Upload the Appendix III: Core-Texts and Journals before you proceed" + ex;
                }
                try
                {
                    if (academicstaff.HasFile == true)
                    {
                        string extension = System.IO.Path.GetExtension(academicstaff.FileName);
                        if (extension == ".pdf" || extension == ".PDF" || extension == ".Pdf")
                        {
                            string filename = "TeachingStaff" + extension;
                            if (!Directory.Exists(folderName))
                            {
                                Directory.CreateDirectory(folderName);
                            }
                            if (File.Exists(folderName + filename))
                            {
                                File.Delete(folderName + filename);
                            }
                            academicstaff.SaveAs(folderName + filename);
                            //string imagePath = folderName + filename;
                            //System.Drawing.Image img = System.Drawing.Image.FromFile(imagePath);
                            //byte[] ImageuniversityAcademicStaff = ImageToByteArray(img);
                            //academicStaffbytes = Convert.ToBase64String(ImageuniversityAcademicStaff);
                            if (File.Exists(folderName + filename))
                            {
                                academicstaffDocumentUploaded = true;
                            }
                        }
                        else
                        {
                            error = true;
                            message += message.Length > 0 ? "<br>" : "";
                            message += "The file extension of the Appendix IV: Academic Staff is not allowed,Kindly upload Pdf files";
                        }

                    }
                    else
                    {
                        error = true;
                        message += message.Length > 0 ? "<br>" : "";
                        message += "Kindly Upload the  Appendix IV: Academic Staff before you proceed";
                    }
                }
                catch (Exception ex)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Kindly Upload the  Appendix IV: Academic Staff before you proceed" + ex;
                }
                try
                {
                    if (supportstaff.HasFile == true)
                    {
                        string extension = System.IO.Path.GetExtension(supportstaff.FileName);
                        if (extension == ".pdf" || extension == ".PDF" || extension == ".Pdf")
                        {
                            string filename = "RelevantSupportStaff" + extension;
                            if (!Directory.Exists(folderName))
                            {
                                Directory.CreateDirectory(folderName);
                            }
                            if (File.Exists(folderName + filename))
                            {
                                File.Delete(folderName + filename);
                            }
                            supportstaff.SaveAs(folderName + filename);
                            //string imagePath = folderName + filename;
                            //System.Drawing.Image img = System.Drawing.Image.FromFile(imagePath);
                            //byte[] ImageuniversitySupportStaff = ImageToByteArray(img);
                            //supportStaffbytes = Convert.ToBase64String(ImageuniversitySupportStaff);
                            if (File.Exists(folderName + filename))
                            {
                                supportstaffDocumentUploaded = true;
                            }
                        }
                        else
                        {
                            error = true;
                            message += message.Length > 0 ? "<br>" : "";
                            message += "The file extension of the Appendix V: Relevant Support Staff is not allowed,Kindly upload Pdf files";
                        }

                    }
                    else
                    {
                        error = true;
                        message += message.Length > 0 ? "<br>" : "";
                        message += "Kindly Upload the  Appendix V: Relevant Support Staff before you proceed";
                    }
                }
                catch (Exception ex)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Kindly Upload the  Appendix V: Relevant Support Staff before you proceed" + ex;
                }
                try
                {

                    if (universitypolicy.HasFile == true)
                    {
                        string extension = System.IO.Path.GetExtension(universitypolicy.FileName);
                        if (extension == ".pdf" || extension == ".PDF" || extension == ".Pdf")
                        {
                            string filename = "UniversityPolicy" + extension;
                            // 1. Step to convert the image to the Byte Array
                            if (!Directory.Exists(folderName))
                            {
                                Directory.CreateDirectory(folderName);
                            }
                            if (File.Exists(folderName + filename))
                            {
                                File.Delete(folderName + filename);
                            }
                            universitypolicy.SaveAs(folderName + filename);
                            //string imagePath = folderName + filename;
                            //System.Drawing.Image img = System.Drawing.Image.FromFile(imagePath);
                            //byte[] Imageuniversitypolicy = ImageToByteArray(img);
                            // policybytes =Convert.ToBase64String(Imageuniversitypolicy);
                            if (File.Exists(folderName + filename))
                            {
                                universitypolicyDocumentUploaded = true;
                            }

                        }
                        else
                        {
                            error = true;
                            message += message.Length > 0 ? "<br>" : "";
                            message += "The file extension of the Appendix Vi: University Policy on Curriculum Development is not allowed,Kindly upload Pdf files";
                        }

                    }
                    else
                    {
                        error = true;
                        message += message.Length > 0 ? "<br>" : "";
                        message += "Kindly Upload the  Appendix Vi: University Policy on Curriculum Development before you proceed";
                    }
                }
                catch (Exception ex)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Kindly Upload the  Appendix Vi: University Policy on Curriculum Development before you proceed" + ex;
                }
                try
                {
                    if (myCheck.Checked == true)
                    {

                        if (evidence.HasFile == true)
                        {
                            string extension = System.IO.Path.GetExtension(evidence.FileName);
                            if (new Config().IsAllowedExtension(extension))
                            {
                                string filename = " EvidenceofClearenceofProfessionalBody" + extension;
                                if (!Directory.Exists(folderName))
                                {
                                    Directory.CreateDirectory(folderName);
                                }
                                if (File.Exists(folderName + filename))
                                {
                                    File.Delete(folderName + filename);
                                }
                                evidence.SaveAs(folderName + filename);
                                //string imagePath = folderName + filename;
                                //System.Drawing.Image img = System.Drawing.Image.FromFile(imagePath);
                                //byte[] ImageuniversityClearence = ImageToByteArray(img);
                                //clearencebytes = Convert.ToBase64String(ImageuniversityClearence);
                                if (File.Exists(folderName + filename))
                                {
                                    eveidenceDocumentUploaded = true;
                                }

                            }
                            else
                            {
                                error = true;
                                message += message.Length > 0 ? "<br>" : "";
                                message += "The file extension of the Evidence of Clearence of Professional Body is not allowed";
                            }
                        }
                        else
                        {
                            error = true;
                            message += message.Length > 0 ? "<br>" : "";
                            message += "Kindly Upload the Evidence of Clearence of Professional Body before you proceed";
                        }
                    }
                }
                catch (Exception ex)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Kindly Upload the Evidence of Clearence of Professional Body before you proceed" + ex;
                }
                try
                {
                    if (sennateapproval.HasFile)
                    {
                        string extension = System.IO.Path.GetExtension(facilities.FileName);
                        if (extension == ".pdf" || extension == ".PDF" || extension == ".Pdf")
                        {
                            string filename = "SenateApproval" + extension;
                            if (!Directory.Exists(folderName))
                            {
                                Directory.CreateDirectory(folderName);
                            }
                            if (File.Exists(folderName + filename))
                            {
                                File.Delete(folderName + filename);
                            }
                            sennateapproval.SaveAs(folderName + filename);
                            //string imagePath = folderName + filename;
                            //System.Drawing.Image img = System.Drawing.Image.FromFile(imagePath);
                            //byte[] ImageuniversityFacilities = ImageToByteArray(img);
                            //facilitiesbytes = Convert.ToBase64String(ImageuniversityFacilities);
                            if (File.Exists(folderName + filename))
                            {
                                senateApprovalDocumentUploaded = true;
                            }
                        }
                        else
                        {
                            error = true;
                            message += message.Length > 0 ? "<br>" : "";
                            message += "The file extension of the Appendix VIII: Senate Approval is not allowed,Kindly upload Pdf files";
                        }

                    }
                    else
                    {
                        error = true;
                        message += message.Length > 0 ? "<br>" : "";
                        message += "Kindly Upload the  Appendix VIII: Senate Approval before you proceed";
                    }
                }
                catch (Exception ex)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Kindly Upload the Appendix VIII: Senate Approval before you proceed" + ex;
                }
                if (error)
                {
                    documentsFeedback.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
                    var userCode = Session["Code"].ToString();
                    string password = Session["Password"].ToString();
                    string tAccreditationNo = Request.QueryString["accreditationNo"].Trim();
                    string status = new Config().ObjNav()
                        .SaveDocumentsPayment(tAccreditationNo, applicationLetterUploaded, paymentDocumentUploaded, facilitiesDocUploaded,
                        equipmentDocumentUploaded, coretextDocumentUploaded, academicstaffDocumentUploaded, universitypolicyDocumentUploaded, clearanceDocumentUploaded, userCode, password);
                    string[] info = status.Split('*');
                    documentsFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                }

            }
            catch (Exception y)
            {
                documentsFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }
        protected void SendCUE_Click(object sender, EventArgs e)
        {
            try
            {
                documentsFeedback.InnerHtml = "";
                var userCode = Convert.ToInt32(Session["Code"].ToString());
                string password = Session["Password"].ToString();
                string university = Session["UniversityCode"].ToString();
                string tAccreditationNo = Request.QueryString["accreditationNo"].Trim();
                string univerNo1 = university.Replace("-", "_");
                string univerNo2 = univerNo1.Replace(":", "_");
                string status = new Config().ObjNav().ProgramAccreditationAlert(userCode, university, tAccreditationNo);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    //string embed = "<object data=\"{0}\" type=\"application/pdf\" width=\"1000px\" height=\"300px\">";
                    //embed += "If you are unable to view file, you can download from <a href = \"{0}\">here</a>";
                    //embed += " or download <a target = \"_blank\" href = \"~/Downloads\">Proforma Invoices</a> to view the file.";
                    //embed += "</object>";
                    //ltEmbed.Text = string.Format(embed, ResolveUrl("~/Downloads/" + univerNo2 + ".pdf"));
                    feedback.InnerHtml = "<div class='alert alert-success'>"+ info[1] + "</div>";
                }
                else
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>"+info[1]+"</div>";
                }

            }
            catch (Exception t)
            {
                documentsFeedback.InnerHtml = "<div class='alert alert-danger'>"+t.Message+"<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        public byte[] ImageToByteArray(System.Drawing.Image imageIn)
        {
            using (var ms = new MemoryStream())
            {
                imageIn.Save(ms, imageIn.RawFormat);

                return ms.ToArray();
            }
        }
        protected void DownloadFile(object sender, EventArgs e)
        {
            string filePath = (sender as LinkButton).CommandArgument;
            Response.ContentType = ContentType;
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filePath));
            Response.WriteFile(filePath);
            Response.End();
        }

        protected void requiresPrerequisites_CheckedChanged(object sender, EventArgs e)
        {
            if (requiresPrerequisites.Checked == true)
            {
                divPrerequisites.Visible = true;
            }
            else
            {
                divPrerequisites.Visible = false;
            }
        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {
            string tAccreditationNo = Request.QueryString["accreditationNo"].Trim();
            Response.Redirect("DownLoadProgramme.aspx?accreditationNo=" + tAccreditationNo);
        }

        protected void yesEdit_Click(object sender, EventArgs e)
        {
            string accreditationNo = txtprogramID.Text.Trim();
            Response.Redirect("ProgramAccreditation.aspx?accreditationNo=" + accreditationNo);
        }
        protected void deletefile_Click(object sender, EventArgs e)
        {
            try
            {
                String tFileName = fileName.Text.Trim();
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Awaiting Completeness Card/";
                String imprestNo = Request.QueryString["accreditationNo"].Trim();
                imprestNo = imprestNo.Replace('/', '_');
                imprestNo = imprestNo.Replace(':', '_');
                String documentDirectory = filesFolder + imprestNo + "/";
                String myFile = documentDirectory + tFileName;
                if (File.Exists(myFile))
                {
                    File.Delete(myFile);
                    if (File.Exists(myFile))
                    {
                        documentsFeedback.InnerHtml = "<div class='alert alert-danger'>The file could not be deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        documentsFeedback.InnerHtml = "<div class='alert alert-success'>The file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                else
                {
                    documentsFeedback.InnerHtml = "<div class='alert alert-danger'>A file with the given name does not exist in the server <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }



            }
            catch (Exception m)
            {
                documentsFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }

        }
    }
}