<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/ChooseServiceMaster.Master" CodeBehind="DisabilitiesCodes.aspx.cs" Inherits="CicPortal.DisabilitiesCodes" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
           <%
               var userType = Convert.ToString(Session["UserType"]);
               var univer = Convert.ToString(Session["UniversityCode"]);
               if (userType == "Data Officer")

               { %>
<div class="panel panel-default">
<div class="panel-heading">All Disabilities Codes</div>
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
                    <th>Disability  Code</th>
                    <th>Disability Name</th>
                </tr>
                </thead>
                <tbody>
                <%
                    var results= nav.Disability;
                    int count = 0;
                    foreach (var disable in results)
                        {
                    count++;
                %>
                <tr>
                    <td><% =count %></td>
                    <td><%=disable.Code%></td>
                    <td><%=disable.Description%></td>
                </tr>
                 <% } %>
                </tbody>
                <tfoot>
                <tr>
                    <th>#</th>
                    <th>Disability Code</th>
                    <th>Disability Name</th>
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
                         title: 'Disabilities Codes',
                         filename: 'Disabilities Codes',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     },
                     {
                         extend: 'csv',
                         title: 'Disabilities Codes',
                         filename: 'Disabilities Codes',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     },
                     {
                         extend: 'excel',
                         title: 'Disabilities Codes',
                         filename: 'Disabilities Codes',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     },
                      {
                          extend: 'pdf',
                          title: 'Disabilities Codes',
                          filename: 'Disabilities Codes',
                          orientation: 'landscape',
                          pageSize: 'LEGAL'
                      },
                     {
                         extend: 'print',
                         title: 'Disabilities Codes',
                         filename: 'Disabilities Codes',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     }]
            });
        });
</script>
</asp:Content>
