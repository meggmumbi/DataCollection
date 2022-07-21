<%@ Page Title="" Language="C#" MasterPageFile="~/AccreditationMaster.Master" AutoEventWireup="true" CodeBehind="InstitutionAccTechnicalReports.aspx.cs" Inherits="CicPortal.InstitutionAccTechnicalReports" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <div class="row">
            <div class="col-md-12 col-lg-12">
                  <div class="panel panel-default">
            <div class="panel-heading">Technical Reports</div>
                <div class="panel-body">
                    <div id ="feedback" runat="server"></div>
                     <table class="table table-striped table-bordered table-hover dataTable2"  id="dataTables-example">
                       <thead>
                         <tr>
                            <th>Document No</th>
                            <th>Institution Name</th>
                            <th>Date</th>
                            <th>Download Report</th>
                            <th>Recommendation Reporting</th>
                         </tr>
                         </thead>
                         <tbody>
                         <%
                             var nav = Config.ReturnNav();
                             var programs = nav.SiteInspectionComments.Where(r => r.Institution_No == Convert.ToString(Session["UniversityCode"]) && r.Status == "Completed");
                             foreach (var program in programs)
                             {
                             %>
                             <tr>
                                 <td><%=program.Code %></td>
                                 <td><%=program.Institution_Name %></td>
                                 <td><%= Convert.ToDateTime(program.Date_Created).ToString("dd/MM/yyyy") %></td>
                                 <td><a href="OverallInspectionReport.aspx?docNo=<%=program.Code %>" class="btn btn-success"><i class="fa fa-eye"></i> View Report</a></td>
                                 <td><a href="SiteInspectionRecommendation.aspx?docNo=<%=program.Code %>" class="btn btn-success"><i class="fa fa-plus"></i> Recommendation Reporting</a></td>
                             </tr>
                             <%
                            }
                         %>
                         </tbody>
                     </table>   
                    </div> 
 
                </div>
                <br />
                     <asp:Button runat="server" style="margin-left:2%" CssClass="btn btn-warning" Text="Go To Homepage" ID="GoToHomepage"/>
                <br />
                <br />
            </div>
           </div>
         </div>
</asp:Content>
