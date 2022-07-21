<%@ Page Title="" Language="C#" MasterPageFile="~/DataCollectionMaster.Master" AutoEventWireup="true" CodeBehind="LibraryStaff.aspx.cs" Inherits="CicPortal.LibraryStaff" %>

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
                    <p>*Please click Download Excel Template to download library staff formatted excel template</p>
                    <div class="panel-heading">Excel Upload</div>

                    <div class="panel-body">
                        <a href="templates\Library Staff.xlsx"><i class="fa fa-file-excel-o"></i>Download Library Staff Excel Template</a>
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
                    <div class="panel-heading">Form Upload</div>
                    <div class="panel-body">
                        <label class="btn btn-success" data-toggle="modal" data-target="#form-input"><i class="fa fa-plus fa-fw"></i>Add Library Staff</label>
                    </div>
                </div>

            </div>
        </div>
        <div runat="server" id="feedback"></div>
        <div id="deletallfeedback" style="display: none" data-dismiss="alert"></div>
        <div id="tableOutput">
        </div>

        <div class="panel panel-default">
            <p>*List of All Uploaded Library Staff details</p>
            <div class="panel-heading">All Library Staff</div>
            <div class="panel-body">
                <div style="display: none;background-color:antiquewhite" id="deletealldiv" >
                   <center><button type="button" class="btn btn-danger deletestaffdata" id="deletestaffdata" name="deletestaffdata">Delete Selected Library Staff Records</button></center> 
                </div>
                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="checkBoxAll" name="checkBoxAll" class="custom-checkbox" /></th>
                            <th>National Id</th>
                            <th>Staff Name</th>
                            <th>Date of Birth</th>
                            <th>Position in the Library</th>
                            <th>Highest Academic Qualification</th>
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
<div id="menu1" class="tab-pane fade">
    <div class="row">
            <div class="col-md-6 col-lg-6">
                <div class="panel panel-default">
                    <p>*Please click Download Excel Template to download library staff formatted excel template</p>
                    <div class="panel-heading">Excel Upload</div>

                    <div class="panel-body">
                        <a href="templates\Library Staff.xlsx"><i class="fa fa-file-excel-o"></i>Download Library Staff Excel Template</a>
                        <div class="form-group">
                            <select class="form-control" id="dataType2" style='display: none;'>
                                <option value="-1" disabled selected>Select Data to Import</option>
                                <option selected value="">Import Posts Data</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <input type="file" id="fileUploader2" class="btn btn-fill btn-primary btn-large" />
                        </div>
                    </div>
                </div>

            </div>
            <div class="col-md-6 col-lg-6">
                <div class="panel panel-default">
                    <div class="panel-heading">Form Upload</div>
                    <div class="panel-body">
                        <label class="btn btn-success" data-toggle="modal" data-target="#form-input"><i class="fa fa-plus fa-fw"></i>Add Library Staff</label>
                    </div>
                </div>

            </div>
        </div>
        <div runat="server" id="feedback2"></div>
        <div id="tableOutput2">
        </div>
        <div class="panel panel-default">
            <p>*List of All Uploaded Library Staff details</p>
            <div class="panel-heading">All Library Staff</div>
            <div class="panel-body">
                <table class="table table-striped table-bordered table-hover" id="dataTables-example2">
                    <thead>
                        <tr>
                            <th>National Id</th>
                            <th>Staff Name</th>
                            <th>Date of Birth</th>
                            <th>Position in the Library</th>
                            <th>Highest Academic Qualification</th>
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
    <%
        }
    %>
    <div id="form-input" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Add Library Staff</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter the Library staff ID Number/Passport Number</p>
                            <div class="form-group"><strong>ID Number/Passport No:</strong><asp:TextBox runat="server" CssClass="form-control" placeholder="ID Number/Passport No" ID="idNumber" />
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter the Library Staff First Name</p>
                            <div class="form-group"><strong>First Name:</strong><asp:TextBox runat="server" CssClass="form-control" placeholder="First Name" ID="firstName" />
                            </div>
                        </div>
                    </div>
                    <div class="row">

                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter the library staff Middle Name</p>
                            <div class="form-group"><strong>Middle Name:</strong><asp:TextBox runat="server" CssClass="form-control" placeholder="Middle Name" ID="middleName" />
                            </div>

                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter the Library Staff Last Name</p>
                            <div class="form-group"><strong>Last Name:</strong><asp:TextBox runat="server" CssClass="form-control" placeholder="Last Name" ID="lastName" />
                            </div>
                        </div>
                    </div>

                    <div class="row">


                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter the Library Staff Date of Birth</p>
                            <div class="form-group"><strong>Date of Birth:</strong><asp:TextBox runat="server" CssClass="form-control bootstrapdatepicker" placeholder="Date of Birth" ID="dob" />
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter the Library Staff Position in the Library</p>
                            <div class="form-group"><strong>Position in the Library:</strong><asp:TextBox runat="server" CssClass="form-control" ID="position" placeholder="Position in the Library" />
                            </div>
                        </div>
                    </div>


                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter the Library staff Highest Academic Qualification</p>
                            <div class="form-group"><strong>Highest Academic Qualification:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="highestAcademicQualification" />
                            </div>

                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please select the Campus Name</p>
                            <div class="form-group"><strong>Campus:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="campus" />
                            </div>

                        </div>

                    </div>
                     <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter the Library staff  Payroll Number</p>
                            <div class="form-group"><strong>Payroll Number:</strong><asp:TextBox runat="server" CssClass="form-control" ID="staffpayroll" />
                            </div>

                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please Select the  Ethnic Background</p>
                            <div class="form-group"><strong>Ethnic Background:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="stafethnicbackground" />
                            </div>

                        </div>

                    </div>
                     <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>*Please select Home County</p>
                            <div class="form-group"><strong>Home County:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="staffhomecounty" />
                            </div>

                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please Enter the  Date of First Appointment</p>
                            <div class="form-group"><strong>Date of First Appointment:</strong><asp:TextBox runat="server" CssClass="form-control bootstrapdatepicker" ID="staffdateoffirstappointment" />
                            </div>

                        </div>

                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>*Please select Nationality</p>
                            <div class="form-group"><strong>Nationality:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="staffNationality" />
                            </div>

                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please Enter the  Date of Current Appointment</p>
                            <div class="form-group"><strong>Date of Current Appointment:</strong><asp:TextBox runat="server" CssClass="form-control bootstrapdatepicker" ID="staffofcurrrentappointment" />
                            </div>
                        </div>
                    </div>
                     <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>*Please Enter Disability  Desciption</p>
                            <div class="form-group"><strong>Disability Description:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="disabilitydescription" />
                            </div>

                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter the Disability Registration Code</p>
                            <div class="form-group"><strong>Disability Registration Code:</strong><asp:TextBox runat="server" CssClass="form-control" ID="disabilitycode" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>*Please select the Terms of Service</p>
                            <div class="form-group"><strong>Terms of Service:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="termsofservice" />
                            </div>
                        </div>
                           <div class="col-md-6 col-lg-6">
                            <p>*Please select the Library Staff Status</p>
                            <div class="form-group"><strong>Library Staff Status:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="librarystaffstatus" />
                            </div>
                        </div>
                    </div>
                     <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>*Please select the Highest Academic Qualification Specialization</p>
                            <div class="form-group"><strong>Highest Academic Qualification Specialization:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="highestspecialization" />
                            </div>
                        </div>
                           <div class="col-md-6 col-lg-6">
                            <p>*Please select the Second  Highest Academic Qualification </p>
                            <div class="form-group"><strong>Second Highest Academic Qualification :</strong><asp:DropDownList runat="server" CssClass="form-control" ID="secondhighestcode" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                         <div class="col-md-6 col-lg-6">
                            <p>*Please select the Staff Gender</p>
                            <div class="form-group"><strong>Gender:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="staffgender" />
                            </div>
                        </div>
                          <div class="col-md-6 col-lg-6">
                            <p>*Please select the Second Highest Academic Qualification Specialization</p>
                            <div class="form-group"><strong>Second Highest Academic Qualification Specialization:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="secondhighestspecialization" />
                            </div>
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Save Changes" ID="submit" OnClick="submit_Click" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>
    <div id="deleteStaffModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting Library Staff</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the Library Staff <strong id="staffName"></strong>?</p>
                    <asp:TextBox runat="server" ID="staffIdNo" type="hidden" />
                     <asp:TextBox runat="server" ID="staffEntry" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Library Staff" OnClick="delete_Click" />
                </div>
            </div>

        </div>
    </div>
    <script>
        $(document).ready(function() {
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
    <script>
        $(document).ready( function () {
            new ExcelUploader({
                maxInAGroup: 100,
                serverColumnNames: ["100"],
                importTypeSelector: "#dataType",
                fileChooserSelector: "#fileUploader",
                outputSelector: "#tableOutput",
                extraData: { _token: "23333323323223323232" },
                receiverUrl: ["addLibraryStaff"],
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
                  url: "<% =Config.Receiver() %>/getLibraryStaff?userId=<% =Convert.ToString(Session["Code"])%>&&userPassword=<% =Convert.ToString(Session["Password"])%>",
                  type: "GET",
                  contentType: "application/json;charset=utf-8",
                  data: JSON.stringify("user: data"),
                  dataType: "json"
              })
          .done(function (response) {
              var table = $("#dataTables-example tbody");
              for (var i = 0; i < response.length; i++) {
                  var obj = response[i];            
                  table.append("<tr><td>"+
                     '<input type="checkbox" class="checkboxes" id="selectedrecordid" name="selectedrecordid" value="'+ obj.IdNo +' "/>' + "</td><td>" +
                      obj.IdNo + "</td><td>" + obj.FirstName + " " + obj.MiddleName + " " + obj.LastName + "</td><td>" + obj.DateOfBirth + "</td><td>" + obj.Position + "</td><td>" + obj.HighestAcademicQualification + "</td>" +
                      "<td><label class='btn btn-success' " +
                      "onclick='edit(\"" + obj.IdNo + "\",\"" + obj.FirstName + "\",\"" + obj.MiddleName + "\", \"" + obj.LastName + "\", \" " + obj.DateOfBirth + "\", \" " +
                      obj.Position + "\",\"" + obj.HighestAcademicQualification + "\",\"" + obj.Campus + "\",\"" + obj.EthnicBackground + "\",\" " + obj.HomeCounty + "\",\" " + obj.ProgramDomain + "\",\" "
                      + obj.DateOfCurrentAppointment +  "\",\" " + obj.DateOfFirstAppointment + "\",\" " + obj.PayrollNo + "\",\" " + obj.TermsOfService + "\",\" " + obj.Gender + "\",\" " + obj.Nationality + "\",\" " + obj.DisabilityDescription + "\",\" " + obj.DisabilityRegistrationCode + "\");'><i class='fa fa-edit'></i> Edit</label></td><td>" +
                      "<label class='btn btn-danger' onclick=' deleteStaff(\"" + obj.EntryNumber + "\",\"" + obj.FirstName + " " + obj.MiddleName + " " + obj.LastName + "\",\"" + obj.IdNo + "\");'><i class='fa fa-trash'></i> Delete</label></td> </tr>");
              }
              $('#dataTables-example').DataTable({
                  responsive: true
              });
              //(IdNumber, FirstName, MiddleName, lastName,  DateOfBirth, position, HighestAcademicQualification, Campus
              // alerter("ERROR OCCURRED! ");
              /* $.each(data, function (idx, elem) {
              (staffName, idNumber)
         
                });*/
        
          })
          .fail(function (error) {
              alerter("ERROR OCCURRED! " + JSON.stringify(error) + "<br/>");
         
          });
          } else {
              <%
             %>
          }
        }
       
        function alerter(message) {
            if (window.swal) {
                swal("Alert!", message, "warning");
            } else {
                alert(message);
            }
        }
        function deleteStudent(id, payroll,name) {
            swal({
                title: "Are you sure you want to delete " + name + "?",
                text: "Once deleted, you will not be able to recover details of the academic staff!",
                icon: "warning",
                buttons: true,
                dangerMode: true,
            })
              .then((willDelete) => {
                  if (willDelete) {
                      window.location.href = "/AcademicStaff.aspx?idNo=" + id + "&&payrollNo=" + payroll;
                      /*swal("Poof! Your imaginary file has been deleted!", {
                          icon: "success",
                      });*/
                  } /*else {
                     swal("Your imaginary file is safe!");
                 }*/
              });
        }
     
        function edit(IdNumber, FirstName, MiddleName, lastName,  DateOfBirth, position, HighestAcademicQualification, Campus,EthnicBackground,HomeCounty,ProgramDomain,DateOfCurrentAppointment,DateOfFirstAppointment,PayrollNo,TermsOfService,Gender,Nationality,DisabilityDescription,DisabilityRegistrationCode) {
            console.log(EthnicBackground);
            document.getElementById("MainContent_idNumber").value = IdNumber.trim();
            document.getElementById("MainContent_firstName").value = FirstName.trim();
            document.getElementById("MainContent_middleName").value = MiddleName.trim();
            document.getElementById("MainContent_lastName").value = lastName.trim();
            $('#MainContent_dob').val(DateOfBirth).datepicker("update");
            document.getElementById("MainContent_position").value = position.trim();
            document.getElementById("MainContent_highestAcademicQualification").value = HighestAcademicQualification.trim();
            document.getElementById("MainContent_campus").value = Campus.trim();
            document.getElementById("MainContent_stafethnicbackground").value = EthnicBackground.trim();
            document.getElementById("MainContent_staffhomecounty").value = HomeCounty.trim();
            $('#MainContent_staffofcurrrentappointment').val(DateOfCurrentAppointment).datepicker("update");
            $('#MainContent_staffdateoffirstappointment').val(DateOfFirstAppointment).datepicker("update");
            document.getElementById("MainContent_staffpayroll").value = PayrollNo.trim();
            document.getElementById("MainContent_termsofservice").value = TermsOfService.trim();
            document.getElementById("MainContent_staffgender").value = Gender.trim();
            document.getElementById("MainContent_staffNationality").value = Nationality.trim();
            document.getElementById("MainContent_disabilitydescription").value = DisabilityDescription.trim();
            document.getElementById("MainContent_disabilitycode").value = DisabilityRegistrationCode.trim();   

            $('#form-input').modal('show');
        }
        function deleteStaff(staffentry,staffName, idNumber) {
            document.getElementById("staffName").innerText = staffName;
            document.getElementById("MainContent_staffEntry").value = staffentry;
            document.getElementById("MainContent_staffIdNo").value = idNumber;

            $("#deleteStaffModal").modal();
        }
    </script>
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
          
            $(".deletestaffdata").on("click",
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
                        title: "Confirm Library Staff Deletion?",
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
                                url: "LibraryStaff.aspx/DeleteAllStaff",
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
                                            title: "Selected Library Staff Records Deleted!",
                                            text:  "University Library Staff Details have been successfully Deleted!",
                                            type: "success"
                                        }).then(() => {
                                            $("#deletallfeedback").css("display", "block");
                                            $("#deletallfeedback").css("color", "green");
                                            $('#deletallfeedback').attr("class", "alert alert-success");
                                            $("#deletallfeedback").html("University Library Staff Details have been successfully Deleted!");
                                            $("#deletallfeedback").css("display", "block");
                                            $("#deletallfeedback").css("color", "green");
                                            $("#deletallfeedback").html("University Library Staff Details have been successfully Deleted!");
                                            $("#deletallfeedback").reset();
                                        });
                                        selected_arr = [];
                                        window.location = "LibraryStaff.aspx";
                                        break;
                                    default:
                                        Swal.fire
                                        ({
                                            title: "Library Staff Deletion Error!!!",
                                            text: status,
                                            type: "error"
                                        }).then(() => {
                                            $("#deletallfeedback").css("display", "block");
                                            $("#deletallfeedback").css("color", "red");
                                            $('#deletallfeedback').addClass('alert alert-danger');
                                            $("#deletallfeedback").html("University Library Staff Details Could not be Deleted!.Kindy Try Again Later");
                                        });
                                        selected_arr = [];
                                        break;
                                }
                            }
                            );
                        } else if (result.dismiss === Swal.DismissReason.cancel) {
                            Swal.fire(
                                'Library Staff Deletion Cancelled',
                                'You cancelled your Library staff deletion details!',
                                'error'
                            );
                        }
                    });

                });
        });
    </script>
  <script type="text/javascript">

        // Load google charts
        google.charts.load('current', {'packages':['corechart']});
        google.charts.setOnLoadCallback(drawChart);
        // Draw the chart and set the chart values
        function drawChart() {
            // Create the data table.
            var data = new google.visualization.DataTable();
            data.addColumn('string', 'Topping');
            data.addColumn('number', 'Slices');
        
            var myData = {
                'Male':<% = new Config().ObjNav().FnGetUniversityTotalMaleStudents(Convert.ToString(Session["UniversityCode"]))%>,
                'Female': <% = new Config().ObjNav().FnGetUniversityTotalFemaleStudents(Convert.ToString(Session["UniversityCode"]))%>,
                'Intersex': <% = new Config().ObjNav().FnGetUniversityTotalIntersexStudents(Convert.ToString(Session["UniversityCode"]))%>,
    };
        
    var rows = [];
    for (element in myData) {
        rows.push([element + " (" + myData[element] + ")", myData[element]])
    }
    data.addRows(rows);

    // Optional; add a title and set the width and height of the chart
    var options = {'title':'Students Enrollment Distribution by Gender',
        'width':250, 
        'height':250,
        'chartArea': {'width': '80%', 'height': '80%','left': '30','top': '30'},
        'is3D': true,
        'legend': {'position': 'bottom'}
    };

    // Display the chart inside the <div> element with id="piechart"
    var chart = new google.visualization.PieChart(document.getElementById('gender-chart'));
    chart.draw(data, options);
}
 </script>
