<%@ Page Title="" Language="C#" MasterPageFile="~/DataCollectionMaster.Master" AutoEventWireup="true" CodeBehind="DataCollectionHelpDesk.aspx.cs" Inherits="CicPortal.DataCollectionHelpDesk" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="DataCollection.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">Help Desk</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
            Help Desk
        </div>
        <div class="panel-body">
            <div runat="server" id="generalFeedback"></div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Sender Name<span style="color: red">*</span></strong>
                    <asp:TextBox runat="server" ID="sendername" CssClass="form-control" ReadOnly="true" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Sender Email Address<span style="color: red">*</span></strong>
                    <asp:TextBox runat="server" ID="email" CssClass="form-control" ReadOnly="true" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong> Date Requested<span style="color: red">*</span></strong>
                    <asp:TextBox runat="server" ID="daterequested" CssClass="form-control" ReadOnly="true" />
                </div>
            </div>
            <div class="col-lg-6 col-sm-6">
                <div class="form-group">
                    <strong>Time Requested<span style="color: red">*</span></strong>
                    <asp:TextBox runat="server" ID="timerequested" CssClass="form-control" ReadOnly="true" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Category of the issue<span style="color: red">*</span></strong>
                    <asp:DropDownList runat="server" ID="category" CssClass="form-control" placeholder="Please select the category" AppendDataBoundItems="true">
                        <asp:ListItem>--Select--</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator runat="server" ID="categoryValidator" ControlToValidate="category" InitialValue="--Select--" ErrorMessage="Please Select the category" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-12 col-lg-12">
                <div class="form-group">
                    <strong>Description of the issue<span style="color: red">*</span></strong>
                    <asp:TextBox runat="server" ID="description" CssClass="form-control" placeholder="Please enter the description of the issue here..." TextMode="MultiLine" Height="250px" />
                    <asp:RequiredFieldValidator runat="server" ID="validatordescription" ControlToValidate="description" ErrorMessage="Please enter the description of the issue" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-12 col-lg-12">
                <div class="form-group">
                    <strong>Attach Evidence</strong>
                    <asp:FileUpload runat="server" ID="attached_file" CssClass="form-control" />
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="reset" class="btn btn-warning pull-left"><i class="fa fa-times"></i>Discard</button>
            <asp:Button runat="server" CssClass="btn btn-primary" Text="Submit Request To CUE" ID="submit" OnClick="submit_Click"/>
        </div>
    </div>
</asp:Content>
