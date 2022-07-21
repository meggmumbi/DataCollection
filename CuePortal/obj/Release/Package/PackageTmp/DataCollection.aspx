<%@ Page Title="" Language="C#" MasterPageFile="~/DataCollectionMaster.Master" AutoEventWireup="true" CodeBehind="DataCollection.aspx.cs" Inherits="CicPortal.DataCollection" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
      <%
         var nav2 = Config.ReturnNav();
          if (Convert.ToString(Session["type"]) == "old")
          {
         var nav = Config.ReturnNav();
         string University_Code = Convert.ToString(Session["UniversityCode"]);
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
                                         <%
                                             int students =new Config().ObjNav().FnGetUniversityTotalStudents(University_Code);
                                          %>
                                        <% =students%>
                                    </div>
                                    <div>Very Large WSPs(>35000 connections) </div>
                                </div>
                            </div>
                        </div>
                        <a href="StudentsArchive.aspx">
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
                                            int academicStaff = new Config().ObjNav().FnGetUniversityTotalUniversityStaff(University_Code);
                                            %>
                                        <% =academicStaff %>
                                    </div>
                                    <div>Large WSPs(10,000-35,000 Connections)</div>
                                </div>
                            </div>
                        </div>
                        <a href="TeachingStaffArchive.aspx">
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
                                        <% int programs = new Config().ObjNav().FnGetUniversityTotalUniversityProgrammes(Convert.ToString(Session["UniversityCode"]));

                                            %>
                                        <% =programs %>
                                    </div>
                                    <div> Medium WSPs(5,000-9,999 Connections)</div>
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
                                        <%  int campuses = new Config().ObjNav().FnGetUniversityTotalUniversityCampuses(Convert.ToString(Session["UniversityCode"]));
                                       
                                             %>
                                            <%=campuses %>
                                    </div>
                                    <div>Small WSPS(<5000 Connections)</div>
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
    <div class="row">
         <div class="col-md-4 col-lg-4">
             <div class="panel panel-default">
                   <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i>Turnover and grouping of WSBs

                        </div>
                        <div class="panel-body">
                            <div id="domains-chart" style="position:center;right:0px;top:0px;"></div>
                        </div>
                    </div>
    
        </div>
        <div class="col-md-4 col-lg-4">
             <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i>Aggregated O+M Cost BreakDown for All Utilities
                        </div>
                        <div class="panel-body">
                            <div id="ranks-chart"></div>
                           
                        </div>
                    </div>
        </div>
         <div class="col-md-4 col-lg-4">
             <div class="panel panel-default">
                   <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i> Weights of Turnover and Grouping

                        </div>
                        <div class="panel-body">
                            <div id="gender-chart" style="position:center;right:0px;top:0px;"></div>
                        </div>
                    </div>
        </div>
   </div>

    <div class="row">
        
       <div class="col-md-4 col-lg-4">
             <div class="panel panel-default">
                   <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i> Baseline Comparison of Water Governance Sub-Indicators

                        </div>
                        <div class="panel-body">
                            <div id="year-chart" style="position:center;right:0px;top:0px;"></div>
                        </div>
                    </div>
        </div>
      <div class="col-md-4 col-lg-4">
             <div class="panel panel-default">
                   <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i> Weights of Water Governance Sub-Indicators

                        </div>
                        <div class="panel-body">
                            <div id="sponsor-chart" style="position:center;right:0px;top:0px;"></div>
                        </div>
                    </div>
    
        </div>
  </div>
  
    <%
        }
    %> 
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
    var options = {'title':'Weights of Water Governance Sub-Indicators',
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
        'Government':<% =  new Config().ObjNav().FnGetUniversityTotalGovernmentSponsoredStudents(Convert.ToString(Session["UniversityCode"]))%>,
        'Self': <% = new Config().ObjNav().FnGetUniversityTotalSelfSponsoredStudents(Convert.ToString(Session["UniversityCode"]))%>,
       
    };
        
    var rows = [];
    for (element in myData) {
        rows.push([element + " (" + myData[element] + ")", myData[element]])
    }
    data.addRows(rows);

  // Optional; add a title and set the width and height of the chart
    var options = {'title':'Weights of Water Governance Sub-Indicators',
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
    google.charts.load("current", {packages:['corechart']});
    google.charts.setOnLoadCallback(drawChart);
    function drawChart() {
      var data = google.visualization.arrayToDataTable([
        ["Students", "Total", { role: "style" } ],
        ["Year1",<% = new Config().ObjNav().FnGetUniversityTotalFirstYearStudents(Convert.ToString(Session["UniversityCode"]))%>, "#e60000"],
        ["Year2",<% = new Config().ObjNav().FnGetUniversityTotalSecondYearStudents(Convert.ToString(Session["UniversityCode"]))%>, "#6666ff"],
        ["Year3",<% = new Config().ObjNav().FnGetUniversityTotalThridYearStudents(Convert.ToString(Session["UniversityCode"]))%>, "#e67300"],
        ["Year4", <% = new Config().ObjNav().FnGetUniversityTotaFourthYearStudents(Convert.ToString(Session["UniversityCode"]))%>, "##9900e6"]
      ]);

      var view = new google.visualization.DataView(data);
      view.setColumns([0, 1,
                       { calc: "stringify",
                         sourceColumn: 1,
                         type: "string",
                         role: "annotation" },
                       2]);

      var options = {
          title: "Baseline Comparison of Water Governance Sub-Indicators",
        width: 250,
        height: 250,
        is3D: true,
        bar: {groupWidth: "95%"},
        legend: { position: "none" },
      };
      var chart = new google.visualization.ColumnChart(document.getElementById('year-chart'));
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
    var options = {'title':'Turnover and grouping of WSBs',
        'width':250, 
        'height':250,
        'is3D': true,
        'chartArea': {'width': '80%', 'height': '80%','left': '30','top': '30'},
        'legend': {'position': 'bottom'}
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
    var options = {'title':'Aggregated O+M Cost BreakDown for All Utilities',
        'width':250, 
        'height':250,
        'is3D': true,
        'chartArea': {'width': '80%', 'height': '80%','left': '30','top': '30'},
        'legend': {'position': 'bottom'}
    };

  // Display the chart inside the <div> element with id="piechart"
    var chart = new google.visualization.PieChart(document.getElementById('ranks-chart'));
  chart.draw(data, options);
}
</script>

 </asp:Content>
