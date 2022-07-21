<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OpenAmendmentsRequests.aspx.cs" MasterPageFile="~/DataCollectionMaster.Master" Inherits="CicPortal.OpenAmendmentsRequests" %>

<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  
        <div class="row">
            <div class="col-md-12 col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">Open University Data Amendments Requests</div>

                    <div class="panel-body">
                        <div id="feedback" runat="server"></div>
                        <table class="table table-bordered table-striped table-hover dataTable2">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Amendment No.</th>
                                    <th>Amendments  Description</th>
                                    <th>Submission Date</th>
                                    <th>Start Date</th>
                                    <th>End Date</th>

                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    var nav = Config.ReturnNav();
                                    var invitations = nav.DataCollectionInvitations.Where(r => r.Published == true &&r.University_No==Convert.ToString(Session["UniversityCode"])&& r.Document_Status == "Published" &&r.Submission_Type=="Ammendment");
                                    int noticecounter = 0;
                                    foreach (var invitation in invitations)
                                    {
                                        noticecounter++;
                                %>
                                <tr>
                                    <td><%=noticecounter %></td>
                                    <td><%=invitation.Notice_No %></td>
                                    <td><%=invitation.Invitation_Summary %></td>
                                    <td><%=invitation.Published_On %></td>
                                    <td><%=invitation.Collection_Period_Start_date %></td>
                                    <td><%=invitation.Collection_Period_End_Date %></td>
                                </tr>
                                <%

                                    }
                                %>
                            </tbody>
                        </table>


                    </div>
                </div>
            </div>

        </div>
        <div class="row">
            <div class="col-md-12 col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">University Data Amendments Data Sets</div>

                    <div class="panel-body">
                        <div id="Div1" runat="server"></div>
                        <table class="table table-bordered table-striped table-hover dataTable2">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Amendment No.</th>
                                    <th>DataSet ID</th>
                                    <th>Dataset Description</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    var nav1 = Config.ReturnNav();
                                    var datasetinvitations = nav.DataCollectionInvitations.Where(r => r.Published == true &&r.University_No==Convert.ToString(Session["UniversityCode"]) && r.Document_Status == "Published"&&r.Submission_Type=="Original" &&r.Approval_Status=="Released");
                                    foreach (var invitation in invitations)
                                    {
                                        // var AmendmentNumber = new Config().ObjNav().GetAmendmentsNumber(Convert.ToString(Session["UniversityCode"]));
                                        var datatsets = nav1.IDCDatasets.Where(r => r.IDC_No == invitation.Notice_No);
                                        int datacounter = 0;
                                        foreach (var datatset in datatsets)
                                        {
                                            datacounter++;
                                %>
                                <tr>
                                    <td><%=datacounter %></td>
                                    <td><%=datatset.IDC_No %></td>
                                    <td><%=datatset.Dataset_Code %></td>
                                    <td><%=datatset.Dataset_Description %></td>
                                </tr>
                              <%}
                                  } %>
                            </tbody>
                        </table>


                    </div>
                </div>
            </div>

        </div>
</asp:Content>


