<%@ Page Title="" Language="C#" MasterPageFile="~/AccreditationMaster.Master" AutoEventWireup="true" CodeBehind="RecommendationLines.aspx.cs" Inherits="CicPortal.RecommendationLines" %>

<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="panel panel-default">
        <div class="panel-heading">Recommendations</div>
        <div class="panel-body">
            <div id="feedback" runat="server"></div>
            <div class="col-md-12 col-lg-12">
                <div class="panel-body">
                    <label class="btn btn-info pull-left" data-toggle="modal" data-target="#addresponsemodal"><i class="fa fa-plus fa-fw"></i>Click To Add Recommendations</label>
                </div>
            </div>
            <table class="table table-striped table-bordered table-hover dataTable2" id="dataTables-example">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Recommendation</th>
                        <th>Response Status</th>
                        <th>Effective Date</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int counter = 0;
                        string docNo = Convert.ToString(Request.QueryString["docNo"]);
                        int lineNo = Convert.ToInt32(Request.QueryString["lineNo"]);
                        string allData = new Config().ObjNav().FnGetProposalRec(docNo, lineNo);
                        String[] info = allData.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                        if (info != null)
                        {
                            foreach (var allInfo in info)
                            {
                                counter++;
                                String[] arr = allInfo.Split('*');
                            %>
                            <tr>
                                <td><% =counter%></td>
                                <td><% =arr[1] %></td>
                                <td><% =arr[2]  %></td>
                                <td><% =arr[3]  %></td>
                                                        <td>
                            <label class="btn btn-info" onclick="addresponse('<%=arr[0] %>','<%=arr[1] %>','<%=arr[2] %>','<%=arr[3]%>');"><i class="fa fa-pencil"></i>Edit Response</label></td>
                                                                                        <td>
                            <label class="btn btn-danger" onclick="deleteaddresponse('<%=arr[0] %>');"><i class="fa fa-times"></i>Delete</label></td>
                            </tr>
                            <% 
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
                <div class="modal-footer">
            <asp:Button runat="server" CssClass="btn btn-primary pull-left" Text="Previous" ID="previous" OnClick="previous_Click"/>
        </div>
    </div>
    <div id="addresponsemodal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 style="color:royalblue" class="modal-title"><%=Request.QueryString["secName"].Trim() %></h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="tentryNo" type="hidden" />
                    <div class="form-group">
                        <strong>Institution Remarks</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="remarks" TextMode="MultiLine" placeholder="Please Enter Remarks" />
                    </div>
                    <div class="form-group">
                        <strong>Status</strong>
                        <asp:DropDownList runat="server" CssClass="form-control" ID="status" placeholder="Please Select Status">
                            <asp:ListItem Value="0">--Select Status--</asp:ListItem>
                            <asp:ListItem Value="1">Done</asp:ListItem>
                            <asp:ListItem Value="2">Not Done</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <strong>Effective Date</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="effectivedate" placeholder="Please Select Effective Date" />
                    </div>
                    <div class="form-group">
                        <strong>Attach Evidence</strong>
                        <asp:FileUpload runat="server" CssClass="form-control" ID="attachment" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Save" ID="savedetails" OnClick="savedetails_Click" />
                </div>
            </div>

        </div>
    </div>
        <div id="deleteaddresponsemodal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 style="color:royalblue" class="modal-title"><%=Request.QueryString["secName"].Trim() %></h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="tnentryNo" type="hidden" />
                    <strong>Are you sure you want to delete line?</strong>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning pull-left" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Delete" ID="delete" OnClick="delete_Click" />
                </div>
            </div>

        </div>
    </div>
    <script>
        function addresponse(entryno, rec, resp, effdate) {
            document.getElementById("MainContent_tentryNo").value = entryno;
            document.getElementById("MainContent_remarks").value = rec;
            document.getElementById("MainContent_status").value = resp;
            document.getElementById("MainContent_effectivedate").value = effdate;
            $("#addresponsemodal").modal();
        }
        function deleteaddresponse(entryno) {
            document.getElementById("MainContent_tnentryNo").value = entryno;
            $("#deleteaddresponsemodal").modal();
        }
    </script>
    <script>
        $('#MainContent_effectivedate').datepicker({
            autoclose: true, format: 'd/mm/yyyy'
        });
    </script>
</asp:Content>
