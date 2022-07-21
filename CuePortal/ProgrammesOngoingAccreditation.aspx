<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AccreditationMaster.Master"  CodeBehind="ProgrammesOngoingAccreditation.aspx.cs" Inherits="CicPortal.ProgrammesOngoingAccreditation" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="panel panel-primary">
     <div class="panel panel-default">
           <div class="panel-heading">
          Status of Submitted Applications
        </div>
        </div>
        <div class="panel-body">
            <table class="table table-bordered table-striped" id="dataTables-example">
                 <thead>
                          <tr>
                              <th>#</th>
                             <th>Accreditation No:</th>
                             <th>Programme Name</th>
                             <th>Campus Name</th>
                             <th>Application Date</th>
                             <th>Status</th>
                             <th>View Progress</th>
                         </tr>
                         </thead>
                        <tbody>
                         <%
                             var nav = Config.ReturnNav();
                             var programs5 = nav.ProgramAccreditation.Where(r => r.Institution_No == Convert.ToString(Session["UniversityCode"])&& r.Status!="Open" &&r.Current_Version==true);

                             int proramcounter = 0;

                             foreach (var program5 in programs5)
                             {
                                 proramcounter++;
                             %>
                             <tr>
                                 <td><%=proramcounter%></td>
                                 <td><%=program5.Accreditation_No %></td>
                                 <td><%=program5.Program_Name %></td>
                                 <td><%=program5.Campus_Name %></td>
                                 <td><%=program5.Date_Created %></td>
                                 <td><%=program5.Status %></td>
                                 <td><a href="OngoingPrograms.aspx?accreditation=<%=program5.Accreditation_No %>&&step=1" class="btn btn-success"><i class="fa fa-eye"></i> View Status</a></td>

                             </tr>
                             <%
                                 }
                         %>
                </tbody>
            </table>   
        </div>
    </div>
     <script>
         $(document).ready(function() {
            $('#dataTables-example').DataTable({
                 responsive: true
             });
         });
     </script>
</asp:Content>

