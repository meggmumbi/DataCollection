<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Research.aspx.cs" Inherits="CicPortal.Research" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div>
          
        <div class="row">
            <div class="col-md-6 col-lg-6">
                  <div class="panel panel-default">
            <div class="panel-heading">Excel Upload</div>
   
                <div class="panel-body">
            <div class="form-group">
                                <select class="form-control" id="dataType" style='display:none;'>
                                    <option value="-1" disabled selected>Select Data to Import</option>
                                    <option selected value="">Import Posts Data</option>
                                </select>
                            </div>
                            <!-- This is the file chooser input field-->
                            <div class="form-group">
                                <input type="file" id="fileUploader" class="btn btn-fill btn-primary btn-large" />
                            </div>
   </div>
            </div>
       
            </div>
            <div class="col-md-6 col-lg-6">
                 <div class="panel panel-default">
            <div class="panel-heading">Form Upload</div>
     <div class="panel-body">
    <label class="btn btn-success"  data-toggle="modal" data-target="#form-input"><i class="fa fa-plus fa-fw"></i> Add Publication</label>
         </div>
            </div>
    
            </div>
        </div>
         <div runat="server" id="feedback"></div>
                          <div id="tableOutput">
                    </div>
    
        <div class="panel panel-default">
            <div class="panel-heading">Publications</div>
            <div class="panel-body">
      <table  class="table table-striped table-bordered table-hover" id="dataTables-example">
          <thead>
          <tr>
             
              <th>Title</th>
              <th>Description</th>
              <th>Domain</th>
              <th>Campus</th>
              <th>Year</th>
          </tr>
          </thead>
          <tbody>
         
          </tbody>
      </table>  
       </div>
                 </div>

        </div> 
        <div id="studentUpload" class="modal fade" role="dialog" >
  <div class="modal-dialog modal-lg">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Add Publication</h4>
      </div>
      <div class="modal-body">
      <label id="progress"></label>
          <div id="myProgress">
  <div id="myBar">0%</div>
</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>

     <div id="form-input" class="modal fade" role="dialog" >
  <div class="modal-dialog modal-lg">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Add Publication</h4>
      </div>
      <div class="modal-body">
          <div class="row">
               
                <div class="col-md-6 col-lg-6">
                  <div class="form-group"><strong>Domain:</strong><asp:DropDownList runat="server" CssClass="form-control"  ID="domain" OnSelectedIndexChanged="domainChange" AutoPostBack="True"/> </div>

              </div>
             <div class="col-md-6 col-lg-6">
                  <div class="form-group"><strong>Sub Domain:</strong><asp:DropDownList runat="server" CssClass="form-control"  ID="subdomain"/> </div>

              </div>
            

          </div>
           <div class="row">
               <div class="col-md-6 col-lg-6">
                  <div class="form-group"><strong>Campus:</strong><asp:DropDownList runat="server" CssClass="form-control"  ID="campus"/> </div>

              </div>
                <div class="col-md-6 col-lg-6" id="mPublicationType">
                  <div class="form-group"><strong>Publication Type:</strong><asp:DropDownList runat="server" CssClass="form-control"  ID="publicationType"/> </div>

              </div>
             
            

          </div>
        <div class="row">
              <div class="col-md-12 col-lg-12">
                  <div class="form-group"><strong>Title:</strong><asp:TextBox runat="server" CssClass="form-control" placeholder="Title" ID="title" required/> </div>

              </div>
              <div class="col-md-12 col-lg-12">
                  <div class="form-group"><strong>Description:</strong><asp:TextBox runat="server" CssClass="form-control" placeholder="Description" ID="description" TextMode="MultiLine" required/> </div>

              </div>

          </div>
            <div class="row">
              <div class="col-md-12 col-lg-12">
                  <div class="form-group"><strong>Link to Publication, Innovation or Patent:</strong><asp:TextBox runat="server" CssClass="form-control" placeholder="Link to Publication, Innovation or Patent" ID="link" /> </div>

              </div>
             

          </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                  <div class="form-group"><strong>Patenting/Copyright Organisation:</strong><asp:TextBox runat="server" CssClass="form-control"  Placeholder="Patenting or Copyright Organisation" ID="patentingOrganisation"/> </div>

              </div>
              <div class="col-md-6 col-lg-6">
                  <div class="form-group"><strong>Patent/Copyright No:</strong><asp:TextBox runat="server" CssClass="form-control"  ID="copyrightNo" PlaceHolder="Patent/Copyright No"/> </div>

              </div>
            

          </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                  <div class="form-group"><strong>Patent/Copyright Year:</strong><asp:TextBox runat="server" CssClass="form-control"  Placeholder="Patent/Copyright Year" ID="patentYear"/> </div>

              </div>
              <div class="col-md-12 col-lg-12">
                  <div class="form-group"><strong>Author Ids:</strong> <i>Please enter the id numbers of all authors from your institution in a comma separated list</i><asp:TextBox runat="server" CssClass="form-control"  ID="authors" PlaceHolder="Authors" required /> </div>

              </div>
            

          </div>
      </div>
      <div class="modal-footer">
          <asp:Button runat="server" CssClass="btn btn-success" Text="Add Research" OnClick="Unnamed1_Click"/>
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
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
    $(document).ready( function () {
        new ExcelUploader({
            maxInAGroup: 100,
            serverColumnNames: ["100"],
            importTypeSelector: "#dataType",
            fileChooserSelector: "#fileUploader",
            outputSelector: "#tableOutput",
            extraData: {_token: "23333323323223323232"}
        });
      //  loadData();
    });
</script>
  <script>
      function loadData() {
          $.ajax({
              url: "http://localhost:57742/api/values?userId=12&&userPassword=14",
              type: "GET",
              contentType: "application/json;charset=utf-8",
              data: JSON.stringify("user: data"),
              dataType: "json"
          })
      .done(function (response) {
          var table = $("#dataTables-example tbody");
          for (var i = 0; i < response.length; i++) {
              var obj = response[i];
        
              table.append("<tr><td>" +
                  obj.idNumber + "</td><td>" + obj.Surname + " " + obj.firstName + " " + obj.middleName + "</td><td>" + obj.gender + "</td><td>" + obj.dob + "</td><td>" + obj.myProgram + "</td><td>" + obj.yearOfStudy + "</td><td>" + obj.sponsorship + "</td> </tr>");
          }
          $('#dataTables-example').DataTable({
              responsive: true
          });
         // alerter("ERROR OCCURRED! ");
          /* $.each(data, function (idx, elem) {
        
            });*/
        
      })
      .fail(function (error) {
          alerter("ERROR OCCURRED! " + JSON.stringify(error) + "<br/>");
         
      });
      }
      function alerter(message) {
          if (window.swal) {
              swal("Alert!", message, "warning");
          } else {
              alert(message);
          }
      }
  </script>
</asp:Content>
