<%@ Page Title="" Language="C#" MasterPageFile="~/QAMaster.Master" AutoEventWireup="true" CodeBehind="AuditRequisitionsDetails.aspx.cs" Inherits="CicPortal.AuditRequisitionsDetails" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <div class="row">
            <div class="col-md-12 col-lg-12">
                                
             <div class="panel panel-default">
                <div class="panel-heading">
                    Invitation For Quality Audit <i>This are the general details of the audit. Once you complete approving/rejecting and adding auditee, you can download/printout the final report</i>
                </div>
                 <br />
                 <asp:Button runat="server" style="margin-left:80%" CssClass="btn btn-warning fa-eye" Text="Print Document" ID="PrintDocument" OnClick="PrintDocument_Click"/><br />
                <div class="panel-body">
                    <div id ="feedback" runat="server"></div>

                       <div class="row" >
  
                              <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <label class="required">Description Of The Quality Audit</label>
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
                                     <label class="required">Planned Start Date</label>                       
                                        <asp:TextBox CssClass="form-control" runat="server" ID="startdate" ReadOnly="true"/>                   
                                   </div>
                             </div>
                              <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label class="required">Planned End Date</label>                       
                                        <asp:TextBox CssClass="form-control" runat="server" ID="enddate" ReadOnly="true"/>
                                  </div>
                             </div>
                         </div> 
                         <div class="row" style="display:none">
                             <div class="col-md-6 col-lg-6">
                                 <div class="form-group">
                                     <label class="required">Program Name</label>                       
                                        <asp:TextBox CssClass="form-control" runat="server" ID="programmename" ReadOnly="true" />      
                                    </div>
                             </div>
                         </div>
                  </div> 
          <div class="panel panel-default">
            <div class="panel-heading">
                <div runat="server" id="terminate"></div>
                     Proposed Auditor Team <i>This is the auditor team proposed by Commission of University Education. Please approve or reject the proposed auditor team </i>
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
                    <th>Approve Auditor</th>
                    <th>Reject Auditor</th>
                    <%--<th>Job Title</th>--%>
                </tr>
                </thead>
                <tbody>
                <% var nav = Config.ReturnNav();
                    string AuditNo = Convert.ToString(Session["EngagementId"]);
                    var details = nav.AuditCMNTeam.Where(r => r.Document_No == AuditNo && r.Responded == false);
                    string university = Convert.ToString(Session["UniversityCode"]);
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
                        <td><label class="btn btn-success" onclick="approveauditor('<%=detail.Document_No %>','<%=detail.Name %>','<%=detail.Resource_No %>')"><i class="fa fa-pencil"></i> Approve Auditor</label></td>
                        <td><label class="btn btn-danger" onclick="rejectauditor('<%=detail.Document_No %>','<%=detail.Name %>','<%=detail.Resource_No %>')"><i class="fa fa-thrash"></i> Reject Auditor</label></td>
                       <%-- <td><%=detail.Job_Title %></td>  --%>                     
                    </tr>
                    <%  
                   } %>
                </tbody>
            </table> 
             </div>

                  <div class="panel panel-default">
            <div class="panel-heading">
                <div runat="server" id="Div1"></div>
                     Approved Auditors
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
                </tr>
                </thead>
                <tbody>
                <% 
                    var details1 = nav.AuditCMNTeam.Where(r => r.Document_No == AuditNo && r.Responded == true && r.Approved == true);
                    int programesCounter10 = 0;
                    foreach (var detail in details1)
                    {
                        programesCounter10++;
                     %>
                    <tr>
                        <td><%=programesCounter10 %></td>
                        <td><%=detail.Name %></td>
                        <td><%=detail.Job_Title %></td>
                        <td><% = Convert.ToDateTime(detail.Start_Date).ToString("dd/MM/yyyy")%></td>
                        <td><% = Convert.ToDateTime(detail.End_Date).ToString("dd/MM/yyyy")%></td>                   
                    </tr>
                    <%  
                   } %>
                </tbody>
            </table> 
             </div>

                      <div class="panel panel-default">
            <div class="panel-heading">
                <div runat="server" id="Div2"></div>
                     Rejected Auditors
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
                </tr>
                </thead>
                <tbody>
                <%
                    var details2 = nav.AuditCMNTeam.Where(r => r.Document_No == AuditNo && r.Responded == true && r.Approved == false);
                    int programesCounter20 = 0;
                    foreach (var detail in details2)
                    {
                        programesCounter20++;
                     %>
                    <tr>
                        <td><%=programesCounter20 %></td>
                        <td><%=detail.Name %></td>
                        <td><%=detail.Job_Title %></td>
                        <td><% = Convert.ToDateTime(detail.Start_Date).ToString("dd/MM/yyyy")%></td>
                        <td><% = Convert.ToDateTime(detail.End_Date).ToString("dd/MM/yyyy")%></td>                   
                    </tr>
                    <%  
                   } %>
                </tbody>
            </table> 
             </div>
                     <div class="panel panel-default">
            <div class="panel-heading">
                <div runat="server" id="contactpersons"></div>
                  
                     Proposed Auditee Team <i>Kindly add your proposed auditee team by clicking on the 'Add Auditee Team' button</i>
                </div>
            <br />
                 <label class="btn btn-success" style="margin-left:5%" data-toggle="modal" data-target="#addcontactperson"><i class="fa fa-plus fa-fw"></i>Add Auditee Team</label>
                 <br />
                 <br />
                 <table class="table table-bordered table-striped dataTable">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Auditee Name</th>
                    <th>Engagement Role</th>
                    <th>Official Email Address</th>
                    <th>Phone Number</th>
                    <th>Edit Auditee</th>
                    <th>Remove Auditee</th>
                </tr>
                </thead>
                <tbody>
                <% var nav1 = Config.ReturnNav();
                    string AuditNo1 = Convert.ToString(Session["EngagementId"]);
                    var mdetail = nav1.AuditeeCMNTeam.Where(r => r.Document_No == AuditNo1);
                    string university1 = Convert.ToString(Session["UniversityCode"]);
                    int programesCounter1 = 0;
                    foreach (var tdetail in mdetail)
                    {
                        programesCounter1++;
                     %>
                    <tr>
                        <td><%=programesCounter1 %></td>
                        <td><%=tdetail.Name %></td>
                        <td><%=tdetail.Job_Title %></td>
                        <td><%=tdetail.Email %></td>
                        <td><%=tdetail.Phone_No %></td>
                        <td><label class="btn btn-success" onclick="editauditee('<%=tdetail.Line_No %>','<%=tdetail.Document_No %>','<%=tdetail.Name %>','<%=tdetail.Job_Title %>','<%=tdetail.Email %>','<%=tdetail.Phone_No %>')"><i class="fa fa-pencil"></i> Edit Auditee</label></td>
                        <td><label class="btn btn-danger" onclick="deleteauditee('<%=tdetail.Line_No %>','<%=tdetail.Document_No %>','<%=tdetail.Name %>')"><i class="fa fa-thrash"></i> Remove Auditee</label></td>                    
                    </tr>
                    <%  
                   } %>
                </tbody>
            </table>                         
             </div>  
                <center>
                <asp:Button runat="server" CssClass="btn btn-success" Text="Submit Invitation Response" ID="submitInvitation" OnClick="submitInvitation_Click"/>
                </center><br />
           </div>

         </div>
         <asp:Button runat="server" style="margin-left:2%" CssClass="btn btn-warning" Text="Go To Homepage" ID="previouspage" OnClick="previouspage_Click"/>
        <br />
        <br />
        <br />
       </div>
    </div>

    <div id="addcontactperson" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Add Auditee</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="editRationaleCode" type="hidden" />
                    <div class="form-group">
                        <strong>Auditee Name</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="auditeename" placeholder="Please Enter Auditee Name" />
                    </div>
                    <div class="form-group">
                        <strong>Engagement Role</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="tengagement" placeholder="Please Enter Engagement Role" />
                    </div>
                    <div class="form-group">
                        <strong>Official Email Address</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="temail" placeholder="Please Enter Official Email Address"/>
                    </div>
                    <div class="form-group">
                        <strong>Phone Number</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="tphone" type="number" placeholder="Please Enter Phone Number"/>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Add Auditee" ID="buttonaddcontactperson" OnClick="buttonaddcontactperson_Click"/>
                </div>
            </div>

        </div>
    </div>

 <div id="approveauditormodal" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Confirm Approval of Auditor</h4>
          </div>
          <div class="modal-body">
            <p>Are you sure you want to approve <strong id="nametoapprove"></strong> as an Auditor? Note that once you approve the auditor you cannot undo the action again</p>
              <asp:TextBox runat="server" ID="txtdoclinenoapprove" type="hidden"/>
              <asp:TextBox runat="server" ID="txtresource" type="hidden"/>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
              <asp:Button runat="server" CssClass="btn btn-success" Text="Approve Auditor" ID="buttonapprovecontactperson" OnClick="buttonapprovecontactperson_Click"/>
          </div>
    </div>
  </div>
