<%@ Page Title="" Language="C#" MasterPageFile="~/DataCollectionMaster.Master" AutoEventWireup="true" CodeBehind="Land.aspx.cs" Inherits="CicPortal.Land" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   <%
        var userType = Convert.ToString(Session["UserType"]);
        List<Int32> programLevelCount = new List<int>();
        List<String> programLevels = new List<String>();
        if (userType == "Data Officer")
        { %>
    
    <div>
    <div class="row" style="width: 100%; margin: 5px;">
        <div class="panel panel-default">
            <p>*Please Fill in all Land Details</p>
            <div class="panel-heading">Add Land</div>
            <div class="panel-body">
                <div id="feedback" runat="server"></div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Campus Name<span style="color:red">*</span></strong>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="campus" AppendDataBoundItems="true">
                                <asp:ListItem>--Select--</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="validatecampus" ControlToValidate="campus" InitialValue="--Select--" ErrorMessage="Please select campus, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>  
                     <div class="col-md-6 col-lg-6">
                         <div class="form-group">
                             <strong>Ownership Status<span style="color:red">*</span></strong>
                             <asp:DropDownList runat="server" CssClass="form-control" ID="ownership" AppendDataBoundItems="true">
                                 <asp:ListItem>--Select--</asp:ListItem>
                             </asp:DropDownList>
                             <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="validateownership" ControlToValidate="ownership" InitialValue="--Select--" ErrorMessage="Please select Ownership Status, it cannot be empty!" ForeColor="Red" />
                         </div>
                    </div>
                </div> 
                  <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Land Size(Acres) e.g 100<span style="color:red">*</span></strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="landSize" placeholder="Land Size (Acres)"/>
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="validatelandSize" ControlToValidate="landSize" ErrorMessage="Please enter land size, it cannot be empty!" ForeColor="Red" />
                            <asp:RegularExpressionValidator runat="server" ErrorMessage="Decimal values are only allowed e.g 100 or 100.00" ControlToValidate="landSize" ValidationExpression="^[1-9]\d*(\.\d+)?$" ForeColor="Red"></asp:RegularExpressionValidator>
                        </div>
                    </div>  
                     <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>LR Number<span style="color:red">*</span></strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="lRNumber" Placeholder ="LR Number" />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="validatelRNumber" ControlToValidate="lRNumber" ErrorMessage="Please enter LR number, it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>
                </div>
                 <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Upload Title Deed/Lease Agreement(Copy)<span style="color:red">*</span></strong>
                            <asp:FileUpload runat="server" CssClass="form-control" ID="titleDeed"  />
                            <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="validatetitleDeed" ControlToValidate="titleDeed" ErrorMessage="Please upload Title Deed/Lease Agreement(Copy), it cannot be empty!" ForeColor="Red" />
                        </div>
                    </div>  
                   
                </div>
            </div>
            <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Add Land" OnClick="Unnamed1_Click"/>
                <div class="clearfix"></div>
            </div>
        </div>
        <div class="panel panel-default">
            <p>*List of all Land details submitted</p>
            <div class="panel-heading">Added Land</div>
            <div class="panel-body">
                <table class="table table-bordered table-striped datatable">
                    <thead>
                    <tr>
                        <th>Campus</th>
                        <th>Ownership Status</th>
                        <th>Land Size(Acres)</th>
                        <th>LR Number</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        var nav = Config.ReturnNav();
                        var lands = nav.resources_land.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                        foreach (var land in lands)
                        {
                            %>
                        <tr>
                            <td><%=land.CampusName %></td>
                            <td><%=land.OwnershipDescription %></td>
                            <td><%=String.Format("{0:n}", Convert.ToDouble(land.Land_Size)) %></td>
                            <td><%=land.LR_Number %></td>
                            
                            <td><label class="btn btn-success" onclick="editLand('<%=land.Land_Code %>', '<%=land.Campus %>', '<%=land.Ownership_Status %>', '<%=land.Land_Size %>', '<%=land.LR_Number %>')"><i class="fa fa-edit"></i> Edit</label></td>
                            <td><label class="btn btn-danger" onclick="deleteLand('<%=land.Land_Code %>','<%=land.LR_Number %>')"><i class="fa fa-trash"></i> Delete</label></td>
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

     <script>
         $(document).ready(function() {
             $('.datatable').DataTable({
                 responsive: true
             });
         });
     </script>
    <script>
        function deleteLand(landCode, lrNumber) {

            document.getElementById("lrNumberToDelete").innerText = lrNumber;
            document.getElementById("MainContent_removeLandCode").value = landCode;
            $("#deleteLandModal").modal();
        }
        function editLand(landCode, campus, ownershipStatus, landSize, lrNumber) {
            document.getElementById("MainContent_editLandCode").value = landCode;
            document.getElementById("MainContent_editCampus").value = campus;
            document.getElementById("MainContent_editOwnershipStatus").value = ownershipStatus;
            document.getElementById("MainContent_editLandSize").value = landSize;
            document.getElementById("MainContent_editLRNumber").value = lrNumber;
            $("#editLandModal").modal();
        }
    </script>
 <div id="deleteLandModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Deleting Land</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the land LR Number <strong id="lrNumberToDelete"></strong> ?</p>
          <asp:TextBox runat="server" ID="removeLandCode" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Land" OnClick="deleteLand_Click"/>
      </div>
    </div>

  </div>
</div>
    <div id="editLandModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Edit Land</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="editLandCode" type="hidden"/>
           <div class="form-group">
               <p>*Please select the campus Name</p>
            <strong>Campus:</strong>
            <asp:DropDownList runat="server" CssClass="form-control" ID="editCampus"/>
        </div> 
          <div class="form-group">
              <p>*Please select the land ownership status</p>
            <strong>Ownership Status:</strong>
            <asp:DropDownList runat="server" CssClass="form-control " ID="editOwnershipStatus"/>
        </div>  
          <div class="form-group">
              <p>*Please enter the land Size in Acres</p>
            <strong>Land Size:</strong>
            <asp:TextBox runat="server" CssClass="form-control" ID="editLandSize" Placehoder="Land Size"/>
        </div>  
          <div class="form-group">
              <p>*Please enter the land LR Number</p>
            <strong>LR Number:</strong>
            <asp:TextBox runat="server" CssClass="form-control" ID="editLRNumber" Placeholder ="LR Number"/>
        </div> 
          <div class="form-group">
              <p>*PLease upload the Title Deed/Land Lease Agreement Copy</p>
            <strong>Title Deed/Lease Agreement (Copy):</strong>
            <asp:FileUpload runat="server" CssClass="form-control" ID="editTitle" />
        </div>  
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Update Land" OnClick="editLand_Click"/>
      </div>
    </div>

  </div>
</div>
    <%
        }
        else
        {
            var nav = Config.ReturnNav();
    %>
 <div class="row">
        <div class="col-lg-3 col-md-6">
            <div class="panel panel-green">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-xs-3">
                            <i class="fa fa-user fa-5x"></i>
                        </div>
                        <div class="col-xs-9 text-right">
                            <div class="huge">
                               <%-- <%

                                    int academicStaff = nav.University_Staff_Details.Where(r => r.Institution_Code == Convert.ToString(Session["UniversityCode"]) && r.Staff_Type == "Teaching").ToList().Count;
                                %>
                                <% =academicStaff %>--%>
                            </div>
                            <div>Total Academic Staff</div>
                        </div>
                    </div>
                </div>
                <a href="AcademicStaff.aspx">
                    <div class="panel-footer">
                        <span class="pull-left">View Details</span>
                        <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                        <div class="clearfix"></div>
                    </div>
                </a>
            </div>
        </div>
        <div class="col-lg-3 col-md-6">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-xs-3">
                            <i class="fa fa-book fa-5x"></i>
                        </div>
                        <div class="col-xs-9 text-right">
                            <div class="huge">
                                <%

                                    int campus1 = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"])).ToList().Count;
                                %>
                                <% =campus1 %>
                            </div>
                            <div>Total Campuses</div>
                        </div>
                    </div>
                </div>
                <a href="AccreditedPrograms.aspx">
                    <div class="panel-footer">
                        <span class="pull-left">View Details</span>
                        <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                        <div class="clearfix"></div>
                    </div>
                </a>
            </div>
        </div>
        <div class="col-lg-3 col-md-6">
            <div class="panel panel-green">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-xs-3">
                            <i class="fa fa-user fa-5x"></i>
                        </div>
                        <div class="col-xs-9 text-right">
                            <div class="huge">
                                <%
                                    int programs1 = nav.Programs.Where(r => r.Accreditation_Status == "CUE Accredited" && r.Institution_Code == Convert.ToString(Session["UniversityCode"])).ToList().Count;
                                %>
                                <% =programs1 %>
                            </div>
                            <div>Total Programmes</div>
                        </div>
                    </div>
                </div>
                <a href="AcademicStaff.aspx">
                    <div class="panel-footer">
                        <span class="pull-left">View Details</span>
                        <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                        <div class="clearfix"></div>
                    </div>
                </a>
            </div>
        </div>
        <div class="col-lg-3 col-md-6">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-xs-3">
                            <i class="fa fa-book fa-5x"></i>
                        </div>
                        <div class="col-xs-9 text-right">
                            <div class="huge">
                              <%--  <%
                                    int disability = nav.University_Staff_Details.Where(r => r.Institution_Code == Convert.ToString(Session["UniversityCode"])).ToList().Count;
                                %>
                                <% =disability %>--%>
                            </div>
                            <div>PWD Staff</div>
                        </div>
                    </div>
                </div>
                <a href="AccreditedPrograms.aspx">
                    <div class="panel-footer">
                        <span class="pull-left">View Details</span>
                        <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                        <div class="clearfix"></div>
                    </div>
                </a>
            </div>
        </div>
    </div>
     <div class="panel panel-default">
            <p>*List of all Land details submitted</p>
            <div class="panel-heading">Added Land</div>
            <div class="panel-body">
                <table class="table table-bordered table-striped datatable1">
                    <thead>
                    <tr>
                        <th>Campus</th>
                        <th>Ownership Status</th>
                        <th>Land Size(Acres)</th>
                        <th>LR Number</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        var nav1 = Config.ReturnNav();
                        var lands = nav.resources_land.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                        foreach (var land in lands)
                        {
                            %>
                        <tr>
                            <td><%=land.CampusName %></td>
                            <td><%=land.OwnershipDescription %></td>
                            <td><%=String.Format("{0:n}", Convert.ToDouble(land.Land_Size)) %></td>
                            <td><%=land.LR_Number %></td>                            
                        </tr>
                        <%
                        }
                         %>
                    </tbody>
                </table>
            </div>
        </div>
    <script>
        $(document).ready(function () {
            $('.datatable1').DataTable({
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

    <%
        } %>
</asp:Content>
