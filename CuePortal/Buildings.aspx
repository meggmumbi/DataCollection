<%@ Page Title="" Language="C#" MasterPageFile="~/DataCollectionMaster.Master" AutoEventWireup="true" CodeBehind="Buildings.aspx.cs" Inherits="CicPortal.Buildings" %>
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
            <div class="panel-heading">Add Buildings</div>
            <div class="panel-body">
                <div id="feedback" runat="server"></div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please select the campus name</p>
                        <div class="form-group">
                            <strong>Campus:</strong>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="campus"/>
                        </div>
                    </div>  
                     <div class="col-md-6 col-lg-6">
                         <p>*Please select the Building Category</p>
                        <div class="form-group">                            
                            <strong>Building Category:</strong>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="category" OnSelectedIndexChanged="facilities_SelectedIndexChanged" AutoPostBack="true"/>
                        </div>
                    </div>
                </div> 
                  <div class="row">
                       <div class="col-md-6 col-lg-6">
                         <p>*Please select the Building Sub-Category</p>
                        <div class="form-group">
                            <strong>Building Sub-Category:</strong>
                           <asp:DropDownList runat="server" CssClass="form-control" ID="buildingsubcategories"/>
                        </div>
                    </div> 
                    <div class="col-md-6 col-lg-6">
                        <p>*Please enter the building name/Descrption</p>
                        <div class="form-group">
                            <strong>Name/Description:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="name" placeholder="Name/Description"/>
                        </div>
                    </div>  
                </div>  
                <div class="row">
                     <div class="col-md-6 col-lg-6">
                         <p>*Please enter the building Capacity</p>
                        <div class="form-group">
                            <strong>Building Capacity:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="capacity" Placeholder ="Capacity"  TextMode="Number"/>
                        </div>
                    </div>
                     <div class="col-md-6 col-lg-6">
                         <p>*Please enter the building number of Floors</p>
                        <div class="form-group">
                            <strong>Number of Floors:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="noOfFloors" Placeholder ="Number of Floors"  TextMode="Number"  AutoCompleteType="Disabled" min="0"/>
                        </div>
                    </div>                    
                </div> 
                <div class="row">
                     <div class="col-md-6 col-lg-6">
                        <p>*Please enter the building Size in Square Meters</p>
                        <div class="form-group">
                            <strong>Size (sq Mtrs):</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="size" Placeholder ="Size(sq Mtrs)" TextMode="Number" />
                        </div>
                    </div>
                     <div class="col-md-6 col-lg-6">
                         <p>*Please enter the building location/Block</p>
                        <div class="form-group">
                            <strong>Block/Location:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="block" placeholder="Block/Location" />
                        </div>
                    </div>   
                </div>
                  <div class="row">
                     <div class="col-md-6 col-lg-6">
                         <p>*Please enter the No. of Rooms for the Building</p>
                        <div class="form-group">
                            <strong>No. of Rooms:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="noofrooms" placeholder="No. of Rooms for the Building" TextMode="Number" />
                        </div>
                    </div> 
                   <div class="col-md-6 col-lg-6">
                        <p>*Please check if the building has provision for persons with Disabilities</p>
                        <div class="form-group">
                            <strong>Provision for Persons with Disabilities(P.W.D):</strong>
                            <asp:CheckBox runat="server" CssClass="form-control" ID="provisionForPWD"/>
                        </div>
                    </div> 
                </div>
            </div>
            <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Add Building" ID="addBuilding" OnClick="addBuilding_Click"/>
                <div class="clearfix"></div>
            </div>
        </div>

       <%-- Pop Up Dialog--%>
        <div class="panel panel-default">
            <p>*List of all uploaded building details</p>
            <div class="panel-heading">Added Buildings</div>
            <div class="panel-body">
               <table class="table table-bordered table-striped datatable" id="dataTables-example">
                    <thead>
                    <tr>
                        <th>Campus</th>
                        <th>Category</th>
                        <th>Name/Description</th>
                        <th>Capacity</th>
                        <th>Size (sq Mtrs)</th>
                        <th>Provision for P.W.D.</th>
                        <th>No. Of Rooms</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        var universityCode = Session["UniversityCode"];
                        var nav = Config.ReturnNav();
                        var buildings = nav.Buildings.Where(r =>r.university ==Convert.ToString( Session["UniversityCode"]));
                        foreach (var building in buildings)
                        {
                            %>
                        <tr>
                            <td><%= building.CampusName %></td>
                            <td><%= building.buildingtype %></td>
                            <td><%= building.description %></td>
                            <td><%= building.capacity %></td>
                            <td><%= building.size_sq_mtrs %></td>
                            <td><%= Convert.ToBoolean(building.provision_for_PWD)?"Yes":"No" %></td>
                            <td><%= building.No_of_Rooms %></td>
                            <td><label class="btn btn-success" onclick="editBuilding('<%=building.id %>','<%=building.CampusName %>', '<%=building.buildingtype  %>', '<%=building.description %>', '<%=building.capacity %>', '<%=building.location %>','<%=building.size_sq_mtrs %>','<%=building.No_of_Rooms %>')"><i class="fa fa-edit"></i> Edit</label></td>
                            <td><label class="btn btn-danger" onclick="deleteBuilding('<%=building.id %>','<%=building.CampusName %>')"><i class="fa fa-trash"></i> Delete</label></td>
                        </tr>
                                <%
                        }
                         %>
                    </tbody>
                </table>
            </div>
        </div>

 </div>
  <div id="deleteBuildingModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Deleting Building</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the Building in <strong id="BuildingToDelete"></strong>?</p>
          <asp:TextBox runat="server" ID="removeBuildingCode" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
         <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Building" OnClick="deleteBuilding_Click"/>
      </div>
    </div>

  </div>
