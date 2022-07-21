<%@ Page Title="" Language="C#" MasterPageFile="~/AccreditationMaster.Master" AutoEventWireup="true" CodeBehind="SiteInspectionReports.aspx.cs" Inherits="CicPortal.SiteInspectionReports" %>
<%@ Import Namespace="CicPortal" %>
<%@ Import Namespace="System.IO" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <div class="row">
            <div class="col-md-12 col-lg-12">
                  <div class="panel panel-default">
            <div class="panel-heading">Technical Reports</div>
                <div class="panel-body">
                    <div id ="feedback" runat="server"></div>
                       <table class="table table-bordered table-striped">
                           <thead>
                           <tr>
                               <th>Document Title</th>
                               <th>Download</th>
                           </tr>
                           </thead>
                           <tbody>
                           <%
                               try
                               {
                                    String fileFolderApplication = ConfigurationManager.AppSettings["FilesLocation"];
                                    String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Overall Evaluation Card/";
                                    string imprestNo = Request.QueryString["docNo"];
                                    imprestNo = imprestNo.Replace('/', '_');
                                    imprestNo = imprestNo.Replace(':', '_');
                                    String documentDirectory = filesFolder + imprestNo+"/";
                                    if (Directory.Exists(documentDirectory))
                                    {
                                        foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                        {
                                            String url = documentDirectory;
                                        %>
                               <tr>
                                   <td><% =file.Replace(documentDirectory, "") %></td>
                                   <td><a href="DownLoadFile.aspx?applicationNo=<%=imprestNo %>&&fileName=<%=file.Replace(documentDirectory, "") %>" class="btn btn-success">Download</a></td>
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
                     <asp:Button runat="server" style="margin-left:2%" CssClass="btn btn-warning" Text="Previous" ID="previous" OnClick="previous_Click"/>
                <br />
                <br />
            </div>
           </div>
         </div>
</asp:Content>