</div>


 <div id="rejectauditormodal" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Reason for rejecting Auditor</h4>
          </div>
          <div class="modal-body">
              <asp:TextBox runat="server" ID="txtdoclinenoreject" type="hidden"/>
              <asp:TextBox runat="server" ID="txtresourceperson" type="hidden"/>
              <p>Are you sure you want to reject <strong id="txtrejectcontact"></strong>as an Auditor? Note that once you reject the auditor you cannot undo the action again</p>
           <div class="form-group">
                <strong>Reason For Rejecting Auditor</strong>
                <asp:TextBox runat="server" CssClass="form-control" ID="txtreason" placeholder="Enter Reason"/>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
              <asp:Button runat="server" CssClass="btn btn-danger" Text="Reject Auditor" ID="RejectContactPerson" OnClick="RejectContactPerson_Click"/>
          </div>
    </div>
  </div>
</div>

 <div id="deleteauditeemodal" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Remove Auditee from the list</h4>
          </div>
          <div class="modal-body">
            <p>Are you sure you want to remove <strong id="txtnametoapprove"></strong> as an auditee?</p>
              <asp:TextBox runat="server" ID="txtlineno" type="hidden"/>
              <asp:TextBox runat="server" ID="txtdocno" type="hidden"/>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
              <asp:Button runat="server" CssClass="btn btn-success" Text="Remove Auditee" ID="removeauditee" OnClick="removeauditee_Click"/>
          </div>
    </div>
  </div>
