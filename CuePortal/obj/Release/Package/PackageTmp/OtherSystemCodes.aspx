<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OtherSystemCodes.aspx.cs" MasterPageFile="~/ChooseServiceMaster.Master" Inherits="CicPortal.OtherSystemCodes" %>
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
               <p><strong>Sponsorship Codes</strong></p>
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
                 <tr>
                    <td>3</td>
                    <td>Other</td>
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
               <p><strong>Students Status Codes</strong></p>               
               <table id="statuscodes" class="table table-striped table-bordered table-hover">
                <thead>
                <tr>
                    <th>Status Code</th>
                    <th>Status Name</th>
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
                    <td>Deferred</td>
                </tr>
                         <tr>
                    <td>6</td>
                    <td>Expelled</td>
                </tr>
                </tbody>
                <tfoot>
                <tr>
                    <th>Status Code</th>
                    <th>Status Name</th>
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
                <p><strong>Students Residents Codes</strong></p>   
               <table id="termsofservicecodes" class="table table-striped table-bordered table-hover">
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
         <section >
        <div class="row">
        <div class="col-md-12">
            <div class="panel-body">
                <p><strong>Publication Type Codes</strong></p>   
               <table id="" class="table table-striped table-bordered table-hover">
                <thead>
                <tr>
                    <th> Code</th>
                    <th>Publication Type</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>0</td>
                    <td>None</td>
                </tr>
                <tr>
                    <td>1</td>
                    <td>Book</td>
                </tr>
                     <tr>
                    <td>2</td>
                    <td>Journal</td>
                </tr>
                       <tr>
                    <td>3</td>
                    <td>Audio-Visual</td>
                </tr>
                </tbody>
                <tfoot>
                <tr>
                    <th> Code</th>
                    <th>Publication Type</th>
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
                <p><strong>Terms of Service Codes</strong></p>   
               <table id="residents" class="table table-striped table-bordered table-hover">
                <thead>
                <tr>
                    <th>Terms of Service Code</th>
                    <th>Terms of Service Name</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>1</td>
                    <td>Full Time</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Part Time</td>
                </tr>
                </tbody>
                <tfoot>
                <tr>
                    <th>Terms of Service Code</th>
                    <th>Terms of Service Name</th>
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
                <p><strong>Gender Codes</strong></p>   
               <table id="residents" class="table table-striped table-bordered table-hover">
                <thead>
                <tr>
                    <th>Gender Code</th>
                    <th>Gender Name</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>1</td>
                    <td>Male</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Female</td>
                </tr>
                  <tr>
                    <td>3</td>
                    <td>Intersex</td>
                </tr>
                </tbody>
                <tfoot>
                <tr>
                   <th>Gender Code</th>
                    <th>Gender Name</th>
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
                <p><strong>Part Time Staff Category Codes</strong></p>   
               <table id="residents" class="table table-striped table-bordered table-hover">
                <thead>
                <tr>
                    <th>Category Code</th>
                    <th> Name</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>1</td>
                    <td>Internal</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>External</td>
                </tr>
                  <tr>
                    <td>3</td>
                    <td>None</td>
                </tr>
                </tbody>
                <tfoot>
                <tr>
                   <th>Category Code</th>
                    <th>Name</th>
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
                <p><strong>Disciplinary Verdict Codes</strong></p>   
               <table id="disciplinarycodes" class="table table-striped table-bordered table-hover">
                <thead>
                <tr>
                    <th>Verdict Code</th>
                    <th>Verdict Name</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>1</td>
                    <td>Warning</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Expulsion</td>
                </tr>
                  <tr>
                    <td>3</td>
                    <td>Suspension</td>
                </tr>
                  <tr>
                    <td>4</td>
                    <td>Others</td>
                </tr>
                </tbody>
                <tfoot>
                <tr>
                    <th>Verdict Code</th>
                    <th>Verdict Name</th>
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
                <p><strong> Highest Academic Qualifications Codes</strong></p>   
               <table id="residents" class="table table-striped table-bordered table-hover">
                <thead>
                <tr>
                    <th>Highest Academic Qualifiations Code</th>
                     <th>Highest Academic Qualifiations Name</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>1</td>
                    <td>Bachelors</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Masters</td>
                </tr>
                     <tr>
                    <td>3</td>
                    <td>Doctorate</td>
                </tr>
                     <tr>
                    <td>4</td>
                    <td>Postgraduate Diploma</td>
                </tr>
                     <tr>
                    <td>5</td>
                    <td>Diploma</td>
                </tr>
                 <tr>
                    <td>6</td>
                    <td>Certificate</td>
                </tr>
                 <tr>
                    <td>7</td>
                    <td>None</td>
                </tr>
                </tbody>
                <tfoot>
                <tr>
                    <th>Highest Academic Qualifiations Code</th>
                    <th>Highest Academic Qualifiations Name</th>
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
                         title: 'Sponsorship Codes ',
                         filename: 'Sponsorship Codes ',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     },
                     {
                         extend: 'csv',
                         title: 'Sponsorship Codes ',
                         filename: 'Sponsorship Codes ',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     },
                     {
                         extend: 'excel',
                         title: 'Sponsorship Codes ',
                         filename: 'Sponsorship Codes ',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     },
                      {
                          extend: 'pdf',
                          title: 'Sponsorship Codes ',
                          filename: 'Sponsorship Codes ',
                          orientation: 'landscape',
                          pageSize: 'LEGAL'
                      },
                     {
                         extend: 'print',
                         title: 'Sponsorship Codes ',
                         filename: 'Sponsorship Codes ',
                         orientation: 'landscape',
                         pageSize: 'LEGAL'
                     }]
            });
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
             title: 'Students Status',
             filename: 'Students Status',
             orientation: 'landscape',
             pageSize: 'LEGAL'
         },
         {
             extend: 'csv',
             title: 'Students Status',
             filename: 'Students Status',
             orientation: 'landscape',
             pageSize: 'LEGAL'
         },
         {
             extend: 'excel',
             title: 'Students Status',
             filename: 'Students Status',
             orientation: 'landscape',
             pageSize: 'LEGAL'
         },
          {
              extend: 'pdf',
              title: 'Students Status',
              filename: 'Students Status',
              orientation: 'landscape',
              pageSize: 'LEGAL'
          },
         {
             extend: 'print',
             title: 'Students Status',
             filename: 'Students Status',
             orientation: 'landscape',
             pageSize: 'LEGAL'
         }]
});
$('#termsofservicecodes').DataTable({
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
             title: 'Terms of Service',
             filename: 'Terms of Service',
             orientation: 'landscape',
             pageSize: 'LEGAL'
         },
         {
             extend: 'csv',
             title: 'Terms of Service',
             filename: 'Terms of Service',
             orientation: 'landscape',
             pageSize: 'LEGAL'
         },
         {
             extend: 'excel',
             title: 'Terms of Service',
             filename: 'Terms of Service',
             orientation: 'landscape',
             pageSize: 'LEGAL'
         },
          {
              extend: 'pdf',
              title: 'Terms of Service',
              filename: 'Terms of Service',
              orientation: 'landscape',
              pageSize: 'LEGAL'
          },
         {
             extend: 'print',
             title: 'Terms of Service',
             filename: 'Tutor Rate',
             orientation: 'landscape',
             pageSize: 'LEGAL'
         }]
});
</script>
</asp:Content>


