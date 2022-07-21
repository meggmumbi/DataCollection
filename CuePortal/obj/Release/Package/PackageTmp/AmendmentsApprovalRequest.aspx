<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/DataCollectionMaster.Master" CodeBehind="AmendmentsApprovalRequest.aspx.cs" Inherits="CicPortal.AmendmentsApprovalRequest" %>


<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%
        var userType = Convert.ToString(Session["UserType"]);
        List<Int32> programLevelCount = new List<int>();
        List<String> programLevels = new List<String>();
        if (userType == "Data Officer")
        { %>
       <%
           int myStep = 1;
           int maxSteps = 2;
           try
           {
               myStep = Convert.ToInt32(Request.QueryString["step"].Trim());
               if (myStep < 1 || myStep > maxSteps)
               {
                   myStep = 1;
               }
           }
           catch (Exception)
           {
               myStep = 1;
           }
           if (myStep == 1)
           {
    %>
    <div class="panel panel-default">
        <div class="panel-heading">
          <label class="pull-right">Step <%=myStep %> of <%=maxSteps %></label>
            University Amendments Request
        </div>
        <div class="panel-body">
            <div runat="server" id="feedbackamendments"></div>
            <div id="feedback1" style="display: none"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Amendments Description</label>
                        <asp:textBox runat="server" CssClass="form-control" ID="amendmentsdetails"  placeholder="Amendments Description" TextMode="MultiLine"/>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Open Invitation No.</label>
                       <asp:DropDownList runat="server" ID="invitation" CssClass="form-control" placeholder="Invitation Number" />
                    </div>
                </div>
            </div>
            
          <div class="panel-footer">
            <div class="pull-right">
                <asp:Button runat="server" ID="amendments" CssClass="btn btn-success" Text="Next" OnClick="Submit_Click" />

            </div>
            <div class="clearfix"></div>
        </div>
    </div>
    </div>
     <%
         }
         else if (myStep == 2)
         {
    %>

      <div class="panel panel-default">
        <div class="panel-heading">University Data Amendments Data Sets
            <label class="pull-right">Step <%=myStep %> of <%=maxSteps %></label>
            <div class="clearfix"></div>
        </div>
      <div id="feedback2" style="display: none"></div>
        <div class="panel-body">
      <table class="table table-bordered table-striped datatable" >
                <thead>
                    <tr>
                        <th>Dataset Codes</th>
                        <th>Dataset Description</th>
                        <th>Require Amendments (Check if yes)</th>
                    </tr>

                </thead>
                <tbody>
                     <%
                         var nav1 = Config.ReturnNav();
                         var datasetcodes = nav1.DataSets;
                         foreach (var datasetcode in datasetcodes)
                         {
                        %>
                    <tr>
                          <td><%=datasetcode.Code %></td>
                          <td><%=datasetcode.Description %></td>
                          <td><input type="checkbox" class="checkboxes" value="<%=datasetcode.Code %>"/></td>
                    </tr>  
                      <%
                            }
                        %>                 
                </tbody>
            </table>
            <div class="panel-footer">
            <div class="pull-right">
                <input id = "btnDatasetCodes" type="button" class="btn btn-success btnDatasetCodes "  value="Submit Request" />
            </div>

            <div class="pull-left">
                <asp:Button runat="server" ID="creditorsnext2" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
            </div>
            <div class="clearfix"></div>
        </div>
        </div>
    </div>
    <script>
         $(document).ready(function() {
             var td2 = $(".datatable"),
                            p2 = td2.dataTable({
                                lengthMenu: [[5, 15, 20, -1], [5, 15, 20, "All"]],
                                pageLength: 5,
                                language: {
                                    aria: {
                                    sortAscending: ": activate to sort column ascending",
                                    sortDescending: ": activate to sort column descending"
                                    },
                                    emptyTable: "No data available in table",
                                    info: "Showing _START_ to _END_ of _TOTAL_ records",
                                    infoEmpty: "No records found",
                                    infoFiltered: "(filtered1 from _MAX_ total records)",
                                    lengthMenu: "Show _MENU_",
                                    search: "Search:",
                                    zeroRecords: "No matching records found",
                                    paginate: {
                                        previous: "Prev",
                                        next: "Next",
                                        last: "Last",
                                        first: "First"
                                    }
                                },
                                bStateSave: !0,
                                columnDefs: [
                                    { orderable: !0, defaultContent: "-", targets: "_all" },
                                    { searchable: !0, targets: "_all" }
                                ],
                                order: [[0, "asc"]],
                                bDestroy: true,
                                info: false,
                                processing: true,
                                retrieve: true
                            });

                       td2.on("change",
                            "tbody tr .checkboxes",
                            function () {
                                var t = jQuery(this).is(":checked"), selected_arr = [];
                                t ? ($(this).prop("checked", !0), $(this).parents("tr").addClass("active"))
                                    : ($(this).prop("checked", !1), $(this).parents("tr").removeClass("active"));

                                // Read all checked checkboxes
                                $("input:checkbox[class=checkboxes]:checked").each(function () {
                                    selected_arr.push($(this).val());
                                });

                                if (selected_arr.length > 0) {
                                    //$("#goodsappalert").addClass("alert alert-warning");
                                    //$("#grpshowhide").css("display", "block");
                                    
                                } else {
                                    //$("#goodsappalert").removeClass("alert alert-warning");
                                    //$("#grpshowhide").css("display", "none");
                                    selected_arr = [];
                                }

                            });
                       var selected_arr = [];
                       $(".btnDatasetCodes").on("click",
                           function (e) {
                               e.preventDefault();

                               // Read all checked checkboxes
                               $.each($(".datatable tr.active"), function () {
                                   //procurement category
                                   selected_arr.push($(this).find('td').eq(0).text());
                               });
                               //var alldatasets = {};
                                // alldatasets = selected_arr
                                 var postData = {
                                        //    DocumentNo: $("#txtIfApplicationNo").val(),
                                       // RfiDocumentNo: $('#txtIfpNo').val(),
                                       AllDatasecodes: selected_arr
                               
                               };
                                // alert("This are DatasetsCodes" + " " + JSON.stringify(postData));
                               $.ajax({
                                   type: "POST",
                                   url: "AmendmentsApprovalRequest.aspx/SubmitDatasetCodes",
                                   data: '{postData: ' + JSON.stringify(postData) + '}',
                                   contentType: "application/json; charset=utf-8",
                                   dataType: "json",
                                   
                                   success: function (status) {
                                       switch (status.d) {
                                           case "success":
                                               swal({
                                                   title: "University Ammendment Dataset Codes!",
                                                   text: "Your University Ammendment details was Successfully Submitted.",
                                                   icon: "success",
                                               }).then(() => {
                                                   $("#feedback2").css("display", "block");
                                                   $("#feedback2").css("color", "green");
                                                   $('#feedback2').attr("class", "alert alert-success");
                                                   $("#feedback2").html("Your University Ammendment details was Successfully Submmitted");
                                          });
                                               break;

                                           default:
                                           swal({
                                                   title: "University Ammendment Dataset Codes Error!!!",
                                                   text: "Error Occured when submmitting your University Ammendment Details.Kindly Try Again",
                                                   type: "error"
                                               }).then(() => {
                                                   $("#feedback2").css("display", "block");
                                                   $("#feedback2").css("color", "red");
                                                   $('#feedback2').addClass('alert alert-danger');
                                                   $("#feedback2").html(status.d);
                                               });
                                               break;
                                       }

                                   }
                               });
                           });
                       

         });
        
     </script>
       <%}
            
           }
           %>
    </asp:Content>
