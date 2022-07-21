<%@ Page Title="" Language="C#" MasterPageFile="~/DataCollectionMaster.Master" AutoEventWireup="true" CodeBehind="WasteManagement.aspx.cs" Inherits="CicPortal.WasteManagement" %>
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
            <div class="panel-heading">Add Waste Management Facility</div>
            <div class="panel-body">
                  <div id="feedback" runat="server"></div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please select the campus Name</p>
                        <div class="form-group">
                            <strong>Campus:</strong>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="campus"/>
                        </div>
                    </div>  
                     <div class="col-md-6 col-lg-6">
                        <p>*Please enter the NEMA Disposal Method/Description</p>
                        <div class="form-group">
                            <strong>Description/NEMA Disposal Method:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="description" placeholder="Description/NEMA Disposal Method" />
                        </div>
                    </div>  
                </div> 
                  <div class="row">                  
                        <div class="col-md-6 col-lg-6">
                         <p>*Please select the waste management facility category</p>
                        <div class="form-group">
                            <strong>Facility Category:</strong>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="category" OnSelectedIndexChanged="facilities_SelectedIndexChanged" AutoPostBack="true"/>
                        </div>
                    </div>
                     <div class="col-md-6 col-lg-6">
                       <p>*Please select the waste management facility sub categories</p>
                        <div class="form-group">
                            <strong>Facility Sub-Category</strong>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="wastesubcategories" Placeholder ="Waste Management Facility Sub-Categories" />
                        </div>
                    </div>
                </div>
                  <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please enter the Capacity</p>
                        <div class="form-group">
                            <strong>Capacity:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="wastecapacity" placeholder="Capacity" TextMode="Number" min="0" />
                        </div>
                    </div> 
                </div>
            </div>
            <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Add Waste Management" OnClick="addWaste_Click"/>
                <div class="clearfix"></div>
            </div>
        </div>
        <div class="panel panel-default">
            <p>*List of all uploaded waste management Facilities</p>
            <div class="panel-heading">Added Waste Management Facilities</div>
            <div class="panel-body">
                <table class="table table-bordered table-striped datatable">
                    <thead>
                    <tr>
                        <th>Campus</th>
                        <th>Facility Category</th>
                        <th>NEMA Disposal Method</th>
                        <th>Facility Sub-Category</th>
                        <th>Capacity</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                    </thead>
                             <tbody>
                    <%
                        var nav = Config.ReturnNav();
                        var wastes = nav.Wastes_Managment.Where(r => r.University == Convert.ToString(Session["UniversityCode"]));
                        foreach (var waste in wastes)
                        {
                            %>
                        <tr>
                            <td><%=waste.Campus %></td>
                            <td><%=waste.Category %></td>
                            <td><%=waste.Disposal_Method %></td>
                            <td><%=waste.Hazardous_Materials %></td>
                            <td><%=waste.Capacity %></td>
                            <td><label class="btn btn-success" onclick="editWaste( '<%=waste.Campus %>','<%=waste.Category %>','<%=waste.Disposal_Method %>','<%=waste.Hazardous_Materials %>','<%=waste.Capacity %>')"><i class="fa fa-edit"></i> Edit</label></td>
                            <td><label class="btn btn-danger" onclick="deleteWaste('<%=waste.id %>','<%=waste.Campus %>')"><i class="fa fa-trash"></i> Delete</label></td>
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
         $(document).ready(function() {
             $('.datatable').DataTable({
                 responsive: true
             });
         });
     </script>
  <div id="deleteWasteModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Deleting Waste management facilities</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the waste management facility in <strong id="WasteToDelete"></strong>?</p>
          <asp:TextBox runat="server" ID="removeWasteCode" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
         <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Waste" OnClick="deleteWaste_Click"/>
      </div>
    </div>

  </div>
</div>

 <div id="editWasteModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
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
              <p>*Please select the waste management facility category</p>
            <div class="form-group">
                <strong>Category:</strong>
               <asp:DropDownList runat="server" CssClass="form-control " ID="editcategory"/>
            </div>           
        </div>  
          <div class="form-group">
               <p>*Please enter the NEMA Disposal Method/Description</p>
            <div class="form-group">
                <strong>Description/NEMA Disposal Method:</strong>
                <asp:TextBox runat="server" CssClass="form-control" ID="editmethod" placeholder="Description/NEMA Disposal Method" TextMode="MultiLine" />
            </div>
        </div>  
          <div class="form-group">
             <p>*Please enter any hazardous material(s)</p>
            <div class="form-group">
                <strong>Any Hazardous Material(s):</strong>
                <asp:TextBox runat="server" CssClass="form-control" ID="editanyother" Placeholder ="Any Hazardous Material(s)" />
            </div>
        </div> 
           <div class="form-group">
             <p>*Please enter Capacity</p>
            <div class="form-group">
                <strong>Capacity:</strong>
                <asp:TextBox runat="server" CssClass="form-control" ID="editcapacity" Placeholder ="Capacity" />
            </div>
        </div> 
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Update Waste Management" OnClick="EditWasteManagement"/>
                <div class="clearfix"></div>
            </div>
      </div>
    </div>
  </div>
  </div>
    <script>
        function deleteWaste(id, Campus) {
            document.getElementById("WasteToDelete").innerText = Campus;
        document.getElementById("MainContent_removeWasteCode").value = id;
        $("#deleteWasteModal").modal();}
        function editWaste(campusName,category,method,hazard,capacity ) {
            document.getElementById("MainContent_editCampusName").value = campusName;
            document.getElementById("MainContent_editcategory").value = category;
            document.getElementById("MainContent_editmethod").value = method;
            document.getElementById("MainContent_editanyother").value = hazard;
            document.getElementById("MainContent_editcapacity").value = capacity;
            $("#editWasteModal").modal();
}
</script>
     <script>
         $(document).ready(function() {
            /* $('#dataTables-example').DataTable({
                 responsive: true
             });*/
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
                                <%

                                    int campus1 = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"])).ToList().Count;
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
   <div class="panel panel-default">
            <p>*List of all uploaded waste management Facilities</p>
            <div class="panel-heading">Added Waste Management Facilities</div>
            <div class="panel-body">
                <table class="table table-bordered table-striped dataTables">
                    <thead>
                    <tr>
                        <th>Campus</th>
                        <th>Category</th>
                        <th>NEMA Disposal Method</th>
                        <th>Hazardous Materials</th>
                        <th>Capacity</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                    </thead>
                             <tbody>
                    <%
                        var nav1 = Config.ReturnNav();
                        var wastes = nav.Wastes_Managment.Where(r => r.University == Convert.ToString(Session["UniversityCode"]));
                        foreach (var waste in wastes)
                        {
                            %>
                        <tr>
                            <td><%=waste.Campus %></td>
                            <td><%=waste.Category %></td>
                            <td><%=waste.Disposal_Method %></td>
                            <td><%=waste.Hazardous_Materials %></td>
                              <td><%=waste.Capacity %></td>
                            <td><label class="btn btn-success" onclick="editWaste( '<%=waste.Campus %>','<%=waste.Category %>','<%=waste.Disposal_Method %>','<%=waste.Hazardous_Materials %>','<%=waste.Capacity %>')"><i class="fa fa-edit"></i> Edit</label></td>
                            <td><label class="btn btn-danger" onclick="deleteWaste('<%=waste.id %>','<%=waste.Campus %>')"><i class="fa fa-trash"></i> Delete</label></td>
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
<!-- needed by older browsers -->
<script src="https://github.com/eligrey/Blob.js"></script>

<!-- Required -->
<script src="https://rawgit.com/eligrey/FileSaver.js/src/FileSaver.js"></script>
<script src="https://unpkg.com/xlsx/dist/xlsx.full.min.js"></script>
 <%} %>
</asp:Content>
