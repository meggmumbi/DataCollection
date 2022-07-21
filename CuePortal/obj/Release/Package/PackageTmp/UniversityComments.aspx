<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AccreditationMaster.Master" CodeBehind="UniversityComments.aspx.cs" Inherits="CicPortal.UniversityComments" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="panel panel-primary">
<div class="container">
  <div class="row">
    <div class="col-sm-10 col-sm-offset-1" id="logout">
        <div class="page-header">
           <center> <h3 class="reviews">Leave your comment</h3></center>
        </div>
        <div class="comment-tabs">
            <div class="tab-content">
                <div class="tab-pane active" id="comments-logout"> 
                       <div class="tab-pane" id="add-comment">
                    <form action="#" method="post" class="form-horizontal" id="commentForm" role="form"> 
                      <label>Please leave your feedback based on the Accreditation Process.</label>
                        <div class="form-group">
                            <div class="col-sm-10>
                                <div id="feedback" runat="server"></div>
                                <asp:TextBox id="txtaddComment" class="form-control" TextMode="multiline" Columns="50" Rows="5" runat="server" />
                            
                            </div>
                        </div><br /><br />
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10"> 
                                <asp:Button runat="server" ID="comments"  CssClass="btn btn-success glyphicon glyphicon-send" Text=" Summit Comment" OnClick="SubmitComments_Click" />
                            </div>
                        </div>            
                    </form>
                </div><br /><br /><br /><br /><br /><br />
                     <table  class="table table-striped table-bordered table-hover" id="dataTables-example">
                            <thead>
                            <tr>
                                <th> Comment ID</th>
                                <th>Description</th>
                                <th>Comment Date</th>
                                <th>Comment Time</th>
                            </tr>
                            </thead>
                            <tbody>
                        <%
                           var nav = Config.ReturnNav();
                            var comments = nav.UniversitiesComments;
                            foreach (var comment in comments)
                            {
                          %>
                         <tr>
                        <td><%=comment.Comment_No %></td>
                        <td><%=comment.Comment_Description %></td>
                        <td><%=comment.Date %></td>
                         <td><%=comment.Time %></td>
                          </tr>
                            <%
                             }
                           %>
                        </tbody>
                    </table>
                </div>
                <div class="collapse" id="replyTwo">
                        </div>
                </div>
               
            </div>
        </div>
	</div>
	</div>
     <script>
         $(document).ready(function() {
             $('#dataTables-example').DataTable({
                 responsive: true
             });
         });
     </script>
  </div>
</asp:Content>