<%@ Page Title="" Language="C#" MasterPageFile="~/DataCollectionMaster.Master" AutoEventWireup="true" CodeBehind="AccessRoads.aspx.cs" Inherits="CicPortal.AccessRoads" %>

<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <%
    var userType = Convert.ToString(Session["UserType"]);
    List<Int32> programLevelCount = new List<int>();
    List<String> programLevels = new List<String>();
    if (userType == "Data Officer")
     { %>
    <div>
        <div class="row" style="width: 100%; margin: 5px;">
            <div class="panel panel-default">
                <div class="panel-heading">Add Access Road</div>
                <div class="panel-body">
                    <div id="feedback" runat="server"></div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>*Please Select the Campus Name</p>
                            <div class="form-group">
                                <strong>Campus:</strong>
                                <asp:DropDownList runat="server" CssClass="form-control" ID="campus" />
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please Select the Road Surface Types</p>
                            <div class="form-group">
                                <strong>Surface Types:</strong>
                                <asp:DropDownList runat="server" CssClass="form-control" ID="roadstatus" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter the Access Road Description</p>
                            <div class="form-group">
                                <strong>Description:</strong>
                                <asp:TextBox runat="server" CssClass="form-control" ID="description" placeholder="Description" />
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter the Distance from the Main Road</p>
                            <div class="form-group">
                                <strong>Distance from Main Road:</strong>
                                <asp:TextBox runat="server" CssClass="form-control" ID="distance" Placeholder="Distance from Main Road" />
                            </div>
                        </div>
                    </div>

                </div>
                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Add Access Roads Details" OnClick="addAccessRoads_Click" />
                    <div class="clearfix"></div>
                </div>
            </div>
            <div class="panel panel-default">
                <p>*List of all the uploaded acces roads details</p>
                <div class="panel-heading">Added Access Roads</div>
                <div class="panel-body">
                    <table class="table table-bordered table-striped datatable">
                        <thead>
                            <tr>
                                <th>Campus</th>
                                <th>Surface Types</th>
                                <th>Description</th>
                                <th>Distance from Main Road</th>
                                <th>Edit</th>
                                <th>Delete</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                var nav = Config.ReturnNav();
                                var roads = nav.RoadsAccess.Where(r => r.UniversityCode == Convert.ToString(Session["UniversityCode"]));
                                foreach (var road in roads)
                                {
                            %>
                            <tr>
                                <td><%=road.Campus %></td>
                                <td><%=road.roadstatus %></td>
                                <td><%=road.description %></td>
                                <td><%=road.distance %></td>
                                <td>
                                    <label class="btn btn-success" onclick="editRoadAccess( '<%=road.Campus %>','<%=road.description %>','<%=road.roadstatus %>','<%=road.distance %>')"><i class="fa fa-edit"></i>Edit</label></td>
                                <td>
                                    <label class="btn btn-danger" onclick="deleteAccessRoads('<%=road.id %>','<%=road.Campus %>')"><i class="fa fa-trash"></i>Delete</label></td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>
    <script>
        $(document).ready(function () {
            $('.datatable').DataTable({
                responsive: true
            });
        });
    </script>
    <div id="deleteRoadAccessModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting Access Roads</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the Access Roads in <strong id="RoadToDelete"></strong>?</p>
                    <asp:TextBox runat="server" ID="removeroadaccessCode" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Access Roads" OnClick="deleteAccessRoads_Click" />
                </div>
            </div>

        </div>
    </div>

    <div id="editRoadModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit Road Access</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <p>*Please select the Campus Name</p>
                        <div class="form-group">
                            <strong>Campus:</strong>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="editcampus" />
                        </div>
                    </div>
                    <div class="form-group">
                        <p>*Please select the Status</p>
                        <div class="form-group">
                            <strong>Status:</strong>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="editStatus" />
                        </div>
                    </div>
                    <div class="form-group">
                        <p>*Please enter the Name/Description</p>
                        <div class="form-group">
                            <strong>Name/Description:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="editDescription" placeholder="Name/Description" />
                        </div>
                    </div>
                    <div class="form-group">
                        <p>*Please enter the Distance from the Main Road</p>
                        <div class="form-group">
                            <strong>Distance from The Main Road:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="editDistance" placeholder="Capacity" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Update Access Roads" OnClick="EditAccessRoads" />
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        function deleteAccessRoads(id, Campus) {
            document.getElementById("RoadToDelete").innerText = Campus;
            document.getElementById("MainContent_removeroadaccessCode").value = id;
            $("#deleteRoadAccessModal").modal();
        }
        function editRoadAccess(campusName, desciption, status, distance) {
            document.getElementById("MainContent_editcampus").value = campusName;
            document.getElementById("MainContent_editStatus").value = status;
            document.getElementById("MainContent_editDescription").value = desciption;
            document.getElementById("MainContent_editDistance").value = distance;
            $("#editRoadModal").modal();
        }
    </script>

  <%
    }
   else
   {
  var nav = Config.ReturnNav();
  %> 
<div class="row">
        <div class="col-lg-3 col-md-6">
            <div class="panel panel-green">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-xs-3">
                            <i class="fa fa-user fa-5x"></i>
                        </div>
                        <div class="col-xs-9 text-right">
                            <div class="huge">
                               <%-- <%

                                    int academicStaff = nav.University_Staff_Details.Where(r => r.Institution_Code == Convert.ToString(Session["UniversityCode"]) && r.Staff_Type == "Teaching").ToList().Count;
                                %>
                                <% =academicStaff %>--%>
                            </div>
                            <div>Total Academic Staff</div>
                        </div>
                    </div>
                </div>
                <a href="AcademicStaff.aspx">
                    <div class="panel-footer">
                        <span class="pull-left">View Details</span>
                        <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                        <div class="clearfix"></div>
                    </div>
                </a>
            </div>
        </div>
        <div class="col-lg-3 col-md-6">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-xs-3">
                            <i class="fa fa-book fa-5x"></i>
                        </div>
                        <div class="col-xs-9 text-right">
                            <div class="huge">
                                <%

                                    int campus1 = new Config().ObjNav().FnGetUniversityTotalUniversityCampuses(Convert.ToString(Session["UniversityCode"]));
                                %>
                                <% =campus1 %>
                            </div>
                            <div>Total Campuses</div>
                        </div>
                    </div>
                </div>
                <a href="AccreditedPrograms.aspx">
                    <div class="panel-footer">
                        <span class="pull-left">View Details</span>
                        <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                        <div class="clearfix"></div>
                    </div>
                </a>
            </div>
        </div>
        <div class="col-lg-3 col-md-6">
            <div class="panel panel-green">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-xs-3">
                            <i class="fa fa-user fa-5x"></i>
                        </div>
                        <div class="col-xs-9 text-right">
                            <div class="huge">
                                <%
                                    int programs1 = new Config().ObjNav().FnGetUniversityTotalUniversityProgrammes(Convert.ToString(Session["UniversityCode"]));
                                %>
                                <% =programs1 %>
                            </div>
                            <div>Total Programmes</div>
                        </div>
                    </div>
                </div>
                <a href="AcademicStaff.aspx">
                    <div class="panel-footer">
                        <span class="pull-left">View Details</span>
                        <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                        <div class="clearfix"></div>
                    </div>
                </a>
            </div>
        </div>
        <div class="col-lg-3 col-md-6">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-xs-3">
                            <i class="fa fa-book fa-5x"></i>
                        </div>
                        <div class="col-xs-9 text-right">
                            <div class="huge">
                                <%--<%
                                    int disability = nav.University_Staff_Details.Where(r => r.Institution_Code == Convert.ToString(Session["UniversityCode"])).ToList().Count;
                                %>
                                <% =disability %>--%>
                            </div>
                            <div>PWD Staff</div>
                        </div>
                    </div>
                </div>
                <a href="AccreditedPrograms.aspx">
                    <div class="panel-footer">
                        <span class="pull-left">View Details</span>
                        <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                        <div class="clearfix"></div>
                    </div>
                </a>
            </div>
        </div>
    </div>
  <div class="panel panel-default">
                <p>*List of all the uploaded acces roads details</p>
                <div class="panel-heading">Added Access Roads</div>
                <div class="panel-body">
                    <table class="table table-bordered table-striped dataTables">
                        <thead>
                            <tr>
                                <th>Campus</th>
                                <th>Status</th>
                                <th>Description</th>
                                <th>Distance from Main Road</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                var nav1 = Config.ReturnNav();
                                var roads = nav.RoadsAccess.Where(r => r.UniversityCode == Convert.ToString(Session["UniversityCode"]));
                                foreach (var road in roads)
                                {
                            %>
                            <tr>
                                <td><%=road.Campus %></td>
                                <td><%=road.roadstatus %></td>
                                <td><%=road.description %></td>
                                <td><%=road.distance %></td>
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
            $('.dataTables').DataTable({
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
    <script src="https://github.com/eligrey/Blob.js"></script>
    <script src="https://rawgit.com/eligrey/FileSaver.js/src/FileSaver.js"></script>
    <script src="https://unpkg.com/xlsx/dist/xlsx.full.min.js"></script>
 <%} %>
</asp:Content>
