<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/ChooseServiceMaster.Master"  CodeBehind="UniversitiesCodes.aspx.cs" Inherits="CicPortal.UniversitiesCodes" %>
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
    <section >
        <div class="row">
        <div class="col-md-12">
            <div class="panel-body">
                <h2><strong>University Education Management System Codes</strong></h2>
                <% 
                    var nav = Config.ReturnNav();
                %>
               <table id="uniprogrammes" class="table table-striped table-bordered table-hover">
                <thead>
                <tr>
                    <th>Programme Code</th>
                    <th>Programme Name</th>
                </tr>
                </thead>
                <tbody>
                <%
                    var results= Config.ReturnNav();
                       var program= nav.Programs.Where(t=>t.Institution_Code==(String)Session["UniversityCode"]).ToArray();
                        
                    for (int i = 0; i < program.Count(); i++)
                    {
                        var result = program[i];
                %>
                <tr>
                    <td><%=result.Code%></td>
                    <td><%=result.Description%></td>=
                </tr>
                 <% } %>
               
                </tbody>
                <tfoot>
                <tr>
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
                         title: 'Tutor Rate',
                         filename: 'Tutor Rate',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     },
                     {
                         extend: 'csv',
                         title: 'Tutor Rate',
                         filename: 'Tutor Rate',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     },
                     {
                         extend: 'excel',
                         title: 'Tutor Rate',
                         filename: 'Tutor Rate',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     },
                      {
                          extend: 'pdf',
                          title: 'Tutor Rate',
                          filename: 'Tutor Rate',
                          orientation: 'landscape',
                          pageSize: 'LEGAL'
                      },
                     {
                         extend: 'print',
                         title: 'Tutor Rate',
                         filename: 'Tutor Rate',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     }]
            });
        });
</script>
</asp:Content>

