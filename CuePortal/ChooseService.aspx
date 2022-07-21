<%@ Page Title="" Language="C#" MasterPageFile="~/ChooseServiceMaster.Master" AutoEventWireup="true" CodeBehind="ChooseService.aspx.cs" Inherits="CicPortal.ChooseService" %>

<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row" style="background-color: #f5f5f5;">

        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 style="color: #ffffff;">Water Services Regulatory Board (Wasreb)</h3>
                </div>
            </div>
            <div id="feedback" style="display:none"></div>
            <h4>Click on your desired section to access services within the module.</h4>
            &nbsp;     &nbsp;     &nbsp;     &nbsp;   
        </div>
        <hr />

        <div class="col-lg-3 col-md-6 card " style="float: left">
            <div class="panel panel-green">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-xs-3">
                            <i class="fa fa-database fa-5x"></i>
                        </div>
                        <div class="col-xs-9 text-right">
                            <div class="huge">
                            </div>
                            <div>Data Submission</div>
                        </div>
                    </div>
                </div>
                <a href="DataCollection.aspx">
               <%-- <a href="#" id="validateDataUser">--%>
                    <div class="panel-footer">
                        <span class="pull-right" style="color: red">Proceed</span>
                        <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                        <div class="clearfix">
                        </div>
                        <div class="panel-footer">
                            Total untreated surface water available, Total groundwater available, Water production,Total water produced
                        </div>
                    </div>
                </a>
            </div>
        </div>
        <%--<div class="col-lg-3 col-md-6 card" style="float: left">
            <div class="panel panel-green">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-xs-3">
                            <i class="fa fa-certificate fa-5x"></i>
                        </div>
                        <div class="col-xs-9 text-right">
                            <div class="huge">
                            </div>
                            <div>Accreditation</div>
                        </div>
                    </div>
                </div>
                <a href="Accreditation.aspx">
               <%-- <a href="#" id="validateAccUser">
                    <div class="panel-footer">
                        <span class="pull-right" style="color: red">Proceed</span>
                        <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                        <div class="clearfix">
                        </div>
                        <div class="panel-footer">
                            Includes services such as Institutional Accreditation, Programme Accreditation
                              &nbsp; &nbsp;&nbsp;     &nbsp;     &nbsp;     &nbsp;     &nbsp;     &nbsp;     &nbsp;     &nbsp;
                        </div>
                    </div>
                </a>
            </div>
        </div>--%>
  <%--      <div class="col-lg-3 col-md-6 card">
            <div class="panel panel-green ">
                <div class="panel-heading ">
                    <div class="row">
                        <div class="col-xs-3">
                            <i class="fa fa-institution fa-5x"></i>
                        </div>
                        <div class="col-xs-9 text-right">
                            <div class="huge">
                            </div>
                            <div>Quality Audit</div>
                        </div>
                    </div>
                </div>
                <a href="QualityAudit.aspx">
                <%--<a href="#" id="validateQAUser">
                    <div class="panel-footer">
                        <span class="pull-right" style="color: red">Proceed</span>
                        <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                        <div class="clearfix">
                        </div>
                        <div class="panel-footer">
                            Includes services such as Institutional Quality Audit, Programme Quality Audit
                                   &nbsp; &nbsp;&nbsp;     &nbsp;     &nbsp;     &nbsp;     &nbsp;     &nbsp;     &nbsp;     &nbsp;
                        </div>
                    </div>
                </a>
            </div>
        </div>--%>
       </div>
      

    <script type="text/javascript">

        //validate Data Users
        $("#validateDataUser").on('click', function () {
            
            var user = '<%=Session["UserType"] %>';
            if (user == "Data Officer" || user == "VC")
            {
                window.location.href = "DataCollection.aspx";
            }
            else
            {
                Swal.fire
                 ({
                     title: "ALERT!",
                     text: "Insufficient Rights To Access This Module",
                     type: "error"
                 }).then(() => {
                     $("#feedback").css("display", "block");
                     $("#feedback").css("color", "red");
                     $('#feedback').addClass('alert alert-danger');
                     $("#feedback").html("You do not have enough access rights to this module, your role is "+user+".");
                 });
            }
        });

        //validate Acc Users
        $("#validateAccUser").on('click', function () {
            
            var user = '<%=Session["UserType"] %>';
            if (user == "Data Officer" || user == "Programme Accreditation Officer" || user == "Institutional Accreditation Officer" || user == "VC") {
                window.location.href = "Accreditation.aspx";
            }
            else {
                Swal.fire
                 ({
                     title: "ALERT!",
                     text: "Insufficient Rights To Access This Module",
                     type: "error"
                 }).then(() => {
                     $("#feedback").css("display", "block");
                     $("#feedback").css("color", "red");
                     $('#feedback').addClass('alert alert-danger');
                     $("#feedback").html("You do not have enough access rights to this module, your role is " + user + ".");
                 });
            }
        });

        //validate QA Users
        $("#validateQAUser").on('click', function () {
            
            var user = '<%=Session["UserType"] %>';
            if (user == "Data Officer" || user == "Quality Audit Officer" || user == "VC") {
                window.location.href = "QualityAudit.aspx";
            }
            else {
                Swal.fire
                 ({
                     title: "ALERT!",
                     text: "Insufficient Rights To Access This Module",
                     type: "error"
                 }).then(() => {
                     $("#feedback").css("display", "block");
                     $("#feedback").css("color", "red");
                     $('#feedback').addClass('alert alert-danger');
                     $("#feedback").html("You do not have enough access rights to this module, your role is " + user + ".");
                 });
            }
        });
    </script>
</asp:Content>

