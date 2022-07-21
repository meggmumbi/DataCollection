<%@ Page Title="" Language="C#" MasterPageFile="~/ChooseServiceMaster.Master" AutoEventWireup="true" CodeBehind="AllSubmittedProgrammes.aspx.cs" Inherits="CicPortal.AllSubmittedProgrammes" %>

<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Home.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">Submitted Programmes</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">Submitted Programmes</div>

        <div class="panel-body">
            <div id="feedback" runat="server"></div>
            <table class="table table-bordered table-striped table-hover dataTable2">
                <thead>
                    <tr>
                        <th>Description</th>
                        <th>Programme Level</th>

                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = Config.ReturnNav();
                        var programs1 = nav.ProgramAccreditation.Where(r => r.Institution_No == Convert.ToString(Session["UniversityCode"]));
                        foreach (var program in programs1)
                        {
                    %>
                    <tr>
                        <td><%=program.Program_Name %></td>
                        <td><%=program.Program_Level %></td>
                    </tr>
                    <%

                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
