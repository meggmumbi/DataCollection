<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/ChooseServiceMaster.Master" CodeBehind="ProgrammesCodes.aspx.cs" Inherits="CicPortal.ProgrammesCodes" %>

<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <%
            var userType = Convert.ToString(Session["UserType"]);
            var univer = Convert.ToString(Session["UniversityCode"]);
            if (userType == "Data Officer")

            { %>
        <div class="panel panel-default">
            <div class="panel-heading">All University Programmes Codes</div>
            <div class="panel-body">
                <section>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="panel-body">
                                <h3><strong>Accredited Programmes</strong></h3>
                                <% 
                                    var nav = Config.ReturnNav();
                                %>
                                <table id="uniprogrammes" class="table table-striped table-bordered table-hover">
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
                                            var results = Config.ReturnNav();
                                            var program = nav.Programs.Where(t => t.Accreditation_Status == "CUE Accredited" && t.Institution_Code == (String)Session["UniversityCode"]).ToArray();
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
                                            <td><%=result.Institution_Code %></td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="panel-body">
                                <h3><strong>Unaccredited Programmes</strong></h3>
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
                                            var program1 = nav.Programs.Where(t => t.Accreditation_Status == "Unaccredited" && t.Institution_Code == (String)Session["UniversityCode"]).ToArray();
                                            int count1 = 0;
                                            for (int i = 0; i < program1.Count(); i++)
                                            {
                                                count1++;
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
        //two
        $(function () {
            $('#uniprogrammes1').DataTable({
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

