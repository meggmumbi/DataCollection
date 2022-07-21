<%@ Page Title="" Language="C#" MasterPageFile="~/ChooseServiceMaster.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="CicPortal.Settings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

          <div class="panel panel-primary" style="padding: 10px; margin-top: 10px;"><h3>Settings</h3>
    </div>
 <div class="panel panel-primary">
       <div class="modal-body">
            <div class="panel-heading" style="background-color: #F9BE00; color: #ffffff;"><strong>Reset Password</strong></div>
            <div class="panel-body">
               <div runat="server" id="feedback"></div>
                <div class="row">
                  <div class="col-md-6 col-lg-6">
                  <div class="form-group">
                    <label>Official Email Address:</label>
                    <asp:Textbox runat="server" CssClass="form-control" placeholder="Official Email Address" required type="text" ID="emailaddress"/>
                </div>
                </div>
                <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <label>Current Password:</label>
                    <asp:Textbox runat="server" CssClass="form-control" placeholder="Current Password" required type="password" ID="currentPassword"/>
                </div>
                </div>
                </div>
                 <div class="row">
                  <div class="col-md-6 col-lg-6">
                 <div class="form-group">
                    <label>New Password:</label>
                    <asp:Textbox runat="server" CssClass="form-control" placeholder="New Password" required type="password" ID="newPassword"/>
                </div>
               </div>
                <div class="col-md-6 col-lg-6">
                 <div class="form-group">
                    <label>Confirm Password:</label>
                    <asp:Textbox runat="server" CssClass="form-control" placeholder="Confirm Password" required type="password" ID="confirmPassword"/>
                </div>
              </div>
              </div>
            </div>
            <div class="panel-footer"><asp:Button runat="server" CssClass="btn btn-success " Text="Reset Password" OnClick="Unnamed1_Click"/>
                <div class="clearfix"></div>
            </div>
        </div>
        </div>
</asp:Content>
