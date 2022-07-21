<%@ Page Title="" Language="C#" MasterPageFile="~/ChooseServiceMaster.Master" AutoEventWireup="true" CodeBehind="UniversityNiche.aspx.cs" Inherits="CicPortal.UniversityNiche" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="panel panel-default">
        <div class="panel-heading">
            Philosophical Basis/Niche of the University
        </div>
        <div class="panel-body">
               <div runat="server" id="feedback"></div>

            <div class="form-group">
                <strong>  Philosophical Basis/Niche of the University:</strong>
                <asp:textBox runat="server" CssClass="form-control" ID="universityniche" placeholder="Philosophical Basis/Niche of the University" TextMode="MultiLine"/>
            </div>
           
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Save Changes" OnClick="SavePhilosophy_Click"/>
            <div class="clearfix"></div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
       Philosophical Basis/Niche of the University
        </div>
        <div class="panel-body">
            <table class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Niche of the University</th>
                    <th>Edit</th>
                </tr>
                </thead>
                   <tbody>
                    <%
                        var nav = Config.ReturnNav();
                        var UniversityProfiles = nav.UniversityProfile.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                        int count = 0;
                        string phylosophydetail = "";
                        foreach (var UniversityProfile  in UniversityProfiles)
                        {
                            count ++;
                            var phylosophydetails = new Config().ObjNav().FngetUniversitPhylosophy(Convert.ToString(Session["UniversityCode"]));
                            phylosophydetail =  Regex.Replace(phylosophydetails, @"[^0-9a-zA-Z]+", " ");
                            %>
                        <tr>
                            <td><%=count %></td>
                            <td><%=phylosophydetails %></td>
                            <td><label class="btn btn-success" onclick="editNiche('<%=phylosophydetail%>')"><i class="fa fa-edit"></i> Edit</label></td>
                        </tr>
                        <%
                        }
                         %>
                    </tbody>
            </table>
        </div>
    </div>
    <script type="text/javascript">
        function editNiche(niche) {
            document.getElementById("MainContent_editnichedetails").value = niche;
                 $("#editUniversityNicheModal").modal();
             }
         </script>
  <div id="editUniversityNicheModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Update Philosophical Basis/Niche of the University</h4>
      </div>
      <div class="modal-body">
           <div class="form-group">
               <p>*Please Enter the University Niche</p>
            <strong>Philosophical Basis/Niche of the University:</strong>
             <asp:TextBox runat="server" CssClass="form-control" ID="editnichedetails" Placehoder="Philosophical Basis/Niche of the University" TextMode="MultiLine"/>
        </div> 
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Update University Niche" OnClick="EditUniversityNiche_Click"/>
      </div>
    </div>
  </div>
</div>
</asp:Content>
