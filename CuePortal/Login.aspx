<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CicPortal.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login - CUE</title>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />

    <link href="images/logo.png" rel="shortcut icon" type="image/x-icon" />

    <!-- Bootstrap Core CSS -->
    <link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" />

    <!-- MetisMenu CSS -->
    <link href="../vendor/metisMenu/metisMenu.min.css" rel="stylesheet" />

    <!-- Custom CSS -->
    <link href="../dist/css/sb-admin-2.css" rel="stylesheet" />

    <!-- Morris Charts CSS -->
    <link href="../vendor/morrisjs/morris.css" rel="stylesheet" />


    <!-- Custom Fonts -->
    <link href="../vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />

</head>
<body>
    <form id="form1" runat="server">
        <div class="row" style="width: 100%; display: block; margin: auto;">
            <div class="panel col-md-10 col-lg-10 col-sm-10 col-xs-12 col-md-offset-1 col-lg-offset-1 col-sm-offset-1" style="margin-top: 20px; border: 1px solid #d0dada; border-radius: 4px; padding-top: 5px; padding-bottom: 10px;">
                <div class="row ">
                    <div>
                        <img src="images/cue-header.png" style="margin-left:500px" />
                        <h3 style="width: 100%; text-align: center;">The Water Services Regulatory Board (Wasreb)</h3>
                        <hr />
                    </div>

                    <div class="col-md-6 col-sm-8 col-xs-12 col-md-offset-3 col-sm-offset-2" style="border: 1px solid #d0dada; border-radius: 1px; border-bottom-width: 0px; border-top-width: 0px;">
                   
                        <div class="panel">
                            <div style="padding: 20px;">
                                <div id="feedback" runat="server"></div>
                                <div class="form-group">
                                    <label>Email Address:</label>

                                    <asp:TextBox CssClass="form-control" runat="server" ID="username" Placeholder="Email Address" required Style="height: 42px;" />

                                </div>

                                <div class="form-group">
                                    <label>Account Password:</label>

                                    <asp:TextBox CssClass="form-control " runat="server" ID="password" Placeholder="Account Password" type="password" required Style="height: 42px;" />

                                </div>
                                <hr />
                                <p><strong>Forgot Your Password?</strong> <a style="color:royalblue; font-style:italic" href="ForgotPass.aspx">Click Here To Reset</a></p><hr />
                                <p><strong>Dont Have an Account?</strong> <a style="color:royalblue; font-style:italic" href="RequestAccountCreation.aspx">Click Here To Request Account Creation</a></p><hr />
                                <p><strong>Have an Help Desk Issue?</strong> <a style="color:royalblue; font-style:italic" href="HelpDesk.aspx">Click Here To Create Help Desk Request</a></p><hr />
                            </div>

                            <div style="background-color: #ececec; padding: 10px;">
                                <asp:Button runat="server" CssClass="btn btn-success btn-block btn-ladda" data-style="contract-overlay" ID="login" Text="Login" Style="border-radius: 2px; font-size: 17px; line-height: 1.471; padding: 10px 19px;z-index: 10;" OnClick="login_Click" OnClientClick="$('.loading').show();" />
                            </div>
                        </div>
                       </div>
                    </div>                    <div class="col-md-12 col-sm-12 col-xs-12" style="text-align: center;">
                        <hr />
                        Copyright  &copy; <%: DateTime.Now.Year %>  Terms and Conditions Apply | <a href="https://wasreb.go.ke//">The Water Services Regulatory Board</a>
                    </div>
                
              </div>
            <div>
            </div>
        </div>
    </form>
<%--    <script type="text/javascript">
        if (document.layers) {
            //Capture the MouseDown event.
            document.captureEvents(Event.MOUSEDOWN);

            //Disable the OnMouseDown event handler.
            document.onmousedown = function () {
                return false;
            };
        }
        else {
            //Disable the OnMouseUp event handler.
            document.onmouseup = function (e) {
                if (e != null && e.type == "mouseup") {
                    //Check the Mouse Button which is clicked.
                    if (e.which == 2 || e.which == 3) {
                        //If the Button is middle or right then disable.
                        return false;
                    }
                }
            };
        }

        //Disable the Context Menu event.
        document.oncontextmenu = function () {
            return false;
        };
    </script>--%>
<%--    <script language="JavaScript"> var message = 'Right Click is disabled.This is not allowed!!!';
        function clickIE() { if (event.button == 2) { alert(message); return false; } }
        function clickNS(e) {
            if (document.layers || (document.getElementById && !document.all)) {
                if (e.which == 2 || e.which == 3) { alert(message); return false; }
            }
        }
        if (document.layers) { document.captureEvents(Event.MOUSEDOWN); document.onmousedown = clickNS; }
        else if (document.all && !document.getElementById) { document.onmousedown = clickIE; }
        document.oncontextmenu = new Function('alert(message);return false')

    </script>--%>
</body>

</html>
