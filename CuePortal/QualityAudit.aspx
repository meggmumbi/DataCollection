<%@ Page Title="" Language="C#" MasterPageFile="~/QAMaster.Master" AutoEventWireup="true" CodeBehind="QualityAudit.aspx.cs" Inherits="CicPortal.QualityAudit" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
      <%
          var nav2 = Config.ReturnNav();
          if (Convert.ToString(Session["type"]) == "old")
          {
               List<Int32> programLevelCount = new List<int>();
              List<String> programLevels = new List<String>();
              var nav = Config.ReturnNav();
      %>
   <div class="row">
        <div runat="server" id="feedback"></div>
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
                                    <div> Accredited Programmes</div>
                                </div>
                            </div>
                        </div>
                        <a href="AccPrograms.aspx">
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
                        <a href="AccTeachingStaffArchive.aspx">
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
                        <a href="AccCampuses.aspx">
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
                                            int prog = new Config().ObjNav().FnGetTerminatedPrograms(Convert.ToString(Session["UniversityCode"]));
                                             %>
                                        <% =prog %>
                                    </div>
                                    <div>Terminated Programmes</div>
                                </div>
                            </div>
                        </div>
                        <a href="AccPrograms.aspx">
                            <div class="panel-footer">
                                <span class="pull-left">View Details</span>
                                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>
                
            </div>
<%--       <div class="row">
            <div class="col-md-12 col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">Accredited Programmes</div>

                    <div class="panel-body">
                        <div id="Div1" runat="server"></div>
                        <table class="table table-bordered table-striped table-hover dataTable2">
                            <thead>
                                <tr>
                                    <th>Code</th>
                                    <th>Description</th>
                                    <th>Programme Level</th>

                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    var programs1 = nav.Programs.Where(r => r.Accreditation_Status == "CUE Accredited" && r.Institution_Code == Convert.ToString(Session["UniversityCode"]));
                                    foreach (var program in programs1)
                                    {
                                %>
                                <tr>
                                    <td><%=program.Code %></td>
                                    <td><%=program.Description %></td>
                                    <td><%=program.Program_Level %></td>
                                </tr>
                                <%

                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>--%>

    <%} %>
 </asp:Content>
