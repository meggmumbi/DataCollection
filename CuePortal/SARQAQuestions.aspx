<%@ Page Title="" Language="C#" MasterPageFile="~/QAMaster.Master" AutoEventWireup="true" CodeBehind="SARQAQuestions.aspx.cs" Inherits="CicPortal.SARQAQuestions" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div>
    <%var nav = Config.ReturnNav(); %>
    <div class="row">
        <div class="col-md-12 col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">Audit Questions</div>
                    <div class="panel-body">
                        <div id="feedback" style="display: none"></div>
                        <div runat="server" id="documentsfeedback"></div>
                        <%
                            string SARNo = Request.QueryString["SARNo"];
                            string sectionCode = Request.QueryString["sectionID"];
                             string Type = Request.QueryString["Type"];
                            var sections = nav.SARSectionsSetup.Where(r => r.Code == sectionCode);
                            foreach(var sect in sections)
                            {
                                %><center><h3><strong><label style="color:red"><%="SECTION NAME: " + sect.Description %></label></strong></h3></center><br /><%
                            }

                                var Qsections = nav.AuditResponseLines.Where(x=> x.Audit_Requisition_No == SARNo && x.Section_ID == sectionCode);
                                foreach (var qSection in Qsections)                                 
                                {
                                    Session["QuestionID"] = qSection.Question_ID;
                                    %>
                                    <div class="divSurvey">
                                    <input type="hidden" value="<% =Request.QueryString["SARNo"] %>" class="txtsurveyNo"/>
                                    <input type="hidden" value="<% =Request.QueryString["Type"] %>" class="txtType"/>
                                    <input type="hidden" value="<% =Request.QueryString["sectionID"] %>" class="txtsectioncode"/>
                                    <input type="hidden" value="<% =qSection.Section_Description %>" class="txtsectiondescription"/>
                                    <input type="hidden" value="<% =qSection.Question_Type %>" class="QuesionType"/>
                                    <input type="hidden" value="<% =qSection.Question_ID %>" class="txtquestionId"/>
                                    <input type="hidden" value="<% =qSection.Question_Description %>" class="QuesionDesc"/>
                                    <input type="hidden" value="<% =qSection.Response_Code %>" class="QuesionResponseCode"/>
                                    <%
                                    if (qSection.Question_Type == "Open-Ended")
                                    {
                                    %>                                     
                                      <div class="col-md-6 col-lg-6">
                                            <div class="form-group">
                                                <label><%=qSection.Question_Description %></label>
                                                    <textarea class="form-control openended" rows="1"></textarea>  
                                            </div>
                                        </div>
                                    <%
                                    }
                                    else if (qSection.Question_Type == "Closed-Ended")
                                    {
                                        var answerType = qSection.Response_Code;
                                        var answers = nav.AnswersOptions.Where(x=> x.Answer_Code == answerType);
                                        ratingItemsD.DataSource = answers;
                                        ratingItemsD.DataTextField = "Description";
                                        ratingItemsD.DataValueField = "Code";
                                        ratingItemsD.DataBind();
                                        %>
                                            <div class="col-md-6 col-lg-6">
                                                <div class="form-group">
                                                    <label><%=qSection.Question_Description %></label>

                                                    <select id="ratingItemsD" runat="server" cssclass="form-control closedended" name="D1" style="width:300PX">
                                                        <option></option>
                                                    </select>
 <%--                                                    <asp:DropDownList CssClass="form-control closedended" runat="server" ID="" AppendDataBoundItems="true">
                                                         <asp:ListItem>--Select Response--</asp:ListItem>  
                                                     </asp:DropDownList> --%>
                                                </div>
                                            </div>
                                        <%
                                    }
                                    else if (qSection.Question_Type == "Attachment")
                                    {
                                        %>
                                            <div class="col-md-6 col-lg-6">
                                                <div class="form-group">
                                                    <label><%=qSection.Question_Description %></label>
                                                     <asp:FileUpload CssClass="form-control attachment" runat="server" ID="attachment"/>
                                                   <%--  <br />
                                                   <asp:Button runat="server" CssClass="btn btn-success" Text="Attach Supporting Document" ID="attachfile"/>--%>  
                                                </div>
                                            </div>
                                        <%
                                    }
                                    else if (qSection.Question_Type == "Date")
                                    {
                                        %>
                                            <div class="col-md-6 col-lg-6">
                                                <div class="form-group">
                                                    <label><%=qSection.Question_Description %></label>
                                                    <asp:TextBox CssClass="form-control txtdate" runat="server" ID="txtdate" TextMode="Date"/>   
                                                </div>
                                            </div>
                                        <%
                                    }
                                 %>  </div> <%
                              }
                         %>

              
                    </div>
                <br />  
                <center>
                    <button type="submit" class="btn btn-success  saveresponce">Save Response</button><br /><br />                     
                </center>
                
            </div>
                 <asp:Button type="button" class="btn btn-warning pull-left" ID="previouspage" runat="server" Text="Back To Sections" OnClick="previouspage_Click"/>  
        </div>
    </div>
