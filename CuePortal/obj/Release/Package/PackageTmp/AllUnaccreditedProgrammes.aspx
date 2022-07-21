<%@ Page Title="" Language="C#" MasterPageFile="~/ChooseServiceMaster.Master" AutoEventWireup="true" CodeBehind="AllUnaccreditedProgrammes.aspx.cs" Inherits="CicPortal.AllUnaccreditedProgrammes" %>

<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Home.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">Unaccredited Programmes</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">Unaccredited Programmes</div>

        <div class="panel-body">
            <div id="feedback" runat="server"></div>
            <table class="table table-bordered table-striped table-hover" id="dataTables_1">
                <thead>
                    <tr>
                        <th>Code</th>
                        <th>Description</th>
                        <th>Programme Level</th>

                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = Config.ReturnNav();
                        var programs1 = nav.Programs.Where(r => r.Accreditation_Status == "Unaccredited" && r.Institution_Code == Convert.ToString(Session["UniversityCode"]));
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
    <script>
        $(document).ready(function () {
            $('#dataTables_1').DataTable({
                responsive: true,
                "pageLength": 50
            });
        });
    </script>
</asp:Content>
