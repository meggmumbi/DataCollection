﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AccreditationMaster.Master" CodeBehind="RevisedProgrammeAccreditation.aspx.cs" Inherits="CicPortal.RevisedProgrammeAccreditation" %>

<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-12 col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">Programme Accreditation Pending Actions</div>
                <div class="panel-body">
                    <strong>
                        <ul class="nav nav-pills" style="background-color: antiquewhite">
                            <li class="nav-item">
                                <a class="nav-link  active" data-toggle="pill" href="#feedback">Completeness Feedback</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" data-toggle="pill" href="#peers">Curriculum Document Review</a>
                            </li>

                            <li class="nav-item">
                                <a class="nav-link" data-toggle="pill" href="#site">Verification of Academic Resources</a>
                            </li>
                        </ul>
                    </strong>
                    <div class="form-group">
                        <hr />
                        <div runat="server" id="Div5"></div>
                        <asp:Literal ID="ltEmbed" runat="server" />
                    </div>
                </div>
                <!-- Tab panes -->
                <div class="tab-content">
                    <div runat="server" id="documentsFeedback"></div>
                    <div class="tab-pane fade" id="peers">
                        <div class="row">
                            <div class="col-md-12 col-lg-12">
                                <div class="panel panel-default">
                                    <div class="panel-heading">Application(s) Awaiting Peer Reviewers</div>

                                    <div class="panel-body">
                                        <div id="Div2" runat="server"></div>
                                        <table class="table table-bordered table-striped table-hover" id="dataTables-example3">
                                            <thead>
                                                <tr>
                                                    <th>Accreditation No</th>
                                                    <th>Campus</th>
                                                    <th>Programme Name</th>
                                                    <th>Programme Domain</th>
                                                    <th>Programme Level</th>
                                                    <%--<th>Responsibility</th>--%>
                                                    <th>Feedback Report</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    var nav2 = Config.ReturnNav();
                                                    var requestsprog2 = nav2.ProgramAccreditation.Where(r => r.Institution_No == Convert.ToString(Session["UniversityCode"])&&r.Current_Version==true &&r.Published==true&& r.Status == "Awaiting Peer Review");
                                                    foreach (var request in requestsprog2)
                                                    {
                                                %>
                                                <tr>
                                                    <td><%=request.Accreditation_No %></td>
                                                    <td><%=request.Campus_Name %></td>
                                                    <td><%=request.Program_Name %></td>
                                                    <td><%=request.domainDescription %></td>
                                                    <td><%=request.Program_Level %></td>
                                                    <%--<td><%=request.Responsibility %></td>--%>
                                                  
                                                    <td><label class="btn btn-success" onclick="generateEvaluationTool('<%=request.Accreditation_No %>','<%=request.Program_Name %>')"><i class="fa fa-download"></i>Download</label></td>
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
                    </div>
                    <div class="tab-pane active" id="feedback">
                        <div class="row">
                            <div class="col-md-12 col-lg-12">
                                <div class="panel panel-default">
                                    <div class="panel-heading">Programme Accreditation Completeness Feedback</div>

                                    <div class="panel-body">
                                        <div id="Div3" runat="server"></div>
                                        <table class="table table-bordered table-striped table-hover" id="dataTables-example4">
                                            <thead>
                                                <tr>
                                                    <th>Accreditation No</th>
                                                    <th>Campus</th>
                                                    <th>Programme Name</th>
                                                    <th>Programme Domain</th>
                                                    <th>Program Level</th>
                                                    <th>Completeness Status</th>
                                                    <%--<th>Responsibility</th>--%>
                                                    <th>Revise</th>
                                                    <th>Feedback Report</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    var nav3 = Config.ReturnNav();
                                                    var requestsprog3 = nav3.ProgramAccreditation.Where(r => r.Institution_No == Convert.ToString(Session["UniversityCode"])&&r.Current_Version==true &&r.Published==true && r.Status == "Awaiting Completeness Check");
                                                    foreach (var request in requestsprog3)
                                                    {
                                                        var completestatus = "";
                                                        if (request.Curriculumn_Completeness =="Complete")
                                                        {
                                                            completestatus = "Complete";
                                                        }
                                                        else
                                                        {
                                                            completestatus = "Incomplete";
                                                        }
                                                %>
                                                <tr>
                                                    <td><%=request.Accreditation_No %></td>
                                                    <td><%=request.Campus_Name %></td>
                                                    <td><%=request.Program_Name %></td>
                                                    <td><%=request.domainDescription %></td>
                                                     <td><%=request.Program_Level %></td>                                                   
                                                    <td><%=completestatus %></td>
                                                     <%--<td><%=request.Responsibility %></td>--%>
                                                   <td>
                                                    <%
                                                        if (completestatus=="Incomplete")
                                                        {
                                                    %>
                                                    <a href="ProgramAccreditation.aspx?accreditationNo=<%=request.Accreditation_No %>" class="btn btn-success"><i class="fa fa-share"></i>Revise</a>
                        
                                                    <%   
                                                        }
                                                     %>
                                                    </td>
                                                    <td>
                                                        <label class="btn btn-success" onclick="generatefeddbackvoucher('<%=request.Accreditation_No %>','<%=request.Program_Name %>')"><i class="fa fa-download"></i>Download</label>
                                                    </td>
                                                   
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
                    </div>
                    <div class="tab-pane fade" id="site">
                        <div class="row">
                            <div class="col-md-12 col-lg-12">
                                <div class="panel panel-default">
                                    <div class="panel-heading">Programme Accreditation Under Verification of Academic Resources</div>

                                    <div class="panel-body">
                                        <div id="exitreportfeedback" runat="server"></div>
                                        <table class="table table-bordered table-striped table-hover" id="dataTables-example5">
                                            <thead>
                                                <tr>
                                                    <th>Accreditation No</th>
                                                    <th>Campus</th>
                                                    <th>Program Name</th>
                                                    <th>Program Domain</th>
                                                    <th>Verdict</th>
                                                    <%--<th>Responsibility</th>--%>
                                                    <th>Respond</th>
                                                    <th>Feedback Report</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    var nav4 = Config.ReturnNav();
                                                    var requestsprog4 = nav4.ProgramAccreditation.Where(r => r.Institution_No == Convert.ToString(Session["UniversityCode"])&&r.Current_Version==true &&r.Published==true && r.Status == "Verification of Academic Resources");
                                                    foreach (var request in requestsprog4)
                                                    {
                                                %>
                                                <tr>
                                                    <td><%=request.Accreditation_No %></td>
                                                    <td><%=request.Campus_Name %></td>
                                                    <td><%=request.Program_Name %></td>
                                                    <td><%=request.domainDescription %></td>
                                                    <td><%=request.Programme_Verdict %></td>
                                                    <%--<td><%=request.Responsibility %></td>--%>
                                                      <td><a href="VerificationsofAcademicResources.aspx?accreditationNo=<%=request.Accreditation_No %>" class="btn btn-success"><i class="fa fa-share"></i>Respond</a></td>
                                                    <td>
                                                     <label class="btn btn-success" onclick="generateExitReport('<%=request.Accreditation_No %>','<%=request.Program_Name %>')"><i class="fa fa-download"></i>Download</label></td>
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
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function () {
            $('#dataTables-example1').DataTable({
                responsive: true
            });
        });
        $(document).ready(function () {
            $('#dataTables-example2').DataTable({
                responsive: true
            });
        });
        $(document).ready(function () {
            $('#dataTables-example3').DataTable({
                responsive: true
            });
        });
        $(document).ready(function () {
            $('#dataTables-example4').DataTable({
                responsive: true
            });
        });
        $(document).ready(function () {
            $('#dataTables-example5').DataTable({
                responsive: true
            });
        });
    </script>
    <script type="text/javascript">
        function generatefeddbackvoucher(programmeNumber, Name) {
            document.getElementById("MainContent_txtprogramname").value = Name;
            document.getElementById("MainContent_txtprogrammeNumber").value = programmeNumber;
            document.getElementById("MainContent_txtprogrammeNumbers").value = programmeNumber;
            $("#generatefeddbackVoucherModal").modal();
        }
    </script>
    <script type="text/javascript">
        function generateEvaluationTool(programmeNumber, Name) {
            document.getElementById("MainContent_txtprogramnames").value = Name;
            document.getElementById("MainContent_txtprogramsnumber").value = programmeNumber;
            document.getElementById("MainContent_txtprogramsnumbers").value = programmeNumber;
            $("#generateEvaluationToolModal").modal();
        }
    </script>
     <script type="text/javascript">
        function generateExitReport(programmeNumber, Name) {
            document.getElementById("MainContent_txtexitprogrammename").value = Name;
            document.getElementById("MainContent_txtexitprogramnumber").value = programmeNumber;
            document.getElementById("MainContent_txtexitprogramnumbers").value = programmeNumber;
            $("#generateexitreportModal").modal();
        }
    </script>
    <div id="generatefeddbackVoucherModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Generate Completeness Check Feedback Voucher</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="txtprogrammeNumbers" type="hidden" />
                    <div class="form-group">
                        <strong>Accreditation Number:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="txtprogrammeNumber" ReadOnly="true" />
                    </div>
                    <div class="form-group">
                        <strong>Programme Name:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="txtprogramname" TextMode="MultiLine" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Generate Feedback Report" OnClick="GenerateFeedbackVoucher_Click" />
                </div>
            </div>

        </div>
    </div>
    <div id="generateEvaluationToolModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Generate Programme Evaluation Report</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="txtprogramsnumbers" type="hidden" />
                    <div class="form-group">
                        <strong>Accreditation Number:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="txtprogramsnumber" ReadOnly="true" />
                    </div>
                    <div class="form-group">
                        <strong>Programme Name:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="txtprogramnames" TextMode="MultiLine" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Generate Evaluation Report" OnClick="GenerateEvaluationReport_Click" />
                </div>
            </div>

        </div>
    </div>
     <div id="generateexitreportModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Generate Programme Exit Report</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="txtexitprogramnumbers" type="hidden" />
                    <div class="form-group">
                        <strong>Accreditation Number:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="txtexitprogramnumber" ReadOnly="true" />
                    </div>
                    <div class="form-group">
                        <strong>Programme Name:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="txtexitprogrammename" TextMode="MultiLine" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Generate Exit Report" OnClick="GenerateExitReport_Click" />
                </div>
            </div>

        </div>
    </div>
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
