<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AccreditationMaster.Master" CodeBehind="OngoingInstAccreditations.aspx.cs" Inherits="CicPortal.OngoingInstAccreditations" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<section style="background:#efefe9;">
               <div class="row">
                  <div class="panel panel-default">
                  <div class="panel-heading"><strong>University Institution Accreditation Progress</strong> </div>
                  <div class="board">
                    <div class="board-inner">
                    <ul class="nav nav-tabs" id="myTab">
                     <div class="liner"></div>
                     <li class="active">
                     <a href="#home" data-toggle="tab" title="Step 1">

                      <span class="round-tabs one">
                             <i class="fa fa-home"></i>
                             <strong>Stage1:</strong>
                      </span> 
                  </a></li>

                  <li><a href="#profile" data-toggle="tab" title="Step 2">
                     <span class="round-tabs two">
                         <i class="fa fa-chevron-right"></i>
                         <strong>Stage2:</strong>
                     </span> 
           </a>
                 </li>
                 <li><a href="#messages" data-toggle="tab" title="Step 3">
                     <span class="round-tabs three">
                          <i class="fa fa-chevron-right"></i>
                         <strong>Stage3:</strong>
                     </span> </a>
                     </li>

                     <li><a href="#settings" data-toggle="tab" title="Step 4">
                         <span class="round-tabs four">
                              <i class="fa fa-chevron-right"></i>
                             <strong>Stage4:</strong>
                         </span> 
                     </a></li>

                     <li><a href="#doner" data-toggle="tab" title="completed">
                         <span class="round-tabs five">
                              <i class="fa fa-chevron-right"></i>
                             <strong>Stage5:</strong>
                         </span> </a>
                     </li>
                     
                     </ul>
                     
                     </div>
                     <div class="tab-content">
                      <div class="tab-pane fade in active" id="home">
             <div>
             <div class="container">
                      <h2>Accreditation Progress</h2>
                      <p>Current Institution Accreditation Awaiting Completeness Check</p> 
                      <div class="progress">
                        <div class="progress-bar progress-bar-striped active"  role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width:20%">
                          20%
                        </div>
                      </div>
                    </div>
          <div class="row">
            <div class="col-md-12 col-lg-12">
                  <div class="panel panel-default">
             <div class="panel-heading"><strong>Accreditations Awaiting Completeness Check</strong> </div>
                <div class="panel-body">
                     <table class="table table-bordered table-striped table-hover" id="dataTables-example">
                         <thead>
                         <tr>
                             <th>Accreditation No:</th>
                             <th>Institution Name</th>
                             <th>Campus</th>
                             <th>Application Date</th>
                             <th>Status</th>
                         </tr>
                         </thead>
                         <tbody>
                         <%
                             var nav = Config.ReturnNav();
                             var programs = nav.InstitutionAccreditation.Where(r => r.Institution_No == Convert.ToString(Session["UniversityCode"])&&r.Status=="Awaiting Completeness Checks");
                             foreach (var program in programs)
                             {
                             %>
                             <tr>
                                 <td><%=program.Accreditation_No %></td>
                                 <td><%=program.Institution_Name %></td>
                                 <td><%=program.Institution_Campus %></td>
                                 <td><%=program.Application_Date %></td>
                                 <td><%=program.Status %></td>
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
        </div>
  </div>
<div class="tab-pane fade" id="profile">
       <div>
    <div class="container">
                      <h2>Accreditation Progress</h2>
                      <p>Current Institution Accreditation Awaiting Payments</p> 
                      <div class="progress">
                        <div class="progress-bar progress-bar-striped active"  role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width:40%">
                          40%
                        </div>
                      </div>
                    </div>
        <div class="row">
            <div class="col-md-12 col-lg-12">
                  <div class="panel panel-default">
             <div class="panel-heading"><strong>Accreditations Awaiting Finance Processing</strong> </div>
                <div class="panel-body">
                    <div id ="Div1" runat="server"></div>
                     <table class="table table-bordered table-striped table-hover" id="dataTables-example1">
                          <thead>
                         <tr>
                             <th>Accreditation No:</th>
                             <th>Institution Name</th>
                             <th>Institution Campus</th>
                             <th>Application Date</th>
                             <th>Status</th>
                             <th>Confirm Payment</th>
                         </tr>
                         </thead>
                         <tbody>
                         <%
                             var nav2 = Config.ReturnNav();
                             var programs2 = nav.InstitutionAccreditation.Where(r => r.Institution_No == Convert.ToString(Session["UniversityCode"])&&r.Status=="Awaiting Payment Processing");
                             foreach (var program2 in programs2)
                             {
                             %>
                             <tr>
                                 <td><%=program2.Accreditation_No %></td>
                                 <td><%=program2.Institution_Name %></td>
                                 <td><%=program2.Institution_Campus %></td>
                                 <td><%=program2.Application_Date %></td>
                                 <td><%=program2.Status %></td>
                                 <td> <label class="btn btn-success" onclick="makePayments('<%=program2.Accreditation_No %>', '<%=program2.Institution_Name %>')"><i class="fa fa-edit"></i> Make Payment</label></td>


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
        </div>
       </div>
      <div class="tab-pane fade" id="messages">
       <div>
    <div class="container">
                      <h2>Accreditation Progress</h2>
                      <p>Current Institution Accreditation Awaiting Peer Review</p> 
                      <div class="progress">
                        <div class="progress-bar progress-bar-striped active"  role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width:60%">
                          60%
                        </div>
                      </div>
                    </div>
        <div class="row">
            <div class="col-md-12 col-lg-12">
              <div class="panel panel-default">
             <div class="panel-heading"><strong>Accreditations Awaiting Peer Review</strong> </div>
                <div class="panel-body">
                    <div id ="Div2" runat="server"></div>
                     <table class="table table-bordered table-striped table-hover" id="dataTables-example2">
                         <thead>
                         <tr>
                             <th>Accreditation No:</th>
                             <th>Institution Name</th>
                             <th>Campus</th>
                             <th>Application Date</th>
                             <th>Status</th>
                         </tr>
                         </thead>
                         <tbody>
                         <%
                             var nav3 = Config.ReturnNav();
                             var programs3 = nav3.InstitutionAccreditation.Where(r => r.Institution_No == Convert.ToString(Session["UniversityCode"])&&r.Status=="Awaiting Peer Review");
                             foreach (var program3 in programs3)
                             {
                             %>
                             <tr>
                                 <td><%=program3.Accreditation_No %></td>
                                 <td><%=program3.Institution_Name %></td>
                                 <td><%=program3.Institution_Campus %></td>
                                 <td><%=program3.Application_Date %></td>
                                 <td><%=program3.Status %></td>
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
         </div>
     </div>
   <div class="tab-pane fade" id="settings">
      <div>
    <div class="container">
                      <h2>Accreditation Progress</h2>
                      <p>Current Institution Accreditation Awaiting Board Approval</p> 
                      <div class="progress">
                        <div class="progress-bar progress-bar-striped active"  role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width:80%">
                          80%
                        </div>
                      </div>
                    </div>
        <div class="row">
            <div class="col-md-12 col-lg-12">
                  <div class="panel panel-default">
             <div class="panel-heading"><strong>Accreditations Awaiting Board Approval</strong> </div>
                <div class="panel-body">
                    <div id ="Div3" runat="server"></div>
                     <table class="table table-bordered table-striped table-hover" id="dataTables-example4">
                         <thead>
                         <tr>
                             <th>Accreditation No:</th>
                             <th>Institution Name</th>
                             <th>Campus</th>
                             <th>Application Date</th>
                             <th>Status</th>
                         </tr>
                         </thead>
                         <tbody>
                         <%
                             var nav4 = Config.ReturnNav();
                             var programs4 = nav.InstitutionAccreditation.Where(r => r.Institution_No == Convert.ToString(Session["UniversityCode"])&&r.Status=="Awaiting Board Approval");
                             foreach (var program4 in programs4)
                             {
                             %>
                             <tr>
                                 <td><%=program4.Accreditation_No %></td>
                                 <td><%=program4.Institution_Name %></td>
                                 <td><%=program4.Institution_Campus %></td>
                                 <td><%=program4.Application_Date %></td>
                                 <td><%=program4.Status %></td>
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
        </div>
  </div>
   <div class="tab-pane fade" id="doner">
       <div>
           <div class="container">
                      <h2>Accreditation Progress</h2>
                      <p>Completed Institution Accreditations</p> 
                      <div class="progress">
                        <div class="progress-bar progress-bar-striped active"  role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width:100%">
                          100%
                        </div>
                      </div>
                    </div>
        <div class="row">
            <div class="col-md-12 col-lg-12">
                  <div class="panel panel-default">
             <div class="panel-heading"><strong>Completed Institution Accreditations</strong> </div>
                <div class="panel-body">
                    <div id ="Div4" runat="server"></div>
                     <table class="table table-bordered table-striped table-hover" id="dataTables-example5">
                         <thead>
                         <tr>
                             <th>Accreditation No:</th>
                             <th>Institution Name</th>
                             <th>Campus</th>
                             <th>Application Date</th>
                             <th>Status</th>
                         </tr>
                         </thead>
                         <tbody>
                         <%
                             var nav5 = Config.ReturnNav();
                             var programs5 = nav.InstitutionAccreditation.Where(r => r.Institution_No == Convert.ToString(Session["UniversityCode"])&&r.Status=="Completed");
                             foreach (var program5 in programs5)
                             {
                             %>
                             <tr>
                                 <td><%=program5.Accreditation_No %></td>
                                 <td><%=program5.Institution_Name %></td>
                                 <td><%=program5.Institution_Campus %></td>
                                 <td><%=program5.Application_Date %></td>
                                 <td><%=program5.Status %></td>
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
        </div>
  </div>
 </div>
<div class="clearfix"></div>
</div>

</div>
</div>
</section>
 <div id="MakepaymentsModal" class="modal fade" role="dialog">
          <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Confirm Institution Accreditation Payments</h4>
              </div>
              <div class="modal-body">
                  <asp:TextBox runat="server" ID="editRationaleCode" type="hidden"/>
                  <div class="form-group">
                      <strong>Accreditation Number:</strong>                      
                      <asp:TextBox runat="server" CssClass="form-control" ID="accreditationnumber" placeholder="Institution Accreditation Number"/>

                  </div>
                  <div class="form-group">
                      <strong>Institution Name:</strong>
                      <asp:TextBox runat="server" CssClass="form-control" ID="programmeName" placeholder="Institution Name" ReadOnly="true"/>
                  </div>
                  <div class="form-group">
                  <strong>Payment Document:</strong>
                <asp:Fileupload runat="server" ID="paymentdocument" CssClass="form-control" style="padding-top: 0px;"/>
                 <asp:RequiredFieldValidator runat="server" id="payments" controltovalidate="paymentdocument" errormessage="Please attach the Payment Document!" ForeColor="Red"/>
                  <div class="form-group">
                      <strong>Payment Reference Number:</strong>
                      <asp:TextBox runat="server" CssClass="form-control" ID="paymentsref" placeholder="Payment Reference Number"/>
                  </div>
                  </div>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                  <asp:Button runat="server" CssClass="btn btn-success" Text="Confirm Payments" ID="makePayments" OnClick="ConfirmPayments_Click" />
              </div>
        </div>

      </div>
    </div>
<script>
    function makePayments(no, name) {
          document.getElementById("MainContent_accreditationnumber").value = no;
          document.getElementById("MainContent_programmeName").value = name;
          $("#MakepaymentsModal").modal();
}
</script>
  <script>
         $(document).ready(function() {
            $('#dataTables-example').DataTable({
                 responsive: true
             });
         });
     </script>
    <script>
         $(document).ready(function() {
            $('#dataTables-example1').DataTable({
                 responsive: true
             });
         });
     </script>
    <script>
         $(document).ready(function() {
            $('#dataTables-example2').DataTable({
                 responsive: true
             });
         });
     </script>
<script>
         $(document).ready(function() {
            $('#dataTables-example4').DataTable({
                 responsive: true
             });
         });
     </script>
      <script>
         $(document).ready(function() {
            $('#dataTables-example5').DataTable({
                 responsive: true
             });
         });
     </script>
    
</asp:Content>