</div>

    <div id="editauditeemodal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit Auditee</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="tlineno" type="hidden" />
                    <asp:TextBox runat="server" ID="tdocno" type="hidden" />
                    <div class="form-group">
                        <strong>Auditee Name</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="tname"/>
                    </div>
                    <div class="form-group">
                        <strong>Engagement Role</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="tjobtitle"/>
                    </div>
                    <div class="form-group">
                        <strong>Official Email Address</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="ttemail"/>
                    </div>
                    <div class="form-group">
                        <strong>Phone Number</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="ttphone" type="number"/>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Edit Auditee" ID="editauditee" OnClick="editauditee_Click"/>
                </div>
            </div>

        </div>
    </div>

<script>
    function approveauditor(approvelineno, name, resourceno) {
        document.getElementById("nametoapprove").innerText = name;
        document.getElementById("MainContent_txtdoclinenoapprove").value = approvelineno;
        document.getElementById("MainContent_txtresource").value = resourceno;
        $("#approveauditormodal").modal();
    }

    function rejectauditor(approvelineno, name, resourceno) {
        document.getElementById("txtrejectcontact").innerText = name;
        document.getElementById("MainContent_txtdoclinenoreject").value = approvelineno;
        document.getElementById("MainContent_txtresourceperson").value = resourceno;
        $("#rejectauditormodal").modal();
    }

    function deleteauditee(lineno, docno, name) {
        document.getElementById("txtnametoapprove").innerText = name;
        document.getElementById("MainContent_txtlineno").value = lineno;
        document.getElementById("MainContent_txtdocno").value = docno;
        $("#deleteauditeemodal").modal();
    }

    function editauditee(lineno, docno, name, jobtitle, email, phone) {
        document.getElementById("MainContent_tlineno").value = lineno;
        document.getElementById("MainContent_tdocno").value = docno;
        document.getElementById("MainContent_tname").value = name;
        document.getElementById("MainContent_tjobtitle").value = jobtitle;
        document.getElementById("MainContent_ttemail").value = email;
        document.getElementById("MainContent_ttphone").value = phone;
        $("#editauditeemodal").modal();
    }
</script>
</asp:Content>
