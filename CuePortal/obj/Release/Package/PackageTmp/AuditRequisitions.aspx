<%@ Page Title="" Language="C#" MasterPageFile="~/QAMaster.Master" AutoEventWireup="true" CodeBehind="AuditRequisitions.aspx.cs" Inherits="CicPortal.AuditRequisitions" %>
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
                             <th>View Details</th>
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
                                 <td><a href="ViewActiveSAR.aspx?SARNo=<%=program.Code %>" class="btn btn-success"><i class="fa fa-eye"></i>  View Details</a></td>
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
     <script>
         $(document).ready(function() {
             $('#dataTables-example').DataTable({
                 responsive: true
             });
         });

         function viewDetails(docno, description, instname, startdate, enddate) {
             document.getElementById("MainContent_tdocno").value = docno;
             document.getElementById("MainContent_description").value = description;
             document.getElementById("MainContent_institutionname").value = instname;
             document.getElementById("MainContent_startdate").value = startdate;
             document.getElementById("MainContent_enddate").value = enddate;
             $("#viewDetailsmodal").modal();
         }
     </script>
 <div id="viewDetailsmodal" class="modal fade" role="dialog">
          <div class="modal-dialog modal-lg">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Invitation For Quality Audit</h4>
              </div>
              <div class="modal-body">                 
                     <div class="row" >
                        <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <label class="required">Description</label>
                                <asp:TextBox CssClass="form-control" runat="server" ID="description" ReadOnly="true"/>   
                        </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <label class="required">Program Name</label>                       
                                <asp:TextBox CssClass="form-control" runat="server" ID="institutionname" ReadOnly="true" />      
                            </div>
                        </div>
                    </div>
                    <div class="row" >
                        <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <label class="required">Audit Plan Start Date</label>                       
                                <asp:TextBox CssClass="form-control" runat="server" ID="startdate"  ReadOnly="true"/>                   
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <label class="required">Audit Plan End Date</label>                       
                                <asp:TextBox CssClass="form-control" runat="server" ID="enddate"  ReadOnly="true"/>
                            </div>
                        </div>
                    </div> 
                     <div class="panel panel-default">
                        <div class="panel-heading">
                            <div runat="server" id="terminate"></div>
                                 Proposed Auditor Team
                            </div>
                        <br />
                             <table class="table table-bordered table-striped dataTable">
                            <thead>
                            <tr>
                                <th>#</th>
                                <th>Auditor Name</th>
                                <th>Engagement Role</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <%--<th>Job Title</th>--%>
                            </tr>
                            </thead>
                            <tbody>
                            <asp:TextBox runat="server" ID="tdocno" type="hidden"/>
                            <% var nav1 = Config.ReturnNav();
                                //string AuditNo = tdocno.Text;
                                string AuditNo = Convert.ToString(Session["AuditNo"]);
                                var details = nav1.AuditCMNTeam.Where(r => r.Document_No == AuditNo);
                                int programesCounter = 0;
                                foreach (var detail in details)
                                {
                                    programesCounter++;
                                 %>
                                <tr>
                                    <td><%=programesCounter %></td>
                                    <td><%=detail.Name %></td>
                                    <td><%=detail.Job_Title %></td>
                                    <td><% = Convert.ToDateTime(detail.Start_Date).ToString("dd/MM/yyyy")%></td>
                                    <td><% = Convert.ToDateTime(detail.End_Date).ToString("dd/MM/yyyy")%></td>
                                   <%-- <td><%=detail.Job_Title %></td>  --%>                     
                                </tr>
                                <%  
                               } %>
                            </tbody>
                        </table> 
                     </div> 
                </div> 
             </div>
         </div>
    </div>

</asp:Content>
