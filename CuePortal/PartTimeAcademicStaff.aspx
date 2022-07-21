<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/DataCollectionMaster.Master" CodeBehind="PartTimeAcademicStaff.aspx.cs" Inherits="CicPortal.PartTimeAcademicStaff" %>

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
                <p>*Click Download Partime Teaching Staff Excel Template to download formatted excel template</p>
                <div class="panel panel-default">
                    <div class="panel-heading">Excel Upload</div>

                    <div class="panel-body">
                        <a href="templates/PartTime Teaching Staff.xlsx"><i class="fa fa-file-excel-o"></i>Download PartTime Teaching Staff Excel Template</a>
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
                <p>*Please Click Add PartTime Teaching Staff to add partime teaching staff details manually</p>
                <div class="panel panel-default">
                    <div class="panel-heading">Form Upload</div>
                    <div class="panel-body">
                        <label class="btn btn-success" data-toggle="modal" data-target="#form-input"><i class="fa fa-plus fa-fw"></i>Add PartTime Teaching Staff</label>
                    </div>
                </div>

            </div>
        </div>
        <div runat="server" id="feedback"></div>
        <div id="tableOutput">
        </div>

        <div class="panel panel-default">
            <p>*List of all uploaded PartTime Teaching staff Details</p>
            <div class="panel-heading">All PartTime Teaching Staff</div>
            <div class="panel-body">
                 <div style="display: none;background-color:antiquewhite" id="deletealldiv" >
                   <center><button type="button" class="btn btn-danger deletestaffdata" id="deletestaffdata" name="deletestaffdata">Delete Selected Part-Time Staff Records</button></center> 
                </div>
                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="checkBoxAll" name="checkBoxAll" class="custom-checkbox" /></th>
                            <th>National Id</th>
                            <th>Staff Name</th>
                            <th>Gender</th>
                            <th>Date of Birth</th>
                            <th>County</th>
                            <th>Payroll Number</th>
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
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Uploading Staff Data</h4>
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
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Add PartTime Staff</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter PartTime staff ID number/Passport Number.</p>
                            <div class="form-group">
                                <strong>ID Number/Passport No:</strong><asp:TextBox runat="server" CssClass="form-control" placeholder="ID Number/Passport No" ID="idNumber" />
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter PartTime staff Payroll number</p>
                            <div class="form-group">
                                <strong>Payroll No:</strong><asp:TextBox runat="server" CssClass="form-control" ID="payrollNumber" placeholder="Payroll Number" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter PartTime Staff First Name</p>
                            <div class="form-group">
                                <strong>First Name:</strong><asp:TextBox runat="server" CssClass="form-control" placeholder="First Name" ID="firstName" />
                            </div>

                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter PartTime Staff Middle Name </p>
                            <div class="form-group">
                                <strong>Middle Name:</strong><asp:TextBox runat="server" CssClass="form-control" placeholder="Middle Name" ID="middleName" />
                            </div>

                        </div>

                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter partTime staff Last Name</p>
                            <div class="form-group">
                                <strong>Last Name:</strong><asp:TextBox runat="server" CssClass="form-control" placeholder="Last Name" ID="lastName" />
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please select partTime staff Gender</p>
                            <div class="form-group">
                                <strong>Gender:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="gender" />
                            </div>
                        </div>

                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter PartTime Staff Ethnic Background </p>
                            <div class="form-group">
                                <strong>Ethnic Background:</strong>
                                <asp:DropDownList runat="server" ID="ethnicBackground" CssClass="form-control"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter PartTime staff Date of Birth</p>
                            <div class="form-group">
                                <strong>Date of Birth:</strong><asp:TextBox runat="server" CssClass="form-control bootstrapdatepicker" placeholder="Date of Birth" ID="dob" />
                            </div>
                        </div>

                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>*Please select ParTime Staff Nationality</p>
                            <div class="form-group">
                                <strong>Nationality:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="nationality" />
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please Select PartTime staff Home County </p>
                            <div class="form-group">
                                <strong>Home County:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="homeCounty" />
                            </div>
                        </div>


                    </div>
                    <div class="row">

                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter partTime staff Disability Description</p>
                            <div class="form-group">
                                <strong>Disability Description:</strong> <i>(Choose None if staff is not disabled)</i><asp:DropDownList runat="server" CssClass="form-control" ID="disabilityDescriptions"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter partTime staff Disability Registration Code</p>
                            <div class="form-group">
                                <strong>Disability Registration Code:</strong><asp:TextBox runat="server" CssClass="form-control" placeholder="Disability Registration Code" ID="disabilityCode" />
                            </div>
                        </div>

                    </div>

                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>*Please select partTime staff Program Domain</p>
                            <div class="form-group">
                                <strong>Program Domain:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="programDomain" />
                            </div>
                        </div>

                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter partTime staff Rank</p>
                            <div class="form-group">
                                <strong>Rank:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="staffrank" />
                            </div>

                        </div>

                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>*Please enter PartTime staff Date of First Appointment</p>
                            <div class="form-group">
                                <strong>Date of First Appointment:</strong><asp:TextBox runat="server" CssClass="form-control bootstrapdatepicker" placeholder="Date of Appointment" ID="dateOfAppointment" />
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please select PartTime staff Type</p>
                            <div class="form-group">
                                <strong>PartTime Teaching Staff Type:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="stafftype" />
                            </div>

                        </div>

                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>*Please select PartTime staff Highest Academic Qualifications</p>
                            <div class="form-group">
                                <strong>Highest Academic Qualification:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="highestAcademicQualification" />
                            </div>

                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>*Please select PartTime staff Campus</p>
                            <div class="form-group">
                                <strong>Campus:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="campus" />
                            </div>

                        </div>
                       <div class="col-md-6 col-lg-6">
                          <p>* Please  select non-teaching staff Date of Current Appointment.</p>
                          <div class="form-group"><strong>Date of Current Appointment:</strong><asp:TextBox runat="server" CssClass="form-control bootstrapdatepicker" placeholder="Date of Current Appointment" ID="dateOfCurrentAppointment" /> </div>
                          </div>
                    </div>
                    <div class="row">
                    </div>

                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Submit Staff Details" ID="submit" OnClick="submit_Click" />
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
                                         int programs1= new Config().ObjNav().FnGetUniversityTotalUniversityProgrammes(Convert.ToString(Session["UniversityCode"]));
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
                    <i class="fa fa-bar-chart-o fa-fw"></i>Staff Distribution by Gender

                </div>
                <div class="panel-body">
                    <div id="genders-chart" style="position: center; right: 0px; top: 0px;"></div>
                </div>
            </div>

        </div>
        <div class="col-md-4 col-lg-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <i class="fa fa-bar-chart-o fa-fw"></i>Staff Distribution by Domain

                </div>
                <div class="panel-body">
                    <div id="domains-chart" style="position: center; right: 0px; top: 0px;"></div>
                </div>
            </div>

        </div>
        <div class="col-md-4 col-lg-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <i class="fa fa-bar-chart-o fa-fw"></i>Staff by Qualifications
                </div>
                <div class="panel-body">
                    <div id="qualifications-chart"></div>

                </div>
            </div>

        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-lg-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <i class="fa fa-bar-chart-o fa-fw"></i>Staff by Rank
                </div>
                <div class="panel-body">
                    <div id="ranks-chart"></div>

                </div>
            </div>

        </div>
        <div class="col-md-4 col-lg-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <i class="fa fa-bar-chart-o fa-fw"></i> Staff by Qualifications
                </div>
                <div class="panel-body">
                    <div id="qualifications1-chart"></div>

                </div>
            </div>

        </div>
    </div>

      <div class="row">
        <div class="col-md-12 col-lg-12">
            <div class="panel panel-green">
                <div class="panel-heading">
                    University Approved of Part-Time Teaching Staff 
                </div>
                <div class="panel-body">
                    <table class="table table-bordered table-striped dataTable2">
                        <thead>
                            <tr>
                                <th>Staff ID</th>
                                <th>Staff Name</th>
                                <th>Date of Birth</th>
                                <th>Date of First Appointment</th>
                                <th>Highest Academic Qualification</th>
                                <th>Ethinicity</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                var staffdetails = nav.University_Staff_Details.Where(r => r.Institution_Code == Convert.ToString(Session["UniversityCode"])&&r.Terms_of_Service=="Part Time"&&r.Current_Profile==true);
                                foreach (var staffdetail in staffdetails)
                                {
                            %>
                            <tr>
                                <td><%=staffdetail.ID_Passport_No %></td>
                                <td><%=staffdetail.First_Name+" "+staffdetail.Mddle_Name+" "+staffdetail.Surname%></td>
                                <td><%=staffdetail.Date_of_Birth %></td>
                                <td><%=staffdetail.Date_of_first_Appointment %></td>
                                <td><%=staffdetail.Highest_Academic_Qualification %></td>
                                <td><%=staffdetail.Ethnic_Background %></td>
                              
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
       <div id="deleteStaffModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Deleting PartTime Teaching Staff</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the Staff <strong id="staffname"></strong> ?</p>
          <asp:TextBox runat="server" ID="removestaffCode" type="hidden"/>
           <asp:TextBox runat="server" ID="removestaffId" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Staff" OnClick="deleteStaff_Click"/>
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
                receiverUrl: ["addPartTimeAcademicStaff"],
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
                  url: "<% =Config.Receiver() %>/getPartTimers?userId=<% =Convert.ToString(Session["Code"])%>&&userPassword=<% =Convert.ToString(Session["Password"])%>",
                  type: "GET",
                  contentType: "application/json;charset=utf-8",
                  data: JSON.stringify("user: data"),
                  dataType: "json"
              })
      .done(function (response) {
          var table = $("#dataTables-example tbody");
          for (var i = 0; i < response.length; i++) {
              var obj = response[i];//obj.enrolmentId
                table.append("<tr><td>"+
                     '<input type="checkbox" class="checkboxes" id="selectedrecordid" name="selectedrecordid" value="'+ obj.IDNo +' "/>' + "</td><td>" +
                  obj.IDNo + "</td><td>" + obj.Surname + " " + obj.FirstName + " " + obj.MiddleName + "</td><td>" + obj.Gender + "</td><td>" + obj.DateOfBirth + "</td><td>" + obj.HomeCounty + "</td><td>" + obj.PayrollNo + "</td>" +
                  "<td><label class='btn btn-success' onclick='" +
                  "edit(\"" + obj.IDNo + "\", \"" + obj.Surname + "\", \"" + obj.MiddleName + "\", \"" + obj.FirstName + "\", \"" + obj.Gender + "\", \"" + obj.EthnicBackground + "\",\"" + obj.DateOfBirth + "\", \"" + obj.HomeCounty + "\",\"" + obj.PayrollNo + "\", \"" + obj.Campus + "\", \"" + obj.DateOfFirstAppointment + "\", \"" + obj.DateOfCurrentAppointment + "\",\"" + obj.Nationality + "\",\"" + obj.Rank + "\",\"" + obj.DisabilityDescription + "\",\"" + obj.DisabilityRegistrationCode + "\");" +
                  "'><i class='fa fa-edit'></i> Edit</label></td><td>" +
                  "<label class='btn btn-danger' onclick=' deleteStaff(\"" + obj.EntryNo + "\",\"" + obj.IDNo + "\", \"" + obj.FirstName + " " + obj.MiddleName + " " + obj.Surname + "\");'><i class='fa fa-trash'></i> Delete</label></td> </tr>");
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
          
              function deleteStaff(entry,staffId, name) {
                  document.getElementById("staffname").innerText = name;
                  document.getElementById("MainContent_removestaffCode").value = entry;
                  document.getElementById("MainContent_removestaffId").value = staffId;
                  $("#deleteStaffModal").modal();
              }
              function edit(IDNo, Surname, MiddleName, FirstName, Gender, EthnicBackground,DateOfBirth, HomeCounty,PayrollNo, Campus,DateOfFirstAppointment,DateOfCurrentAppointment,Nationality,Rank,DisabilityDescription,DisabilityRegistrationCode) {
                  
                  campus = Campus.trim();  
                  nationality = Nationality.trim();    
                  ethnicbackgrounds = EthnicBackground.trim();    
                  homecounty = HomeCounty.trim(); 
                  staffranks =Rank.trim()
                  console.log(ethnicbackgrounds);
                  document.getElementById('MainContent_idNumber').value = IDNo.trim();
                  document.getElementById('MainContent_lastName').value = Surname.trim();
                  document.getElementById('MainContent_middleName').value = MiddleName.trim();
                  document.getElementById('MainContent_firstName').value = FirstName.trim();
                  document.getElementById('MainContent_gender').value = Gender.trim();
                  document.getElementById('MainContent_ethnicBackground').value = ethnicbackgrounds;
                  $('#MainContent_dob').val(DateOfBirth).datepicker("update");
                  document.getElementById('MainContent_homeCounty').value = homecounty;               
                  document.getElementById('MainContent_payrollNumber').value = PayrollNo.trim();
                  document.getElementById('MainContent_campus').value = campus;
                  $('#MainContent_dateOfAppointment').val(DateOfFirstAppointment).datepicker("update");
                  $('#MainContent_dateOfCurrentAppointment').val(DateOfCurrentAppointment).datepicker("update");
                  document.getElementById('MainContent_staffrank').value = staffranks;
                  document.getElementById('MainContent_nationality').value = nationality;
                  document.getElementById('MainContent_disabilityDescriptions').value = DisabilityDescription.trim();
                  document.getElementById('MainContent_disabilityCode').value = DisabilityRegistrationCode.trim();
                  $('#form-input').modal('show');
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
                        title: "Confirm Part-Time Teaching Staff Deletion?",
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
                                url: "PartTimeAcademicStaff.aspx/DeleteAllStaff",
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
                                            title: "Selected Part-Time Teaching Staff Records Deleted!",
                                            text:  "University Part-Time Teaching Staff Details have been successfully Deleted!",
                                            type: "success"
                                        }).then(() => {
                                            $("#deletallfeedback").css("display", "block");
                                            $("#deletallfeedback").css("color", "green");
                                            $('#deletallfeedback').attr("class", "alert alert-success");
                                            $("#deletallfeedback").html("University Part-Time Teaching Staff Details have been successfully Deleted!");
                                            $("#deletallfeedback").css("display", "block");
                                            $("#deletallfeedback").css("color", "green");
                                            $("#deletallfeedback").html("University Part-Time Teaching Staff Details have been successfully Deleted!");
                                            $("#deletallfeedback").reset();
                                        });
                                        selected_arr = [];
                                        window.location = "PartTimeAcademicStaff.aspx";
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
                                            $("#deletallfeedback").html("University Part-Time Teaching Staff Details Could not be Deleted!.Kindy Try Again Later");
                                        });
                                        selected_arr = [];
                                        break;
                                }
                            }
                            );
                        } else if (result.dismiss === Swal.DismissReason.cancel) {
                            Swal.fire(
                                'Part-Time Teaching Staff Deletion Cancelled',
                                'You cancelled your Part-Time Teaching Staff deletion details!',
                                'error'
                            );
                        }
                    });

                });
        });
    </script>
    <script type="text/javascript" src="js/loader.js"></script>
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
                'Male':<% = new Config().ObjNav().FnGetUniversityTotalUniversityMaleStaff(Convert.ToString(Session["UniversityCode"]))%>,
               'Female':<% = new Config().ObjNav().FnGetUniversityTotalUniversityFemaleStaff(Convert.ToString(Session["UniversityCode"]))%>,
               'Intersex':<% = new Config().ObjNav().FnGetUniversityTotalUniversityIntersexStaff(Convert.ToString(Session["UniversityCode"]))%>,
        };
        var rows = [];
        for (element in myData) {
            rows.push([element + " (" + myData[element] + ")", myData[element]])
        }
        data.addRows(rows);

        // Optional; add a title and set the width and height of the chart
        var options = {'title':'Part-Time Staff Distribution by Gender',
            'width':250, 
            'height':250,
            'chartArea': {'width': '80%', 'height': '80%','left': '30','top': '30'},
            'is3D': true,
            'legend': {'position': 'bottom'}
        };
        // Display the chart inside the <div> element with id="piechart"
        var chart = new google.visualization.PieChart(document.getElementById('genders-chart'));
        chart.draw(data, options);
    }
    </script>
      <script type="text/javascript">
        google.charts.load("current", {packages:['corechart']});
        google.charts.setOnLoadCallback(drawChart);
        function drawChart() {
            var data = google.visualization.arrayToDataTable([
             ["Staff", "Total", { role: "style" } ],    
             ["Bachelors", <% = new Config().ObjNav().FnGetUniversityTotalUniversityPartTimeBachelorsStaff(Convert.ToString(Session["UniversityCode"]))%>, "#6666ff"],
             ["Masters",<% = new Config().ObjNav().FnGetUniversityTotalUniversityPartTimeMastersStaff(Convert.ToString(Session["UniversityCode"]))%>, "#e67300"]
       
        ]);

        var view = new google.visualization.DataView(data);
        view.setColumns([0, 1,
                         { calc: "stringify",
                             sourceColumn: 1,
                             type: "string",
                             role: "annotation" },
                         2]);

        var options = {
            title: "Staff Distrubution by Qualifications",
            width: 250,
            height: 250,
            is3D: true,
            bar: {groupWidth: "95%"},
            legend: { position: "none" },
        };
        var chart = new google.visualization.ColumnChart(document.getElementById("qualifications1-chart"));
        chart.draw(view, options);
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
                'Graduate Assistant':<% = new Config().ObjNav().FnGetUniversityTotalUniversityGraduateAssistantStaff(Convert.ToString(Session["UniversityCode"]))%>,
                'Research Assistant': <% = new Config().ObjNav().FnGetUniversityTotalUniversityResearchAssistantStaff(Convert.ToString(Session["UniversityCode"]))%>,
                'Tutorial Fellow': <% = new Config().ObjNav().FnGetUniversityTotalUniversityTutorialFellowStaff(Convert.ToString(Session["UniversityCode"]))%>,
                'Junior Research':  <% = new Config().ObjNav().FnGetUniversityTotalUniversityJuniorResearchStaff(Convert.ToString(Session["UniversityCode"]))%>,
                'Lecturer': <% = new Config().ObjNav().FnGetUniversityTotalUniversityLecturerStaff(Convert.ToString(Session["UniversityCode"]))%>,
                'Research Fellow': <% = new Config().ObjNav().FnGetUniversityTotalUniversityResearchFellowStaff(Convert.ToString(Session["UniversityCode"]))%>,
                'Senior Lecturer':  <% = new Config().ObjNav().FnGetUniversityTotalUniversitySeniorLecturerStaff(Convert.ToString(Session["UniversityCode"]))%>,
                'Senior Research Fellow': <% = new Config().ObjNav().FnGetUniversityTotalUniversitySeniorReserachFellowStaff(Convert.ToString(Session["UniversityCode"]))%>,
                'Associate Proffesor': <% = new Config().ObjNav().FnGetUniversityTotalUniversityAssociateProffesorStaff(Convert.ToString(Session["UniversityCode"]))%>,
                'Professor': <% = new Config().ObjNav().FnGetUniversityTotalUniversityProfessorsStaff(Convert.ToString(Session["UniversityCode"]))%>,
                'Adjunct Academic Staff': <% = new Config().ObjNav().FnGetUniversityTotalUniversityAdjunctAcademicStaffStaff(Convert.ToString(Session["UniversityCode"]))%>,
        };
        
        var rows = [];
        for (element in myData) {
            rows.push([element + " (" + myData[element] + ")", myData[element]])
        }
        data.addRows(rows);

        // Optional; add a title and set the width and height of the chart
        var options = {'title':'Staff Distribution by Rank',
            'width':250, 
            'height':250,
            'is3D': true,
            'chartArea': {'width': '80%', 'height': '80%','left': '30','top': '30'},
            'legend': {'position': 'none'}
        };

        // Display the chart inside the <div> element with id="piechart"
        var chart = new google.visualization.PieChart(document.getElementById('ranks-chart'));
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
                'Education':<% = new Config().ObjNav().FnGetUniversityTotalUniversityEducationStaff(Convert.ToString(Session["UniversityCode"]))%>,
                'Business': <% = new Config().ObjNav().FnGetUniversityTotalUniversitBusinessStaff(Convert.ToString(Session["UniversityCode"]))%>,
                'Health & Welfare': <% = new Config().ObjNav().FnGetUniversityTotalUniversitHealthStaff(Convert.ToString(Session["UniversityCode"]))%>,
                'Arts': <% = new Config().ObjNav().FnGetUniversityTotalUniversityArtsStaff(Convert.ToString(Session["UniversityCode"]))%>,
                'Social Science':<% = new Config().ObjNav().FnGetUniversityTotalUniversityScienceStaff(Convert.ToString(Session["UniversityCode"]))%>,
                'Services': <% = new Config().ObjNav().FnGetUniversityTotalUniversityServicesStaff(Convert.ToString(Session["UniversityCode"]))%>,
                'Natural Science':  <% = new Config().ObjNav().FnGetUniversityTotalUniversityNaturalScienceStaff(Convert.ToString(Session["UniversityCode"]))%>,
                'Engineering': <% = new Config().ObjNav().FnGetUniversityTotalUniversityEngineeringStaff(Convert.ToString(Session["UniversityCode"]))%>,
                'ICT': <% = new Config().ObjNav().FnGetUniversityTotalUniversityICTStaff(Convert.ToString(Session["UniversityCode"]))%>,
                'Life Science':<% = new Config().ObjNav().FnGetUniversityTotalUniversityLifeScienceStaff(Convert.ToString(Session["UniversityCode"]))%>,
                'Agriculture': <% = new Config().ObjNav().FnGetUniversityTotalUniversityAgricultureStaff(Convert.ToString(Session["UniversityCode"]))%>,
        };
        
        var rows = [];
        for (element in myData) {
            rows.push([element + " (" + myData[element] + ")", myData[element]])
        }
        data.addRows(rows);

        // Optional; add a title and set the width and height of the chart
        var options = {'title':'Staff Distribution by Domain',
            'width':250, 
            'height':250,
            'is3D': true,
            'chartArea': {'width': '80%', 'height': '80%','left': '30','top': '30'},
            'legend': {'position': 'none'}
        };

        // Display the chart inside the <div> element with id="piechart"
        var chart = new google.visualization.PieChart(document.getElementById('domains-chart'));
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
            'Bachelors': <% = new Config().ObjNav().FnGetUniversityTotalUniversityPartTimeBachelorsStaff(Convert.ToString(Session["UniversityCode"]))%>,
            'Masters':<% = new Config().ObjNav().FnGetUniversityTotalUniversityPartTimeMastersStaff(Convert.ToString(Session["UniversityCode"]))%>,
            'Doctorate': <% = new Config().ObjNav().FnGetUniversityTotalUniversityPartTimeDoctorateStaff(Convert.ToString(Session["UniversityCode"]))%>,
            'Diploma':<% = new Config().ObjNav().FnGetUniversityTotalUniversityPartTimeDiplomaStaff(Convert.ToString(Session["UniversityCode"]))%>,
            'Certificate': <% = new Config().ObjNav().FnGetUniversityTotalUniversityPartTimeCertificateStaff(Convert.ToString(Session["UniversityCode"]))%>,
        };
        
        var rows = [];
        for (element in myData) {
            rows.push([element + " (" + myData[element] + ")", myData[element]])
        }
        data.addRows(rows);

        // Optional; add a title and set the width and height of the chart
        var options = {'title':'Staff Distribution by Qualifications',
            'width':250, 
            'height':250,
            'is3D': true,
            'chartArea': {'width': '80%', 'height': '80%','left': '30','top': '30'},
            'legend': {'position': 'none'}
        };

        // Display the chart inside the <div> element with id="piechart"
        var chart = new google.visualization.PieChart(document.getElementById('qualifications-chart'));
        chart.draw(data, options);
    }
    </script>
</asp:Content>
