<%@ Page Title="" Language="C#" MasterPageFile="~/DataCollectionMaster.Master" AutoEventWireup="true" CodeBehind="DataCollectionHelpDeskResolved.aspx.cs" Inherits="CicPortal.DataCollectionHelpDeskResolved" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Home.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">Submitted Help Desk Requests</li>
            </ol>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
            Resolved Help Desk Requests
        </div>
        <div class="panel-body">
            <div runat="server" id="generalFeedback"></div>
            <table id="example1" class="table table-striped table-bordered">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Issue Category</th>
                        <th>Issue Description</th>
                        <th>Date Submitted</th>
                        <th>Time Submitted</th>
                        <th>Resolution</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int counter = 0;
                        string unicode = Convert.ToString(Session["UniversityCode"]);
                        string userEmail = Convert.ToString(Session["EmailAddress"]);
                        string allData = new Config().ObjNav().FnGetResolvedHelpdeskRequests(unicode,userEmail);
                        String[] info = allData.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                        if (info != null)
                        {
                            foreach (var allInfo in info)
                            {
                                counter++;
                                String[] arr = allInfo.Split('*');
                                %>
                                <tr>
                                    <td><% =counter%></td>
                                    <td><% =arr[3] %></td>
                                    <td><% =arr[4]  %></td>
                                    <td><% =arr[1]  %></td>
                                    <td><% =arr[2]  %></td>
                                    <td><% =arr[5]  %></td>
                                    <td><% ="Resolved"  %></td>
                                </tr>
                                <% 
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

</asp:Content>
