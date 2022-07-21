<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/ChooseServiceMaster.Master" CodeBehind="EthinicityCodes.aspx.cs" Inherits="CicPortal.EthinicityCodes" %>
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
               <table id="ethnicitydetails" class="table table-striped table-bordered table-hover">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Ethnicity  Code</th>
                    <th>Ethnicity Name</th>

                </tr>
                </thead>
                <tbody>
                <%
                    var results= Config.ReturnNav();
                    var ethnicities= nav.Ethnicity;
                    int count = 0;
                    foreach (var ethnicity in ethnicities)
                        {
                    count++;
                %>
                <tr>
                    <td><% =count %></td>
                    <td><%=ethnicity.Code%></td>
                    <td><%=ethnicity.Ethnicity_Background%></td>
                </tr>
                 <% } %>
                </tbody>
                <tfoot>
                <tr>
                    <th>#</th>
                    <th>Ethnicity Code</th>
                    <th>Ethnicity  Name</th>
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
    $('#ethnicitydetails').DataTable({
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
                         title: 'Ethnicity Codes',
                         filename: 'Ethnicity Codes',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     },
                     {
                         extend: 'csv',
                         title: 'Ethnicity Codes',
                         filename: 'Ethnicity Codes',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     },
                     {
                         extend: 'excel',
                         title: 'Ethnicity Codes',
                         filename: 'Ethnicity Codes',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     },
                      {
                          extend: 'pdf',
                          title: 'Ethnicity Codes',
                          filename: 'Ethnicity Codes',
                          orientation: 'landscape',
                          pageSize: 'LEGAL'
                      },
                     {
                         extend: 'print',
                         title: 'Ethnicity Codes',
                         filename: 'Ethnicity Codes',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     }]
            });
        });
</script>
</asp:Content>