<%@ Page Title="" Language="C#" MasterPageFile="~/DataCollectionMaster.Master" AutoEventWireup="true" CodeBehind="Sanitation.aspx.cs" Inherits="CicPortal.Sanitation" %>
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
            <div class="panel-heading">Add Sanitation Facility</div>
            <div class="panel-body">
                <div runat="server" id="feedback"></div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please select the campus name</p>
                        <div class="form-group">
                            <strong>Campus:</strong>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="campus"/>
                        </div>
                    </div>  
                     <div class="col-md-6 col-lg-6">
                         <p>*Please select the Sanitation Type</p>
                        <div class="form-group">
                            <strong>Sanitation Type:</strong>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="type" />
                        </div>
                    </div>
                </div> 
                  <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please enter the  saniation Number/Quantity </p>
                        <div class="form-group">
                            <strong>Number/Quantity:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="quantity" placeholder="Number/Quantity" TextMode="Number" min="0" />
                        </div>
                    </div>  
                     <div class="col-md-6 col-lg-6">
                         <p>*Please enter the Sanitation Location/Block</p>
                        <div class="form-group">
                            <strong>Location/Block:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="location" Placeholder ="Location" />
                        </div>
                    </div>
                </div>
            </div>
             <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Add Satitation Facility" OnClick="addSanitation_Click"/>
                <div class="clearfix"></div>
            </div>
        </div>
        <div class="panel panel-default">
            <p>*List of all uploaded sanitation details</p>
            <div class="panel-heading">Added Sanitation Facilities</div>
            <div class="panel-body">
                <table class="table table-bordered table-striped datatable">
                    <thead>
                    <tr>
                        <th>Campus</th>
                        <th>Type</th>
                        <th>Name</th>
                        <th>Location/Block</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                    </thead>
                      <tbody>
                    <%
                        var nav = Config.ReturnNav();
                        var sanitation = nav.Sanitations.Where(r => r.UniversityCode == Convert.ToString(Session["UniversityCode"]));
                        foreach (var san in sanitation)
                        {
                            %>
                        <tr>
                            <td><%=san.Campus %></td>
                            <td><%=san.sanitationtype %></td>
                            <td><%=san.name %></td>
                            <td><%=san.location%></td>
                            <td><label class="btn btn-success" onclick="editSanitation('<%=san.Campus %>', '<%=san.sanitationtype %>', '<%=san.name%>', '<%=san.location %>')"><i class="fa fa-edit"></i> Edit</label></td>
                            <td><label class="btn btn-danger" onclick="deleteSanitation('<%=san.id %>','<%=san.Campus %>')"><i class="fa fa-trash"></i> Delete</label></td>
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
    <div id="deleteSanitationModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Deleting Sanitation Services</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the Sanitation Service  <strong id="SanitationToDelete"></strong>?</p>
          <asp:TextBox runat="server" ID="removeSanitationCode" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
         <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Sanitation Facility" OnClick="deleteSanitation_Click"/>
      </div>
    </div>

  </div>
</div>

 <div id="editSanitationModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Edit Sanitations</h4>
      </div>
      <div class="modal-body">
           <div class="form-group">
               <p>*Please select the campus Name</p>
            <strong>Campus Name:</strong>
            <asp:DropDownList runat="server" CssClass="form-control" ID="editCampusName"/>
        </div> 
          <div class="form-group">
              <p>*Please select Sanitation Type</p>
            <div class="form-group">
                <strong>Sanitation Type:</strong>
               <asp:DropDownList runat="server" CssClass="form-control " ID="editType"/>
            </div>
           
        </div>  
          <div class="form-group">
              <p>*Please Enter Number</p>
            <div class="form-group">
                <strong>Number:</strong>
              <asp:TextBox runat="server" CssClass="form-control" ID="editname" placeholder="Name" />
            </div>
           
        </div>  
          <div class="form-group">
               <p>*Please enter the Location/Block</p>
            <div class="form-group">
                <strong>Location/Block:</strong>
                <asp:TextBox runat="server" CssClass="form-control" ID="editLocation" placeholder="Location" />
            </div>
        </div>  
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Update Sanitation" OnClick="EditSanitations"/>
                <div class="clearfix"></div>
            </div>
      </div>
    </div>
  </div>
  </div>
 <script>
     function deleteSanitation(id, Campus) {
         document.getElementById("SanitationToDelete").innerText = Campus;
            document.getElementById("MainContent_removeSanitationCode").value = id;
            $("#deleteSanitationModal").modal();
      }
     function editSanitation(campusName, type, name, location) {
        document.getElementById("MainContent_editCampusName").value = campusName;
        document.getElementById("MainContent_editType").value = type;
        document.getElementById("MainContent_editname").value = name;
    document.getElementById("MainContent_editLocation").value = location;
    $("#editSanitationModal").modal();
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
                                   int programs1=nav.Programs.Where(r => r.Accreditation_Status == "CUE Accredited" && r.Institution_Code == Convert.ToString( Session["UniversityCode"])).ToList().Count;
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
                                <%--        <%
                                   int disability=nav.University_Staff_Details.Where(r => r.Institution_Code == Convert.ToString( Session["UniversityCode"])).ToList().Count;
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
            <p>*List of all uploaded sanitation details</p>
            <div class="panel-heading">Added Sanitation Facilities</div>
            <div class="panel-body">
                <table class="table table-bordered table-striped datatable">
                    <thead>
                    <tr>
                        <th>Campus</th>
                        <th>Type</th>
                        <th>Name</th>
                        <th>Location/Block</th>
                    </tr>
                    </thead>
                      <tbody>
                    <%
                        var nav1 = Config.ReturnNav();
                        var sanitation = nav.Sanitations.Where(r => r.UniversityCode == Convert.ToString(Session["UniversityCode"]));
                        foreach (var san in sanitation)
                        {
                            %>
                        <tr>
                            <td><%=san.Campus %></td>
                            <td><%=san.sanitationtype %></td>
                            <td><%=san.name %></td>
                            <td><%=san.location%></td>
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
  }
  %>
</asp:Content>
