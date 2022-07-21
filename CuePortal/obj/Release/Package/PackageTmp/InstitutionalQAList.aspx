<%@ Page Title="" Language="C#" MasterPageFile="~/QAMaster.Master" AutoEventWireup="true" CodeBehind="InstitutionalQAList.aspx.cs" Inherits="CicPortal.InstitutionalQAList" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">Open Institutional Quality Audit List</div>
        <div class="panel-body">
            <table class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>Quality Audit No.</th>
                    <th>Institutional No.</th>
                    <th>Institutional Name</th>
                    <th>Application Date</th>
                    <th>Edit</th>
                </tr>
                </thead>
                <tbody>
                <% var nav = Config.ReturnNav();
                   var applications = nav.Institutional_Quality_Audit.Where(r => r.Institution_No == Convert.ToString(Session["UniversityCode"]));
                   foreach (var application in applications)
                   {
                     %>
                    <tr>
                        <td><%=application.Quality_Audit_No %></td>
                        <td><%=application.Institution_No %></td>
                        <td><%=application.Institution_Name %></td>
                        <td><%=application.Application_Date %></td>
                        <td><a href="InstitutionalQA.aspx?qa=<%=application.Quality_Audit_No %>" class="btn btn-success"><i class="fa fa-pencil"></i> Edit</a></td>
                    </tr>
                    <%  
                   }
                %>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
