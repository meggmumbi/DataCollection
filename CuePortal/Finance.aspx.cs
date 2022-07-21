using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class Finance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var nav = Config.ReturnNav();
            if (!IsPostBack)
            {
                List<string> allClassification = new List<string>();
                allClassification.Add("Income");
                allClassification.Add("Expense");
                classification.DataSource = allClassification;
                classification.DataBind();
                LoadVoteHeads();
            }
            try
            {
                string entry = Request.QueryString["entry"].Trim();
                if (!string.IsNullOrEmpty(entry))
                {
                    string userCode = Convert.ToString(Session["Code"]);
                    string password = Convert.ToString(Session["Password"]);
                    string status = new Config().ObjNav().DeleteFinancialSubmission(entry, userCode, password);
                    if (status == "success")
                    {
                        feedback.InnerHtml =
                            "<div class='alert alert-success'>The financial submission was successfully deleted</div>";
                    }

                }
            }catch(Exception) { }

        }
        
        public void LoadVoteHeads()
        {
            var nav = Config.ReturnNav();
            var voteheads = nav.VoteHeads.Where(r => r.CategoryCode == classification.SelectedValue);
            voteHead.DataSource = voteheads;
            voteHead.DataValueField = "AccountsCode";
            voteHead.DataTextField = "AccountsDescription";
            voteHead.DataBind();
        }

        protected void classification_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadVoteHeads();
        }

        protected void Unnamed1_Click1(object sender, EventArgs e)
        {
            string tVoteHead = voteHead.SelectedValue;
            string tAmount = amount.Text.Trim();
            decimal mAmount = 0;
            try
            {
                mAmount = Convert.ToDecimal(tAmount);
                try
                {
                    string userCode = Convert.ToString(Session["Code"]);
                    string password = Convert.ToString(Session["Password"]);
                    string status = new Config().ObjNav().AddFinancialSubmission(tVoteHead, mAmount, userCode, password);
                    string[] info = status.Split('*');
                    feedback.InnerHtml = "<div class='alert alert-"+info[0]+"'>"+ info[1]+"</div>";
                    if (info[0]=="success")
                    {
                        amount.Text = "";
                    }
                }
                catch (Exception r)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>We experienced an error while adding the votehead. Please try again later.</div>";
                }
            }
            catch (Exception y)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>Please specify a valid value for amount</div>";
            }
        }
    }
}