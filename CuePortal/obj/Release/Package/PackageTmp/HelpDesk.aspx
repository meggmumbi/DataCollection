<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HelpDesk.aspx.cs" Inherits="CicPortal.HelpDesk" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>HELP DESK - CUE</title>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <link href="images/logo.png" rel="shortcut icon" type="image/x-icon" />
    <link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../vendor/metisMenu/metisMenu.min.css" rel="stylesheet" />
    <link href="../dist/css/sb-admin-2.css" rel="stylesheet" />
    <script src="js/http_ajax.googleapis.com_ajax_libs_jquery_3.2.1_jquery.min.js"></script>
    <link href="../vendor/morrisjs/morris.css" rel="stylesheet" />
    <link href="../vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
    <style>
        .loader {
            position: fixed;
            z-index: 999;
            height: 100%;
            width: 100%;
            top: 0;
            left: 0;
            background-color: Black;
            filter: alpha(opacity=60);
            opacity: 0.6;
            -moz-opacity: 0.8;
        }

        .center {
            z-index: 1000;
            margin: 300px auto;
            padding: 10px;
            width: 130px;
            background-color: White;
            border-radius: 10px;
            filter: alpha(opacity=100);
            opacity: 1;
            -moz-opacity: 1;
        }

            .center img {
                height: 128px;
                width: 128px;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="loader" class="loader" style="display: none">
            <div class="center">
                <img alt="" src="images/loader.gif" />
            </div>
        </div>
        <div class="row" style="width: 100%; display: block; margin: auto;">
            <div class="panel col-md-10 col-lg-10 col-sm-10 col-xs-12 col-md-offset-1 col-lg-offset-1 col-sm-offset-1" style="margin-top: 20px; border: 1px solid #d0dada; border-radius: 4px; padding-top: 5px; padding-bottom: 10px;">
                <div class="row" style="width: 100%; margin: 5px;">
                    <div>
                        <img src="images/cue-header.jpg" width="100%" height="100px" />
                        <h3 style="width: 100%; text-align: center;">HELP DESK FORM</h3>
                        <hr />
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">Please Fill in all the Details to Submit the form</div>
                        <div class="panel-body">
                            <div class="panel">
                                <div style="padding: 20px;">
                                    <div id="generalFeedback" runat="server"></div>
                                    <div class="col-lg-12 col-sm-12">
                                        <div class="alert alert-info alert-dismissible" role="alert">
                                            A helpdesk is a tool that organizes University communication to help The Commission for University Education respond to university users more quickly and effectively.
                                        </div>
                                    </div>
                                    
                                    <div class="col-lg-6 col-sm-6">
                                        <div class="form-group">
                                            <strong>Date Requested<span style="color: red">*</span></strong>
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
                                            <strong>Sender Full Name<span style="color: red">*</span></strong>
                                            <asp:TextBox runat="server" ID="sendername" CssClass="form-control" placeholder="Please enter your full name" />
                                            <asp:RequiredFieldValidator runat="server" ID="sendernameValidator" ControlToValidate="sendername"  ErrorMessage="Please enter your full name" ForeColor="Red" />
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-lg-6">
                                        <div class="form-group">
                                            <strong>Sender Email Address<span style="color: red">*</span></strong>
                                            <asp:TextBox runat="server" ID="email" CssClass="form-control" placeholder="Please enter your official email address" />
                                            <asp:RequiredFieldValidator runat="server" ID="emailValidator" ControlToValidate="email"  ErrorMessage="Please enter your official email address" ForeColor="Red" />
                                            <asp:RegularExpressionValidator ID="emailexpressvalidator" runat="server" ControlToValidate="email" ErrorMessage="Please enter valid email address e.g (test@gmail.com)" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"> </asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-lg-6">
                                        <div class="form-group">
                                            <strong>University Name (<i>Start typing the name of the university name</i>)<span style="color: red">*</span></strong>
                                            <asp:DropDownList runat="server" ID="universityname" CssClass="form-control select2" placeholder="Please select the university" AppendDataBoundItems="true">
                                                <asp:ListItem>--Select--</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator runat="server" ID="universitynameValidator" ControlToValidate="universityname" InitialValue="--Select--" ErrorMessage="Please Select the university" ForeColor="Red" />
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
                            </div>
                        </div>
                        <div style="background-color: #ececec; padding: 10px;">
                            <asp:Button runat="server" CssClass="btn btn-info pull-left" Text="Exit This Page" ID="exitpage" CausesValidation="false" OnClick="exitpage_Click" />
                            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Submit Request To CUE" ID="submitdetails" OnClick="submitdetails_Click" />
                            <div class="clearfix"></div>
                        </div>
                    </div>
                    <div class="col-md-12 col-sm-12 col-xs-12" style="text-align: center;">
                        <hr />
                        Copyright  &copy; <%: DateTime.Now.Year %>  Terms and Conditions Apply | <a href="http://www.cue.or.ke/">Commission for University Education</a>
                    </div>
                </div>
                <div>
                </div>
            </div>
        </div>
    </form>
    <script>
        $('select').on('change', function () {
            var type = this.selectedIndex;
            var tproposedname = document.getElementById("proposedname");
            var tevidences = document.getElementById("evidences");
            var tselectUniversityName = document.getElementById("selectUniversityName");
            if (type == 0) {
                tproposedname.style.display = "block";
                tevidences.style.display = "block";
                tselectUniversityName.style.display = "none";
            } else {
                tproposedname.style.display = "none";
                tevidences.style.display = "none";
                tselectUniversityName.style.display = "block";
            }
        });
    </script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script type="text/javascript" src="js/CustomJs.js"></script>
    <!-- Sweet Alert Js -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
</body>

</html>


