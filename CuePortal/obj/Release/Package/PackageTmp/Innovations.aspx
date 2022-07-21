<%@ Page Title="" Language="C#" MasterPageFile="~/DataCollectionMaster.Master" AutoEventWireup="true" CodeBehind="Innovations.aspx.cs" Inherits="CicPortal.Innovations" %>
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
                      <p>*Please click Download Innovations Template to download formatted innovation excel template.</p>
            <div class="panel-heading">Excel Upload</div>
   
                <div class="panel-body">
                    <a href="templates/Staff Innovations.xlsx"><i class="fa fa-file-excel-o"></i> Download Innovations Template</a>
            <div class="form-group">
                                <select class="form-control" id="dataType" style='display:none;'>
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
                     <p>*Please click Add Innovation to add innovation details manually.</p>
            <div class="panel-heading">Form Upload</div>
     <div class="panel-body">
    <label class="btn btn-success"  data-toggle="modal" data-target="#form-input"><i class="fa fa-plus fa-fw"></i> Add Innovation</label>
         </div>
            </div>
    
            </div>
        </div>
         <div runat="server" id="feedback"></div>
                          <div id="tableOutput">
                    </div>
    
        <div class="panel panel-default">
            <p>*List of All Uploaded innovation details</p>
            <div class="panel-heading">Innovations</div>
            <div class="panel-body">
      <table  class="table table-striped table-bordered table-hover" id="dataTables-example">
          <thead>
          <tr>
             
              <th>Title</th>
              <th>Type</th>
              <th>Domain</th>
              <th>Campus</th>
              <th>Year</th>
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
  <div id="studentUpload" class="modal fade" role="dialog" >
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Add Staff Innovation</h4>
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

     <div id="form-input" class="modal fade" role="dialog" >
  <div class="modal-dialog modal-lg">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Add Innovation</h4>
      </div>
      <div class="modal-body">
          <div class="row">
                <div class="col-md-6 col-lg-6">
                   <P>*Please select innovation Campus</P>
                  <div class="form-group"><strong>Campus:</strong><asp:DropDownList runat="server" CssClass="form-control"  ID="campus"/> </div>
               </div>
                <div class="col-md-6 col-lg-6">
                    <P>*Please select Innovation Domain</P>
                  <div class="form-group"><strong>Domain:</strong><asp:DropDownList runat="server" CssClass="form-control"  ID="domain" /> </div>

              </div>
          </div>
        <div class="row">
              <div class="col-md-12 col-lg-12">
                  <p>*Please enter Innovation Title</p>
                  <div class="form-group"><strong>Title:</strong><asp:TextBox runat="server" CssClass="form-control" placeholder="Title" ID="title" /> </div>
              </div>
               <div class="col-md-12 col-lg-12">
                  <p>*Please enter the active Innovation link</p>
                  <div class="form-group"><strong>Link to Innovation:</strong><asp:TextBox runat="server" CssClass="form-control" placeholder="Link to Innovation" ID="link" /> </div>
              </div>
          </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <p>*Please enter the innovation Copyright Organisation</p>
                  <div class="form-group"><strong>Copyright Organisation:</strong><asp:TextBox runat="server" CssClass="form-control"  Placeholder=" Copyright Organisation" ID="patentingOrganisation"/> </div>

              </div>
              <div class="col-md-6 col-lg-6">
                  <p>*Please enter the innovation Copyright Number</p>
                  <div class="form-group"><strong>Copyright No:</strong><asp:TextBox runat="server" CssClass="form-control"  ID="copyrightNo" PlaceHolder="Copyright No"/> </div>

              </div>
          </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <p>*Please enter the innovation Copyright Year</p>
                  <div class="form-group"><strong>Copyright Year:</strong><asp:TextBox runat="server" CssClass="form-control"  Placeholder="Patent/Copyright Year" ID="patentYear"/> </div>
              </div>
              <div class="col-md-12 col-lg-12">
                  <p>*Please enter the Innovation Author Ids in the order in which they appear in the Innovation separated by Commas</p>
                  <div class="form-group"><strong>Author Ids:</strong> <i>Please enter the id numbers of all authors from your institution in a comma separated list</i><asp:TextBox runat="server" CssClass="form-control"  ID="authors" PlaceHolder="Authors"  /> </div>
              </div>
          </div>
      </div>
      <div class="modal-footer">
          <asp:Button runat="server" CssClass="btn btn-success" Text="Add Innovation" OnClick="Unnamed1_Click"/>
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
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
                                        int programs1=nav.Programs.Where(r => r.Accreditation_Status == "CUE Accredited" && r.Institution_Code == Convert.ToString( Session["UniversityCode"])).ToList().Count;
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
                            <i class="fa fa-bar-chart-o fa-fw"></i> Staff Publications Per Category

                        </div>
                        <div class="panel-body">
                            <div id="type-chart" style="position:center;right:0px;top:0px;"></div>
                        </div>
                    </div>
    
        </div>
         <div class="col-md-4 col-lg-4">
             <div class="panel panel-default">
                   <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i> Staff Publications Distribution by Domain

                        </div>
                        <div class="panel-body">
                            <div id="domains-chart" style="position:center;right:0px;top:0px;"></div>
                        </div>
                    </div>
    
        </div>
      <div class="col-md-4 col-lg-4">
             <div class="panel panel-default">
                   <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i> Staff Publications Distribution by Category

                        </div>
                        <div class="panel-body">
                            <div id="category-chart" style="position:center;right:0px;top:0px;"></div>
                        </div>
                    </div>
    
        </div>
  </div>
        <div class="row">
        <div class="col-md-12 col-lg-12">
            <div class="panel panel-green">
                <div class="panel-heading">
                  University Staff Innovations
                </div>
                <div class="panel-body">
                    <table class="table table-bordered table-striped dataTable" >
                        <thead>
                        <tr>
                             <th>Title</th>
                              <th>Type</th>
                              <th>Domain</th>
                              <th>Campus</th>
                              <th>Year</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                           
                             var universityresearches = nav.Research.Where(r => r.university == Convert.ToString(Session["UniversityCode"])&&r.Researcher_Category=="Staff"&&r.Category=="Innovation");
                             foreach (var researchpublications in universityresearches)
                             {
                                 %>
                             <tr>
                                 <td><%=researchpublications.Title %></td>
                                 <td><%=researchpublications.Description %></td>
                                 <td><%=researchpublications.Domain %></td>
                                 <td><%=researchpublications.Campus %></td>
                                 <td><%=researchpublications.Patent_Year %></td>
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
   <div class="row">
        <div class="col-md-12 col-lg-12">
            <div class="panel panel-green">
                <div class="panel-heading">
                    No. of Innovations per Campus
                </div>
                <div class="panel-body">
                    <table class="table table-bordered table-striped dataTable2" >
                        <thead>
                        <tr>
                            <th> Campus Code</th>
                            <th> Campus Name</th>
                            <th> No. of Innovations</th>
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
                                 <td><% = nav.Research.Where(r=>r.university==Convert.ToString(Session["UniversityCode"])&&r.Campus==campus.No).ToList().Count %></td>
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
        }
         %>
     <div id="deleteInnovationsModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Deleting Staff Innovation</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the Staff  Innovation<strong id="innovationtitle"></strong> ?</p>
          <asp:TextBox runat="server" ID="removeinnovationCode" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Innovation" OnClick="deleteInnovation_Click"/>
      </div>
    </div>

  </div>
