<%@ Page Title="" Language="C#" MasterPageFile="~/DataCollectionMaster.Master" AutoEventWireup="true" CodeBehind="Fire.aspx.cs" Inherits="CicPortal.Fire" %>
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
            <div class="panel-heading">Add Fire Fighting Details</div>
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
                         <p>*Please select the Safety measures class</p>
                        <div class="form-group">
                            <strong>Class:</strong>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="fireClass"/>
                        </div>
                    </div>
                </div> 
                  <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please enter the safety measures Location/Block</p>
                        <div class="form-group">
                            <strong>Block/Location:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="block" placeholder="Block/Location" />
                        </div>
                    </div>  
                     <div class="col-md-6 col-lg-6">
                         <p>*Please enter the No of Devices </p>
                        <div class="form-group">
                            <strong>No of Devices:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="noOfDevices" Placeholder ="No of Devices"  TextMode="Number" min="0"/>
                        </div>
                    </div>
                </div> 
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please enter the Date of the Last Inspection</p>
                        <div class="form-group">
                            <strong>Date of Last Inspection:</strong>
                            <asp:TextBox runat="server" CssClass="form-control bootstrapdatepicker" ID="lastInspection" placeholder="Date of Last Inspection"  />
                        </div>
                    </div>  
                    <div class="col-md-6 col-lg-6">
                        <p>*Please upload fire compliance certificate</p>
                        <div class="form-group">
                            <strong>Fire Compliance Certificate:</strong>
                            <asp:FileUpload runat="server" CssClass="form-control" ID="fireCompliance"  />
                        </div>
                    </div>
                </div>
                 <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please check if Biometric registration of all students and staff exists</p>
                        <div class="form-group">
                            <strong>Biometric Registration:</strong>
                           <asp:Checkbox runat="server" CssClass="form-control" ID="biometricregistrations"/>
                        </div>
                    </div>  
                     <div class="col-md-6 col-lg-6">
                        <p>*Please check if Functional electronic records of all students and staff exists</p>
                        <div class="form-group">
                            <strong>Functional Electronic Records:</strong>
                           <asp:Checkbox runat="server" CssClass="form-control" ID="functionalrecords"/>
                        </div>
                    </div>
                </div> 
                 <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please check if Bio data including passport size photographs of each student residing within the university accommodation facilities exists</p>
                        <div class="form-group">
                            <strong>Biometric Registration:</strong>
                           <asp:Checkbox runat="server" CssClass="form-control" ID="biodata"/>
                        </div>
                    </div>                     
                </div> 
            </div>
           <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Add Fire Fighting Details" OnClick="addFire_Click"/>
                <div class="clearfix"></div>
            </div>
        </div>
        </div>
        <div class="panel panel-default">
            <p>*List of all uploaded safety measures details</p>
            <div class="panel-heading">Submitted Fire Fighting Details</div>
            <div class="panel-body">
                 <table class="table table-bordered table-striped datatable">
                    <thead>
                    <tr>
                        <th>Campus</th>
                        <th>Class</th>
                        <th>Block/Location</th>
                        <th>No. of Devices</th>
                        <th>Date of Last Inspection</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                    </thead>
                  <tbody>
                    <%
                        var nav = Config.ReturnNav();
                        var fires = nav.Fires.Where(r => r.university == Convert.ToString(Session["UniversityCode"]));
                        foreach (var fire in fires)
                        {
                            %>
                        <tr>
                            <td><%=fire.campus_code %></td>
                            <td><%=fire.fireclass %></td>
                             <td><%=fire.location %></td>
                             <td><%=fire.number_of_devices %></td>
                             <td><%=Convert.ToDateTime(fire.date_of_last_inspection) %></td>
                            <td><label class="btn btn-success" onclick="editFires( '<%=fire.campus_code %>','<%=fire.fireclass %>','<%=fire.location %>','<%=fire.number_of_devices %>','<%=fire.date_of_last_inspection %>')"><i class="fa fa-edit"></i> Edit</label></td>
                            <td><label class="btn btn-danger" onclick="deleteFire('<%=fire.id %>','<%=fire.campus_code %>')"><i class="fa fa-trash"></i> Delete</label></td>
                        </tr>
                        <%
                        }
                         %>
                    </tbody>
                </table>
            </div>
        </div>
        
        <div class="panel panel-default">
            <div class="panel-heading">Elevated water for Fire fighting</div>
            <div id="elevetedwaterfeedback" runat="server"></div>
            <div class="panel-body">
                <div class="row">
                     <div class="col-md-4 col-lg-4">
                        <div class="form-group">
                            <br/>
                            <p>*Please select the campus name</p>
                            <strong>Campus:</strong>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="elevatedCampus"/>
                        </div>
                    </div> 
                 <div class="col-md-4 col-lg-4">
                     <p>*Please enter the volume of the elevated water storage for fire fighting</p>
                        <div class="form-group">
                            <strong>Volume of elevated water (Litres):</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="elevatedvolume" Placeholder ="Volume of elevated water storage" />
                        </div>
                    </div>
                      <div class="col-md-4 col-lg-4">
                          <br/>
                          <br/>
                          <asp:Button runat="server" CssClass="btn btn-success" Text="Add Eleveted Water Details" OnClick="addElevetedWaterDetails_Click"/>
                          </div>
                    
                    </div>
                   <div class="panel-body">
                  <table class="table table-bordered table-striped datatable">
                    <thead>
                    <tr>
                          <th>#</th>
                        <th>Campus</th>
                        <th>Volume of Elevated Water</th>
                         <th>Edit</th>
                         <th>Delete</th>
                    </tr>
                    </thead>
                    <tbody>
                           <%
                               var navs = Config.ReturnNav();
                               var elevetedwaters = nav.Eleveted_Water_Detail.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                               int elevetedwatercounter = 0;
                               foreach (var elevetedwater in elevetedwaters)
                               {
                                   elevetedwatercounter++;
                            %>
                        <tr>
                            <td><%=elevetedwatercounter %></td>
                            <td><%=elevetedwater.University_Campus %></td>
                            <td><%=elevetedwater.Volume_of_Eleveted %></td>
                            <td><label class="btn btn-success" onclick="editElevetedWater('<%=elevetedwater.Code %>', '<%=elevetedwater.University_Campus %>', '<%=elevetedwater.Volume_of_Eleveted %>')"><i class="fa fa-edit"></i> Edit</label></td>
                            <td><label class="btn btn-danger" onclick="deleteElevetedWater('<%=elevetedwater.Code %>','<%=elevetedwater.Volume_of_Eleveted %>')"><i class="fa fa-trash"></i> Delete</label></td>
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
  <div id="deleteFireModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Deleting Building</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the Building in <strong id="FireDelete"></strong>?</p>
          <asp:TextBox runat="server" ID="removeFireCode" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
         <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Fire" OnClick="deleteFire_Click"/>
      </div>
    </div>
  </div>
</div>
 <div id="deleteElevetedWaterModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Deleting Eleveted Water</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the  Eleveted Water Details  Volume <strong id="elevetedwater"></strong>?</p>
          <asp:TextBox runat="server" ID="elevetedwatercode" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
         <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Eleveted Water Details" OnClick="deleteElevetedWater_Click"/>
      </div>
    </div>
  </div>
</div>
 <div id="editFireModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Edit Safety Measures</h4>
      </div>
      <div class="modal-body">
         
           <div class="form-group">
            <p>*Please select the campus name</p>
            <strong>Campus:</strong>
            <asp:DropDownList runat="server" CssClass="form-control" ID="editCampus"/>
        </div>
        </div> 
     <div class="modal-body">
         <div class="form-group">
            <p>*Please select the Class</p>
            <strong>Class:</strong>
            <asp:DropDownList runat="server" CssClass="form-control" ID="editclass"/>
        </div>
       </div>
     <div class="modal-body">
          <div class="form-group">
             <p>*Please enter Block/Location</p>
            <div class="form-group">
                <strong>Block/Location:</strong>
                <asp:TextBox runat="server" CssClass="form-control" ID="editlocation" Placeholder ="Block/Location" />
            </div>
        </div>  
        </div>  
     <div class="modal-body">
        <div class="form-group">
             <p>*Please enter No. Of Devices</p>
            <div class="form-group">
                <strong>No. of Devices</strong>
                <asp:TextBox runat="server" CssClass="form-control" ID="devices" Placeholder ="Block/Location" />
            </div>
        </div> 
     </div> 
<div class="modal-body">
          <div class="form-group">
             <p>*Please enter Date of Last Inspection</p>
            <div class="form-group">
                <strong>Date of Last Inspection</strong>
                <asp:TextBox runat="server" CssClass="form-control bootstrapdatepicker " ID="dateofinspection" Placeholder ="Block/Location" />
            </div>
        </div> 
 </div> 
<div class="modal-body">
                        <p>*Please upload fire compliance certificate</p>
                        <div class="form-group">
                            <strong>Fire Compliance Certificate:</strong>
                            <asp:FileUpload runat="server" CssClass="form-control" ID="editfilecompliance"  />
                        </div>
                    </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Update Fire Fighting Details" OnClick="EditSafety" />
                <div class="clearfix"></div>
            </div>
      </div>
    </div>
  </div>

 <div id="editSafetyModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Edit Safety Management</h4>
      </div>
      <div class="modal-body">
           <div class="form-group">
               <p>*Please select the campus Name</p>
            <strong>Campus Name:</strong>
            <asp:DropDownList runat="server" CssClass="form-control" ID="editCampusName"/>
        </div> 
        </div>
      <div class="modal-body">
          <div class="form-group">
              <p>*Please select the Class category</p>
            <div class="form-group">
                <strong>Category:</strong>
               <asp:DropDownList runat="server" CssClass="form-control " ID="editcategory"/>
            </div>
          </div>
        </div>  
      <div class="modal-body">        
          <div class="form-group">
               <p>*Please enter the Block/Location</p>
            <div class="form-group">
                <strong>Block/Location:</strong>
                <asp:TextBox runat="server" CssClass="form-control" ID="TextBox1" placeholder="Block/Location" />
            </div>
        </div> 
          </div>
      <div class="modal-body">         
          <div class="form-group">
             <p>*Please enter No. of Devices</p>
            <div class="form-group">
                <strong>No. of Devices:</strong>
                <asp:TextBox runat="server" CssClass="form-control" ID="TextBox2" Placeholder ="No. of Devices" />
            </div>
        </div> 
        </div>
         <div class="modal-body"> 
           <div class="form-group">
             <p>*Please enter Date of Last Inspection</p>
            <div class="form-group">
                <strong>Date of Last Inspection:</strong>
                <asp:TextBox runat="server" CssClass="form-control" ID="TextBox3" Placeholder ="Date of Last Inspection" />
            </div>
        </div> 
    </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Update Safety Measures"  />
                <div class="clearfix"></div>
            </div>
      </div>
    </div>
  </div>
<div id="editElevetedModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Update Eleveted Water Details</h4>
      </div>
      <div class="modal-body">
            <asp:TextBox runat="server" ID="editelevetedwatercode" type="hidden"/>
           <div class="form-group">
               <p>*Please select the campus Name</p>
            <strong>Campus Name:</strong>
            <asp:DropDownList runat="server" CssClass="form-control" ID="editelevetedwatercampus"/>
        </div> 
        </div>
      <div class="modal-body">
          <div class="form-group">
              <p>*Please select the Class category</p>
            <div class="form-group">
                <strong>Volume of elevated water (Litres):</strong>
               <asp:TextBox runat="server" CssClass="form-control " ID="editelevetedwater"/>
            </div>
          </div>
        </div>  
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Update Safety Measures"  OnClick="updateElevetedWater_Click" />
                <div class="clearfix"></div>
            </div>
      </div>
    </div>
  </div>
<script>
    function deleteFire(id, campusName) {
        document.getElementById("FireDelete").innerText = campusName;
        document.getElementById("MainContent_removeFireCode").value = id;
        $("#deleteFireModal").modal();

    }
    function deleteElevetedWater(id, watervolume) {
        document.getElementById("elevetedwater").innerText = watervolume;
        document.getElementById("MainContent_elevetedwatercode").value = id;
        $("#deleteElevetedWaterModal").modal();

    }
    function editElevetedWater(codes,campusName, volume) {
        document.getElementById("MainContent_editelevetedwatercode").value = codes;
        document.getElementById("MainContent_editelevetedwatercampus").value = campusName;
        document.getElementById("MainContent_editelevetedwater").value = volume;
        $("#editElevetedModal").modal();
    }
    function editFires(campusName,typeclass,location,devices,dateofinspection) {
        document.getElementById("MainContent_editCampus").value = campusName;
        document.getElementById("MainContent_editclass").value = typeclass;
        document.getElementById("MainContent_editlocation").value = location;
        document.getElementById("MainContent_devices").value = devices;
        document.getElementById("MainContent_dateofinspection").value = dateofinspection;
            $("#editFireModal").modal();
    }
</script>
  <script>
    $(document).ready(function() {
     $('.datatable').DataTable({
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
                              <%--  <%
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
            <p>*List of all uploaded safety measures details</p>
            <div class="panel-heading">Submitted Fire Fighting Details</div>
            <div class="panel-body">
                 <table class="table table-bordered table-striped dataTables">
                    <thead>
                    <tr>
                        <th>Campus</th>
                        <th>Class</th>
                        <th>Block/Location</th>
                        <th>No. of Devices</th>
                        <th>Date of Last Inspection</th>
                    </tr>
                    </thead>
                  <tbody>
                    <%
                        var nav1 = Config.ReturnNav();
                        var fires = nav.Fires.Where(r => r.university == Convert.ToString(Session["UniversityCode"]));
                        foreach (var fire in fires)
                        {
                            %>
                        <tr>
                            <td><%=fire.campus_code %></td>
                            <td><%=fire.fireclass %></td>
                             <td><%=fire.location %></td>
                             <td><%=fire.number_of_devices %></td>
                             <td><%=fire.date_of_last_inspection %></td>
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
