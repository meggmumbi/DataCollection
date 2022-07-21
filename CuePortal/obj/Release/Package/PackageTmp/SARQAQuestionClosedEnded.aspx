<%@ Page Title="" Language="C#" MasterPageFile="~/QAMaster.Master" AutoEventWireup="true" CodeBehind="SARQAQuestionClosedEnded.aspx.cs" Inherits="CicPortal.SARQAQuestionClosedEnded" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="panel panel-primary">
        <div class="panel panel-default">
            <div class="panel-heading">
                Question Details
                <div class="clearfix"></div>
            </div>
        </div>
        <div class="panel-body">
            <center><h3><strong style="color:red" id="sectionname" runat="server"></strong></h3></center>
            <br />
            <div id="generalFeedback" runat="server"></div>
            <div class="col-md-12 col-lg-12">
                <div class="form-group">
                    <strong>
                        <label class="control-label" runat="server" id="lblquestionname"></label>
                    </strong>
                    <asp:DropDownList runat="server" ID="questionname" CssClass="form-control select2" AppendDataBoundItems="true">
                        <asp:ListItem>--Select--</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="questionname" InitialValue="--Select--" ErrorMessage="Please enter your answer, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-12 col-lg-12" runat="server" id="divsubanswer" visible="false">
                <div class="form-group">
                    <strong>
                        <label class="control-label" runat="server" id="lblsubanswer"></label>
                    </strong>
                    <asp:TextBox runat="server" ID="subanswer" CssClass="form-control" placeholder="Please enter your answer here" />
                </div>
            </div>
            <div class="col-md-12 col-lg-12">
                <asp:Button runat="server" ID="backtoquestions" CssClass="btn btn-info pull-left" Text="Back To Questions" OnClick="backtoquestions_Click" CausesValidation="false" />
                <asp:Button runat="server" ID="save" CssClass="btn btn-success pull-right" Text="Save / Update" OnClick="save_Click" />
            </div>
        </div>
    </div>
</asp:Content>
