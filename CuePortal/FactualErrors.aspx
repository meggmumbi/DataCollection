<%@ Page Title="" Language="C#" MasterPageFile="~/QAMaster.Master" AutoEventWireup="true" CodeBehind="FactualErrors.aspx.cs" Inherits="CicPortal.FactualErrors" %>

<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="DataCollection.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">Correction of Factual Errors</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
            Correction of Factual Errors <i style="color: yellow">Kindly ensure you respond to each audit criteria before submitting your response.</i>
        </div>
        <div class="panel-body">
            <div runat="server" id="generalFeedback"></div>
            <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Audit Criteria</th>
                        <th>Findings</th>
                        <th>Respond</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int counter = 0;
                        string feedbackNo = Request.QueryString["feedbackNo"];
                        string allData = new Config().ObjNav().FnGetSARCompletenessLines(feedbackNo);
                        String[] info = allData.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                        if (info != null)
                        {
                            foreach (var allInfo in info)
                            {
                                counter++;
                                String[] arr = allInfo.Split('*');
                    %>
                    <tr>
                        <td><% =counter %></td>
                        <td><% =arr[1]  %></td>
                        <td><% =arr[2]  %></td>
                        <%
                            if (arr[3] == " ")
                            {
                        %>
                        <td>
                            <label class="btn btn-info" onclick="saveResponse('<%=feedbackNo %>','<%=arr[0] %>','<%=arr[1] %>','<%=arr[3] %>','<%=arr[4]%>');"><i class="fa fa-pencil"></i>Save Response</label></td>
                        <%
                            }
                            else
                            {
                        %>
                        <td>
                            <label class="btn btn-warning" onclick="saveResponse('<%=feedbackNo %>','<%=arr[0] %>','<%=arr[1] %>','<%=arr[3] %>','<%=arr[4]%>');"><i class="fa fa-pencil"></i>Edit Response</label></td>
                        <%
                            }
                        %>
                        <%
                            if (arr[3] != " " && arr[4].Length > 1)
                            {
                        %>
                        <td>
                            <label class="btn btn-success"><i class="fa fa-check"></i>Response Saved</label></td>
                        <%
                            }
                            else
                            {
                        %>
                        <td>
                            <label class="btn btn-danger"><i class="fa fa-times"></i>Response Not Saved</label></td>
                        <%
                            }
                        %>
                    </tr>
                    <% 
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
        <br />
        <br />
        <center>
 <asp:Button runat="server" CssClass="btn btn-success" Text="Preview / Print Correction of Factual Errors" ID="printFactualErrrors" OnClick="printFactualErrrors_Click" CausesValidation="false" />
            </center>
        <br />
        <br />
        <div class="col-sm-12">
            <p><i style="color: royalblue">Kindly ensure you preview your correction of factual errors before submitting your response to the Commission for University Education. Use the button above (Preview / Print Correction of Factual Errors) to preview / print your response.</i></p>
        </div>
        <br />
        <br />
        <div class="modal-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous Page" ID="PreviousPage" OnClick="PreviousPage_Click"  CausesValidation="false"/>
            <asp:Button runat="server" CssClass="btn btn-primary pull-right" Text="Submit Response To CUE" ID="submit" OnClick="submit_Click"  CausesValidation="false"/>
<%--             <label class="btn btn-info" onclick="saveResponse('');"><i class="fa fa-send"></i>Save Response</label>--%>
        </div>
    </div>
    <script>
        function saveResponse(docno, secCode, desc, response, remarks) {
            document.getElementById("tdesc").innerText = desc;
            document.getElementById("MainContent_tdocNo").value = docno;
            document.getElementById("MainContent_tsubCode").value = secCode;
            document.getElementById("MainContent_tresponse").value = response;
            document.getElementById("MainContent_tinsresponse").value = remarks;
            $("#saveResponseModal").modal();
        }
    </script>
    <div id="saveResponseModal" class="modal fade" role="dialog">
        <div class="modal-dialog" style="width: 70%">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h5 class="modal-title"><strong style="color: red">AUDIT CRITERIA - </strong><strong id="tdesc"></strong></h5>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="tdocNo" type="hidden" />
                    <asp:TextBox runat="server" ID="tsubCode" type="hidden" />
                    <div class="form-group">
                        <strong style="color: blue">Finding Response</strong>
                        <asp:DropDownList runat="server" CssClass="form-control" ID="tresponse">
                            <asp:ListItem>--Select--</asp:ListItem>
                            <asp:ListItem>No Factual Error</asp:ListItem>
                            <asp:ListItem>Factual Error</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="tresponse" InitialValue="--Select--" ErrorMessage="Please select finding response, it cannot be empty!" ForeColor="Red" />
                    </div>
                    <div class="form-group">
                        <strong style="color: blue">Institution Response</strong>
                        <asp:TextBox runat="server" CssClass="form-control" Wrap="true" Rows="5" ID="tinsresponse" TextMode="MultiLine" Height="100px" placeholder="Type here..." />
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="tinsresponse" ErrorMessage="Please enter response, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning pull-left" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Save" ID="savedetails" OnClick="savedetails_Click" />
                </div>
            </div>

        </div>
    </div>
</asp:Content>
