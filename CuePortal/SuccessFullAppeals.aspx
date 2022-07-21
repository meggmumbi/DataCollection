<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/DataCollectionMaster.Master" CodeBehind="SuccessFullAppeals.aspx.cs" Inherits="CicPortal.SuccessFullAppeals" %>

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
                    <p>*Please click Download Students Discipline Data Template to download formatted excel template</p>
                    <div class="panel-heading">Excel Upload</div>

                    <div class="panel-body">
                        <a href="templates/Successful Appeals.xlsx"><i class="fa fa-file-excel-o"></i>Download Students Successful Appeals Data Template</a>
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
                    <p>*Please Click Add Successful Appeals Cases to add students Appeals manually</p>
                    <div class="panel-heading">Form Upload</div>
                    <div class="panel-body">
                        <label class="btn btn-success" data-toggle="modal" data-target="#form-input"><i class="fa fa-plus fa-fw"></i>Add Successful Appeals</label>
                    </div>
                </div>

            </div>
        </div>
        <div runat="server" id="feedback"></div>
        <div id="tableOutput">
        </div>

        <div class="panel panel-default">
            <p>*List of All uploaded Successful Appeals students cases</p>
            <div class="panel-heading">All Successful Appeals Cases</div>
            <div class="panel-body">
                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                    <thead>
                        <tr>
                            <th>Case Reference ID</th>
                            <th>Student Id</th>
                            <th>Student Name</th>
                            <th>Case Description</th>
                            <th>Verdict</th>
                            <th>Verdict Date</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
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

        <div class="panel panel-default">
            <p>*List of All uploaded Successful Appeals students cases</p>
            <div class="panel-heading">All Successful Appeals Cases</div>
            <div class="panel-body">
                <table class="table table-striped table-bordered table-hover" id="dataTables-examples">
                    <thead>
                        <tr>
                            <th>Case Reference ID</th>
                            <th>Student Id</th>
                            <th>Student Name</th>
                            <th>Case Description</th>
                            <th>Verdict</th>
                            <th>Verdict Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var nav1 = Config.ReturnNav();
                            var disciplines = nav.DisciplineCases.Where(r => r.University == Convert.ToString(Session["UniversityCode"]) && r.Type == "Appeal");
                            foreach (var discipline in disciplines)
                            {
                        %>
                        <tr>
                            <td><%=discipline.Case_Reference_No %></td>
                            <td><%=discipline.Student_Id %></td>
                            <td><%=discipline.First_Name+" "+discipline.Middle_Name+" " +discipline.Last_Name%></td>
                            <td><%=discipline.Case_Description%></td>
                            <td><%=discipline.Date%></td>
                            <td><%=discipline.Verdict_Category%></td>
                            <td><%=discipline.Verdict_Date%></td>
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
                $('#dataTables-example').DataTable({
                    responsive: true
                });
            });
        </script>
        <%
            }
        %>
        <div id="studentUpload" class="modal fade" role="dialog">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Uploading Succesful Appeals Cases</h4>
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
                        <h4 class="modal-title">Add Successful Appeals Cases</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <p>*Please enter the Case Reference Number</p>
                            <strong>Case Reference Number:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" placeholder="Case Reference Number" ID="casereferenceid" />
                        </div>
                        <div class="form-group">
                            <p>*Please enter the student ID Number/Passport Number</p>
                            <strong>Student ID/Passport No.:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" placeholder="Student Id" ID="studentId" />
                        </div>
                        <div class="form-group">
                            <p>*Please enter the student admission Number</p>
                            <strong>Student Admission:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" placeholder="Student Admission" ID="studentAdm" />
                        </div>
                        <div class="form-group">
                            <p>*Please enter the student First Name</p>
                            <strong>Student First Name:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" placeholder="Student First Name" ID="studentFirstName" />
                        </div>
                        <div class="form-group">
                            <p>*Please enter the stuent Middle Name</p>
                            <strong>Student Middle Name:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" placeholder="Student Middle Name" ID="studentMiddleName" />
                        </div>
                        <div class="form-group">
                            <p>*Please enter the student Last Name</p>
                            <strong>Student Last Name:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" placeholder="Student Last Name" ID="studentLastName" />
                        </div>
                        <div class="form-group">
                            <p>*Please enter the student case description</p>
                            <strong>Case Description:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" placeholder="Case Description" ID="caseDescription" TextMode="MultiLine" />
                        </div>
                        <div class="form-group">
                            <p>*Please enter the student case date</p>
                            <strong>Case Date:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" placeholder="Case Date" ID="caseDate" TextMode="Date" Style="padding-top: 0px;" />
                        </div>
                        <div class="form-group">
                            <p>*Please enter the student case verdict </p>
                            <strong>Verdict:</strong>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="verdict"></asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <p>*Please enter the student case verdict Date</p>
                            <strong>Verdict Date:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="verdictDate" TextMode="Date" Style="padding-top: 0px;" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Submit Case Appeals" ID="submit" OnClick="submit_Click" />
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>

            </div>
        </div>


        <div id="form-input1" class="modal fade" role="dialog">
            <div class="modal-dialog modal-lg">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header" style="background-color: #5cb85c">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Update Students Appeals Case Details</h4>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="caseid" type="hidden" />
                        <div class="form-group">
                            <p>*Please enter the Case Reference Number</p>
                            <strong>Case Reference Number:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" placeholder="Case Reference Number" ID="casereferenceNo" />
                        </div>
                        <div class="form-group">
                            <p>*Please enter the student ID Number/Passport Number</p>
                            <strong>Student ID/Passport No:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" placeholder="Student Id" ID="studentsid" />
                        </div>
                        <div class="form-group">
                            <p>*Please enter the student Name</p>
                            <strong>Student Name:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" placeholder="Student Name" ID="studentName" ReadOnly="True" />
                        </div>
                        <div class="form-group">
                            <p>*Please enter the student Case Description</p>
                            <strong>Case Description:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" placeholder="Case Description" ID="caseDescription1" TextMode="MultiLine" />
                        </div>
                        <div class="form-group">
                            <p>*Please enter the student case Date</p>
                            <strong>Case Date:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" placeholder="Case Date" ID="caseDate1" TextMode="Date" Style="padding-top: 0px;" />
                        </div>
                        <div class="form-group">
                            <p>*Please enter the student case verdict</p>
                            <strong>Verdict:</strong>
                            <asp:DropDownList runat="server" CssClass="form-control" placeholder="Verdict" ID="verdict1" />
                        </div>
                        <div class="form-group">
                            <p>*Please enter the student verdict date</p>
                            <strong>Verdict Date:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="verdictDate1" TextMode="Date" Style="padding-top: 0px;" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Update Appeal Case" ID="editSubmit" OnClick="edit_Click" />
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="deleteFullAppealsModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting Successfull Appeal</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the  Successfull Appeal for <strong id="appealsToDelete"></strong>?</p>
                    <asp:TextBox runat="server" ID="removeappealCode" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Appeal" OnClick="deleteAppeals_Click" />
                </div>
            </div>
        </div>
    </div>

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

    <script>
        $(document).ready( function () {
            new ExcelUploader({
                maxInAGroup: 100,
                serverColumnNames: ["100"],
                importTypeSelector: "#dataType",
                fileChooserSelector: "#fileUploader",
                outputSelector: "#tableOutput",
                extraData: { _token: "23333323323223323232" },
                receiverUrl: ["addAppealsCase"],
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
                  url: "<% =Config.Receiver() %>/getAppeals?userCode=<% =Convert.ToString(Session["Code"])%>&&password=<% =Convert.ToString(Session["Password"])%>",
                  type: "GET",
                  contentType: "application/json;charset=utf-8",
                  data: JSON.stringify("user: data"),
                  dataType: "json"
              })
          .done(function (response) {
              var table = $("#dataTables-example tbody");
              for (var i = 0; i < response.length; i++) {
                  var obj = response[i];//obj.enrolmentId
                  table.append("<tr><td>" +
                    obj.CaseReferenceNo + "</td><td>" + obj.StudentId + "</td><td>" + obj.StudentName + "</td><td>" + obj.CaseDescription + "</td><td>" + obj.Verdict + "</td><td>" + obj.VerdictDate + "</td></td>" +
                    "<td><label class='btn btn-success' onclick='" +
                    "edit(\"" + obj.AppealId  + "\",\"" + obj.CaseReferenceNo + "\", \"" + obj.StudentId + "\", \"" + obj.StudentName + "\",\"" + obj.CaseDescription + "\", \"" + obj.Verdict + "\", \"" + obj.VerdictDate + "\",\"" + obj.CaseDate + "\");" +
                    "'><i class='fa fa-edit'></i> Edit</label></td><td>" +
                    "<label class='btn btn-danger' onclick=' deleteAppeals(\"" + obj.AppealId + "\", \"" + obj.StudentName + "\");'><i class='fa fa-trash'></i> Delete</label></td> </tr>");
              }
              $('#dataTables-example').DataTable({
                  responsive: true
              });
         
        
          })
          .fail(function (error) {
              alerter("ERROR OCCURRED! " + JSON.stringify(error) + "<br/>");
         
          });
          } 
        
      }
        function alerter(message) {
            if (window.swal) {
                swal("Alert!", message, "warning");
            } else {
                alert(message);
            }
        }
    
        function deleteAppeals(id, name) {
            document.getElementById("appealsToDelete").innerText = name;
            document.getElementById("MainContent_removeappealCode").value = id;
            $("#deleteFullAppealsModal").modal();
        }
        function edit(caseId,caserefence, studentId, studentName, description, verdict, verdictDate,casedate) {
            document.getElementById('MainContent_caseid').value = caseId;
            document.getElementById('MainContent_casereferenceNo').value = caserefence;
            document.getElementById('MainContent_studentName').value = studentName;
            document.getElementById('MainContent_studentsid').value = studentId;
            document.getElementById('MainContent_caseDescription1').value = description;
            $('#MainContent_caseDate1').val(casedate).datepicker("update");
            document.getElementById('MainContent_verdict1').value = verdict;
            document.getElementById('MainContent_verdictDate1').value = verdictDate;
            $('#form-input1').modal('show');
        }
    </script>
</asp:Content>
