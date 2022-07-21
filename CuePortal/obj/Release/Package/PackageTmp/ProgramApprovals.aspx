<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AccreditationMaster.Master" CodeBehind="ProgramApprovals.aspx.cs" Inherits="CicPortal.ProgramApprovals" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div>
        <div id="feedback" runat="server"></div>
        <%
            var nav = Config.ReturnNav(); 
            String userType = Convert.ToString(Session["UserType"]);
            userType = userType.ToLower();
            if (userType=="Data Officer")
            {
                var entries = nav.AccreditationApprovals.Where(r => r.universityCode == Convert.ToString(Session["UniversityCode"]) && r.status == "Open");
                Boolean openEntry = false;
                foreach (var entry in entries)
                {
                    openEntry = true;
                }
                if (openEntry)
                {
              %>
                <div class="alert alert-info">There is an open approval request. You cannot send another request</div>
              <%
                }
                else
                {
                    %>
        <div class="form-group">
        <asp:Button runat="server" CssClass="btn btn-success " Text="Send Accreditation Approval Request" ID="sendApproval" OnClick="sendApproval_Click"/>
        <div class="clearfix">
           
            </div>
        </div>
        <%
                }
        %>
                
        <%
            }
             %>
         <div class="panel panel-default">
             <div class="panel-heading">
                 Open Approval Requests
             </div>
             <div class="panel-body">
                <table class="table table-bordered table-striped" >
                    <thead>
                    <tr>
                        <th>Sender</th>
                        <th>Sent On</th>
                        <th>Approve</th>
                        <th>Reject</th>
                        <th>Cancel Approval Request</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% var openEntries = nav.AccreditationApprovals.Where(r => r.universityCode == Convert.ToString(Session["UniversityCode"]) && r.status == "Open");
               
                foreach (var entry in openEntries)
                {
                    %>
                        <tr>
                            <td><% = entry.SenderName %></td>
                            <td><% = entry.sentOn %></td>
                            <td>
                                <% if (Convert.ToString(Session["Code"]) == entry.approverId)
                                   {
                                       %>
                                <label class="btn btn-success" onclick="approveRequest('<%=entry.EntryId %>')">Approve Request</label>
                                <%
                                   } %>
                            </td>
                           <td>
                                <% if (Convert.ToString(Session["Code"]) == entry.approverId)
                                   {
                                       %>
                                <label class="btn btn-danger" onclick="rejectRequest('<%=entry.EntryId %>')">Reject Request</label>
                                <%
                                   } %>
                            </td>
                            <td>
                                <% if (Convert.ToString(Session["Code"]) == entry.senderId)
                                   {
                                       %>
                                <label class="btn btn-danger" onclick="cancelApprovalRequest('<%=entry.EntryId %>')">Cancel Approval Request</label>
                                <%
                                   } %>
                            </td>
                        </tr>
                        <%
                }
                         %>
                    </tbody>
                </table>
             </div>
         </div> 
          <div class="panel panel-default">
                 <div class="panel-heading">
                     Approval Requests
                 </div>
                 <div class="panel-body">
                    <table class="table table-bordered table-striped" id="dataTables-example">
                        <thead>
                        <tr>
                            <th>Sender</th>
                            <th>Sent On</th>
                             <th>Status</th>
                            <th>Approver</th>
                            <th>Action Date</th>
                            <th>Comment</th>
                        </tr>
                        </thead>
                         <tbody>
                    <% var approved = nav.AccreditationApprovals.Where(r => r.universityCode == Convert.ToString(Session["UniversityCode"]));
               
                foreach (var entry in approved)
                {
                    %>
                        <tr>
                            <td><% = entry.SenderName %></td>
                            <td><% = entry.sentOn %></td>
                            <td><% = entry.status %></td>
                            <td><% = entry.ApproverName %></td>
                            <td><% = entry.ActionDate %></td>
                            <td><% = entry.comment %></td>
                        </tr>
                        <%
                        }
                         %>
                    </tbody>
                    </table>
                 </div>
             </div> 
    
         </div>
     <script>
         $(document).ready(function() {
             $('#dataTables-example').DataTable({
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
<!-- needed by older browsers -->
<script src="https://github.com/eligrey/Blob.js"></script>

<!-- Required -->
<script src="https://rawgit.com/eligrey/FileSaver.js/src/FileSaver.js"></script>
<script src="https://unpkg.com/xlsx/dist/xlsx.full.min.js"></script>

<script>
    $(document).ready( function () {
        new ExcelUploader({
            maxInAGroup: 100,
            serverColumnNames: ["100"],
            importTypeSelector: "#dataType",
            fileChooserSelector: "#fileUploader",
            outputSelector: "#tableOutput",
            extraData: {_token: "23333323323223323232"}
        });
      //  loadData();
    });
</script>
  <script>
      function loadData() {
          $.ajax({
              url: "http://localhost:57742/api/values?userId=12&&userPassword=14",
              type: "GET",
              contentType: "application/json;charset=utf-8",
              data: JSON.stringify("user: data"),
              dataType: "json"
          })
      .done(function (response) {
          var table = $("#dataTables-example tbody");
          for (var i = 0; i < response.length; i++) {
              var obj = response[i];
        
              table.append("<tr><td>" +
                  obj.idNumber + "</td><td>" + obj.Surname + " " + obj.firstName + " " + obj.middleName + "</td><td>" + obj.gender + "</td><td>" + obj.dob + "</td><td>" + obj.myProgram + "</td><td>" + obj.yearOfStudy + "</td><td>" + obj.sponsorship + "</td> </tr>");
          }
          $('#dataTables-example').DataTable({
              responsive: true
          });
         // alerter("ERROR OCCURRED! ");
          /* $.each(data, function (idx, elem) {
        
            });*/
        
      })
      .fail(function (error) {
          alerter("ERROR OCCURRED! " + JSON.stringify(error) + "<br/>");
         
      });
      }
      function alerter(message) {
          if (window.swal) {
              swal("Alert!", message, "warning");
          } else {
              alert(message);
          }
      }
      //  
      function cancelApprovalRequest(entryId) {
          document.getElementById("MainContent_cancelApprovalEntryId").value = entryId;

          $("#cancelApprovalModal").modal();
      } function rejectRequest(entryId) {
          document.getElementById("MainContent_rejectApprovalEntryId").value = entryId;
          $("#rejectRequestModal").modal();
      } function approveRequest(entryId) {
          document.getElementById("MainContent_approveApprovalEntryId").value = entryId;
          $("#approveRequestModal").modal();
      }
  </script>
    <div id="cancelApprovalModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Cancel Approval Request</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you would like to cancel this approval request?</p>
          <asp:Textbox runat="server" ID="cancelApprovalEntryId" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
       <asp:Button runat="server" CssClass="btn btn-danger" ID="cancelApprovalRequest" Text="Cancel Approval Request" OnClick="cancelApprovalRequest_Click"/>
      </div>
    </div>

  </div>
</div>  
      <div id="rejectRequestModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Reject Request</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you would like to reject this approval request?</p>
          <div class="form-group">
              <strong>Comment:</strong>
               <asp:Textbox runat="server" ID="rejectComment" CssClass="form-control" TextMode="MultiLine"/>
          </div>
          <asp:Textbox runat="server" ID="rejectApprovalEntryId" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
       <asp:Button runat="server" CssClass="btn btn-danger" ID="rejectApprovalRequest" Text="Reject Request" OnClick="rejectApprovalRequest_Click"/>
      </div>
    </div>

  </div>
</div>
    <div id="approveRequestModal" class="modal fade" role="dialog">
      <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Confirm Approve Request</h4>
          </div>
          <div class="modal-body">
            <p>Are you sure you would like to approve this approval request?</p>
              <div class="form-group">
                  <strong>Comment:</strong>
                   <asp:Textbox runat="server" ID="approveComment" CssClass="form-control" TextMode="MultiLine"/>
              </div>
              <asp:Textbox runat="server" ID="approveApprovalEntryId" type="hidden"/>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
           <asp:Button runat="server" CssClass="btn btn-success" ID="approveApprovalRequest" Text="Approve Request" OnClick="approveApprovalRequest_Click"/>
          </div>
        </div>

      </div>
    </div>

</asp:Content>
