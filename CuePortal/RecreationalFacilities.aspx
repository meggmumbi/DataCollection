<%@ Page Title="" Language="C#" MasterPageFile="~/DataCollectionMaster.Master" AutoEventWireup="true" CodeBehind="RecreationalFacilities.aspx.cs" Inherits="CicPortal.RecreationalFacilities" %>
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
            <div class="panel-heading">Add Recreational Facility</div>
            <div class="panel-body">
                <div id="feedback" runat="server"></div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please select the Campus Name</p>
                        <div class="form-group">
                            <strong>Campus:</strong>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="campus"/>
                        </div>
                    </div>  
                    <div class="col-md-6 col-lg-6">
                        <p>*Please enter the ownership status of the Facility</p>
                        <div class="form-group">
                            <strong>Facility Ownership:</strong>
                           <asp:DropDownList runat="server" CssClass="form-control" ID="ownership" />
                        </div>
                    </div>
                </div> 
                  <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please enter the facility location</p>
                        <div class="form-group">
                            <strong>Location:</strong>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="location"/>
                        </div>
                    </div>  
                     <div class="col-md-6 col-lg-6">
                         <p>*Please enter the Number/Quality of the facility</p>
                        <div class="form-group">
                            <strong>Number/Quantity:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="quantity" Placeholder ="Number/Quantity"  TextMode="Number" min="0"/>
                        </div>
                    </div>
                </div>
                <div class="row">                    
                     <div class="col-md-6 col-lg-6">
                         <p>*Please Select the Facilty type</p>
                        <div class="form-group">
                            <strong>Type of Facility:</strong>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="typeOfFacility" OnSelectedIndexChanged="facilities_SelectedIndexChanged" AutoPostBack="True"/>
                        </div>
                    </div>
                     <div class="col-md-6 col-lg-6">
                         <p>*Please select facility sub-category</p>
                        <div class="form-group">
                            <strong>Facility Sub-Category:</strong>
                             <asp:DropDownList runat="server" CssClass="form-control" ID="subcategories" />
                        </div>
                    </div>
                </div>                
            </div>
            <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Add Recreational Facility Details" OnClick="addRecreation_Click"/>
                <div class="clearfix"></div>
            </div>
        </div>
        <div class="panel panel-default">
            <p>*List of all uploaded Recreational Facility details</p>
            <div class="panel-heading">Added Recreational Facilities</div>
            <div class="panel-body">
                <table class="table table-bordered table-striped datatables">
                    <thead>
                    <tr>
                        <th>Campus</th>
                        <th>Type of Facility</th>
                        <th>Location</th>
                        <th>Number/Quantity</th>
                        <th>Ownership</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                    </thead>
                      <tbody>
                    <%
                        var nav = Config.ReturnNav();
                        var recreational = nav.RecreationalFacilites.Where(r => r.UniversityCode == Convert.ToString(Session["UniversityCode"]));
                        foreach (var recreation in recreational)
                        {
                            %>
                        <tr>
                            <td><%=recreation.Campus %></td>
                            <td><%=recreation.facility_type %></td>
                            <td><%=recreation.location %></td>
                            <td><%=recreation.quantity %></td>
                            <td><%=recreation.ownership %></td>
                            <td><label class="btn btn-success" onclick="editRecreational('<%=recreation.Campus %>','<%=recreation.facility_type %>','<%=recreation.location %>','<%=recreation.quantity %>','<%=recreation.ownership %>')"><i class="fa fa-edit"></i> Edit</label></td>
                            <td><label class="btn btn-danger" onclick="deleteRecreation('<%=recreation.id %>','<%=recreation.Campus %>')"><i class="fa fa-trash"></i> Delete</label></td>
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
    <div id="deleteRecreationModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Deleting Recreation Facility</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the Recerational Facility in <strong id="FacilityToDelete"></strong>?</p>
          <asp:TextBox runat="server" ID="removeRecerationCode" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
         <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Receration" OnClick="deleteRecreation_Click"/>
      </div>
    </div>

  </div>
</div>

 <div id="editRecreationModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Edit Waste Managment</h4>
      </div>
      <div class="modal-body">
           <div class="form-group">
               <p>*Please select the campus Name</p>
            <strong>Campus Name:</strong>
            <asp:DropDownList runat="server" CssClass="form-control" ID="editCampusName"/>
        </div> 
          <div class="form-group">
              <p>*Please select the Type of Facility:</p>
            <div class="form-group">
                <strong>Type of Facility:</strong>
               <asp:DropDownList runat="server" CssClass="form-control " ID="editType"/>
            </div>
           
        </div>  
         <div class="form-group">
              <p>*Please select the Location</p>
            <div class="form-group">
                <strong>Location</strong>
               <asp:DropDownList runat="server" CssClass="form-control " ID="editLocation"/>
            </div> 
             </div>
          <div class="form-group">
             <p>*Please enter Quantity</p>
            <div class="form-group">
                <strong>Quantity:</strong>
                <asp:TextBox runat="server" CssClass="form-control" ID="editQunatity" Placeholder ="Quantity" />
            </div>
        </div> 
         <div class="form-group">
              <p>*Please select the Ownership</p>
            <div class="form-group">
                <strong>Ownership</strong>
               <asp:DropDownList runat="server" CssClass="form-control " ID="editOwnership"/>
            </div> 
             </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Update Reacreational Facilities" OnClick="EditRecreations"/>
                <div class="clearfix"></div>
            </div>
      </div>
    </div>
  </div>
  </div>
     <script>
         function deleteRecreation(id, campusName) {
             document.getElementById("FacilityToDelete").innerText = campusName;
             document.getElementById("MainContent_removeRecerationCode").value = id;
            $("#deleteRecreationModal").modal();
        }
         function editRecreational(campusName,type,location,quantity,ownership) {
             document.getElementById("MainContent_editCampusName").value = campusName;
             document.getElementById("MainContent_editType").value = type;
             document.getElementById("MainContent_editLocation").value = location;
             document.getElementById("MainContent_editQunatity").value = quantity;
             document.getElementById("MainContent_editOwnership").value = ownership;
             $("#editRecreationModal").modal();
        }
    </script>
     <script>
         $(document).ready(function() {
             $('.datatables').DataTable({
                 responsive: true
             });
         });
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
                               <%-- <%

                                    int campus1 = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"])).ToList().Count;
                                %>
                                <% =campus1 %>--%>
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
                                    int programs1 = nav.Programs.Where(r => r.Accreditation_Status == "CUE Accredited" && r.Institution_Code == Convert.ToString(Session["UniversityCode"])).ToList().Count;
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
                               <%-- <%
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
            <p>*List of all uploaded Recreational Facility details</p>
            <div class="panel-heading">Added Recreational Facilities</div>
            <div class="panel-body">
                <table class="table table-bordered table-striped dataTables">
                    <thead>
                    <tr>
                        <th>Campus</th>
                        <th>Type of Facility</th>
                        <th>Location</th>
                        <th>Number/Quantity</th>
                        <th>Ownership</th>
                    </tr>
                    </thead>
                      <tbody>
                    <%
                        var nav1 = Config.ReturnNav();
                        var recreational = nav.RecreationalFacilites.Where(r => r.UniversityCode == Convert.ToString(Session["UniversityCode"]));
                        foreach (var recreation in recreational)
                        {
                            %>
                        <tr>
                            <td><%=recreation.Campus %></td>
                            <td><%=recreation.facility_type %></td>
                            <td><%=recreation.location %></td>
                            <td><%=recreation.quantity %></td>
                            <td><%=recreation.ownership %></td>
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
