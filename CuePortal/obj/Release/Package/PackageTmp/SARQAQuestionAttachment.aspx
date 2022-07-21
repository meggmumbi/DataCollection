<%@ Page Title="" Language="C#" MasterPageFile="~/QAMaster.Master" AutoEventWireup="true" CodeBehind="SARQAQuestionAttachment.aspx.cs" Inherits="CicPortal.SARQAQuestionAttachment" %>

<%@ Import Namespace="System.IO" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title">Attach Supporting documents in pdf formats, maximum size is 5MB</h3>
        </div>
        <div class="panel-body">
            <center><h3><strong style="color:royalblue" id="sectionname" runat="server"></strong></h3></center>
            <br />
            <div runat="server" id="documentsfeedback"></div>
            <div class="row">
                <div class="col-lg-6 col-md-6">
                    <div class="form-group">
                        <strong>
                            <label class="control-label" runat="server" id="lblquestionname"></label>
                        </strong>
                        <asp:FileUpload runat="server" ID="document" CssClass="form-control" Style="padding-top: 0px;" />
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="document" ErrorMessage="Please upload document, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                <div class="col-lg-6 col-md-6">
                    <div class="form-group">
                        <strong>
                            <label class="control-label" runat="server">Document Name<span style="color: red">*</span> (<i>Specify the exact name of the document attached above e.g university requirements</i>)</label>
                        </strong>
                        <asp:TextBox runat="server" ID="docname" CssClass="form-control" placeholder="Please enter document name attached here" />
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="docname" ErrorMessage="Please enter document name attached here, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                <div class="col-lg-12 col-md-12">
                    <div class="form-group">
                        <strong>
                            <label class="control-label" runat="server">Description<span style="color:red">*</span></label>
                        </strong>
                        <asp:TextBox runat="server" ID="desc" CssClass="form-control" TextMode="MultiLine" Height="200px" placeholder="Please enter description here"/>
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="desc" ErrorMessage="Please enter description here, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 col-md-12">
                    <asp:Button runat="server" CssClass="btn btn-success pull-left" Text="Save Details" ID="uploadDocument" OnClick="uploadDocument_Click" />
                </div>
            </div>
            <br />
            <strong>
                <label class="control-label" runat="server" id="Label1" style="color: royalblue">List of all uploaded documents from all sections</label>
            </strong>
            <table class="table table-bordered table-striped" id="example3">
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
                            String PCNo = Request.QueryString["SARNo"];
                            PCNo = PCNo.Replace('/', '_');
                            PCNo = PCNo.Replace(':', '_');
                            String documentDirectory = filesFolder + PCNo + "/";
                            if (Directory.Exists(documentDirectory))
                            {
                                foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                {
                                    String url = documentDirectory;
                    %>
                    <tr>
                        <td><% =file.Replace(documentDirectory, "") %></td>
                        <td><a href="SARDownLoadFile.aspx?SARNo=<%=PCNo %>&&fileName=<%=file.Replace(documentDirectory, "") %>" class="btn btn-success">Download</a></td>
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
        <div class="panel-footer">
            <asp:Button runat="server" ID="backtoquestions" CssClass="btn btn-info pull-left" Text="Back To Questions" OnClick="backtoquestions_Click" CausesValidation="false"/>
            <div class="clearfix"></div>
        </div>
    </div>

    <script>
        function deleteFile(fileName) {
            document.getElementById("filetoDeleteName").innerText = fileName;
            document.getElementById("MainContent_fileName").value = fileName;
            $("#deleteFileModal").modal();
        }
    </script>

    <div id="deleteFileModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting File</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the file <strong id="filetoDeleteName"></strong>?</p>
                    <asp:TextBox runat="server" ID="fileName" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" OnClick="deleteFile_Click" />
                </div>
            </div>

        </div>
    </div>
</asp:Content>
