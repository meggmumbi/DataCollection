<%@ Page Title="" Language="C#" MasterPageFile="~/ChooseServiceMaster.Master" AutoEventWireup="true" CodeBehind="Departments.aspx.cs" Inherits="CicPortal.Departments" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%@ Import Namespace="CicPortal" %>

       <div class="panel panel-default">
        <div class="panel-heading">
            Add Department
        </div>
        <div class="panel-body">
        <div runat="server" id="feedback"></div>

            <div class="form-group">
                <strong> School/Faculty or Institute Name:</strong>
                <asp:DropDownList runat="server" ID="txtschool" CssClass="form-control"  />
            </div>
             <div class="form-group">
                <strong> Department Name:</strong>
                <asp:textBox runat="server" CssClass="form-control" ID="txtdepartment" placeholder="Department"  TextMode="MultiLine"/>
            </div>
           
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right"  Text="Add Department" OnClick="SaveDepartment_Click"/>
            <div class="clearfix"></div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
            Departments
        </div>
        <div class="panel-body">
            <table class="table table-bordered table-striped datatable">
                <thead>
                <tr>
                    <th>#</th>
                    <th>School/Faculty or Institute</th>
                    <th>Department</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
                </thead>
                 <tbody>
                    <%
                        var nav = Config.ReturnNav();
                        var departments = nav.UniversityDepartments.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                        int count = 0;
                        foreach (var department in departments)
                        {
                            count++;
                            %>
                        <tr>
                            <td><%=count %></td>
                            <td><%=department.School_Name %></td>
                            <td><%=department.Department_Name %></td>
                            <td><label class="btn btn-success" onclick="editDepartment('<%=department.Department_Code %>', '<%=department.Department_Name %>','<%=department.School_Name %>')"><i class="fa fa-edit"></i> Edit</label></td>
                            <td><label class="btn btn-danger" onclick="deleteDepartments('<%=department.Department_Code %>','<%=department.Department_Name %>')"><i class="fa fa-trash"></i> Delete</label></td>
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
         function deleteDepartments(id, name) {
             document.getElementById("departmentdetails").innerText = name;
             document.getElementById("MainContent_removedepartmentCode").value = id;
             $("#deleteDepartmentModal").modal();
         }
         function editDepartment(id, Department, School) {
             document.getElementById("MainContent_editdepartmentcode").value = id;
             document.getElementById("MainContent_editDepartment").value = Department;
             document.getElementById("MainContent_editSchool").value = School;
             $("#ediDepartmentModal").modal();
         }
         </script>
 <div id="deleteDepartmentModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Deleting Department</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the Department <strong id="departmentdetails"></strong> ?</p>
          <asp:TextBox runat="server" ID="removedepartmentCode" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Department" OnClick="deleteDepartment_Click"/>
      </div>
    </div>

  </div>
</div>
  <div id="ediDepartmentModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Edit Department Details</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="editdepartmentcode" type="hidden"/>
           <div class="form-group">
               <p>*Please enter the Department Name</p>
            <strong>Department Name:</strong>
             <asp:TextBox runat="server" CssClass="form-control" ID="editDepartment" Placehoder="Department Name"/>
        </div> 
            <div class="form-group">
               <p>*Please enter the School Name</p>
            <strong>School Name:</strong>
               <asp:DropDownList runat="server" ID="editSchool" CssClass="form-control"  />
        </div>   
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Update Department" OnClick="EditDepartment_Click" />
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
