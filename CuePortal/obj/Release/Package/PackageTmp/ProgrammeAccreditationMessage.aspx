<%@ Page Title="" Language="C#" MasterPageFile="~/AccreditationMaster.Master" AutoEventWireup="true" CodeBehind="ProgrammeAccreditationMessage.aspx.cs" Inherits="CicPortal.ProgrammeAccreditationMessage" %>

<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row" style="width: 100%; margin: 5px;">
        <div class="panel panel-default">
            <div class="panel-heading">Compose New Message(CUE Programme Accreditation Help Desk)</div>
            <div class="panel-body">
                <div runat="server" id="messagefeedback"></div>
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <center><h3 class="box-title">Compose New Message</h3></center>
                    </div>
                    <div class="box-body">
                        <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                              <h5>Message From:<strong><% =Session["Name"] %></strong></h5> 
                                <input class="form-control" value="<%=Session["EmailAddress"] %>" id="useremailaddress" name="useremailaddress" placeholder="Message From:">
                            </div>
                        </div>
                        </div>
                         <% 
                             var nav = Config.ReturnNav();
                             string DataCollectionEmail = "";
                             var datacollections= nav.DataCollectionSetup;
                             foreach (var datacollection in datacollections)
                             {
                                 DataCollectionEmail = datacollection.ICT_Email_Address;
                        %>
                           <% } %>
                        <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                               <h5>Message To:<strong>CUE Help Desk</strong></h5>
                                  <input class="form-control" value="<% =DataCollectionEmail %>" id="cueemailaddress" name="cueemailaddress" placeholder="To:" readonly>
                            </div>
                        </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 col-lg-6">
                             <div class="form-group">
                               <label>Message Subject</label>
                                <asp:TextBox ID="messageSubject" runat="server" CssClass="form-control" required/>
                             </div>  
                          </div>
                        </div>

                       <div class="row">
                        <div class="col-md-6 col-lg-6">
                             <div class="form-group">
                               <label>Message Body</label>
                                <asp:TextBox ID="messageDescription" runat="server" CssClass="form-control" TextMode="MultiLine" style="height:200px" required/>
                             </div>  
                         </div>
                        </div>
                    </div>
                    <div class="box-footer">
                        <asp:Button runat="server" ID="sendMessage" CssClass="btn btn-success pull-right" Text="Send Message" OnClick="sendMessage_Click"/>
                        <asp:Button runat="server" ID="homepage" CssClass="btn btn-warning pull-left" Text="Back To Homepage" OnClick="homepage_Click"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
