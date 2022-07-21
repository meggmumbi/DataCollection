<%@ Page Title="" Language="C#" MasterPageFile="~/DataCollectionMaster.Master" AutoEventWireup="true" CodeBehind="AcademicStaff.aspx.cs" Inherits="CicPortal.FullTimeAcademicStaffSize" %>

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
                    <p>*Please click Download Excel Template to download formatted</p>
                    <div class="panel-heading">Excel Upload</div>
                    <div class="panel-body">
                        <a href="templates/Teaching Staff.xlsx"><i class="fa fa-file-excel-o"></i>Download Excel Template</a>
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
                    <p>*Please add Details manually</p>
                    <div class="panel-heading">Form Upload</div>
                    <div class="panel-body">
                        <label class="btn btn-success" data-toggle="modal" data-target="#form-input"><i class="fa fa-plus fa-fw"></i>Add Abstraction and Production</label>
                    </div>
                </div>
            </div>
        </div>
        <div runat="server" id="feedback"></div>
        <div id="deletallfeedback" style="display: none" data-dismiss="alert"></div>
        <div id="tableOutput">
        </div>
        <div class="panel panel-default">
            <p>*List of all uploaded details.</p>
            <div class="panel-heading">Abstraction and production</div>
            <div></div>
            <div class="panel-body">
                <div style="display: none; background-color: antiquewhite" id="deletealldiv">
                    <center><button type="button" class="btn btn-danger deletestaffdata" id="deletestaffdata" name="deletestaffdata">Delete Selected Records</button></center>
                </div>
                <table id="example1" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th></th>
                            <th>Unit</th>
                            <th>Current </th>
                            <th>Previous</th>

                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Surface water abstracted</td>
                            <td>m^3</td>
                            <td>4</td>
                            <td>4</td>

                        </tr>
                        <tr>
                            <td>Untreated surface water imported</td>
                            <td>m^3</td>
                            <td>4</td>
                            <td>4</td>

                        </tr>
                        <tr>
                            <td>Untreated surface water exported</td>
                            <td>m^3</td>
                            <td>4</td>
                            <td>4</td>

                        </tr>
                        <tr>
                            <td>
                                <p style="color: darkblue">Total untreated surface water available</p>
                            </td>
                            <td>m^3</td>
                            <td>4</td>
                            <td>4</td>

                        </tr>

                        <tr>
                            <td>Groundwater abstracted</td>
                            <td>m^3</td>
                            <td>4</td>
                            <td>4</td>

                        </tr>
                        <tr>
                            <td>Groundwater imported</td>
                            <td>m^3</td>
                            <td>4</td>
                            <td>4</td>

                        </tr>
                        <tr>
                            <td>Groundwater exported
                            </td>
                            <td>m^3</td>
                            <td>4</td>
                            <td>4</td>

                        </tr>
                        <tr>
                            <td>
                                <p style="color: darkblue">Total groundwater available</p>
                            </td>
                            <td>m^3</td>
                            <td>4</td>
                            <td>4</td>

                        </tr>
                        <tr>
                            <td>Volume of groundwater requiring treatment</td>
                            <td>m^3</td>
                            <td>4</td>
                            <td>4</td>

                        </tr>
                        <tr>
                            <td>Metered surface water abstraction points
                            </td>
                            <td>m^3</td>
                            <td>4</td>
                            <td>4</td>

                        </tr>
                        <tr>
                            <td>Unmetered surface water abstraction points
                            </td>
                            <td>m^3</td>
                            <td>4</td>
                            <td>4</td>

                        </tr>
                        <tr>
                            <td>Metered groundwater abstraction points
                            </td>
                            <td>m^3</td>
                            <td>4</td>
                            <td>4</td>

                        </tr>
                        <tr>
                            <td>Unmetered groundwater abstraction points
                            </td>
                            <td>m^3</td>
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
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Add Teaching Staff</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>* Please  enter teaching staff ID number/Passport No.</p>
                            <div class="form-group">
                                <strong>ID Number/Passport No:</strong>
                                <asp:TextBox runat="server" CssClass="form-control" placeholder="ID Number/Passport No" ID="idNumber" />
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>* Please  enter teaching staff Payroll No.</p>
                            <div class="form-group">
                                <strong>Payroll No:</strong><asp:TextBox runat="server" CssClass="form-control" ID="payrollNumber" placeholder="Payroll Number" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>* Please  enter teaching staff  First Name.</p>
                            <div class="form-group">
                                <strong>First Name:</strong><asp:TextBox runat="server" CssClass="form-control" placeholder="First Name" ID="firstName" />
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>* Please  enter teaching staff Middle Name</p>
                            <div class="form-group">
                                <strong>Middle Name:</strong><asp:TextBox runat="server" CssClass="form-control" placeholder="Middle Name" ID="middleName" />
                            </div>

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>* Please  enter teaching staff Last Name</p>
                            <div class="form-group">
                                <strong>Last Name:</strong><asp:TextBox runat="server" CssClass="form-control" placeholder="Last Name" ID="lastName" />
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>* Please  select  teaching staff Gender</p>
                            <div class="form-group">
                                <strong>Gender:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="gender" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>* Please  enter teaching staff Ethnic Background.</p>
                            <div class="form-group">
                                <strong>Ethnic Background:</strong>
                                <asp:DropDownList runat="server" CssClass="form-control" ID="ethinBackground"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>* Please  enter teaching staff Date of Birth </p>
                            <div class="form-group">
                                <strong>Date of Birth:</strong><asp:TextBox runat="server" CssClass="form-control bootstrapdatepicker" placeholder="Date of Birth" ID="dob" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>* Please  select teaching staff Nationality.</p>
                            <div class="form-group">
                                <strong>Nationality:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="nationality" />
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>* Please  select teaching staff Home County.</p>
                            <div class="form-group">
                                <strong>Home County:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="homeCounty" />
                            </div>
                        </div>


                    </div>
                    <div class="row">

                        <div class="col-md-6 col-lg-6">
                            <p>* Please  select teaching staff Disability Description.</p>
                            <div class="form-group">
                                <strong>Disability Description:</strong> <i>(Choose None if not Disabled)</i><asp:DropDownList runat="server" CssClass="form-control" ID="diabilityDescription"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>* Please enter teaching staff Disability Registration Code(Type None if Not Applicable).</p>
                            <div class="form-group">
                                <strong>Disability Registration Code:</strong><asp:TextBox runat="server" CssClass="form-control" placeholder="Disability Registration Code" ID="disabilityCode" />
                            </div>
                        </div>

                    </div>

                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>* Please  select teaching staff Programme Domain.</p>
                            <div class="form-group">
                                <strong>Programme Domain:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="programDomain" />
                            </div>
                        </div>

                        <div class="col-md-6 col-lg-6">
                            <p>* Please  select teaching staff Rank.</p>
                            <div class="form-group">
                                <strong>Staff Rank:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="staffrankcode" />
                            </div>

                        </div>

                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>* Please  select teaching staff Date of First Appointment.</p>
                            <div class="form-group">
                                <strong>Date of First Appointment:</strong><asp:TextBox runat="server" CssClass="form-control bootstrapdatepicker" placeholder="Date of Appointment" ID="dateOfAppointment" />
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>* Please  select teaching staff Terms of Service.</p>
                            <div class="form-group">
                                <strong>Terms of Service:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="stafftermsOfService" />
                            </div>

                        </div>


                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>* Please  select teaching staff Highest Academic Qualification.</p>
                            <div class="form-group">
                                <strong>Highest Academic Qualification:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="highestAcademicQualification" />
                            </div>

                        </div>
                        <div class="col-md-6 col-lg-6">
                            <p>* Please  select teaching staff Campus.</p>
                            <div class="form-group">
                                <strong>Campus:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="campus" />
                            </div>

                        </div>

                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <p>* Please  enter teaching staff Date of Current Appointment.</p>
                            <div class="form-group">
                                <strong>Date of Current Appointment:</strong><asp:TextBox runat="server" CssClass="form-control bootstrapdatepicker" placeholder="Date of Current Appointment" ID="dateOfCurrentAppointment" />
                            </div>
                        </div>

                        <div class="col-md-6 col-lg-6" style="display: none">
                            <p>* Please select the Submission Type.</p>
                            <div class="form-group">
                                <strong>Submission Type:</strong><asp:DropDownList runat="server" CssClass="form-control" ID="submissiontype" />
                            </div>
                        </div>
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

                                    int academicStaff = 0; /*new Config().ObjNav().FnGetUniversityTotalUniversityStaff(Convert.ToString(Session["UniversityCode"]));*/
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

                                    int campus1 = 0; /*new Config().ObjNav().FnGetUniversityTotalUniversityCampuses(Convert.ToString(Session["UniversityCode"]));*/
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
                                    int programs1 = 0; /*new Config().ObjNav().FnGetUniversityTotalUniversityProgrammes(Convert.ToString(Session["UniversityCode"]));*/
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
                                    int disability = 0; /*new Config().ObjNav().FnGetUniversityPWDTotalStudents(Convert.ToString(Session["UniversityCode"]));*/
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
                    <i class="fa fa-bar-chart-o fa-fw"></i>Academic Staff Distribution by Gender

                </div>
                <div class="panel-body">
                    <div id="genders-chart" style="position: center; right: 0px; top: 0px;"></div>
                </div>
            </div>

        </div>
        <div class="col-md-4 col-lg-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <i class="fa fa-bar-chart-o fa-fw"></i>Academic Staff by Terms of Service
                </div>
                <div class="panel-body">
                    <div id="learning-chart"></div>

                </div>
            </div>

        </div>
        <div class="col-md-4 col-lg-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <i class="fa fa-bar-chart-o fa-fw"></i>Academic Staff by Qualifications
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
                    <i class="fa fa-bar-chart-o fa-fw"></i>Academic Staff Distribution by Domain

                </div>
                <div class="panel-body">
                    <div id="domains-chart" style="position: center; right: 0px; top: 0px;"></div>
                </div>
            </div>

        </div>
        <div class="col-md-4 col-lg-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <i class="fa fa-bar-chart-o fa-fw"></i>Academic Staff by Rank
                </div>
                <div class="panel-body">
                    <div id="ranks-chart"></div>

                </div>
            </div>

        </div>
    </div>
    <div class="row">
        <div class="col-md-12 col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    List of University Teaching Staff 
                </div>
                <div class="panel-body">
                   
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
                    <h4 class="modal-title">Confirm Deleting Teaching Staff</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the Staff <strong id="staffname"></strong>?</p>
                    <asp:TextBox runat="server" ID="removestaffCode" type="hidden" />
                    <asp:TextBox runat="server" ID="removepayrolcode" type="hidden" />
                    <asp:TextBox runat="server" ID="removestaffid" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Staff" OnClick="deleteStaff_Click" />
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
    <script src="js/CustomJs.js"></script>
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
                receiverUrl: ["addAcademicStaff"],
                username: "<% = Session["Code"] %>",
                password: "<% =Session["Password"] %>"
            });
            loadData();
        });
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
                        title: "Confirm Teaching Staff Deletion?",
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
                                url: "AcademicStaff.aspx/DeleteAllStaff",
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
                                            title: "Selected Teaching Staff Records Deleted!",
                                            text:  "University Teaching Staff Details have been successfully Deleted!",
                                            type: "success"
                                        }).then(() => {
                                            $("#deletallfeedback").css("display", "block");
                                            $("#deletallfeedback").css("color", "green");
                                            $('#deletallfeedback').attr("class", "alert alert-success");
                                            $("#deletallfeedback").html("University Teaching Staff Details have been successfully Deleted!");
                                            $("#deletallfeedback").css("display", "block");
                                            $("#deletallfeedback").css("color", "green");
                                            $("#deletallfeedback").html("University Teaching Staff Details have been successfully Deleted!");
                                            $("#deletallfeedback").reset();
                                        });
                                        selected_arr = [];
                                        window.location = "AcademicStaff.aspx";
                                        break;
                                    default:
                                        Swal.fire
                                        ({
                                            title: "Teaching Staff Deletion Error!!!",
                                            text: status,
                                            type: "error"
                                        }).then(() => {
                                            $("#deletallfeedback").css("display", "block");
                                            $("#deletallfeedback").css("color", "red");
                                            $('#deletallfeedback').addClass('alert alert-danger');
                                            $("#deletallfeedback").html("University Teaching Staff Details Could not be Deleted!.Kindy Try Again Later");
                                        });
                                        selected_arr = [];
                                        break;
                                }
                            }
                            );
                        } else if (result.dismiss === Swal.DismissReason.cancel) {
                            Swal.fire(
                                'Teaching Staff Deletion Cancelled',
                                'You cancelled your teaching staff deletion details!',
                                'error'
                            );
                        }
                    });

                });
        });
    </script>
    <script type="text/javascript" src="js/loader.js"></script>
  

</asp:Content>
