<%@ Page Title="" Language="C#" MasterPageFile="~/QAMaster.Master" AutoEventWireup="true" CodeBehind="OpenCorrectionOfFuctualErrors.aspx.cs" Inherits="CicPortal.OpenCorrectionOfFuctualErrors" %>

<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="DataCollection.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">Correction of Factual Errors</li>
            </ol>
        </div>
    </div>
    <div>
        <div class="row">
            <div class="col-md-12 col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">Open Correction Of Factual Errors</div>
                    <div class="panel-body">
                        <div id="feedback" runat="server"></div>
                        <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Audit No</th>
                                    <th>Description</th>
                                    <th>Planned Start Date</th>
                                    <th>Planned End Date</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int counter = 0;
                                    var nav = Config.ReturnNav();
                                    var programs = nav.AuditRequisitionHeader.Where(r => r.Institution_Code == Convert.ToString(Session["UniversityCode"]) && r.Approval_Status == "Released" && r.Document_Type == "Factual Error" && r.Task_Type == "Institution Quality Audit" && r.Submission_Status == "Open");
                                    foreach (var program in programs)
                                    {
                                        counter++;
                                        Session["AuditNo"] = program.Code;
                                %>
                                <tr>
                                    <td><%=counter %></td>
                                    <td><%=program.Code %></td>
                                    <td><%=program.Description %></td>
                                    <td><% = Convert.ToDateTime(program.Audit_Plan_Start_Date).ToString("dd/MM/yyyy")%></td>
                                    <td><% = Convert.ToDateTime(program.Audit_Plan_End_Date).ToString("dd/MM/yyyy")%></td>
                                    <td><a href="FactualErrors.aspx?feedbackNo=<%=program.Code %>" class="btn btn-primary"><i class="fa fa-eye"></i>View Details</a></td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <asp:Button runat="server" Style="margin-left: 2%" CssClass="btn btn-warning" Text="Go To Homepage" ID="gotohomepage" OnClick="gotohomepage_Click" />
            <br />
            <br />
            <br />
        </div>
    </div>
</asp:Content>
