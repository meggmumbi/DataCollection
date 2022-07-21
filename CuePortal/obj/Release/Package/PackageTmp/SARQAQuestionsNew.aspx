<%@ Page Title="" Language="C#" MasterPageFile="~/QAMaster.Master" AutoEventWireup="true" CodeBehind="SARQAQuestionsNew.aspx.cs" Inherits="CicPortal.SARQAQuestionsNew" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%
        var nav = Config.ReturnNav();
        string SARNo = Request.QueryString["SARNo"];
        string sectionCode = Request.QueryString["sectionID"];
        string Type = Request.QueryString["Type"];
    %>
    <div class="panel panel-primary">
        <div class="panel panel-default">
            <div class="panel-heading">
                SAR Questions
                <div class="clearfix"></div>
            </div>
        </div>
        <div class="panel-body">
            <div runat="server" id="gradingSystemFeedback"></div>
            <%
                var sections = nav.SARSectionsSetup.Where(r => r.Code == sectionCode);
                foreach (var sect in sections)
                {
            %><center><h3><strong><label style="color:royalblue"><%="AUDIT CRITERIA: "+sect.Description %></label></strong></h3></center>
            <br />
            <%
                }
            %>
            <table class="table table-bordered table-striped dataTable">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Question</th>
                        <th>Question Type</th>
                        <th>Save Details</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int gradecounter = 0;
                        string allData = new Config().ObjNav().FnGetAllAuditLinesEach(SARNo, sectionCode);
                        String[] info1 = allData.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                        if (info1 != null)
                        {
                            foreach (var data in info1)
                            {
                                gradecounter++;
                                String[] arr = data.Split('*');
                    %>
                    <tr>

                        <td><%=gradecounter %></td>
                        <td><%=arr[4] %></td>
                        <td><%=arr[5] %></td>
                        <%
                            if (arr[5] == "Open-Ended")
                            {
                        %>
                        <td><a href="SARQAQuestionOpenEnded.aspx?SARNo=<%=SARNo %>&&sectionID=<%=sectionCode %>&&questionID=<%=arr[3] %>&&lineno=<%=arr[0] %>&&Type=<%=Type %>" class="btn btn-info"><i class="fa fa-save"></i>Save/Edit</a> </td>
                        <%
                            }
                            if (arr[5] == "Closed-Ended")
                            {
                        %>
                        <td><a href="SARQAQuestionClosedEnded.aspx?SARNo=<%=SARNo %>&&sectionID=<%=sectionCode %>&&questionID=<%=arr[3] %>&&lineno=<%=arr[0] %>&&Type=<%=Type %>" class="btn btn-info"><i class="fa fa-save"></i>Save/Edit</a> </td>
                        <%
                            }
                            if (arr[5] == "Date")
                            {
                        %>
                        <td><a href="SARQAQuestionDate.aspx?SARNo=<%=SARNo %>&&sectionID=<%=sectionCode %>&&questionID=<%=arr[3] %>&&lineno=<%=arr[0] %>&&Type=<%=Type %>" class="btn btn-info"><i class="fa fa-save"></i>Save/Edit</a> </td>
                        <%
                            }
                            if (arr[5] == "Attachment")
                            {
                        %>
                        <td><a href="SARQAQuestionAttachment.aspx?SARNo=<%=SARNo %>&&sectionID=<%=sectionCode %>&&questionID=<%=arr[3] %>&&lineno=<%=arr[0] %>&&Type=<%=Type %>" class="btn btn-info"><i class="fa fa-save"></i>Save/Edit</a> </td>
                        <%
                            }
                        %>
                        <%
                            if (arr[7].Length > 0)
                            {
                        %>
                        <td>
                            <label class="btn btn-success"><i class="fa fa-check"></i>Data Saved</label></td>
                        <%
                            }
                            else
                            {
                        %>
                        <td>
                            <label class="btn btn-danger"><i class="fa fa-times"></i>Not Saved</label></td>
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
        <div class="panel-footer">
            <div class="pull-left">
                <asp:Button runat="server" CssClass="btn btn-info" Text="Back To Sections" CausesValidation="false" ID="back" OnClick="back_Click" />
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
    <script>

        function OpenEndedClick(qzName, lineNo, qType) {
            document.getElementById("questionName").innerText = qzName;
            document.getElementById("MainContent_txtLineNo").value = lineNo;
            document.getElementById("MainContent_txtQuestionType").value = qType;
            $("#OpenEndedClickModal").modal();
        }

        function ClosedEndedClick(qzName, lineNo, qType) {
            document.getElementById("questionName1").innerText = qzName;
            document.getElementById("MainContent_txtLineNo1").value = lineNo;
            document.getElementById("MainContent_txtQuestionType1").value = qType;
            $("#ClosedEndedClickModal").modal();
        }

        function DateClick(qzName, lineNo, qType) {
            document.getElementById("questionName2").innerText = qzName;
            document.getElementById("MainContent_txtLineNo2").value = lineNo;
            document.getElementById("MainContent_txtQuestionType2").value = qType;
            $("#DateClickModal").modal();
        }

        function AttachmentClick(qzName, lineNo, qType) {
            document.getElementById("questionName3").innerText = qzName;
            document.getElementById("MainContent_txtLineNo3").value = lineNo;
            document.getElementById("MainContent_txtQuestionType3").value = qType;
            $("#AttachmentClickModal").modal();
        }
    </script>
    <div id="OpenEndedClickModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Save/Edit Question</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="txtLineNo" type="hidden" />
                    <asp:TextBox runat="server" ID="txtQuestionType" type="hidden" />
                    <div class="form-group">
                        <strong style="color: red" id="questionName"></strong><i style="color: darkblue">(Kindly enter your response in paragraph format)</i>
                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Enter your answer here" ID="editopenendedanswer" TextMode="MultiLine" Height="250px" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" ID="btn_Open_Ended" Text="Save" OnClick="btn_Open_Ended_Click" />
                </div>
            </div>

        </div>
    </div>

    <div id="ClosedEndedClickModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Save/Edit Question</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="txtLineNo1" type="hidden" />
                    <asp:TextBox runat="server" ID="txtQuestionType1" type="hidden" />
                    <div class="form-group">
                        <strong style="color: red" id="questionName1"></strong>
                        <asp:DropDownList CssClass="form-control" runat="server" ID="editclosedended" AppendDataBoundItems="true">
                            <asp:ListItem>--Select--</asp:ListItem>
                            <asp:ListItem>YES</asp:ListItem>
                            <asp:ListItem>NO</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" ID="btn_Closed_Ended" Text="Save" OnClick="btn_Closed_Ended_Click" />
                </div>
            </div>

        </div>
    </div>

    <div id="DateClickModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Save/Edit Question</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="txtLineNo2" type="hidden" />
                    <asp:TextBox runat="server" ID="txtQuestionType2" type="hidden" />
                    <div class="form-group">
                        <strong style="color: red" id="questionName2"></strong>
                        <asp:TextBox runat="server" CssClass="form-control" TextMode="Date" placeholder="Enter date here" ID="editdate" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" ID="btn_Date" Text="Save" OnClick="btn_Date_Click" />
                </div>
            </div>

        </div>
    </div>

    <div id="AttachmentClickModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Save/Edit Question</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="txtLineNo3" type="hidden" />
                    <asp:TextBox runat="server" ID="txtQuestionType3" type="hidden" />
                    <div class="form-group">
                        <strong style="color: red" id="questionName3"></strong>
                        <asp:FileUpload CssClass="form-control" runat="server" ID="editattachment" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" ID="btn_Attachment" Text="Save" OnClick="btn_Attachment_Click" />
                </div>
            </div>
            <table id="example2" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Document Title</th>
                        <th>Download</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try
                        {
                            String fileFolderApplication = ConfigurationManager.AppSettings["FileFolderApplication"];
                            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Institution Audit Response/";
                            String imprestNo = Request.QueryString["SARNo"];
                            imprestNo = imprestNo.Replace('/', '_');
                            imprestNo = imprestNo.Replace(':', '_');
                            String documentDirectory = filesFolder + imprestNo + "/";
                            if (Directory.Exists(documentDirectory))
                            {
                                foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                {
                                    String url = documentDirectory;
                    %>
                    <tr>
                        <td><% =file.Replace(documentDirectory, "") %></td>

                        <td><a href="<%=fileFolderApplication %>\Imprest Memo\<% =imprestNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success" download>Download</a></td>
                        <td>
                            <label class="btn btn-danger" onclick="deleteFile('<%=file.Replace(documentDirectory, "")%>');"><i class="fa fa-trash-o"></i>Delete</label></td>
                    </tr>
                    <%
                                }
                            }
                        }
                        catch (Exception)
                        {

                        }%>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
