<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/ChooseServiceMaster.Master" CodeBehind="UniversityViceChancellor.aspx.cs" Inherits="CicPortal.UniversityViceChancellor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<%@ Import Namespace="CicPortal" %>
     <div class="panel panel-default">
        <div class="panel-heading">
            Add University Vice Chancellor(<i>Please fill in at least Four University Vice Chancellors Details</i>)
        </div>
        <div class="panel-body">
             <div runat="server" id="feedback"></div>
            <div class="form-group">
                <strong>Vice  Chancellor Name:</strong>
                <asp:textBox runat="server" CssClass="form-control" ID="txtchancellorname" placeholder="Vice Chancellor Name" />
            </div>
            <div class="form-group">
                <strong> Highest Academic Qualification:</strong>
                <asp:DropDownList runat="server" CssClass="form-control"  ID="txtqualifications" />
            </div>
            <div class="form-group">
                <strong> Date of First Appointment:</strong>
               <asp:TextBox runat="server" CssClass="form-control bootstrapdatepicker" placeholder="Date of Appointment" ID="txtdateofappointment" /> 
            </div>
            <div class="form-group">
                <strong>Years Served:</strong>
                <asp:TextBox runat="server" CssClass="form-control" ID="yearsserved" placeholder="Years Served"  TextMode="Number" />
            </div>
           <div class="form-group">
                <strong> Nationality:</strong>
                <asp:DropDownList runat="server" CssClass="form-control" ID="txtnationality" />
            </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Add Vice Chancellor" OnClick="AddChancellor_Onclick"/>
            <div class="clearfix"></div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
            University Vice Chancellors
        </div>
        <div class="panel-body">
            <table class="table table-bordered table-striped datatable">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Name of Vice Chancellor</th>
                    <th>Highest Academic Qualification</th>
                    <th>Date of Appointment</th>
                    <th>Nationality</th>
                     <th>Years Served</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
                </thead>
               <tbody>
                    <%
                        var nav = Config.ReturnNav();
                        var chancellors = nav.UniversityChancellors.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"])&&r.Category=="Vice Chancellor");
                        int count = 0;
                        foreach (var chancellor in chancellors)
                        {
                            count++;
                            %>
                        <tr>
                            <td><%=count %></td>
                            <td><%=chancellor.Name %></td>
                            <td><%=chancellor.Highest_Academic_Qualification %></td>
                            <td><%=chancellor.Date_of_Appointment%></td>
                            <td><%=chancellor.Nationality_Name %></td>
                           <td><%=chancellor.Years_Served %></td>
                              <td><label class="btn btn-success" onclick="editChancellor('<%=chancellor.Name %>', '<%=chancellor.Date_of_Appointment %>', '<%=chancellor.Nationality %>','<%=chancellor.Years_Served %>')"><i class="fa fa-edit"></i> Edit</label></td>
                            <td><label class="btn btn-danger" onclick="deleteChancellors('<%=chancellor.Code %>','<%=chancellor.Name %>')"><i class="fa fa-trash"></i> Delete</label></td>
                        </tr>
                        <%
                        }
                         %>
                    </tbody>
                </table>
            </div>
        </div>
    <%--</div>--%>
     <script>
         $(document).ready(function() {
             $('.datatable').DataTable({
                 responsive: true
             });
         });
     </script>
    <script>
        function deleteChancellors(id, name) {
            document.getElementById("ChancellorToDelete").innerText = name;
            document.getElementById("MainContent_removechancellornamescode").value = id;
            $("#deleteChnacellorModal").modal();
        }
        function editChancellor(Name, Date, Nationality,years) {
            document.getElementById("MainContent_editName").value = Name;
            document.getElementById("MainContent_editDate").value = Date;
            document.getElementById("MainContent_editNationality").value = Nationality;
            document.getElementById("MainContent_edityearsserved").value = years;
            $("#editChnacellorModal").modal();
        }
    </script>
 <div id="deleteChnacellorModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Deleting Vice Chancellor</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the Vice Chancellor <strong id="ChancellorToDelete"></strong> ?</p>
          <asp:TextBox runat="server" ID="removechancellornamescode" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Vice Chancellor"  OnClick="deleteChancellor_Onclick"/>
      </div>
    </div>
  </div>
</div>
    <div id="editChnacellorModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Edit Vice Chancellor Details</h4>
      </div>
      <div class="modal-body">
           <div class="form-group">
               <p>*Please select the Vice Chancellor Name</p>
            <strong>Vice Chancellor Name:</strong>
             <asp:TextBox runat="server" CssClass="form-control" ID="editName" Placehoder="Chancellor Name"/>
        </div> 
           <div class="form-group">
              <p>*Please select the Highest Academic Qualifications</p>
            <strong>Highest Academic Qualifications:</strong>
            <asp:DropDownList runat="server" CssClass="form-control " ID="editqualifications"/>
        </div> 
          <div class="form-group">
               <p>*Please select the Date of Appointment</p>
            <strong>Date of Appointment:</strong>
              <asp:TextBox runat="server" CssClass="form-control bootstrapdatepicker" placeholder="Date of Current Appointment" ID="editDate" />
        </div> 
          <div class="form-group">
              <p>*Please select the Nationality</p>
            <strong>Nationality:</strong>
            <asp:DropDownList runat="server" CssClass="form-control " ID="editNationality"/>
        </div>    
          <div class="form-group">
              <p>*Please enter the Years Served</p>
            <strong>Years Served:</strong>
             <asp:TextBox runat="server" CssClass="form-control" ID="edityearsserved" Placehoder="Years Served "/>
        </div>  
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Update Vice Chancellor" OnClick="EditChancellor_Onclick"/>
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