</div>
<script>
    $("body").delegate(".saveresponce", "click", function (event) {
            //To prevent form submit after ajax call

            event.preventDefault();
            //Loop through the Table rows and build a JSON array.
            var allrfqitems = new Array();
            //declare an array
            var i = 0;

            $(".divSurvey").each(function () {
                var row = $(this);
                var onerfqitem = {};

                i++;

                onerfqitem.SurveyNo = row.attr("id", "txtsurveyNo" + i).find(".txtsurveyNo").val(); 

                onerfqitem.SectionCode = row.attr("id", "txtsectioncode" + i).find(".txtsectioncode").val(); 

                onerfqitem.SectionDesc = row.attr("id", "txtsectiondescription" + i).find(".txtsectiondescription").val();

                onerfqitem.QuestionType = row.attr("id", "QuesionType" + i).find(".QuesionType").val();

                onerfqitem.QuestionId = row.attr("id", "txtquestionId" + i).find(".txtquestionId").val();

                onerfqitem.QuestionDescription = row.attr("id", "QuesionDesc" + i).find(".QuesionDesc").val();

                onerfqitem.OpenQuiz = row.attr("id", "openended" + i).find(".openended").val();

                onerfqitem.ClosedQuiz = row.attr("id", "closedended" + i).find(".closedended").val(); 

                onerfqitem.SDate = row.attr("id", "txtdate" + i).find(".txtdate").val(); 

                onerfqitem.AttachedDoc = row.attr("id", "attachment" + i).find(".attachment").val();

                onerfqitem.QuestionResponseCode = row.attr("id", "QuesionResponseCode" + i).find(".QuesionResponseCode").val();

                //onerfqitem.SurveyNo = $(".txtsurveyNo").val();
                //onerfqitem.SectionCode = $(".txtsectioncode").val();
                //onerfqitem.QuestionId = $(".txtquestionId").val(); 
                //onerfqitem.QuestionDescription = $("#QuesionDesc").val();
                //onerfqitem.OpenQuiz = $(".openended").val();
                //onerfqitem.ClosedQuiz = $("#closedended").val();
                //onerfqitem.SDate = $("#txtdate").val();
                allrfqitems.push(onerfqitem);

            });

            $.ajax({
                type: "POST",
                url: "SARQAQuestions.aspx/InsertComponentItems",
                data: '{cmpitems: ' + JSON.stringify(allrfqitems) + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (status) {
                    switch (status.d) {
                        case "success":
                            Swal.fire
                            ({
                                title: "Response Saved!",
                                text: "The Audit Response was saved successfully, Click Ok button to complete responding to other audit sections",
                                type: "success"
                            }).then(() => {
                                $("#feedback").css("display", "block");
                                $("#feedback").css("color", "green");
                                $('#feedback').attr("class", "alert alert-success");
                                $("#feedback").html("The Audit Response was saved successfully, Click Ok button to complete responding to other audit sections");
                            }).then(() => {
                                var sarno = $(".txtsurveyNo").val();
                                var type = $(".txtType").val();
                                //window.location.replace("QAqestions.aspx?SARNo=" + sarno + "Type=" + type);
                                $(location).attr('href', 'QAqestions.aspx?SARNo=' + sarno + '&&Type=' + type)
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
                                title: "Audit Response Failed!!!",
                                text: "The audit response could not be saved successfully, please try again!",
                                type: "error"
                            }).then(() => {
                                //$("#feedback").css("display", "block");
                                //$("#feedback").css("color", "red");
                                //$('#feedback').addClass('alert alert-danger');
                                //$("#feedback").html(status.d);
                            });

                            break;
                    }
                },
                error: function (err) {
                    console.log(err.statusText);
                    console.log(status.d);
                }

            });

            console.log(allrfqitems);
    });
</script>
</asp:Content>