</div>

 <div id="editBuildingModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Edit Building</h4>
      </div>

      <div class="modal-body">
           <asp:TextBox runat="server" ID="editBuilding" type="hidden"/>
           <div class="form-group">
               <p>*Please select the campus Name</p>
            <strong>Campus Name:</strong>
            <asp:DropDownList runat="server" CssClass="form-control" ID="editCampusName"/>
        </div> 
          <div class="form-group">
              <p>*Please select the Building Category</p>
            <strong>Building Category:</strong>
            <asp:DropDownList runat="server" CssClass="form-control " ID="editBuildingtype"/>
        </div>  
          <div class="form-group">
              <p>*Please enter the Building Description</p>
            <strong>Building Descrption:</strong>
            <asp:TextBox runat="server" CssClass="form-control" ID="editDescription" Placehoder="Description"/>
        </div>  
          <div class="form-group">
              <p>*Please enter the building Capacity</p>
            <strong>Building Capacity</strong>
            <asp:TextBox runat="server" CssClass="form-control" ID="editCapacity"/>
        </div> 
           
           <div class="form-group">
              <p>*Please enter the Building Location</p>
            <strong>Building Location:</strong>
            <asp:TextBox runat="server" CssClass="form-control" ID="editLocation"/>
        </div> 
           <div class="form-group">
              <p>*Please enter the Building Size</p>
            <strong>Building Size:</strong>
            <asp:TextBox runat="server" CssClass="form-control" ID="editSize"/>
        </div> 
           <div class="form-group">
              <p>*Please enter the No. of Rooms</p>
            <strong>No. of Rooms:</strong>
            <asp:TextBox runat="server" CssClass="form-control" ID="editrooms"/>
        </div> 
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Update Building" ID="Button1" OnClick="editBuilding_Click"/>
                <div class="clearfix"></div>
            </div>
      </div>
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
    <script>
    function edit() {
          $('#form-input').modal('show');
      }
  </script>
     <script>
         function deleteBuilding(id, campusName) {
            document.getElementById("BuildingToDelete").innerText = campusName;
            document.getElementById("MainContent_removeBuildingCode").value = id;
            $("#deleteBuildingModal").modal();
        }
         function editBuilding(buildingcode, campusName, buildingtype, description, capacity, location, size,rooms) {
             document.getElementById("MainContent_editBuilding").value = buildingcode;
             document.getElementById("MainContent_editCampusName").value = campusName;
             document.getElementById("MainContent_editBuildingtype").value = buildingtype;
             document.getElementById("MainContent_editDescription").value = description;
            document.getElementById("MainContent_editCapacity").value = capacity;
            document.getElementById("MainContent_editLocation").value = location; 
            document.getElementById("MainContent_editSize").value = size;
            document.getElementById("MainContent_editrooms").value = rooms;
            $("#editBuildingModal").modal();
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
                              <%--  <%

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
            <p>*List of all uploaded building details</p>
            <div class="panel-heading">Added Buildings</div>
            <div class="panel-body">
               <table class="table table-bordered table-striped datatable dataTables">
                    <thead>
                    <tr>
                        <th>Campus</th>
                        <th>Category</th>
                        <th>Name/Description</th>
                        <th>Capacity</th>
                        <th>Size (sq Mtrs)</th>
                        <th>Provision for P.W.D.</th>             
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        var universityCode = Session["UniversityCode"];
                        var nav1 = Config.ReturnNav();
                        var buildings = nav.Buildings.Where(r =>r.university ==Convert.ToString( Session["UniversityCode"]));
                        foreach (var building in buildings)
                        {
                            %>
                        <tr>
                            <td><%= building.CampusName %></td>
                            <td><%= building.buildingtype %></td>
                            <td><%= building.description %></td>
                            <td><%= building.capacity %></td>
                            <td><%= building.size_sq_mtrs %></td>
                            <td><%= Convert.ToBoolean(building.provision_for_PWD)?"Yes":"No" %></td>
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
 <%
        } %>
</asp:Content>
