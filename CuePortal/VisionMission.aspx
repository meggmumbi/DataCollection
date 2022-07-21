<%@ Page Title="" Language="C#" MasterPageFile="~/ChooseServiceMaster.Master" AutoEventWireup="true" CodeBehind="VisionMission.aspx.cs" Inherits="CicPortal.VisionMission" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="panel panel-default">
   <div runat="server" id="feedback"></div>

        <div class="panel-heading">
            Vision, Mission and Objectives
        </div>
        <div class="panel-body">
            <div class="form-group">
                <strong>Vision:</strong>
                <asp:textBox runat="server" CssClass="form-control" ID="txtvission" placeholder="Vision" TextMode="MultiLine"/>
            </div>
            <div class="form-group">
                <strong>Mission:</strong>
                <asp:textBox runat="server" CssClass="form-control" ID="txtmission" placeholder="Mission" TextMode="MultiLine"/>
            </div>
            <div class="form-group">
                <strong>Objectives:</strong>
                <asp:textBox runat="server" CssClass="form-control" ID="txtaims" placeholder="Objectives" TextMode="MultiLine"/>
            </div>
        </div>
         <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Save Changes" OnClick="SaveMission_Click"/>
                <div class="clearfix"></div>
            </div>
    </div>
      <div class="panel panel-default">
            <div class="panel-heading">Submitted University Mission and Vision</div>
            <div class="panel-body">
                <table class="table table-bordered table-striped datatable">
                    <thead>
                    <tr>
                        <th>University Code</th>
                        <th>Vission</th>
                        <th>Mission</th>
                        <th>Objectives</th>
                        <th>Update</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        var nav = Config.ReturnNav();
                        var UniversityProfiles = nav.UniversityProfile.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                        string universitymission = "";
                        string universityvission = "";
                        string universityaim = "";
                        foreach (var UniversityProfile in UniversityProfiles)
                        {
                            var universitymissions = new Config().ObjNav().FngetUniversityMission(Convert.ToString(Session["UniversityCode"]));
                            universitymission =  Regex.Replace(universitymissions, @"[^0-9a-zA-Z]+", " ");
                            var universityvissions = new Config().ObjNav().FngetUniversityVission(Convert.ToString(Session["UniversityCode"]));
                            universityvission =  Regex.Replace(universityvissions, @"[^0-9a-zA-Z]+", " ");
                            var universityaims = new Config().ObjNav().FngetUniversityAim(Convert.ToString(Session["UniversityCode"]));
                            universityaim =  Regex.Replace(universityaims, @"[^0-9a-zA-Z]+", " ");
                            %>
                        <tr>
                            <td><%=UniversityProfile.University_Code %></td>
                            <td><%=universityvissions %></td>
                            <td><%=universitymissions %></td>
                            <td><%=universityaims %></td>
                            <td><label class="btn btn-success" onclick="editVissionMission('<%=universityvission %>','<%=universitymission %>','<%=universityaim %>')"><i class="fa fa-edit"></i> Edit</label></td>
                        </tr>
                        <%
                        }
                         %>
                    </tbody>
                </table>
            </div>
        </div>
  <script>
        function editVissionMission(vission,mission,aims) {
            document.getElementById("MainContent_editvission").value = vission;
            document.getElementById("MainContent_editmission").value = mission;
            document.getElementById("MainContent_editaims").value = aims;

            $("#editMissionModal").modal();
        }
    </script>
<div id="editMissionModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Edit Mission & Vission</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="editLandCode" type="hidden"/>
           <div class="form-group">
             <strong>Vision:</strong>
                <asp:textBox runat="server" CssClass="form-control" ID="editvission" placeholder="Vision" TextMode="MultiLine"/>
        </div> 
          <div class="form-group">
             <strong>Mission:</strong>
                <asp:textBox runat="server" CssClass="form-control" ID="editmission" placeholder="Vision" TextMode="MultiLine"/>
        </div> 
          <div class="form-group">
              <strong>Objectives:</strong>
               <asp:textBox runat="server" CssClass="form-control" ID="editaims" placeholder="Objectives" TextMode="MultiLine"/>
        </div>
      </div>
      <div class="modal-footer">
           <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Update Changes" OnClick="UpdateVissionMission_Click" />
                <div class="clearfix"></div>
      </div>
    </div>
  </div>
</div>
  <script>
         $(document).ready(function() {
             $('.datatable').DataTable({
                 responsive: true
             });
         });
     </script>
</asp:Content>
