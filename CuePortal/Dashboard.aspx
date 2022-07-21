<%@ Page Title="" Language="C#" MasterPageFile="~/ChooseServiceMaster.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="CicPortal.Dashboard" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
      <%

         var nav2 = Config.ReturnNav();
          if (Convert.ToString(Session["type"]) == "old")
          {
               var nav = Config.ReturnNav();
      %>
    <div class="row">
        <div runat="server" id="feedback"></div>
                <div class="col-lg-3 col-md-6">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-users fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">
                                    <%--    <%
                                            
                                 int students = nav.University_Students_Profile.Where(r=>r.University_No == Convert.ToString(Session["UniversityCode"])&&r.Approval_Status=="Open"&&r.Current_profile==true).ToList().Count;
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
                                     <%--   <%
                                            int academicStaff = nav.University_Staff_Details.Where(r=>r.Institution_Code==Convert.ToString(Session["UniversityCode"])&&r.Staff_Type=="Teaching"&&r.Current_Profile==true).ToList().Count;
                                            %>
                                        <% =academicStaff %>--%>
                                    </div>
                                    <div>Teaching Staff</div>
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
                                        <% int programs = nav.Programs.Where(r => r.Accreditation_Status == "CUE Accredited" && r.Institution_Code == Convert.ToString( Session["UniversityCode"])).ToList().Count; %>
                                        <% =programs %>
                                    </div>
                                    <div>Teaching Programs</div>
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
                                    <div>University Campuses</div>
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
     <%
               }
               %>  

<div class="row">
         <div class="col-md-4 col-lg-4">
             <div class="panel panel-default">
                   <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i>Teaching Staff Distribution by Domain

                        </div>
                        <div class="panel-body">
                            <div id="domains-chart" style="position:center;right:0px;top:0px;"></div>
                        </div>
                    </div>    
        </div>
        <div class="col-md-4 col-lg-4">
             <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i>Teaching Staff by Rank
                        </div>
                        <div class="panel-body">
                            <div id="ranks-chart"></div>
                           
                        </div>
                        <!-- /.panel-body -->
                    </div>
    
        </div>
         <div class="col-md-4 col-lg-4">
             <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i>Teaching Staff by Disability
                        </div>
                        <div class="panel-body">
                            <div id="disability-chart"></div>
                           
                        </div>
                        <!-- /.panel-body -->
                    </div>
    
        </div>
   </div>

    <div class="row">
         <div class="col-md-4 col-lg-4">
             <div class="panel panel-default">
                   <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i> Students Enrollment Distribution by Gender

                        </div>
                        <div class="panel-body">
                            <div id="gender-chart" style="position:center;right:0px;top:0px;"></div>
                        </div>
                    </div>
    
        </div>
       <div class="col-md-4 col-lg-4">
             <div class="panel panel-default">
                   <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i> Students Enrollment Distribution by Year

                        </div>
                        <div class="panel-body">
                            <div id="year-chart" style="position:center;right:0px;top:0px;"></div>
                        </div>
                    </div>
    
        </div>
      <div class="col-md-4 col-lg-4">
             <div class="panel panel-default">
                   <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i> Students Enrollment Distribution by
Sponsors

                        </div>
                        <div class="panel-body">
                            <div id="sponsor-chart" style="position:center;right:0px;top:0px;"></div>
                        </div>
                    </div>
    
        </div>
  </div>
    <div class="row">
         <div class="col-md-4 col-lg-4">
             <div class="panel panel-default">
                   <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i> Students Enrollment Distribution by Year

                        </div>
                        <div class="panel-body">
                            <div id="campus-chart" style="position:center;right:0px;top:0px;"></div>
                        </div>
                    </div>
    
        </div>
         <div class="col-md-4 col-lg-4">
             <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i> Student Enrolment by Sponsorship
                        </div>
                        <div class="panel-body">
                            <div id="learning-chart"></div>
                           
                        </div>
                        <!-- /.panel-body -->
                    </div>
    
        </div>
        <div class="col-md-4 col-lg-4">
             <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i> Students Distribution by Program Levels
                        </div>
                        <div class="panel-body">
                            <div id="program-chart"></div>
                         
                        </div>
                  </div>
        </div>  
     </div>
 </asp:Content>