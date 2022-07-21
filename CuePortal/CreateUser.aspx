<%@ Page Title="" Language="C#" MasterPageFile="~/ChooseServiceMaster.Master" AutoEventWireup="true" CodeBehind="CreateUser.aspx.cs" Inherits="CicPortal.CreateUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="ChooseService.aspx">Home</a></li>
                <li class="breadcrumb-item active">Create User</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
            Please fill in all the details to create a user
                <div class="clearfix"></div>
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <label class="span2">User Type<span style="color: red">*</span></label>
                    <asp:DropDownList runat="server" ID="usertype" AppendDataBoundItems="true" CssClass="form-control select2">
                        <asp:ListItem>--Select--</asp:ListItem>
                        <asp:ListItem Value="VC">Vice Chancellor (VC)</asp:ListItem>
                        <asp:ListItem Value="DVC">Deputy Vice Chancellor (DVC)</asp:ListItem>
                        <asp:ListItem Value="Data Officer">Data Officer</asp:ListItem>
                        <asp:ListItem Value="Programme Accreditation Officer">Programme Accreditation Officer</asp:ListItem>
                        <asp:ListItem Value="Institutional Accreditation Officer">Institutional Accreditation Officer</asp:ListItem>
                        <asp:ListItem Value="Quality Audit Officer">Quality Audit Officer</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="usertype" InitialValue="--Select--" ErrorMessage="Please select user type, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group" runat="server">
                    <label class="span2">Full Name<span style="color: red">*</span></label>
                    <asp:TextBox runat="server" ID="fname" CssClass="form-control span3" placeholder="Please Enter Full Name" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="fname" ErrorMessage="Please Enter Full Name, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group" runat="server">
                    <label class="span2">Official Email Address<span style="color: red">*</span></label>
                    <asp:TextBox runat="server" ID="email" CssClass="form-control span3" placeholder="Please Enter Email Address (test@gmail.com)" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="email" ErrorMessage="Please Enter Email Address, it cannot be empty!" ForeColor="Red" />
                    <asp:RegularExpressionValidator ID="emailexpressvalidator" runat="server" ControlToValidate="email" ErrorMessage="Please enter valid email address e.g (test@gmail.com)" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"> </asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group" runat="server">
                    <label class="span2">Phone Number<span style="color: red">*</span></label>
                    <asp:TextBox runat="server" ID="phone" CssClass="form-control span3" placeholder="Please Enter Phone Number (07xxxxxxxx)" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="phone" ErrorMessage="Please Enter Phone Number, it cannot be empty!" ForeColor="Red" />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="phone" ErrorMessage="Please Enter Valid Phone Number, it should be 10 digits e.g (07xxxxxxxx)" ValidationExpression="[0-9]{10}" ForeColor="Red"></asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="col-md-12 col-lg-12">
                <asp:Button runat="server" ID="save" CssClass="btn btn-info pull-right" Text="Create User" OnClick="save_Click" />
            </div>
        </div>
    </div>
</asp:Content>
