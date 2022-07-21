<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AccreditationMaster.Master" CodeBehind="ProgramPreamble.aspx.cs" Inherits="CicPortal.ProgramPreamble" %>

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
    <div class="panel panel-primary">
        <div runat="server" id="balancemessage"></div>
        <div class="panel-body">
            <div class="row" style="background-color: #f5f5f5;">
                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                    <p class="pull-left" style="font-size: 15px"><a href="Downloads/Programme_Portal_Manual.pdf"><i class="fa fa-file-pdf-o"></i>Portal User Guide</a></p>
                      <p class="pull-right" style="font-size: 15px"><a href="Downloads/Guidelines_Curriculum_Development.pdf"><i class="fa fa-file-pdf-o"></i>Curriculum Document GuideLines</a></p>
                    <h3 style="color: Highlight"><b>Universities Programme Accreditation</b></h3>
                </div>
                <hr />
                
                <div class="panel-heading">
                    <div class="row">
                         
                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                            <p>
                                Programme accreditation is one of the external quality assurance mechanisms aimed at adding 
                            value and validating institutional capacity for ensuring quality of academic programmes offered in
                             universities in Kenya. Given its mandate, the Commission undertakes to ensure only quality academic programmes
                             enter and remain in the universities sector, but the primary responsibility for quality academic programmes
                             rests with universities themselves.  As provided by the Universities Act, 
                            programme accreditation should precede launching of an academic programme. 
                                As you submit the curriculum for evaluation, you undertake to subject it to the accreditation process 
                            so that it will eventually be formally recognised as having met pre-determined criteria.<br />
                            Before starting online submission of the curriculum for evaluation, ensure that the following are available for uploading as and when required:
                   <ol type="1">
                 <li>Needs assessment report.</li>
                 <li>Proof of Senate approval in form of Minutes of Senate.</li>
                 <li>Proof of approval by professional bodies (where applicable).</li>
                 <li>Appendices on facilities, equipment and teaching materials, core-texts and journals, academic staff, relevant support staff, University policy on curriculum development and complete curriculum document</li>
                 <li>Proof of Payment of evaluation fee.</li>
             </ol>
                                <div class="panel panel-default">
                                    <p>*Programme Accreditation Fee Schedule</p>
                                    <div class="panel-heading">Programme Accreditation Fee Schedule</div>
                                    <div class="panel-body">
                                        <table class="table table-bordered table-striped datatable">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Accreditation Fee Amount(Ksh)</th>
                                            </thead>
                                            <tbody>
                                                <%
                                                    var acrefees = nav.AccreditationFees;
                                                    int counter = 0;
                                                    foreach (var fees in acrefees)
                                                    {
                                                        counter++;
                                                %>
                                                <tr>
                                                    <td><%=counter %></td>
                                                    <td><%=Convert.ToDecimal(fees.Programme_Accreditation_Amount).ToString("#,##0") %></td>
                                                </tr>
                                                <%
                                                    }
                                                %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                        </div>
                    </div>
                    <h4 style="color: red"><u>Note:</u></h4>
                    <p>Timelines for required responses are inbuilt, and the system will automatically terminate evaluation at the expiry of the given response period; if this happens, you will be required to make a fresh application for accreditation and make requisite payment.</p>
                </div>
               
                <asp:Button runat="server" CssClass="btn btn-success pull-right fa fa-arrow-right" Style="margin-right: 100px;" Text="Next" ID="Next" OnClick="Proceed_Onclick" />

           </div>
        </div>
    </div>
        <%} %>
</asp:Content>
