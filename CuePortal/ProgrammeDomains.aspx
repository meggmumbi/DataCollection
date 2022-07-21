<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/ChooseServiceMaster.Master" CodeBehind="ProgrammeDomains.aspx.cs" Inherits="CicPortal.ProgrammeDomains" %>

<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <%
            var userType = Convert.ToString(Session["UserType"]);
            var univer = Convert.ToString(Session["UniversityCode"]);
            if (userType == "Data Officer")

            { %>
        <div class="panel panel-default">
            <div class="panel-heading">All University Programmes Domains Codes</div>
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
                                            <th>Domain Code</th>
                                            <th>Domain Description</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            var results = Config.ReturnNav();
                                            var program = nav.Programmes_Domains.ToList();
                                            int count = 0;
                                            for (int i = 0; i < program.Count(); i++)
                                            {
                                                count++;
                                                var result = program[i];
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
                                            <th>Programme Code</th>
                                            <th>Programme Name</th>
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
                         title: 'University Programmes Domains Codes',
                         filename: 'Programmes Domain Codes',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     },
                     {
                         extend: 'csv',
                         title: 'University Programmes Domains Codes',
                         filename: 'Programmes Domain Codes',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     },
                     {
                         extend: 'excel',
                         title: 'University Programmes Domains Codes',
                         filename: 'Programmes Domain Codes',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     },
                      {
                          extend: 'pdf',
                          title: 'University Programmes Domains Codes',
                          filename: 'Programmes Codes',
                          orientation: 'Programmes Domain Codes',
                          pageSize: 'LEGAL'
                      },
                     {
                         extend: 'print',
                         title: 'University Programmes Domains Codes',
                         filename: 'Programmes Domain Codes',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     }]
            });
        });
    </script>
</asp:Content>
