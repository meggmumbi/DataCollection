<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/DataCollectionMaster.Master" CodeBehind="DisciplineArchive.aspx.cs" Inherits="CicPortal.DisciplineArchive" %>

<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%
        var userType = Convert.ToString(Session["UserType"]);
        List<Int32> programLevelCount = new List<int>();
        List<String> programLevels = new List<String>();
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
                                         <%
                                             int students =new Config().ObjNav().FnGetUniversityTotalStudents(Convert.ToString(Session["UniversityCode"]));
                                          %>
                                        <% =students%>
                                    </div>
                                    <div>Students Enrolled</div>
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
                                            int academicStaff = new Config().ObjNav().FnGetUniversityTotalUniversityStaff(Convert.ToString(Session["UniversityCode"]));
                                            %>
                                        <% =academicStaff %>
                                    </div>
                                    <div>Teaching Staff</div>
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
                                    <div> All Programmes</div>
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
 <div class="row">
        <div class="col-md-12 col-lg-12">
            <div class="panel panel-green">
                <div class="panel-heading">
                 University Discipline Cases List
                </div>
                <div class="panel-body">
                    <table class="table table-bordered table-striped dataTable2">
                        <thead>
                            <tr>
                            <th>Case Id</th>
                            <th>Students ID</th>
                            <th>Student Name</th>
                            <th>Discipline Description</th>
                            <th>Date</th>
                            <th>Verdict</th>
                            <th>Verdict Date</th>
                            <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                var disciplinecases = nav.DisciplineCases.Where(r => r.University == Convert.ToString(Session["UniversityCode"])&&r.Approval_Status=="Approved");
                                foreach (var disciplinecase in disciplinecases)
                                {
                            %>
                            <tr>
                                <td><%=disciplinecase.Case_Id %></td>
                                <td><%=disciplinecase.Student_Id %></td>
                                <td><%=disciplinecase.First_Name %></td>
                                <td><%=disciplinecase.Case_Description %></td>
                                <td><%=disciplinecase.Date %></td>
                                <td><%=disciplinecase.Verdict_Category %></td>
                                <td><%=disciplinecase.Verdict_Date %></td>  
                                <td><%=disciplinecase.Approval_Status %></td>                               
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
    <%} %>
</asp:Content>
