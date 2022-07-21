<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LibraryServices.aspx.cs" MasterPageFile="~/DataCollectionMaster.Master" Inherits="CicPortal.LibraryServices" %>

<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%
        var userType = Convert.ToString(Session["UserType"]);
        List<Int32> programLevelCount = new List<int>();
        List<String> programLevels = new List<String>();
        if (userType == "Data Officer")
        { %>
    
    
     <div class="row" style="width: 100%; margin: 5px;">
        <div class="panel panel-default">
            <div class="panel-heading">Add Library Services
            </div>
            <div class="panel-body">
                <div id="feedback" runat="server"></div>    
                 <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please select Library Name </p>
                        <div class="form-group">
                            <strong>Campus Name:</strong>
                             <asp:DropDownList runat="server" CssClass="form-control" ID="universitylibrarycampus"/>
                        </div>
                    </div>
                     <div class="col-md-6 col-lg-6">
                         <p>*Please check if the library Offer Information Literacy  Services</p>
                        <div class="form-group">
                            <strong>Information Literacy Services:</strong>
                            <asp:Checkbox runat="server" CssClass="form-control" ID="informationliteracy"/>
                        </div>
                    </div>  
                </div>         
                 <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please check if the library Offer Reference & Information Service </p>
                        <div class="form-group">
                            <strong>Reference & Information Services:</strong>
                             <asp:Checkbox runat="server" CssClass="form-control" ID="referenceinformation"/>
                        </div>
                    </div>  
                     <div class="col-md-6 col-lg-6">
                         <p>*Please check if the library Offer Circulation Services</p>
                        <div class="form-group">
                            <strong>Circulation Services:</strong>
                            <asp:Checkbox runat="server" CssClass="form-control" ID="circulations"/>
                        </div>
                    </div>
                </div>
                 <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please check if the library Offer Awareness Services</p>
                        <div class="form-group">
                            <strong>Current Awareness Services:</strong>
                             <asp:Checkbox runat="server" CssClass="form-control" ID="awareness"/>
                        </div>
                    </div>  
                     <div class="col-md-6 col-lg-6">
                         <p>*Please check if the library Offer Inter library Loans Services</p>
                        <div class="form-group">
                            <strong>Inter library Services:</strong>
                            <asp:Checkbox runat="server" CssClass="form-control" ID="interlibraryuloans"/>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please check if the library Offer Reprographic Services </p>
                        <div class="form-group">
                            <strong>Reprographic Services (Printing, photocopying, and binding):</strong>
                             <asp:Checkbox runat="server" CssClass="form-control" ID="reprographic"/>
                        </div>
                    </div>  
                     <div class="col-md-6 col-lg-6">
                         <p>*Please check if the library Offer Multimedia Services</p>
                        <div class="form-group">
                            <strong>Multimedia Services:</strong>
                            <asp:Checkbox runat="server" CssClass="form-control" ID="multimedia"/>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please check if the library Offer Knowledge Management  Services </p>
                        <div class="form-group">
                            <strong>Knowledge Management Services:</strong>
                             <asp:Checkbox runat="server" CssClass="form-control" ID="knowledgemanagement"/>
                        </div>
                    </div>  
                     <div class="col-md-6 col-lg-6">
                         <p>*Please check if the library Offer Preservation Services</p>
                        <div class="form-group">
                            <strong>Preservation Services:</strong>
                            <asp:Checkbox runat="server" CssClass="form-control" ID="preservation"/>
                        </div>
                    </div>
                  </div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please check if the library Offer Archiving  Services </p>
                        <div class="form-group">
                            <strong>Archiving Services:</strong>
                             <asp:Checkbox runat="server" CssClass="form-control" ID="archiving"/>
                        </div>
                    </div>  
                     <div class="col-md-6 col-lg-6">
                         <p>*Please check if the library Offer Information Resources Services</p>
                        <div class="form-group">
                            <strong>Information Resources Services:</strong>
                            <asp:Checkbox runat="server" CssClass="form-control" ID="information"/>
                        </div>
                    </div>
                  </div>
                </div>
            </div>
            <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Add Library Services "  OnClick="SubmitServices_Click"/>
                <div class="clearfix"></div>
            </div>
        <div class="panel panel-default">
            <p>*List of All uploaded Library Services details</p>
            <div class="panel-heading">Added Library Services</div>
            <div class="panel-body">
                <table class="table table-bordered table-striped datatable">
                    <thead>
                    <tr>
                        <th>Library Name</th>
                        <th>Circulation</th>
                        <th>Awareness</th>
                        <th>Multimedia</th>
                        <th>Preservation</th>
                        <th>Archiving</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                    </thead>
                   <tbody>
                    <%
                        var nav = Config.ReturnNav();
                        var library = nav.LibraryServices.Where(r => r.University_No == Convert.ToString(Session["UniversityCode"]));
                        foreach (var lib in library)
                        {
                            %>
                        <tr>     
                            <td><%=lib.Library_Campus_Name%></td>
                            <td><%=Convert.ToBoolean(lib.Circulation )?"Yes":"No"%></td>
                            <td><%=Convert.ToBoolean(lib.Awareness )?"Yes":"No"%></td>
                            <td><%=Convert.ToBoolean(lib.Multimedia)?"Yes":"No" %></td>
                            <td><%=Convert.ToBoolean(lib.Preservation)?"Yes":"No" %></td>
                            <td><%=Convert.ToBoolean(lib.Archiving )?"Yes":"No"%></td>
                            <td><label class="btn btn-success" onclick="editLibrary( '<%=lib.Library_Name %>','<%=lib.Circulation %>','<%=lib.Awareness %>','<%=lib.Multimedia %>','<%=lib.Preservation %>','<%=lib.Archiving %>')"><i class="fa fa-edit"></i> Edit</label></td>
                            <td><label class="btn btn-danger" onclick="deleteLibrary('<%=lib.id %>','<%=lib.Library_Name %>')"><i class="fa fa-trash"></i> Delete</label></td>
                        </tr>
                        <%
                            }
                         %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
     
<script>        
         function deleteFile(fileName) {
             document.getElementById("filetoDeleteName").innerText = fileName;
             document.getElementById("MainContent_fileName").value = fileName;
             $("#deleteFileModal").modal(); 
         }
     </script> 
     <script>
         $(document).ready(function () {
             $('.datatable').DataTable({
                 responsive: true
             });
         });
     </script>

 <div id="editLibraryModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Edit Library Services</h4>
      </div>
      <div class="modal-body">
        <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please select Library Name </p>
                        <div class="form-group">
                            <strong>Campus Name:</strong>
                             <asp:DropDownList runat="server" CssClass="form-control" ID="editlibraryname"/>
                        </div>
                    </div>
                     <div class="col-md-6 col-lg-6">
                         <p>*Please check if the library Offer Information Literacy  Services</p>
                        <div class="form-group">
                            <strong>Information Literacy:</strong>
                            <asp:Checkbox runat="server" CssClass="form-control" ID="editinfromationliteracy"/>
                        </div>
                    </div>  
                </div>  
             <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please check if the library Offer Reference & Information Service </p>
                        <div class="form-group">
                            <strong>Reference & Information:</strong>
                             <asp:Checkbox runat="server" CssClass="form-control" ID="editreferencinformation"/>
                        </div>
                    </div>  
                     <div class="col-md-6 col-lg-6">
                         <p>*Please check if the library Offer Circulation Services</p>
                        <div class="form-group">
                            <strong>Circulation:</strong>
                            <asp:Checkbox runat="server" CssClass="form-control" ID="editcirculation"/>
                        </div>
                    </div>
                </div>
              <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please check if the library Offer Awareness Services</p>
                        <div class="form-group">
                            <strong>Awareness:</strong>
                             <asp:Checkbox runat="server" CssClass="form-control" ID="editawareness"/>
                        </div>
                    </div>  
                     <div class="col-md-6 col-lg-6">
                         <p>*Please check if the library Offer Inter library Loans Services</p>
                        <div class="form-group">
                            <strong>Inter library Loans:</strong>
                            <asp:Checkbox runat="server" CssClass="form-control" ID="editlibraryloans"/>
                        </div>
                    </div>
                </div>
            <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please check if the library Offer Reprographic Services </p>
                        <div class="form-group">
                            <strong>Reprographic:</strong>
                             <asp:Checkbox runat="server" CssClass="form-control" ID="editreprographic"/>
                        </div>
                    </div>  
                     <div class="col-md-6 col-lg-6">
                         <p>*Please check if the library Offer Multimedia Services</p>
                        <div class="form-group">
                            <strong>Multimedia:</strong>
                            <asp:Checkbox runat="server" CssClass="form-control" ID="editmultimedia"/>
                        </div>
                    </div>
                </div>
           <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please check if the library Offer Knowledge Management  Services </p>
                        <div class="form-group">
                            <strong>Knowledge Management:</strong>
                             <asp:Checkbox runat="server" CssClass="form-control" ID="editknowledgemanagement"/>
                        </div>
                    </div>  
                     <div class="col-md-6 col-lg-6">
                         <p>*Please check if the library Offer Preservation Services</p>
                        <div class="form-group">
                            <strong>Preservation:</strong>
                            <asp:Checkbox runat="server" CssClass="form-control" ID="editpreservation"/>
                        </div>
                    </div>
                </div>
           <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please check if the library Offer Archiving  Services </p>
                        <div class="form-group">
                            <strong>Archiving:</strong>
                             <asp:Checkbox runat="server" CssClass="form-control" ID="editarchiving"/>
                        </div>
                    </div>  
                 <div class="col-md-6 col-lg-6">
                         <p>*Please check if the library Offer Information Resources Services</p>
                        <div class="form-group">
                            <strong>Information Resources:</strong>
                            <asp:Checkbox runat="server" CssClass="form-control" ID="editinginformation"/>
                        </div>
                    </div>
                </div>        
             </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Update Services"  OnClick="UpdateLibraryServices_Click"/>
                <div class="clearfix"></div>
            </div>
  </div>
</div>
</div>
     <script>
         function deleteLibrary(id, libraryname) {
             document.getElementById("LibraryToDelete").innerText = libraryname;
             document.getElementById("MainContent_removeLibraryCode").value = id;
             $("#deleteLibrarysModal").modal();
         }
         function editLibrary(libraryname, informationliteracy, referencinformation, circulation,awareness, libraryloans, reprographic, multimedia, knowledgemanagement, preservation, archiving) {
             document.getElementById("MainContent_editlibraryname").value = libraryname;
             if (informationliteracy =="true") {
                 document.getElementById("MainContent_editinfromationliteracy").checked = true;
             } if (referencinformation == "true") {
                 document.getElementById("MainContent_editreferencinformation").checked = true;
             } if (circulation == "true") {
                 document.getElementById("MainContent_editcirculation").checked = true;
             }
             if (awareness == "true") {
                 document.getElementById("MainContent_editawareness").checked = true;
             } if (libraryloans == "true") {
                 document.getElementById("MainContent_editlibraryloans").checked = true;
             } if (reprographic == "true") {
                 document.getElementById("MainContent_editreprographic").checked = true;
             } if (multimedia == "true") {
                 document.getElementById("MainContent_editmultimedia").checked = true;
             } if (knowledgemanagement == "true") {
                 document.getElementById("MainContent_editknowledgemanagement").checked = true;
             } if (preservation =="true") {
                 document.getElementById("MainContent_editpreservation").checked = true;
             } if (archiving == "true") {
                 document.getElementById("MainContent_editarchiving").checked = true;
             }
             $("#editLibraryModal").modal();
         }
 </script>   
     <script>
         $(document).ready(function () {
             /* $('#dataTables-example').DataTable({
                  responsive: true
              });*/
         });
     </script>
   <div id="deleteLibrarysModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting Library Services  </h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the Library Service in <strong id="LibraryToDelete"></strong>?</p>
                    <asp:TextBox runat="server" ID="removeLibraryCode" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Library Service" OnClick="deleteLibrary_Click" />
                </div>
            </div>

        </div>
    </div>
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
            <p>*List of All uploaded Library Services details</p>
            <div class="panel-heading">Added Library Services</div>
            <div class="panel-body">
                <table class="table table-bordered table-striped dataTables">
                    <thead>
                    <tr>
                        <th>Library Name</th>
                        <th>Circulation Services</th>
                        <th>Awareness Services</th>
                        <th>Multimedia Services</th>
                        <th>Preservation Services</th>
                        <th>Archiving Services</th>
                    </tr>
                    </thead>
                   <tbody>
                    <%
                        var nav1 = Config.ReturnNav();
                        var library = nav.LibraryServices.Where(r => r.University_No == Convert.ToString(Session["UniversityCode"]));
                        foreach (var lib in library)
                        {
                            %>
                        <tr>
                            <td><%=lib.Library_Name %></td>
                            <td><%=lib.Circulation %></td>
                            <td><%=lib.Awareness %></td>
                            <td><%=lib.Multimedia %></td>
                            <td><%=lib.Preservation %></td>
                            <td><%=lib.Archiving %></td>
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
     }
        
    %>
</asp:Content>
