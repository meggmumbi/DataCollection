<%@ Page Title="" Language="C#" MasterPageFile="~/DataCollectionMaster.Master" AutoEventWireup="true" CodeBehind="Library.aspx.cs" Inherits="CicPortal.Library" %>

<%@ Import Namespace="CicPortal" %>
<%@ Import Namespace="System.IO" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%
        var userType = Convert.ToString(Session["UserType"]);
        List<Int32> programLevelCount = new List<int>();
        List<String> programLevels = new List<String>();
        if (userType == "Data Officer")
        { %>
    <div class="row" style="width: 100%; margin: 5px;">
        <div class="panel panel-default">
            <div class="panel-heading">
                Add Library Resources
            </div>
            <div class="panel-body">
                <div id="feedback" runat="server"></div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please select the campus name</p>
                        <div class="form-group">
                            <strong>Campus:</strong>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="campus" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <p>Please enter the Library Name/Description</p>
                        <div class="form-group">
                            <strong>Description/Name:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="description" placeholder="Description/Name" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please enter the Library Sitting Capacity</p>
                        <div class="form-group">
                            <strong>Sitting Capacity:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="sittingCapacity" placeholder="Sitting Capacity" TextMode="Number" />
                        </div>
                    </div>
                       <div class="col-md-6 col-lg-6">
                        <p>*Please check if the library has Library Advisory Committee </p>
                        <div class="form-group">
                            <strong>Library Advisory Committee:</strong>
                            <asp:CheckBox runat="server" CssClass="form-control" ID="advisorycommittee" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please enter the Library No. of Volumes</p>
                        <div class="form-group">
                            <strong>No. of Volumes:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="noOfVolumes" placeholder="No. of Volumes" TextMode="Number" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <p>*Please Enter the Library No. of Titles</p>
                        <div class="form-group">
                            <strong>No. of Titles:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="noOfTitles" Placeholder="No. of Titles" TextMode="Number" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please check if the library has Library Management Committee</p>
                        <div class="form-group">
                            <strong>Library Management Committee:</strong>
                            <asp:CheckBox runat="server" CssClass="form-control" ID="managementcommittee" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <p>*Please enter the Library Bandwidth Allocation</p>
                        <div class="form-group">
                            <strong>Library Bandwidth Allocation:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="bandwidth" Placeholder="Bandwidth" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please check if the library has Anti Plagiarism Software</p>
                        <div class="form-group">
                            <strong>Anti Plagiarism Software:</strong>
                            <asp:CheckBox runat="server" CssClass="form-control" ID="antiPlagiarism" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <p>*Please check if the library has Digital Repository</p>
                        <div class="form-group">
                            <strong>Digital Repository:</strong>
                            <asp:CheckBox runat="server" CssClass="form-control" ID="digitalRepository" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please enter the Number of Library Staff Working in the Library</p>
                        <div class="form-group">
                            <strong>No. Of Library Staff:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="noOfStaff" placeholder="No. Of Staff" TextMode="Number" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <p>*Please enter the number of Active Data Access Points</p>
                        <div class="form-group">
                            <strong>Active Data Access Points:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="dataccess" Placeholder="Active Data Access Points" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please enter the No. of Computers in the Library</p>
                        <div class="form-group">
                            <strong>No. of Computers:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="computers" Placeholder="No. of Computers" TextMode="Number" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <p>*Please check if the library has Security system </p>
                        <div class="form-group">
                            <strong>Security system:</strong>
                            <asp:CheckBox runat="server" CssClass="form-control" ID="securitysystem" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please check if the library has Off campus access software </p>
                        <div class="form-group">
                            <strong>Off campus access Software:</strong>
                            <asp:CheckBox runat="server" CssClass="form-control" ID="offcampussystem" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <p>*Please check if the library has  Online Public Access Catalogue(OPAC)</p>
                        <div class="form-group">
                            <strong>Online Public Access Catalog(OPAC):</strong>
                            <asp:CheckBox runat="server" CssClass="form-control" ID="opac" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Add Library Resources Details" OnClick="addLibrary_Click" />
                <div class="clearfix"></div>
            </div>
        </div>
        <div class="panel panel-default">
            <p>*List of All uploaded Library Resources details</p>
            <div class="panel-heading">Added Library Resources</div>
            <div class="panel-body">
                <table class="table table-bordered table-striped datatable">
                    <thead>
                        <tr>
                            <th>Campus</th>
                            <th>Description/Name</th>
                            <th>Sitting Capacity</th>
                            <th>Functional Areas</th>
                            <th>No of Volumes</th>
                            <th>No of Titles</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var nav = Config.ReturnNav();
                            var library = nav.Librarydetails.Where(r => r.UniversityCode == Convert.ToString(Session["UniversityCode"]));
                            foreach (var lib in library)
                            {
                        %>
                        <tr>
                            <td><%=lib.Campus %></td>
                            <td><%=lib.LibraryName %></td>
                            <td><%=lib.SittingCapacity %></td>
                            <td><%=lib.FunctionalAreas %></td>
                            <td><%=lib.NoofVolumes %></td>
                            <td><%=lib.NoofTitles %></td>
                            <td>
                                <label class="btn btn-success" onclick="editLibrary( '<%=lib.Campus %>','<%=lib.LibraryName %>','<%=lib.SittingCapacity %>','<%=lib.FunctionalAreas %>','<%=lib.NoofVolumes %>','<%=lib.NoofTitles %>','<%=lib.Librarybandwith %>','<%=lib.NoofLibraryStaff %>','<%=lib.QualificationsofLibraryStaff %>','<%=lib.NoofComputers %>','<%=lib.ActiveDataAccesspoint %>','<%=lib.Off_Campus_Access_System %>','<%=lib.OPAC %>','<%=lib.Security_System %>','<%=lib.Library_Advisory_Committee %>','<%=lib.Library_Management_Commitee %>','<%=lib.Digital_Repository %>','<%=lib.Antiplagiarism_Software %>')"><i class="fa fa-edit"></i>Edit</label></td>
                            <td>
                                <label class="btn btn-danger" onclick="deleteLibrary('<%=lib.id %>','<%=lib.Campus %>')"><i class="fa fa-trash"></i>Delete</label></td>
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
    <div id="deleteLibrarysModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting Library General Details</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete theGeneral Details in <strong id="LibraryToDelete"></strong>?</p>
                    <asp:TextBox runat="server" ID="removeLibraryCode" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Library  Details" OnClick="deleteLibrary_Click" />
                </div>
            </div>

        </div>
    </div>

    <div id="editLibraryModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit Library</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <p>*Please select the Campus Name</p>
                                <div class="form-group">
                                    <strong>Campus:</strong>
                                    <asp:DropDownList runat="server" CssClass="form-control" ID="editcampus" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <p>*Please enter the Description</p>
                                <div class="form-group">
                                    <strong>Description:</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="editdescription" placeholder="Name/Description" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <p>*Please enter Sitting Capacity:</p>
                                <div class="form-group">
                                    <strong>Sitting Capacity::</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="editSitting" placeholder="Sitting Capacity:" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <p>*Please enter the Functional Areas:</p>
                                <div class="form-group">
                                    <strong>Functional Areas::</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="editfunctional" placeholder="Functional Areas" />
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <p>*Please enter the No. of Volumes:</p>
                                <div class="form-group">
                                    <strong>No. of Volumes::</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="editVolume" placeholder="No. of Volumes:" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <p>*Please enter the No. of Titles:</p>
                                <div class="form-group">
                                    <strong>No. of Titles:</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="editTitle" placeholder="No. of Titles" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <p>*PLease enter the Library Bandwidth Allocation:</p>
                                <div class="form-group">
                                    <strong>Library Bandwidth Allocation::</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="editbandwith" placeholder="Library Bandwidth Allocation" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <p>*PLease enter the No. Of Library Staff:</p>
                                <div class="form-group">
                                    <strong>No. Of Library Staff:</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="editStaff" placeholder="No. Of Library Staff" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <p>*PLease enter the Qualifications of Library Staff:</p>
                                <div class="form-group">
                                    <strong>Qualifications of Library Staff:</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="editQualification" placeholder="Qualifications of Library Staff" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <p>*PLease enter the No. of Computers:</p>
                                <div class="form-group">
                                    <strong>No. of Computers:</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="editComputers" placeholder="No. of Computers:" />
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <p>*PLease enter Active Data Access Points:</p>
                                <div class="form-group">
                                    <strong>Active Data Access Points:</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="editAccespoints" placeholder="Active Data Access Points:" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <p>*Please check if the library has Library Advisory Committee </p>
                                <div class="form-group">

                                    <strong>Library Advisory Committee:</strong>
                                    <asp:CheckBox runat="server" CssClass="form-control" ID="editlibraryadvisorycommittee" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <div class="form-group">                              
                                <div class="form-group">
                                    <p>*Please check if the library has Library Management Committee</p>
                                    <strong>Library Management Committee:</strong>
                                    <asp:CheckBox runat="server" CssClass="form-control" ID="editlibrarycommittee" />
                                </div>
                            </div>
                        </div>
                          <div class="col-md-6 col-lg-6">
                        <p>*Please check if the library has Security system </p>
                        <div class="form-group">
                            <strong>Security system:</strong>
                            <asp:CheckBox runat="server" CssClass="form-control" ID="editsecurity" />
                        </div>
                    </div>
                    </div>
                    <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please check if the library has Off campus access software </p>
                        <div class="form-group">
                            <strong>Off campus access Software:</strong>
                            <asp:CheckBox runat="server" CssClass="form-control" ID="editoffcampussystem" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <p>*Please check if the library has  Online Public Access Catalogue(OPAC)</p>
                        <div class="form-group">
                            <strong>Online Public Access Catalog(OPAC):</strong>
                            <asp:CheckBox runat="server" CssClass="form-control" ID="editopacs" />
                        </div>
                    </div>
                </div>
                 <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <p>*Please check if the library has Anti Plagiarism Software</p>
                        <div class="form-group">
                            <strong>Anti Plagiarism Software:</strong>
                            <asp:CheckBox runat="server" CssClass="form-control" ID="editantiplagiarism" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <p>*Please check if the library has Digital Repository</p>
                        <div class="form-group">
                            <strong>Digital Repository:</strong>
                            <asp:CheckBox runat="server" CssClass="form-control" ID="editdigitalrepo" />
                        </div>
                    </div>
                </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Update Library" OnClick="EditLibrary" />
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            function deleteLibrary(id, Campus) {
                document.getElementById("LibraryToDelete").innerText = Campus;
                document.getElementById("MainContent_removeLibraryCode").value = id;
                $("#deleteLibrarysModal").modal();
            }
            function editLibrary(campusName, libraryname, capacity, functional, volume, titles, bandwith, staff, qualifications, computers, accesspoints,offcampussystem,opacs,security,advisorycommitee,librarymanagementcommittee,digitalrepo,antiplagiarism) {
                document.getElementById("MainContent_editcampus").value = campusName;
                document.getElementById("MainContent_editdescription").value = libraryname;
                document.getElementById("MainContent_editSitting").value = capacity;
                document.getElementById("MainContent_editfunctional").value = functional;
                document.getElementById("MainContent_editVolume").value = volume;
                document.getElementById("MainContent_editTitle").value = titles;
                document.getElementById("MainContent_editbandwith").value = bandwith;
                document.getElementById("MainContent_editStaff").value = staff;
                document.getElementById("MainContent_editQualification").value = qualifications;
                document.getElementById("MainContent_editComputers").value = computers;
                document.getElementById("MainContent_editAccespoints").value = accesspoints;
                if (offcampussystem == "1") {
                    document.getElementById("MainContent_editoffcampussystem").checked = true;
                } if (opacs == "1") {                    
                    document.getElementById("MainContent_editopacs").checked = true;
                } if (security == "1") {                
                    document.getElementById("MainContent_editsecurity").checked = true;
                } if (advisorycommitee == "1") {
                    document.getElementById("MainContent_editlibraryadvisorycommittee").checked = true;
                } if (librarymanagementcommittee == "1") {
                    document.getElementById("MainContent_editlibrarycommittee").checked = true;
                } if (digitalrepo == "1") {
                    document.getElementById("MainContent_editdigitalrepo").checked = true;
                } if (antiplagiarism == "1") {
                    document.getElementById("MainContent_editantiplagiarism").checked = true;
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
            <p>*List of All uploaded Library Resources details</p>
            <div class="panel-heading">Added Library Resources</div>
            <div class="panel-body">
                <table class="table table-bordered table-striped dataTables">
                    <thead>
                        <tr>
                            <th>Campus</th>
                            <th>Description/Name</th>
                            <th>Sitting Capacity</th>
                            <th>Functional Areas</th>
                            <th>No of Volumes</th>
                            <th>No of Titles</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var nav1 = Config.ReturnNav();
                            var library = nav.Librarydetails.Where(r => r.UniversityCode == Convert.ToString(Session["UniversityCode"]));
                            foreach (var lib in library)
                            {
                        %>
                        <tr>
                            <td><%=lib.Campus %></td>
                            <td><%=lib.LibraryName %></td>
                            <td><%=lib.SittingCapacity %></td>
                            <td><%=lib.FunctionalAreas %></td>
                            <td><%=lib.NoofVolumes %></td>
                             <td><%=lib.NoofTitles %></td>
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
