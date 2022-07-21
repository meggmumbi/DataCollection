<%@ Page Title="" Language="C#" MasterPageFile="~/ChooseServiceMaster.Master" AutoEventWireup="true" CodeBehind="Affliations.aspx.cs" Inherits="CicPortal.Affliations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%@ Import Namespace="CicPortal" %>
    <div class="panel panel-default">
        <div class="panel-heading">
            Add Affiliation/Linkages & Collaboration
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback"></div>
            <div class="form-group">
                <strong>Organisation Name:</strong>
                <asp:TextBox runat="server" CssClass="form-control" ID="organisationname" placeholder="Organisation Name" />
            </div>
            <div class="form-group">
                <strong>Affliations Country :</strong>
                <asp:DropDownList runat="server" CssClass="form-control" ID="affiliationcountry" />
            </div>
            <div class="form-group">
                <strong>Affiliation/Linkages & Collaboration:</strong>
                <asp:TextBox runat="server" CssClass="form-control" ID="txtaffiliations" placeholder="Affliations/Linkages" TextMode="MultiLine" />
            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Add Affliations/Linkages" OnClick="SaveAffiliations_Click" />
            <div class="clearfix"></div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
            Affiliation/Linkages & Collaboration
        </div>
        <div class="panel-body">
            <table class="table table-bordered table-striped datatable" >
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Country Name</th>
                        <th>Organisation Name</th>
                        <th>Affliations/Linkages</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = Config.ReturnNav();
                        var affiliations = nav.UniversityAffiliations.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                        int count = 0;
                        foreach (var affiliation in affiliations)
                        {
                            count++;
                    %>
                    <tr>
                        <td><%=count %></td>
                        <td><%=affiliation.Country_Name %></td>
                        <td><%=affiliation.Organisation_Name %></td>
                        <td><%=affiliation.Affiliation_description %></td>
                        <td>
                            <label class="btn btn-success" onclick="editAffiliation('<%=affiliation.Code %>','<%=affiliation.Country %>','<%=affiliation.Organisation_Name %>','<%=affiliation.Affiliation_description %>')"><i class="fa fa-edit"></i>Edit</label></td>
                        <td>
                            <label class="btn btn-danger" onclick="deleteAffiliations('<%=affiliation.Code %>','<%=affiliation.Affiliation_description %>')"><i class="fa fa-trash"></i>Delete</label></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
    <script>
        function editAffiliation(id, Country, Affiliation, organisationname) {
            document.getElementById("MainContent_editaffiliationcode").value = id;
            document.getElementById("MainContent_editaffiliationscountry").value = Country;
            document.getElementById("MainContent_editorganisationname").value = organisationname;
            document.getElementById("MainContent_editAffiliation").value = Affiliation;
            $("#editAffiliationModal").modal();
        }
        function deleteAffiliations(id, name) {
            document.getElementById("affiliationdetails").innerText = name;
            document.getElementById("MainContent_removeaffiliationCode").value = id;
            $("#deleteAffiliationModal").modal();
        }
    </script>    

     <script>
         $(document).ready(function() {
             $('.datatable').DataTable({
                 responsive: true
             });
         });
     </script>
    <div id="deleteAffiliationModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting Affiliation</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the Affiliation <strong id="affiliationdetails"></strong>?</p>
                    <asp:TextBox runat="server" ID="removeaffiliationCode" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Affiliation" OnClick="deleteAffiliation_Click" />
                </div>
            </div>

        </div>
    </div>
    <div id="editAffiliationModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit Affiliation/Linkages & Collaboration Details</h4>
                </div>
                   <div class="modal-body">
                    <asp:TextBox runat="server" ID="TextBox1" type="hidden" />
                    <div class="form-group">
                        <p>*Please enter Organisation Name</p>
                        <strong>Organisation Name:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="editorganisationname" Placehoder="Organisation Name" />
                    </div>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="editaffiliationcode" type="hidden" />
                    <div class="form-group">
                        <p>*Please Select Affliation Country</p>
                        <strong>Affiliation Country:</strong>
                        <asp:DropDownList runat="server" CssClass="form-control" ID="editaffiliationscountry" Placehoder="Affiliations Country" />
                    </div>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <p>*Please enter the Affliation</p>
                        <strong>Affiliation/Linkages & Collaboration:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="editAffiliation" Placehoder="Affiliations" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Update Affiliation" OnClick="EditAffiliations_Click" />
                </div>
            </div>
        </div>
    </div>
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

