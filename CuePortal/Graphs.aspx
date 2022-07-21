<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Graphs.aspx.cs" Inherits="CicPortal.Graphs" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!--<div class="jumbotron" style="padding: 10px; margin-top: 10px;"><h2>Home</h2>
        <h4> <a href="" style="color:#0000fe">Home/</a></h4>
    </div> -->
      <%

          if (Convert.ToString(Session["type"]) == "old")
          {
      %>
    <div class="row">
        <div class="col-md-4 col-lg-4">
             <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i> Student Enrolment by Sponsorship
                        </div>
                        <div class="panel-body">
                            <div id="morris-donut-chart"></div>
                            <a href="Students.aspx" class="btn btn-default btn-block">View Details</a>
                        </div>
                        <!-- /.panel-body -->
                    </div>
    
        </div>
        <div class="col-md-8 col-lg-8">
             <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i> Research by Domain
                          
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="row">
                                
                                
                                    <div id="morris-bar-chart"></div>
                                <div style="padding: 10px;">
                                 <a href="#" class="btn btn-default btn-block">View Details</a>
                               </div>
                            </div>
                            <!-- /.row -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                   
        </div>
    </div>
     <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i> Student Distribution by County
                          
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="row">
                                
                                
                                    <div id="student_by_county"></div>
                                <div style="padding: 10px;">
                                 <a href="#" class="btn btn-default btn-block">View Details</a>
                               </div>
                            </div>
                            <!-- /.row -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                   
    <div class="row">
        <div class="col-md-6 col-lg-6">
             <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i> Revenue by Source
                        </div>
                        <div class="panel-body">
                            <div id="revenue-chart"></div>
                            <a href="#" class="btn btn-default btn-block">View Details</a>
                        </div>
                        <!-- /.panel-body -->
                    </div>
          
        </div>
 <div class="col-md-6 col-lg-6">
             <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i> Expenditure
                        </div>
                        <div class="panel-body">
                            <div id="expenditure-chart"></div>
                            <a href="#" class="btn btn-default btn-block">View Details</a>
                        </div>
                        <!-- /.panel-body -->
                    </div>
          
        </div>

    </div>
        <div class="row">
        <div class="col-md-6 col-lg-6">
             <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i> Enrolment of Foreign Students by Region
                        </div>
                        <div class="panel-body">
                            <div id="foreign_students"></div>
                            <a href="#" class="btn btn-default btn-block">View Details</a>
                        </div>
                        <!-- /.panel-body -->
                    </div>
          
        </div>
 <div class="col-md-6 col-lg-6">
             <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i> Students by Program Levels
                        </div>
                        <div class="panel-body">
                            <div id="student_program_levels"></div>
                            <a href="#" class="btn btn-default btn-block">View Details</a>
                        </div>
                        <!-- /.panel-body -->
                    </div>
          
        </div>

    </div>
    

                   <script>
                       function loaddata() {
                           Morris.Donut({
                               element: 'morris-donut-chart',
                               data: [
                                   {
                                       label: "Government Sponsored",
                                       value: 12000
                                   }, {
                                       label: "Self Sponsored",
                                       value: 1000
                                   }
                               ],
                               resize: true
                           });
                           Morris.Donut({
                               element: 'revenue-chart',
                               data: [
                                   {
                                       label: "Grants from Government",
                                       value: 2000
                                   }, {
                                       label: "Recurrent Allocation",
                                       value: 1000
                                   }, {
                                       label: "Development Allocation",
                                       value: 1000
                                   }, {
                                       label: "Grants from Development Partners",
                                       value: 1000
                                   }, {
                                       label: "Research Grants",
                                       value: 1000
                                   }
                               ],
                               resize: true
                           }); Morris.Donut({
                               element: 'expenditure-chart',
                               data: [
                                   {
                                       label: "Salaries and Wages",
                                       value: 3000
                                   }, {
                                       label: "Operations and Maintenance",
                                       value: 1000
                                   }, {
                                       label: "Other Expenditure",
                                       value: 1000
                                   }, {
                                       label: "Acquisition of non financial assets",
                                       value: 1000
                                   }, {
                                       label: "Other development",
                                       value: 1000
                                   }
                               ],
                               resize: true
                           });Morris.Donut({
                               element: 'foreign_students',
                               data: [
                                   {
                                       label: "Sub-Saharan Africa",
                                       value: 3000
                                   }, {
                                       label: "Europe",
                                       value: 1000
                                   }, {
                                       label: "Northern Africa",
                                       value: 1000
                                   }, {
                                       label: "Oceania",
                                       value: 1000
                                   }, {
                                       label: "Western Europe",
                                       value: 1000
                                   }
                               ],
                               resize: true
                           });Morris.Donut({
                               element: 'student_program_levels',
                               data: [
                                   {
                                       label: "Doctorate",
                                       value: 3000
                                   }, {
                                       label: "Masters",
                                       value: 1000
                                   }, {
                                       label: "Bachelors",
                                       value: 1000
                                   }, {
                                       label: "Postgraduate Diploma",
                                       value: 1000
                                   }, {
                                       label: "Diploma",
                                       value: 1000
                                   }, {
                                       label: "Certificate",
                                       value: 1000
                                   }
                               ],
                               resize: true
                           });
                           Morris.Bar({
                               element: 'morris-bar-chart',
                               data: [{
                                   y: 'Education',
                                   a: 100,
                                   b: 90,
                                   c: 90
                               }, {
                                   y: 'Arts & Humanities',
                                   a: 75,
                                   b: 65,
                                   c: 90
                               }, {
                                   y: 'Social Sciences',
                                   a: 50,
                                   b: 40,
                                   c: 90
                               }, {
                                   y: 'Business, Administration ',
                                   a: 75,
                                   b: 65,
                                   c: 90
                               }, {
                                   y: 'Natural Sciences',
                                   a: 50,
                                   b: 40,
                                   c: 90
                               }, {
                                   y: 'ICT',
                                   a: 75,
                                   b: 65,
                                   c: 90
                               }, {
                                   y: 'Engineering',
                                   a: 100,
                                   b: 90,
                                   c: 90
                               }, {
                                   y: 'Agriculture',
                                   a: 100,
                                   b: 90,
                                   c: 90
                               }, {
                                   y: 'Health & Welfare',
                                   a: 100,
                                   b: 90,
                                   c: 90
                               }, {
                                   y: 'Services',
                                   a: 100,
                                   b: 90,
                                   c: 90
                               }],
                               xkey: 'y',
                               ykeys: ['a', 'b','c'],
                               labels: ['Publications', 'Innovations', 'Patents'],
                               hideHover: 'auto',
                               resize: true
                           });
                           Morris.Bar({
                               element: 'student_by_county',
                               data: [{
                                   y: 'Mombasa',
                                   a: 100
                                  
                               }, {
                                   y: 'Baringo',
                                   a: 75
                               }, {
                                   y: 'Bomet',
                                   a: 50
                               }, {
                                   y: 'Bungoma',
                                   a: 75
                               }, {
                                   y: 'Busia',
                                   a: 50
                               }, {
                                   y: 'Elgeyo - Marakwet',
                                   a: 75
                               }, {
                                   y: 'Embu',
                                   a: 100
                               }, {
                                   y: 'Garissa',
                                   a: 100
                               }, {
                                   y: 'Homa Bay',
                                   a: 100
                               }, {
                                   y: 'Isiolo',
                                   a: 100
                               }, {
                                   y: 'Baringo',
                                   a: 75
                               }, {
                                   y: 'Bomet',
                                   a: 50
                               }, {
                                   y: 'Bungoma',
                                   a: 75
                               }, {
                                   y: 'Busia',
                                   a: 50
                               }, {
                                   y: 'Elgeyo - Marakwet',
                                   a: 75
                               }, {
                                   y: 'Embu',
                                   a: 100
                               }, {
                                   y: 'Garissa',
                                   a: 100
                               }, {
                                   y: 'Homa Bay',
                                   a: 100
                               }, {
                                   y: 'Isiolo',
                                   a: 100
                               }, {
                                   y: 'Baringo',
                                   a: 75
                               }, {
                                   y: 'Bomet',
                                   a: 50
                               }, {
                                   y: 'Bungoma',
                                   a: 75
                               }, {
                                   y: 'Busia',
                                   a: 50
                               }, {
                                   y: 'Elgeyo - Marakwet',
                                   a: 75
                               }, {
                                   y: 'Embu',
                                   a: 100
                               }, {
                                   y: 'Garissa',
                                   a: 100
                               }, {
                                   y: 'Homa Bay',
                                   a: 100
                               }, {
                                   y: 'Isiolo',
                                   a: 100
                               }, {
                                   y: 'Baringo',
                                   a: 75
                               }, {
                                   y: 'Bomet',
                                   a: 50
                               }, {
                                   y: 'Bungoma',
                                   a: 75
                               }, {
                                   y: 'Busia',
                                   a: 50
                               }, {
                                   y: 'Elgeyo - Marakwet',
                                   a: 75
                               }, {
                                   y: 'Embu',
                                   a: 100
                               }, {
                                   y: 'Garissa',
                                   a: 100
                               }, {
                                   y: 'Homa Bay',
                                   a: 100
                               }, {
                                   y: 'Isiolo',
                                   a: 100
                               }, {
                                   y: 'Baringo',
                                   a: 75
                               }, {
                                   y: 'Bomet',
                                   a: 50
                               }, {
                                   y: 'Bungoma',
                                   a: 75
                               }, {
                                   y: 'Busia',
                                   a: 50
                               }, {
                                   y: 'Elgeyo - Marakwet',
                                   a: 75
                               }, {
                                   y: 'Embu',
                                   a: 100
                               }, {
                                   y: 'Garissa',
                                   a: 100
                               }, {
                                   y: 'Homa Bay',
                                   a: 100
                               }, {
                                   y: 'Isiolo',
                                   a: 100
                               }],
                               xkey: 'y',
                               ykeys: ['a'],
                               labels: ['Students'],
                               hideHover: 'auto',
                               resize: true
                           });
                       }
                   </script>
     <script>
        $(document).ready(function () {
            loaddata();
        });
    </script>
    <% }
          else
          {
              %>
    <div class="row" style="margin: 10px;">
        <div class="panel panel-default">
            <div class="panel-heading">Profile</div>
            <div class="panel-body">
            <table class="table table-bordered table-striped">
                <%
                    var nav = Config.ReturnNav();
                    int code = Convert.ToInt32( Session["Code"]);
                    var users = nav.UniversitySignup.Where(r => r.Code == code);
                    foreach (var user in users)
                    {%>
                    <tr><td>Proposed Name:</td><td><%=user.Proposed_Name %></td></tr>
                    <tr><td>Principal Academic Focus:</td><td><%=user.Domain_Description %></td></tr>
                    <tr><td>Ministry of Education Code:</td><td><%=user.Ministry_of_Education_Code %></td></tr>
                    <tr><td>KRA PIN:</td><td><%=user.Kra_Pin %></td></tr>
                    <tr><td>Proposed Location:</td><td><%=user.Proposed_Location %></td></tr>
                    <tr><td>Sponsor:</td><td><%=user.Sponsor %></td></tr>
                    <tr><td>County:</td><td><%=user.County_Name %></td></tr>
                    <tr><td>Constituency:</td><td><%=user.ConstituencyName %></td></tr>
                    <tr><td>Post Address:</td><td><%=user.Post_Address %></td></tr>
                    <tr><td>Post Code:</td><td><%=user.Post_Code %></td></tr>
                    <tr><td>Website:</td><td><%=user.Institution_Website %></td></tr>
                    <tr><td>Phone Number:</td><td><%=user.Phone_Number %></td></tr>
                    <tr><td>Email Address:</td><td><%=user.Email_Address %></td></tr>
                
                <%
                        
                    }
                     %>
            
             
            </table>

            </div>
        </div>
       
    </div>
    <%
          } %>
 </asp:Content>
