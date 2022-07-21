<%@ Page Title="" Language="C#" MasterPageFile="~/DataCollectionMaster.Master" AutoEventWireup="true" CodeBehind="UtilityServices.aspx.cs" Inherits="CicPortal.UtilityServices" %>
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
            <div class="panel-heading">Add Utility Services</div>
            <div class="panel-body">
                  <div runat="server" id="feedback"></div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please select the Campus Name</p>
                        <div class="form-group">
                            <strong>Campus:</strong>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="campus"/>
                        </div>
                    </div>  
                     <div class="col-md-6 col-lg-6">
                         <p>*Please select the Utility Services Category</p>
                        <div class="form-group">
                            <strong>Utility Services Category:</strong>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="category"/>
                        </div>
                    </div>
                </div> 
                  <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please enter the Utility Service Name/Description</p>
                        <div class="form-group">
                            <strong>Name/Description:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="description" placeholder="Name/Description" />
                        </div>
                    </div>  
                     <div class="col-md-6 col-lg-6">
                         <p>*Please enter the Utility Service Status</p>
                        <div class="form-group">
                            <strong>Utility Services Status:</strong>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="utilstatus" />
                        </div>
                    </div>
                </div>
                 <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please enter the Utility service capcacity</p>
                        <div class="form-group">
                            <strong>Capacity:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="capacity" placeholder="Capacity" TextMode="Number"  min="0"/>
                        </div>
                    </div>  
                     <div class="col-md-6 col-lg-6">
                         <p>*PLease enter the utility service provider</p>
                        <div class="form-group">
                            <strong>Service Provider:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="serviceProvider" placeholder="Service Provider" />
                        </div>
                    </div>
                </div>
             
            </div>
              <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Add Utility Services" OnClick="addUtility_Click"/>
                <div class="clearfix"></div>
            </div>
        </div>
        <div class="panel panel-default">
            <p>*List of All uploaded Utility services</p>
            <div class="panel-heading">Added Utility Services</div>
            <div class="panel-body">
                <table class="table table-bordered table-striped datatable">
                    <thead>
                    <tr>
                        <th>Campus</th>
                        <th>Category</th>
                        <th>Name/Description</th>
                        <th>Status</th>
                        <th>Capacity</th>
                        <th>Service Provider</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                    </thead>
                     <tbody>
                    <%
                        var nav = Config.ReturnNav();
                        var utility = nav.UtilityServices.Where(r => r.UniversityCode == Convert.ToString(Session["UniversityCode"]));
                        foreach (var util in utility)
                        {
                            %>
                        <tr>
                            <td><%=util.Campus %></td>
                            <td><%=util.utilitycategory %></td>
                            <td><%=util.Description %></td>
                            <td><%=util.utilitystatus %></td>
                            <td><%=util.capacity %></td>
                            <td><%=util.servicerprovider %></td>
                            <td><label class="btn btn-success" onclick="editUtility('<%=util.Campus %>', '<%=util.Description %>', '<%=util.utilitycategory%>','<%=util.utilitystatus %>','<%=util.capacity %>','<%=util.servicerprovider %>')"><i class="fa fa-edit"></i> Edit</label></td>
                            <td><label class="btn btn-danger" onclick="deleteUtility('<%=util.id %>','<%=util.Campus %>')"><i class="fa fa-trash"></i> Delete</label></td>
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
<div id="deleteUtilityModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Deleting Utility Services</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the Utility Service in  <strong id="UtilityToDelete"></strong>?</p>
          <asp:TextBox runat="server" ID="removeUtilityCode" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
         <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Utility Services" OnClick="deleteUtility_Click"/>
      </div>
    </div>

  </div>
</div>

 <div id="editUtilityModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Edit Utility Services</h4>
      </div>
      <div class="modal-body">
           <div class="form-group">
                <p>*Please select the Campus Name</p>
            <div class="form-group">
                <strong>Campus:</strong>
                <asp:DropDownList runat="server" CssClass="form-control" ID="editcampus"/>
            </div>
         </div> 
          <div class="form-group">
             <p>*Please select the Utility Services Category</p>
            <div class="form-group">
                <strong>Category:</strong>
                <asp:DropDownList runat="server" CssClass="form-control" ID="editCategory"/>
            </div>
        </div>  
          <div class="form-group">
               <p>*Please enter the Utility Service Name/Description</p>
            <div class="form-group">
                <strong>Name/Description:</strong>
                <asp:TextBox runat="server" CssClass="form-control" ID="editDescription" placeholder="Name/Description" />
            </div>
        </div>  
          <div class="form-group">
               <p>*Please enter the Utility Service Status</p>
                <div class="form-group">
                    <strong>Status:</strong>
                    <asp:DropDownList runat="server" CssClass="form-control" ID="editStatus" />
                </div>
        </div>
       <div class="form-group">
        <p>*Please enter the Utility service capacity</p>
        <div class="form-group">
            <strong>Capacity:</strong>
            <asp:TextBox runat="server" CssClass="form-control" ID="editCapacity" placeholder="Capacity" />
        </div>
    </div>  
       <div class="form-group">
        <p>*Please enter the utility service provider</p>
    <div class="form-group">
        <strong>Service Provider:</strong>
        <asp:TextBox runat="server" CssClass="form-control" ID="editService" placeholder="Service Provider" />
    </div>
   </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Update Utilities" OnClick="EditUtility"/>
                <div class="clearfix"></div>
            </div>
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
  <script>
         function deleteUtility(id, Campus) {
             document.getElementById("UtilityToDelete").innerText = Campus;
            document.getElementById("MainContent_removeUtilityCode").value = id;
            $("#deleteUtilityModal").modal();
}
         function editUtility(campusName, name, category, status, capacity,service) {
             document.getElementById("MainContent_editcampus").value = campusName;
             document.getElementById("MainContent_editCategory").value = category;
             document.getElementById("MainContent_editDescription").value = name;
             document.getElementById("MainContent_editStatus").value = status;
             document.getElementById("MainContent_editCapacity").value = capacity;
             document.getElementById("MainContent_editService").value = service;
             $("#editUtilityModal").modal();
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
                                  <%--      <%
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
            <p>*List of All uploaded Utility services</p>
            <div class="panel-heading">Added Utility Services</div>
            <div class="panel-body">
                <table class="table table-bordered table-striped datatable">
                    <thead>
                    <tr>
                        <th>Campus</th>
                        <th>Category</th>
                        <th>Name/Description</th>
                        <th>Status</th>
                        <th>Capacity</th>
                        <th>Service Provider</th>
                    </tr>
                    </thead>
                     <tbody>
                    <%
                        var nav1 = Config.ReturnNav();
                        var utility = nav.UtilityServices.Where(r => r.UniversityCode == Convert.ToString(Session["UniversityCode"]));
                        foreach (var util in utility)
                        {
                            %>
                        <tr>
                            <td><%=util.Campus %></td>
                            <td><%=util.utilitycategory %></td>
                            <td><%=util.Description %></td>
                            <td><%=util.utilitystatus %></td>
                            <td><%=util.capacity %></td>
                            <td><%=util.servicerprovider %></td>
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
<!-- needed by older browsers -->
<script src="https://github.com/eligrey/Blob.js"></script>
<!-- Required -->
<script src="https://rawgit.com/eligrey/FileSaver.js/src/FileSaver.js"></script>
<script src="https://unpkg.com/xlsx/dist/xlsx.full.min.js"></script>
<%
  }
  %>
</asp:Content>
