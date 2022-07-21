<%@ Page Title="" Language="C#" MasterPageFile="~/AccreditationMaster.Master" AutoEventWireup="true" CodeBehind="OngoingPrograms.aspx.cs" Inherits="CicPortal.OngoingPrograms" %>

<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%
        var step = Request.QueryString["step"];
        int myStep = 0;
        int maxSteps = 5;
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
        var nav = Config.ReturnNav();
    %>
    <%  if (myStep == 1)
        {
    %>
    <section style="background: #efefe9;">
        <div class="row">
            <div class="panel panel-default">
                <div class="panel-heading"><strong>University Programme Accreditation Progress</strong> </div>
                <div class="board">
                    <div class="board-inner">
                        <ul class="nav nav-tabs" id="myTab">
                            <li class="active">
                                <a href="#home" data-toggle="tab" title="Step 1">
                                    <span class="round-tabs one">
                                        <i class="fa fa-home"></i>
                                        <strong>Stage1:</strong>
                                    </span>
                                </a></li>

                            <li><a href="#profile" data-toggle="tab" title="Step 2">
                                <span class="round-tabs two">
                                    <i class="fa fa-chevron-right"></i>
                                    <strong>Stage2:</strong>
                                </span>
                            </a>
                            </li>
                            <li><a href="#messages" data-toggle="tab" title="Step 3">
                                <span class="round-tabs three">
                                    <i class="fa fa-chevron-right"></i>
                                    <strong>Stage3:</strong>
                                </span></a>
                            </li>

                            <li><a href="#settings" data-toggle="tab" title="Step 4">
                                <span class="round-tabs four">
                                    <i class="fa fa-chevron-right"></i>
                                    <strong>Stage4:</strong>
                                </span>
                            </a></li>

                            <li><a href="#doner" data-toggle="tab" title="Step 5">
                                <span class="round-tabs five">
                                    <i class="fa fa-chevron-right"></i>
                                    <strong>Stage5:</strong>
                                </span></a>
                            </li>
                        </ul>

                    </div>
                    <div class="tab-content">
                        <div class="tab-pane fade in active" id="home">
                            <div class="container">
                                <h2>Programme Accreditation Progress</h2>
                                <p>Preliminary Review</p>
                                <div class="progress">
                                    <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width: 20%">
                                        Accreditation Process 20% Complete
                                    </div>
                                </div>
                                 <p>Actionable items/Areas of responsibility are:</p>
                            <ul>
                              <li>Undergoing preliminary check by the Commission</li>
                              <li>Completeness check completed, awaiting payment by the University</li>
                              <li>Completeness check completed, awaiting re-submission by the University (after preliminary check report has been submitted to university)</li>
                            </ul>    
                            </div>
                            <div class="row">
                                <div class="col-md-12 col-lg-12">
                                    <div class="panel panel-default">
                                        <div class="panel-heading"><strong>Preliminary Review</strong> </div>
                                        <div class="panel-body">
                                            <table class="table table-bordered table-striped table-hover" id="dataTables-example1">
                                                <thead>
                                                    <tr>
                                                        <th>#</th>
                                                        <th>Accreditation No:</th>
                                                        <th>Programme Name</th>
                                                        <th>Campus</th>
                                                        <th>Application Date</th>
                                                        <th>Status</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        var programs = nav.ProgramAccreditation.Where(r => r.Institution_No == Convert.ToString(Session["UniversityCode"]) &&r.Current_Version==true && r.Status == "Awaiting Completeness Check");
                                                        int programme11 = 0;
                                                        foreach (var program in programs)
                                                        {
                                                            programme11++;
                                                    %>
                                                    <tr>
                                                        <td><%=programme11 %></td>
                                                        <td><%=program.Accreditation_No %></td>
                                                        <td><%=program.Program_Name %></td>
                                                        <td><%=program.Campus_Name %></td>
                                                        <td><%=program.Date_Created %></td>
                                                        <td><%=program.Status %></td>
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
                        <div class="tab-pane fade" id="profile">
                            <div>
                                <div class="container">
                                    <h2>Programme Accreditation Progress</h2>
                                    <p>Under Peer Review</p>
                                    <div class="progress">
                                        <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%">
                                            Accreditation Process 40% Complete
                                        </div>
                                    </div>
                                      <p>Actionable items/Areas of responsibility are:</p>
                                    <ul>
                                      <li>Awaiting feedback from the Commission</li>
                                      <li>Awaiting feedback from the University (after Peer Reviewers’ report submitted to university)</li>                                   
                                    </ul>    
                                </div>
                                <div class="row">
                                    <div class="col-md-12 col-lg-12">
                                        <div class="panel panel-default">
                                            <div id="feedback" runat="server"></div>
                                            <div class="panel-heading"><strong>Under Peer Review</strong> </div>
                                            <div class="panel-body">
                                                <div id="Div1" runat="server"></div>
                                                <table class="table table-bordered table-striped table-hover" id="dataTables-example2">
                                                    <thead>
                                                        <tr>
                                                            <th>#</th>
                                                            <th>Accreditation No:</th>
                                                            <th>Programme Name</th>
                                                            <th>Campus</th>
                                                            <th>Application Date</th>
                                                            <th>Status</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%
                                                            var nav2 = Config.ReturnNav();
                                                            var programs2 = nav2.ProgramAccreditation.Where(r => r.Institution_No == Convert.ToString(Session["UniversityCode"])  &&r.Current_Version==true&& r.Status == "Awaiting Peer Review");
                                                            int programme22 = 0;
                                                            foreach (var program2 in programs2)
                                                            {
                                                                programme22++;
                                                        %>
                                                        <tr>
                                                            <td><%=programme22%></td>
                                                            <td><%=program2.Accreditation_No %></td>
                                                            <td><%=program2.Program_Name %></td>
                                                            <td><%=program2.Campus_Name %></td>
                                                            <td><%=program2.Date_Created %></td>
                                                            <td><%=program2.Status %></td>
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
                        <div class="tab-pane fade" id="messages">
                            <div class="container">
                                <h2>Programme Accreditation Progress</h2>
                                <p>Verification of Academic Resources</p>
                                <div class="progress">
                                    <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%">
                                        Accreditation Process 60% Complete
                                    </div>

                                </div>
                                <p>Actionable items/Areas of responsibility are:</p>
                                    <ul>
                                      <li>Awaiting feedback from the Commission</li>
                                      <li>Awaiting feedback from the University (after Peer Reviewers’ report submitted to university)</li>                                   
                                    </ul>   
                            </div>
                            <div class="row">
                                <div class="col-md-12 col-lg-12">
                                    <div class="panel panel-default">
                                        <div class="panel-heading"><strong>Verification of Academic Resources</strong> </div>
                                        <div class="panel-body">
                                            <div id="Div2" runat="server"></div>
                                            <table class="table table-bordered table-striped table-hover" id="dataTables-example">
                                                <thead>
                                                    <tr>
                                                        <th>#</th>
                                                        <th>Accreditation No:</th>
                                                        <th>Programme Name</th>
                                                        <th>Campus</th>
                                                        <th>Application Date</th>
                                                        <th>Status</th>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        var nav3 = Config.ReturnNav();
                                                        var programs3 = nav3.ProgramAccreditation.Where(r => r.Institution_No == Convert.ToString(Session["UniversityCode"])  &&r.Current_Version==true&& r.Status == "Verification of Academic Resources");
                                                        int programme33 = 0;
                                                        foreach (var program3 in programs3)
                                                        {
                                                            programme33++;
                                                    %>
                                                    <tr>
                                                        <td><%=programme33 %></td>
                                                        <td><%=program3.Accreditation_No %></td>
                                                        <td><%=program3.Program_Name %></td>
                                                        <td><%=program3.Campus_Name %></td>
                                                        <td><%=program3.Date_Created %></td>
                                                        <td><%=program3.Status %></td>                                                       
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
                    <div class="tab-pane fade" id="settings">
                        <div>
                            <div class="container">
                                <h2>Programme Accreditation Progress</h2>
                                <p>Being Processed for Approval</p>
                                <div class="progress">
                                    <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width: 80%">
                                        Accreditation Process 80% Complete
                                    </div>
                                </div>
                            </div>
                                                           
                            <div class="row">
                                <div class="col-md-12 col-lg-12">
                                    <div class="panel panel-default">
                                        <div class="panel-heading"><strong>Being Processed for Approval</strong> </div>
                                        <div class="panel-body">
                                            <div id="Div3" runat="server"></div>
                                            <table class="table table-bordered table-striped table-hover" id="dataTables-example4">
                                                <thead>
                                                    <tr>
                                                        <th>#</th>
                                                        <th>Accreditation No:</th>
                                                        <th>Programme Name</th>
                                                        <th>Campus</th>
                                                        <th>Application Date</th>
                                                        <th>Status</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        var nav4 = Config.ReturnNav();
                                                        var programs4 = nav.ProgramAccreditation.Where(r => r.Institution_No == Convert.ToString(Session["UniversityCode"]) &&r.Current_Version==true && r.Status == "Awaiting Board Approval");
                                                        int program44 = 0;
                                                        foreach (var program4 in programs4)
                                                        {
                                                            program44++;
                                                    %>
                                                    <tr>
                                                        <td><%=program44 %></td>
                                                        <td><%=program4.Accreditation_No %></td>
                                                        <td><%=program4.Program_Name %></td>
                                                        <td><%=program4.Campus_Name %></td>
                                                        <td><%=program4.Date_Created %></td>
                                                        <td><%=program4.Status %></td>
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
                    <div class="tab-pane fade" id="doner">
                        <div>
                            <div class="container">
                                <h2>Programme Accreditation Progress</h2>
                                <p>Application for Programme Accreditation completed</p>
                                <div class="progress">
                                    <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%">
                                        Accreditation Process 100% Complete
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12 col-lg-12">
                                    <div class="panel panel-default">
                                        <div class="panel-heading"><strong>Application for Programme Accreditation completed</strong> </div>
                                        <div class="panel-body">
                                            <div id="Div4" runat="server"></div>
                                            <table class="table table-bordered table-striped table-hover" id="dataTables-example5">
                                                <thead>
                                                    <tr>
                                                        <th>#</th>
                                                        <th>Accreditation No:</th>
                                                        <th>Programme Name</th>
                                                        <th>Campus</th>
                                                        <th>Application Date</th>
                                                        <th>Status</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        var nav5 = Config.ReturnNav();
                                                        var programs5 = nav.ProgramAccreditation.Where(r => r.Institution_No == Convert.ToString(Session["UniversityCode"]) && r.Current_Version==true&& r.Status == "Completed");
                                                        int programs55 = 0;
                                                        foreach (var program5 in programs5)
                                                        {
                                                            programs55++;
                                                    %>
                                                    <tr>
                                                        <td><%=programs55 %></td>
                                                        <td><%=program5.Accreditation_No %></td>
                                                        <td><%=program5.Program_Name %></td>
                                                        <td><%=program5.Campus_Name %></td>
                                                        <td><%=program5.Date_Created %></td>
                                                        <td><%=program5.Status %></td>
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
                <div class="clearfix"></div>
            </div>

        </div>
        </div>
    </section>
    <div id="MakepaymentsModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Programme Accreditation Paymemts</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="editRationaleCode" type="hidden" />
                    <div class="form-group">
                        <strong>Accreditation Number:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="accreditationnumber" placeholder="Programme Accreditation Number" />

                    </div>
                    <div class="form-group">
                        <strong>Programme Name:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="programmeName" placeholder="Programme Name" ReadOnly="true" />
                    </div>
                    <div class="form-group">
                        <strong>Payment Document:</strong>
                        <asp:FileUpload runat="server" ID="paymentdocument" CssClass="form-control" Style="padding-top: 0px;" />
                        <asp:RequiredFieldValidator runat="server" ID="payments" ControlToValidate="paymentdocument" ErrorMessage="Please attach the Payment Document!" ForeColor="Red" />
                        <div class="form-group">
                            <strong>Payment Reference Number:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="paymentsref" placeholder="Payment Reference Number" />
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Confirm Payments" ID="makePayments" OnClick="ConfirmPayments_Click" />
                </div>
            </div>

        </div>
    </div>
    <script>
        function makePayments(no, name) {
            document.getElementById("MainContent_accreditationnumber").value = no;
            document.getElementById("MainContent_programmeName").value = name;
            $("#MakepaymentsModal").modal();
        }
    </script>
    <script>
        $(document).ready(function () {
            $('#dataTables-example').DataTable({
                responsive: true
            });
        });
    </script>
    <script>
        $(document).ready(function () {
            $('#dataTables-example1').DataTable({
                responsive: true
            });
        });
    </script>
    <script>
        $(document).ready(function () {
            $('#dataTables-example2').DataTable({
                responsive: true
            });
        });
    </script>
    <script>
        $(document).ready(function () {
            $('#dataTables-example4').DataTable({
                responsive: true
            });
        });
    </script>
    <script>
        $(document).ready(function () {
            $('#dataTables-example5').DataTable({
                responsive: true
            });
        });
    </script>
    <%} %>
</asp:Content>
