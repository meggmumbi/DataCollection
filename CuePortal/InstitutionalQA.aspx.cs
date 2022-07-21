using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class InstitutionalQA : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                List<string> staffcategorys = new List<string>();
                staffcategorys.Add("Teaching Staff");
                staffcategorys.Add("Non-Teaching Staff");
                staffcategory.DataSource = staffcategorys;
                staffcategory.DataBind();


                string qaNo = Request.QueryString["qa"].Trim();
                if (string.IsNullOrEmpty(qaNo))
                {
                    throw new Exception();
                }
                else
                {
                    var nav = Config.ReturnNav();
                    var applications = nav.Institutional_Quality_Audit.Where(r => r.Institution_No == Convert.ToString(Session["UniversityCode"])&&r.Quality_Audit_No==qaNo).ToList();
                    if (applications.Count < 1)
                    {
                        throw new Exception();
                    }
                    else
                    {
                        var step = Request.QueryString["step"];
                        int myStep = 0;
                        int maxSteps = 10;
                        try
                        {
                            myStep = Convert.ToInt32(step);
                        }
                        catch (Exception)
                        {
                            myStep = 1;
                        }
                        if (myStep < 1)
                        {
                            myStep = 1;
                        }
                        if (myStep==1)
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
                            
                        
                        }
                        else if(myStep == 3)
                        {
                            if (!IsPostBack)
                            {
                                var countries = nav.countries;
                                trusteeNationality.DataSource = countries;
                                trusteeNationality.DataValueField = "Code";
                                trusteeNationality.DataTextField = "Name";
                                trusteeNationality.DataBind();

                                councilNationality.DataSource = countries;
                                councilNationality.DataValueField = "Code";
                                councilNationality.DataTextField = "Name";
                                councilNationality.DataBind();

                                var academicLevels = nav.AcademicLevels;
                                // Code
                                councilHighestAcademic.DataSource = academicLevels;
                                councilHighestAcademic.DataValueField = "Code";
                                councilHighestAcademic.DataTextField = "Level_Name";
                                councilHighestAcademic.DataBind();

                                trusteeHighestAcademicQualification.DataSource = academicLevels;
                                trusteeHighestAcademicQualification.DataValueField = "Code";
                                trusteeHighestAcademicQualification.DataTextField = "Level_Name";
                                trusteeHighestAcademicQualification.DataBind();
                            }
                        }
                        else if (myStep == 4)
                        {
                            //Full-time Staff,
                            if (!IsPostBack)
                            {
                                var categories = nav.HRCategories;
                                fullTimerCategory.DataSource = categories;
                                fullTimerCategory.DataValueField = "Code";
                                fullTimerCategory.DataTextField = "Description";
                                fullTimerCategory.DataBind();

                                var partTimeCategories = nav.HRCategories;
                                partTimerCategory.DataSource = partTimeCategories;
                                partTimerCategory.DataValueField = "Code";
                                partTimerCategory.DataTextField = "Description";
                                partTimerCategory.DataBind();

                                var adminStaffCategories = nav.HRCategories;
                                administrativeStaffCategory.DataSource = adminStaffCategories;
                                administrativeStaffCategory.DataValueField = "Code";
                                administrativeStaffCategory.DataTextField = "Description";
                                administrativeStaffCategory.DataBind();

                                var academicLevels = nav.AcademicLevels;
                                developmentTrainingCategory.DataSource = academicLevels;
                                developmentTrainingCategory.DataValueField = "Code";
                                developmentTrainingCategory.DataTextField = "Level_Name";
                                developmentTrainingCategory.DataBind();
                                developmentTrainingYear.DataSource = new Config().GetYears();
                                developmentTrainingYear.DataBind();
                                
                            }
                        }
                        else if (myStep == 5)
                        {
                            //,,
                            if (!IsPostBack)
                            {
                                var sourcesOfIncomeList = nav.Financial_Setups;
                                sourceOfIncome.DataSource = sourcesOfIncomeList;
                                sourceOfIncome.DataValueField = "id";
                                sourceOfIncome.DataTextField = "description";
                                sourceOfIncome.DataBind();
                                sourceOfIncomeYear.DataSource = new Config().GetYears();
                                sourceOfIncomeYear.DataBind();
                                var creditorsList = nav.Financial_Setups;
                                universityCreditor.DataSource = creditorsList;
                                universityCreditor.DataValueField = "id";
                                universityCreditor.DataTextField = "description";
                                universityCreditor.DataBind();
                                var debtorsList = nav.Financial_Setups;
                                universityDebtor.DataSource = debtorsList;
                                universityDebtor.DataValueField = "id";
                                universityDebtor.DataTextField = "description";
                                universityDebtor.DataBind();
                                universityCreditorYear.DataSource = new Config().GetYears();
                                universityCreditorYear.DataBind();
                                universityDebtorYear.DataSource = new Config().GetYears();
                                universityDebtorYear.DataBind();
                                operationBudgetYear.DataSource = new Config().GetYears();
                                operationBudgetYear.DataBind();
                                debtEquityYear.DataSource = new Config().GetYears();
                                debtEquityYear.DataBind();
                                researchBudgetaryYear.DataSource = new Config().GetYears();
                                researchBudgetaryYear.DataBind();
                                researchAttractedYear.DataSource = new Config().GetYears();
                                researchAttractedYear.DataBind();
                                libraryBudgetaryYear.DataSource = new Config().GetYears();
                                libraryBudgetaryYear.DataBind();
                                allocationActualYear.DataSource = new Config().GetYears();
                                allocationActualYear.DataBind();
                                var budgetActuals = nav.BudgetAndActual;
                                foreach (var budgetActual in budgetActuals)
                                {
                                    string type = "";
                                    //,,,,
                                    /*if (type == "Operation Budget")
                                    {
                                        operationBudgetYear1.Text = budgetActual.Year_1_Budget_Allocation + "";
                                        operationActualYear1.Text = budgetActual.Year_1_Actual_Expenditure + "";
                                        operationBudgetYear2.Text = budgetActual.Year_2_Budget_Allocation + "";
                                        operationActualYear2.Text = budgetActual.Year_2_Actual_Expenditure + "";
                                        operationBudgetYear3.Text = budgetActual.Year_3_Budget_Allocation + "";
                                        operationActualYear3.Text = budgetActual.Year_3_Actual_Expenditure + "";
                                        operationBudgetYear4.Text = budgetActual.Year_4_Budget_Allocation + "";
                                        operationActualYear4.Text = budgetActual.Year_4_Actual_Expenditure + "";
                                        operationBudgetYear5.Text = budgetActual.Year_5_Budget_Allocation + "";
                                        operationActualYear5.Text = budgetActual.Year_5_Actual_Expenditure + "";
                                    }
                                    else if (type == "Research Budgetary Allocation")
                                    {
                                        researchBudgetYear1.Text = budgetActual.Year_1_Budget_Allocation + "";
                                        researchActualYear1.Text = budgetActual.Year_1_Actual_Expenditure + "";
                                        researchBudgetYear2.Text = budgetActual.Year_2_Budget_Allocation + "";
                                        researchActualYear2.Text = budgetActual.Year_2_Actual_Expenditure + "";
                                        researchBudgetYear3.Text = budgetActual.Year_3_Budget_Allocation + "";
                                        researchActualYear3.Text = budgetActual.Year_3_Actual_Expenditure + "";
                                        researchBudgetYear4.Text = budgetActual.Year_4_Budget_Allocation + "";
                                        researchActualYear4.Text = budgetActual.Year_4_Actual_Expenditure + "";
                                        researchBudgetYear5.Text = budgetActual.Year_5_Budget_Allocation + "";
                                        researchActualYear5.Text = budgetActual.Year_5_Actual_Expenditure + "";
                                    }
                                    else if (type == "Money Attracted for Research")
                                    {
                                        researchAttractedBudgetYear1.Text = budgetActual.Year_1_Budget_Allocation + "";
                                        researchAttractedActualYear1.Text = budgetActual.Year_1_Actual_Expenditure + "";
                                        researchAttractedBudgetYear2.Text = budgetActual.Year_2_Budget_Allocation + "";
                                        researchAttractedActualYear2.Text = budgetActual.Year_2_Actual_Expenditure + "";
                                        researchAttractedBudgetYear3.Text = budgetActual.Year_3_Budget_Allocation + "";
                                        researchAttractedActualYear3.Text = budgetActual.Year_3_Actual_Expenditure + "";
                                        researchAttractedBudgetYear4.Text = budgetActual.Year_4_Budget_Allocation + "";
                                        researchAttractedActualYear4.Text = budgetActual.Year_4_Actual_Expenditure + "";
                                        researchAttractedBudgetYear5.Text = budgetActual.Year_5_Budget_Allocation + "";
                                        researchAttractedActualYear5.Text = budgetActual.Year_5_Actual_Expenditure + "";
                                    }
                                    else if (type == "Library Budgetary Allocation")
                                    {
                                        libraryBudgetYear1.Text = budgetActual.Year_1_Budget_Allocation + "";
                                        libraryActualYear1.Text = budgetActual.Year_1_Actual_Expenditure + "";
                                        libraryBudgetYear2.Text = budgetActual.Year_2_Budget_Allocation + "";
                                        libraryActualYear2.Text = budgetActual.Year_2_Actual_Expenditure + "";
                                        libraryBudgetYear3.Text = budgetActual.Year_3_Budget_Allocation + "";
                                        libraryActualYear3.Text = budgetActual.Year_3_Actual_Expenditure + "";
                                        libraryBudgetYear4.Text = budgetActual.Year_4_Budget_Allocation + "";
                                        libraryActualYear4.Text = budgetActual.Year_4_Actual_Expenditure + "";
                                        libraryBudgetYear5.Text = budgetActual.Year_5_Budget_Allocation + "";
                                        libraryActualYear5.Text = budgetActual.Year_5_Actual_Expenditure + "";
                                    }
                                    else if (type == "Allocation and Actual Expenditure")
                                    {
                                        budgetaryYear1.Text = budgetActual.Year_1_Budget_Allocation + "";
                                        allocationYear1.Text = budgetActual.Year_1_Actual_Expenditure + "";
                                        budgetaryYear2.Text = budgetActual.Year_2_Budget_Allocation + "";
                                        allocationYear2.Text = budgetActual.Year_2_Actual_Expenditure + "";
                                        budgetaryYear3.Text = budgetActual.Year_3_Budget_Allocation + "";
                                        allocationYear3.Text = budgetActual.Year_3_Actual_Expenditure + "";
                                        budgetaryYear4.Text = budgetActual.Year_4_Budget_Allocation + "";
                                        allocationYear4.Text = budgetActual.Year_4_Actual_Expenditure + "";
                                        budgetaryYear5.Text = budgetActual.Year_5_Budget_Allocation + "";
                                        allocationYear5.Text = budgetActual.Year_5_Actual_Expenditure + "";
                                    }
                                    else if (type == "Debt Equity Assets Liabilities")
                                    {
                                        totalDebtYear1.Text = budgetActual.Year_1_Debt + "";
                                        totalEquityYear1.Text = budgetActual.Year_1_Equity + "";
                                        currentAssetsYear1.Text = budgetActual.Year_1_Current_Assets + "";
                                        currentLiabilitiesYear1.Text = budgetActual.Year_1_Current_Liabilities + "";
                                        totalDebtYear2.Text = budgetActual.Year_2_Debt + "";
                                        totalEquityYear2.Text = budgetActual.Year_2_Equity + "";
                                        currentAssetsYear2.Text = budgetActual.Year_2_Current_Assets + "";
                                        currentLiabilitiesYear2.Text = budgetActual.Year_2_Current_Liabilities + "";
                                        totalDebtYear3.Text = budgetActual.Year_3_Debt + "";
                                        totalEquityYear3.Text = budgetActual.Year_3_Equity + "";
                                        currentAssetsYear3.Text = budgetActual.Year_3_Current_Assets + "";
                                        currentLiabilitiesYear3.Text = budgetActual.Year_3_Current_Liabilities + "";
                                        totalDebtYear4.Text = budgetActual.Year_4_Debt + "";
                                        totalEquityYear4.Text = budgetActual.Year_4_Equity + "";
                                        currentAssetsYear4.Text = budgetActual.Year_4_Current_Assets + "";
                                        currentLiabilitiesYear4.Text = budgetActual.Year_4_Current_Liabilities + "";
                                        totalDebtYear5.Text = budgetActual.Year_5_Debt + "";
                                        totalEquityYear5.Text = budgetActual.Year_5_Equity + "";
                                        currentAssetsYear5.Text = budgetActual.Year_5_Current_Assets + "";
                                        currentLiabilitiesYear5.Text = budgetActual.Year_5_Current_Liabilities + "";

                                    }*/
                                }
                            }
                        }
                        else if (myStep == 6)
                        {
                            if (!IsPostBack)
                            {
                                var academicLevels = nav.AcademicLevels;
                                // Code
                                academicLeaderHighestQualification.DataSource = academicLevels;
                                academicLeaderHighestQualification.DataValueField = "Code";
                                academicLeaderHighestQualification.DataTextField = "Level_Name";
                                academicLeaderHighestQualification.DataBind();

                                kenyaInternationalProgrammeLevel.DataSource = academicLevels;
                                kenyaInternationalProgrammeLevel.DataValueField = "Code";
                                kenyaInternationalProgrammeLevel.DataTextField = "Level_Name";
                                kenyaInternationalProgrammeLevel.DataBind();

                                var categories = nav.HRCategories;
                                qualityAcademicStaffCategory.DataSource = categories;
                                qualityAcademicStaffCategory.DataValueField = "Code";
                                qualityAcademicStaffCategory.DataTextField = "Description";
                                qualityAcademicStaffCategory.DataBind();
                                List<string> accreditationStatus = new List<string>();
                                accreditationStatus.Add("CUE Accredited");
                                accreditationStatus.Add("Senate approved");
                                programmeAccreditationStatus.DataSource = accreditationStatus;
                                programmeAccreditationStatus.DataBind();
                                var faculties =
                                    nav.UniversitySchoolsFaculties.Where(
                                        r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                                programmeSchool.DataSource = faculties;
                                programmeSchool.DataValueField = "School_Code";
                                programmeSchool.DataTextField = "School_Name";
                                programmeSchool.DataBind();

                                collaboratingSchool.DataSource = faculties;
                                collaboratingSchool.DataValueField = "School_Code";
                                collaboratingSchool.DataTextField = "School_Name";
                                collaboratingSchool.DataBind();

                                qualityAcademicAgeBracket.DataSource = nav.AgeBrackets;
                                qualityAcademicAgeBracket.DataValueField = "Code";
                                qualityAcademicAgeBracket.DataTextField = "Age_Bracket";
                                qualityAcademicAgeBracket.DataBind();
                            }
                        }
                    }
                    }

                
                //qa
            }
            catch (Exception)
            {
                Response.Redirect("InstitutionalQAList.aspx");
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
                    CheckBox isStakeHolder = (CheckBox) stakeholderCell.Controls[0];
                    HtmlTableCell engagedCell = cells[2]; //is engaged
                    CheckBox isEngaged = (CheckBox)engagedCell.Controls[0];
                    HtmlTableCell analyzedcell = cells[3]; //is engaged
                    CheckBox isAnalyzed = (CheckBox)analyzedcell.Controls[0];
                    string stakeHolderCode = isStakeHolder.ID.Replace("isstakeholder", "");
                    string qaNo = Request.QueryString["qa"].Trim();
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
                string tStakeholder = otherStakeHolderName.Text.Trim();
                bool tstakeengaged = false;
                bool tanalyzeneeds = false;
                if (analyzeneeds.Checked==true)
                {
                    tanalyzeneeds = true;
                }
                if(stakeengaged.Checked== true)
                {
                    tstakeengaged = true;
                }
                string qaNo = Request.QueryString["qa"].Trim();
                string status = new Config().ObjNav()
                        .AddNewStakeHolder(qaNo, tStakeholder, tstakeengaged, tanalyzeneeds, Convert.ToString(Session["Code"]), Convert.ToString(Session["Password"]));
                      string[] info = status.Split('*');
                     feedbackOthers.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        stakeHolderStrength.Text = "";
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
        string tStrength = stakeHolderStrength.Text.Trim();
                if (string.IsNullOrEmpty(tStrength))
                {
                    strengthWeaknessFeedback.InnerHtml = Config.GetAlert("danger","Please provide a valid value for stakeholder strength");
                }
                else
                {
            string qaNo = Request.QueryString["qa"].Trim();
            string status = new Config().ObjNav()
                        .AddStrengthOrWeakness(qaNo, 0, tStrength, Convert.ToString(Session["Code"]),
                            Convert.ToString(Session["Password"]));
            string[] info = status.Split('*');
                    strengthWeaknessFeedback.InnerHtml = Config.GetAlert(info[0],info[1]);
                    if (info[0]=="success")
                    {
                        stakeHolderStrength.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                strengthWeaknessFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }

        protected void addStakeHolderWeakness_Click(object sender, EventArgs e)
        {
            try
            {
        string tWeakness = stakeholderWeakness.Text.Trim();
                if (string.IsNullOrEmpty(tWeakness))
                {
                    strengthWeaknessFeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for stakeholder weakness");
                }
                else
                {
            string qaNo = Request.QueryString["qa"].Trim();
            string status = new Config().ObjNav()
                        .AddStrengthOrWeakness(qaNo, 1, tWeakness, Convert.ToString(Session["Code"]),
                            Convert.ToString(Session["Password"]));
            string[] info = status.Split('*');
                    strengthWeaknessFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        stakeholderWeakness.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                strengthWeaknessFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }

        protected void addCouncilCommittee_Click(object sender, EventArgs e)
        {
            try
            {
        string tCommittee = councilName.Text.Trim();
                if (string.IsNullOrEmpty(tCommittee))
                {
                    governanceFeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for the council committee name");
                }
                else
                {
            string qaNo = Request.QueryString["qa"].Trim();
            string status = new Config().ObjNav()
                        .AddSARCommitteesComposition(qaNo, 2, tCommittee,1, Convert.ToString(Session["Code"]),
                            Convert.ToString(Session["Password"]));
            string[] info = status.Split('*');
                    governanceFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        councilName.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                governanceFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }

        protected void addSenateComposition_Click(object sender, EventArgs e)
        {
            try
            {
        string tCommittee = senateComposition.Text.Trim();
                if (string.IsNullOrEmpty(tCommittee))
                {
                    governanceFeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for the council committee name");
                }
                else
                {
            string qaNo = Request.QueryString["qa"].Trim();
            string status = new Config().ObjNav()
                        .AddSARCommitteesComposition(qaNo, 1, tCommittee, 0, Convert.ToString(Session["Code"]),
                            Convert.ToString(Session["Password"]));
            string[] info = status.Split('*');
                    governanceFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        senateComposition.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                governanceFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }

        protected void addSenateCommittee_Click(object sender, EventArgs e)
        {
            try
            {
        string tCommittee = senateCommitteeName.Text.Trim();
                if (string.IsNullOrEmpty(tCommittee))
                {
                    governanceFeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for the council committee name");
                }
                else
                {
            string qaNo = Request.QueryString["qa"].Trim();
            string status = new Config().ObjNav()
                        .AddSARCommitteesComposition(qaNo, 1, tCommittee, 1, Convert.ToString(Session["Code"]),
                            Convert.ToString(Session["Password"]));
            string[] info = status.Split('*');
                    governanceFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        senateCommitteeName.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                governanceFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }

        protected void addUmbComposition_Click(object sender, EventArgs e)
        {
            try
            {
        string tCommittee = umbCompositionName.Text.Trim();
                if (string.IsNullOrEmpty(tCommittee))
                {
                    governanceFeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for the council committee name");
                }
                else
                {
            string qaNo = Request.QueryString["qa"].Trim();
            string status = new Config().ObjNav()
                        .AddSARCommitteesComposition(qaNo, 0, tCommittee, 0, Convert.ToString(Session["Code"]),
                            Convert.ToString(Session["Password"]));
            string[] info = status.Split('*');
                    governanceFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        umbCompositionName.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                governanceFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }

        protected void addUmbCommittee_Click(object sender, EventArgs e)
        {
            try
            {
        string tCommittee = umbCommitteeName.Text.Trim();
                if (string.IsNullOrEmpty(tCommittee))
                {
                    governanceFeedback.InnerHtml = Config.GetAlert("danger", "Please provide a valid value for the council committee name");
                }
                else
                {
            string qaNo = Request.QueryString["qa"].Trim();
            string status = new Config().ObjNav()
                        .AddSARCommitteesComposition(qaNo, 0, tCommittee, 1, Convert.ToString(Session["Code"]),
                            Convert.ToString(Session["Password"]));
            string[] info = status.Split('*');
                    governanceFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        umbCommitteeName.Text = "";
                    }
                }
            }
            catch (Exception y)
            {
                governanceFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }

        protected void addTrusteeMember_Click(object sender, EventArgs e)
        {

            try
            {

        //  
        string tMemberName = trusteeName.Text.Trim();
        string tHighestAcademic = trusteeHighestAcademicQualification.SelectedValue;
                DateTime tAppointment = new DateTime();
        string tNationality = trusteeNationality.SelectedValue;
                Boolean error = false;
        string message = "";
                if (string.IsNullOrEmpty(tMemberName))
                {
                    error = true;
                    message =  "Please provide a valid value for the trustee name";
                }
                try
                {
                    tAppointment = DateTime.ParseExact(trusteeDateOfAppointment.Text.Trim(), "d/M/yyyy",
                        CultureInfo.InvariantCulture);
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please provide a valid value for trustee date of appointment";
                }
                if (error)
                {
                    governanceFeedback.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
            string qaNo = Request.QueryString["qa"].Trim();
            string status = new Config().ObjNav()
                        .AddTrusteeSenateComposition(qaNo, 3, tMemberName, 0, Convert.ToString(Session["Code"]),
                            Convert.ToString(Session["Password"]),tHighestAcademic, tAppointment, tNationality);
            string[] info = status.Split('*');
                    governanceFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        trusteeName.Text = "";
                        trusteeDateOfAppointment.Text = "";
                        trusteeHighestAcademicQualification.SelectedIndex = 0;
                        trusteeNationality.SelectedIndex = 0;
                    }
                }
            }
            catch (Exception y)
            {
                governanceFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }

        protected void councilAddMember_Click(object sender, EventArgs e)
        {
            try
            {

        //  
        string tMemberName = councilMemberName.Text.Trim();
        string tHighestAcademic = councilHighestAcademic.SelectedValue;
                DateTime tAppointment = new DateTime();
        string tNationality = councilNationality.SelectedValue;
                Boolean error = false;
        string message = "";
                if (string.IsNullOrEmpty(tMemberName))
                {
                    error = true;
                    message = "Please provide a valid value for the council member name";
                }
                try
                {
                    tAppointment = DateTime.ParseExact(councilDateOfAppointment.Text.Trim(), "d/M/yyyy",
                        CultureInfo.InvariantCulture);
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please provide a valid value for council member date of appointment";
                }
                if (error)
                {
                    governanceFeedback.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
            string qaNo = Request.QueryString["qa"].Trim();
            string status = new Config().ObjNav()
                        .AddTrusteeSenateComposition(qaNo, 2, tMemberName, 0, Convert.ToString(Session["Code"]),
                            Convert.ToString(Session["Password"]), tHighestAcademic, tAppointment, tNationality);
            string[] info = status.Split('*');
                    governanceFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        councilMemberName.Text = "";
                        councilDateOfAppointment.Text = "";
                        councilHighestAcademic.SelectedIndex = 0;
                        councilNationality.SelectedIndex = 0;
                    }
                }
            }
            catch (Exception y)
            {
                governanceFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }

        protected void addFullTimeStaff_Click(object sender, EventArgs e)
        {
            try
            {
                Boolean error = false;
        string message = "";
        string tCategory = fullTimerCategory.SelectedValue;
                int tMale = 0;
                int tFemale = 0;
                int tNoFullEstablishment = 0;
                try
                {
                    tMale = Convert.ToInt32(fullTimerMale.Text.Trim());
                    if (tMale < 0)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please provide a valid value for no of male";
                }
                try
                {
                    tFemale = Convert.ToInt32(fullTimerfemale.Text.Trim());
                    if (tFemale < 0)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please provide a valid value for no of female staff";
                }
                try
                {
                    tNoFullEstablishment = Convert.ToInt32(fullTimerNoFullEstablishment.Text.Trim());
                    if (tNoFullEstablishment < 0)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please provide a valid value for No. at Full Establishment";
                }
                if (!error)
                {
            string qaNo = Request.QueryString["qa"].Trim();
            string status = new Config().ObjNav()
                        .AddHRSummary(qaNo, 0, tCategory, tNoFullEstablishment, tMale, tFemale,
                            Convert.ToString(Session["Code"]),
                            Convert.ToString(Session["Password"]));
            string[] info = status.Split('*');
                    hrSummaryFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                }
                else
                {
                    hrSummaryFeedback.InnerHtml = Config.GetAlert("danger", message);
                }
            }
            catch (Exception y)
            {
                hrSummaryFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }

        protected void addPartTimeStaff_Click(object sender, EventArgs e)
        {
            try
            {
                Boolean error = false;
        string message = "";
        string tCategory = partTimerCategory.SelectedValue;
                int tMale = 0;
                int tFemale = 0;
                int tNoFullEstablishment = 0;
                try
                {
                    tMale = Convert.ToInt32(partTimerMale.Text.Trim());
                    if (tMale < 0)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please provide a valid value for no of male";
                }
                try
                {
                    tFemale = Convert.ToInt32(partTimerfemale.Text.Trim());
                    if (tFemale < 0)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please provide a valid value for no of female staff";
                }
                
                if (!error)
                {
            string qaNo = Request.QueryString["qa"].Trim();
            string status = new Config().ObjNav()
                        .AddHRSummary(qaNo, 1, tCategory, tNoFullEstablishment, tMale, tFemale,
                            Convert.ToString(Session["Code"]),
                            Convert.ToString(Session["Password"]));
            string[] info = status.Split('*');
                    hrSummaryFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                }
                else
                {
                    hrSummaryFeedback.InnerHtml = Config.GetAlert("danger", message);
                }
            }
            catch (Exception y)
            {
                hrSummaryFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }

        protected void addAdministrativeStaff_Click(object sender, EventArgs e)
        {
            try
            {
                Boolean error = false;
        string message = "";
        string tCategory = administrativeStaffCategory.SelectedValue;
                int tMale = 0;
                int tFemale = 0;
                int tNoFullEstablishment = 0;
                try
                {
                    tMale = Convert.ToInt32(administrativeMale.Text.Trim());
                    if (tMale < 0)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please provide a valid value for no of male";
                }
                try
                {
                    tFemale = Convert.ToInt32(administrativefemale.Text.Trim());
                    if (tFemale < 0)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please provide a valid value for no of female staff";
                }
               
                if (!error)
                {
            string qaNo = Request.QueryString["qa"].Trim();
            string status = new Config().ObjNav()
                        .AddHRSummary(qaNo, 2, tCategory, tNoFullEstablishment, tMale, tFemale,
                            Convert.ToString(Session["Code"]),
                            Convert.ToString(Session["Password"]));
            string[] info = status.Split('*');
                    hrSummaryFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                }
                else
                {
                    hrSummaryFeedback.InnerHtml = Config.GetAlert("danger", message);
                }
            }
            catch (Exception y)
            {
                hrSummaryFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }

        protected void addDevelopmentTraining_Click(object sender, EventArgs e)
        {
            try
            {
                Boolean error = false;
                string message = "";
                string tCategory = developmentTrainingCategory.SelectedValue.Trim();
                int tMale = 0,
                    tFemale = 0,
                    year = 0;
                try
                {
                    tMale = Convert.ToInt32(developmentTrainingMale.Text.Trim());
                    if (tMale < 0)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter a valid value for Male";
                }
                try
                {
                    tFemale = Convert.ToInt32(developmentTrainingFemale.Text.Trim());
                    if (tFemale < 0)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter a valid value for FeMale";
                }
                try
                {
                    year = Convert.ToInt32(developmentTrainingYear.SelectedValue);
                    if (year < 0)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please select the year";
                }
               
                if (error)
                {
                    hrSummaryFeedback.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
            string qaNo = Request.QueryString["qa"].Trim();
            string status = new Config().ObjNav()
                        .AddDevelopmentTraining(qaNo, tCategory, year, tMale, tFemale,  Convert.ToString(Session["Code"]),
                            Convert.ToString(Session["Password"]));
            string[] info = status.Split('*');
                    hrSummaryFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                }
            }
            catch (Exception y)
            {
                hrSummaryFeedback.InnerHtml = Config.GetAlert("danger", y.Message);
            }
        }

        protected void addSourceOfIncome_Click(object sender, EventArgs e)
        {
            try
            {
        string qaNo = Request.QueryString["qa"].Trim();
                Boolean error = false;
        string message = "";
                int tSource = 0;
                try
                {
                    tSource = Convert.ToInt32(sourceOfIncome.SelectedValue.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please select the source of income";
                }
                int year = 0;
                Decimal
                    tExpected = 0,
                    tActual = 0;
               // double , incomeSourceActual1
                try
                {
                    tExpected = Convert.ToDecimal(incomeSourceExpected.Text.Trim());
                }
                catch (Exception t)
                {
                    error = true;
                    message = "Please enter a valid value for  expected income";
                }
                try
                {
                    tActual = Convert.ToDecimal(incomeSourceActual.Text.Trim());
                }
                catch (Exception t)
                {
                    error = true;
                    message = "Please enter a valid value for  actual income";
                }

                try
                {
                    year = Convert.ToInt32(sourceOfIncomeYear.SelectedValue);
                }
                catch (Exception t)
                {
                    error = true;
                    message = "Please select the year";
                }
               
                if (error)
                {
                    revenueFeedback.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
            string status = new Config().ObjNav().AddSourceOfIncome(qaNo,tSource, year, tExpected, tActual, Convert.ToString(Session["Code"]),
                            Convert.ToString(Session["Password"]));
            string[] info = status.Split('*');
                    revenueFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0]=="success")
                    {
                        sourceOfIncome.SelectedIndex = 0;
                        sourceOfIncomeYear.SelectedIndex = 0;
                        incomeSourceActual.Text = "";
                        incomeSourceExpected.Text = "";
                    }
                }
            }
            catch (Exception m)
            {
                revenueFeedback.InnerHtml = Config.GetAlert("danger", m.Message);
            }
        }

        protected void addCreditor_Click(object sender, EventArgs e)
        {
            try
            {
        string qaNo = Request.QueryString["qa"].Trim();
                Boolean error = false;//  universityCreditorYear
        string message = "";
                int creditorCode = 0;
                int tYear = 0;
                  Decimal  amount = 0;
           
                try
                {
                    creditorCode = Convert.ToInt32(universityCreditor.SelectedValue);
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please select the creditor";
                }
                try
                {
                    tYear = Convert.ToInt32(universityCreditorYear.SelectedValue.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please select the year";
                }
                try
                {
                    amount = Convert.ToDecimal(universityCreditorAmount.Text.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please enter a valid value for  amount";
                }
               
                if (error)
                {
                    revenueFeedback.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
            //add to nav
            string status =new Config().ObjNav().AddCreditorsDebtors(qaNo,1,creditorCode,tYear, amount);
            string[] info = status.Split('*');
                    revenueFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0]=="success")
                    {
                        universityCreditor.SelectedIndex = 0;
                        universityCreditorYear.SelectedIndex = 0;
                        universityCreditorAmount.Text = "";
                    }
                }
            }
            catch (Exception m)
            {
                revenueFeedback.InnerHtml = Config.GetAlert("danger", m.Message);
            }
        }

        protected void addDebtor_Click(object sender, EventArgs e)
        {
            try
            {
        string qaNo = Request.QueryString["qa"].Trim();
                Boolean error = false;//  universityCreditorYear
        string message = "";
                int debtorCode = 0;
                int tYear = 0;
                Decimal amount = 0;

                try
                {
                    debtorCode = Convert.ToInt32(universityDebtor.SelectedValue);
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please select the debtor";
                }
                try
                {
                    tYear = Convert.ToInt32(universityDebtorYear.SelectedValue.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please select the year";
                }
                try
                {
                    amount = Convert.ToDecimal(universityDebtorAmount.Text.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please enter a valid value for  amount";
                }

                if (error)
                {
                    revenueFeedback.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
            //add to nav
            string status = new Config().ObjNav().AddCreditorsDebtors(qaNo, 0, debtorCode, tYear, amount);
            string[] info = status.Split('*');
                    revenueFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0] == "success")
                    {
                        universityCreditor.SelectedIndex = 0;
                        universityCreditorYear.SelectedIndex = 0;
                        universityCreditorAmount.Text = "";
                    }
                }
            }
            catch (Exception m)
            {
                revenueFeedback.InnerHtml = Config.GetAlert("danger", m.Message);
            }
        }

        protected void addProgramme_Click(object sender, EventArgs e)
        {
            try
            {
        string qaNo = Request.QueryString["qa"].Trim();
        string tProgrammeName = "";
                int tAccreditationStatus = 0;
                int tHighestQualification = 0;
                Decimal tDuration = 0;
                Boolean error = false;
        string message = "";
                try
                {
                    tProgrammeName = programmeName.Text.Trim();
                    if (tProgrammeName.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please enter the programme name";
                }
                try
                {
                    tAccreditationStatus = programmeAccreditationStatus.SelectedIndex;
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please select the programme accreditation status";
                }
                try
                {
                    tHighestQualification = Convert.ToInt32(academicLeaderHighestQualification.SelectedValue);
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please select the Highest Academic Qualification of Academic Leader";
                }
                try
                {
                    tDuration = Convert.ToDecimal(programmeDuration.Text.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please enter a valid programme duration in months";
                }

                if (error)
                {
                    academicProgrammesFeedback.InnerHtml = Config.GetAlert("danger",message);
                }
                else
                {
            string status = new Config().ObjNav()
                        .AddQaAcademicProgramme(qaNo, tProgrammeName, tAccreditationStatus, tHighestQualification,
                            tDuration);
            string[] info = status.Split('*');
                    academicProgrammesFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0]=="success")
                    {
                        programmeName.Text = "";
                        programmeAccreditationStatus.SelectedIndex = 0;
                        academicLeaderHighestQualification.SelectedIndex = 0;
                        programmeDuration.Text = "";
                    }
                }

            }
            catch (Exception t)
            {
                academicProgrammesFeedback.InnerHtml = Config.GetAlert("danger", t.Message);
            }

        }

        

        protected void saveOperationBudget_Click(object sender, EventArgs e)
        {
            try
            {
        string qaNo = Request.QueryString["qa"].Trim();
                int year = 0;
                Decimal budget = 0,
                    actual = 0;
                Boolean error = false;
        string message = "";
                //   
                try
                {
                    year = Convert.ToInt32(operationBudgetYear.SelectedValue);
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please select the year";
                } try
                {
                    budget = Convert.ToDecimal(operationBudget.Text.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please enter a valid value for budgeted amount";
                }
                try
                {
                    actual = Convert.ToDecimal(actualExpenditure.Text.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please enter a valid value for actual amount";
                }

                

                if (error)
                {
                    revenueFeedback.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
            string status = new Config().ObjNav().AddActualBudget(qaNo,0,year, budget, actual, Convert.ToString(Session["Code"]),
                            Convert.ToString(Session["Password"]));
            string[] info = status.Split('*');
                    revenueFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                }
            }
            catch (Exception m)
            {
                revenueFeedback.InnerHtml = Config.GetAlert("danger", m.Message);
            }
        }

        protected void ResearchAttracted_Click(object sender, EventArgs e)
        {
            try
            {
        string qaNo = Request.QueryString["qa"].Trim();
                int year = 0; ;
                Decimal Budget = 0,
                    Actual = 0;
                Boolean error = false;
        string message = "";
                
                try
                {
                    year = Convert.ToInt32(researchAttractedYear.SelectedValue);
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please select the year";
                } try
                {
                   Budget = Convert.ToDecimal(researchAttractedAllocation.Text.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please enter a valid value for allocation amount";
                }
                try
                {
                   Actual = Convert.ToDecimal(researchAttractedExpenditure.Text.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please enter a valid value for Expenditure amount"; 
                }


                if (error)
                {
                    revenueFeedback.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
            string status = new Config().ObjNav().AddActualBudget(qaNo, 2,year,Budget, Actual, Convert.ToString(Session["Code"]),
                            Convert.ToString(Session["Password"]));
            string[] info = status.Split('*');
                    revenueFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                }
            }
            catch (Exception m)
            {
                revenueFeedback.InnerHtml = Config.GetAlert("danger", m.Message);
            }
        }

        protected void saveLibrary_Click(object sender, EventArgs e)
        {
            try
            {
        string qaNo = Request.QueryString["qa"].Trim();
                int year = 0;
                Decimal Budget = 0,
                    Actual = 0;
                Boolean error = false;
        string message = "";
                try
                {
                    year = Convert.ToInt32(libraryBudgetaryYear.SelectedValue);
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please select the year";
                } try
                {
                    Budget = Convert.ToDecimal(libraryBudgetaryAllocation.Text.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please enter a valid value for Budgetary Allocation amount";
                }
                try
                {
                    Actual = Convert.ToDecimal(libraryBudgetaryExpenditure.Text.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please enter a valid value for Expenditure amount";
                }
                if (error)
                {
                    revenueFeedback.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
            string status = new Config().ObjNav().AddActualBudget(qaNo, 3, year,Budget, Actual, Convert.ToString(Session["Code"]),
                            Convert.ToString(Session["Password"]));
            string[] info = status.Split('*');
                    revenueFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                }
            }
            catch (Exception m)
            {
                revenueFeedback.InnerHtml = Config.GetAlert("danger", m.Message);
            }
        }

        protected void saveAllocationActual_Click(object sender, EventArgs e)
        {
            try
            {
        string qaNo = Request.QueryString["qa"].Trim();
                int year = 0;
                Decimal Budget = 0,
                    Actual = 0;
                Boolean error = false;
        string message = "";
                try
                {
                    year = Convert.ToInt32(allocationActualYear.SelectedValue);
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please select the year";
                }try
                {
                    Budget = Convert.ToDecimal(allocationActualAllocation.Text.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please enter a valid value for Allocation amount";
                }
                try
                {
                    Actual = Convert.ToInt32(allocationActualExpenditure.Text.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please enter a valid value for Expenditure amount";
                }

                if (error)
                {
                    revenueFeedback.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
            string status = new Config().ObjNav().AddActualBudget(qaNo, 4, year,Budget,Actual,Convert.ToString(Session["Code"]),
                            Convert.ToString(Session["Password"]));
            string[] info = status.Split('*');
                    revenueFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                }
            }
            catch (Exception m)
            {
                revenueFeedback.InnerHtml = Config.GetAlert("danger", m.Message);
            }
        }

        protected void saveResearchAllocation_Click(object sender, EventArgs e)
        {
            try
            {
        string qaNo = Request.QueryString["qa"].Trim();
                int year = 0;
                Decimal Budget = 0,
                    Actual = 0;
                Boolean error = false;
        string message = "";
                try
                {
                    year = Convert.ToInt32(researchBudgetaryYear.SelectedValue);
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please select the year";
                }try
                {
                    Budget = Convert.ToDecimal(researchBudgetaryAllocation.Text.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please enter a valid value for allocation amount";
                }
                try
                {
                    Actual = Convert.ToDecimal(researchBudgetaryExpenditure.Text.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please enter a valid value for expenditure amount";
                }

                

                if (error)
                {
                    revenueFeedback.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
            string status = new Config().ObjNav().AddActualBudget(qaNo, 1,year, Budget, Actual, Convert.ToString(Session["Code"]),
                            Convert.ToString(Session["Password"]));
            string[] info = status.Split('*');
                    revenueFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                }
            }
            catch (Exception m)
            {
                revenueFeedback.InnerHtml = Config.GetAlert("danger", m.Message);
            }
        }

        protected void addDebtEuityAssetsLiabilities_Click(object sender, EventArgs e)
        {
            
            try
            {
        string qaNo = Request.QueryString["qa"].Trim();
                int year = 0;
                Decimal Debt = 0,
                   Equity = 0,
                    Assets = 0,
                    Liabilities = 0;
                Boolean error = false;
        string message = "";
             
                try
                {
                    year = Convert.ToInt32(debtEquityYear.SelectedValue);
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please select the year";
                }try
                {
                   Debt = Convert.ToDecimal(totalDebt.Text.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please enter a valid value for  total debt amount";
                }
                try
                {
                   Equity = Convert.ToDecimal(totalEquity.Text.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please enter a valid value for equity amount";
                }try
                {
                    Assets = Convert.ToDecimal(currentAssets.Text.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please enter a valid value for  current assets";
                }
                try
                {
                    Liabilities = Convert.ToDecimal(currentLiabilities.Text.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please enter a valid value for current liabilities";
                }
               
                if (error)
                {
                    revenueFeedback.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
            string status = new Config().ObjNav().AddDebtEquityCurrentAssetsLiabilities(qaNo, 5, year,Debt, Equity, Assets, Liabilities, Convert.ToString(Session["Code"]),Convert.ToString(Session["Password"]));
            string[] info = status.Split('*');
                    revenueFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                }
            }
            catch (Exception m)
            {
                revenueFeedback.InnerHtml = Config.GetAlert("danger", m.Message);
            }
           /* String status = new Config().ObjNav().Fngeneratecodes("CUST_19-20:001");
            String[] info = status.Split('*');
            revenueFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);*/
        }

        protected void addCollaborationProgramme_Click(object sender, EventArgs e)
        {
            try
            {//collaboratingSchool collaboratingProgrammeName collaboratingInstitution
        string qaNo = Request.QueryString["qa"].Trim();
                Boolean error = false;
        string message = "";
                int tSchool = 0;
        string tProgrammeName = "";
        string tCollaboratingInstitution = "";
                try
                {
                    tSchool = Convert.ToInt32(collaboratingSchool.SelectedValue.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please select the School/Faculty offering the academic programme under collaboration";
                }
                try
                {
                    tProgrammeName = collaboratingProgrammeName.Text.Trim();
                    if (tProgrammeName.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please enter the academic programme being offered under collaboration";

                } try
                {
                    tCollaboratingInstitution = collaboratingInstitution.Text.Trim();
                    if (tCollaboratingInstitution.Length < 1)
                    {
                        throw new Exception();
                    }
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please enter the collaborating institution";

                }
                if (error)
                {
                    academicProgrammesFeedback.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
            string status = new Config().ObjNav()
                        .AddQaCollaboratingAcademicProgramme(qaNo, tSchool, tProgrammeName, tCollaboratingInstitution);
            string[] info = status.Split('*');
                    academicProgrammesFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0]=="success")
                    {
                        collaboratingInstitution.Text = "";
                        collaboratingProgrammeName.Text = "";
                        collaboratingSchool.SelectedIndex = 0;
                    }
                }
            }
            catch (Exception m)
            {
                academicProgrammesFeedback.InnerHtml = Config.GetAlert("danger", m.Message);
            } 
        }
        protected void addSchoolSummary_Click(object sender, EventArgs e)
        {
            try
            {
        string qaNo = Request.QueryString["qa"].Trim();
                int schoolCode = 0;
                int phd = 0;
                int masters = 0;
                int pgd = 0;
                int bachelors = 0;
                int diploma = 0;
                int certificate = 0;
                Boolean error = false;
        string message = "";
                //programmeSchool schoolPhdSummary schoolMastersSummary schoolPGDSummary schoolBachelorsSummary
                //schoolDiplomaSummary schoolCertificateSummary
                try
                {
                    schoolCode = Convert.ToInt32(programmeSchool.SelectedValue.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please select the school";
                }
                try
                {
                    phd = Convert.ToInt32(schoolPhdSummary.Text.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please enter a valid value No. of PHD Programmes";
                }
                try
                {
                    masters = Convert.ToInt32(schoolMastersSummary.Text.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please enter a valid value No. of Masters Programmes";
                }try
                {
                    pgd = Convert.ToInt32(schoolPGDSummary.Text.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please enter a valid value No. of P.G.D. Programmes";
                }try
                {
                    bachelors = Convert.ToInt32(schoolBachelorsSummary.Text.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please enter a valid value No. of Bachelors Programmes";
                }try
                {
                    diploma = Convert.ToInt32(schoolDiplomaSummary.Text.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please enter a valid value No. of Diploma Programmes";
                }try
                {
                    certificate = Convert.ToInt32(schoolCertificateSummary.Text.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please enter a valid value No. of Certificate Programmes";
                }
                if (error)
                {
                    academicProgrammesFeedback.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
            string status = new Config().ObjNav()
                        .AddQaProgrammeSummary(qaNo, schoolCode, phd, masters, pgd, bachelors, diploma,certificate);
            string[] info = status.Split('*');
                    academicProgrammesFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0]=="success")
                    {
                        programmeSchool.SelectedIndex = 0;
                        schoolPhdSummary.Text = "";
                        schoolMastersSummary.Text = "";
                        schoolPGDSummary.Text = "";
                        schoolBachelorsSummary.Text = "";
                        schoolDiplomaSummary.Text = "";
                        schoolCertificateSummary.Text = "";
                    }
                }
            }
            catch (Exception m)
            {
                academicProgrammesFeedback.InnerHtml = Config.GetAlert("danger", m.Message);
            }
        }

        protected void addKenyanInternational_Click(object sender, EventArgs e)
        {
            try
            {
        string qaNo = Request.QueryString["qa"].Trim();
        //kenyaInternationalProgrammeLevel kenyanStudents internationalStudents
        string programLevel = "";
                int kenyan = 0;
                int international = 0;
                Boolean error = false;
        string message = "";
                try
                {
                    programLevel = kenyaInternationalProgrammeLevel.SelectedValue;
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please select the program level";
                }
                try
                {
                    kenyan = Convert.ToInt32(kenyanStudents.Text.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please enter the number of kenyan students";
                }try
                {
                    international = Convert.ToInt32(internationalStudents.Text.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please enter the number of international students";
                }
                if (error)
                {
                    academicProgrammesFeedback.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
            string status = new Config().ObjNav().AddKenyanInternationalStudents(qaNo, programLevel,kenyan, international);
            string[] info = status.Split('*');
                    academicProgrammesFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0]=="success")
                    {
                        kenyaInternationalProgrammeLevel.SelectedIndex = 0;
                        kenyanStudents.Text = "";
                        internationalStudents.Text = "";
                    }
                }
            }
            catch (Exception t)
            {
                academicProgrammesFeedback.InnerHtml = Config.GetAlert("danger", t.Message);
            }

        }

        protected void addQualityAcademicStaff_Click(object sender, EventArgs e)
        {
            try
            {
        string qaNo = Request.QueryString["qa"].Trim();
                int category = 0;
                int ageBracket = 0;
                int noOfStaff = 0;
                Boolean error = false;
        string message = "";
                try
                {
                    category = Convert.ToInt32(qualityAcademicStaffCategory.SelectedValue.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please select the staff category";
                }
                try
                {
                    ageBracket = Convert.ToInt32(qualityAcademicAgeBracket.SelectedValue.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please select the age bracket";
                } try
                {
                    noOfStaff = Convert.ToInt32(qualityAcademicNoofStaff.Text.Trim());
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br>" : "";
                    message += "Please enter the number of staff ";
                }
                   

                if (error)
                {
                    academicProgrammesFeedback.InnerHtml = Config.GetAlert("danger", message);
                }
                else
                {
            string status = new Config().ObjNav()
                        .AddAcademicStaffQuality(qaNo, category, ageBracket, noOfStaff);
            string[] info = status.Split('*');
                    academicProgrammesFeedback.InnerHtml = Config.GetAlert(info[0], info[1]);
                    if (info[0]=="success")
                    {
                        qualityAcademicStaffCategory.SelectedIndex = 0;
                        qualityAcademicAgeBracket.SelectedIndex = 0;
                        qualityAcademicNoofStaff.Text = "";
                    }
                }
            }
            catch (Exception t)
            {
                academicProgrammesFeedback.InnerHtml = Config.GetAlert("danger", t.Message);
            }
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string InsertQualityofAcademicStaff(List<General> cmpitems)
        {
            string tCategory = "";
            decimal tagebracket1 = 0;
            decimal tagebracket2 = 0;
            decimal tagebracket3 = 0;
            decimal tagebracket4 = 0;
            decimal tagebracket5 = 0;
            int jobCode = 0;
            bool error = false;
            string message = "";
            string results_0 = (dynamic)null;
            string results_1 = (dynamic)null;
            try
            {

                //Check for NULL.
                if (cmpitems == null)
                    cmpitems = new List<General>();

                //Loop and insert records.
                foreach (General oneitem in cmpitems)
                {
                    tCategory = oneitem.category;
                    tagebracket1 = oneitem.agebracket1;
                    tagebracket2 = oneitem.agebracket2;
                    tagebracket3 = oneitem.agebracket3;
                    tagebracket4 = oneitem.agebracket4;
                    tagebracket5 = oneitem.agebracket5;

                    //if (string.IsNullOrWhiteSpace(oneitems.Unit_Price.ToString(CultureInfo.InvariantCulture)))
                    //    return Json("unitpriceEmpty", JsonRequestBehavior.AllowGet);


                    //string status = new Config().ObjNav().AddPeerReviewersEvaluation(jobCode, Convert.ToString(HttpContext.Current.Session["PeerCode"]),
                    //    tComponent, tSubcomponent, tStrength, tWeakness, tReccommendation, tScore);
                    //string[] info = status.Split('*');
                    //results_0 = info[0];
                    //results_1 = info[1];
                }
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
            return results_0;
        }
    }
}