</div>  
    <script>
         $(document).ready(function() {
             changeSubDomain();
         });
         $("#MainContent_domain").change(function () {
             changeSubDomain();
         });
         function changeSubDomain() {
             var domain = document.getElementById("MainContent_domain").value;
             var xmlhttp = new XMLHttpRequest();
             xmlhttp.onreadystatechange = function () {
                 if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                     var reply = xmlhttp.responseText;
                     $("#MainContent_subdomain").html(reply);
                 }
             }
             xmlhttp.open("GET", "<% =Config.Receiver() %>/getSubDomains?domain=" + domain, true);
             xmlhttp.send();
         }
     </script>
<script>
         $(document).ready(function() {
             $('.dataTable').DataTable({
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
            extraData: {_token: "23333323323223323232"},
            receiverUrl: ["addInnovation"],
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
                  url: "<% =Config.Receiver() %>/getResearch?type=Innovation&&userCode=<% = Session["Code"] %>&&password=<% =Session["Password"] %>",
                  type: "GET",
                  contentType: "application/json;charset=utf-8",
                  data: JSON.stringify("user: data"),
                  dataType: "json"
              })
          .done(function (response) {
              var table = $("#dataTables-example tbody");
              for (var i = 0; i < response.length; i++) {
                  var obj = response[i];

                  table.append("<tr><td>" +
                      obj.Title + "</td><td>" + obj.PublicationType + "</td><td>" + obj.Domain + "</td><td>" + obj.Campus + "</td><td>" + obj.PatentYear + "</td>" +
                         "<td><label class='btn btn-success' " +
                                  "onclick='edit(\"" + obj.Title + "\",\"" + obj.Domain + "\", \" " + obj.Campus + "\", \" " + obj.CopyrightNo + "\",\" " + obj.Link + "\",\" " + obj.Authors + "\", \" " + obj.PatentYear + "\");'><i class='fa fa-edit'></i> Edit</label></td><td>" +
                                  "<label class='btn btn-danger' onclick=' deleteResearch(\"" + obj.Code + "\",\"" + obj.Title + "\",\"" + obj.Description + "\", \"" + obj.Domain + " " + obj.Campus + " " + obj.PatentYear + "\");'><i class='fa fa-trash'></i> Delete</label></td> </tr>");
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
  </script>
<script type="text/javascript">
    function alerter(message) {
        if (window.swal) {
            swal("Alert!", message, "warning");
        } else {
            alert(message);
        }
    }
   
    function deleteResearch(id, title) {
        document.getElementById("innovationtitle").innerText = title;
        document.getElementById("MainContent_removeinnovationCode").value = id;
        $("#deleteInnovationsModal").modal();
    }
    function edit(Title, Domain, Campus, PatentYear, Authors, CopyrightNo, Link) {
        document.getElementById("MainContent_title").value = Title.trim();
        document.getElementById("MainContent_domain").value = Domain.trim();
        document.getElementById("MainContent_campus").value = Campus.trim();
        document.getElementById("MainContent_authors").value = Authors.trim();
        document.getElementById("MainContent_copyrightNo").value = CopyrightNo.trim();
        $('#MainContent_patentYear').val(PatentYear).datepicker("update");

        $('#form-input').modal('show');
    }
  </script>
</asp:Content>
