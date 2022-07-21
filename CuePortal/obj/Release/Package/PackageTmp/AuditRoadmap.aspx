<%@ Page Title="" Language="C#" MasterPageFile="~/QAMaster.Master" AutoEventWireup="true" CodeBehind="AuditRoadmap.aspx.cs" Inherits="CicPortal.AuditRoadmap" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <div class="row">
            <div class="col-md-12 col-lg-12">
                  <div class="panel panel-default">
            <div class="panel-heading">Audit Roadmap</div>
                <div class="panel-body">
                    <div id ="feedback" runat="server"></div>
                     <table class="table table-striped table-bordered table-hover"  id="dataTables-example">
                       <thead>
                         <tr>
                             <th>Audit Number</th>
                            <th>Description Of Audit Roadmap</th>
                             <th>Planned Start Date</th>
                             <th>Planned End Date</th>
                             <%--<th>View Roadmap Details</th>--%>
                             <th>Respond To Audit Questions</th>
                         </tr>
                         </thead>
                         <tbody>
                         <%
                             var nav = Config.ReturnNav();
                             var programs = nav.AuditRequisitionHeader.Where(r => r.Institution_Code == Convert.ToString(Session["UniversityCode"])  && r.Document_Type == "Audit Roadmap" && r.Task_Type == "Institution Quality Audit" && r.Submission_Status == "Open");
                             foreach (var program in programs)
                             {
                             %>
                             <tr>
                                 <td><%=program.Code %></td>
                                 <td><%=program.Description %></td>
                                 <td><% = Convert.ToDateTime(program.Audit_Plan_Start_Date).ToString("dd/MM/yyyy")%></td>
                                 <td><% = Convert.ToDateTime(program.Audit_Plan_End_Date).ToString("dd/MM/yyyy")%></td>
                                <%-- <td><a href="RoadmapReport.aspx?RoadmapNo=<%=program.Code %>" class="btn btn-success"><i class="fa fa-eye"></i>  View Roadmap Details</a></td>--%>
                                 <td><a href="AuditRoadmapLines.aspx?RoadmapNo=<%=program.Code %>" class="btn btn-success"><i class="fa fa-reply"></i>  Respond To Audit Findings</a></td>
                             </tr>
                             <%
                            }
                         %>
                         </tbody>
                     </table>   
                    </div> 
 
                </div>
                <br />
                     <asp:Button runat="server" style="margin-left:2%" CssClass="btn btn-warning" Text="Go To Homepage" ID="GoToHomepage"/>
                <br />
                <br />
            </div>
           </div>
         </div>
</asp:Content>
