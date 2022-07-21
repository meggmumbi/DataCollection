<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LibraryPolicies.aspx.cs" MasterPageFile="~/DataCollectionMaster.Master" Inherits="CicPortal.LibraryPolicies" %>

<%@ Import Namespace="CicPortal" %>
<%@ Import Namespace="System.IO" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%
        var userType = Convert.ToString(Session["UserType"]);
        List<Int32> programLevelCount = new List<int>();
        List<String> programLevels = new List<String>();
        if (userType == "Data Officer")
        { %>


     <div class="panel panel-default">
        <div class="panel-heading">
           University Library Policies<div class="pull-right"><i class="fa fa-angle-left"></i><i class="fa fa-angle-right"></i></div> <div class="clearfix"></div>
        </div>
        <div class="panel-body">
            <div id="documentsFeedback" runat="server"></div>           
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please upload the Library ICT Policy</p>
                        <div class="form-group">
                            <strong>Campus Name</strong>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="librarycampus"  />
                        </div>
                    </div>  
                    <div class="col-md-6 col-lg-6">
                        <p>*Please upload the Library Policy</p>
                        <div class="form-group">
                            <strong>Library Policy:</strong>
                            <asp:FileUpload runat="server" CssClass="form-control" ID="literacypolicy"  />
                        </div>
                    </div>  
                </div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please Check if Library Repository Policy exists</p>
                        <div class="form-group">
                            <strong>Library Repository Policy:</strong>
                              <asp:Checkbox runat="server" CssClass="form-control" ID="filerepositorypolicy"/>
                        </div>
                    </div>  
                     <div class="col-md-6 col-lg-6">
                        <p>*Please Check if Library Rules & Regulations Policy Exist</p>
                        <div class="form-group">
                            <strong>Library Rules & Regulations:</strong>
                              <asp:Checkbox runat="server" CssClass="form-control" ID="rulerequlationpolicy"/>
                        </div>
                    </div> 
                </div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please Check if Circulation  Policy Exists</p>
                        <div class="form-group">
                            <strong>Circulation Policy:</strong>
                             <asp:Checkbox runat="server" CssClass="form-control" ID="circulationpolicy"/>
                        </div>
                    </div>  
                   <div class="col-md-6 col-lg-6">
                        <p>*Please Check if Disaster Management Policy Exists</p>
                        <div class="form-group">
                            <strong>Disaster Management Policy:</strong>
                             <asp:Checkbox runat="server" CssClass="form-control" ID="disasterpolicy"/>
                        </div>
                    </div>  
                </div>
            <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please Check if Library ICT Policy Exists</p>
                        <div class="form-group">
                            <strong>Library ICT Policy:</strong>
                               <asp:Checkbox runat="server" CssClass="form-control" ID="ictpolicy"/>
                        </div>
                    </div>  
                   <div class="col-md-6 col-lg-6">
                        <p>*Please Check if Collection Development and Management Policy Exists</p>
                        <div class="form-group">
                            <strong>Collection Development and Management Policy:</strong>
                              <asp:Checkbox runat="server" CssClass="form-control" ID="managementpolicy"/>
                        </div>
                    </div>  
                </div>
                 <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 form-group">
                    <br/>
                    <asp:Button runat="server" ID="addrationale" CssClass="btn btn-success" Text="Upload Library Policies" OnClick="upload_Click" />
                </div>
               </div>  
                
            <br/>
            <hr/>
            <br/>
             <table class="table table-bordered table-striped datatable">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Document Title</th>
                    <th>Download</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try
                    {
                        String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Customer Card/";
                        String universityNumber = Convert.ToString(Session["UniversityCode"]);
                        universityNumber = universityNumber.Replace('/', '_');
                        universityNumber = universityNumber.Replace(':', '_');
                        String documentDirectory = filesFolder + universityNumber + "/" + "Library Policies" + "/";
                        if (Directory.Exists(documentDirectory))
                        {
                            int filecounter = 0;
                            foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                            {
                                filecounter++;
                                String url = documentDirectory;
                %>
                <tr>
                     <td><% =filecounter%></td>
                    <td><% =file.Replace(documentDirectory, "") %></td>

                    <td> 
                        <label class="btn btn-success" onclick="DownloadFile('<%=file.Replace(documentDirectory, "")%>');"><i class="fa fa-download"></i>Download</label></td>
                    <td>
                        <label class="btn btn-danger" onclick="deleteFile('<%=file.Replace(documentDirectory, "")%>');"><i class="fa fa-trash-o"></i>Delete</label></td>
                </tr>
                <%
                            }
                        }
                    }
                    catch (Exception)
                    {

                    }%>
            </tbody>
        </table>

  </div>
       <script>        
         function deleteFile(fileName) {
             document.getElementById("filetoDeleteName").innerText = fileName;
             document.getElementById("MainContent_fileName").value = fileName;
             $("#deleteFileModal").modal(); 
         }
         function DownloadFile(fileName) {
             document.getElementById("filetoDownloadName").innerText = fileName;
             document.getElementById("MainContent_downloadfilename").value = fileName;
             $("#downloadFileModal").modal();
         }
     </script> 
     <script>
         $(document).ready(function () {
             $('.datatable').DataTable({
                 responsive: true
             });
         });
     </script>
  <div id="deleteFileModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Deleting File</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the file <strong id="filetoDeleteName"></strong> ?</p>
          <asp:TextBox runat="server" ID="fileName" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" OnClick="deleteFile_Click"/>
      </div>
    </div>
  </div>
</div> 
     <div id="downloadFileModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Downloading File</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to download the file <strong id="filetoDownloadName"></strong> ?</p>
          <asp:TextBox runat="server" ID="downloadfilename" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Download File" OnClick="downloadFile_Click"/>
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
  <table class="table table-bordered table-striped datatable">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Document Title</th>
                    <th>Download</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try
                    {
                        String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Customer Card/";
                        String universityNumber = Convert.ToString(Session["UniversityCode"]);
                        universityNumber = universityNumber.Replace('/', '_');
                        universityNumber = universityNumber.Replace(':', '_');
                        String documentDirectory = filesFolder + universityNumber + "/" + "Library Policies" + "/";
                        if (Directory.Exists(documentDirectory))
                        {
                            int filecounter = 0;
                            foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                            {
                                filecounter++;
                                String url = documentDirectory;
                %>
                <tr>
                     <td><% =filecounter%></td>
                    <td><% =file.Replace(documentDirectory, "") %></td>

                    <td><a href="<%=filesFolder %><% =universityNumber + "\\" + file.Replace(documentDirectory, "") %>" class="btn btn-success download">Download</a></td>
                    </tr>
                <%
                            }
                        }
                    }
                    catch (Exception)
                    {

                  }%>
            </tbody>
        </table>
 <script>
         $(document).ready(function () {
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
  
   <%} %>
    
</asp:Content>

