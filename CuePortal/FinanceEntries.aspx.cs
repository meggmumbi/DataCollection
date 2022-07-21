using Newtonsoft.Json;
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
    public partial class FinanceEntries : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = Config.ReturnNav();
                var financestartdates = nav.Accounting_Periods.ToList().OrderBy(r => r.Starting_Date);
                fnstartdate.DataSource = financestartdates;
                fnstartdate.DataValueField = "Starting_Date";
                fnstartdate.DataTextField = "Starting_Date";
                fnstartdate.DataTextFormatString = "{0:MMMM dd, yyyy}";
                fnstartdate.DataBind();

                var financeenddates = nav.Accounting_Periods.ToList().OrderBy(r => r.Starting_Date);
                fnenddate.DataSource = financeenddates;
                fnenddate.DataValueField = "Starting_Date";
                fnenddate.DataTextField = "Starting_Date";
                fnenddate.DataTextFormatString = "{0:MMMM dd, yyyy}";
                fnenddate.DataBind();

                string tfnstartdate = fnstartdate.SelectedValue;
                string tfnenddate = fnenddate.SelectedValue;
                Session["tfnstartdate"] = tfnstartdate;
                Session["tfnenddate"] = tfnenddate;

            }
        }
        protected void FinancialYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            string tfnstartdate = fnstartdate.SelectedValue;
            string tfnenddate = fnenddate.SelectedValue;
            Session["tfnstartdate"] = tfnstartdate;
            Session["tfnenddate"] = tfnenddate;
        }
        protected void previous_Click(object sender, EventArgs e)
        {
            int step = 1;
            try
            {
                step = Convert.ToInt32(Request.QueryString["step"].Trim());
            }
            catch (Exception)
            {
                step = 1;
            }
            step -= 1;
            Response.Redirect("FinanceEntries.aspx?step=" + step);
        }
        protected void next_Click(object sender, EventArgs e)
        {
            int step = 1;
            try
            {
                step = Convert.ToInt32(Request.QueryString["step"].Trim());
            }
            catch (Exception)
            {
                step = 1;
            }
            step += 1;
            Response.Redirect("FinanceEntries.aspx?step=" + step);
          
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string InsertIncome(List<Financials> finance)
        {
            var universityCode = HttpContext.Current.Session["UniversityCode"].ToString();
            HtmlGenericControl NewControl = new HtmlGenericControl();
            var results = (dynamic)null;
            int category = 0;
            try
            {
                if (finance == null)
                {
                    finance = new List<Financials>();
                }
                foreach (Financials finances in finance)
                {
                    string type = finances.source;
                    if (type == "Recurrent Allocation")
                        category = 6;
                    if (type == "Development Grants")
                        category = 7;
                    if (type == "Student Fees")
                        category = 8;
                    if (type == "Donations")
                        category = 9;
                    if (type == "Income Generating Units (IGUs)")
                        category = 10;
                    if (type == "Research Grants")
                        category = 11;
                    if (type == "Collaborating Institutions")
                        category = 12;
                    if (type == "Scholarships and Bursaries")
                        category = 13;
                    string currentYear = DateTime.Now.Year.ToString();
                 
                    int year = Convert.ToInt32(currentYear);
                    decimal expected = finances.expected;
                    decimal actual = finances.actual;
                    var userCode = HttpContext.Current.Session["Code"].ToString();
                    var password = HttpContext.Current.Session["Password"].ToString();
                    var financialstartdyear = HttpContext.Current.Session["tfnstartdate"].ToString();
                    var financialendyear = HttpContext.Current.Session["tfnenddate"].ToString();
                    var status = new Config().ObjNav().AddExpectedActualAmounts(universityCode, category, year, expected, actual, financialstartdyear, financialendyear,userCode, password);
                    string[] info = status.Split('*');
                    NewControl.ID = "feedbacksourcesincome";
                    NewControl.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    HttpContext.Current.Session["startyear"] = financialendyear;
                    HttpContext.Current.Session["endyear"] = financialstartdyear;
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
        public static string InsertCreditor(List<Financials> finance)
        {
            var universityCode = HttpContext.Current.Session["UniversityCode"].ToString();
            HtmlGenericControl NewControl = new HtmlGenericControl();
            var results = (dynamic)null;
            int category = 0;
            try
            {
                if (finance == null)
                {
                    finance = new List<Financials>();
                }
                foreach (Financials finances in finance)
                {
                    string type = finances.credits;
                    if (type == "Statutory Remittances")
                        category = 0;
                    if (type == "Obligatory Remittances")
                        category = 1;
                    if (type == "Supplies and Service Providers")
                        category = 2;
                    if (type == "Other Creditors")
                        category = 3;
                    string currentYear = DateTime.Now.Year.ToString();
                    int year = Convert.ToInt32(currentYear);
                    decimal amounts = Convert.ToDecimal(finances.amounts);
                    DateTime tfinancialstartyear = new DateTime();
                    tfinancialstartyear = Convert.ToDateTime(HttpContext.Current.Session["tfnstartdate"].ToString());
                    DateTime tfinancialendyear  = new DateTime();
                    tfinancialendyear =Convert.ToDateTime(HttpContext.Current.Session["tfnenddate"].ToString());
                    var userCode = HttpContext.Current.Session["Code"].ToString();
                    var password = HttpContext.Current.Session["Password"].ToString();
                    var status = new Config().ObjNav()
                          .AddCreditorsAmounts(universityCode, category, year, amounts, tfinancialstartyear, tfinancialendyear,userCode, password);
                    string[] info = status.Split('*');
                    NewControl.ID = "creditorsfeedback";
                    NewControl.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

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
        public static string InsertDebtor(List<Financials> finance)
        {
            var universityCode = HttpContext.Current.Session["UniversityCode"].ToString();
            HtmlGenericControl NewControl = new HtmlGenericControl();
            var results = (dynamic)null;
            int category = 0;
            try
            {
                if (finance == null)
                {
                    finance = new List<Financials>();
                }
                foreach (Financials finances in finance)
                {
                    string type = finances.debtor;
                    if (type == "Student Fee Arrears")
                        category = 0;
                    if (type == "University Consultancy services")
                        category = 1;
                    if (type == "Income Generating Units (IGUs)")
                        category = 2;
                    if (type == "Other Debtors")
                        category = 3;
                    string currentYear = DateTime.Now.Year.ToString();
                    int year = Convert.ToInt32(currentYear);
                    decimal debtoramounts = Convert.ToDecimal(finances.debtoramounts);
                    var userCode = HttpContext.Current.Session["Code"].ToString();
                    var password = HttpContext.Current.Session["Password"].ToString();
                    DateTime tfinancialstartyear = new DateTime();
                    tfinancialstartyear = Convert.ToDateTime(HttpContext.Current.Session["tfnstartdate"].ToString());
                    DateTime tfinancialendyear = new DateTime();
                    tfinancialendyear = Convert.ToDateTime(HttpContext.Current.Session["tfnenddate"].ToString());
                    var status = new Config().ObjNav().AddDebtorsAmounts(universityCode, category, year, debtoramounts, tfinancialstartyear, tfinancialendyear,userCode, password);
                    string[] info = status.Split('*');
                    NewControl.ID = "debtorsfeedback";
                    NewControl.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    results = info[0];
                }

            }
            catch (Exception ex)
            {
                results = ex.Message;
            }
            return results;
            
        }
        protected void UpdateSourceIncome_Click(object sender, EventArgs e)
        {
            int category = 0;
            string teditsourcetype = editsourcetype.Text.Trim();
            if (teditsourcetype == "Recurrent Allocation")
                category = 6;
            if (teditsourcetype == "Development Grants")
                category = 7;
            if (teditsourcetype == "Student Fees")
                category = 8;
            if (teditsourcetype == "Donations")
                category = 9;
            if (teditsourcetype == "Income Generating Units (IGUs)")
                category = 10;
            if (teditsourcetype == "Research Grants")
                category = 11;
            if (teditsourcetype == "Collaborating Institutions")
                category = 12;
            if (teditsourcetype == "Scholarships and Bursaries")
                category = 13;
            decimal teditExpected =Convert.ToDecimal(editExpected.Text.Trim());
            decimal teditActuals =Convert.ToDecimal(editActuals.Text.Trim());
            string currentYear = DateTime.Now.Year.ToString();
            var universityCode = HttpContext.Current.Session["UniversityCode"].ToString();
            int year = Convert.ToInt32(currentYear);
            var financialstartdyear = HttpContext.Current.Session["tfnstartdate"].ToString();
            var financialendyear = HttpContext.Current.Session["tfnenddate"].ToString();
            string userCode = Session["Code"].ToString();
            string password = Session["Password"].ToString();
            string status = new Config().ObjNav().AddExpectedActualAmounts(universityCode, category, year, teditExpected, teditActuals, financialstartdyear, financialendyear,userCode, password);
            string[] info = status.Split('*');
            feedbacksourcesincome.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            if (info[0] == "success")
            {
                feedbacksourcesincome.InnerHtml = "<div class='alert alert-success'>The University Source of Income Entries were succefully Updated</div>";

            }
            else
            {
                feedbacksourcesincome.InnerHtml = "<div class='alert alert-success'>The University Source of Income Entries were not succefully Updated</div>";

            }

        }
        protected void DeleteSourceIncome_Click(object sender, EventArgs e)
        {
            int tremoveincomeCode = Convert.ToInt32(removeincomeCode.Text.Trim());
            string tremoveIncomeType = removeIncomeType.Text.Trim();
            int category = 0;
            if (tremoveIncomeType == "Recurrent Allocation")
                category = 6;
            if (tremoveIncomeType == "Development Grants")
                category = 7;
            if (tremoveIncomeType == "Student Fees")
                category = 8;
            if (tremoveIncomeType == "Donations")
                category = 9;
            if (tremoveIncomeType == "Income Generating Units (IGUs)")
                category = 10;
            if (tremoveIncomeType == "Research Grants")
                category = 11;
            if (tremoveIncomeType == "Collaborating Institutions")
                category = 12;
            if (tremoveIncomeType == "Scholarships and Bursaries")
                category = 13;
            string currentYear = DateTime.Now.Year.ToString();
            int year = Convert.ToInt32(currentYear);
            var universityCode = HttpContext.Current.Session["UniversityCode"].ToString();
            string userCode = Session["Code"].ToString();
            string password = Session["Password"].ToString();
            string status = new Config().ObjNav().DeleteExpectedActualAmounts(universityCode, tremoveincomeCode, category, userCode, password);
            string[] info = status.Split('*');
            feedbacksourcesincome.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            if (info[0] == "success")
            {
                feedbacksourcesincome.InnerHtml = "<div class='alert alert-success'>The University Source of Income Entries were succefully Delete</div>";

            }
            else
            {
                feedbacksourcesincome.InnerHtml = "<div class='alert alert-success'>The University Source of Income Entries were not succefully Delete</div>";

            }
        }
        protected void UpdateCreditors_Click(object sender, EventArgs e)
        {
            int category = 0;
            string teditCreditors = editCreditors.Text.Trim();
            if (teditCreditors == "Statutory Remittances (PAYE, KRA, NHIF, NSSF, Pension etc.)")
                category = 0;
            if (teditCreditors == "Obligatory Remittances (SACCOs, Staff Bank Loans, University Bank Loans etc.)")
                category = 1;
            if (teditCreditors == "Supplies and Service Providers")
                category = 2;
            if (teditCreditors == "Other Creditors")
                category = 3;
            decimal teditAmounts = Convert.ToDecimal(editAmounts.Text.Trim());
            string currentYear = DateTime.Now.Year.ToString();
            var universityCode = HttpContext.Current.Session["UniversityCode"].ToString();
            int year = Convert.ToInt32(currentYear);
            DateTime tfinancialstartyear = new DateTime();
            tfinancialstartyear = Convert.ToDateTime(HttpContext.Current.Session["tfnstartdate"].ToString());
            DateTime tfinancialendyear = new DateTime();
            tfinancialendyear = Convert.ToDateTime(HttpContext.Current.Session["tfnenddate"].ToString());
            string userCode = Session["Code"].ToString();
            string password = Session["Password"].ToString();
            string status = new Config().ObjNav().AddCreditorsAmounts(universityCode, category, year, teditAmounts, tfinancialstartyear, tfinancialendyear,userCode, password);
            string[] info = status.Split('*');
            creditorsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            if (info[0] == "success")
            {
                creditorsfeedback.InnerHtml = "<div class='alert alert-success'>The University Creditors Entries were succefully Updated</div>";

            }
            else
            {
                creditorsfeedback.InnerHtml = "<div class='alert alert-success'>The University  Creditors Entries were not succefully Updated</div>";

            }

        }
        protected void UpdateDebtors_Click(object sender, EventArgs e)
        {
            int category = 0;
            string teditDebtors = editDebtors.Text.Trim();
            if (teditDebtors == "Student Fee Arrears")
                category = 0;
            if (teditDebtors == "University Consultancy services")
                category = 1;
            if (teditDebtors == "Income Generating Units (IGUs)")
                category = 2;
            if (teditDebtors == "Other Debtors")
                category = 3;
            decimal teditDebtorAmounts = Convert.ToDecimal(editDebtorAmounts.Text.Trim());
            string currentYear = DateTime.Now.Year.ToString();
            var universityCode = HttpContext.Current.Session["UniversityCode"].ToString();
            int year = Convert.ToInt32(currentYear);
            DateTime tfinancialstartyear = new DateTime();
            tfinancialstartyear = Convert.ToDateTime(HttpContext.Current.Session["tfnstartdate"].ToString());
            DateTime tfinancialendyear = new DateTime();
            tfinancialendyear = Convert.ToDateTime(HttpContext.Current.Session["tfnenddate"].ToString());
            string userCode = Session["Code"].ToString();
            string password = Session["Password"].ToString();
            string status = new Config().ObjNav().AddDebtorsAmounts(universityCode, category, year, teditDebtorAmounts, tfinancialstartyear, tfinancialendyear,userCode, password);
            string[] info = status.Split('*');
            Debtorsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            if (info[0] == "success")
            {
                Debtorsfeedback.InnerHtml = "<div class='alert alert-success'>The University Debtors Entries were succefully Updated</div>";

            }
            else
            {
                Debtorsfeedback.InnerHtml = "<div class='alert alert-success'>The University  Debtors Entries were not succefully Updated</div>";

            }

        }
        protected void DeleteCreditors_Click(object sender, EventArgs e)
        {
            int category = 0;
            string teditCreditors = editCreditors.Text.Trim();
            if (teditCreditors == "Statutory Remittances (PAYE, KRA, NHIF, NSSF, Pension etc.)")
                category = 0;
            if (teditCreditors == "Obligatory Remittances (SACCOs, Staff Bank Loans, University Bank Loans etc.)")
                category = 1;
            if (teditCreditors == "Supplies and Service Providers")
                category = 2;
            if (teditCreditors == "Other Creditors")
                category = 3;
            int tremoveCreditorCode = Convert.ToInt32(removeCreditorCode.Text.Trim());
            string currentYear = DateTime.Now.Year.ToString();
            var universityCode = HttpContext.Current.Session["UniversityCode"].ToString();
            int year = Convert.ToInt32(currentYear);
            string userCode = Session["Code"].ToString();
            string password = Session["Password"].ToString();
            string status = new Config().ObjNav().DeleteCreditorsAmounts(universityCode, tremoveCreditorCode, category, userCode, password);
            string[] info = status.Split('*');
            if (info[0] == "success")
            {
                creditorsfeedback.InnerHtml = "<div class='alert alert-success'>The University Creditors Entries were succefully Updated</div>";

            }
            else
            {
                creditorsfeedback.InnerHtml = "<div class='alert alert-success'>The University  Creditors Entries were not succefully Updated</div>";

            }
        }
        protected void DeleteDebtor_Click(object sender, EventArgs e)
        {
            int category = 0;
            string tremoveDebtorType = removeDebtorType.Text.Trim();
            if (tremoveDebtorType == "Student Fee Arrears")
                category = 0;
            if (tremoveDebtorType == "University Consultancy services")
                category = 1;
            if (tremoveDebtorType == "Income Generating Units (IGUs)")
                category = 2;
            if (tremoveDebtorType == "Other Debtors")
                category = 3;
            int tremoveDebtorCode = Convert.ToInt32(removeDebtorCode.Text.Trim());
            string currentYear = DateTime.Now.Year.ToString();
            var universityCode = HttpContext.Current.Session["UniversityCode"].ToString();
            int year = Convert.ToInt32(currentYear);
            string userCode = Session["Code"].ToString();
            string password = Session["Password"].ToString();
            string status = new Config().ObjNav().DeleteDebtorsAmounts(universityCode, category, tremoveDebtorCode, userCode, password);
            string[] info = status.Split('*');
            if (info[0] == "success")
            {
                Debtorsfeedback.InnerHtml = "<div class='alert alert-success'>The University Debtors Entries were succefully Deleted</div>";

            }
            else
            {
                Debtorsfeedback.InnerHtml = "<div class='alert alert-success'>The University  Debtors Entries were not succefully Deleted</div>";

            }
        }
        protected void ActualBudget_Click(object sender, EventArgs e)
        {
            decimal toperationBudget = Convert.ToDecimal(txtoperationBudget.Text.Trim());
            decimal tactualExpenditure = Convert.ToDecimal(txtactualExpenditure.Text.Trim());
            string currentYear = DateTime.Now.Year.ToString();
            int year = Convert.ToInt32(currentYear);
            DateTime tfinancialstartyear = new DateTime();
            tfinancialstartyear = Convert.ToDateTime(HttpContext.Current.Session["tfnstartdate"].ToString());
            DateTime tfinancialendyear = new DateTime();
            tfinancialendyear = Convert.ToDateTime(HttpContext.Current.Session["tfnenddate"].ToString());
            string userCode = Session["Code"].ToString();
            string password = Session["Password"].ToString();
            string status = new Config().ObjNav().AddOperationBudget(toperationBudget, tactualExpenditure, year, tfinancialstartyear, tfinancialendyear,userCode, password);
            string[] info = status.Split('*');
            feedback4.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            if (info[0] == "success")
            {
                feedback4.InnerHtml = "<div class='alert alert-success'>The  University Operation Budget and Actual Expenditure Entries were succefully Submitted</div>";

            }
            else
            {
                feedback4.InnerHtml = "<div class='alert alert-success'>The  University Operation Budget and Actual Expenditure Entries were not succefully Submitted</div>";

            }
        }
        protected void UpdateUniversityBudget_Click(object sender, EventArgs e)
        {
            decimal teditOptsOperation = Convert.ToDecimal(editOptsOperation.Text.Trim());
            decimal teditopsActuals = Convert.ToDecimal(editopsActuals.Text.Trim());
            string currentYear = DateTime.Now.Year.ToString();
            int year = Convert.ToInt32(currentYear);
            string userCode = Session["Code"].ToString();
            string password = Session["Password"].ToString();
            DateTime tfinancialstartyear = new DateTime();
            tfinancialstartyear = Convert.ToDateTime(HttpContext.Current.Session["tfnstartdate"].ToString());
            DateTime tfinancialendyear = new DateTime();
            tfinancialendyear = Convert.ToDateTime(HttpContext.Current.Session["tfnenddate"].ToString());
            string status = new Config().ObjNav().AddOperationBudget(teditOptsOperation, teditopsActuals, year, tfinancialstartyear, tfinancialendyear, userCode, password);
            string[] info = status.Split('*');
            if (info[0] == "success")
            {
                feedback4.InnerHtml = "<div class='alert alert-success'>The  University Operation Budget and Actual Expenditure Entries were succefully Updated</div>";

            }
            else
            {
                feedback4.InnerHtml = "<div class='alert alert-success'>The  University Operation Budget and Actual Expenditure Entries were not succefully Updated</div>";

            }
        }
        protected void DeleteUniversityBudget_Click(object sender, EventArgs e)
        {

            var universityCode = HttpContext.Current.Session["UniversityCode"].ToString();
            string userCode = Session["Code"].ToString();
            string password = Session["Password"].ToString();
            string status = new Config().ObjNav().DeleteOperationBudget(universityCode,userCode, password);
            string[] info = status.Split('*');
            if (info[0] == "success")
            {
                feedback4.InnerHtml = "<div class='alert alert-success'>The  University Operation Budget and Actual Expenditure Entries were succefully Deleted</div>";

            }
            else
            {
                feedback4.InnerHtml = "<div class='alert alert-success'>The  University Operation Budget and Actual Expenditure Entries were not succefully Deleted</div>";

            }
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string ActualBudgetSubmit(string toperationBudget, string tactualExpenditure)
        {
            var results = (dynamic)null;
            try
            {
                string currentYear = DateTime.Now.Year.ToString();
                int year = Convert.ToInt32(currentYear);
                decimal budget = Convert.ToDecimal(toperationBudget);
                decimal Expenditure = Convert.ToDecimal(tactualExpenditure);
                string userCode = HttpContext.Current.Session["Code"].ToString();
                string password = HttpContext.Current.Session["Password"].ToString();
                DateTime tfinancialstartyear = new DateTime();
                tfinancialstartyear = Convert.ToDateTime(HttpContext.Current.Session["tfnstartdate"].ToString());
                DateTime tfinancialendyear = new DateTime();
                tfinancialendyear = Convert.ToDateTime(HttpContext.Current.Session["tfnenddate"].ToString());
                string status = new Config().ObjNav().AddOperationBudget(budget, Expenditure, year, tfinancialstartyear,tfinancialendyear, userCode, password);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    results = info[0];
                }
                else
                {
                    results = info[1];
                }

            }
            catch (Exception ex)
            {
                results = ex.Message;
            }
            return results;
    }
    protected void SubmitAssetsLiabilities_Click(object sender, EventArgs e)
        {
            decimal ttotalDebt = Convert.ToDecimal(totalDebt.Text.Trim());
            decimal ttotalEquity = Convert.ToDecimal(totalEquity.Text.Trim());
            decimal tcurrentAssets = Convert.ToDecimal(currentAssets.Text.Trim());
            decimal tcurrentLiabilities =Convert.ToDecimal( currentLiabilities.Text.Trim());
            string currentYear = DateTime.Now.Year.ToString();
            int year = Convert.ToInt32(currentYear);
            DateTime tfinancialstartyear = new DateTime();
            tfinancialstartyear = Convert.ToDateTime(HttpContext.Current.Session["tfnstartdate"].ToString());
            DateTime tfinancialendyear = new DateTime();
            tfinancialendyear = Convert.ToDateTime(HttpContext.Current.Session["tfnenddate"].ToString());
            string userCode = Convert.ToString(Session["Code"]);
            string password = Convert.ToString(Session["Password"]);
            string status = new Config().ObjNav()
              .AddCurrentAssetsLiabilitiesEquitytRecord(ttotalDebt, ttotalEquity, tcurrentAssets, tcurrentLiabilities, year, tfinancialstartyear, tfinancialendyear,userCode, password);
            string[] info = status.Split('*');
            feedback5.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            if (info[0] == "success")
            {
                feedback5.InnerHtml = "<div class='alert alert-success'>The Total Debt, Total Equity, Current Assets and Current Liabilities were succesfully Submitted</div>";
            }
            else
            {
                feedback5.InnerHtml = "<div class='alert alert-danger'>The Total Debt, Total Equity, Current Assets and Current Liabilities were not succesfully  Submitted</div>";
            }
        }
        protected void UpdateAssets_Click(object sender, EventArgs e)
        {
            decimal tedittotaldebts = Convert.ToDecimal(edittotaldebts.Text.Trim());
            decimal tedittotalequity = Convert.ToDecimal(edittotalequity.Text.Trim());
            decimal tedittotalAssets = Convert.ToDecimal(edittotalAssets.Text.Trim());
            decimal tedittotalLibaility = Convert.ToDecimal(edittotalLibaility.Text.Trim());
            string currentYear = DateTime.Now.Year.ToString();
            int year = Convert.ToInt32(currentYear);
            DateTime tfinancialstartyear = new DateTime();
            tfinancialstartyear = Convert.ToDateTime(HttpContext.Current.Session["tfnstartdate"].ToString());
            DateTime tfinancialendyear = new DateTime();
            tfinancialendyear = Convert.ToDateTime(HttpContext.Current.Session["tfnenddate"].ToString());
            string userCode = Convert.ToString(Session["Code"]);
            string password = Convert.ToString(Session["Password"]);
            string status = new Config().ObjNav()
              .AddCurrentAssetsLiabilitiesEquitytRecord(tedittotaldebts, tedittotalequity, tedittotalAssets, tedittotalLibaility, year, tfinancialstartyear, tfinancialendyear, userCode, password);
            string[] info = status.Split('*');
            feedback5.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            if (info[0] == "success")
            {
                feedback5.InnerHtml = "<div class='alert alert-success'>The Total Debt, Total Equity, Current Assets and Current Liabilities were succesfully Submitted</div>";
            }
            else
            {
                feedback5.InnerHtml = "<div class='alert alert-danger'>The Total Debt, Total Equity, Current Assets and Current Liabilities were not succesfully  Submitted</div>";
            }
        }
        protected void DeleteAssets_Click(object sender, EventArgs e)
        {
            string tremoveAssetsCode = removeAssetsCode.Text.Trim();
            string currentYear = DateTime.Now.Year.ToString();
            int year = Convert.ToInt32(currentYear);
            string userCode = Convert.ToString(Session["Code"]);
            string password = Convert.ToString(Session["Password"]);
            string status = new Config().ObjNav()
            .DeleteCurrentAssetsLiabilitiesEquitytRecord(tremoveAssetsCode, userCode, password);
            string[] info = status.Split('*');
            feedback5.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            if (info[0] == "success")
            {
                feedback5.InnerHtml = "<div class='alert alert-success'>The Total Debt, Total Equity, Current Assets and Current Liabilities were succesfully Submitted</div>";
            }
            else
            {
                feedback5.InnerHtml = "<div class='alert alert-danger'>The Total Debt, Total Equity, Current Assets and Current Liabilities were not succesfully  Submitted</div>";
            }
        }
        protected void Research_Click(object sender, EventArgs e)
        {
            decimal tresearchBudgetAllocation = Convert.ToDecimal(researchBudgetAllocation.Text.Trim());
            decimal tresearchActualExpenditure = Convert.ToDecimal(researchActualExpenditure.Text.Trim());
            decimal tresearchAttractedBudgetAllocation = Convert.ToDecimal(researchAttractedBudgetAllocation.Text.Trim());
            decimal tresearchAttractedActualExpenditure = Convert.ToDecimal(researchAttractedActualExpenditure.Text.Trim());
            string currentYear = DateTime.Now.Year.ToString();
            int year = Convert.ToInt32(currentYear);
            DateTime tfinancialstartyear = new DateTime();
            tfinancialstartyear = Convert.ToDateTime(HttpContext.Current.Session["tfnstartdate"].ToString());
            DateTime tfinancialendyear = new DateTime();
            tfinancialendyear = Convert.ToDateTime(HttpContext.Current.Session["tfnenddate"].ToString());
            string userCode = Convert.ToString(Session["Code"]);
            string password = Convert.ToString(Session["Password"]);
            string status = new Config().ObjNav()
              .AddResearchBudgetRecord(tresearchBudgetAllocation, tresearchActualExpenditure, tresearchAttractedBudgetAllocation, tresearchAttractedActualExpenditure, year, tfinancialstartyear, tfinancialendyear,userCode, password);
            string[] info = status.Split('*');
            feedback6.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            if (info[0] == "success")
            {
                feedback6.InnerHtml = "<div class='alert alert-success'>The Research Budget entries were succefully Submitted</div>";
            
            }
            else
            {
                feedback6.InnerHtml = "<div class='alert alert-danger'>The Research Budget entries could not be updated</div>";
            }
        }
        protected void UpdateResearch_Click(object sender, EventArgs e)
        {
            decimal teditbudgetallocation = Convert.ToDecimal(editbudgetallocation.Text.Trim());
            decimal teditactualexpenditure = Convert.ToDecimal(editactualexpenditure.Text.Trim());
            decimal teditresearchallocation = Convert.ToDecimal(editresearchallocation.Text.Trim());
            decimal teditresearchactualexpenditure = Convert.ToDecimal(editresearchactualexpenditure.Text.Trim());
            string currentYear = DateTime.Now.Year.ToString();
            int year = Convert.ToInt32(currentYear);
            DateTime tfinancialstartyear = new DateTime();
            tfinancialstartyear = Convert.ToDateTime(HttpContext.Current.Session["tfnstartdate"].ToString());
            DateTime tfinancialendyear = new DateTime();
            tfinancialendyear = Convert.ToDateTime(HttpContext.Current.Session["tfnenddate"].ToString());
            string userCode = Convert.ToString(Session["Code"]);
            string password = Convert.ToString(Session["Password"]);
            string status = new Config().ObjNav()
              .AddResearchBudgetRecord(teditbudgetallocation, teditactualexpenditure, teditresearchallocation, teditresearchactualexpenditure, year, tfinancialstartyear, tfinancialendyear, userCode, password);
            string[] info = status.Split('*');
            feedback6.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            if (info[0] == "success")
            {
                feedback6.InnerHtml = "<div class='alert alert-success'>The Research Budget entries were succefully Submitted</div>";

            }
            else
            {
                feedback6.InnerHtml = "<div class='alert alert-danger'>The Research Budget entries could not be updated</div>";
            }
        }
        protected void DeleteResearch_Click(object sender, EventArgs e)
        {
            string tremoveResearchCode = removeResearchCode.Text.Trim();
            string currentYear = DateTime.Now.Year.ToString();
            int year = Convert.ToInt32(currentYear);
            string userCode = Convert.ToString(Session["Code"]);
            string password = Convert.ToString(Session["Password"]);
            string status = new Config().ObjNav()
              .DeleteResearchBudgetRecord(tremoveResearchCode, userCode, password);
            string[] info = status.Split('*');
            feedback6.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            if (info[0] == "success")
            {
                feedback6.InnerHtml = "<div class='alert alert-success'>The Research Budget entries were succefully Deleted</div>";

            }
            else
            {
                feedback6.InnerHtml = "<div class='alert alert-danger'>The Research Budget entries could not be Deleted</div>";
            }
        }
        protected void Sumit_Click(object sender, EventArgs e)
        {
            decimal tlibraryActualExpenditure = Convert.ToDecimal(libraryActualExpenditure.Text.Trim());
            decimal tlibraryOperationBudget = Convert.ToDecimal(libraryOperationBudget.Text.Trim());
            string currentYear = DateTime.Now.Year.ToString();
            int year = Convert.ToInt32(currentYear);
            DateTime tfinancialstartyear = new DateTime();
            tfinancialstartyear = Convert.ToDateTime(HttpContext.Current.Session["tfnstartdate"].ToString());
            DateTime tfinancialendyear = new DateTime();
            tfinancialendyear = Convert.ToDateTime(HttpContext.Current.Session["tfnenddate"].ToString());
            string userCode = Convert.ToString(Session["Code"]);
            string password = Convert.ToString(Session["Password"]);
            string status = new Config().ObjNav()
                .AddLibraryBudgetDetails(tlibraryActualExpenditure, tlibraryOperationBudget, year, tfinancialstartyear, tfinancialendyear,userCode, password);
            string[] info = status.Split('*');
            feedback7.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
               if (info[0] == "success")
                {
                    feedback7.InnerHtml = "<div class='alert alert-success'>The University Library operation budget and actual expenditure was successfully Submitted</div>";
                }
                else
                {
                    feedback7.InnerHtml = "<div class='alert alert-danger'>The University Library operation budget and actual expenditure could not be Submitted</div>";
                }
        }
        protected void UpdateLibrary_Click(object sender, EventArgs e)
        {
            decimal teditLibraryOperationBudget = Convert.ToDecimal(editLibraryOperationBudget.Text.Trim());
            decimal teditLibraryActualExpenditure = Convert.ToDecimal(editLibraryActualExpenditure.Text.Trim());
            string currentYear = DateTime.Now.Year.ToString();
            int year = Convert.ToInt32(currentYear);
            DateTime tfinancialstartyear = new DateTime();
            tfinancialstartyear = Convert.ToDateTime(HttpContext.Current.Session["tfnstartdate"].ToString());
            DateTime tfinancialendyear = new DateTime();
            tfinancialendyear = Convert.ToDateTime(HttpContext.Current.Session["tfnenddate"].ToString());
            string userCode = Convert.ToString(Session["Code"]);
            string password = Convert.ToString(Session["Password"]);
            string status = new Config().ObjNav()
                .AddLibraryBudgetDetails(teditLibraryOperationBudget, teditLibraryActualExpenditure, year, tfinancialstartyear, tfinancialendyear, userCode, password);
            string[] info = status.Split('*');
            feedback7.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            if (info[0] == "success")
            {
                feedback7.InnerHtml = "<div class='alert alert-success'>The University Library operation budget and actual expenditure was successfully Submitted</div>";
            }
            else
            {
                feedback7.InnerHtml = "<div class='alert alert-danger'>The University Library operation budget and actual expenditure could not be Submitted</div>";
            }
        }
        protected void DeleteLibraryResearch_Click(object sender, EventArgs e)
        {
            string tremoveLibraryCode = removeLibraryCode.Text.Trim();
            string currentYear = DateTime.Now.Year.ToString();
            int year = Convert.ToInt32(currentYear);
            string userCode = Convert.ToString(Session["Code"]);
            string password = Convert.ToString(Session["Password"]);
            string status = new Config().ObjNav()
                .DeleteLibraryBudgetDetails(tremoveLibraryCode, userCode, password);
            string[] info = status.Split('*');
            feedback7.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            if (info[0] == "success")
            {
                feedback7.InnerHtml = "<div class='alert alert-success'>The University Library operation budget and actual expenditure was successfully Deleted</div>";
            }
            else
            {
                feedback7.InnerHtml = "<div class='alert alert-danger'>The University Library operation budget and actual expenditure could not be Deleted</div>";
            }
        }
    }
}