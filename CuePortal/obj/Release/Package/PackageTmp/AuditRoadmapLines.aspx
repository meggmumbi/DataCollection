<%@ Page Title="" Language="C#" MasterPageFile="~/QAMaster.Master" AutoEventWireup="true" CodeBehind="AuditRoadmapLines.aspx.cs" Inherits="CicPortal.AuditRoadmapLines" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <div class="row">
            <div class="col-md-12 col-lg-12">
                  <div class="panel panel-default">
                <div class="panel-heading">Roadmap For Corrective Actions</div>
                      <br />  <asp:Button runat="server" style="margin-left:75%" CssClass="btn btn-warning" Text="Print Audit Roadmap" ID="ViewRoadmapDetails" OnClick="ViewRoadmapDetails_Click"/><br /><br />  
                <div class="panel-body">
                    <div id ="feedback" runat="server"></div>
                   <table class="table table-bordered table-striped" id="dataTables-example">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Audit Criteria</th>
                            <th>Recommendations</th>
                            <th>Due Date</th>
                            <th>Respond</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        var RoadmapNo = Request.QueryString["RoadmapNo"];
                        var EvalsubComponents = Config.ReturnNav().SARCompletenessLines.Where(x=> x.Code == RoadmapNo).ToList();
                        int programesCounter = 0;
                        var tRecommendation = "";
                        foreach (var project in EvalsubComponents)
                        {
                            programesCounter++;
                            tRecommendation = new Config().ObjNav().FngetAuditRoadmapReccomendation(RoadmapNo);
                            %>
                            <tr>
                                    <td><%=programesCounter %></td>
                                    <td><%=project.Section_Description %></td>                                   
                                    <td><%=tRecommendation %></td>
                                    <td><% = Convert.ToDateTime(project.Due_Date).ToString("dd/MM/yyyy")%></td>
                                    <td><label class="btn btn-success" onclick="addresponse('<%=project.Section_Code %>','<%=project.Section_Description %>')"><i class="fa fa-eye"></i> Respond</label></td>
                            </tr> 
                            <%
                        }

                    %>
                    </tbody>
                </table>  
                    </div> 
                <br />  
                <center>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Submit Response To CUE" ID="submitresponse" OnClick="submitresponse_Click"/><br /><br />                     
                </center>
                </div>
                <br />
                     <asp:Button runat="server" style="margin-left:2%" CssClass="btn btn-warning" Text="Back To Home Page" ID="GoToHomepage" OnClick="GoToHomepage_Click"/>
                <br />
                <br />
            </div>
           </div>
         </div>


    <div id="addresponsemodal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Add Response</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="tsextioncode" type="hidden" />
                    <asp:TextBox runat="server" ID="tsectiondesc" type="hidden" />
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
                        <asp:TextBox runat="server" CssClass="form-control" ID="effectivedate" placeholder="Please Select Effective Date"/>
                    </div>
                    <div class="form-group">
                        <strong>Attach Evidence</strong>
                        <asp:FileUpload runat="server" CssClass="form-control" ID="attachment"/>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Save" ID="savedetails" OnClick="savedetails_Click"/>
                </div>
            </div>

        </div>
    </div>

<script>
    function addresponse(sectioncode, sectdes) {       
        document.getElementById("MainContent_tsextioncode").value = sectioncode;
        document.getElementById("MainContent_tsectiondesc").value = sectdes;
        $("#addresponsemodal").modal();
    }

        $(document).ready(function () {
        $("#<%= effectivedate.ClientID %>").datepicker({ dateFormat: "dd/mm/yy" }).val();
    });
</script>
</asp:Content>
