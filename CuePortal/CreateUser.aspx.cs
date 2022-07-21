using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class CreateUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                string entryNo = "";
                try
                {
                    entryNo = Request.QueryString["entryNo"];
                    if (string.IsNullOrEmpty(entryNo))
                    {
                        entryNo = "";
                    }
                    else
                    {
                        var nav = Config.ReturnNav();
                        string custNo = Convert.ToString(Session["UniversityCode"]);
                        var data = nav.UniversityUsers.Where(x => x.UniversityCode == custNo && x.Entry_No == Convert.ToInt32(entryNo)).ToList();
                        foreach (var item in data)
                        {
                            usertype.SelectedValue = item.UserType;
                            fname.Text = item.Full_Name;
                            email.Text = item.Authentication_Email;
                            phone.Text = item.Mobile_Phone_No;
                        }
                    }
                }
                catch
                {
                    entryNo = "";
                }
            }
        }

        protected void save_Click(object sender, EventArgs e)
        {
            try
            {
                bool err = false;
                string msg = "";
                string entryNo = "";
                int txtentryNo = 0;
                try
                {
                    if (!string.IsNullOrEmpty(Request.QueryString["entryNo"]))
                    {
                        entryNo = Request.QueryString["entryNo"];
                        txtentryNo = Convert.ToInt32(entryNo);
                    }
                    else
                    {
                        entryNo = "";
                    }
                }
                catch
                {
                    entryNo = "";
                }
                string custNo = Convert.ToString(Session["UniversityCode"]);
                string luser = Convert.ToString(Session["UserType"]);
                string nusertype = usertype.SelectedValue.Trim();
                if(luser == nusertype)
                {
                    err = true;
                    msg = "You cannot assign duties to yourself.";
                }
                int txtusertype = 0;
                if (nusertype == "Data Officer")
                {
                    txtusertype = 0;
                }
                if (nusertype == "DVC")
                {
                    txtusertype = 1;
                }
                if (nusertype == "VC")
                {
                    txtusertype = 2;
                }
                if (nusertype == "Programme Accreditation Officer")
                {
                    txtusertype = 3;
                }
                if (nusertype == "Institutional Accreditation Officer")
                {
                    txtusertype = 4;
                }
                if (nusertype == "Quality Audit Officer")
                {
                    txtusertype = 5;
                }
                string txtfname = fname.Text.Trim();
                string txtphone = phone.Text.Trim();
                string txtemail = email.Text.Trim();
                //Validate university email
                var validatetemailaddress = email.Text.Trim();
                string[] EmailContents = validatetemailaddress.Split('@');
                string Useremaildomain = EmailContents[1];

                var Universityemaildomains = new Config().ObjNav().FngetUniversityDomain(custNo);
                string Universityemaildomain = Convert.ToString(Universityemaildomains).Trim();
                if (Useremaildomain != Universityemaildomain)
                {
                    err = true;
                    msg = "Please Provide Valid University Official Email Address that ends with ("+ Universityemaildomain + ")";
                }

                var nav = Config.ReturnNav();
                int data = nav.UniversityUsers.Where(x => x.UniversityCode == custNo && x.UserType == nusertype).ToList().Count;
                if(data > 0 && txtentryNo == 0)
                {
                    err = true;
                    msg = "You can only have one user per module";
                }
                if (err)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + msg + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String status = new Config().ObjNav().FnCreatePortalUsers(txtentryNo, custNo, txtusertype, txtfname, txtemail, txtphone);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        generalFeedback.InnerHtml = "<div class='alert alert-info'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                        "setTimeout(function() { window.location.replace('ChooseService.aspx') }, 9000);", true);
                    }
                    else
                    {
                        generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
            }
            catch (Exception m)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}