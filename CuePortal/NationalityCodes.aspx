<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/ChooseServiceMaster.Master" CodeBehind="NationalityCodes.aspx.cs" Inherits="CicPortal.NationalityCodes" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
           <%
               var userType = Convert.ToString(Session["UserType"]);
               var univer = Convert.ToString(Session["UniversityCode"]);
               if (userType == "Data Officer")

               { %>
<div class="panel panel-default">
<div class="panel-heading">All Nationaties Codes</div>
   <div class="panel-body">
    <section >
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
                    <th>Nationality  Code</th>
                    <th>Nationality Name</th>

                </tr>
                </thead>
                <tbody>
                <%
                    var results= Config.ReturnNav();
                    var nationalities= nav.Nationality;
                    int count = 0;
                    foreach (var national in nationalities)
                        {
                    count++;
                %>
                <tr>
                    <td><% =count %></td>
                    <td><%=national.Code%></td>
                    <td><%=national.Name%></td>
                </tr>
                 <% } %>
                </tbody>
                <tfoot>
                <tr>
                    <th>#</th>
                   <th>Nationality Code</th>
                    <th>Nationality  Name</th>
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
                         title: 'Nationalities Codes',
                         filename: 'Nationalities Codes',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     },
                     {
                         extend: 'csv',
                         title: 'Nationalities Codes',
                         filename: 'Nationalities Codes',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     },
                     {
                         extend: 'excel',
                         title: 'Nationalities Codes',
                         filename: 'Nationalities Codes',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     },
                      {
                          extend: 'pdf',
                          title: 'Nationalities Codes',
                          filename: 'Nationalities Codes',
                          orientation: 'landscape',
                          pageSize: 'LEGAL'
                      },
                     {
                         extend: 'print',
                         title: 'Nationalities Codes',
                         filename: 'Nationalities Codes',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     }]
            });
        });
</script>
</asp:Content>