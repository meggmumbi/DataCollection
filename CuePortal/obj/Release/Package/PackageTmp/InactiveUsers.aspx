<%@ Page Title="" Language="C#" MasterPageFile="~/ChooseServiceMaster.Master" AutoEventWireup="true" CodeBehind="InactiveUsers.aspx.cs" Inherits="CicPortal.InactiveUsers" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Home.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">De-Activated Users</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
            All De-Activated Users
        </div>
        <div class="panel-body">
            <div runat="server" id="generalFeedback"></div>
            <table id="example1" class="table table-striped table-bordered">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>User Type</th>
                        <th>Full Name</th>
                        <th>Official Email Address</th>
                        <th>Mobile Number</th>
                        <th>Status</th>
                        <th>Activate User</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav = Config.ReturnNav();
                        string custNo = Convert.ToString(Session["UniversityCode"]);
                        var data = nav.UniversityUsers.Where(x => x.UniversityCode == custNo && x.State == "Disabled").ToList();
                        int counter = 0;
                        foreach (var item in data)
                        {
                            counter++;
                    %>
                    <tr>
                        <td><%=counter %></td>
                        <td><% =item.UserType %></td>
                        <td><% =item.Full_Name %></td>
                        <td><% =item.Authentication_Email %></td>
                        <td><% =item.Mobile_Phone_No %></td>
                        <td><% ="De-Activated" %></td>
                        <td>
                            <label class="btn btn-primary" onclick="viewDetails('<%=item.Entry_No %>','<%=item.Full_Name %>');"><i class="fa fa-check"></i>Activate User</label>
                        </td>
                        <%
                            }
                        %>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <script>
        function viewDetails(docNo, name) {
            document.getElementById("txtname").innerHTML = name;
            document.getElementById("MainContent_txtdocNo").value = docNo;
            $("#viewDetailsModal").modal();
        }
    </script>

    <div id="viewDetailsModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Activate User</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="txtdocNo" type="hidden" />
                    Are you sure you want to Activate: <strong id="txtname"></strong> as a portal user on <%= Convert.ToDateTime(DateTime.Now).ToString("dd/MM/yyyy")%> at <%= Convert.ToDateTime(DateTime.Now).ToString("h:mm:ss tt")%>? 
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-info" Text="Activate User" ID="activate_user" OnClick="activate_user_Click" CausesValidation="false"/>
                    <button type="button" class="btn btn-warning pull-left" data-dismiss="modal">Cancel</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

