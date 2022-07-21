<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/AccreditationMaster.Master" CodeBehind="NewProgrammeAccreditations.aspx.cs" Inherits="CicPortal.NewProgrammeAccreditations" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%
        var nav = Config.ReturnNav();
        String accreditationNo = "";
         String applicationNo = "";
        try
        {
            accreditationNo = Request.QueryString["accreditationNo"].Trim();
            applicationNo = Request.QueryString["applicationNo"].Trim();
        }
        catch (Exception)
        {

        }
    %>

    <% 
    string institutionstatus = Convert.ToString(Session["InstitutionStatus"]);
    if (institutionstatus == "Proposed")
    {
     %>
     <div class="panel panel-primary">
        <div class="panel panel-default">
            <div class="panel-heading">
                Programme General Details
                <div class="clearfix"></div>
            </div>
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <strong>Programme Name<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" ID="programName" CssClass="form-control" placeholder="Programme Name" />
                    <asp:RequiredFieldValidator runat="server" ID="programNameValidator" ControlToValidate="programName" ErrorMessage="Please Enter Programme Name" ForeColor="Red" />
                </div>
                <div class="col-md-6 col-lg-6">
                    <strong>Programme Duration<span style="color: red">*</span></strong>
                    <asp:TextBox runat="server" ID="duration" CssClass="form-control" type="number" placeholder="Programme Duration" />
                    <asp:RequiredFieldValidator runat="server" ID="durationValidator" ControlToValidate="duration" ErrorMessage="Please Enter Programme Duration" ForeColor="Red" />
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <strong>Programme Level<span style="color: red">*</span></strong>
                    <asp:DropDownList runat="server" ID="programLevel" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="programLevel" InitialValue="--Select--" ErrorMessage="Please Select Programme Level" ForeColor="Red" />
                </div>
                <div class="col-md-6 col-lg-6">
                    <strong>Programme Domain<span style="color:red">*</span></strong>
                    <asp:DropDownList runat="server" ID="programDomain" CssClass="form-control" AppendDataBoundItems="true" >
                        <asp:ListItem>--Select--</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator runat="server" id="programDomainValidator" controltovalidate="programDomain" InitialValue="--Select--" errormessage="Please Select Programme Domain" ForeColor="Red"/>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                    <br />
                    <asp:Button runat="server" ID="addprogramDetails" CssClass="btn btn-success btn-block" Text="Save Program Details" OnClick="addprogramDetails_Click"/>
                </div>
            </div>
            <br />
        </div>
    </div>
    <div class="panel-body">
        <div id="feedback1" runat="server"></div>
        <table class="table table-bordered table-striped table-hover" id="dataTables-example1">
            <thead>
                <tr>
                    <th>Code</th>
                    <th>Description</th>
                    <th>Programme Domain</th>
                    <th>Programme Level</th>
                    <th>Duration</th>
                    <th>Cost</th>
                    <th>Remove</th>
                </tr>
            </thead>
            <tbody>
                <%
                    var nav1 = Config.ReturnNav();
                    string application1 = Request.QueryString["applicationNo"];
                    string AccCode = Request.QueryString["AccCode"];
                    decimal IA = 0;
                    decimal pprogramee = 0;
                    var acrefees = nav.AccreditationFees;
                    foreach (var fees in acrefees)
                    {
                        pprogramee = Convert.ToDecimal(fees.Programme_Accreditation_Amount);
                    }
                    var insFees = nav.InstitutionFeesSchedule.Where(x=> x.Service == AccCode);
                    foreach (var item in insFees)
                    {
                        IA = Convert.ToDecimal(item.Amount);
                    }
                    decimal ptotal = 0;
                    decimal TotalAmount = 0;
                    int nP = nav1.Programmes.Where(r => r.Institution_Application_Number == application1).ToList().Count();
                    ptotal = pprogramee * Convert.ToDecimal(nP);
                    TotalAmount = ptotal + IA;
                    Session["IA"] = IA;
                    Session["ptotal"] = ptotal;
                    Session["TotalAmount"] = TotalAmount;
                    var requests = nav1.Programmes.Where(r => r.Institution_Application_Number == application1);
                    foreach (var request in requests)
                    {
                %>
                <tr>
                    <td><%=request.Code %></td>
                    <td><%=request.Description %></td>
                    <td><%=request.domainDescription %></td>
                    <td><%=request.Program_Level %></td>
                    <td><%=request.Programme_Duration %></td>
                    <td><%= pprogramee %></td>
                    <td><label class="btn btn-danger" onclick="RemoveProgram('<%=request.Code %>','<%=request.Description %>');"><i class="fa fa-thrash"></i>Remove</label></td>
                </tr>
                        <%
            }
        %>
            </tbody>
        </table>
        <br />
        <div class="row">
            <div class="col-md-6 col-lg-6">
                <label style="color:royalblue"><strong>Total Programme Accreditation Amount:</strong></label>
                <asp:Label runat="server" class="form-control" readonly="true"> <%=Convert.ToDecimal(Session["ptotal"]).ToString("#,##0") %></asp:Label>
            </div>
            <div class="col-md-6 col-lg-6">
                <label style="color:royalblue"><strong>Total Institutional Accreditation Amount:</strong></label>
                <asp:Label runat="server" class="form-control" readonly="true"> <%=Convert.ToDecimal(Session["IA"]).ToString("#,##0") %></asp:Label>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 col-lg-6">
                <label style="color:royalblue"><strong>Total Amount To Pay:</strong></label>
                <asp:Label runat="server" class="form-control" readonly="true"> <%=Convert.ToDecimal(Session["TotalAmount"]).ToString("#,##0") %></asp:Label>
            </div>
        </div>
        <br />
    </div>
        <% 
        string application = Request.QueryString["applicationNo"];
        int progmmecounter = nav.Programmes.Where(r => r.Institution_Application_Number == application).ToList().Count;
       %> 
        <%
        if (progmmecounter > 2)
        {
            %>
            <div class="row">
            <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                <br />
                <asp:Button runat="server" ID="SubmitProgrammeApplication" CssClass="btn btn-success pull-right" Text="Submit Application To CUE" CausesValidation="false" OnClick="SubmitProgrammeApplication_Click"/>
            </div>
            </div>
        <%
        }
        %>

    <asp:Button runat="server" ID="previous" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" CausesValidation="false"/><br /><br />
    <%
    }
    else
    {
    %>
    <div class="panel panel-default programsData">
        <div class="panel-heading">List Of All CUE Accredited Programmes</div>
        <div class="panel-body">
            <div id="feedbackData" runat="server"></div>
            
            <table class="table table-bordered table-striped table-hover tablePrograms" id="dataTable2">

                <thead>
                    <tr>
                        <th  style="display:none">Document No</th>
                        <th><input type="checkbox" id="checkBoxAll" name="checkBoxAll" class="custom-checkbox" /></th>
                        <th>Program No</th>
                        <th>Description</th>
                        <th>Programme Domain</th>
                        <th>Programme Level</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var nav4 = Config.ReturnNav();
                        var programs = nav.Programs.Where(r => r.Accreditation_Status == "CUE Accredited" && r.Institution_Code == Convert.ToString(Session["UniversityCode"]));
                        foreach (var request in programs)
                        {
                    %>
                    <tr>
                        <td style="display:none"><input value="<% =Request.QueryString["applicationNo"] %>" id="txtapplicationNo"/></td>
                        <td><input type="checkbox" class="checkboxes" id="selectedprograms" name="selectedprograms" value=""/></td>
                        <td><%=request.Code %></td>
                        <td><%=request.Description %></td>
                        <td><%=request.domainName %></td>
                        <td><%=request.Program_Level %></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
            <center>
                <button type="button" class="btn btn-success btn_applyallselectedActvities" id="btn_applyallselectedActvities" name="btn_applyallselectedActvities">Submit Selected Programs</button>
            </center>
        <br />
        <br />
    </div>               
      <%
    }
   %>

<div id="RemoveProgramModal" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Confirm removal of programme</h4>
          </div>
          <div class="modal-body">
            <p>Are you sure you want to remove the programme: <strong id="terminateNo"></strong>?</p>
              <asp:TextBox runat="server" ID="programNo" type="hidden"/>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-danger pull-left" data-dismiss="modal">Cancel</button>
              <asp:Button runat="server" CssClass="btn btn-success" Text="Remove Programme" ID="removeprogram" CausesValidation="false" OnClick="removeprogram_Click"/>
          </div>
    </div>
  </div>
</div>
 
<script>
    function RemoveProgram(applicationno, desc) {
        document.getElementById("terminateNo").innerText = desc;
        document.getElementById("MainContent_programNo").value = applicationno;
        $("#RemoveProgramModal").modal();
    }
</script>
<script>
    $(document).ready(function () {
        $('#dataTable2').DataTable({
            responsive: true
        });
    });
    $(document).ready(function () {
        $('#dataTables-example1').DataTable({
            responsive: true
        });
    });
</script>
</asp:Content>