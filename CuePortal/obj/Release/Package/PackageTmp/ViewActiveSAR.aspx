<%@ Page Title="" Language="C#" MasterPageFile="~/QAMaster.Master" AutoEventWireup="true" CodeBehind="ViewActiveSAR.aspx.cs" Inherits="CicPortal.ViewActiveSAR" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div>
    <div class="row">
        <div class="col-md-12 col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">Open Invitations For Quality Audit</div>
                <br />
                <asp:Button runat="server" style="margin-left:80%" CssClass="btn btn-warning fa-eye" Text="View Engagement Letter" ID="engagementletter" OnClick="engagementletter_Click" Visible="false"/>
                 <ul class="nav nav-pills" role="tablist">
                 <ul class="nav nav-tabs">
                        <li class="active" style="background-color:#D3D3D3">
                            <a href="#home" data-toggle="tab"   <h3 class="panel-title" style="color:black">General Details</h3></a>
                        </li>
                        <li style="background-color:#D3D3D3">
                            <a href="#objectives" data-toggle="tab"><h3 class="panel-title" style="color:black">Audit Objectives</h3></a>
                        </li>
                      <li style="background-color:#D3D3D3">
                            <a href="#location" data-toggle="tab"><h3 class="panel-title" style="color:black">Audit Site Locations </h3></a>
                        </li>
                      <li style="background-color:#D3D3D3">
                            <a href="#procedures" data-toggle="tab"><h3 class="panel-title" style="color:black">Audit Procedures </h3></a>
                        </li>
                      <li style="background-color:#D3D3D3">
                            <a href="#scope" data-toggle="tab"><h3 class="panel-title" style="color:black">Audit Scope </h3></a>
                        </li>
                    </ul>
               </ul>
                <br />
            <div class="tab-content">
                <div id="home" class="tab-pane active">
                    <div class="panel panel-primary">
                        <div class="panel panel-heading">
                            <h3 class="panel-title">General Details (<i>This are the general details for the quality audit</i>)</h3>
                        </div>
                <div class="panel-body">
                    <div id ="feedback" runat="server"></div>

                       <div class="row" >
  
                              <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <label class="required">Description</label>
                                        <asp:TextBox CssClass="form-control" runat="server" ID="description" ReadOnly="true"/>   
                                </div>
                             </div>
                             <div class="col-md-6 col-lg-6">
                                 <div class="form-group">
                                     <label class="required">Institution Name</label>                       
                                        <asp:TextBox CssClass="form-control" runat="server" ID="institutionname" ReadOnly="true" />      
                                    </div>
                             </div>
                         </div>
                           <div class="row" >
                             <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label class="required">Planned Start Date</label>                       
                                        <asp:TextBox CssClass="form-control" runat="server" ID="startdate" ReadOnly="true"/>                   
                                   </div>
                             </div>
                              <div class="col-md-6 col-lg-6">
                                  <div class="form-group">
                                     <label class="required">Planned End Date</label>                       
                                        <asp:TextBox CssClass="form-control" runat="server" ID="enddate" ReadOnly="true"/>
                                  </div>
                             </div>
                         </div> 
                          <div class="row" style="display:none" >
                             <div class="col-md-6 col-lg-6">
                                 <div class="form-group">
                                     <label class="required">Program Name</label>                       
                                        <asp:TextBox CssClass="form-control" runat="server" ID="programmename" ReadOnly="true" />      
                                    </div>
                             </div>
                         </div>
                  </div>
                    </div>
                  </div>
                    <div id="objectives" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Audit Objectives</h3>
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered table-striped datatable" id="example2">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Description</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                      <% var nav = Config.ReturnNav();
                                        string SARNo = Request.QueryString["SARNo"];
                                        var details = nav.AuditPlanLineObjective.Where(r => r.Audit_Plan_No == SARNo);
                                        int programesCounter = 0;
                                        foreach (var detail in details)
                                        {
                                            programesCounter++;
                                         %>
                                        <tr>
                                            <td><%=programesCounter %></td>
                                            <td><%=detail.Description %></td>                   
                                        </tr>
                                        <%  
                                       } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div id="location" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Audit Locations</h3>
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered table-striped datatable" id="example1">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Location Name</th>
                                            <th>Contact Person</th>
                                            <th>Email Address</th>
                                            <th>Phone Number</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                      <% var nav1 = Config.ReturnNav();
                                        string SARNo1 = Request.QueryString["SARNo"];
                                        var details1 = nav.AuditLocation.Where(r => r.Audit_Plan_No == SARNo1);
                                        int programesCounter1 = 0;
                                        foreach (var detail in details1)
                                        {
                                            programesCounter1++;
                                         %>
                                        <tr>
                                            <td><%=programesCounter1 %></td>
                                            <td><%=detail.Location_Name %></td>
                                            <td><%=detail.Contact_Person %></td>
                                            <td><%=detail.Email %></td>
                                            <td><%=detail.Telephone %></td>                   
                                        </tr>
                                        <%  
                                       } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div id="procedures" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Audit Procedures</h3>
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered table-striped datatable" id="example4">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Description</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                      <% var nav2 = Config.ReturnNav();
                                        string SARNo2 = Request.QueryString["SARNo"];
                                        var details2 = nav.AuditProcedures.Where(r => r.Audit_Plan_No == SARNo2);
                                        int programesCounter2 = 0;
                                        foreach (var detail in details2)
                                        {
                                            programesCounter2++;
                                         %>
                                        <tr>
                                            <td><%=programesCounter2 %></td>
                                            <td><%=detail.Description %></td>                   
                                        </tr>
                                        <%  
                                       } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    
                    <div id="scope" class="tab-pane fade">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Audit Scope</h3>
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered table-striped datatable" id="example5">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Description</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                      <% var nav3 = Config.ReturnNav();
                                        string SARNo3 = Request.QueryString["SARNo"];
                                        var details3 = nav.AuditPlanScope.Where(r => r.Audit_Plan_No == SARNo3);
                                        int programesCounter3 = 0;
                                        foreach (var detail in details3)
                                        {
                                            programesCounter3++;
                                         %>
                                        <tr>
                                            <td><%=programesCounter3 %></td>
                                            <td><%=detail.Description %></td>                   
                                        </tr>
                                        <%  
                                       } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <asp:Button runat="server" style="margin-left:2%" CssClass="btn btn-warning" Text="Go To Homepage" ID="previouspage" OnClick="previouspage_Click"/>
                <%--<asp:Button runat="server" CssClass="btn btn-warning pull-right" Text="Respond To Invitation" ID="respondtoinvitation" OnClick="respondtoinvitation_Click"/>--%>
                <br />
                <br />
                <br />
            </div>
        </div>
    </div>
</div>
</asp:Content>
