<%@ Page Title="" Language="C#" MasterPageFile="~/ChooseServiceMaster.Master" AutoEventWireup="true" CodeBehind="AllAccreditedProgrammes.aspx.cs" Inherits="CicPortal.AllAccreditedProgrammes" %>

<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Home.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">CUE Accredited Programmes</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading"> CUE Accredited Programmes</div>

        <div class="panel-body">
            <div id="feedback" runat="server"></div>
            <table id="uniprogrammes1" class="table table-striped table-bordered table-hover">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Programme Code</th>
                        <th>Programme Name</th>
                        <th>University Code</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int count = 0;
                        var nav = Config.ReturnNav();
                        var program1 = nav.Programs.Where(t => t.Accreditation_Status == "CUE Accredited" && t.Institution_Code == (String)Session["UniversityCode"]).ToArray();
                        for (int i = 0; i < program1.Count(); i++)
                        {
                            count++;
                            var result = program1[i];
                    %>
                    <tr>
                        <td><% =count %></td>
                        <td><%=result.Code%></td>
                        <td><%=result.Description%></td>
                        <td><%=result.Institution_Code %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
    <script>
        //$(document).ready(function () {
        //    $('#dataTables_2').DataTable({
        //        responsive: true,
        //        "pageLength": 50
        //    });
        //});

        //
        $(function () {
            $('#uniprogrammes1').DataTable({
                "paging": true,
                "lengthChange": true,
                "searching": true,
                "ordering": true,
                "info": true,
                "autoWidth": true,
                "pageLength": 50,
                dom: 'Bfrtip',
                buttons: [
                     {
                         extend: 'copy',
                         title: 'University Programmes Codes',
                         filename: 'Programmes Codes',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     },
                     {
                         extend: 'csv',
                         title: 'University Programmes Codes',
                         filename: 'Programmes Codes',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     },
                     {
                         extend: 'excel',
                         title: 'University Programmes Codes',
                         filename: 'Programmes Codes',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     },
                      {
                          extend: 'pdf',
                          title: 'University Programmes Codes',
                          filename: 'Programmes Codes',
                          orientation: 'Programmes Codes',
                          pageSize: 'LEGAL'
                      },
                     {
                         extend: 'print',
                         title: 'University Programmes Codes',
                         filename: 'Programmes Codes',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     }]
            });
        });
    </script>
</asp:Content>
