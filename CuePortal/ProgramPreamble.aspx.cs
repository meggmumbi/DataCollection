using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class ProgramPreamble : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        protected void Proceed_Onclick(object sender, EventArgs e)
        {
            Response.Redirect("ProgramAccreditation.aspx");
            //try
            //{
            //    string universityCode = Convert.ToString(Session["UniversityCode"]);

            //    var nav = Config.ReturnNav();
            //    var cust = nav.CustomerBalance.Where(x => x.No == universityCode);
            //    foreach (var customer in cust)
            //    {
            //        if (customer.Balance_LCY > customer.Credit_Limit_LCY)
            //        {
            //            balancemessage.InnerHtml = "<div class='alert alert-danger'>" + " Your Balance amounts is Ksh. " + Convert.ToDecimal(customer.Balance_LCY).ToString("#,##0") + " which is above your required Credit Limit " + Convert.ToDecimal(customer.Credit_Limit_LCY).ToString("#,##0") + ", Kindly clear with Commission for University Eduction(CUE) finance department before you proceed" + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //        }
            //        else
            //        {
            //            Response.Redirect("ProgramAccreditation.aspx");
            //        }
            //    }
            //}
            //catch (Exception ex)
            //{
            //    balancemessage.InnerHtml = "<div class='alert alert-danger'>Something Went wrong, kindly try again!</div>";
            //}
        }
    }
}