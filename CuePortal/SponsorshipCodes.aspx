<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SponsorshipCodes.aspx.cs" Inherits="CicPortal.SponsorshipCodes" %>
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
               
               <table id="uniprogrammes" class="table table-striped table-bordered table-hover">
                <thead>
                <tr>
                    <th>Sponsorship Code</th>
                    <th>Sponsorship Name</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>1</td>
                    <td>Government Sponsored</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Self Sponsored</td>
                </tr>
                </tbody>
                <tfoot>
                <tr>
                    <th>Sponsorship Code</th>
                    <th>Sponsorship Name</th>
                </tr>
              </table>
            </div>
        </div>
       </div>
      </section>
        <section >
        <div class="row">
        <div class="col-md-12">
            <div class="panel-body">
                <h2><strong>University Education Management System Codes</strong></h2>
               
               <table id="statuscodes" class="table table-striped table-bordered table-hover">
                <thead>
                <tr>
                    <th>Students Code</th>
                    <th>Students Name</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>1</td>
                    <td>Active</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Deceased</td>
                </tr>
                     <tr>
                    <td>3</td>
                    <td>Transfered</td>
                </tr>
                     <tr>
                    <td>4</td>
                    <td>Absconded</td>
                </tr>
                     <tr>
                    <td>5</td>
                    <td>Deferement</td>
                </tr>
                         <tr>
                    <td>6</td>
                    <td>Expelled</td>
                </tr>
                </tbody>
                <tfoot>
                <tr>
                    <th>Students Code</th>
                    <th>Students Name</th>
                </tr>
              </table>
            </div>
        </div>
       </div>
      </section>
        <section >
        <div class="row">
        <div class="col-md-12">
            <div class="panel-body">
                <h2><strong>University Education Management System Codes</strong></h2>
               
               <table id="residents" class="table table-striped table-bordered table-hover">
                <thead>
                <tr>
                    <th>Residents Code</th>
                    <th>Residents Name</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>1</td>
                    <td>University Accommodation</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Private Accommodation</td>
                </tr>
                     <tr>
                    <td>3</td>
                    <td>University Partnership</td>
                </tr>
                </tbody>
                <tfoot>
                <tr>
                     <th>Residents Code</th>
                    <th>Residents Name</th>
                </tr>
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
$('#residents').DataTable({
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
$('#statuscodes').DataTable({
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
</script>
</asp:Content>

