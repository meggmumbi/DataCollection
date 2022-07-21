<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AccreditationMaster.Master" CodeBehind="VerificationsofAcademicResources.aspx.cs" Inherits="CicPortal.VerificationsofAcademicResources" %>

<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%
        const int maxStep = 10;
        var nav = Config.ReturnNav();
        String accreditationNo = "";
        try
        {
            accreditationNo = Request.QueryString["accreditationNo"].Trim();
        }
        catch (Exception)
        {

        }
    %>
    <%--  <div class="row">
        <div class="col-md-12 col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">Verifications of Academic Resources</div>
                <div class="panel-body">
                    <div id="feedback" runat="server"></div>
                    <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                        <thead>
                            <tr>
                                <th>No:</th>
                                <th>Accreditation No</th>
                                <th>Programme Name</th>
                                <th>Verification Status</th>
                                <th>Aggregate Score</th>
                                <th>Maximum Score</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                var programs = nav.ProgrammeSiteInspection.Where(r => r.Status == "Completed" && r.Application_No == accreditationNo && r.Type == "Group");
                                foreach (var program in programs)
                                {
                            %>
                            <tr>
                                <td><%=program.Code %></td>
                                <td><%=program.Application_No %></td>
                                <td><%=program.Application_Description %></td>
                                <td><%=program.Status %></td>
                                <td><%=program.Aggregate_Score %></td>
                                <td><%=program.Maximum_Aggregate_Score %></td>
                               
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>--%>
    <div class="row">
        <div class="col-md-12 col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">Academic Resource Verifications(University Comments/Feedback)</div>
                <div class="panel-body">
                    <div id="feedback" runat="server"></div>
                    <table class="table table-striped table-bordered table-hover" id="dataTables-example1">
                        <thead>
                            <tr>
                                <%--<th>Voucher No.</th>--%>
                                <th>#</th>
                                <th>Component Description</th>
                                <th>Sub-Component Description</th>
                                <th>Strength</th>
                                <th>Weakness</th>
                                <th>CUE Comment</th>
                                <th>University Feedback</th>                                
                                <th>Comments</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                var nav1 = Config.ReturnNav();
                                var programs2 = nav.ProgrammeSiteInspection.Where(r => r.Status == "Completed" && r.Application_No == accreditationNo && r.Type == "Group"&&r.CUE_Comment!="");
                                int feedbackcounter = 0;
                                foreach (var program in programs2)
                                {
                                    feedbackcounter++;
                            %>
                            <tr>
                                <%--<td><%=program.Code %></td>--%>
                                <td><%=feedbackcounter %></td>
                                <td><%=program.Component_Description %></td>
                                <td><%=program.Sub_Component_Description %></td>
                                <td><%=program.Strength %></td>
                                <td><%=program.Weakness %></td> 
                                <td><%=program.CUE_Comment %></td>                              
                                <td><%=program.Instiution_Feedback %></td>
                                 
                                <td>
                                    <label class="btn btn-success" onclick="makeComments('<%=program.Application_No %>','<%=program.Evaluation_Header_No %>', '<%=program.Component_Code %>','<%=program.Sub_Component_Code %>')"><i class="fa fa-edit"></i>Make Comments</label></td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
                <br />
                <center>
                     <asp:Button runat="server" CssClass="btn btn-success" Text="Submit Feedback To CUE" ID="submitfeedbacktocue" OnClick="submitfeedbacktocue_Click"/>
                </center>
                <br />
                <br />
                <br />
            </div>
        </div>
    </div>
    <div id="makeCommentsModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Verification of Academic Resources Comments/Feedback</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="editRationaleCode" type="hidden" />
                    <div class="form-group">
                        <strong>Accreditation Number:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="accreditationnumber" placeholder="Programme Accreditation Number" ReadOnly="true" />

                    </div>
                    <div class="form-group">
                        <strong>Verification Number:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="verificationNumber" placeholder="Programme Verification Number" />
                    </div>
                    <div class="form-group" style="display: none">
                        <strong>Component Code:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="componentcode" placeholder="Component Code" />
                    </div>
                    <div class="form-group" style="display: none">
                        <strong>Sub-Component  Code:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="subcomponentcode" placeholder="Sub-Component Code" />
                    </div>
                    <div class="form-group">
                        <strong>University Comments/Feedback:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="universityfeedback" placeholder="University Feedback" TextMode="MultiLine" />
                    </div>
                     <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Upload Evidence:</strong>
                            <asp:FileUpload runat="server" CssClass="form-control" ID="evidences"  />
                        </div>
                    </div>  
                </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Submit Feedback" ID="makeComments" OnClick="SendFeedback_Click" />
                </div>
            </div>

        </div>
    </div>

    <script>
        $(document).ready(function () {
            $('#dataTables-example').DataTable({
                responsive: true
            });
        });
        $(document).ready(function () {
            $('#dataTables-example1').DataTable({
                responsive: true
            });
        });
    </script>
    <script>
        function makeComments(accreditation, voucherNumber, component, subcomponent) {
            document.getElementById("MainContent_accreditationnumber").value = accreditation;
            document.getElementById("MainContent_componentcode").value = component;
            document.getElementById("MainContent_verificationNumber").value = voucherNumber;
            document.getElementById("MainContent_subcomponentcode").value = subcomponent;
            $("#makeCommentsModal").modal();
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
    <script src="https://github.com/eligrey/Blob.js"></script>
    <script src="https://rawgit.com/eligrey/FileSaver.js/src/FileSaver.js"></script>
    <script src="https://unpkg.com/xlsx/dist/xlsx.full.min.js"></script>
</asp:Content>
