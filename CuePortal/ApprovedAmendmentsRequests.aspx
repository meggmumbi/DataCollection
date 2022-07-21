<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApprovedAmendmentsRequests.aspx.cs" MasterPageFile="~/DataCollectionMaster.Master" Inherits="CicPortal.ApprovedAmendmentsRequests" %>

<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  
        <div class="row">
            <div class="col-md-12 col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">Approved University Data Amendments Requests</div>

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
                            </tbody>
                        </table>


                    </div>
                </div>
            </div>

        </div>
        <div class="row">
            <div class="col-md-12 col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">Approved University Data Amendments Data Sets</div>

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
                                    var AmendmentNumber = new Config().ObjNav().GetAmendmentsNumber(Convert.ToString(Session["UniversityCode"]));
                                    var datatsets = nav1.IDCDatasets.Where(r => r.IDC_No == AmendmentNumber);
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
                              <%} %>
                            </tbody>
                        </table>


                    </div>
                </div>
            </div>

        </div>
</asp:Content>

