<%@ Page Title="" Language="C#" MasterPageFile="~/DataCollectionMaster.Master" AutoEventWireup="true" CodeBehind="FinanceEntries.aspx.cs" Inherits="CicPortal.FinanceEntries" %>

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
        int maxSteps = 7;
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
        <p>*Please enter university source of income amounts in Kenya Shillings</p>
        <div class="panel-heading">
            <label class="pull-right">Step <%=myStep %> of <%=maxSteps %></label>
            (i)	Sources of income in KShs. Millions 
        </div>
        <div class="panel-body">
            <div runat="server" id="feedbacksourcesincome"></div>
            <div id="feedback1" style="display: none"></div>
            <h3>Please Select University Financial Year Start Date and End Date</h3>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Financial Year Start Date:</label>
                       <asp:DropDownList CssClass="form-control" runat="server" ID="fnstartdate" Placeholder="Financial Year Start Date" type="text" OnSelectedIndexChanged="FinancialYear_SelectedIndexChanged" AutoPostBack="true"  Style="height: 42px;" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Financial Year End Date:</label>
                     <asp:DropDownList CssClass="form-control" runat="server" ID="fnenddate" Placeholder="Financial Year End Date" type="text" OnSelectedIndexChanged="FinancialYear_SelectedIndexChanged" AutoPostBack="true"  Style="height: 42px;" />
                    </div>
                </div>
            </div>
            <table class="table table-bordered table-striped" id="tblIncome">
                <thead>
                    <tr>
                        <th>Source of Income</th>
                        <th>Expected</th>
                        <th>Actual</th>
                    </tr>

                </thead>
                <tbody>
                    <tr>
                        <td>
                            <input type="text" class="form-control" value="Recurrent Allocation" disabled="disabled" /></td>
                        <td>
                            <input type="number" class="form-control" autocomplete="off"  min="0"/></td>
                        <td> 
                            <input type="number" class="form-control" autocomplete="off"  min="0"/></td>
                    </tr>
                    <tr>
                        <td>
                            <input type="text" class="form-control" value="Development Grants" disabled="disabled" /></td>
                        <td>
                            <input type="number" class="form-control" autocomplete="off"  min="0"/></td>
                        <td>
                            <input type="number" class="form-control" autocomplete="off"  min="0"/></td>
                    </tr>
                    <tr>
                        <td>
                            <input type="text" class="form-control" value="Student Fees" disabled="disabled" /></td>
                        <td>
                            <input type="number" class="form-control" autocomplete="off"  min="0"/></td>
                        <td>
                            <input type="number" class="form-control" autocomplete="off"  min="0"/></td>
                    </tr>
                    <tr>
                        <td>
                            <input type="text" class="form-control" value="Donations" disabled="disabled" /></td>
                        <td>
                            <input type="number" class="form-control"  autocomplete="off"  min="0"/></td>
                        <td>
                            <input type="number" class="form-control" autocomplete="off"  min="0"/></td>
                    </tr>
                    <tr>
                        <td>
                            <input type="text" class="form-control" value="Income Generating Units (IGUs)" disabled="disabled" /></td>
                        <td>
                            <input type="number" class="form-control" autocomplete="off"  min="0"/></td>
                        <td>
                            <input type="number" class="form-control" autocomplete="off"  min="0"/></td>
                    </tr>
                    <tr>
                        <td>
                            <input type="text" class="form-control" value="Research Grants" disabled="disabled" /></td>
                        <td>
                            <input type="number" class="form-control" autocomplete="off"  min="0"/></td>
                        <td>
                            <input type="number" class="form-control" autocomplete="off"  min="0"/></td>
                    </tr>
                    <tr>
                        <td>
                            <input type="text" class="form-control" value="Collaborating Institutions" disabled="disabled" /></td>
                        <td>
                            <input type="number" class="form-control" autocomplete="off"  min="0"/></td>
                        <td>
                            <input type="number" class="form-control" autocomplete="off"  min="0"/></td>
                    </tr>
                    <tr>
                        <td>
                            <input type="text" class="form-control" value="Scholarships and Bursaries" disabled="disabled" /></td>
                        <td>
                            <input type="number" class="form-control" autocomplete="off"  min="0"/></td>
                        <td>
                            <input type="number" class="form-control" autocomplete="off"  min="0"/></td>
                    </tr>
                </tbody>
            </table>
            <div class="panel-footer">
                <br />
                <input type="button" id="btnSave" class="btn btn-success pull-right" value="Submit Income" />
            </div>
        </div>

        <div class="panel panel-default">
            <p>*List of all Sources of Income</p>
            <div class="panel-heading">Added Sources of Income</div>
            <div class="panel-body">
                <table class="table table-bordered table-striped datatable">
                    <thead>
                        <tr>
                            <th>Source of Income</th>
                            <th>Expected Amounts</th>
                            <th>Actual Amounts</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var nav = Config.ReturnNav();
                            var incomes = nav.SourcesofIncome.Where(r => r.University_No == Convert.ToString(Session["UniversityCode"]));
                            foreach (var income in incomes)
                            {
                        %>
                        <tr>
                            <td><%=income.Type %></td>
                            <td><%=income.Expected_Income %></td>
                            <td><%=income.Actual_Income %></td>
                            <td><label class="btn btn-success" onclick="editSourceofIncome('<%=income.No %>', '<%=income.Type %>','<%=income.Expected_Income %>', '<%=income.Actual_Income %>')"><i class="fa fa-edit"></i>Edit</label></td>
                           <td><label class="btn btn-danger" onclick="deleteSourceIncome('<%=income.No %>','<%=income.Type %>')"><i class="fa fa-trash"></i> Delete</label></td>

                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="panel-footer">
            <div class="pull-right">
                <asp:Button runat="server" ID="addsourceofincome" CssClass="btn btn-success" Text="Next" OnClick="next_Click" />

            </div>
            <div class="clearfix"></div>
        </div>
    </div>
     <script>
     function deleteSourceIncome (incomecode,sourceincome) {
         document.getElementById("IncomeToDelete").innerText = sourceincome;
         document.getElementById("MainContent_removeIncomeType").value = sourceincome;
         document.getElementById("MainContent_removeincomeCode").value = incomecode;
         $("#deleteSourceofIncomeModal").modal();
       }
     function editSourceofIncome(incomecode, sourcetype, expected, actauls) {
         document.getElementById("MainContent_editIncomeCode").value = incomecode;
         document.getElementById("MainContent_editsourcetype").value = sourcetype;
         document.getElementById("MainContent_editExpected").value = expected;
         document.getElementById("MainContent_editActuals").value = actauls;
         $("#editSourceofIncomeModal").modal();
     }

 </script>
<script>
         $(document).ready(function() {
             $('.datatable').DataTable({
                 responsive: true
             });
         });
     </script>
 <div id="deleteSourceofIncomeModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Deleting Source Of Income</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the Source of Income <strong id="IncomeToDelete"></strong> ?</p>
          <asp:TextBox runat="server" ID="removeincomeCode" type="hidden"/>
            <asp:TextBox runat="server" ID="removeIncomeType" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Income" OnClick="DeleteSourceIncome_Click" />
      </div>
    </div>
  </div>
</div>
  <div id="editSourceofIncomeModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Update Source Of Income</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="editIncomeCode" type="hidden"/>
           <div class="form-group">
               <p>*Please enter the Source of Income</p>
            <strong>Source of Income:</strong>
           <asp:TextBox runat="server" CssClass="form-control" ID="editsourcetype"/>
           </div> 
          <div class="form-group">
              <p>*Please enter the Expected Amounts</p>
            <strong>Expected Amounts:</strong>
            <asp:TextBox runat="server" CssClass="form-control" ID="editExpected"  TextMode="Number"/>
        </div>  
          <div class="form-group">
              <p>*Please enter the Actual Amounts</p>
            <strong>Actual Amounts:</strong>
            <asp:TextBox runat="server" CssClass="form-control" ID="editActuals" TextMode="Number"/>
        </div>  
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Update Source of Income" OnClick="UpdateSourceIncome_Click"/>
      </div>
    </div>
  </div>
</div>
    <%
        }
        else if (myStep == 2)
        {
    %>
    <div class="panel panel-default">
        <p>*Please enter all university Creditors amounts in Kenya Shillings</p>
        <div class="panel-heading">
            <label class="pull-right">Step <%=myStep %> of <%=maxSteps %></label>
            (ii) List of University Creditors (indicating amounts) 
        </div>
        <div runat="server" id="creditorsfeedback"></div>
        <div id="feedback2" style="display: none"></div>
        <div class="panel-body">
            <table class="table table-bordered table-striped" id="tblCreditor">
                <thead>
                    <tr>
                        <th>SN</th>
                        <th>University Creditors</th>
                        <th>Amount</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>
                            <input type="text" class="form-control" value="Statutory Remittances" disabled="disabled" /></td>
                        <td>
                            <input type="number" class="form-control" autocomplete="off"  min="0" /></td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>
                            <input type="text" class="form-control" value="Obligatory Remittances" disabled="disabled" /></td>
                        <td>
                            <input type="number" class="form-control"  autocomplete="off"  min="0"/></td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>
                            <input type="text" class="form-control" value="Supplies and Service Providers" disabled="disabled" /></td>
                        <td>
                            <input type="number" class="form-control"  autocomplete="off"  min="0"/></td>
                    </tr>
                    <tr>
                        <td>4</td>
                        <td>
                            <input type="text" class="form-control" value="Other Creditors" disabled="disabled" /></td>
                        <td>
                            <input type="number" class="form-control" autocomplete="off"  min="0"/></td>
                    </tr>
                </tbody>
            </table>
            <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 form-group">
                <br />
                <input type="button" id="btnSave1" class="btn btn-success pull-right" value="Submit Details" />
            </div>
        </div>
        <div class="panel panel-default">
            <p>*List of all University Creditors</p>
            <div class="panel-heading">Added University Creditors</div>
            <div class="panel-body">
                <table class="table table-bordered table-striped datatable">
                    <thead>
                        <tr>
                            <th>SN</th>
                            <th>University Creditors</th>
                            <th>Amounts</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var nav = Config.ReturnNav();
                            var creditors = nav.UniversityCreditors.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                            foreach (var creditor in creditors)
                            {
                        %>
                        <tr>
                            <td><%=creditor.University_Code %></td>
                            <td><%=creditor.Creditor_Category %></td>
                            <td><%=creditor.Amounts %></td>

                            <td>
                                <label class="btn btn-success" onclick="editCreditor('<%=creditor.Code %>', '<%=creditor.Creditor_Category %>', '<%=creditor.Amounts %>')"><i class="fa fa-edit"></i>Edit</label></td>
                            <td>
                                <label class="btn btn-danger" onclick="deleteCreditors('<%=creditor.Code %>','<%=creditor.Creditor_Category %>')"><i class="fa fa-trash"></i>Delete</label></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="panel-footer">
            <div class="pull-right">
                <asp:Button runat="server" ID="creditorsnext1" CssClass="btn btn-success pull-right" Text="Next" OnClick="next_Click" />
            </div>

            <div class="pull-left">
                <asp:Button runat="server" ID="creditorsnext2" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
            </div>
            <div class="clearfix"></div>
        </div>
     <script>
         function deleteCreditors (creditorcode,CreditorCategory) {
             document.getElementById("IncomeCreditToDelete").innerText = CreditorCategory;
             document.getElementById("MainContent_removeCreditorCode").value = creditorcode;
         $("#deleteCreditorModal").modal();
       }
         function editCreditor(creditor, category, amounts) {
             document.getElementById("MainContent_editCreditorCode").value = creditor;
             document.getElementById("MainContent_editCreditors").value = category;
             document.getElementById("MainContent_editAmounts").value = amounts;
             $("#editCreditorModal").modal();
     }
 </script>
 <div id="deleteCreditorModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Deleting University Creditors</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the Source of Income <strong id="IncomeCreditToDelete"></strong> ?</p>
          <asp:TextBox runat="server" ID="removeCreditorCode" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Creditor" OnClick="DeleteCreditors_Click" />
      </div>
    </div>
  </div>
</div>
 <div id="editCreditorModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Update University Creditors</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="editCreditorCode" type="hidden"/>
           <div class="form-group">
               <p>*Please enter the University Creditors</p>
            <strong>University Creditors:</strong>
           <asp:TextBox runat="server" CssClass="form-control" ID="editCreditors"/>
           </div> 
          <div class="form-group">
              <p>*Please enter the Creditor Amounts</p>
            <strong>Creditor Amounts:</strong>
            <asp:TextBox runat="server" CssClass="form-control" ID="editAmounts"  TextMode="Number"/>
        </div>   
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Update Creditor" OnClick="UpdateCreditors_Click"/>
      </div>
    </div>
  </div>
</div>
 </div>
    <%
        }
        else if (myStep == 3)
        {
    %>
    <div class="panel panel-default">
        <p>*Please enter all University debtors amounts per category in Kenya Shillings</p>
        <div class="panel-heading">
            <label class="pull-right">Step <%=myStep %> of <%=maxSteps %></label>
            (iii) List of University debtors (including amounts per category)
        </div>
        <div class="panel-body">
            <div runat="server" id="Debtorsfeedback"></div>
            <div id="feedback3" style="display: none"></div>
            <table class="table table-bordered table-striped" id="tblDebtor">
                <thead>
                    <tr>
                        <th>SN</th>
                        <th>University Debtors</th>
                        <th>Amount</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>
                            <input type="text" class="form-control" value="Student Fee Arrears" disabled="disabled" /></td>
                        <td>
                            <input type="number" class="form-control" autocomplete="off"  min="0" /></td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>
                            <input type="text" class="form-control" value="University Consultancy services" disabled="disabled" /></td>
                        <td>
                            <input type="number" class="form-control" autocomplete="off"  min="0"/></td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>
                            <input type="text" class="form-control" value="Income Generating Units (IGUs)" disabled="disabled" /></td>
                        <td>
                            <input type="number" class="form-control" autocomplete="off"  min="0"/></td>
                    </tr>
                    <tr>
                        <td>4</td>
                        <td>
                            <input type="text" class="form-control" value="Other Debtors" disabled="disabled" /></td>
                        <td>
                            <input type="number" class="form-control" autocomplete="off"  min="0" /></td>
                    </tr>
                </tbody>
            </table>
            <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 form-group">
                <br />
                <input type="button" id="btnSave2" class="btn btn-success pull-right" value="Submit Details" />
            </div>
        </div>
        <div class="panel panel-default">
            <p>*List of all University Creditors</p>
            <div class="panel-heading">Added University Creditors</div>
            <div class="panel-body">
                <table class="table table-bordered table-striped datatable">
                    <thead>
                        <tr>
                            <th>SN</th>
                            <th>University Debtors</th>
                            <th>Amounts</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var nav = Config.ReturnNav();
                            var debtors = nav.UniversityDebtors.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]));
                            foreach (var debtor in debtors)
                            {
                        %>
                        <tr>
                            <td><%=debtor.University_Code %></td>
                            <td><%=debtor.Debtor_Category %></td>
                            <td><%=debtor.Amounts %></td>

                            <td>
                                <label class="btn btn-success" onclick="editDebtors('<%=debtor.Code %>', '<%=debtor.Debtor_Category %>', '<%=debtor.Amounts %>')"><i class="fa fa-edit"></i>Edit</label></td>
                            <td>
                                <label class="btn btn-danger" onclick="deleteDebtors('<%=debtor.Code %>','<%=debtor.Debtor_Category %>')"><i class="fa fa-trash"></i>Delete</label></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="panel-footer">
            <div class="pull-right">
                <asp:Button runat="server" ID="debtorsnext1" CssClass="btn btn-success pull-right" Text="Next" OnClick="next_Click" />
            </div>
            <div class="pull-left">
                <asp:Button runat="server" ID="debtorsnext2" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
   <script>
       function deleteDebtors(debtorcode,DebtorCategory) {
           document.getElementById("IncomeDebtorToDelete").innerText = DebtorCategory;
           document.getElementById("MainContent_removeDebtorType").value = debtorcode;
           document.getElementById("MainContent_removeDebtorCode").value = debtorcode;
         $("#deleteDebtorModal").modal();
       }
       function editDebtors(debtorscode, category, amounts) {
             document.getElementById("MainContent_editDebtorCode").value = debtorscode;
             document.getElementById("MainContent_editDebtors").value = category;
             document.getElementById("MainContent_editDebtorAmounts").value = amounts;
             $("#editDebtorsModal").modal();
     }
 </script>
<div id="deleteDebtorModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Deleting University Debtors</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the University Debtors <strong id="IncomeDebtorToDelete"></strong> ?</p>
          <asp:TextBox runat="server" ID="removeDebtorCode" type="hidden"/>
           <asp:TextBox runat="server" ID="removeDebtorType" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Debtor" OnClick="DeleteDebtor_Click" />
      </div>
    </div>
  </div>
</div>
<div id="editDebtorsModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Update University Debtors</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="editDebtorCode" type="hidden"/>
           <div class="form-group">
               <p>*Please enter the University Debtors</p>
            <strong>University Debtors:</strong>
           <asp:TextBox runat="server" CssClass="form-control" ID="editDebtors"/>
           </div> 
          <div class="form-group">
              <p>*Please enter the Debtors Amounts</p>
            <strong>Debtors Amounts:</strong>
            <asp:TextBox runat="server" CssClass="form-control" ID="editDebtorAmounts"  TextMode="Number"/>
        </div>   
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Update Debtors" OnClick="UpdateDebtors_Click"/>
      </div>
    </div>
  </div>
</div>
    <%
        }
        else if (myStep == 4)
        {
    %>
    <div class="panel panel-default">
        <p>*Please enter the university operational budget and actual expenditure in Kenya shillings</p>
        <div class="panel-heading">
            <label class="pull-right">Step <%=myStep %> of <%=maxSteps %></label>
            (iv) The University operation budget and actual expenditure  
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback4"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Operation Budget:</strong>
                        <asp:TextBox runat="server" ID="txtoperationBudget" CssClass="form-control" placeholder="Operation Budget" TextMode="Number"  autocomplete="off"  min="0"/>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Actual Expenditure:</strong>
                        <asp:TextBox runat="server" ID="txtactualExpenditure" CssClass="form-control" placeholder="Actual Expenditure"  TextMode="Number" autocomplete="off"  min="0"/>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 form-group">
                <br />
                <%--                    <input type="button" id="btn_budgetactualexpenditure" class="btn btn-success btn_budgetactualexpenditure"  value="Submit Details"/>--%>
                <asp:Button runat="server" CssClass="btn btn-success" Text="Submit Details" ID="btn_budgetactualexpenditure" OnClick="ActualBudget_Click" />
            </div>
        </div>
         <div class="panel panel-default">
            <p>*List of all University Operation Budget and Actual Expenditure</p>
            <div class="panel-heading">Added University Operation Budget and Actual Expenditure</div>
            <div class="panel-body">
                <table class="table table-bordered table-striped datatable">
                    <thead>
                        <tr>
                            <th>University</th>
                            <th>Actual Expenditure</th>
                            <th>Operation Budget</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var nav = Config.ReturnNav();
                            var budgetactuals = nav.UniversityBudgetandActual.Where(r => r.University_No == Convert.ToString(Session["UniversityCode"]));
                            foreach (var budgetactual in budgetactuals)
                            {
                        %>
                        <tr>
                            <td><%=budgetactual.University_No %></td>
                            <td><%=budgetactual.Actual_Expenditure %></td>
                            <td><%=budgetactual.Operation_Budget %></td>
                            <td>
                                <label class="btn btn-success" onclick="editOperationBudget('<%=budgetactual.No %>', '<%=budgetactual.Actual_Expenditure %>', '<%=budgetactual.Operation_Budget %>')"><i class="fa fa-edit"></i>Edit</label></td>
                            <td>
                                <label class="btn btn-danger" onclick="deleteOperationBudget('<%=budgetactual.No %>','<%=budgetactual.University_No %>')"><i class="fa fa-trash"></i>Delete</label></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="panel-footer">
            <div class="pull-right">
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="btnBudget" OnClick="next_Click" />
            </div>
            <div class="pull-left">

                <asp:Button runat="server" ID="budget1" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
 <script>
     function deleteOperationBudget(budgetamounts,BudgetCategory) {
           document.getElementById("BudgetToDelete").innerText = budgetamounts;
           document.getElementById("MainContent_removeBudgetCode").value = BudgetCategory;
           $("#deleteOperationBudgetModal").modal();
       }
     function editOperationBudget(budgetcode, budgetactuals, budgetsoperation) {
         document.getElementById("MainContent_editBudgetCode").value = budgetcode;
         document.getElementById("MainContent_editopsActuals").value = budgetactuals;
         document.getElementById("MainContent_editOptsOperation").value = budgetsoperation;
         $("#editOperationBudgetModal").modal();
     }
 </script>
<div id="deleteOperationBudgetModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Deleting University Operation Budget and Actual Expenditure</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the University Debtors <strong id="BudgetToDelete"></strong> ?</p>
          <asp:TextBox runat="server" ID="removeBudgetCode" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Budget" OnClick="DeleteUniversityBudget_Click" />
      </div>
    </div>
  </div>
</div>
<div id="editOperationBudgetModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Update University Operational Budget</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="editBudgetCode" type="hidden"/>
           <div class="form-group">
               <p>*Please enter the University Debtors</p>
            <strong>University Operation Budget Amounts:</strong>
           <asp:TextBox runat="server" CssClass="form-control" ID="editOptsOperation"/>
           </div> 
          <div class="form-group">
              <p>*Please enter the Debtors Amounts</p>
            <strong>University Actual Expenditure Amounts:</strong>
            <asp:TextBox runat="server" CssClass="form-control" ID="editopsActuals"  TextMode="Number"/>
        </div>   
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Update Budget" OnClick="UpdateUniversityBudget_Click"/>
      </div>
    </div>
  </div>
</div>
    <%
        }
        else if (myStep == 5)
        {
    %>
    <div class="panel panel-default">
        <p>*Please enter University Total debt,Total Equity,Current Assets and Current Liabilities</p>
        <div class="panel-heading">
            <label class="pull-right">Step <%=myStep %> of <%=maxSteps %></label>
            (v) Total Debt, Total Equity, Current Assets and Current Liabilities 
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback5"></div>
            <div class="row">
                <div class="col-md-6 col-lg6">
                    <div class="form-group">
                        <strong>Total Debt:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Total Debt" ID="totalDebt" TextMode="Number"  autocomplete="off"  min="0" />
                    </div>
                </div>
                <div class="col-md-6 col-lg6">
                    <div class="form-group">
                        <strong>Total Equity:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Total Equity" ID="totalEquity" TextMode="Number"  autocomplete="off"  min="0"  />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg6">
                    <div class="form-group">
                        <strong>Current Assets:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Current Assets" ID="currentAssets" TextMode="Number"  autocomplete="off"  min="0" />
                    </div>
                </div>
                <div class="col-md-6 col-lg6">
                    <div class="form-group">
                        <strong>Current Liabilities:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Current Liabilities" ID="currentLiabilities" TextMode="Number"    autocomplete="off"  min="0"/>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 form-group">
                <br />
                <asp:Button runat="server" CssClass="btn btn-success" Text="Submit Details" ID="Button2" OnClick="SubmitAssetsLiabilities_Click" />
            </div>
        </div>
    </div>
  <div class="panel panel-default">
            <p>*List of all University Creditors</p>
            <div class="panel-heading">Added University Total debt,Total Equity,Current Assets and Current Liabilities</div>
            <div class="panel-body">
                <table class="table table-bordered table-striped datatable">
                    <thead>
                        <tr>
                            <th>SN</th>
                            <th>Total Debt</th>
                            <th>Total Equity</th>
                            <th>Current Assets</th>
                            <th>Current Liabilities</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var nav = Config.ReturnNav();
                            var assestliabilities = nav.UniversityBudgetandActual.Where(r => r.University_No == Convert.ToString(Session["UniversityCode"]));
                            foreach (var assestliability in assestliabilities)
                            {
                        %>
                        <tr>
                            <td><%=assestliability.University_No %></td>
                            <td><%=assestliability.University_Total_Debt %></td>
                             <td><%=assestliability.University_Total_Equity %></td>
                             <td><%=assestliability.University_Current_Assets %></td>
                             <td><%=assestliability.University_Current_Liabilities %></td>

                            <td>
                                <label class="btn btn-success" onclick="editAssets('<%=assestliability.University_No %>', '<%=assestliability.University_Total_Debt %>', '<%=assestliability.University_Total_Equity %>','<%=assestliability.University_Current_Assets %>', '<%=assestliability.University_Current_Liabilities %>')"><i class="fa fa-edit"></i>Edit</label></td>
                            <td>
                                <label class="btn btn-danger" onclick="deleteAssets('<%=assestliability.University_No %>','<%=assestliability.University_No %>')"><i class="fa fa-trash"></i>Delete</label></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    <div class="panel-footer">
        <div class="pull-right">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="Button3" OnClick="next_Click" />
        </div>
        <div class="pull-left">
            <asp:Button runat="server" ID="Button1" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
        </div>
        <div class="clearfix"></div>
    </div> 
    
    <script>
        function deleteAssets(assetcode,totalassets) {
            document.getElementById("AssetsToDelete").innerText = assetcode;
            document.getElementById("MainContent_removeAssetsCode").value = totalassets;
           $("#deleteAssetsBudgetModal").modal();
       }
        function editAssets(assetcode, debts, equity,currentassets,liability) {
            document.getElementById("MainContent_editUniversityCode").value = assetcode;
            document.getElementById("MainContent_edittotaldebts").value = debts;
            document.getElementById("MainContent_edittotalequity").value = equity;
            document.getElementById("MainContent_edittotalAssets").value = currentassets;
            document.getElementById("MainContent_edittotalLibaility").value = liability;
         $("#editAssetsModal").modal();
     }
 </script> 
  <div id="deleteAssetsBudgetModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Deleting Total Debt, Total Equity, Current Assets and Current Liabilities</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete the University Debtors <strong id="AssetsToDelete"></strong> ?</p>
          <asp:TextBox runat="server" ID="removeAssetsCode" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Budget" OnClick="DeleteAssets_Click" />
      </div>
    </div>
  </div>
</div>  
<div id="editAssetsModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Update University Operational Budget</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="editUniversityCode" type="hidden"/>
           <div class="form-group">
               <p>*Please enter the University Debtors</p>
            <strong>University Total Debt:</strong>
           <asp:TextBox runat="server" CssClass="form-control" ID="edittotaldebts"/>
           </div> 
          <div class="form-group">
              <p>*Please enter the Debtors Amounts</p>
            <strong>University Total Equity:</strong>
            <asp:TextBox runat="server" CssClass="form-control" ID="edittotalequity"  TextMode="Number"/>
        </div> 
          <div class="form-group">
              <p>*Please enter the Debtors Amounts</p>
            <strong>University Current Assets:</strong>
            <asp:TextBox runat="server" CssClass="form-control" ID="edittotalAssets"  TextMode="Number"/>
        </div> 
           <div class="form-group">
              <p>*Please enter the Debtors Amounts</p>
            <strong>University Current Liabilities:</strong>
            <asp:TextBox runat="server" CssClass="form-control" ID="edittotalLibaility"  TextMode="Number"/>
        </div>   
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Update Budget" OnClick="UpdateAssets_Click"/>
      </div>
    </div>
  </div>
</div>
    <%
        }
        else if (myStep == 6)
        {
    %>
    <div class="panel panel-default">
        <p>*Please enetr University research Budget Allocation and Actual Expenditure amounts in Kenya Shillings</p>
        <div class="panel-heading">
            <label class="pull-right">Step <%=myStep %> of <%=maxSteps %></label>
            Research
        </div>

        <div class="panel-body">
            <div runat="server" id="feedback6"></div>
            <h4>Internal Research Funds (Amount set apart by the University for research activities)</h4>
            <div class="row">
                <div class="col-md-6 col-lg6">
                    <div class="form-group">
                        <strong>Budget Allocation:</strong>
                        <asp:TextBox runat="server" ID="researchBudgetAllocation" CssClass="form-control" placeholder="Operation Budget" TextMode="Number"  autocomplete="off"  min="0" />
                    </div>
                </div>
                <div class="col-md-6 col-lg6">
                    <div class="form-group">
                        <strong>Actual Expenditure:</strong>
                        <asp:TextBox runat="server" ID="researchActualExpenditure" CssClass="form-control" placeholder="Actual Expenditure" TextMode="Number"  autocomplete="off"  min="0" />
                    </div>
                </div>
            </div>
            <h4>External Research Funds (Amount attracted for research through local, regional and international grants)</h4>
            <hr />
            <div class="row">
                <div class="col-md-6 col-lg6">
                    <div class="form-group">
                        <strong>Amount awarded during the Financial Year:</strong>
                        <asp:TextBox runat="server" ID="researchAttractedBudgetAllocation" CssClass="form-control" placeholder="Operation Budget" TextMode="Number"   autocomplete="off"  min="0"/>
                    </div>
                </div>
                <div class="col-md-6 col-lg6">
                    <div class="form-group">
                        <strong>Amount spent during the Financial Year:</strong>
                        <asp:TextBox runat="server" ID="researchAttractedActualExpenditure" CssClass="form-control" placeholder="Actual Expenditure" TextMode="Number"   autocomplete="off"  min="0"/>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 form-group">
                <br />
                <asp:Button runat="server" CssClass="btn btn-success" Text="Submit Details" ID="Button6" OnClick="Research_Click" />
            </div>
        </div>
         <div class="panel panel-default">
            <p>*List of all University Creditors</p>
            <div class="panel-heading">Added University research Budget Allocation and Actual Expenditure</div>
            <div class="panel-body">
                <table class="table table-bordered table-striped datatable">
                    <thead>
                        <tr>
                            <th>University </th>
                            <th>University Budget Allocation</th>
                            <th>University Actual Expenditure</th>
                             <th>Research Budget Expenditure</th>
                             <th>Research Actual Expenditure</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var nav = Config.ReturnNav();
                            var reasearchamounts = nav.UniversityBudgetandActual.Where(r => r.University_No == Convert.ToString(Session["UniversityCode"]));
                            foreach (var reasearchamount in reasearchamounts)
                            {
                        %>
                        <tr>
                            <td><%=reasearchamount.University_No %></td>
                            <td><%=reasearchamount.Research_Budget_Allocation %></td>
                             <td><%=reasearchamount.Research_Actual_Expenditure %></td>
                            <td><%=reasearchamount.BudgetAttractedforResearch %></td>
                             <td><%=reasearchamount.ActualAttractedforResearch %></td>

                            <td>
                                <label class="btn btn-success" onclick="editResearch('<%=reasearchamount.No %>', '<%=reasearchamount.University_Budget_Allocation %>', '<%=reasearchamount.BudgetAttractedforResearch %>', '<%=reasearchamount.University_Actual_Expenditure %>', '<%=reasearchamount.Actual_Expenditure %>')"><i class="fa fa-edit"></i>Edit</label></td>
                            <td>
                                <label class="btn btn-danger" onclick="deleteResearch('<%=reasearchamount.University_No %>','<%=reasearchamount.University_No %>')"><i class="fa fa-trash"></i>Delete</label></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="panel-footer">
            <div class="pull-right">
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="Button5" OnClick="next_Click" />
            </div>
            <div class="pull-left">
                <asp:Button runat="server" ID="Button4" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
    
    <script>
        function deleteResearch(researchcode,researchamounts) {
            document.getElementById("RsearchToDelete").innerText = researchcode;
            document.getElementById("MainContent_removeResearchCode").value = researchamounts;
           $("#deleteResearchModal").modal();
       }
        function editResearch(researchcode, budgetallocation, actualexpenditure,researchallocation,actualexpenditure) {
            document.getElementById("MainContent_editResearchUniversityCode").value = researchcode;
            document.getElementById("MainContent_editbudgetallocation").value = budgetallocation;
            document.getElementById("MainContent_editactualexpenditure").value = actualexpenditure;
            document.getElementById("MainContent_editresearchallocation").value = researchallocation;
            document.getElementById("MainContent_editresearchactualexpenditure").value = actualexpenditure;
            $("#editResearchModal").modal();
     }
 </script> 
  <div id="deleteResearchModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Deleting Research</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete Research <strong id="RsearchToDelete"></strong> ?</p>
          <asp:TextBox runat="server" ID="removeResearchCode" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Research"  OnClick="DeleteResearch_Click"/>
      </div>
    </div>
  </div>
</div> 
<div id="editResearchModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Update University Operational Budget</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="editResearchUniversityCode" type="hidden"/>
           <div class="form-group">
               <p>*Please enter the University Debtors</p>
            <strong>University Budget Allocation::</strong>
           <asp:TextBox runat="server" CssClass="form-control" ID="editbudgetallocation"/>
           </div> 
          <div class="form-group">
              <p>*Please enter the Debtors Amounts</p>
            <strong>University Actual Expenditure:</strong>
            <asp:TextBox runat="server" CssClass="form-control" ID="editactualexpenditure"  TextMode="Number"/>
        </div> 
          <div class="form-group">
              <p>*Please enter the Debtors Amounts</p>
            <strong>University Research  Budget Allocation:</strong>
            <asp:TextBox runat="server" CssClass="form-control" ID="editresearchallocation"  TextMode="Number"/>
        </div> 
           <div class="form-group">
              <p>*Please enter the Debtors Amounts</p>
            <strong>University Research  Actual Expenditure:</strong>
            <asp:TextBox runat="server" CssClass="form-control" ID="editresearchactualexpenditure"  TextMode="Number"/>
        </div>   
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Update Budget" OnClick="UpdateResearch_Click" />
      </div>
    </div>
  </div>
</div>
    <%
        }
        else if (myStep == 7)
        {
    %>
    <div class="panel panel-default">
        <p>*Please enter University Library operational Budget and actual expenditure amounts in Kenya Shillings</p>
        <div class="panel-heading">
            <label class="pull-right">Step <%=myStep %> of <%=maxSteps %></label>
            (iv) The University Library operation budget and actual expenditure  
        </div>
        <div class="panel-body">
            <div runat="server" id="feedback7"></div>
            <div class="row">
                <div class="col-md-6 col-lg6">
                    <div class="form-group">
                        <strong>Library Operation Budget:</strong>
                        <asp:TextBox runat="server" ID="libraryOperationBudget" CssClass="form-control" placeholder="Library Operation Budget" TextMode="Number"   autocomplete="off"  min="0"/>
                    </div>
                </div>
                <div class="col-md-6 col-lg6">
                    <div class="form-group">
                        <strong>Library Actual Expenditure:</strong>
                        <asp:TextBox runat="server" ID="libraryActualExpenditure" CssClass="form-control" placeholder="Library Actual Expenditure" TextMode="Number"   autocomplete="off"  min="0"/>
                    </div>
                </div>
                <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 form-group">
                    <br />
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Submit Details" ID="Button8" OnClick="Sumit_Click" />
                </div>
            </div>
             <div class="panel panel-default">
            <p>*List of all University Creditors</p>
            <div class="panel-heading">Added University Library Operation Budget and Actual expenditure</div>
            <div class="panel-body">
                <table class="table table-bordered table-striped datatable">
                    <thead>
                        <tr>
                            <th>SN</th>
                            <th>Library Operation Budget</th>
                            <th>Library Actual Expenditure</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var nav = Config.ReturnNav();
                            var libraries = nav.UniversityBudgetandActual.Where(r => r.University_No == Convert.ToString(Session["UniversityCode"]));
                            foreach (var library in libraries)
                            {
                        %>
                        <tr>
                            <td><%=library.University_No %></td>
                            <td><%=library.Library_Operation_Budget %></td>
                            <td><%=library.Library_Actual_Expenditure %></td>

                            <td>
                                <label class="btn btn-success" onclick="editLibraryBudget('<%=library.University_No %>', '<%=library.Library_Actual_Expenditure %>', '<%=library.Library_Operation_Budget %>')"><i class="fa fa-edit"></i>Edit</label></td>
                            <td>
                                <label class="btn btn-danger" onclick="deleteLibraryBudget('<%=library.University_No %>','<%=library.University_No %>')"><i class="fa fa-trash"></i>Delete</label></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
            <div class="panel-footer">
                <div class="pull-left">
                </div>
                <asp:Button runat="server" ID="Button7" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
   
     <script>
         function deleteLibraryBudget(librarycode,budgetamounts) {
             document.getElementById("LibraryToDelete").innerText = librarycode;
             document.getElementById("MainContent_removeLibraryCode").value = budgetamounts;
             $("#deleteLibraryBudgetModal").modal();
       }
        function editLibraryBudget(universityCode, actualexpenditure, operationBudget) {
            document.getElementById("MainContent_editLibraryUniversityCode").value = universityCode;
            document.getElementById("MainContent_editLibraryOperationBudget").value = actualexpenditure;
            document.getElementById("MainContent_editLibraryActualExpenditure").value = operationBudget;
            $("#editLibraryBudgetModal").modal();
     }
 </script> 
<div id="deleteLibraryBudgetModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Deleting Library</h4>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete Research <strong id="LibraryToDelete"></strong> ?</p>
          <asp:TextBox runat="server" ID="removeLibraryCode" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Research" OnClick="DeleteLibraryResearch_Click" />
      </div>
    </div>
  </div>
</div> 
<div id="editLibraryBudgetModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Update University Operational Budget</h4>
      </div>
      <div class="modal-body">
          <asp:TextBox runat="server" ID="editLibraryUniversityCode" type="hidden"/>
           <div class="form-group">
               <p>*Please enter the University Debtors</p>
            <strong>Library Operation Budget:</strong>
           <asp:TextBox runat="server" CssClass="form-control" ID="editLibraryOperationBudget" autocomplete="off"  min="0"/>
           </div> 
          <div class="form-group">
              <p>*Please enter the Debtors Amounts</p>
            <strong>Library Actual Expenditure:</strong>
            <asp:TextBox runat="server" CssClass="form-control" ID="editLibraryActualExpenditure"  TextMode="Number" autocomplete="off"  min="0"/>
        </div>   
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Update Budget" OnClick="UpdateLibrary_Click"/>
      </div>
    </div>
  </div>
</div>
    <%
        }%>
    <%
        }
        else
        {
            var nav = Config.ReturnNav();
    %>
    <div class="row">
        <div class="col-lg-3 col-md-6">
            <div class="panel panel-green">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-xs-3">
                            <i class="fa fa-user fa-5x"></i>
                        </div>
                        <div class="col-xs-9 text-right">
                            <div class="huge">
                                <%

                                    int academicStaff = new Config().ObjNav().FnGetUniversityTotalUniversityStaff(Convert.ToString(Session["UniversityCode"]));
                                %>
                                <% =academicStaff %>
                            </div>
                            <div>Total Academic Staff</div>
                        </div>
                    </div>
                </div>
                <a href="AcademicStaff.aspx">
                    <div class="panel-footer">
                        <span class="pull-left">View Details</span>
                        <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                        <div class="clearfix"></div>
                    </div>
                </a>
            </div>
        </div>
        <div class="col-lg-3 col-md-6">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-xs-3">
                            <i class="fa fa-book fa-5x"></i>
                        </div>
                        <div class="col-xs-9 text-right">
                            <div class="huge">
                                <%

                                    int campus1 = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"])).ToList().Count;
                                %>
                                <% =campus1 %>
                            </div>
                            <div>Total Campuses</div>
                        </div>
                    </div>
                </div>
                <a href="AccreditedPrograms.aspx">
                    <div class="panel-footer">
                        <span class="pull-left">View Details</span>
                        <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                        <div class="clearfix"></div>
                    </div>
                </a>
            </div>
        </div>
        <div class="col-lg-3 col-md-6">
            <div class="panel panel-green">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-xs-3">
                            <i class="fa fa-user fa-5x"></i>
                        </div>
                        <div class="col-xs-9 text-right">
                            <div class="huge">
                                <%
                                    int programs1 = nav.Programs.Where(r => r.Accreditation_Status == "CUE Accredited" && r.Institution_Code == Convert.ToString(Session["UniversityCode"])).ToList().Count;
                                %>
                                <% =programs1 %>
                            </div>
                            <div>Total Programmes</div>
                        </div>
                    </div>
                </div>
                <a href="AcademicStaff.aspx">
                    <div class="panel-footer">
                        <span class="pull-left">View Details</span>
                        <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                        <div class="clearfix"></div>
                    </div>
                </a>
            </div>
        </div>
        <div class="col-lg-3 col-md-6">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-xs-3">
                            <i class="fa fa-book fa-5x"></i>
                        </div>
                        <div class="col-xs-9 text-right">
                            <div class="huge">
                                <%
                                    int disability = new Config().ObjNav().FnGetUniversityPWDTotalStudents(Convert.ToString(Session["UniversityCode"]));
                                %>
                                <% =disability %>
                            </div>
                            <div>PWD Staff</div>
                        </div>
                    </div>
                </div>
                <a href="AccreditedPrograms.aspx">
                    <div class="panel-footer">
                        <span class="pull-left">View Details</span>
                        <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                        <div class="clearfix"></div>
                    </div>
                </a>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-lg-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <i class="fa fa-bar-chart-o fa-fw"></i>University Creditors amounts in Kenya Shillings

                </div>
                <div class="panel-body">
                    <div id="creditors-chart" style="position: center; right: 0px; top: 0px;"></div>
                </div>
            </div>

        </div>
        <div class="col-md-4 col-lg-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <i class="fa fa-bar-chart-o fa-fw"></i>Sources of income in KShs. Millions 
                </div>
                <div class="panel-body">
                    <div id="sponsor-chart"></div>

                </div>
                <!-- /.panel-body -->
            </div>

        </div>
        <div class="col-md-4 col-lg-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <i class="fa fa-bar-chart-o fa-fw"></i>University Debtors in Kenya Shillings
                </div>
                <div class="panel-body">
                    <div id="debtors-chart"></div>

                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-lg-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <i class="fa fa-bar-chart-o fa-fw"></i>University Creditors amounts in Kenya Shillings

                </div>
                <div class="panel-body">
                    <div id="creditors1-chart" style="position: center; right: 0px; top: 0px;"></div>
                </div>
            </div>

        </div>
        <div class="col-md-4 col-lg-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <i class="fa fa-bar-chart-o fa-fw"></i>Sources of income in KShs. Millions 
                </div>
                <div class="panel-body">
                    <div id="sponsor1-chart"></div>

                </div>
                <!-- /.panel-body -->
            </div>

        </div>
        <div class="col-md-4 col-lg-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <i class="fa fa-bar-chart-o fa-fw"></i>University Debtors in Kenya Shillings
                </div>
                <div class="panel-body">
                    <div id="debtors1-chart"></div>

                </div>
            </div>
        </div>
    </div>
   <div class="panel panel-default">
            <p>*List of University Sources of Income</p>
            <div class="panel-heading">University Submitted Sources of Income</div>
            <div class="panel-body">
                <table class="table table-bordered table-striped datatable">
                    <thead>
                        <tr>
                            <th>Source of Income</th>
                            <th>Expected Amounts</th>
                            <th>Actual Amounts</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var nav1 = Config.ReturnNav();
                            var incomes = nav.SourcesofIncome.Where(r => r.University_No == Convert.ToString(Session["UniversityCode"]));
                            foreach (var income in incomes)
                            {
                        %>
                        <tr>
                            <td><%=income.Type %></td>
                            <td><%=income.Expected_Income %></td>
                            <td><%=income.Actual_Income %></td>
                         
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
            $('.datatable').DataTable({
                responsive: true
            });
        });
    </script>


 <div id="editBuildingModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Edit Source Of Income</h4>
      </div>
      <div class="modal-body">
           <asp:TextBox runat="server" ID="editBuilding" type="hidden"/>
           <div class="form-group">
               <p>*Please select the campus Name</p>
            <strong>Campus Name:</strong>
            <asp:DropDownList runat="server" CssClass="form-control" ID="editCampusName"/>
        </div> 
          <div class="form-group">
              <p>*Please select the Building Category</p>
            <strong>Building Category:</strong>
            <asp:DropDownList runat="server" CssClass="form-control " ID="editBuildingtype"/>
        </div>  
          <div class="form-group">
              <p>*Please enter the Building Description</p>
            <strong>Building Descrption:</strong>
            <asp:TextBox runat="server" CssClass="form-control" ID="editDescription" Placehoder="Description"/>
        </div>  
          <div class="form-group">
              <p>*Please enter the building Capacity</p>
            <strong>Building Capacity</strong>
            <asp:TextBox runat="server" CssClass="form-control" ID="editCapacity"/>
        </div>                      
           <div class="form-group">
              <p>*Please enter the Building Location</p>
            <strong>Building Location:</strong>
            <asp:TextBox runat="server" CssClass="form-control" ID="editLocation"/>
        </div> 
           <div class="form-group">
              <p>*Please enter the Building Size</p>
            <strong>Building Size:</strong>
            <asp:TextBox runat="server" CssClass="form-control" ID="editSize"/>
        </div>  
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Update Building" ID="Button9" />
                <div class="clearfix"></div>
            </div>
      </div>
    </div>
  </div>
    <script src="js/http_ajax.googleapis.com_ajax_libs_jquery_3.2.1_jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <%
        }
    %>
    
<script src="js/http_ajax.googleapis.com_ajax_libs_jquery_3.2.1_jquery.min.js"></script>
<script src="js/http_cdnjs.cloudflare.com_ajax_libs_popper.js_1.12.6_umd_popper.js"></script>
<script src="js/http_maxcdn.bootstrapcdn.com_bootstrap_4.0.0-beta.2_js_bootstrap.js"></script>
<script src="js/http_unpkg.com_sweetalert_dist_sweetalert.min.js"></script>
<script src="js/http_rawgit.com_eligrey_FileSaver.js_master_FileSaver.js"></script>
<script src="js/http_unpkg.com_xlsx_dist_xlsx.full.min.js"></script>
<script src="js/excel_uploader.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://github.com/eligrey/Blob.js"></script>
<script src="https://rawgit.com/eligrey/FileSaver.js/src/FileSaver.js"></script>
<script src="https://unpkg.com/xlsx/dist/xlsx.full.min.js"></script>
</asp:Content>
