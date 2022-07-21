<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/AccreditationMaster.Master" CodeBehind="InstitutionPreamble.aspx.cs" Inherits="CicPortal.InstitutionPreamble" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <%
        const int maxStep = 11;
        var nav = Config.ReturnNav();
        String accreditationNo = "";
        try
        {
            accreditationNo = Request.QueryString["accreditationNo"].Trim();
        }
        catch (Exception)
        {

        }
        int currentStep = 1;
        try
        {
            currentStep = Convert.ToInt32(Request.QueryString["step"]);
            if (currentStep > maxStep || currentStep < 1)
            {
                currentStep = 1;
            }
        }
        catch (Exception)
        {
            currentStep = 1;
        }
    %>
    <%
        if (currentStep == 1)
        {
    %> 
     <div class="row" style="background-color: #f5f5f5;">
       <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                    <p class="pull-left" style="font-size: 15px"><a href="Downloads/CUE Portal User Guide.pdf"><i class="fa fa-file-pdf-o"></i>Portal User Guide</a></p>
                    <p class="pull-right" style="font-size: 15px"><a href="Downloads/Steps_Establish_university.pdf"><i class="fa fa-file-pdf-o"></i>Steps towards Establishment of a University</a></p>
                  <h3 style="color:Highlight"><b>Universities Institution Accreditation</b></h3>
                </div>
                <hr />
            </div> <hr/>
   <div class="panel-heading">
    <div class="row" >
       <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
        <p>Institutional Accreditation is the process by which the
            Commission recognizes an institution as having met minimum
            standards for accreditation. For purposes of this section, an
            institution could be a university, a university constituent
            college, a university campus or ODEL centre for which an
            applicant is seeking accreditation. Any applicant seeking
            accreditation for any of the above types of institution would
            need to first familiarize himself with the following documents:
             <ol type="1">
             <li><a href="Downloads/the-universities-act-2012.pdf"><i class="fa fa-file-pdf-o"></i>The Universities Act 2012</a></li>
              <li><a href="Downloads/university-regulations.pdf"><i class="fa fa-file-pdf-o"></i>The Universities Regulations 2014</a></li>
              <li><a href="Downloads/universities standards and guidelines june 2014.pdf"><i class="fa fa-file-pdf-o"></i>The Universities Standards and Guidelines 2014</a></li>
            </ol>
       
<%--            <p>To proceed, select the type of institution for which you are
            applying for accreditation</p>--%>
            </p>
                <div class="panel panel-default">
                                    <p>Institution Accreditation Fee Schedule</p>
                                    <div class="panel-heading">Institution Accreditation Fee Schedule</div>
                                    <div class="panel-body">
                                        <table class="table table-bordered table-striped datatable">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Accreditation Type</th>
                                                    <th>Accreditation Charge(Ksh)</th>
                                            </thead>
                                            <tbody>
                                                <%
                                                    var acrefees = nav.InstitutionFeesSchedule;
                                                    int counter = 0;
                                                    foreach (var fees in acrefees)
                                                    {
                                                        counter++;
                                                %>
                                                <tr>
                                                    <td><%=counter %></td>
                                                    <td><%=fees.Description %></td>
                                                     <td><%=Convert.ToDecimal(fees.Amount).ToString("#,##0") %></td>
                                                </tr>
                                                <%
                                                    }
                                                %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
           <h4 style="color:red"><u>Note:</u></h4>
          <p>Timelines for required responses are inbuilt, and the system will automatically terminate evaluation at the expiry of the given response period; if this happens, you will be required to make a fresh application for accreditation and make requisite payment.</p>
        </div>
         <asp:Button runat="server" CssClass="btn btn-success pull-right fa fa-arrow-right"  style="margin-right: 100px;" Text="Next" ID="Next" OnClick="Proceed_Onclick" />
      </div>
     </div>
    <%} %>
</asp:Content>