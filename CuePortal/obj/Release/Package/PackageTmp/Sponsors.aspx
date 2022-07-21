<%@ Page Title="" Language="C#" MasterPageFile="~/ChooseServiceMaster.Master" AutoEventWireup="true" CodeBehind="Sponsors.aspx.cs" Inherits="CicPortal.Sponsors" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%@ Import Namespace="CicPortal" %>
       <div class="panel panel-default">
        <div class="panel-heading">
            Add Sponsor
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>
            <div class="form-group">
                <strong> Sponsor:</strong>
                <asp:textBox runat="server" CssClass="form-control" ID="txtsponsor" placeholder="Sponsor"  TextMode="MultiLine"/>
            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Add Sponsor" OnClick="SaveSponsor_Click"/>
            <div class="clearfix"></div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
            Sponsors
        </div>
        <div class="panel-body">
            <table class="table table-bordered table-striped datatable">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Sponsor Name</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
                </thead>
                <tbody>
                    <%
                        var nav = Config.ReturnNav();
                        var sponsors = nav.UniversitySponsors.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                        int count = 0;
                        foreach (var sponsor in sponsors)
                        {
                            count++;
                            %>
                        <tr>
                            <td><%=count %></td>
                            <td><%=sponsor.Sponsor_Name %></td>
                            <td><label class="btn btn-success" onclick="editSponsor('<%=sponsor.Sponsor_Name %>')"><i class="fa fa-edit"></i> Edit</label></td>
                            <td><label class="btn btn-danger" onclick="deleteSponsors('<%=sponsor.Code %>','<%=sponsor.Sponsor_Name %>')"><i class="fa fa-trash"></i> Delete</label></td>
                        </tr>
                        <%
                        }
                  %>
                    </tbody>
            </table>
        </div>
    </div>
 <script>
         $(document).ready(function() {
             $('.datatable').DataTable({
                 responsive: true
             });
         });
     </script>
 <script>
    //function deleteSponsors(id, name) {
    //    swal({
    //        title: "Are you sure you want to delete " + name + "?",
    //        text: "Once deleted, you will not be able to recover details of the student!",
    //        icon: "warning",
    //        buttons: true,
    //        dangerMode: true,
    //    }).then((willDelete) => {
    //        if (willDelete) {
    //            window.location.href = "/Sponsors.aspx?entry=" + id;
    //        } 
    //    });
    //}
     function deleteSponsors(id, name) {
         document.getElementById("sponsordetails").innerText = name;
         document.getElementById("MainContent_removesponsorCode").value = id;
         $("#deleteSponsorModal").modal();
    }
    function editSponsor(Name) {
        document.getElementById("MainContent_editName").value = Name;
        $("#ediSponsorModal").modal();
    }
   </script>
 <div id="deleteSponsorModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Deleting Sponsor</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the Sponsor <strong id="sponsordetails"></strong> ?</p>
          <asp:TextBox runat="server" ID="removesponsorCode" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Sponsor" OnClick="deleteSponsor_Click"/>
      </div>
    </div>

  </div>
</div>
  <div id="ediSponsorModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Edit University Sponsor Details</h4>
      </div>
      <div class="modal-body">
           <div class="form-group">
               <p>*Please Enter University Sponsor Name</p>
            <strong>Sponsor Name:</strong>
             <asp:TextBox runat="server" CssClass="form-control" ID="editName" Placehoder="Sponsor Name" TextMode="MultiLine"/>
        </div> 
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Update Sponsor" OnClick="EditSponsors"/>
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
<!-- needed by older browsers -->
<script src="https://github.com/eligrey/Blob.js"></script>

<!-- Required -->
<script src="https://rawgit.com/eligrey/FileSaver.js/src/FileSaver.js"></script>
<script src="https://unpkg.com/xlsx/dist/xlsx.full.min.js"></script>

</asp:Content>

