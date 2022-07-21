<%@ Page Title="" Language="C#" MasterPageFile="~/QAMaster.Master" AutoEventWireup="true" CodeBehind="QAqestions.aspx.cs" Inherits="CicPortal.QAqestions" %>

<%@ Import Namespace="CicPortal" %>
<%@ Import Namespace="System.IO" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <div class="row">
            <div class="col-md-12 col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">Self Assessment Sections <i>(Kindly respond to all the sections provided below. More sections can be accessed by clicking next at the bottom of the page) </i></div>
                    <div class="panel-body">
                        <div id="documentsfeedback" runat="server"></div>
                        <asp:Button runat="server" CssClass="btn btn-info pull-right" Text="Preview/Print SAR" ID="print" OnClick="print_Click" />
                        <br />
                        <br />
                        <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Audit Criteria</th>
                                    <th>View Audit Questions</th>
                                    <th>No of Questions</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    var nav = Config.ReturnNav();
                                    string Type = Request.QueryString["Type"];
                                    string docNo = Request.QueryString["SARNo"];
                                    var programs = nav.SARSectionsSetup.Where(x => x.Category == Type);
                                    int programcounter = 0;
                                    int qzno = 0;
                                    string ans = "";
                                    foreach (var program in programs)
                                    {
                                        qzno = nav.AuditResponseLines.Where(x => x.Audit_Requisition_No == Request.QueryString["SARNo"] && x.Section_ID == program.Code).ToList().Count;
                                        string allData = new Config().ObjNav().FnGetAuditLineDescription(Request.QueryString["SARNo"], program.Code);
                                        String[] info = allData.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                                        if (info != null)
                                        {
                                            foreach (var data in info)
                                            {
                                                String[] arr = data.Split('*');
                                                ans = arr[1];
                                            }
                                        }

                                        programcounter++;
                                %>
                                <tr>
                                    <td><%=programcounter %></td>
                                    <td><%=program.Description %></td>
                                    <td><a href="SARQAQuestionsNew.aspx?SARNo=<%=Request.QueryString["SARNo"] %>&&Type=<%=Request.QueryString["Type"] %>&&sectionID=<%=program.Code %>" class="btn btn-success"><i class="fa fa-eye"></i>View Audit Questions</a></td>
                                    <td>
                                        <label class="btn btn-info"><i class="fa fa-plus"></i><%=qzno + " Question(s)"%></label></td>
                                    <%
                                        if (ans.Length > 0)
                                        {
                                    %><td>
                                        <label class="btn btn-success"><i class="fa fa-check"></i>Answered</label></td>
                                    <%
                                        }
                                        else
                                        {
                                    %><td>
                                        <label class="btn btn-danger"><i class="fa fa-times"></i>Unanswered</label></td>
                                    <%
                                        }
                                    %>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>

                        </table>


                    </div>
                    <br />

                    <label class="btn btn-info pull-left" data-toggle="modal" data-target="#AttachPaymentDocument"><i class="fa fa-plus fa-fw"></i>Attach Payment Document</label>
                    <%--<label class="btn btn-success pull-right" data-toggle="modal" data-target="#AttachPaymentDocument"><i class="fa fa-plus fa-fw"></i>Attach Payment Document</label>--%>
                    <br />
                    <br />
                    <br />
                    <div class="panel-heading">Uploaded Documents</div>
                    <div class="panel-body">
                        <table class="table table-bordered table-striped">
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
                                        //string doc = "PAYMENT_DOCUMENT";
                                        // + "_" + doc
                                        String documentDirectory = filesFolder + imprestNo + "/";
                                        if (Directory.Exists(documentDirectory))
                                        {
                                            foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                            {
                                                String url = documentDirectory;
                                %>
                                <tr>
                                    <td><% =file.Replace(documentDirectory, "") %></td>

                                    <td><a href="DownLoadQaPaymentDoc.aspx?applicationNo=<%=imprestNo %>&&fileName=<%=file.Replace(documentDirectory, "") %>" class="btn btn-success">Download</a></td>
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
                <br />
                <asp:Button runat="server" Style="margin-left: 2%" CssClass="btn btn-warning" Text="Back To Home Page" ID="previouspage" OnClick="previouspage_Click" />
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Submit SAR To CUE" ID="SubmitSAR" OnClick="SubmitSAR_Click" />
                <br />
                <br />
            </div>

        </div>
    </div>

    <div id="AttachPaymentDocument" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Attach Payment Document in pdf format</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <strong>Select file to upload:</strong>
                        <asp:FileUpload runat="server" ID="document" CssClass="form-control" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Attach Document" ID="attachdocument" OnClick="attachdocument_Click" />
                </div>
            </div>
        </div>
    </div>
    <div id="deleteFileModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting File</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the file <strong id="filetoDeleteName"></strong>?</p>
                    <asp:TextBox runat="server" ID="txtfileName" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" OnClick="deleteFile_Click" />
                </div>
            </div>

        </div>
    </div>

    <script>

        function deleteFile(fileName) {
            document.getElementById("filetoDeleteName").innerText = fileName;
            document.getElementById("MainContent_txtfileName").value = fileName;
            $("#deleteFileModal").modal();
        }
    </script>
    <script>
        $(document).ready(function () {
            $('#dataTables-example').DataTable({
                responsive: true,
                "pageLength": 50
            });
        });
    </script>
</asp:Content>