<script type="text/javascript">
        // Load google charts
        google.charts.load('current', {'packages':['corechart']});
        google.charts.setOnLoadCallback(drawChart);
        // Draw the chart and set the chart values
        function drawChart() {
            // Create the data table.
            var data = new google.visualization.DataTable();
            data.addColumn('string', 'Topping');
            data.addColumn('number', 'Slices');        
            var myData = {
                'Year1':<% = new Config().ObjNav().FnGetUniversityTotalFirstYearStudents(Convert.ToString(Session["UniversityCode"]))%>,
                'Year2': <% = new Config().ObjNav().FnGetUniversityTotalSecondYearStudents(Convert.ToString(Session["UniversityCode"]))%>,
                'Year3': <% = new Config().ObjNav().FnGetUniversityTotalThridYearStudents(Convert.ToString(Session["UniversityCode"]))%>,
                'Year4': <% = new Config().ObjNav().FnGetUniversityTotaFourthYearStudents(Convert.ToString(Session["UniversityCode"]))%>,
    };
        
    var rows = [];
    for (element in myData) {
        rows.push([element + " (" + myData[element] + ")", myData[element]])
    }
    data.addRows(rows);

    // Optional; add a title and set the width and height of the chart
    var options = {'title':'Students Enrollment Distribution by Year',
        'width':250, 
        'height':250,
        'chartArea': {'width': '80%', 'height': '80%','left': '30','top': '30'},
        'is3D': true,
        'legend': {'position': 'bottom'}
    };

    // Display the chart inside the <div> element with id="piechart"
    var chart = new google.visualization.PieChart(document.getElementById('year-chart'));
    chart.draw(data, options);
}
    </script>
 <script type="text/javascript">

        // Load google charts
        google.charts.load('current', {'packages':['corechart']});
        google.charts.setOnLoadCallback(drawChart);
        // Draw the chart and set the chart values
        function drawChart() {
            // Create the data table.
            var data = new google.visualization.DataTable();
            data.addColumn('string', 'Topping');
            data.addColumn('number', 'Slices');
        
            var myData = {
               'Government':<% =  new Config().ObjNav().FnGetUniversityTotalGovernmentSponsoredStudents(Convert.ToString(Session["UniversityCode"]))%>,
               'Self': <% = new Config().ObjNav().FnGetUniversityTotalSelfSponsoredStudents(Convert.ToString(Session["UniversityCode"]))%>,
       
    };
        
    var rows = [];
    for (element in myData) {
        rows.push([element + " (" + myData[element] + ")", myData[element]])
    }
    data.addRows(rows);

    // Optional; add a title and set the width and height of the chart
    var options = {'title':'Students Enrollment Distribution by Sponsors',
        'width':250, 
        'height':250,
        'chartArea': {'width': '80%', 'height': '80%','left': '30','top': '30'},
        'is3D': true,
        'legend': {'position': 'bottom'}
    };

    // Display the chart inside the <div> element with id="piechart"
    var chart = new google.visualization.PieChart(document.getElementById('sponsor-chart'));
    chart.draw(data, options);
}
    </script>
