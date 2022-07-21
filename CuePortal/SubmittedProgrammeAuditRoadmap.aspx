<%@ Page Title="" Language="C#" MasterPageFile="~/QAMaster.Master" AutoEventWireup="true" CodeBehind="SubmittedProgrammeAuditRoadmap.aspx.cs" Inherits="CicPortal.SubmittedProgrammeAuditRoadmap" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <div class="row">
            <div class="col-md-12 col-lg-12">
                  <div class="panel panel-default">
            <div class="panel-heading">Submitted Programme Audit Roadmap</div>
                <div class="panel-body">
                    <div id ="feedback" runat="server"></div>
                     <table class="table table-striped table-bordered table-hover"  id="dataTables-example">
                       <thead>
                         <tr>
                             <th>Audit Number</th>
                             <th>Description Of Audit Roadmap</th>
                             <th>Planned Start Date</th>
                             <th>Planned End Date</th>
                         </tr>
                         </thead>
                         <tbody>
                         <%
                             var nav = Config.ReturnNav();
                             var programs = nav.AuditRequisitionHeader.Where(r => r.Institution_Code == Convert.ToString(Session["UniversityCode"])  && r.Document_Type == "Audit Roadmap" && r.Task_Type == "Programme Quality Audit" && r.Submission_Status == "Submitted");
                             foreach (var program in programs)
                             {
                             %>
                             <tr>
                                 <td><%=program.Code %></td>
                                 <td><%=program.Description %></td>
                                 <td><% = Convert.ToDateTime(program.Audit_Plan_Start_Date).ToString("dd/MM/yyyy")%></td>
                                 <td><% = Convert.ToDateTime(program.Audit_Plan_End_Date).ToString("dd/MM/yyyy")%></td>                           
                             </tr>
                             <%
                            }
                         %>
                         </tbody>
                     </table>   
                    </div> 
 
                </div>
                <br />
                     <asp:Button runat="server" style="margin-left:2%" CssClass="btn btn-warning" Text="Go To Homepage" ID="GoToHomepage" OnClick="GoToHomepage_Click"/>
                <br />
                <br />
            </div>
           </div>
         </div>
</asp:Content>