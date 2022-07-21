<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/ChooseServiceMaster.Master" CodeBehind="StaffRanksCodes.aspx.cs" Inherits="CicPortal.StaffRanksCodes" %>

<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <%
            var userType = Convert.ToString(Session["UserType"]);
            var univer = Convert.ToString(Session["UniversityCode"]);
            if (userType == "Data Officer")

            { %>
        <div class="panel panel-default">
            <div class="panel-heading">All University Staff Rank Codes</div>
            <div class="panel-body">
                <section>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="panel-body">
                                <h3><strong>University Education Management Information System (UEMIS) Codes</strong></h3>
                                <% 
                                    var nav = Config.ReturnNav();
                                %>
                                <table id="uniprogrammes" class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Staff Rank Code</th>
                                            <th>Staff Rank Name</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            var results = Config.ReturnNav();
                                            var ranks = nav.StaffRanks.ToArray();
                                            int count = 0;
                                            for (int i = 0; i < ranks.Count(); i++)
                                            {
                                                count++;
                                                var result = ranks[i];
                                        %>
                                        <tr>
                                            <td><% =count %></td>
                                            <td><%=result.Code%></td>
                                            <td><%=result.Description%></td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <th>#</th>
                                            <th>Staff Rank Code</th>
                                            <th>Staff Rank Name</th>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </div>
    <% 
        }
    %>
    <script>
        $(function () {
            $('#uniprogrammes').DataTable({
                "paging": true,
                "lengthChange": true,
                "searching": true,
                "ordering": true,
                "info": true,
                "autoWidth": true,
                dom: 'Bfrtip',
                buttons: [
                     {
                         extend: 'copy',
                         title: 'University Staff Rank Codes',
                         filename: 'Staff Rank Codes',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     },
                     {
                         extend: 'csv',
                         title: 'University Staff Rank Codes',
                         filename: 'Staff Rank Codes',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     },
                     {
                         extend: 'excel',
                         title: 'University Staff Rank Codes',
                         filename: 'Staff Rank Codes',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     },
                      {
                          extend: 'pdf',
                          title: 'University Staff Rank Codes',
                          filename: 'Staff Rank Codes',
                          orientation: 'Staff Rank Codes',
                          pageSize: 'LEGAL'
                      },
                     {
                         extend: 'print',
                         title: 'University Staff Rank Codes',
                         filename: 'Staff Rank Codes',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     }]
            });
        });
    </script>
</asp:Content>

