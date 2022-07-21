<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Signup.aspx.cs" Inherits="CicPortal.Signup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <title>Signup - CUE</title>

 
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content=""> 
   
     <link href="images/logo.png" rel="shortcut icon" type="image/x-icon" />

    <!-- Bootstrap Core CSS -->
    <link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="../vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="../dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Morris Charts CSS -->
    <link href="../vendor/morrisjs/morris.css" rel="stylesheet">


    <!-- Custom Fonts -->
    <link href="../vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
    <form id="form1" runat="server">
    <div class="row" style="width: 100%; display: block; margin: auto;">
        
         <div class="col-md-8 col-sm-10 col-xs-12 col-md-offset-2 col-sm-offset-1">
            
            
                 <div class="panel" style="margin-top: 20px;border: 1px solid #d0dada;border-radius: 4px;">
                     <div style="padding-left: 20px; padding-right: 20px; padding-top: 10px;">
                         <img src="images/logo.png" class="pull-left"/>
                         <img src="images/coatofarms.png" class="pull-right"/>
                         <div class="clearfix"></div>
                     </div>
                     <h3 style="width: 100%; text-align: center;">University Education Management Information System (UEMIS)</h3>
                     <hr/>
                     <div style="padding: 20px; ">
                     <div id="feedback" runat="server"></div>
                         <div class="row" >
                             <div class="col-md-6 col-lg-6">
                                 <div class="form-group">
                                     <label>Proposed Name:</label>                       
                                        <asp:TextBox CssClass="form-control" runat="server" ID="proposedName" Placeholder="Proposed Name" required />
                                    </div>

                             </div>
                              <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                      <label>KRA Pin:</label> <i>(Sponsor)</i>                      
                                        <asp:TextBox CssClass="form-control" runat="server" ID="kraPin" Placeholder="KRA P.I.N." required />
                                    </div>

                             </div>
                         </div>
                    
                           <div class="row" >
                             <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label>Proposed Location:</label>                       
                                        <asp:TextBox CssClass="form-control" runat="server" ID="proposedLocation" Placeholder="Proposed Location" required />
                                    </div>

                             </div>
                              <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label>Sponsor:</label>                       
                                        <asp:DropDownList CssClass="form-control" runat="server" ID="sponsor" required />
                                    </div>

                             </div>
                         </div> 
                        
                         <h3>Communication Details:</h3>
                         <hr/>
                         <br/>
                  
                           <div class="row" >
                             <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label>County:</label>                       
                                        <asp:DropDownList CssClass="form-control" runat="server" ID="county"  required  OnSelectedIndexChanged="county_SelectedIndexChanged" AutoPostBack="True"/>
                                    </div>

                             </div>
                              <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label>Constituency:</label>                       
                                        <asp:DropDownList CssClass="form-control" runat="server" ID="constituency"  required />
                                    </div>

                             </div>
                         </div>
                           <div class="row" >
                             <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label>Post Address:</label>                       
                                        <asp:TextBox CssClass="form-control" runat="server" ID="postAddress" Placeholder="Post Address" required />
                                    </div>

                             </div>
                              <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label>Post Code:</label>                       
                                        <asp:DropDownList CssClass="form-control" runat="server" ID="postCode" required OnSelectedIndexChanged="postCode_SelectedIndexChanged" AutoPostBack="True" />
                                    
                                    </div>

                             </div>
                         </div>
                           <div class="row" >
                             <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label>City:</label>                       
                                        <asp:TextBox CssClass="form-control" runat="server" ID="city" Placeholder="City" ReadOnly="True" />
                                    </div>

                             </div>
                              <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label>Institution Website:</label>                       
                                        <asp:TextBox CssClass="form-control" runat="server" ID="institutionWebsite" Placeholder="Institution Website" required />
                                    </div>

                             </div>
                         </div>
                         <div class="row" >
                             <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label>Phone Number:</label>                       
                                        <asp:TextBox CssClass="form-control" runat="server" ID="phoneNumber" Placeholder="Phone Number" />
                                    </div>

                             </div>
                              <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label>Email Address:</label>                       
                                        <asp:TextBox CssClass="form-control" runat="server" ID="emailAddress" Placeholder="Email Address" required type="Email"/>
                                    </div>

                             </div>
                         </div>
                          <div class="row" >
                             <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label>Password:</label>                       
                                        <asp:TextBox CssClass="form-control" runat="server" ID="password" Placeholder="Password" required type="password" />
                                    </div>

                             </div>
                              <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label>Confirm Password:</label>                       
                                        <asp:TextBox CssClass="form-control" runat="server" ID="confirmPassword" Placeholder="Confirm Password" required type="password"/>
                                    </div>

                             </div>
                         </div>
                   <a href="ForgotPass.aspx">Forgot Your Password?</a>
                        </div>

                         <div style="background-color: #ececec; padding:10px;">
                             <asp:Button runat="server" CssClass="btn btn-success btn-block" ID="signup" Text="Signup"  style="border-radius: 2px;font-size: 17px;line-height: 1.471;padding: 10px 19px;" OnClick="signup_Click"/>
                     </div>
                             
                         
                     
                 </div>
                
                   
                         
                       
               
             </div>
      <div class="col-md-8 col-sm-8 col-xs-12 col-md-offset-2 col-sm-offset-2" style="text-align: center;">
          <hr/>
              &copy; <%: DateTime.Now.Year %> -Design by  <a href="http://www.dynasoft.co.ke" runat="server" target="blank">Dynasoft Business Solutions</a>
         </div>
             </div>
    </form>
  
</body>
</html>
