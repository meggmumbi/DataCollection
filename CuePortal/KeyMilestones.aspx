<%@ Page Title="" Language="C#" MasterPageFile="~/ChooseServiceMaster.Master" AutoEventWireup="true" CodeBehind="KeyMilestones.aspx.cs" Inherits="CicPortal.KeyMilestones" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%@ Import Namespace="CicPortal" %>
    <div class="panel panel-default">
        <div class="panel-heading">
            Add Key Milestones
        </div>
        <div class="panel-body">
             <div runat="server" id="feedback"></div>
            <div class="form-group">
                <strong> Year:</strong>
                <asp:textBox runat="server" CssClass="form-control" ID="txtyear"  placeholder="Year"/>
            </div> 
            <div class="form-group">
                <strong> Milestone:</strong>
                <asp:textBox runat="server" CssClass="form-control"  ID="txtmilestone" placeholder="Milestone" TextMode="MultiLine"/>
            </div>
           
        </div>
       <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Add Milestone" OnClick="SaveMilestone_Click"/>
            <div class="clearfix"></div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
            Key Milestones
        </div>
        <div class="panel-body">
           <table class="table table-bordered table-striped datatable ">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Year</th>
                    <th>Milestone</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
                </thead>
               <tbody>
                    <%
                        var nav = Config.ReturnNav();
                        var milestones = nav.UniversityMilestones.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                        string keymilestone = "";
                        int milstoneid = 0;
                        int milestoneCounter = 0;
                        foreach (var milestone in milestones)
                        {
                            milestoneCounter++;
                            milstoneid = milestone.Code;
                            var keymilestones = new Config().ObjNav().FngetUniversitKeyMilestone(Convert.ToString(Session["UniversityCode"]),milstoneid);
                            keymilestone =  Regex.Replace(keymilestones, @"[^0-9a-zA-Z]+", " ");
                            %>
                        <tr>
                            <td><%=milestoneCounter %></td>
                            <td><%=milestone.Milestone_Year %></td>
                            <td><%=keymilestones %></td>
                            <td><label class="btn btn-success" onclick="editMilestone('<%=milestone.Code %>','<%=milestone.Milestone_Year %>', '<%=keymilestone %>')"><i class="fa fa-edit"></i> Edit</label></td>
                            <td><label class="btn btn-danger" onclick="deleteMilestone('<%=milestone.Code %>','<%=milestone.Milestone_Year%>')"><i class="fa fa-trash"></i> Delete</label></td>
                        </tr>
                        <%
                                milstoneid++;
                            }
                         %>
                    </tbody>
            </table>
        </div>
         <script>
         $(document).ready(function() {
             $('.datatable').DataTable({
                 responsive: true
             });
         });
     </script>
    </div>
      <script>
       
          function deleteMilestone(id, name) {
              document.getElementById("milestonename").innerText = name;
              document.getElementById("MainContent_removekeymilestoneCode").value = id;
              $("#deleteKeyMilestoneModal").modal();
          }
           function editMilestone(id,year,name) {
               document.getElementById("MainContent_editcode").value = id;
               document.getElementById("MainContent_editYear").value = year;
               document.getElementById("MainContent_editName").value = name;
               $("#editMilestoneModal").modal();
         }
         </script>
 <script>
         $(function () {
             $("#txtyear").datepicker({ dateFormat: 'yy' });
         });
     </script>
    <div id="deleteKeyMilestoneModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Deleting Key Milestone</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the Key Milestone <strong id="milestonename"></strong> ?</p>
          <asp:TextBox runat="server" ID="removekeymilestoneCode" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Milestone" OnClick="deleteKeyMilestone_Click"/>
      </div>
    </div>

  </div>
</div>
  <div id="editMilestoneModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Edit Milestones Details</h4>
      </div>
      <div class="modal-body">
           <asp:TextBox runat="server" ID="editcode" type="hidden"/>
           <div class="form-group">
               <p>*Please enter the Year</p>
            <strong>Milestone Year:</strong>
             <asp:TextBox runat="server" CssClass="form-control" ID="editYear" Placehoder="Year"/>
        </div>  
           <div class="form-group">
               <p>*Please enter the Description</p>
            <strong>Description Details:</strong>
             <asp:TextBox runat="server" CssClass="form-control" ID="editName" Placehoder="Description" TextMode="MultiLine"/>
        </div>      
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Update Milestone" OnClick="EditKeyMilstones" />
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

