<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AccreditationMaster.Master" CodeBehind="ProgrammesPendingPayments.aspx.cs" Inherits="CicPortal.ProgrammesPendingPayments" %>

<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <div class="row">
            <div class="col-md-12 col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">Applications Pending Payment(Please make payment per Programme)</div>
                    <div class="panel-body">
                        <div id="feedback" runat="server"></div>
                        <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                            <thead>
                                <tr>
                                    <th>Accreditation No:</th>
                                    <th>Programme Name</th>
                                    <th>University</th>
                                    <th>Campus</th>
                                    <th>Application Date</th>
                                    <th>Application Status</th>
                                    <th>Payment Status</th>
                                    <th>Confirm Payment</th>
                                </tr>
                            </thead>
                            <tbody>
                                   <%
                                    var nav = Config.ReturnNav();
                                    var programs = nav.ProgramAccreditation.Where(r => r.Institution_No == Convert.ToString(Session["UniversityCode"]) &&  r.Status == "Awaiting Payments" &&r.Published==true);
                                    foreach (var program in programs)
                                    {
                                        var paids = "";
                                        if (program.Payment_Document == true)
                                        {
                                            paids = "Pending CUE Confirmation";
                                        }
                                        else
                                        {
                                            paids = "Not Paid";
                                        }
                                   %>
                                  <tr>
                                    <td><%=program.Accreditation_No %></td>
                                    <td><%=program.Program_Name %></td>
                                    <td><%=program.Institution_No %></td>
                                    <td><%=program.Campus_Name %></td>
                                    <td><%=program.Date_Created %></td>
                                    <td><%=program.Status %></td>
                                    <td style="background-color: lightgray"><strong style="color: brown"><%=paids %></strong></td>
                                    <%
                                    if (program.Payment_Document == true)
                                    {  %>
                                    <td>
                                        <label class="btn btn-default"><i class="fa fa-times"></i>Payment Confirmed</label></td>
                                    <% }
                                       if (program.Payment_Document == false)
                                    {%>
                                    <td>
                                        <label class="btn btn-success" onclick="makePayments('<%=program.Accreditation_No %>', '<%=program.Program_Name %>')"><i class="fa fa-edit"></i>  Confirm Payment</label></td>
                                    <%}%>
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
    <div id="MakepaymentsModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Programme Accreditation Payments</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="editRationaleCode" type="hidden" />
                    <div class="form-group">
                        <strong>Accreditation Number:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="accreditationnumber" placeholder="Programme Accreditation Number" />
                    </div>
                    <div class="form-group">
                        <strong>Programme Name:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="programmeName" placeholder="Programme Name" ReadOnly="true" />
                    </div>
                    <div class="form-group">
                        <strong>Payment Document:</strong>
                        <asp:FileUpload runat="server" ID="paymentdocument" CssClass="form-control" Style="padding-top: 0px;" />
                        <asp:RequiredFieldValidator runat="server" ID="payments" ControlToValidate="paymentdocument" ErrorMessage="Please attach the Payment Document!" ForeColor="Red" />
                        <div class="form-group">
                            <strong>Payment Reference Number:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="paymentsref" placeholder="Payment Reference Number" />
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Confirm Payments" ID="makePayments" OnClick="ConfirmPayments_Click" />
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
    </script>
    <script>
        function makePayments(no, name) {
            document.getElementById("MainContent_accreditationnumber").value = no;
            document.getElementById("MainContent_programmeName").value = name;
            $("#MakepaymentsModal").modal();
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

