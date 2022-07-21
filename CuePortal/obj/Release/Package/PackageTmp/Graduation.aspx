<%@ Page Title="" Language="C#" MasterPageFile="~/DataCollectionMaster.Master" AutoEventWireup="true" CodeBehind="Graduation.aspx.cs" Inherits="CicPortal.Graduation" %>

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
                    <p>*Please Click Download Graduation Data Template to download student graduation formatted excel template</p>
                    <div class="panel-heading">Excel Upload</div>

                    <div class="panel-body">
                        <a href="templates/Graduation.xlsx"><i class="fa fa-file-excel-o"></i>Download Graduation Data Template</a>
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
                    <p>*Please Click Add Graduation Entry to add graduation details manually</p>
                    <div class="panel-heading">Form Upload</div>
                    <div class="panel-body">
                        <label class="btn btn-success" data-toggle="modal" data-target="#form-input"><i class="fa fa-plus fa-fw"></i>Add  Graduation </label>
                    </div>
                </div>

            </div>
        </div>
        <div runat="server" id="feedback"></div>
        <div id="tableOutput">
        </div>

        <div class="panel panel-default">
            <p>*List of all graduation Details Uploaded.</p>
            <div class="panel-heading">Graduation</div>
            <div class="panel-body">
                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                    <thead>
                        <tr>
                            <th>Student ID</th>
                            <th>Admission No</th>
                            <th>Student Name</th>
                            <th>Programme</th>
                            <th>Award</th>
                            <th>Graduation Date</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
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
                    <h4 class="modal-title">Add Graduation Details</h4>
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
                    <h4 class="modal-title">Add Graduation </h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter student Id No/Birth Certificate No./Passport Number</p>
                            <div class="form-group"><strong>Student Id No/Birth Cert/ Passport:</strong><asp:TextBox runat="server" CssClass="form-control" ID="studentId" placeholder="Student Id No/Birth Cert/ Passport" />
                            </div>

                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter student Admission Number</p>
                            <div class="form-group"><strong>Admission No:</strong><asp:TextBox runat="server" CssClass="form-control" ID="admNo" placeholder="Admission Number" />
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter student first name</p>
                            <div class="form-group"><strong>First Name:</strong><asp:TextBox runat="server" CssClass="form-control" ID="firstName" placeholder="First Name" />
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter student middle name</p>
                            <div class="form-group"><strong>Middle Name:</strong><asp:TextBox runat="server" CssClass="form-control" ID="middleName" placeholder="Middle Name" />
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter student Last name</p>
                            <div class="form-group"><strong>Last Name:</strong><asp:TextBox runat="server" CssClass="form-control" ID="lastName" placeholder="Last Name" />
                            </div>
                        </div>

                        <div class="col-md-6 col-lg-6">
                            <p>*Please select student programme</p>
                            <div class="form-group"><strong>Programme:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="program" />
                            </div>

                        </div>


                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>Please enter student Award</p>
                            <div class="form-group"><strong>Award:</strong><asp:TextBox runat="server" CssClass="form-control" placeholder="Award" ID="credit" />
                            </div>

                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter student graduation Date</p>
                            <div class="form-group"><strong>Graduation Date:</strong><asp:TextBox runat="server" CssClass="form-control bootstrapdatepicker" placeholder="Graduation Date" ID="graduationDate" />
                            </div>
                        </div>

                    </div>
                   <%-- <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>Please Select the Student Gender</p>
                            <div class="form-group"><strong>Gender:</strong><asp:DropDownList runat="server" CssClass="form-control" placeholder="Gender" ID="gender" /></DropDownList>
                            </div>

                        </div>
                    </div>--%>
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Add Graduation Details" OnClick="addGraduation_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>
    <div id="editGraduation" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header" style="background-color:#5cb85c">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit Students Graduation Details</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter student Id Number/Birth Certicate Number/Passport Number</p>
                            <div class="form-group"><strong>Student Id No/Birth Cert/ Passport:</strong><asp:TextBox runat="server" CssClass="form-control" ID="editStudentId" placeholder="Student Id No/Birth Cert/ Passport" />
                            </div>
                             </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter student Admission Number</p>
                            <div class="form-group"><strong>Admission No:</strong><asp:TextBox runat="server" CssClass="form-control" ID="editAdmNo" placeholder="Admission Number" />
                            </div>
                        </div>
                       </div>
                      <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter student First Name</p>
                            <div class="form-group"><strong>First Name:</strong><asp:TextBox runat="server" CssClass="form-control" ID="editFirstName" placeholder="First Name" />
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter student Middle Name</p>
                            <div class="form-group"><strong>Middle Name:</strong><asp:TextBox runat="server" CssClass="form-control" ID="editMiddleName" placeholder="Middle Name" />
                            </div>
                        </div>
                      </div>
                      <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter student Last Name</p>
                            <div class="form-group"><strong>Last Name:</strong><asp:TextBox runat="server" CssClass="form-control" ID="editLastName" placeholder="Last Name" />
                            </div>
                        </div>
                     
                        <div class="col-md-6 col-lg-6">
                            <p>*Please select student Programme</p>
                            <div class="form-group"><strong>Programme:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="editProgram" />
                            </div>
                        </div>
                       </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter student Award</p>
                            <div class="form-group"><strong>Award:</strong><asp:TextBox runat="server" CssClass="form-control" placeholder="Credit" ID="editCredit" />
                            </div>

                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter student Graduation Date</p>
                            <div class="form-group"><strong>Graduation Date:</strong><asp:TextBox runat="server" CssClass="form-control bootstrapdatepicker" placeholder="Graduation Date" ID="editGraduationDate" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Save Changes" OnClick="EditGraduation_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
          </div>
        </div>
  <div id="deleteGraduationModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Deleting Student Graduation</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the Graduation for <strong id="studentname"></strong> ?</p>
          <asp:TextBox runat="server" ID="removeentryCode" type="hidden"/>
           <asp:TextBox runat="server" ID="removeadmission" type="hidden"/>
           <asp:TextBox runat="server" ID="removestudentid" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Graduation Details" OnClick="deleteGraduation_Click" />
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
                                    int programs1 = new Config().ObjNav().FnGetUniversityTotalUniversityProgrammes(Convert.ToString(Session["UniversityCode"]));
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
                                    int disability = new Config().ObjNav().FnGetUniversityPWDTotalStudents(Convert.ToString(Session["UniversityCode"]));
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
    <div class="row">
        <div class="col-md-4 col-lg-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <i class="fa fa-bar-chart-o fa-fw"></i>Students Enrollment Distribution by Year

                </div>
                <div class="panel-body">
                    <div id="campus-chart" style="position: center; right: 0px; top: 0px;"></div>
                </div>
            </div>

        </div>
        <div class="col-md-4 col-lg-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <i class="fa fa-bar-chart-o fa-fw"></i>Student Enrolment by Sponsorship
                </div>
                <div class="panel-body">
                    <div id="learning-chart"></div>

                </div>
            </div>

        </div>
        <div class="col-md-4 col-lg-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <i class="fa fa-bar-chart-o fa-fw"></i>Students Distribution by Program Levels
                </div>
                <div class="panel-body">
                    <div id="program-chart"></div>

                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 col-lg-12">
            <div class="panel panel-green">
                <div class="panel-heading">
                   List of University Students Graduations 
                </div>
                <div class="panel-body">
                    <table class="table table-bordered table-striped dataTable2">
                        <thead>
                            <tr>
                                <th>Campus Code</th>
                                <th>Campus Name</th>
                                <th>No. of Graduating Students</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%

                                var campuses = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                                foreach (var campus in campuses)
                                {
                            %>
                            <tr>
                                <td><%=campus.No %></td>
                                <td><%=campus.Description %></td>
                                <td><% = nav.PartTime.Where(r=>r.University_Code==Convert.ToString(Session["UniversityCode"])&&r.Campus==campus.No).ToList().Count %></td>
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
    <%
        } %>
    <script>
        $(document).ready(function() {
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

    <script>
        $(document).ready( function () {
            new ExcelUploader({
                maxInAGroup: 100,
                serverColumnNames: ["100"],
                importTypeSelector: "#dataType",
                fileChooserSelector: "#fileUploader",
                outputSelector: "#tableOutput",
                extraData: {_token: "23333323323223323232"},
                receiverUrl: ["addGraduation"],
                username: "<% = Session["Code"] %>",
            password: "<% =Session["Password"] %>"
        });
        loadData();
    });
    </script>
    <script>
        function loadData() {
            var userType = "<% = userType %>";
            if (userType == "Data Officer") {
              $.ajax({
                  url: "<% =Config.Receiver() %>/getGraduation?userCode=<% =Convert.ToString(Session["Code"])%>&&password=<% =Convert.ToString(Session["Password"])%>",
                  type: "GET",
                  contentType: "application/json;charset=utf-8",
                  data: JSON.stringify("user: data"),
                  dataType: "json"
              })
          .done(function (response) {
              var table = $("#dataTables-example tbody");
              for (var i = 0; i < response.length; i++) {
                  var obj = response[i];
                  table.append("<tr><td>" + obj.StudentId + "</td><td>" + obj.AdmissionNo + "</td><td>" + obj.LastName + " " + obj.FirstName + " " + obj.MiddleName + "</td><td>" + obj.ProgramName + "</td><td>" + obj.Credit + "</td><td>" +  obj.GraduationDate + "</td>"+
                       "<td><label class='btn btn-success' " +
                                  "onclick='edit(\"" + obj.StudentId + "\",\"" + obj.AdmissionNo + "\",\"" + obj.LastName + "\", \" " + obj.FirstName + "\", \" " + obj.MiddleName + "\",\" " + obj.ProgramName + "\",\" " + obj.Credit + "\", \" " + obj.GraduationDate + "\");'><i class='fa fa-edit'></i> Edit</label></td><td>" +
                                  "<label class='btn btn-danger' onclick='deleteGraduation(\"" + obj.Id + "\",\"" + obj.AdmissionNo + "\",\"" + obj.StudentId + "\");'><i class='fa fa-trash'></i> Delete</label></td> </tr>");
                 
              }
              $('#dataTables-example').DataTable({
                  responsive: true
              });
              // alerter("ERROR OCCURRED! ");
              /* $.each(data, function (idx, elem) {
            
                });*/

          })
          .fail(function (error) {
              alerter("ERROR OCCURRED! " + JSON.stringify(error) + "<br/>");

          });
          } else {
              <% var nav2 = Config.ReturnNav(); %>
          
          }
      }
        function alerter(message) {
            if (window.swal) {
                swal("Alert!", message, "warning");
            } else {
                alert(message);
            }
        }
        function deleteGraduation(entry,admission,studentsid) {
            document.getElementById("studentname").innerText = admission;
            document.getElementById("MainContent_removeentryCode").value = entry;
            document.getElementById("MainContent_removeadmission").value = admission;
            document.getElementById("MainContent_removestudentid").value = studentsid;
            $("#deleteGraduationModal").modal();
        }
        function edit(studentid, admission, lastname, firstname, middlename, programme, award, graduation) {
            document.getElementById("MainContent_editStudentId").value = studentid.trim();
            document.getElementById("MainContent_editAdmNo").value = admission.trim();
            document.getElementById("MainContent_editFirstName").value = firstname.trim();
            document.getElementById("MainContent_editLastName").value = lastname.trim();
            document.getElementById("MainContent_editMiddleName").value = middlename.trim();
            document.getElementById("MainContent_editProgram").value = programme.trim();
            document.getElementById("MainContent_editCredit").value = award.trim();
            $('#MainContent_editGraduationDate').val(graduation).datepicker("update");
            $('#editGraduation').modal('show');
        }
    </script>

</asp:Content>
