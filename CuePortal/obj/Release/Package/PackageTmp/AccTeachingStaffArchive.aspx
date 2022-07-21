<%@ Page Title="" Language="C#" MasterPageFile="~/AccreditationMaster.Master" AutoEventWireup="true" CodeBehind="AccTeachingStaffArchive.aspx.cs" Inherits="CicPortal.AccTeachingStaffArchive" %>
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
                        <a href="TerminatedPrograms.aspx">
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
                  List of Approved University Teaching Staff 
                </div>
                <div class="panel-body">
                    <table class="table table-bordered table-striped dataTable2">
                        <thead>
                            <tr>
                                <th>Staff ID</th>
                                <th>Staff Name</th>
                                <th>Ethnicity</th>
                                <th>Nationality</th>
                                <th>Payroll No</th>
                                <th>Highest Academic Qualification</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                    <%
                        String UniversityCode = Convert.ToString(Session["UniversityCode"]);

                        string AllData = new Config().ObjNav().FnGetAccademicStaff(UniversityCode);
                        String[] info = AllData.Split(new string[] { ":" }, StringSplitOptions.RemoveEmptyEntries);
                        if (info != null)
                        {
                            foreach (var allInfo in info)
                            {
                                String[] Lineinfo = allInfo.Split('*');
                                var ID_Passport_No = Lineinfo[0];
                                var FullName = Lineinfo[1];
                                var Ethnic_Background = Lineinfo[2];
                                var Nationality = Lineinfo[3];
                                var Payroll_No = Lineinfo[4];
                                var Highest_Academic_Qualification = Lineinfo[5];
                                var Approval_Status = Lineinfo[6];

                                    %>
                                    <tr>
                                        <td><% =ID_Passport_No %></td>
                                        <td><% =FullName %></td>
                                        <td><% =Ethnic_Background %></td>
                                        <td><% =Nationality %></td>
                                        <td><% =Payroll_No %></td>
                                        <td><% =Highest_Academic_Qualification %></td>
                                        <td><% =Approval_Status %></td>                                     
                                    </tr>
                                    <% 
                            }
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
