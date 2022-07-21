<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/ChooseServiceMaster.Master" CodeBehind="CampusCodes.aspx.cs" Inherits="CicPortal.CampusCodes" %>

<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <%
            var userType = Convert.ToString(Session["UserType"]);
            var univer = Convert.ToString(Session["UniversityCode"]);
            if (userType == "Data Officer")

            { %>
        <div class="panel panel-default">
            <div class="panel-heading">All Campus Codes</div>
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
                                            <th>Campus  Code</th>
                                            <th>Campus Name</th>
                                            <th>University Code</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            var campus = nav.campuses.Where(t => t.Institution_Code == (String)Session["UniversityCode"]).ToArray();
                                            int count = 0;
                                            foreach (var camp in campus)
                                            {
                                                count++;
                                        %>
                                        <tr>
                                            <td><% =count %></td>
                                            <td><%=camp.No%></td>
                                            <td><%=camp.Description%></td>
                                            <td><%=camp.Institution_Code %></td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <th>#</th>
                                            <th>Campus Code</th>
                                            <th>Campus  Name</th>
                                            <th>University Code</th>
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
                         title: 'University Campus Codes',
                         filename: 'University Campus Codes',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     },
                     {
                         extend: 'csv',
                         title: 'University Campus Codes',
                         filename: 'University Campus Codes',
                         orientation: 'University Campus Codes',
                         pageSize: 'LEGAL'
                     },
                     {
                         extend: 'excel',
                         title: 'University Campus Codes',
                         filename: 'University Campus Codes',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     },
                      {
                          extend: 'pdf',
                          title: 'University Campus Codes',
                          filename: 'University Campus Codes',
                          orientation: 'landscape',
                          pageSize: 'LEGAL'
                      },
                     {
                         extend: 'print',
                         title: 'University Campus Codes',
                         filename: 'University Campus Codes',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     }]
            });
        });
    </script>
</asp:Content>
