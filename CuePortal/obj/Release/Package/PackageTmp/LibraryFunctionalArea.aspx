<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LibraryFunctionalArea.aspx.cs" MasterPageFile="~/DataCollectionMaster.Master"  Inherits="CicPortal.LibraryFunctionalArea" %>

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
            <div class="panel-heading">Add Library Key Functional areas
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
                         <p>*Please check if the library has Circulation Functional Area </p>
                        <div class="form-group">
                            <strong>Circulation Functional Area:</strong>
                            <asp:Checkbox runat="server" CssClass="form-control" ID="circulations"/>
                        </div>
                    </div>  
                </div>         
                 <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please check if the library has Reference & Information Functional Area </p>
                        <div class="form-group">
                            <strong>Reference & Information Functional Area:</strong>
                             <asp:Checkbox runat="server" CssClass="form-control" ID="referenceinformation"/>
                        </div>
                    </div>  
                     <div class="col-md-6 col-lg-6">
                         <p>*Please check if the library has Digital Section Functional Area</p>
                        <div class="form-group">
                            <strong> Digital Section Functional Area:</strong>
                            <asp:Checkbox runat="server" CssClass="form-control" ID="digitalsections"/>
                        </div>
                    </div>
                </div>
                 <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please check if the library has University Librarian Office</p>
                        <div class="form-group">
                            <strong>University Librarian Office:</strong>
                             <asp:Checkbox runat="server" CssClass="form-control" ID="librarianoffice"/>
                        </div>
                    </div>  
                     <div class="col-md-6 col-lg-6">
                         <p>*Please check if the library has Staff working Area </p>
                        <div class="form-group">
                            <strong> Staff working Area :</strong>
                            <asp:Checkbox runat="server" CssClass="form-control" ID="staffworking"/>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please check if the library has Technical Section </p>
                        <div class="form-group">
                            <strong>Technical Section:</strong>
                             <asp:Checkbox runat="server" CssClass="form-control" ID="trechnicalarea"/>
                        </div>
                    </div>  
                     <div class="col-md-6 col-lg-6">
                         <p>*Please check if the library has Stack Areas</p>
                        <div class="form-group">
                            <strong>Stack Areas:</strong>
                            <asp:Checkbox runat="server" CssClass="form-control" ID="stackarea"/>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please check if the library has Reading Section Area </p>
                        <div class="form-group">
                            <strong>Reading Section Area:</strong>
                             <asp:Checkbox runat="server" CssClass="form-control" ID="readingsection"/>
                        </div>
                    </div>  
                     <div class="col-md-6 col-lg-6">
                         <p>*Please check if the library has Luggage area</p>
                        <div class="form-group">
                            <strong>Luggage Area:</strong>
                            <asp:Checkbox runat="server" CssClass="form-control" ID="luggagearea"/>
                        </div>
                    </div>
                  </div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please check if the library has Reprographic Section Area </p>
                        <div class="form-group">
                            <strong> Reprographic Section Area:</strong>
                             <asp:Checkbox runat="server" CssClass="form-control" ID="reprographic"/>
                        </div>
                    </div>  
                  </div>
                </div>
            </div>
            <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Add Library Functional Areas "  OnClick="SubmitFunctionalArea_Click" />
                <div class="clearfix"></div>
            </div>
        <div class="panel panel-default">
            <p>*List of All uploaded Library Services details</p>
            <div class="panel-heading">Added Library Functional Areas</div>
            <div class="panel-body">
                <table class="table table-bordered table-striped datatable">
                    <thead>
                    <tr>
                        <th>Campus Name</th>
                        <th>Technical Section</th>
                        <th>Stack Areas</th>
                        <th>Luggage Area</th>
                        <th>Staff Working Area </th>
                        <th>Librarian Office</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                    </thead>
                   <tbody>
                    <%
                        var nav = Config.ReturnNav();
                        var library = nav.LibraryFunctionalArea.Where(r => r.University_No == Convert.ToString(Session["UniversityCode"]));
                        foreach (var lib in library)
                        {
                            %>
                        <tr>     
                            <td><%=lib.Library_Campus_Name%></td>
                            <td><%=Convert.ToBoolean(lib.Technical_Section )?"Yes":"No"%></td>
                            <td><%=Convert.ToBoolean(lib.Stack_Areas )?"Yes":"No"%></td>
                            <td><%=Convert.ToBoolean(lib.Luggage_Area)?"Yes":"No" %></td>
                            <td><%=Convert.ToBoolean(lib.Staff_working_Area)?"Yes":"No" %></td>
                            <td><%=Convert.ToBoolean(lib.Librarian_Office )?"Yes":"No"%></td>
                            <td><label class="btn btn-success" onclick="editLibrary( '<%=lib.Library_Campus_Code %>','<%=lib.Technical_Section %>','<%=lib.Stack_Areas %>','<%=lib.Luggage_Area %>','<%=lib.Staff_working_Area %>','<%=lib.Librarian_Office %>','<%=lib.Reference_Information %>','<%=lib.Reading_Section %>','<%=lib.Reprographic_Section_Area %>')"><i class="fa fa-edit"></i> Edit</label></td>
                            <td><label class="btn btn-danger" onclick="deleteLibrary('<%=lib.id %>','<%=lib.Library_Campus_Code %>')"><i class="fa fa-trash"></i> Delete</label></td>
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
        <h4 class="modal-title">Edit Library Functional Areas</h4>
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
                         <p>*Please check if the library has Circulation Functional Area </p>
                        <div class="form-group">
                            <strong>Circulation Functional Area:</strong>
                            <asp:Checkbox runat="server" CssClass="form-control" ID="editcirculation"/>
                        </div>
                    </div> 
                      </div>        
                 <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please check if the library has Reference & Information Functional Area </p>
                        <div class="form-group">
                            <strong>Reference & Information Functional Area:</strong>
                             <asp:Checkbox runat="server" CssClass="form-control" ID="editreference"/>
                        </div>
                    </div>  
                     <div class="col-md-6 col-lg-6">
                         <p>*Please check if the library has Digital Section Functional Area</p>
                        <div class="form-group">
                            <strong> Digital Section Functional Area:</strong>
                            <asp:Checkbox runat="server" CssClass="form-control" ID="editdigital"/>
                        </div>
                    </div>
                </div>
                 <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please check if the library has University Librarian Office</p>
                        <div class="form-group">
                            <strong>University Librarian Office:</strong>
                             <asp:Checkbox runat="server" CssClass="form-control" ID="editlibrarian"/>
                        </div>
                    </div>  
                     <div class="col-md-6 col-lg-6">
                         <p>*Please check if the library has Staff working Area </p>
                        <div class="form-group">
                            <strong> Staff working Area :</strong>
                            <asp:Checkbox runat="server" CssClass="form-control" ID="editworking"/>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please check if the library has Technical Section </p>
                        <div class="form-group">
                            <strong>Technical Section:</strong>
                             <asp:Checkbox runat="server" CssClass="form-control" ID="edittechnical"/>
                        </div>
                    </div>  
                     <div class="col-md-6 col-lg-6">
                         <p>*Please check if the library has Stack Areas</p>
                        <div class="form-group">
                            <strong>Stack Areas:</strong>
                            <asp:Checkbox runat="server" CssClass="form-control" ID="editstackarea"/>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please check if the library has Reading Section Area </p>
                        <div class="form-group">
                            <strong>Reading Section Area:</strong>
                             <asp:Checkbox runat="server" CssClass="form-control" ID="editreading"/>
                        </div>
                    </div>  
                     <div class="col-md-6 col-lg-6">
                         <p>*Please check if the library has Luggage area</p>
                        <div class="form-group">
                            <strong>Luggage Area:</strong>
                            <asp:Checkbox runat="server" CssClass="form-control" ID="editluggage"/>
                        </div>
                    </div>
                  </div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please check if the library has Reprographic Section Area </p>
                        <div class="form-group">
                            <strong> Reprographic Section Area:</strong>
                             <asp:Checkbox runat="server" CssClass="form-control" ID="editreprographic"/>
                        </div>
                    </div>  
                  </div>
                </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Update Functional Area"  OnClick="EditFunctionalArea_Click" />
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
        function editLibrary(libraryname, technical, stackarea, luggage,staffworking, librarianoffice, references,readings,reprographic) {
             document.getElementById("MainContent_editlibraryname").value = libraryname;
             if (technical == "true") {
                 document.getElementById("MainContent_edittechnical").checked = true;
             } if (stackarea == "true") {
                 document.getElementById("MainContent_editstackarea").checked = true;
             } if (luggage == "true") {
                 document.getElementById("MainContent_editluggage").checked = true;
             }
             if (staffworking == "true") {
                 document.getElementById("MainContent_editworking").checked = true;
             } if (librarianoffice == "true") {
                 document.getElementById("MainContent_editlibrarian").checked = true;
             } if (reprographic == "true") {
                 document.getElementById("MainContent_editreprographic").checked = true;
             } if (references == "true") {
                 document.getElementById("MainContent_editreference").checked = true;
             } if (readings == "true") {
                 document.getElementById("MainContent_editreading").checked = true;
             } 
             $("#editLibraryModal").modal();
         }
 </script>   
   <div id="deleteLibrarysModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting Library Functional Area</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the Functional Resources in <strong id="LibraryToDelete"></strong>?</p>
                    <asp:TextBox runat="server" ID="removeLibraryCode" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Functional Area"  OnClick="deleteLibrary_Click" />
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

