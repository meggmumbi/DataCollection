<%@ Page Title="" Language="C#" MasterPageFile="~/ChooseServiceMaster.Master" AutoEventWireup="true" CodeBehind="Organogram.aspx.cs" Inherits="CicPortal.Organogram" %>

<%@ Import Namespace="CicPortal" %>
<%@ Import Namespace="System.IO" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%
        var userType = Convert.ToString(Session["UserType"]);
        List<Int32> programLevelCount = new List<int>();
        List<String> programLevels = new List<String>();
        if (userType == "Data Officer")
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

                                    int academicStaff = nav.University_Staff_Details.Where(r => r.Institution_Code == Convert.ToString(Session["UniversityCode"]) && r.Staff_Type == "Teaching"&&r.Current_Profile==true).ToList().Count;
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
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-xs-3">
                            <i class="fa fa-book fa-5x"></i>
                        </div>
                        <div class="col-xs-9 text-right">
                            <div class="huge">
                               <%-- <%
                                    int disability = nav.University_Staff_Details.Where(r => r.Institution_Code == Convert.ToString(Session["UniversityCode"])&&r.Current_Profile==true&&r.Disability_Registration_Code!="").ToList().Count;
                                %>
                                <% =disability %>--%>
                            </div>
                            <div>PWD Staff</div>
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
    </div>
    <div class="row" style="width: 100%; margin: 5px;">
        <div class="panel panel-default">
            <p>*Please Upload the University Organogram</p>
            <div class="panel-heading">University Organogram</div>
            <div class="panel-body">
                <div id="feedback" runat="server"></div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Upload University Organogram :</strong>
                            <div class="file-upload-wrapper">
                              <asp:FileUpload runat="server" CssClass="form-control" ID="organorgram" />
                            </div>
                          
                        </div>
                         <div class="panel-footer">
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Organogram" OnClick="upload_Click" />
                           <div class="clearfix"></div>
                           </div>
                    </div>

                </div>
                       <table class="table table-bordered table-striped">
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
                        String universityNumber =  Convert.ToString(Session["UniversityCode"]);
                        universityNumber = universityNumber.Replace('/', '_');
                        universityNumber = universityNumber.Replace(':', '_');
                        String documentDirectory = filesFolder + universityNumber + "/"+"Organogram/";
                        int filecounter = 0;
                        if (Directory.Exists(documentDirectory))
                        {
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
                    <label class="btn btn-danger" onclick="deleteFile('<%=file.Replace(documentDirectory, "")%>');"><i class="fa fa-trash-o"></i>Delete</label>

                    </td>
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
        </div>
    </div>
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
    <%} %>
</asp:Content>
