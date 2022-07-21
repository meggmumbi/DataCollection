<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Finance.aspx.cs" Inherits="CicPortal.Finance" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div>
        <div class="row">
        <div class="col-md-10 col-lg-10">
            <div class="panel panel-default">
                <div class="panel-heading">Submit Financials</div>
            <div class="panel-body">
                <div id="feedback" runat="server"></div>
         <div class="form-group">
             <strong>Classification:</strong>
             <asp:DropDownList runat="server" ID="classification" CssClass="form-control" OnSelectedIndexChanged="classification_SelectedIndexChanged" AutoPostBack="True"/>
         </div>  
        <div class="form-group">
             <strong>Vote Head:</strong>
             <asp:DropDownList runat="server" ID="voteHead" CssClass="form-control"/>
         </div> 
        <div class="form-group">
             <strong>Amount:</strong>
             <asp:TextBox runat="server" ID="amount" CssClass="form-control" placeholder="Amount" TextMode="Number" required/>
         </div> 
        <div class="form-group">
     <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Vote Head" OnClick="Unnamed1_Click1"/>
        </div>
        </div>
        </div>
        </div>
        </div>

        <div class="panel panel-default">
            <div class="panel-heading">Financial Submissions</div>
            <div class="panel-body">
            <i>To edit the values, just re-enter the vote head.</i>    
      <table  class="table table-striped table-bordered table-hover" id="dataTables-example">
          <thead>
          <tr>
              <th>Classification</th>
              <th>Category</th>
              <th>Sub Category</th>
              <th>Vote Head</th>
              <th>Amount</th>
              <th>Delete</th>
          </tr>
          </thead>
          <tbody>
         <%
             var nav = Config.ReturnNav();
             var financials = nav.FinancialSubmissions.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
             foreach (var financial in financials)
             {
                %>
              <tr>
                  <td><%=financial.CategoryCode %></td>
                  <td><%=financial.MyCategoryDescription %></td>
                  <td><%=financial.Description %></td>
                  <td><%=financial.AccountsDescription %></td>
                  <td><% =String.Format("{0:n}", financial.Amount) %></td>
                  <td><label class='btn btn-danger' onclick="deleteFinancial('<% =financial.Accounts_Code %>', '<%=financial.AccountsDescription %>');"><i class='fa fa-trash'></i> Delete</label>
                      
                      
                  </td>
              </tr>
              <% 
             }
         %>
          </tbody>
      </table>  
       </div>
                 </div>

        </div> 
      

    
     <script>
         $(document).ready(function() {
             /* $('#dataTables-example').DataTable({
                 responsive: true
             });*/
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
<!-- needed by older browsers -->
<script src="https://github.com/eligrey/Blob.js"></script>

<!-- Required -->
<script src="https://rawgit.com/eligrey/FileSaver.js/src/FileSaver.js"></script>
<script src="https://unpkg.com/xlsx/dist/xlsx.full.min.js"></script>
    <script>
        function deleteFinancial(id, name) {
            swal({
                title: "Are you sure you want the votehead " + name + "?",
                text: "Once deleted, you will not be able to recover details of the financial entry!",
                icon: "warning",
                buttons: true,
                dangerMode: true,
            })
              .then((willDelete) => {
                  if (willDelete) {
                      window.location.href = "/Finance.aspx?entry=" + id;
                      /*swal("Poof! Your imaginary file has been deleted!", {
                          icon: "success",
                      });*/
                  } /*else {
                     swal("Your imaginary file is safe!");
                 }*/
              });
        }

      
        

    </script>
</asp:Content>
