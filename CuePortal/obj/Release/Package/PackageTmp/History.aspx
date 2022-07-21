<%@ Page Title="" Language="C#" MasterPageFile="~/ChooseServiceMaster.Master" AutoEventWireup="true" CodeBehind="History.aspx.cs" Inherits="CicPortal.History" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
      <div class="panel panel-default">
     <div runat="server" id="feedback"></div>

        <div class="panel-heading">
            Brief History of the University
        </div>
        <div class="panel-body">
            <div class="form-group">
                <strong> Brief History of the University:</strong>
                <asp:textBox runat="server" CssClass="form-control" ID="txthistory"     placeholder=" Brief History of the University" TextMode="MultiLine"/>
            </div>           
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Save Changes" OnClick="SaveHistory_Click"/>
            <div class="clearfix"></div>
        </div>
    </div>
  <div class="panel panel-default">
            <div class="panel-heading">Added Land</div>
            <div class="panel-body">
                <table class="table table-bordered table-striped datatable">
                    <thead>
                    <tr>
                        <th>University Code</th>
                        <th>Brief History</th>
                        <th>Update</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        var nav = Config.ReturnNav();
                        var UniversityProfiles = nav.UniversityProfile.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                        string universityhistory = "";
                        foreach (var UniversityProfile in UniversityProfiles)
                        {
                            var universityhistories = new Config().ObjNav().FngetUniversitHistory(Convert.ToString(Session["UniversityCode"]));
                            universityhistory =  Regex.Replace(universityhistories, @"[^0-9a-zA-Z]+", " ");
                            %>
                        <tr>
                            <td><%=UniversityProfile.University_Code %></td>
                             <td><%=universityhistories %></td>
                            <td><label class="btn btn-success" onclick="editBriefHistory('<%=universityhistory%>')"><i class="fa fa-edit"></i> Edit</label></td>
                        </tr>
                        <%
                        }
                         %>
                    </tbody>
                </table>
            </div>
        </div>
    <script>
        function editBriefHistory(history) {
            document.getElementById("MainContent_edithistory").value = history;
            $("#editBriefHistoryModal").modal();
        }
    </script>

     <script>
         $(document).ready(function() {
             $('.datatable').DataTable({
                 responsive: true
             });
         });
     </script>
 <div id="editBriefHistoryModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Edit Brief History of the University Details</h4>
      </div>
      <div class="modal-body">
           <div class="form-group">
               <p>*Please enter the Brief History of the University</p>
            <strong>Brief History of the University:</strong>
             <asp:TextBox runat="server" CssClass="form-control" ID="edithistory" Placehoder="Brief History of the University" TextMode="MultiLine"/>
        </div>    
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Update Brief History" OnClick="UpdatebriefHistory_Click" />
      </div>
    </div>
  </div>
</div>
</asp:Content>
