<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AccreditationMaster.Master" CodeBehind="InstitutionsDraftApplications.aspx.cs" Inherits="CicPortal.InstitutionsDraftApplications" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <div class="row">
            <div class="col-md-12 col-lg-12">
                  <div class="panel panel-default">
            <div class="panel-heading">Unsubmitted Applications</div>
   
                <div class="panel-body">
                    <div id ="feedback" runat="server"></div>
                    <table class="table table-bordered table-striped dataTable">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Acccreditation No</th>
                    <th>Institution Type</th>
                    <th>Institution Name</th>
                    <th>Location</th>
                    <th>Sponsor</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <%
                     var nav = Config.ReturnNav();
                    var details = nav.InstitutionAccreditation.Where(r => r.Institution_No == Convert.ToString(Session["UniversityCode"]) &&r.Status=="Open");
                    string university = Convert.ToString(Session["UniversityCode"]);
                    int programesCounter = 0;
                    foreach (var detail in details)
                    {
                        programesCounter++;
                     %>
                    <tr>
                        <td><%=programesCounter %></td>
                        <td><%=detail.Accreditation_No %></td>
                        <td><%=detail.Accreditation_Type %></td>
                        <td><%=detail.Institution_Campus %></td>
                        <td><%=detail.Proposed_Location %></td>
                        <td><%=detail.Sponsor %></td>
                        <td><a href="Institution.aspx" class="btn btn-success"><i class="fa fa-check"></i>Complete</a></td>
                    </tr>
                    <%  
                   } 
                        
                        %>
                </tbody>
                </table>  
                </div>   
                </div>
            </div>
       
            </div>
        
        </div>
     <script>
         $(document).ready(function() {
            $('#dataTables-example').DataTable({
                 responsive: true
             });
         });
     </script>
<script src="js/http_ajax.googleapis.com_ajax_libs_jquery_3.2.1_jquery.min.js"></script>
<script src="js/http_cdnjs.cloudflare.com_ajax_libs_popper.js_1.12.6_umd_popper.js"></script>
<script src="js/http_maxcdn.bootstrapcdn.com_bootstrap_4.0.0-beta.2_js_bootstrap.js"></script>
<script src="js/http_unpkg.com_sweetalert_dist_sweetalert.min.js"></script>
<script src="js/http_rawgit.com_eligrey_FileSaver.js_master_FileSaver.js"></script>
<script src="js/http_unpkg.com_xlsx_dist_xlsx.full.min.js"></script>
<script src="js/excel_uploader.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://github.com/eligrey/Blob.js"></script>
<script src="https://rawgit.com/eligrey/FileSaver.js/src/FileSaver.js"></script>
<script src="https://unpkg.com/xlsx/dist/xlsx.full.min.js"></script>
</asp:Content>
