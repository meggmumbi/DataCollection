<%@ Page Title="" Language="C#" MasterPageFile="~/AccreditationMaster.Master" AutoEventWireup="true" CodeBehind="DraftAccreditation.aspx.cs" Inherits="CicPortal.DraftAccreditation" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <div class="row">
            <div class="col-md-12 col-lg-12">
                  <div class="panel panel-default">
            <div class="panel-heading">Unsubmitted Applications</div>
   
                <div class="panel-body">
                    <div id ="feedback" runat="server"></div>
                     <table class="table table-bordered table-striped table-hover" id="dataTables-example">
                         <thead>
                         <tr>
                             <th>Accreditation No</th>
                             <th>Campus</th>
                             <th>Programme Name</th>
                             <th>Programme Domain</th>
                             <th>Programme Level</th>
                             <th>Status</th>
                             <th>Complete</th>
                         </tr>
                         </thead>
                         <tbody>
                         <%
                             var nav = Config.ReturnNav();
                             var requests = nav.ProgramAccreditation.Where(r => r.Institution_No== Convert.ToString(Session["UniversityCode"])&&r.Status=="Open" && r.Resubmission_Request == false);
                             foreach (var request in requests)
                             { var status = "";
                                 if (request.Status =="Open")
                                 {
                                     status ="Unsubmitted";
                                 }
                                %>
                             <tr>
                                 <td><%=request.Accreditation_No %></td>
                                 <td><%=request.Campus_Name %></td>
                                 <td><%=request.Program_Name %></td>
                                 <td><%=request.domainDescription %></td>
                                 <td><%=request.Program_Level %></td>
                                  <td><%=status %></td>
                                  <td><a class="btn btn-success" href ="ProgramAccreditation.aspx?accreditationNo=<%=request.Accreditation_No %>&step=1" ><i class="fa fa-edit"></i> Complete</a></td>
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
