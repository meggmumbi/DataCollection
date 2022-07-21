<%@ Page Title="" Language="C#" MasterPageFile="~/AccreditationMaster.Master" AutoEventWireup="true" CodeBehind="Institution.aspx.cs" Inherits="CicPortal.Institution" %>
<%@ Import Namespace="CicPortal" %>
<%@ Import Namespace="System.IO" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style type="text/css">

.required:after 
{
	content: "*";
	font-weight: bold;
	color: red; 
}

</style>
     <%
         var nav = Config.ReturnNav();
         String accreditationNo = "";
         String applicationNo = "";
         try
         {
             accreditationNo = Request.QueryString["accreditationNo"].Trim();
             applicationNo = Request.QueryString["applicationNo"].Trim();
         }
         catch (Exception)
         {

         }
         %>

    <div>
        <div class="row">
            <div class="col-md-12 col-lg-12">
                  <div class="panel panel-default">
            <div class="panel-heading">
                Institution Accreditation (<i style="color:yellow">Kindly note that all fields marked with <span class="text-danger">*</span> are mandatory</i>)
                </div>
                <div class="panel-body">
                    <div id ="feedback" runat="server"></div>

                       <div class="row" >
  
                              <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <label class="required">Application Type </label><i>Please select the type of institution for which you are applying for accreditation</i>
                                    <asp:DropDownList runat="server" CssClass="form-control" ID="accreditationType" OnSelectedIndexChanged="accreditationType_SelectedIndexChanged" AutoPostBack="true" AppendDataBoundItems="true">
                                        <asp:ListItem>--Select--</asp:ListItem>
                                    </asp:DropDownList>
                                   <asp:RequiredFieldValidator runat="server" id="university" controltovalidate="accreditationType" InitialValue="--Select--" errormessage="Please select application type!" ForeColor="Red"/>
                                </div>
                             </div>
                             <div class="col-md-6 col-lg-6">
                                 <div class="form-group">
                                     <label class="required">Name</label>  <i>Please enter the name of the institution for which you are applying for accreditation</i>                    
                                        <asp:TextBox CssClass="form-control" runat="server" ID="proposedName" Placeholder="Enter Name" />
                                      <asp:RequiredFieldValidator runat="server" id="proponame" controltovalidate="proposedName" errormessage="Please enter Name!" ForeColor="Red"/>

                                    </div>
                             </div>
                         </div>
                           <div class="row" >
                             <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label class="required">Location</label>  <i>This is the place where the institution will be located</i>                          
                                        <asp:TextBox CssClass="form-control" runat="server" ID="proposedLocation" Placeholder="Enter Location" />
                                      <asp:RequiredFieldValidator runat="server" id="locations" controltovalidate="proposedLocation" errormessage="Please enter Loaction!" ForeColor="Red"/>
                                     </div>
                             </div>
                              <div class="col-md-6 col-lg-6" runat="server" id="divsponsor" visible="false">
                                  <div class="form-group">
                                     <label class="required">Sponsor Type</label>  <i>The funding source for the institution</i>                        
                                        <asp:DropDownList CssClass="form-control select2" runat="server" ID="sponsor" OnSelectedIndexChanged="sponsor_SelectedIndexChanged" AutoPostBack="true" AppendDataBoundItems="true">
                                            <asp:ListItem>--Select--</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" id="sponse" controltovalidate="sponsor" InitialValue="--Select--" errormessage="Please select the Sponsor!" ForeColor="Red"/>

                                  </div>
                             </div>
                               <div class="col-md-6 col-lg-6" runat="server" id="divesponsor" visible="false">
                                   <div class="form-group">
                                       <label class="required">Sponsor</label>
                                       <i>The funding source for the institution</i>
                                       <asp:TextBox CssClass="form-control" runat="server" ID="esponsor" ReadOnly="true"/>
                                   </div>
                               </div>
                         </div> 

                          <div class="row" runat="server" id="divsponsorname" visible="false">
                             <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label class="required">Sponsor Name</label>                       
                                        <asp:TextBox CssClass="form-control" runat="server" ID="sponsorname" Placeholder="Enter sponsor name" />
                                      <asp:RequiredFieldValidator runat="server" id="RequiredFieldValidator48" controltovalidate="proposedLocation" errormessage="Please enter Loaction!" ForeColor="Red"/>
                                     </div>
                             </div>
                         </div> 
                         <h3><i>Communication Details</i></h3>
                         <hr/>
                         <br/>
                    <%
                        string institutionstatus = Convert.ToString(Session["InstitutionStatus"]);
                        if (institutionstatus == "Proposed")
                        { 
                            %>
                           <div class="row" >
                             <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label class="required">County</label>                       
                                        <asp:DropDownList CssClass="form-control" runat="server" ID="county"   OnSelectedIndexChanged="county_SelectedIndexChanged" AutoPostBack="True" />
                                         <asp:RequiredFieldValidator runat="server" id="countys" controltovalidate="county" errormessage="Please select the County!" ForeColor="Red"/>
                                     </div>
                             </div>
                              <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label class="required">Constituency</label>                       
                                        <asp:DropDownList CssClass="form-control" runat="server" ID="constituency"  />
                                        <asp:RequiredFieldValidator runat="server" id="consti" controltovalidate="constituency" errormessage="Please select the constituency!" ForeColor="Red"/>
                                     </div>
                             </div>
                         </div>
                           <div class="row" >
                             <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label class="required">Post Address</label>                       
                                        <asp:TextBox CssClass="form-control" runat="server" ID="postAddress" Placeholder="Post Address"  />
                                        <asp:RequiredFieldValidator runat="server" id="postiaddress" controltovalidate="postAddress" errormessage="Please select the PostAddress!" ForeColor="Red"/>
                                   </div>
                             </div>
                              <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label class="required">Post Code</label>                       
                                      <asp:DropDownList CssClass="form-control" runat="server" ID="postCode"  OnSelectedIndexChanged="postCode_SelectedIndexChanged" AutoPostBack="True" />
                                      <asp:RequiredFieldValidator runat="server" id="code" controltovalidate="postCode" errormessage="Please select the Post Code!" ForeColor="Red"/>
                                   </div>
                             </div>
                         </div>
                           <div class="row" >
                             <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label class="required">City</label>                       
                                        <asp:TextBox CssClass="form-control" runat="server" ID="city" Placeholder="City" ReadOnly="True"  />
                                        <asp:RequiredFieldValidator runat="server" id="citys" controltovalidate="city" errormessage="Please enter the City!" ForeColor="Red"/>

                                  </div>
                             </div>
                              <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label>Institution Website</label>                       
                                        <asp:TextBox CssClass="form-control" runat="server" ID="institutionWebsite" Placeholder="Institution Website"  />
                                        <asp:RequiredFieldValidator runat="server" id="institution" controltovalidate="institutionWebsite" errormessage="Please enter the Institution Website!" ForeColor="Red"/>

                                  </div>
                             </div>
                         </div>
                         <div class="row" >
                             <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label class="required">Phone Number</label>                       
                                        <asp:TextBox CssClass="form-control" runat="server" ID="phoneNumber" Placeholder="Phone Number"   />
                                       <asp:RequiredFieldValidator runat="server" id="phone" controltovalidate="phoneNumber" errormessage="Please enter the Phone Number!" ForeColor="Red"/>

                                  </div>
                             </div>
                              <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label class="required">Email Address</label>                       
                                        <asp:TextBox CssClass="form-control" runat="server" ID="emailAddress" Placeholder="Email Address"  type="Email"/>
                                        <asp:RequiredFieldValidator runat="server" id="email" controltovalidate="emailAddress" errormessage="Please enter the Email Address!" ForeColor="Red"/>

                                  </div>
                             </div>
                       </div>
                    <%
                        }
                        else
                        {
                            %>
                             <div class="row" >
                             <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label class="required">County</label>                       
                                      <asp:TextBox CssClass="form-control" runat="server" ID="tCounty" ReadOnly="true" />
                                     </div>
                             </div>
                              <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label class="required">Constituency</label>                       
                                        <asp:TextBox CssClass="form-control" runat="server" ID="tConstituency" ReadOnly="true" />
                                     </div>
                             </div>
                         </div>
                           <div class="row" >
                             <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label class="required">Post Address</label>                       
                                       <asp:TextBox CssClass="form-control" runat="server" ID="tPostAddress" ReadOnly="true" />
                                   </div>
                             </div>
                              <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label class="required">Post Code</label>                       
                                     <asp:TextBox CssClass="form-control" runat="server" ID="tPostcode" ReadOnly="true" />
                                   </div>
                             </div>
                         </div>
                           <div class="row" >
                             <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label class="required">City</label>                       
                                       <asp:TextBox CssClass="form-control" runat="server" ID="tCity" ReadOnly="true" />

                                  </div>
                             </div>
                              <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label>Institution Website</label>                       
                                         <asp:TextBox CssClass="form-control" runat="server" ID="tInstitutionweb" ReadOnly="true" />

                                  </div>
                             </div>
                         </div>
                         <div class="row" >
                             <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label class="required">Phone Number</label>                       
                                       <asp:TextBox CssClass="form-control" runat="server" ID="tPhoneno" ReadOnly="true" />

                                  </div>
                             </div>
                              <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label class="required">Email Address</label>                       
                                         <asp:TextBox CssClass="form-control" runat="server" ID="tEmail" ReadOnly="true" />
                                  </div>
                             </div>
                       </div>

                            <%
                        }
                    %>
                <h3><i>Attach Documents</i></h3>
                <hr/>
                <br/>
                <div runat="server" id="docfeedback"></div>
               <div class="row">
                   <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                       <div class="form-group">
                           <strong><asp:Label runat="server" class="required"></asp:Label>Application Letter</strong>
                           <asp:FileUpload runat="server" ID="appletter" CssClass="form-control" style="padding-top: 0px;"/>
                       </div>
                   </div>
                   <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                       <div class="form-group">
                           <strong><asp:Label runat="server" id="documentdata"  class="required"></asp:Label></strong>
                           <asp:FileUpload runat="server" ID="selfassessment" CssClass="form-control" style="padding-top: 0px;"/>
                       </div>
                   </div>
               </div>
                <div class="row">
                    <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                        <br />
                        <asp:Button runat="server" ID="Button15" CssClass="btn btn-success btn-block" Text="Submit General Details" OnClick="apply_Click" />
                    </div>
                </div>
            </div>
         </div>
        <%
            string docNo = "";
            try
            {
                docNo = Convert.ToString(Session["applicationNo"]);
                if (string.IsNullOrEmpty(docNo))
                {
                    docNo =  Request.QueryString["applicationNo"];
                }
            }
            catch
            {
                docNo = "";
            }

            if (!string.IsNullOrEmpty(docNo))
            {
                %>
                  <div class="panel panel-default">
                    <div class="panel-heading">
                        <div runat="server" id="Div6"></div>
                        Uploaded Documents
                    </div>
                        <br />
                        <hr/>
                         <br />
                   <table class="table table-bordered table-striped">
                       <thead>
                       <tr>
                           <th>Document Title</th>
                           <th>Download</th>
                           <th>Delete</th>
                       </tr>
                       </thead>
                       <tbody>
                       <%
                           try
                           {
                                    String fileFolderApplication = ConfigurationManager.AppSettings["FilesLocation"];
                                    String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Unprocessed Insitution/";
                                    string imprestNo = "";
                                    try
                                    {
                                        imprestNo = Convert.ToString(Session["applicationNo"]);
                                        if (string.IsNullOrEmpty(imprestNo))
                                        {
                                            imprestNo =  Request.QueryString["applicationNo"];
                                        }
                                    }
                                    catch
                                    {
                                        imprestNo = "";
                                    }
                                    imprestNo = imprestNo.Replace('/', '_');
                                    imprestNo = imprestNo.Replace(':', '_');
                                    String documentDirectory = filesFolder + imprestNo+"/";
                                    if (Directory.Exists(documentDirectory))
                                    {
                                        foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                        {
                                            String url = documentDirectory;
                                       %>
                           <tr>
                               <td><% =file.Replace(documentDirectory, "") %></td>
                               <td><a href="DownLoadFile.aspx?applicationNo=<%=imprestNo %>&&fileName=<%=file.Replace(documentDirectory, "") %>" class="btn btn-success">Download</a></td>
                               <td><label class="btn btn-danger" onclick="deleteFile('<%=file.Replace(documentDirectory, "")%>');"><i class="fa fa-trash-o"></i> Delete</label></td>
                           </tr>
                           <%
                                        }
                                    }
                           }
                           catch (Exception)
                           {
                       
                           }%>
                       </tbody>
                   </table>
                  </div>  
                <%
            }
        %>
         
          <div class="panel panel-default">
            <div class="panel-heading">
                <div runat="server" id="terminate"></div>
                Unsubmitted Applications (<i style="color:yellow">These are applications that have been created but not completed, kindly complete on this application before creating a new one</i>)
                </div>
            <br />
                 <table class="table table-bordered table-striped dataTable">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Acccreditation No</th>
                    <th>Institution Name</th>
                    <th>Location</th>
                    <%--<th>KRA Pin</th>--%>
                    <th>Sponsor</th>
                    <th>Constituency</th>
                    <th>Edit</th>
                    <th>Add Programmes</th>
                    <th>Terminate Application</th>
                </tr>
                </thead>
                <tbody>
                <% var details = nav.InstitutionAccreditation.Where(r => r.Institution_No == Convert.ToString(Session["UniversityCode"]) &&r.Status=="Open");
                    string university = Convert.ToString(Session["UniversityCode"]);
                    int programesCounter = 0;
                    foreach (var detail in details)
                    {
                        programesCounter++;
                     %>
                    <tr>
                        <td><%=programesCounter %></td>
                        <td><%=detail.Accreditation_No %></td>
                        <td><%=detail.Institution_Name %></td>
                        <td><%=detail.Proposed_Location %></td>
                        <%--<td><%=detail.KRA_Pin %></td>--%>
                        <td><%=detail.Sponsor %></td>
                        <td><%=detail.Constituency %></td>
                        <td><a href="Institution.aspx?applicationNo=<%=detail.Accreditation_No %>" class="btn btn-warning"><i class="fa fa-pencil"></i>Edit</a></td>
                         <td><a href="InstitutionAccreditationBundledProgrammes.aspx?applicationNo=<%=detail.Accreditation_No %>&&AccCode=<%=detail.Accreditation_Code %>" class="btn btn-success"><i class="fa fa-plus"></i>Add Programmes</a></td>
                        <td><label class="btn btn-danger" onclick="terminateApplication('<%=detail.Accreditation_No %>');"><i class="fa fa-trash"></i> Terminate Application</label></td>
                        
                    </tr>
                    <%  
                   } %>
                </tbody>
            </table> 
           </div> 
         </div>
     </div>
 </div>

