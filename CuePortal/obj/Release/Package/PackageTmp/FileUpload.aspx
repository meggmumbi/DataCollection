<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FileUpload.aspx.cs" Inherits="CicPortal.FileUpload" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Upload File using Jquery AJAX in Asp.net</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script>
        $(document).ready(function () {
            $("#FileUpload1").change(function () {
                var fileUpload = $("#FileUpload1").get(0);
                var files = fileUpload.files;

                if (files && files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $("#Image1").attr("src", e.target.result);
                    }
                    reader.readAsDataURL(files[0]);
                }
            });

            $("#btnUpload").click(function (e) {
                swal({
                    title: "Are you sure?",
                    text: "Once modified, you will not be able to recover your profile!",
                    icon: "warning",
                    buttons: true,
                    dangerMode: true,
                })
            .then((willDelete) => {
                if (willDelete) {
                    var fileUpload = $("#FileUpload1").get(0);
                    var files = fileUpload.files;
                    var data = new FormData();
                    if (files.length > 0) {
                        data.append(files[0].name, files[0]);
                    }
                    $.ajax({
                        url: "FileUploadHandler.ashx",
                        type: "POST",
                        data: data,
                        contentType: false,
                        processData: false,
                        success: function (result) {
                            alert(result);
                        },
                        error: function (err) {
                            alert(err.statusText)
                        }
                    });
                }

                e.preventDefault();
              });
            });
            
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table border="1">
                <caption>Upload File using Jquery AJAX in Asp.net</caption>
                <tr>
                    <td>Browse File:</td>
                    <td>
                        <asp:FileUpload ID="FileUpload1" runat="server" ClientIDMode="Static" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <fieldset>
                            <legend>Preview Upload</legend>
                            <asp:Image ID="Image1" runat="server" Src="#" Height="150px" Width="150px" AlternateText="No Image" ClientIDMode="Static" />
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Button ID="btnUpload" runat="server" Text="Upload File" ClientIDMode="Static" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
