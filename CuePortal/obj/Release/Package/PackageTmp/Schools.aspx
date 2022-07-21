<%@ Page Title="" Language="C#" MasterPageFile="~/ChooseServiceMaster.Master" AutoEventWireup="true" CodeBehind="Schools.aspx.cs" Inherits="CicPortal.Schools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%@ Import Namespace="CicPortal" %>
     <div class="panel panel-default">
        <div class="panel-heading">
            Add School/Faculty or Institute
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>

            <div class="form-group">
                <strong>School/Faculty or Institute Name(<i>E.g School of, College of, Institute of)</i>:</strong>
                <asp:TextBox runat="server" CssClass="form-control" ID="txtschool" placeholder="School/Faculty or Institute" TextMode="MultiLine" />
            </div>

        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Add School/Faculty or Institute" OnClick="SaveSchool_Onclick" />
            <div class="clearfix"></div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
            School/Faculty or Institute
        </div>
        <div class="panel-body">
            <table class="table table-bordered table-striped datatable">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>School/Faculty or Institute Name</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = Config.ReturnNav();
                        var schools = nav.UniversitySchoolsFaculties.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                        int count = 0;
                        foreach (var school in schools)
                        {
                            count++;
                    %>
                    <tr>
                        <td><%=count %></td>
                        <td><%=school.School_Name %></td>
                        <td>
                            <label class="btn btn-success" onclick="editSchool('<%=school.School_Code %>', '<%=school.School_Name %>')"><i class="fa fa-edit"></i>Edit</label></td>
                        <td>
                            <label class="btn btn-danger" onclick="deleteSchools('<%=school.School_Code %>','<%=school.School_Name %>')"><i class="fa fa-trash"></i>Delete</label></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
    <script>
        $(document).ready(function () {
            $('.datatable').DataTable({
                responsive: true
            });
        });
    </script>
    <script>
        //function deleteSchools(id, name) {
        //       swal({
        //           title: "Are you sure you want to delete " + name + "?",
        //           text: "Once deleted, you will not be able to recover details of the student!",
        //           icon: "warning",
        //           buttons: true,
        //           dangerMode: true,
        //       }).then((willDelete) => {
        //           if (willDelete) {
        //               window.location.href = "/Schools.aspx?entry=" + id;
        //               /*swal("Poof! Your imaginary file has been deleted!", {
        //                   icon: "success",
        //               });*/
        //           } /*else {
        //               swal("Your imaginary file is safe!");
        //           }*/
        //       });
        //}
        function deleteSchools(id, name) {
            document.getElementById("schollname").innerText = name;
            document.getElementById("MainContent_removeschoolCode").value = id;
            $("#deleteSchoolsModal").modal();
        }
        function editSchool(id, School) {
            document.getElementById("MainContent_editschoolcode").value = id;
            document.getElementById("MainContent_editSchool").value = School;
            $("#editSchoolModal").modal();
        }
    </script>
    <div id="deleteSchoolsModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting School</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the School <strong id="schollname"></strong>?</p>
                    <asp:TextBox runat="server" ID="removeschoolCode" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete School" OnClick="deleteschool_Click" />
                </div>
            </div>
        </div>
    </div>
    <div id="editSchoolModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit School Details</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="editschoolcode" type="hidden" />
                    <div class="form-group">
                        <p>*Please enter the School Name</p>
                        <strong>School Name:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="editSchool" Placehoder="School Name" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Update School" OnClick="EditSchool_Click" />
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

