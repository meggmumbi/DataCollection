<%@ Page Title="" Language="C#" MasterPageFile="~/AccreditationMaster.Master" AutoEventWireup="true" CodeBehind="SiteInspectionRecommendation.aspx.cs" Inherits="CicPortal.SiteInspectionRecommendation" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <div class="row">
            <div class="col-md-12 col-lg-12">
                  <div class="panel panel-default">
            <div class="panel-heading">Recommendation Reporting</div>
                <div class="panel-body">
                    <div id ="feedback" runat="server"></div>
                     <table class="table table-striped table-bordered table-hover dataTable2"  id="dataTables-example">
                       <thead>
                         <tr>
                            <th>Chapter Name</th>
                            <th>Topic Name</th>
                            <th>Response To Recommendation</th>
                         </tr>
                         </thead>
                         <tbody>
                         <%
                             var nav = Config.ReturnNav();
                             string docNo = Request.QueryString["docNo"];
                             var programs = nav.ProposalDocumentTemplate.Where(r => r.Application_No == docNo);
                             foreach (var program in programs)
                             {
                             %>
                             <tr>
                                 <td><%=program.Chapter_Name %></td>
                                 <td><%=program.Topic_Name %></td> 
                                 <td><a href="RecommendationLines.aspx?docNo=<%=docNo %>&&lineNo=<%=program.Line_No %>&&secName=<%=program.Topic_Name %>" class="btn btn-info">View Details</a></td>                           
                             </tr>
                             <%
                            }
                         %>
                         </tbody>
                     </table>   
                    </div> 
 
                </div>
                <br />
                     <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="Previous" OnClick="Previous_Click"/>
                 <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Submit To CUE" ID="submittocue" OnClick="submittocue_Click"/>
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
    function addresponse(sectioncode, name) {       
        document.getElementById("MainContent_tsextioncode").value = sectioncode;
        document.getElementById("MainContent_tsectiondesc").value = name;
        $("#addresponsemodal").modal();
    }

        $(document).ready(function () {
        $("#<%= effectivedate.ClientID %>").datepicker({ dateFormat: "dd/mm/yy" }).val();
    });
</script>
</asp:Content>
