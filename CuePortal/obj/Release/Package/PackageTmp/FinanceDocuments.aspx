<%@ Page Title="" Language="C#" MasterPageFile="~/DataCollectionMaster.Master" AutoEventWireup="true" CodeBehind="FinanceDocuments.aspx.cs" Inherits="CicPortal.FinanceDocuments" %>
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
    <div class="panel panel-default">
        <div class="panel-heading">Financial Documents(<i>Please Upload Current Financial Year Documents)</i>)</div>
        <div class="panel-body">
            <div id="feedback" runat="server"></div>
            <div class="form-group">
                <p>*Please upload Audited Profit and Loss Statement</p>
                <strong>Audited Statement of Financial Performance:</strong>
                <asp:FileUpload runat="server" CssClass="form-control" ID="auditedBooks"  />
            </div>
             <div class="form-group">
                <p>*Please upload Current Profit and Loss Statement</p>
                <strong>Current Statement of Financial Performance:</strong>
                <asp:FileUpload runat="server" CssClass="form-control" ID="auditedBooks1"  />
            </div>
            <div class="form-group">
                <p>*Please Upload Audited Balance Sheet Statement</p>
                <strong>Audited Statement of Financial Position:</strong>
                <asp:FileUpload runat="server" CssClass="form-control" ID="balanceSheet"  />
            </div>
            <div class="form-group">
                <p>*Please Upload Current Balance Sheet Statement</p>
                <strong>Current Statement of Financial Position:</strong>
                <asp:FileUpload runat="server" CssClass="form-control" ID="balanceSheet1"  />
            </div>
            <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Upload" ID="upload" OnClick="upload_Click" />
                <div class="clearfix"></div>
            </div>
             <table class="table table-bordered table-striped">
            <thead>
                <tr>
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
                        String documentDirectory = filesFolder + universityNumber + "/" + "Financial Documents" + "/";
                        if (Directory.Exists(documentDirectory))
                        {
                            foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                            {
                                String url = documentDirectory;
                %>
                <tr>
                    <td><% =file.Replace(documentDirectory, "") %></td>
                    <td>
                   <label class="btn btn-success" onclick="downloadFile('<%=file.Replace(documentDirectory, "")%>');"><i class="fa fa-download">Download</label></td>
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
        <h4 class="modal-title">Confirm Deleting File</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the file <strong id="filetoDownloadName"></strong> ?</p>
          <asp:TextBox runat="server" ID="fileNametoDownload" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Download File" OnClick="DownloadFile_Click"/>
      </div>
    </div>
  </div>
</div>
       <%  }
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
                                <%

                                    int academicStaff = new Config().ObjNav().FnGetUniversityTotalUniversityStaff(Convert.ToString(Session["UniversityCode"]));
                                %>
                                <% =academicStaff %>
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
                    <div class="panel panel-green">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-user fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                   <div class="huge">
                                        <%
                                         int programs1=new Config().ObjNav().FnGetUniversityTotalUniversityProgrammes(Convert.ToString(Session["UniversityCode"]));
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
                                        <%
                                        int disability= new Config().ObjNav().FnGetUniversityPWDTotalStudents(Convert.ToString(Session["UniversityCode"]));
                                             %>
                                        <% =disability %>
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
    <div class="row">
        <div class="col-md-4 col-lg-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <i class="fa fa-bar-chart-o fa-fw"></i>Students Publications Per Category

                </div>
                <div class="panel-body">
                    <div id="type-chart" style="position: center; right: 0px; top: 0px;"></div>
                </div>
            </div>

        </div>
        <div class="col-md-4 col-lg-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <i class="fa fa-bar-chart-o fa-fw"></i>Students Publications Distribution by Domain

                </div>
                <div class="panel-body">
                    <div id="domains-chart" style="position: center; right: 0px; top: 0px;"></div>
                </div>
            </div>

        </div>
        <div class="col-md-4 col-lg-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <i class="fa fa-bar-chart-o fa-fw"></i>Students Research  by Category

                </div>
                <div class="panel-body">
                    <div id="category-chart" style="position: center; right: 0px; top: 0px;"></div>
                </div>
            </div>

        </div>
    </div>
    <div class="row">
      <table class="table table-bordered table-striped" id="example2">
            <thead>
                <tr>
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
                        String documentDirectory = filesFolder + universityNumber + "/" + "Financial Documents" + "/";
                        if (Directory.Exists(documentDirectory))
                        {
                            foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                            {
                                String url = documentDirectory;
                %>
                <tr>
                    <td><% =file.Replace(documentDirectory, "") %></td>
                    <td>
                   <label class="btn btn-success" onclick="downloadFile('<%=file.Replace(documentDirectory, "")%>');"><i class="fa fa-download">Download</label></td>
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
    <%} %>

    <script>        
         function deleteFile(fileName) {
             document.getElementById("filetoDeleteName").innerText = fileName;
             document.getElementById("MainContent_fileName").value = fileName;
             $("#deleteFileModal").modal(); 
         }
         function downloadFile(downloadfileName) {
             document.getElementById("filetoDownloadName").innerText = downloadfileName;
             document.getElementById("MainContent_fileNametoDownload").value = downloadfileName;
             $("#downloadFileModal").modal();
         }
</script> 
</asp:Content>
