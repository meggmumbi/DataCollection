<%@ Page Title="" Language="C#" MasterPageFile="~/DataCollectionMaster.Master" AutoEventWireup="true" CodeBehind="Students.aspx.cs" Inherits="CicPortal.Students" %>

<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%
        var userType = Convert.ToString(Session["UserType"]);
        List<Int32> programLevelCount = new List<int>();
        List<String> programLevels = new List<String>();
        if (userType == "Data Officer")
        { %>  
         <div>
            <div class="row">
            <div class="col-md-6 col-lg-6">                 
                <div class="panel panel-default">
                    <p>* Click Download Data Template to download formatted excel template</p>
                    <div class="panel-heading">Excel Upload</div>
                    <div class="panel-body">
                        <a href="templates/Students.xlsx"><i class="fa fa-file-excel-o"></i>Download Data Template</a>
                        <div class="form-group">
                            <select class="form-control" id="dataType" style='display: none;'>
                                <option value="-1" disabled selected>Select Data to Import</option>
                                <option selected value="">Import Posts Data</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <input type="file" id="fileUploader" class="btn btn-fill btn-primary btn-large" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="panel panel-default">
                    <p>*Click Add Ws Coverage to enter details manually</p>
                    <div class="panel-heading">Form Upload</div>
                    <div class="panel-body">
                        <label class="btn btn-success" data-toggle="modal" data-target="#form-input"><i class="fa fa-plus fa-fw"></i>Add Ws Coverage</label>
                    </div>
                </div>

            </div>
        </div>
        <div runat="server" id="feedback"></div>
        <div id="deletallfeedback" style="display: none" data-dismiss="alert"></div>
        <div id="tableOutput">
        </div>
        <div class="panel panel-default">
            <p>*List of uploaded Ws coverage details</p>
            <div class="panel-heading">Water Service Coverage</div>
            <div class="panel-body">
                 <div style="display: none;background-color:antiquewhite" id="deletealldiv" >
                   <center><button type="button" class="btn btn-danger deletestudentsdata" id="deletestudentsdata" name="deletestudentsdata">Delete Selected Records</button></center> 
                </div>
                <table id="example1" class="table table-bordered table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>Water Service Coverage</th>
                                                        <th>Unit</th>
                                                        <th>Current </th>
                                                        <th>Previous</th>

                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>Total Population Living in the area</td>
                                                        <td>No.</td>
                                                        <td>4</td>
                                                        <td>4</td>

                                                    </tr>
                                                    <tr>
                                                        <td>Average Household size in the area</td>
                                                        <td>No.</td>
                                                        <td>4</td>
                                                        <td>4</td>

                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <p style="color: darkblue">Average Hours Of supply</p>
                                                        </td>
                                                        <td>hrs./day</td>
                                                        <td>4</td>
                                                        <td>4</td>

                                                    </tr>
                                                    <tr>
                                                        <td>Population Served (Total)</td>
                                                        <td>No</td>
                                                        <td>4</td>
                                                        <td>4</td>

                                                    </tr>
                                                       <tr>
                                                        <td>Registered individual water connections</td>
                                                        <td>No.</td>
                                                        <td>4</td>
                                                        <td>4</td>

                                                    </tr>
                                                    <tr>
                                                        <td>Dormant individual water connections (disconnected longer than 3 months)</td>
                                                        <td>No.</td>
                                                        <td>4</td>
                                                        <td>4</td>

                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            Active individual water connections
                                                        </td>
                                                        <td>No</td>
                                                        <td>4</td>
                                                        <td>4</td>

                                                    </tr>
                                                    <tr>
                                                        <td>Average number of people served per individual water connection</td>
                                                        <td>No</td>
                                                        <td>4</td>
                                                        <td>4</td>

                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            Average number of people served per individual water connection
                                                        </td>
                                                        <td>No</td>
                                                        <td>4</td>
                                                        <td>4</td>

                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <p style="color: darkblue">Water Service Coverage(total)</p>
                                                        </td>
                                                        <td>%</td>
                                                        <td>4</td>
                                                        <td>4</td>

                                                    </tr>

                                                </tbody>

                                            </table>
            </div>
        </div>
    </div>
    <div id="studentUpload" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Uploading Student Data</h4>
                </div>
                <div class="modal-body">
                    <label id="progress"></label>
                    <div id="myProgress">
                        <div id="myBar">0%</div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <div id="form-input" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Add Student Details</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>* Please enter Student ID No./Passport No./Birth Cert. No. </p>
                            <div class="form-group"><strong>ID No./Passport No./Birth Cert. No.:</strong><asp:TextBox runat="server" CssClass="form-control" placeholder="ID No./Passport No./Birth Cert. No." ID="idNumber" />
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter student admission no.</p>
                            <div class="form-group"><strong>Admission No/Registration No:</strong><asp:TextBox runat="server" CssClass="form-control" placeholder="Admission No" ID="admNo" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter student First Name</p>
                            <div class="form-group"><strong>First Name:</strong><asp:TextBox runat="server" CssClass="form-control" placeholder="First Name" ID="firstName" />
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter student Middle Name</p>
                            <div class="form-group"><strong>Middle Name:</strong><asp:TextBox runat="server" CssClass="form-control" placeholder="Middle Name" ID="middleName" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter student Last Name</p>
                            <div class="form-group"><strong>Last Name:</strong><asp:TextBox runat="server" CssClass="form-control" placeholder="Last Name" ID="lastName" />
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter student year of study</p>
                            <div class="form-group"><strong>Year of Study:</strong><asp:TextBox runat="server" CssClass="form-control" ID="yearOfStudy" TextMode="Number" placeholder="Year of Study" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>*Please select student gender</p>
                            <div class="form-group"><strong>Gender:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="gender" />
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter student Date of Birth</p>
                            <div class="form-group"><strong>Date of Birth:</strong><asp:TextBox runat="server"   CssClass="form-control bootstrapdatepicker" placeholder="Date of Birth" ID="dob" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>*Please select student Nationality</p>
                            <div class="form-group"><strong>Nationality:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="nationality" />
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please select student Home county</p>
                            <div class="form-group"><strong>Home County:</strong><asp:DropDownList runat="server" CssClass="form-control" placeholder="Home County" ID="homeCounty" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter student Disabilty Decription</p>
                            <div class="form-group">
                                <strong>Disability Description:</strong>
                                <asp:DropDownList runat="server" ID="disabilityDescription" CssClass="form-control"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter Disability Registration Code</p>
                            <div class="form-group"><strong>Disability Registration Code:</strong><asp:TextBox runat="server" CssClass="form-control" placeholder="Disability Registration Code" ID="disabilityCode" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter student Ethnic Background</p>
                            <div class="form-group">
                                <strong>Ethnic Background:</strong>
                                <asp:DropDownList runat="server" ID="ethnicBackground" CssClass="form-control"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please select student program</p>
                            <div class="form-group"><strong>Program:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="program" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter student Date of Admission</p>
                            <div class="form-group"><strong>Date of Admission:</strong><asp:TextBox runat="server" CssClass="form-control bootstrapdatepicker" placeholder="Date of Admission" ID="dateOfAdmission" />
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please  select student sponsorship</p>
                            <div class="form-group"><strong>Sponsorship:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="sponsorship" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>*Please select student Campus</p>
                            <div class="form-group"><strong>Campus:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="campus" />
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter student residential status</p>
                            <div class="form-group"><strong>Residential Status:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="residents" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>*Please select student current status</p>
                            <div class="form-group"><strong>Student Status:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="studentstatus" />
                            </div>
                        </div>
                         <div class="col-md-6 col-lg-6" style="display:none">
                            <p>*Please select submission type</p>
                            <div class="form-group"><strong>Submission Types:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="submissioncategory" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Submit Student" OnClick="addstudentsDetails_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
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
                                <%
                                    int students = 0; /*new Config().ObjNav().FnGetUniversityTotalStudents(Convert.ToString(Session["UniversityCode"]));*/
                                %>
                                <% =students %>
                            </div>
                            <div>Students Enrolled</div>
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
                                    int campus1 = 0; /*new Config().ObjNav().FnGetUniversityTotalUniversityCampuses(Convert.ToString(Session["UniversityCode"]));*/
                                %>
                                <% =campus1 %>
                            </div>
                            <div>Campuses</div>
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
                                    int programs1 = 0;/* new Config().ObjNav().FnGetUniversityTotalUniversityProgrammes(Convert.ToString(Session["UniversityCode"]));*/
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
                                    int disability = 0;/*new Config().ObjNav().FnGetUniversityPWDTotalStudents(Convert.ToString(Session["UniversityCode"]));*/
                                %>
                                <% =disability %>
                            </div>
                            <div>PWD Students</div>
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
    <div class="row">
        <div class="col-md-4 col-lg-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <i class="fa fa-bar-chart-o fa-fw"></i>Students Enrollment Distribution by Gender

                </div>
                <div class="panel-body">
                    <div id="gender-chart" style="position: center; right: 0px; top: 0px;"></div>
                </div>
            </div>

        </div>
        <div class="col-md-4 col-lg-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <i class="fa fa-bar-chart-o fa-fw"></i>Students Enrollment Distribution by Year

                </div>
                <div class="panel-body">
                    <div id="year-chart" style="position: center; right: 0px; top: 0px;"></div>
                </div>
            </div>

        </div>
        <div class="col-md-4 col-lg-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <i class="fa fa-bar-chart-o fa-fw"></i>Students Enrollment Distribution by Sponsors

                </div>
                <div class="panel-body">
                    <div id="sponsor-chart" style="position: center; right: 0px; top: 0px;"></div>
                </div>
            </div>

        </div>
    </div>
    <div>
        <%--<div class="row">
            <div class="col-md-12 col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        University Students Currently on Session
                    </div>
                    <div class="panel-body">
                        <table class="table table-bordered table-striped dataTable2">
                            <thead>
                                <tr>
                                    <th>Student ID</th>
                                    <th>Admission No</th>
                                    <th>Student Name</th>
                                    <th>Year of Study</th>
                                    <th>Gender</th>
                                    <th>Sponsorship</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    var studentsdetails = nav.University_Students_Profile.Where(r => r.University_No == Convert.ToString(Session["UniversityCode"]) && r.Current_profile == true);
                                    foreach (var studentsdetail in studentsdetails)
                                    {
                                %>
                                <tr>
                                    <td><%=studentsdetail.Student_ID_Passport %></td>
                                     <td><%=studentsdetail.Admission_Number %></td>
                                    <td><%=studentsdetail.First_Name+" "+studentsdetail.Middle_Name+" "+studentsdetail.Surname %></td>
                                    <td><%=studentsdetail.Year_of_Study %></td>
                                    <td><%=studentsdetail.Gender %></td>
                                    <td><%=studentsdetail.Sponsorship %></td>

                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>--%>

    </div>
<%--     <script>
        function editLand(landCode, campus, ownershipStatus, landSize, lrNumber) {
            document.getElementById("MainContent_editLandCode").value = landCode;
            document.getElementById("MainContent_editCampus").value = campus;
            document.getElementById("MainContent_editOwnershipStatus").value = ownershipStatus;
            document.getElementById("MainContent_editLandSize").value = landSize;
            document.getElementById("MainContent_editLRNumber").value = lrNumber;
            $("#editLandModal").modal();
        }
    </script>--%>
    <script>
        $(document).ready(function() {
            $('#dataTable2').DataTable({
                responsive: true
            });
        });
    </script>
    <%
        } %>
    <div id="deleteStudentModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting Student</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the Student <strong id="studentname"></strong>?</p>
                    <asp:TextBox runat="server" ID="removestudentCode" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Student" OnClick="deleteStudent_Click" />
                </div>
            </div>

        </div>
    </div>
    <script src="js/http_ajax.googleapis.com_ajax_libs_jquery_3.2.1_jquery.min.js"></script>
    <script src="js/http_cdnjs.cloudflare.com_ajax_libs_popper.js_1.12.6_umd_popper.js"></script>
    <script src="js/http_maxcdn.bootstrapcdn.com_bootstrap_4.0.0-beta.2_js_bootstrap.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="js/http_rawgit.com_eligrey_FileSaver.js_master_FileSaver.js"></script>
    <script src="js/http_unpkg.com_xlsx_dist_xlsx.full.min.js"></script>
    <script src="js/excel_uploader.js"></script>
    <script src="js/excel_uploader1.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://github.com/eligrey/Blob.js"></script>
    <script src="https://rawgit.com/eligrey/FileSaver.js/src/FileSaver.js"></script>
    <script src="js/FileSaver.js"></script>
    <script src="https://unpkg.com/xlsx/dist/xlsx.full.min.js"></script>

    <script>
        $(document).ready(function () {
            new ExcelUploader({
                maxInAGroup: 100,
                serverColumnNames: ["100"],
                importTypeSelector: "#dataType",
                fileChooserSelector: "#fileUploader",
                outputSelector: "#tableOutput",
                extraData: { _token: "23333323323223323232" },
                receiverUrl: ["addStudent"],
                username: "<% = Session["Code"] %>",
            password: "<% =Session["Password"] %>"
        });
        loadData();
    });
    </script>
   <%-- <script>
        function loadData() {
            var userType = "<% = userType %>";
          if (userType == "Data Officer") {
              $.ajax({
                  url: "<% =Config.Receiver() %>/getStudents?userId=<% =Convert.ToString(Session["Code"])%>&&userPassword=<% =Convert.ToString(Session["Password"])%>",
                  type: "GET",
                  contentType: "application/json;charset=utf-8",
                  data: JSON.stringify("user: data"),
                  dataType: "json"
              })
                  .done(function(response) {
                      var table = $("#dataTables-example tbody");
                      for (var i = 0; i < response.length; i++) {
                          var obj = response[i]; //obj.enrolmentId
                          table.append("<tr><td>"+
                              '<input type="checkbox" class="checkboxes" id="selectedrecordid" name="selectedrecordid" value="'+ obj.idNumber +' "/>' + "</td><td>" +
                              obj.idNumber + "</td><td>" + obj.Surname + " " + obj.firstName + " " + obj.middleName + "</td><td>" + obj.gender + "</td><td>" + obj.dob + "</td><td>" + obj.myProgram + "</td><td>" + obj.sponsorship + "</td><td>" + obj.stetus + "</td>" +
                              "<td><label class='btn btn-success' onclick='edit(\"" + obj.firstName + "\", \"" + obj.middleName + "\", \"" + obj.Surname + "\", \"" + obj.idNumber + "\", \"" + obj.gender + "\", \"" + obj.dob + "\", \"" + obj.homeCounty + "\", \"" + obj.nationality + "\", \"" + obj.ethnicBackground + "\", \"" + obj.disability + "\",\"" + obj.disabilityCode + "\", \"" + obj.myProgram + "\", \"" + obj.programLevel + "\", \"" + obj.dateOfAdmission + "\", \"" + obj.yearOfStudy + "\", \"" + obj.sponsorship + "\", \"" + obj.campus + "\", \"" + obj.admNo + "\",\"" + obj.residents + "\",\"" + obj.stetus + "\");'><i class='fa fa-edit'></i> Edit</label></td><td>" +
                              "<label class='btn btn-danger' onClick='deleteStudent(\"" + obj.enrolmentId + "\", \"" + obj.firstName + " " + obj.middleName + " " + obj.Surname + "\");'><i class='fa fa-trash'></i> Delete</label></td> </tr>");
                      }

                      $('#dataTables-example').DataTable({
                          responsive: true,
                      });

                  })
                  .fail(function(error) {
                      alerter("ERROR OCCURRED! " + JSON.stringify(error) + "<br/>");

                  });
          } else {
              <% var nav3 = Config.ReturnNav(); %>
      
          
          }
      }
        function alerter(message) {
            if (window.swal) {
                swal("Alert!", message, "warning");
            } else {
                alert(message);
            }
        }
        function deleteStudent(id, name) {
            document.getElementById("studentname").innerText = name;
            document.getElementById("MainContent_removestudentCode").value = id;
            $("#deleteStudentModal").modal();
        }
        function edit(firstName, middleName, lastName, idNumber, gender, dob, homeCounty, nationality, ethnicBackground, disability, disabilityCode, program, programLevel, dateOfAdmission, yearOfStudy, sponsorship, campus, admNo,residents,stetus) {
            gender = gender.trim();
            sponsorship = sponsorship.trim();
            campus = campus.trim();
            nationality = nationality.trim();
            ethnicBackground=ethnicBackground.trim();
            document.getElementById("MainContent_gender").value = gender;
            document.getElementById("MainContent_ethnicBackground").vaue=ethnicBackground;
            $('#MainContent_dob').val(dob).datepicker("update");
            var e = document.getElementById('MainContent_firstName');
            if (e) e.value = firstName;
            e = document.getElementById('MainContent_middleName');
            if (e) e.value = middleName;
            e = document.getElementById('MainContent_lastName');
            if (e) e.value = lastName;
            e = document.getElementById('MainContent_idNumber');
            if (e) e.value = idNumber;
            e = document.getElementById('MainContent_homeCounty');
            if (e) e.value = homeCounty;
            e = document.getElementById('MainContent_nationality');
            if (e) e.value = nationality;
            e = document.getElementById('MainContent_pwd');
            if (e) e.value = pwd;
            e = document.getElementById('MainContent_disabilityCode');
            if (e) e.value = disabilityCode;           
            e = document.getElementById('MainContent_disabilityDescription');
            if (e) e.value = disability;
            e = document.getElementById('MainContent_program');
            if (e) e.value = program;
            $('#MainContent_dateOfAdmission').val(dateOfAdmission).datepicker("update");
            e = document.getElementById('MainContent_yearOfStudy');
            if (e) e.value = yearOfStudy;
            e = document.getElementById('MainContent_admNo');
            if (e) e.value = admNo;
            e = document.getElementById('MainContent_sponsorship');
            if (e) e.value = sponsorship;
            e = document.getElementById('MainContent_campus');
            if (e) e.value = campus;
            e = document.getElementById('MainContent_residents');
            if (e) e.value = residents;
            e = document.getElementById('MainContent_stetus');
            if (e) e.value = stetus;
            $('#form-input').modal('show');
        }
    </script>--%>
      <script type="text/javascript">
        $(document).ready(function() {
            selected_arr=[];
            $('#checkBoxAll').click(function() {
                var checked = this.checked;
                var staffclass = new Array();
                $('input[type="checkbox"]').each(function() {
                    if(this.checked = checked){
                        staffclass.push($(this).val());
                        selected_arr.push($(this).val());
                    }
                    //get the number of checked 
                    if ($("#checkBoxAll:checked").length){
                        $("#deletealldiv").show();
                    } else {
                        $("#deletealldiv").hide();
                    }
                });
            })           
            var td2 = $(".dataTables-example")
            td2.on("change",
                "tbody tr .checkboxes",
                function () {
                    var t = jQuery(this).is(":checked"), selected_arr = [];
                    t ? ($(this).prop("checked", !0), $(this).parents("tr").addClass("active"))
                        : ($(this).prop("checked", !1), $(this).parents("tr").removeClass("active"));
                    // Read all checked checkboxes
                    $("input:checkbox[class=checkboxes]:checked").each(function () {
                        selected_arr.push($(this).val());
                    });

                    if (selected_arr.length > 0) {
                        $("#deletealldiv").css("display", "block");

                    } else {
                        $("#deletealldiv").css("display", "none");
                        selected_arr = [];
                    }
                    selected_arr.shift();
                });
          
            $(".deletestudentsdata").on("click",
                function (e) {
                    e.preventDefault();                   
                    // Read all checked checkboxes
                    $.each($(".selectedrecordid tr.active"), function () {
                        //procurement category
                        var checkbox_value = $('#goodselected').val();
                        selected_arr.push($(this).find('input[type=checkbox]').val());
                        // $(this).find('td').eq(2).text()
                    });
                    var postData = {
                        AllSelectedCategories: selected_arr
                    };     
                    console.log(JSON.stringify(postData))
                 
                    Swal.fire({
                        title: "Confirm Students Deletion?",
                        text: "Are you sure you would like to proceed with submission?",
                        type: "warning",
                        showCancelButton: true,
                        closeOnConfirm: true,
                        confirmButtonText: "Yes, Proceed!",
                        confirmButtonClass: "btn-success",
                        confirmButtonColor: "#008000",
                        position: "center"
                    }).then((result) => {
                        if (result.value) {
                            $.ajax({
                                url: "Students.aspx/DeleteAllStudents",
                                type: "POST",
                                data: '{postData: ' + JSON.stringify(postData) + '}',
                                contentType: "application/json",
                                cache: false,
                                processData: false
                            }).done(function (status) {
                                var obj = status.d;
                                switch (obj) {
                                    case "success":
                                        Swal.fire
                                        ({
                                            title: "Selected Students Records Deleted!",
                                            text:  "University Students Details have been successfully Deleted!",
                                            type: "success"
                                        }).then(() => {
                                            $("#deletallfeedback").css("display", "block");
                                            $("#deletallfeedback").css("color", "green");
                                            $('#deletallfeedback').attr("class", "alert alert-success");
                                            $("#deletallfeedback").html("University Students Details have been successfully Deleted!");
                                            $("#deletallfeedback").css("display", "block");
                                            $("#deletallfeedback").css("color", "green");
                                            $("#deletallfeedback").html("University Students Details have been successfully Deleted!");
                                            $("#deletallfeedback").reset();
                                        });
                                        selected_arr = [];
                                        window.location = "Students.aspx";
                                        break;
                                    default:
                                        Swal.fire
                                        ({
                                            title: "Students Deletion Error!!!",
                                            text: "University Students Details could not Deleted!",
                                            type: "error"
                                        }).then(() => {
                                            $("#deletallfeedback").css("display", "block");
                                            $("#deletallfeedback").css("color", "red");
                                            $('#deletallfeedback').addClass('alert alert-danger');
                                            $("#deletallfeedback").html("University Students Details Could not be Deleted!.Kindy Try Again Later");
                                        });
                                        selected_arr = [];
                                        break;
                                }
                            }
                            );
                        } else if (result.dismiss === Swal.DismissReason.cancel) {
                            Swal.fire(
                                'Students Deletion Cancelled',
                                'You cancelled your Students deletion details!',
                                'error'
                            );
                        }
                    });

                });
        });
    </script>
    <script type="text/javascript" src="js/loader.js"></script>
    <link type="text/css" href="dataTables/dataTables.alphabetSearch.css" rel="stylesheet" />
    <script type="text/javascript" src="js/dataTables.alphabetSearch.min.js"></script>

 
</asp:Content>