<div id="terminateapplicationModal" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Confirm Termination Of Application</h4>
          </div>
          <div class="modal-body">
            <p>Are you sure you want to terminate application  <strong id="terminateNo"></strong>?</p>
              <asp:TextBox runat="server" ID="noterminate" type="hidden"/>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
              <asp:Button runat="server" CssClass="btn btn-danger" Text="Terminate Application" ID="terminateapplication" OnClick="terminateapplication_Click" CausesValidation="false"/>
          </div>
    </div>

  </div>
</div>
 
<div id="deleteFileModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Deleting File</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the file <strong id="filetoDeleteName"></strong> ?</p>
          <asp:TextBox runat="server" ID="fileName" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" ID="deleteFileID" OnClick="deleteFile_Click" CausesValidation="false"/>
      </div>
    </div>

  </div>
</div>
<script>     
    function deleteFile(fileName) {
        document.getElementById("filetoDeleteName").innerText = fileName;
        document.getElementById("MainContent_fileName").value = fileName;
        $("#deleteFileModal").modal(); 
    }
</script> 
<script>
    function terminateApplication(applicationno) {
        document.getElementById("terminateNo").innerText = applicationno;
        document.getElementById("MainContent_noterminate").value = applicationno;
        $("#terminateapplicationModal").modal();
    }
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
<%--<script language="JavaScript"> var message = 'Right Click is disabled';
function clickIE() { if (event.button == 2) { alert(message); return false; } }
function clickNS(e) {
if (document.layers || (document.getElementById && !document.all)) {
if (e.which == 2 || e.which == 3) { alert(message); return false; }
}
}
if (document.layers) { document.captureEvents(Event.MOUSEDOWN); document.onmousedown = clickNS; }
else if (document.all && !document.getElementById) { document.onmousedown = clickIE; }
document.oncontextmenu = new Function('alert(message);return false')

</script>--%>
</asp:Content>
