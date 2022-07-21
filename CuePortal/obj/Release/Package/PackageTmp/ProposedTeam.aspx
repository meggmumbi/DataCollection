<%@ Page Title="" Language="C#" MasterPageFile="~/QAMaster.Master" AutoEventWireup="true" CodeBehind="ProposedTeam.aspx.cs" Inherits="CicPortal.ProposedTeam" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <div class="row">
            <div class="col-md-12 col-lg-12">
                  <div class="panel panel-default">
            <div class="panel-heading">Open Audit Invitations</div>
                <div class="panel-body">
                    <div id ="feedback" runat="server"></div>
                     <table class="table table-striped table-bordered table-hover"  id="dataTables-example">
                       <thead>
                         <tr>
                            <th>Audit No</th>
                            <th>Description</th>
                             <%--<th>Program Name</th>--%>
                             <th>Planned Start Date</th>
                             <th>Planned End Date</th>
                             <th>Respond</th>
                             <%--<th>Respond</th>--%>
                         </tr>
                         </thead>
                         <tbody>
                         <%
                             var nav = Config.ReturnNav();
                             var programs = nav.AuditRequisitionHeader.Where(r => r.Institution_Code == Convert.ToString(Session["UniversityCode"]) &&r.Published == true && r.Document_Type == "Engagement" && r.Task_Type == "Institution Quality Audit" && r.Submission_Status == "Open");
                             foreach (var program in programs)
                             {
                                 Session["AuditNo"] = program.Code;
                             %>
                             <tr>
                                 <td><%=program.Code %></td>
                                 <td><%=program.Description %></td>
                                 <%--<td><%=program.Programme_Name %></td>--%>
                                 <td><% = Convert.ToDateTime(program.Audit_Plan_Start_Date).ToString("dd/MM/yyyy")%></td>
                                 <td><% = Convert.ToDateTime(program.Audit_Plan_End_Date).ToString("dd/MM/yyyy")%></td>
                                 <td><a href="AuditRequisitionsDetails.aspx?SARNo=<%=program.Code %>" class="btn btn-success"><i class="fa fa-eye"></i>  Respond</a></td>
                                <%-- <td><label class="btn btn-success" onclick="viewDetails('<%=program.Code %>','<%=program.Description %>','<%=program.Programme_Name %>','<%=program.Audit_Plan_Start_Date %>','<%=program.Audit_Plan_End_Date %>')"><i class="fa fa-eye"></i> View Details</label></td>--%>
                                 <%--<td><a href="AuditRequisitionsDetails.aspx?AuditNo=<%=program.Code %>" class="btn btn-success"><i class="fa fa-reply"></i>  Respond</a></td>--%>
                             </tr>
                             <%
                            }
                         %>
                         </tbody>
                     </table>   
                    </div>   
                </div>
            </div>
               <asp:Button runat="server" style="margin-left:2%" CssClass="btn btn-warning" Text="Go To Homepage" ID="gotohomepage" OnClick="gotohomepage_Click"/>
                <br />
                <br />
                <br />
           </div>
         </div>
</asp:Content>
