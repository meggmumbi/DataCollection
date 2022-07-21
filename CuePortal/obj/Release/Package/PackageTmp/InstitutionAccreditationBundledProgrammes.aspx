<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AccreditationMaster.Master" CodeBehind="InstitutionAccreditationBundledProgrammes.aspx.cs" Inherits="CicPortal.InstitutionAccreditationBundledProgrammes" %>

<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <%
          const int maxStep =1;
          String applicationNo = "";
         string AccCode = "";
         try
         {
            applicationNo = Request.QueryString["applicationNo"].Trim();
             AccCode = Request.QueryString["AccCode"];
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
    <div>
        <div class="row">
            <div class="col-md-12 col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">Submitted Programme Accreditation Applications</div>
                    <div id="feedbackdata" runat="server"></div>
                    <div class="col-md-12 col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <a href="NewProgrammeAccreditations.aspx?applicationNo=<%=applicationNo%>&&AccCode=<%=AccCode %>""><label class="btn btn-success" data-toggle="modal" data-target="#form-input"><i class="fa fa-plus fa-fw"></i>Add New Programme</label></a>
                            </div>
                        </div>
                    </div>
                    <%
                        string institutionstatus = Convert.ToString(Session["InstitutionStatus"]);
                        if (institutionstatus == "Proposed")
                        {
                            %>
                            <div class="panel-body">
                                <div id="feedback" runat="server"></div>
                                <table class="table table-bordered table-striped table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th>Programme Name</th>
                                            <th>Programme Domain</th>
                                            <th>Programme Level</th>
                                            <th>Status</th>
                                            <%--<th>Proceed</th>--%>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            var nav1 = Config.ReturnNav();
                                            string application1 = Request.QueryString["applicationNo"];
                                            var requests = nav1.ProgrammeAccreditation.Where(r => r.Institution_Accreditation_No == application1);
                                            foreach (var request in requests)
                                            {
                                        %>
                                        <tr>
                                            <td><%=request.Program_Name %></td>
                                            <td><%=request.domainDescription %></td>
                                            <td><%=request.Program_Level %></td>
                                            <td><%=request.Status %></td>
                                            <%-- <td><a href="NewProgrammeAccreditations.aspx?accreditationNo=<%=request.Accreditation_No %>&applicationNo=<%=applicationNo%>&step=1" class="btn btn-success"><i class="fa fa-eye"></i>Proceed</a></td>--%>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                         <%
                        }
                        else
                        {
                          %>
                            <div class="panel-body">
                                <div id="feedback1" runat="server"></div>
                                <table class="table table-bordered table-striped table-hover" id="dataTables-example1">
                                    <thead>
                                        <tr>
                                            <th>Description</th>
                                            <th>Programme Domain</th>
                                            <th>Programme Level</th>
                                            <th>Accreditation Status</th>
                                            <th>Remove</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            var nav1 = Config.ReturnNav();
                                            string application1 = Request.QueryString["applicationNo"];
                                            var requests = nav1.Programmes.Where(r => r.Institution_Application_Number == application1);
                                            foreach (var request in requests)
                                            {
                                        %>
                                        <tr>
                                            <td><%=request.Description %></td>
                                            <td><%=request.domainDescription %></td>
                                            <td><%=request.Program_Level %></td>
                                            <td><%=request.Accreditation_Status %></td>
                                            <td><label class="btn btn-danger" onclick="RemoveProgram('<%=request.Code %>','<%=request.Description %>');"><i class="fa fa-thrash"></i>Remove</label></td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                            <%
                        }
                         %>

                </div>
            </div>
        </div>
    </div>
    <% var nav = Config.ReturnNav();
        string application = Request.QueryString["applicationNo"];
        int programcounter = nav.ProgrammeAccreditation.Where(r => r.Institution_Accreditation_No == application).ToList().Count;
        int progmmecounter = nav.Programmes.Where(r => r.Institution_Application_Number == application).ToList().Count;
       %> 
    <%
                string institutionstatus1 = Convert.ToString(Session["InstitutionStatus"]);
                if (institutionstatus == "Proposed")
                {
                    if (programcounter > 2)
                    {
                            %>
                           <div class="row">
                            <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                                <br />
                                <asp:Button runat="server" ID="SubmitProgrammeApplication" CssClass="btn btn-success pull-right" Text="Submit Application" OnClick="SubmitProgrammeApplication_Click"/>
                            </div>
                           </div>
                            <%
                    }
                 }
                else
                {
                    if (progmmecounter > 2)
                    {
                    %>
                            <div class="row">
                        <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                            <br />
                            <asp:Button runat="server" ID="Button1" CssClass="btn btn-success pull-right" Text="Submit Application" OnClick="SubmitProgrammeApplication_Click"/>
                        </div>
                        </div>
            <%
                    }
                }

                %>

   <%} %>

   <asp:Button runat="server" ID="previous" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click"/><br /><br />


<div id="RemoveProgramModal" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Confirm remove of program</h4>
          </div>
          <div class="modal-body">
            <p>Are you sure you want to remove the program: <strong id="terminateNo"></strong>?</p>
              <asp:TextBox runat="server" ID="programNo" type="hidden"/>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
              <asp:Button runat="server" CssClass="btn btn-success" Text="Remove Program" ID="removeprogram" CausesValidation="false" OnClick="removeprogram_Click"/>
          </div>
    </div>
  </div>
</div>
 
<script>
    function RemoveProgram(applicationno, desc) {
        document.getElementById("terminateNo").innerText = desc;
        document.getElementById("MainContent_programNo").value = applicationno;
        $("#RemoveProgramModal").modal();
    }
</script>

    <script>
        $(document).ready(function () {
            $('#dataTables-example').DataTable({
                responsive: true
            });
        });
        $(document).ready(function () {
            $('#dataTables-example1').DataTable({
                responsive: true
            });
        });
    </script>
    <script src="js/http_ajax.googleapis.com_ajax_libs_jquery_3.2.1_jquery.min.js"></script>
    <script src="js/http_cdnjs.cloudflare.com_ajax_libs_popper.js_1.12.6_umd_popper.js"></script>
    <script src="js/http_maxcdn.bootstrapcdn.com_bootstrap_4.0.0-beta.2_js_bootstrap.js"></script>
    <script src="js/http_unpkg.com_sweetalert_dist_sweetalert.min.js"></script>
    <script src="js/http_rawgit.com_eligrey_FileSaver.js_master_FileSaver.js"></script>
    <script src="js/http_unpkg.com_xlsx_dist_xlsx.full.min.js"></script>
    <script src="js/excel_uploader.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://github.com/eligrey/Blob.js"></script>
    <script src="https://rawgit.com/eligrey/FileSaver.js/src/FileSaver.js"></script>
    <script src="https://unpkg.com/xlsx/dist/xlsx.full.min.js"></script>
</asp:Content>
