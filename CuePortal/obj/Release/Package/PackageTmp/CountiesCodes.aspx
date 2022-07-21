<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/ChooseServiceMaster.Master" CodeBehind="CountiesCodes.aspx.cs" Inherits="CicPortal.CountiesCodes" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
           <%
               var userType = Convert.ToString(Session["UserType"]);
               var univer = Convert.ToString(Session["UniversityCode"]);
               if (userType == "Data Officer")

               { %>
<div class="panel panel-default">
<div class="panel-heading">All National County Codes</div>
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
                    <th>County Code</th>
                    <th>County Name</th>
                </tr>
                </thead>
                <tbody>
                <%
                    var results= Config.ReturnNav();
                    var counties= nav.homecounties;
                    int count = 0;
                    foreach (var county in counties)
                        {
                    count++;
                %>
                <tr>
                    <td><% =count %></td>
                    <td><%=county.Code%></td>
                    <td><%=county.County_Name%></td>
                </tr>
                 <% } %>
                </tbody>
                <tfoot>
                <tr>
                    <th>#</th>
                   <th>County Code</th>
                    <th>County Name</th>
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
                         title: 'Counties Codes',
                         filename: 'Counties Codes',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     },
                     {
                         extend: 'csv',
                         title: 'Counties Codes',
                         filename: 'Counties Codes',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     },
                     {
                         extend: 'excel',
                         title: 'Counties Codes',
                         filename: 'Counties Codes',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     },
                      {
                          extend: 'pdf',
                          title: 'Counties Codes',
                          filename: 'Counties Codes',
                          orientation: 'landscape',
                          pageSize: 'LEGAL'
                      },
                     {
                         extend: 'print',
                         title: 'Counties Codes',
                         filename: 'Counties Codes',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     }]
            });
        });
</script>
</asp:Content>
