<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CompletedPrograms.aspx.cs" MasterPageFile="~/AccreditationMaster.Master" Inherits="CicPortal.CompletedPrograms" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
      <%
          var nav2 = Config.ReturnNav();
          if (Convert.ToString(Session["type"]) == "old")
          {
              var nav = Config.ReturnNav();
      %>
    <div class="row">
        <div runat="server" id="Div1"></div>
                <div class="col-lg-3 col-md-6">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-users fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">
                                       <%-- <%

                                            int students = nav.studentEnrolmentList.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"])).ToList().Count;
                                             %>
                                        <% =students %>--%>
                                    </div>
                                    <div>Students Enrolled</div>
                                </div>
                            </div>
                        </div>
                        <a href="Students.aspx">
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
                                       <%-- <%
                                            int academicStaff = nav.University_Staff_Profile.Where(r => r.Institution_Code == Convert.ToString(Session["UniversityCode"])).ToList().Count;
                                            %>
                                        <% =academicStaff %>--%>
                                    </div>
                                    <div>Academic Staff</div>
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
                                        <% int programs = nav.Programs.Where(r => r.Accreditation_Status == "CUE Accredited" && r.Institution_Code == Convert.ToString(Session["UniversityCode"])).ToList().Count; %>
                                        <% =programs %>
                                    </div>
                                    <div>Academic Programmes</div>
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
                                    <i class="fa fa-building fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">
                                        <%  int campuses = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"])).ToList().Count; %>
                                        <%=campuses %>
                                    </div>
                                    <div>Campuses</div>
                                </div>
                            </div>
                        </div>
                        <a href="Campuses.aspx">
                            <div class="panel-footer">
                                <span class="pull-left">View Details</span>
                                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
    <div>
        <div class="row">
            <div class="col-md-12 col-lg-12">
                  <div class="panel panel-default">
            <div class="panel-heading">Completed Program Accreditation</div>
                <div class="panel-body">
                    <div id ="feedback" runat="server"></div>
                     <table class="table table-bordered table-striped table-hover" id="dataTables-example">
                         <thead>
                         <tr>
                             <th>Accreditation No:</th>
                             <th>Institution Name</th>
                             <th>Campus</th>
                             <th>Program Name</th>
                             <th>Program Level</th>
                             <th>Application Date</th>
                             <th>Status</th>

                         </tr>
                         </thead>
                         <tbody>
                         <%
                             var programmes = nav.ProgramAccreditation.Where(r => r.Institution_No == Convert.ToString(Session["UniversityCode"])&&r.Status=="Completed");
                             foreach (var program in programmes)
                             {
                             %>
                             <tr>
                                 <td><%=program.Accreditation_No %></td>
                                 <td><%=program.Institution_Name %></td>
                                 <td><%=program.Campus_Name %></td>
                                 <td><%=program.Program_Name %></td>
                                 <td><%=program.Program_Level %></td>
                                 <td><%=program.Date_Created %></td>
                                 <td><%=program.Status %></td>
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
        </div>
     <div class="row">
         <div class="col-md-4 col-lg-4">
             <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i>Programmes Distribution by Domains
                        </div>
                        <div class="panel-body">
                            <div id="programdomain-chart"></div>
                           
                        </div>
                    </div>
    
        </div>
        <div class="col-md-4 col-lg-4">
             <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i>Programmes Distribution by Years
                        </div>
                        <div class="panel-body">
                            <div id="years-chart"></div>
                           
                        </div>
                    </div>
    
        </div>
         <div class="col-md-4 col-lg-4">
             <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i>Programmes Distribution by Levels
                        </div>
                        <div class="panel-body">
                            <div id="programlevels-chart"></div>
                           
                        </div>
                    </div>
    
        </div>
   </div>
    <%} %>
     <script>
         $(document).ready(function() {
            $('#dataTables-example').DataTable({
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

</asp:Content>