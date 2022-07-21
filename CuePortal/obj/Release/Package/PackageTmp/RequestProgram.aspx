<%@ Page Title="" Language="C#" MasterPageFile="~/AccreditationMaster.Master" AutoEventWireup="true" CodeBehind="RequestProgram.aspx.cs" Inherits="CicPortal.RequestProgram" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div>
          
        <div class="row">
            <div class="col-md-12 col-lg-12">
                  <div class="panel panel-default">
            <div class="panel-heading">Request Program Accreditation</div>
   
                <div class="panel-body">
                    <div id ="feedback" runat="server"></div>
                        <div class="form-group">
                        <label>Institution:</label>
                        <asp:Textbox runat="server" CssClass="form-control" ID="institution" required  ReadOnly="True"/>
                    </div>
                    <div class="form-group">
                        <label>Campus:</label>
                        <asp:DropDownList runat="server" CssClass="form-control" ID="campus" required/>
                    </div>
                       <div class="row" >
                             <div class="col-md-6 col-lg-6">
                                 <div class="form-group">
                                     <label>Program Name:</label>                       
                                        <asp:TextBox CssClass="form-control" runat="server" ID="programName" Placeholder="Program Name" required />
                                    </div>

                             </div>
                              <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label>Program Domain:</label>                       
                                        <asp:DropDownList CssClass="form-control" runat="server" ID="programDomain"  />
                                    </div>

                             </div>
                         </div>
                      <div class="row" >
                             <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label>Program Level:</label>                       
                                        <asp:DropDownList CssClass="form-control" runat="server" ID="programLevel"  required />
                                    </div>

                             </div>
                          
                         </div>
                        
                  
                          
                
                  
           <div class="form-group">
               <label>Curriculum Document:</label>
                <asp:FileUpload ID="curriculumDocument" runat="server" CssClass="form-control" required/>
           </div> 
                    <div class="form-group">
               <label>Application Letter:</label>
                <asp:FileUpload ID="applicationLetter" runat="server" CssClass="form-control" required/>
           </div>  
                      <div class="form-group">
               <label>Payment Document:</label>
                <asp:FileUpload ID="paymentDoc" runat="server" CssClass="form-control" required/>
           </div>  
                    <div class="form-group">
               <label>Payment Reference:</label>
                <asp:TextBox ID="paymentReference" runat="server" CssClass="form-control" PlaceHolder ="Payment Reference"  required/>
           </div>
                <div style="background-color: #ececec; padding:10px;">
                             <asp:Button runat="server" CssClass="btn btn-success btn-block" ID="apply" Text="Request Program Accreditation"  style="border-radius: 2px;font-size: 17px;padding: 10px 19px;" OnClick="apply_Click"  />
                     </div>      
                    

                </div>   
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

</asp:Content>
