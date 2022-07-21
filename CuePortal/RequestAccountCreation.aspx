<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RequestAccountCreation.aspx.cs" Inherits="CicPortal.RequestAccountCreation" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Account Creation - CUE</title>
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
                         <img src="images/cue-header.png" style="margin-left:500px" />
                         <h3 style="width: 100%; text-align: center;">The Water Services Regulatory Board (Wasreb)</h3>
                        <hr />
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">Please Fill in all the Details to Request for Account Creation</div>
                        <div class="panel-body">
                            <div class="panel">
                                <div style="padding: 20px;">
                                    <div id="feedback" runat="server"></div>
                                    <div id="acccountfeedback" style="display: none" data-dismiss="alert"></div>
                                    <div class="row" style="display:none">
                                        <div class="col-md-6 col-lg-6" >
                                            <div class="form-group">
                                                <label>Institution Type</label>
                                                  <asp:DropDownList CssClass="form-control" runat="server" ID="insttype"  Style="height: 42px;" />
                                            </div>
                                        </div>
                                        <div id="proposedname" class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group" style="display: none">
                                            <div class="form-group">
                                                <label>Proposed Institution Name.</label>
                                                <asp:TextBox CssClass="form-control" runat="server" ID="txtproposedname" Placeholder="Proposed Institution Name." type="text"  Style="height: 42px;" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 col-lg-6">
                                            <div class="form-group">
                                                <label>ID No./Passport No.</label>
                                                <asp:TextBox CssClass="form-control" runat="server" ID="idnumber" Placeholder="ID No./Passport No." type="text"  Style="height: 42px;" />
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-6">
                                            <div class="form-group">
                                                <label>First Name</label>
                                                <asp:TextBox CssClass="form-control" runat="server" ID="firstname" Placeholder="Enter First Name" type="text"  Style="height: 42px;" />

                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 col-lg-6">
                                            <div class="form-group">
                                                <label>Middle Name</label>
                                                <asp:TextBox CssClass="form-control" runat="server" ID="middlname" Placeholder="Enter Middle Name"  Style="height: 42px;" />
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-6">
                                            <div class="form-group">
                                                <label>Last Name</label>
                                                <asp:TextBox CssClass="form-control" runat="server" ID="lastname" Placeholder="Enter Last Name" type="text" required Style="height: 42px;" />

                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 col-lg-6">
                                            <div class="form-group">
                                                <label>Phone No.</label>
                                                <asp:TextBox CssClass="form-control" runat="server" ID="phonenumber" Placeholder="Enter Phone No." type="number" required Style="height: 42px;" />
                                            </div>
                                        </div>
                                        <div id="selectUniversityName" class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group" >
                                            <div class="form-group">
                                                <label>University Name.</label>
                                                <asp:DropDownList CssClass="form-control" runat="server" ID="universityname" Placeholder="Enter University Name" required Style="height: 42px;" />
                                            </div>
                                        </div>

                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 col-lg-6">
                                            <div class="form-group">
                                                <label>Address:</label>
                                                <asp:TextBox CssClass="form-control" runat="server" ID="address" Placeholder="Enter Address" required Style="height: 42px;" />
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-6">
                                            <div class="form-group">
                                                <label>Post Code:</label>
                                                <asp:DropDownList CssClass="form-control" runat="server" ID="postcode" Placeholder="Select Post Code" type="password" required OnSelectedIndexChanged="postCode_SelectedIndexChanged" AutoPostBack="True" Style="height: 42px;" />

                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 col-lg-6">
                                            <div class="form-group">
                                                <label>City:</label>
                                                <asp:TextBox CssClass="form-control" runat="server" ID="city" Placeholder="City Name" required Style="height: 42px;" />
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-6">
                                            <div class="form-group">
                                                <label>Country/region Code:</label>
                                                <asp:DropDownList CssClass="form-control" runat="server" ID="country" Placeholder="Country/Region" type="text" required Style="height: 42px;" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 col-lg-6">
                                            <div class="form-group">
                                                <label>User Role.</label>
                                                <asp:DropDownList CssClass="form-control" runat="server" ID="userrole" Placeholder="User Roles" required Style="height: 42px;" />
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-6">
                                            <div class="form-group">
                                                <label>Email Address(Official Email Address):</label>
                                                <asp:TextBox CssClass="form-control" runat="server" ID="emailaddress" Placeholder="Enter Official Email Address" type="text" required Style="height: 42px;" />

                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div id="evidences" class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group" style="display: none">
                                            <div class="form-group">
                                                <strong>Upload Approval Evidence</strong>
                                                <asp:FileUpload runat="server" ID="equipment" CssClass="form-control" Style="padding-top: 0px;" />
                                            </div>
                                            <a href="Login.aspx" class="pull-right">Back to Login</a>
                                        </div>
                                    </div>
                               </div>
                             </div>
                        </div>
                        <div style="background-color: #ececec; padding: 10px;">
                            <asp:Button runat="server" CssClass="btn btn-success btn-block btn_accountcreation" ID="btn_accountcreation" name="btn_accountcreation" Text="Submit Registration" Style="border-radius: 2px; font-size: 17px; line-height: 1.471; padding: 10px 19px;" />
                        </div>
                    </div>
                    <div class="col-md-12 col-sm-12 col-xs-12" style="text-align: center;">
                        <hr />
                        Copyright  &copy; <%: DateTime.Now.Year %>  Terms and Conditions Apply |  <a href="https://wasreb.go.ke//">The Water Services Regulatory Board</a>
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