<script type="text/javascript">

        // Load google charts
        google.charts.load('current', {'packages':['corechart']});
        google.charts.setOnLoadCallback(drawChart);
        // Draw the chart and set the chart values
        function drawChart() {
            // Create the data table.
            var data = new google.visualization.DataTable();
            data.addColumn('string', 'Topping');
            data.addColumn('number', 'Slices');
        
            var myData = {
            'Masters':<% =  new Config().ObjNav().FnGetUniversityTotalUniversityMastersStudents(Convert.ToString(Session["UniversityCode"]))%>,
           'Bachelors':<% =  new Config().ObjNav().FnGetUniversityTotalUniversityBachelorsStudents(Convert.ToString(Session["UniversityCode"]))%>,
           'Doctorate': <% =  new Config().ObjNav().FnGetUniversityTotalUniversityDoctorateStudents(Convert.ToString(Session["UniversityCode"]))%>,
           'Certificate': <% =  new Config().ObjNav().FnGetUniversityTotalUniversityCertificateStudents(Convert.ToString(Session["UniversityCode"]))%>,
           'Post-graduate Diploma': <% =  new Config().ObjNav().FnGetUniversityTotalUniversityPostgraduateStudents(Convert.ToString(Session["UniversityCode"]))%>,
           'Diploma': <% =  new Config().ObjNav().FnGetUniversityTotalUniversityDiplomaStudents(Convert.ToString(Session["UniversityCode"]))%>,

    };
        
    var rows = [];
    for (element in myData) {
        rows.push([element + " (" + myData[element] + ")", myData[element]])
    }
    data.addRows(rows);

    // Optional; add a title and set the width and height of the chart
    var options = {'title':'Students Enrollment Distribution by Programme Level',
        'width':250, 
        'height':250,
        'chartArea': {'width': '80%', 'height': '80%','left': '30','top': '30'},
        'is3D': true,
        'legend': {'position': 'bottom'}
    };

    // Display the chart inside the <div> element with id="piechart"
    var chart = new google.visualization.PieChart(document.getElementById('program-chart'));
    chart.draw(data, options);
}
    </script>
     <script type="text/javascript">

        // Load google charts
        google.charts.load('current', {'packages':['corechart']});
        google.charts.setOnLoadCallback(drawChart);
        // Draw the chart and set the chart values
        function drawChart() {
            // Create the data table.
            var data = new google.visualization.DataTable();
            data.addColumn('string', 'Topping');
            data.addColumn('number', 'Slices');
        
            var myData = {
                'Full-Time':<% =  new Config().ObjNav().FnGetUniversityTotalFullTimeStudents(Convert.ToString(Session["UniversityCode"]))%>,
                'Part-Time': <% =  new Config().ObjNav().FnGetUniversityTotalPartTimeStudents(Convert.ToString(Session["UniversityCode"]))%>,
    };
        
    var rows = [];
    for (element in myData) {
        rows.push([element + " (" + myData[element] + ")", myData[element]])
    }
    data.addRows(rows);

    // Optional; add a title and set the width and height of the chart
    var options = {'title':'Students Distribution by Mode of Learning',
        'width':250, 
        'height':250,
        'is3D': true,
        'chartArea': {'width': '80%', 'height': '80%','left': '30','top': '30'},
        'legend': {'position': 'bottom'}
    };

    // Display the chart inside the <div> element with id="piechart"
    var chart = new google.visualization.PieChart(document.getElementById('learning-chart'));
    chart.draw(data, options);
}
    </script>
 <script type="text/javascript">
        google.charts.load("current", {packages:['corechart']});
        google.charts.setOnLoadCallback(drawChart);
        function drawChart() {
            var data = google.visualization.arrayToDataTable([
              ["Students", "Total", { role: "style" } ],
              ["Year1",<% = new Config().ObjNav().FnGetUniversityTotalFirstYearStudents(Convert.ToString(Session["UniversityCode"]))%>, "#e60000"],
            ["Year2",<% = new Config().ObjNav().FnGetUniversityTotalSecondYearStudents(Convert.ToString(Session["UniversityCode"]))%>,"#6666ff"],
            ["Year3",<% = new Config().ObjNav().FnGetUniversityTotalThridYearStudents(Convert.ToString(Session["UniversityCode"]))%>, "#e67300"],
            ["Year4",  <% = new Config().ObjNav().FnGetUniversityTotaFourthYearStudents(Convert.ToString(Session["UniversityCode"]))%>, "##9900e6"]
      ]);

      var view = new google.visualization.DataView(data);
      view.setColumns([0, 1,
                       { calc: "stringify",
                           sourceColumn: 1,
                           type: "string",
                           role: "annotation" },
                       2]);

      var options = {
          title: "Students Distrubution by Year of Study",
          width: 250,
          height: 250,
          is3D: true,
          bar: {groupWidth: "95%"},
          legend: { position: "none" },
      };
      var chart = new google.visualization.ColumnChart(document.getElementById("campus-chart"));
      chart.draw(view, options);
  }
    </script>
</asp:Content>
