<%@ Page Title="" Language="C#" MasterPageFile="~/QAMaster.Master" AutoEventWireup="true" CodeBehind="CorrectionOfFuctualErrors.aspx.cs" Inherits="CicPortal.CorrectionOfFuctualErrors" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="row" style="margin: 10px;">
        <div class="panel panel-green">
            <div class="panel-heading">Fuctual Errors Details  <i>Kindly complete the correction of fuctual errors by selecting the finding response. </i>                
            </div>          
            <div class="panel-body">
               <div id="feedback" style="display: none"></div>
                <input type="hidden" value="<% =Request.QueryString["feedbackNo"] %>" id="txtfeedbackNo"/>
                <table class="table table-bordered table-striped" id="dataTables-example">
                    <thead>
                        <tr>
                            <th style="width: 2em; display: none">#</th>
                            <th style="width: 12em;">Section Description</th>
                            <th>Findings</th>
                            <th>Finding Response</th>
                            <th>Correction</th> 
                        </tr>
                    </thead>
                    <tfoot>
                        <tr>
                            <th><asp:Button runat="server" cssClass="btn btn-primary" Text="Previous Page" formnovalidate ID="PreviousPage" OnClick="PreviousPage_Click"/></th>
                            <th></th>
                            <th></th> 
                            <th><button type="submit" class="btn btn-success btnInsertCmps">Submit Response To CUE</button></th>                      
                        </tr>
                    </tfoot>
                    <tbody>
                    <% 
                        string feedbackNo = Request.QueryString["feedbackNo"];
                        var ratingComponents = Config.ReturnNav().SARCompletenessLines.Where(x=> x.Code == feedbackNo).ToList();
                        var findings = "";
                        foreach(var project in ratingComponents)
                        {                            
                            findings = new Config().ObjNav().FngetAuditFindings(feedbackNo);
                                %>
                            <tr>
                                <td style="display:none"><input class="form-control" type="text" value="<%=project.Section_Code %>" disabled="disabled" style="width: 5em;"/></td>
                                <td><textarea  disabled="disabled" style="width: 23em; word-wrap: break-word!important;"><%=project.Section_Description %></textarea></td>
                                <td><textarea  disabled="disabled" style="width: 40em; word-wrap: break-word!important;"><%=findings %></textarea></td>
                                <td><select class="form-control" required="required" id="strength">
                                        <option>--Select--</option>
                                        <option value="1">No Fuctual Error</option>
                                        <option value="2">Fuctual Error</option>
                                    </select>
                                </td>
                                <td><input runat="server" type="text" class="form-control" required="required" id="weakness"/></td>
                            </tr>  
                                <%
                         }                    
                         %>
                    </tbody>
             </table>         
            </div>
     </div>
</div>
<div id="addauditcommentsModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Please Choose Feedback Type</h4>
      </div>
          <div class="modal-body">
          <asp:TextBox runat="server" ID="txtappno" type="hidden"/>
         <div class="form-group">
            <strong>Feedback Type:</strong>
            <asp:DropDownList runat="server" CssClass="form-control" ID="feedbacktype" AutoPostBack="false">
                <asp:ListItem Value="0">--Select Feedback Type--</asp:ListItem>
                <asp:ListItem Value="Curriculum Expert">Curriculum Expert</asp:ListItem>
                <asp:ListItem Value="Panel Chair">Panel Chair</asp:ListItem>
                <asp:ListItem Value="Finance">Finance</asp:ListItem>
                <asp:ListItem Value="QA Expert">QA Expert</asp:ListItem>
                <asp:ListItem Value="Student/Staff Welfare">Student/Staff Welfare</asp:ListItem>
                <asp:ListItem Value="Architect">Architect</asp:ListItem>
            </asp:DropDownList>
        </div> 
          </div>
      <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal" >Close</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Add Comments" ID="addauditcomment"/>
      </div>
    </div>
  </div>
</div>
<script>
    $(document).ready(function() {
        $('#dataTables-example').DataTable({
            responsive: false
        });
    });

    $("body").delegate("#dataTables-example .btnInsertCmps", "click", function (event) {
        //To prevent form submit after ajax call
        event.preventDefault();
        //Loop through the Table rows and build a JSON array.
        var allrfqitems = new Array();
        $("#dataTables-example TBODY TR").each(function () {
            var row = $(this);
            var onerfqitem = {};
            //i++;

            onerfqitem.TfeedbackNo = $("#txtfeedbackNo").val();
            onerfqitem.TSectionCode = row.find("TD input").eq(0).val();
            onerfqitem.TFindingResponse = row.find("TD select").eq(0).val();
            onerfqitem.TInstitutionResponse = row.find("TD input").eq(1).val();
            allrfqitems.push(onerfqitem);
            
        });
        
        $.ajax({
            type: "POST",
            url: "CorrectionOfFuctualErrors.aspx/InsertComponentItems",
            data: '{cmpitems: ' + JSON.stringify(allrfqitems) + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (status) {
                switch (status.d) {
                case "success":
                    Swal.fire
                    ({
                        title: "Feedback Added!",
                        text: "The response of correction of fuctual errors have been submitted successfully!",
                        type: "success"
                    }).then(() => {
                        $("#feedback").css("display", "block");
                        $("#feedback").css("color", "green");
                        $('#feedback').attr("class", "alert alert-success");
                        $("#feedback").html("The response of correction of fuctual errors have been submitted successfully!");
                    }).then(() => {
                        var sarno = $(".txtsurveyNo").val();
                        var type = $(".txtType").val();
                        $(location).attr('href', 'QualityAudit.aspx')
                    });
                    break;

                  case "componentnull":
                    Swal.fire
                    ({
                        title: "Component not filled!",
                        text: "Component field empty!",
                        type: "danger"
                    }).then(() => {
                        $("#feedback").css("display", "block");
                        $("#feedback").css("color", "red");
                        $('#feedback').attr("class", "alert alert-danger");
                        $("#feedback").html("Component field empty!");
                    });
                    break;
                default:
                    Swal.fire
                    ({
                        title: "The response could not be saved!",
                        text: "Please try again!",
                        type: "error"
                    }).then(() => {
                        $("#feedback").css("display", "block");
                        $("#feedback").css("color", "red");
                        $('#feedback').addClass('alert alert-danger');
                        $("#feedback").html(status.d);
                    });
                   
                    break;
                }
            },
            error: function(err) {
                console.log(err.statusText);
                console.log(status.d);
            }
            
        });
        
        console.log(allrfqitems);

    });

</script>
<%--<script>
    //$("#strength").on('change', function () {
    //    //alert($(this).val());
    //    if ($(this).val() == "Fuctual Error") {
    //        $("#addauditcommentsModal").modal('show');
    //    }
    //});
    $("#strength").change(function () {
        $("#dataTables-example TBODY TR").each(function () {
            var row = $(this);
            //var onerfqitem = row.find("TD select").eq(0).val();
            if ($(this).val() == "Fuctual Error") {
                $("#addauditcommentsModal").modal('show');
            }
        });
        //$('#addauditcommentsModal').modal('show')
    });
</script>--%>
</asp:Content>
