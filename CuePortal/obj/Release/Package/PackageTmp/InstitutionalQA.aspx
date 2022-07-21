<%@ Page Title="" Language="C#" MasterPageFile="~/QAMaster.Master" AutoEventWireup="true" CodeBehind="InstitutionalQA.aspx.cs" Inherits="CicPortal.InstitutionalQA" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%
        var step = Request.QueryString["step"];
        int myStep = 0;
        int maxSteps = 9;
        try
        {
            myStep = Convert.ToInt32(step);
        }
        catch (Exception)
        {
            myStep = 1;
        }
        if (myStep < 1) 
        {
        myStep = 1;
        }
         String qaNo = Request.QueryString["qa"].Trim();
         var nav = Config.ReturnNav();
    %>
    <%  if (myStep==1)
       {
         %>
    <div class="panel panel-primary">
        <div class="panel-heading">University Stakeholders
            <label class="pull-right">Step <%=myStep %> of <%=maxSteps %></label>
            <div class="clearfix"></div>
        </div>
        <div id="feedbackstakeholder" runat="server"></div>
        <div class="panel-body">
         <table class="table table-bordered table-striped" runat="server" id="knownStakeHolders">
             <thead>
             <tr>
                 <th>Stakeholder</th>
                 <th>A Stakeholder?(Check if yes) </th>
                 <th>Engaged in the last five years?(Check if yes) </th>
                 <th>Has the University analyzed the needs and requirements of the stakeholder in the last five years?(Check if yes) </th>
             </tr>
             </thead>
             <tbody>
           </tbody>
         </table>
            <div class="row" style="margin: 10px;">
                <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Save Changes" ID="saveStakeHolders" OnClick="saveStakeHolders_Click"/>
            </div>
            <h3>Other Stakeholders</h3>
            <hr/>
              <div id="feedbackOthers" runat="server"></div>
            <table class="table table-bordered table-striped">
             <thead>
             <tr>
                 <th>Stakeholder</th>
                 <th>Engaged in the last five years? <br/>(Check if yes) </th>
                 <th>Has the University analyzed the needs and requirements <br/>of the stakeholder in the last five years?(Check if yes) </th>
             </tr>
             </thead>
             <tbody>
              <tr>
                  <td><asp:Textbox runat="server" ID="otherStakeHolderName" CssClass="form-control" placeholder="Stakeholder Name"/> </td>
                 <td><asp:Checkbox runat="server" ID="stakeengaged" /></td>
                 <td><asp:Checkbox runat="server" ID="analyzeneeds"/></td>
             </tr>
                 <tr>
                 <td colspan="3"> <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Add Stakeholder" OnClick="AddOtherStakeholder_Click"/></td>
                 </tr>
                 </tbody>
                 </table>
             </div>
        <div class="panel-footer">
            <div class="pull-right">
                <a href="InstitutionalQA.aspx?qa=<%=qaNo%>&step=<%=myStep+1 %>" class="btn btn-success">Next</a>
            </div>
            <div class="pull-left">
                <a href="InstitutionalQA.aspx?qa=<%=qaNo%>&step=<%=myStep-1 %>" class="btn btn-danger"">Previous</a>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
    <%  
       }else  if (myStep==2)
       {
         %>
    <div class="panel panel-primary">
        <div class="panel-heading">Key Strengths and Weaknesses on the University Stakeholder Requirements
            <label class="pull-right">Step <%=myStep %> of <%=maxSteps %></label>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">
            <div runat="server" id="strengthWeaknessFeedback"></div>
         <div class="row">
             <div class="col-md-6 col-lg-6">
                 <div class="panel panel-primary">
                     <div class="panel-heading">
                         Key Strengths
                     </div>
                     <div class="panel-body">
                         <div class="form-group">
                             <strong>Strength:</strong>
                             <asp:Textbox runat="server" CssClass="form-control" placeholder="Strength" ID="stakeHolderStrength"/>
                         </div>
                         <div class="form-group">
                             <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Strength" ID="addStakeHolderStrength" OnClick="addStakeHolderStrength_Click"/>
                         </div>
                         <table class="table table-bordered table-striped" id="dataTables-example">
                             <thead>
                             <tr>
                                 <th>SN</th>
                                 <th>Strength</th>
                             </tr>
                             </thead>
                             <tbody>
                             <%
                                 var strengths = nav.StrengthsWeaknessOnStakeHolder.Where(r => r.QA_No == qaNo && r.Type == "Strength");
                                 int strengthscounter = 0;
                                 foreach (var strength in strengths)
                                 {
                                     strengthscounter++;

                                     %>
                                 <tr>
                                 <td><%=strengthscounter %></td>
                               </tr>
                                         <%
                                     
                                 } %>
                             </tbody>
                         </table>
                     </div>
                 </div>
             </div>
           <div class="col-md-6 col-lg-6">
                 <div class="panel panel-primary">
                     <div class="panel-heading">
                         Key Weaknesses
                     </div>
                     <div class="panel-body">
                         <div class="form-group">
                             <strong>Weakness:</strong>
                             <asp:Textbox runat="server" CssClass="form-control" placeholder="Weakness" ID="stakeholderWeakness"/>
                         </div>
                         <div class="form-group">
                             <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Weakness" ID="addStakeHolderWeakness" OnClick="addStakeHolderWeakness_Click"/>
                         </div>
                         <table class="table table-bordered table-striped" id="dataTables-example1">
                             <thead>
                             <tr>
                                 <th>SN</th>
                                 <th>Weakness</th>

                             </tr>
                             </thead>
                             <tbody>
                             <%
                                 var weaknesses = nav.StrengthsWeaknessOnStakeHolder.Where(r => r.QA_No == qaNo && r.Type == "Weakness");
                                 int weaknessescounter = 0;
                                 foreach (var weakness in weaknesses)
                                 {
                                     weaknessescounter++;
                                     %>
                                 <tr>
                                 <td><%=weaknessescounter%></td>
                             </tr>
                                         <%
                                     
                                 } %>
                             
                                
                             </tbody>
                         </table>
                     </div>
                 </div>
             </div>
         
              </div>
        </div>
        <div class="panel-footer">
            <div class="pull-right">
                <a href="InstitutionalQA.aspx?qa=<%=qaNo%>&step=<%=myStep+1 %>" class="btn btn-success">Next</a>
            </div>
            <div class="pull-left">
                <a href="InstitutionalQA.aspx?qa=<%=qaNo%>&step=<%=myStep-1 %>" class="btn btn-danger">Previous</a>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
    <%  
       } else  if (myStep==3)
       {
         %>
    <div class="panel panel-primary">
        <div class="panel-heading">University Governance and Management
            <label class="pull-right">Step <%=myStep %> of <%=maxSteps %></label>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">
        <div runat="server" id="governanceFeedback"></div>
          <div class="row">
          <div class="row">
               <div class="col-md-6 col-lg-6">
                   <div class="panel panel-default">
                       <div class="panel-heading">
                           Names of Committees of University Council 
                       </div>
                       <div class="panel-body">
                           <div class="form-group">
                               <strong>Committee Name:</strong>
                               <div class="row">
                               <div class="col-md-8 col-lg-8 col-sm-9 col-xs-8">
                                  <asp:Textbox runat="server" CssClass="form-control" placeholder="Committee Name" ID="councilName"/> 
                               </div>
                                <div class="col-md-4 col-lg-4 col-sm-3 col-xs-4">
                                    <asp:LinkButton runat="server" CssClass="btn btn-success" ID="addCouncilCommittee" OnClick="addCouncilCommittee_Click">Add Committe</asp:LinkButton>
                                  
                                </div>
                                   </div>
                                 <hr/>
                               <table class="table table-bordered table-striped" id="dataTables-example3">
                                   <thead>
                                   <tr>
                                       <th>SN</th>
                                       <th>Committee Name</th>
                                   </tr>
                                   </thead>
                                   <tbody>
                                 <%
                                     var councilCommittes = nav.SARCommitteeComposition.Where(r => r.QA_No == qaNo&&r.Type=="Council"&&r.Category=="Committee");
                                       int councilCommittescounter = 0;
                                     foreach (var committee in councilCommittes)
                                     {
                                         councilCommittescounter++;
                                         %>
                                       <tr>
                                       <td><%=councilCommittescounter %></td>
                                       <td><%=committee.Description %></td>
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
          <div class="col-md-6 col-lg-6">
                   <div class="panel panel-default">
                       <div class="panel-heading">
                           Composition of the University Senate 
                       </div>
                       <div class="panel-body">
                           <div class="form-group">
                               <strong>Office Name:</strong>
                               <div class="row">
                               <div class="col-md-8 col-lg-8 col-sm-9 col-xs-8">
                                  <asp:Textbox runat="server" CssClass="form-control" placeholder="Office Name" ID="senateComposition"/> 
                               </div>
                                <div class="col-md-4 col-lg-4 col-sm-3 col-xs-4">
                                    <asp:LinkButton runat="server" CssClass="btn btn-success" ID="addSenateComposition" OnClick="addSenateComposition_Click">Add Office</asp:LinkButton>
                                  
                                </div>
                                   </div>
                                 <hr/>
                               <table class="table table-bordered table-striped" id="dataTables-example4">
                                   <thead>
                                   <tr>
                                       <th>SN</th>
                                       <th>Office</th>
                                   </tr>
                                   </thead>
                                   <tbody>
                                  <%
                                      var senateCompositionList = nav.SARCommitteeComposition.Where(r => r.QA_No == qaNo&&r.Type=="Senate"&&r.Category=="Composition");
                                        int senateCompositioncounter = 0;
                                      foreach (var committee in senateCompositionList)
                                      {
                                          senateCompositioncounter++;
                                         %>
                                       <tr>
                                       <td><%=senateCompositioncounter %></td>
                                       <td><%=committee.Description %></td>
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
              </div><div class="row">
                <div class="col-md-6 col-lg-6">
                   <div class="panel panel-default">
                       <div class="panel-heading">
                           Names of Committees of University Senate 
                       </div>
                       <div class="panel-body">
                           <div class="form-group">
                               <strong>Committee Name:</strong>
                               <div class="row">
                               <div class="col-md-8 col-lg-8 col-sm-9 col-xs-8">
                                  <asp:Textbox runat="server" CssClass="form-control" placeholder="Committee Name" ID="senateCommitteeName" /> 
                               </div>
                                <div class="col-md-4 col-lg-4 col-sm-3 col-xs-4">
                                    <asp:LinkButton runat="server" CssClass="btn btn-success" id="addSenateCommittee" OnClick="addSenateCommittee_Click">Add Committe</asp:LinkButton>
                                  
                                </div>
                               </div>
                                 <hr/>
                               <table class="table table-bordered table-striped" id="dataTables-example5">
                                   <thead>
                                   <tr>
                                       <th>SN</th>
                                       <th>Committee Name</th>
                                   </tr>
                                   </thead>
                                   <tbody>
                                  <%
                                      var senateCommittes = nav.SARCommitteeComposition.Where(r => r.QA_No == qaNo&&r.Type=="Senate"&&r.Category=="Committee");
                                       int senateCommittescounter = 0;
                                      foreach (var committee in senateCommittes)
                                      {
                                          senateCommittescounter++;
                                         %>
                                       <tr>
                                       <td><%=senateCommittescounter %></td>
                                       <td><%=committee.Description %></td>
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
          <div class="col-md-6 col-lg-6">
                   <div class="panel panel-default">
                       <div class="panel-heading">
                           Composition of the University Management Board (UMB) 
                       </div>
                       <div class="panel-body">
                           <div class="form-group">
                               <strong>Office Name:</strong>
                               <div class="row">
                               <div class="col-md-8 col-lg-8 col-sm-9 col-xs-8">
                                  <asp:Textbox runat="server" CssClass="form-control" placeholder="Office Name" ID="umbCompositionName"/> 
                               </div>
                                <div class="col-md-4 col-lg-4 col-sm-3 col-xs-4">
                                    <asp:LinkButton runat="server" CssClass="btn btn-success" ID="addUmbComposition" OnClick="addUmbComposition_Click">Add Office</asp:LinkButton>
                                  
                                </div>
                                   </div>
                                 <hr/>
                               <table class="table table-bordered table-striped" id="dataTables-example6">
                                   <thead>
                                   <tr>
                                       <th>SN</th>
                                       <th>Office</th>
                                   </tr>
                                   </thead>
                                   <tbody>
                                  <%
                                      var umbComposition = nav.SARCommitteeComposition.Where(r => r.QA_No == qaNo&&r.Type=="UMB"&&r.Category=="Composition");
                                        int umbCompositionCounter = 0;
                                      foreach (var committee in umbComposition)
                                      {
                                          umbCompositionCounter++;
                                         %>
                                       <tr>
                                       <td><%=umbCompositionCounter %></td>
                                       <td><%=committee.Description %></td>
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
                   </div><div class="row">
                     <div class="col-md-6 col-lg-6">
                   <div class="panel panel-default">
                       <div class="panel-heading">
                        Names of University Management Board (UMB) Committees 
                       </div>
                       <div class="panel-body">
                           <div class="form-group">
                               <strong>Committee Name:</strong>
                               <div class="row">
                               <div class="col-md-8 col-lg-8 col-sm-9 col-xs-8">
                                  <asp:Textbox runat="server" CssClass="form-control" placeholder="Committee Name" ID="umbCommitteeName"/> 
                               </div>
                                <div class="col-md-4 col-lg-4 col-sm-3 col-xs-4">
                                    <asp:LinkButton runat="server" CssClass="btn btn-success" ID="addUmbCommittee" OnClick="addUmbCommittee_Click">Add Committe</asp:LinkButton>
                                  
                                </div>
                                   </div>
                                 <hr/>
                               <table class="table table-bordered table-striped" id="dataTables-example9">
                                   <thead>
                                   <tr>
                                       <th>SN</th>
                                       <th>Committee Name</th>
                                   </tr>
                                   </thead>
                                   <tbody>
                                     <%
                                         var umbCommittess = nav.SARCommitteeComposition.Where(r => r.QA_No == qaNo&&r.Type=="UMB"&&r.Category=="Committee");
                                         int umbCommittessCounte = 0;
                                         foreach (var committee in umbCommittess)
                                         {
                                             umbCommittessCounte++;
                                         %>
                                       <tr>
                                       <td><%=umbCommittessCounte %></td>
                                       <td><%=committee.Description %></td>
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
            <div class="panel panel-primary">
                <div class="panel-heading" data-toggle="collapse" href="#boardOfTrustees">
                   Provide the current Members of University Board of Trustees (for Private Universities) <i class="pull-right">(Click to expand)</i><i class="clearfix"></i>
                </div>
                <div id="boardOfTrustees" class="panel-collapse collapse panel-body">
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <strong>Member Name:</strong>
                                <asp:Textbox runat="server" CssClass="form-control" placeholder="Member Name" ID="trusteeName"/>
                            </div>
                        </div>
                         <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <strong>Highest Academic Qualification:</strong>
                                <asp:DropDownList runat="server" CssClass="form-control" id="trusteeHighestAcademicQualification"/>
                            </div>
                        </div>
                         <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <strong>Date of Appointment:</strong>
                                <asp:Textbox runat="server" CssClass="form-control bootstrapdatepicker" placeholder="Date of Appointment" ID="trusteeDateOfAppointment"/>
                            </div>
                        </div>
                         <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <strong>Nationality:</strong>
                                <asp:DropDownList runat="server" CssClass="form-control" ID="trusteeNationality"/>
                            </div>
                        </div>
                         <div class="col-md-12 col-lg-12">
                            <div class="form-group">
                               
                                <asp:Button runat="server" CssClass="btn btn-success btn-block" text="Add Member" ID="addTrusteeMember" OnClick="addTrusteeMember_Click"/>
                            </div>
                        </div>
                    </div>
                    <table class="table table-bordered table-striped" id="dataTables-example7">
                        <thead>
                        <tr>
                            <th>SN</th>
                            <th>Name</th>
                            <th>Highest Academic Qualification</th>
                            <th>Date Appointment</th>
                            <th>Nationality</th>
                        </tr>
                        </thead>
                        <tbody>
<%--                        <%
                            var boardOfTrustees = nav.SARCommitteeComposition.Where(r => r.QA_No == qaNo&&r.Type=="Board of Trustees"&&r.Category=="Composition");
                            int boardoftrustee = 0;
                            foreach (var committee in boardOfTrustees)
                            {
                                boardoftrustee++;
                                         %>
                                       <tr>
                                       <td><%=boardoftrustee %></td>
                                       <td><%=committee.Description %></td>
                                       <td><%=committee.academicLevelName %></td>
                                       <td><%=committee.Date_of_Appointment%></td>
                                       <td><%=committee.countryName %></td>
                                   </tr>
                                             <%
                                     }
                                      %>--%>
                       
                        </tbody>
                    </table>
                </div>
            </div>
             
         <div class="panel panel-primary">
                <div class="panel-heading" data-toggle="collapse" href="#universityCouncil">
                 Members of University Council <i class="pull-right">(Click to minimize)</i><i class="clearfix"></i>
                </div>
                <div id="universityCouncil" class="panel-collapse panel-body">
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <strong>Member Name:</strong>
                                <asp:Textbox runat="server" CssClass="form-control" placeholder="Member Name" ID="councilMemberName"/>
                            </div>
                        </div>
                         <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <strong>Highest Academic Qualification:</strong>
                                <asp:DropDownList runat="server" CssClass="form-control" ID="councilHighestAcademic"/>
                            </div>
                        </div>
                         <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <strong>Date of Appointment:</strong>
                                <asp:Textbox runat="server" CssClass="form-control bootstrapdatepicker" placeholder="Date of Appointment" ID="councilDateOfAppointment"/>
                            </div>
                        </div>
                         <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <strong>Nationality:</strong>
                                <asp:DropDownList runat="server" CssClass="form-control" ID="councilNationality"/>
                            </div>
                        </div>
                         <div class="col-md-12 col-lg-12">
                            <div class="form-group">
                               <br/>
                                <asp:Button runat="server" CssClass="btn btn-success btn-block" text="Add Member" ID="councilAddMember" OnClick="councilAddMember_Click"/>
                            </div>
                        </div>
                    </div>
                    <table class="table table-bordered table-striped" id="dataTables-example8">
                        <thead>
                        <tr>
                            <th>SN</th>
                            <th>Name</th>
                            <th>Highest Academic Qualification</th>
                            <th>Date Appointment</th>
                            <th>Nationality</th>
                        </tr>
                        </thead>
                        <tbody>
<%--                        <%
                            var councilMembers = nav.SARCommitteeComposition.Where(r => r.QA_No == qaNo&&r.Type=="Council"&&r.Category=="Composition");
                              int councilMemberscounter = 0;
                            foreach (var committee in councilMembers)
                            {
                                councilMemberscounter++;
                                         %>
                                       <tr>
                                       <td><%=councilMemberscounter %></td>
                                       <td><%=committee.Description %></td>
                                       <td><%=committee.academicLevelName %></td>
                                       <td><%=committee.Date_of_Appointment %></td>
                                       <td><%=committee.countryName %></td>
                                   </tr>
                                             <%
                                     }
                                      %>--%>
                        
                        </tbody>
                    </table>
                </div>
            </div>
             
        </div>
        <div class="panel-footer">
            <div class="pull-right">
                <a href="InstitutionalQA.aspx?qa=<%=qaNo%>&step=<%=myStep+1 %>" class="btn btn-success">Next</a>
            </div>
            <div class="pull-left">
                <a href="InstitutionalQA.aspx?qa=<%=qaNo%>&step=<%=myStep-1 %>" class="btn btn-danger">Previous</a>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
    <%  
       } else  if (myStep==4)
       {
         %>
    <div class="panel panel-primary">
        <div class="panel-heading">Human Resources
            <label class="pull-right">Step <%=myStep %> of <%=maxSteps %></label>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">
        <div runat="server" id="hrSummaryFeedback"></div>
            <div class="panel panel-primary">
                <div class="panel-heading">(a)	Summary of the current number of Full Time Academic Staff</div>
                <div class="panel-body">
                    <label class="btn btn-success pull-right" data-toggle="modal" data-target="#addFullTime">Add Full Time Academic Staff</label>
                   
                    <div class="clearfix"></div>
                     <br/>
                    <table class="table table-bordered table-striped" id="dataTables-example13">
                        <thead>
                        <tr>
                            <th rowspan="2">SN </th>
                            <th rowspan="2">Category</th>
                             <th rowspan="2">No. Full Establishment</th>
                            <th colspan="2" style="text-align: center;">
                                No. In Post
                            </th>
                           
                        </tr>
                            <tr>
                                <th>Male</th>
                                <th>Female</th>
                            </tr>
                        </thead>
                        <tbody>
<%--                        <%
                            //Full-time Staff,Part-time Staff,Administrative Staff
                            var fullTimers = nav.HRSummary.Where(r => r.QA_No == qaNo && r.Type == "Full-time Staff");
                            int fullTimersCounter = 0;
                            foreach (var staff in fullTimers)
                            {
                                fullTimersCounter++;
                                %>
                            <tr>
                                <td><%= fullTimersCounter %></td>
                                <td><%= staff.categoryName %></td>
                                <td><%= staff.No_Full_Establishment %></td>
                                <td><%= staff.Male %></td>
                                <td><%= staff.Female %></td>
                            </tr>
                            <%
                            } %>--%>
                       
                        </tbody>
                    </table>
                </div>
               
            </div>
         
            <div class="panel panel-primary">
                <div class="panel-heading">
                    (b)	Summary of the current number of Part Time Academic Staff
                </div>
                <div class="panel-body">
                     <label class="btn btn-success pull-right" data-toggle="modal" data-target="#addPartTime">Add Part Time Staff</label>
                   
                    <div class="clearfix"></div>
                     <br/>
                    <table class="table table-bordered table-striped" id="dataTables-example10">
                        <thead>
                        <tr>
                            <th>SN</th>
                            <th>Category</th>
                            <th>Male</th>
                            <th>Female</th>
                        </tr>
                        </thead>
                        <tbody>
<%--                        <%
                            //Full-time Staff,,Administrative Staff
                            var partTimers = nav.HRSummary.Where(r => r.QA_No == qaNo && r.Type == "Part-time Staff");
                            int partTimerscounnter = 0;
                            foreach (var staff in partTimers)
                            {
                                partTimerscounnter++;
                                %>
                            <tr>
                                <td><%= partTimerscounnter%></td>
                                <td><%= staff.categoryName %></td>
                                <td><%= staff.Male %></td>
                                <td><%= staff.Female %></td>
                            </tr>
                            <%
                            } %>--%>
                        
                        </tbody>
                    </table>
                </div>
                 
            </div>
            <div class="panel panel-primary">
                <div class="panel-heading">
                    (c)	Summary of the current number of Administrative Staff
                </div>
                <div class="panel-body">
                      
                     <label class="btn btn-success pull-right" data-toggle="modal" data-target="#addAdministrativeStaffModal">Add Administrative Staff</label>
                   
                    <div class="clearfix"></div>
                     <br/>
                  <table class="table table-bordered table-striped" id="dataTables-example11">
                        <thead>
                        <tr>
                            <th>SN.</th>
                            <th>Category</th>
                            <th>Male</th>
                            <th>Female</th>
                        </tr>
                        </thead>
                        <tbody>
<%--                         <%
                             //Full-time Staff,,
                             var adminStaffers = nav.HRSummary.Where(r => r.QA_No == qaNo && r.Type == "Administrative Staff");
                             int adminStaffersCounter = 0;
                             foreach (var staff in adminStaffers)
                             {
                                 adminStaffersCounter++;
                                %>
                            <tr>
                                <td><%= adminStaffersCounter %></td>
                                <td><%= staff.categoryName %></td>
                                <td><%= staff.Male %></td>
                                <td><%= staff.Female %></td>
                            </tr>
                            <%
                            } %>--%>
                        </tbody>
                    </table>
                </div>
               
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    (d)	Number of Staff offered development and training in the last five years
                </div>
                <div class="panel-body"> 
                    <div class="form-group"><select class="form-control" id="staffTrainingType" style='display:none;'><option selected value="">Import Posts Data</option></select></div>
                    <div class="form-group"><input type="file" id="staffTrainingChooser" class="btn btn-fill btn-primary btn-large" /></div>
                    <div id="staffTrainingOutput"></div>
                     <label class="btn btn-success pull-right" data-toggle="modal" data-target="#staffDevelopmentAndTraining">Add Staff Development & Training</label>
                   
                    <div class="clearfix"></div>
                     <br/>
                    <table class="table table-bordered table-striped" id="dataTables-example12">
                        <thead>
                        <tr>
                            <th>SN</th>
                            <th>Type of Training</th>
                            <th>Year</th>
                            <th>Male</th>
                            <th>Female</th>
                        </tr>
                        </thead>
                        <tbody>
<%--                        <%
                            var trainigs = nav.TrainingDevelopment.Where(r => r.QA_No == qaNo);
                            int trainigsCounter = 0;
                            foreach (var training in trainigs)
                            {
                                trainigsCounter++;
                                %>
                            <tr>
                                <td><% =trainigsCounter%></td>
                                <td><% =training.TrainingName %></td>
                                <td><% =training.Year %></td>
                                <td><% =training.Male %></td>
                                 <td><% =training.Female %></td>
                            </tr>
                            <%

                            }
                             %>
                      --%>
                        </tbody>
                    </table>
                   
                </div>
               
            </div>
        </div>
        <div class="panel-footer">
            <div class="pull-right">
                <a href="InstitutionalQA.aspx?qa=<%=qaNo%>&step=<%=myStep+1 %>" class="btn btn-success">Next</a>
            </div>
            <div class="pull-left">
                <a href="InstitutionalQA.aspx?qa=<%=qaNo%>&step=<%=myStep-1 %>" class="btn btn-danger">Previous</a>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
    <%  
       } else  if (myStep==5)
       {
         %>
    <div class="panel panel-primary">
        <div class="panel-heading">Revenue and Financial Management
            <label class="pull-right">Step <%=myStep %> of <%=maxSteps %></label>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">
        <div id="revenueFeedback" runat="server"></div>
         <div class="panel panel-primary">
             <div class="panel-heading">
                 (i)	Sources of income in KShs. Millions (expected and actual) for the last five years?
             </div>
             <div class="panel-body">
                 <div class="form-group"><select class="form-control" id="sourceOfIncomeType" style='display:none;'><option selected value="">Import Posts Data</option></select></div>
<div class="form-group"><input type="file" id="sourceOfIncomeChooser" class="btn btn-fill btn-primary btn-large" /></div>
<div id="sourceOfIncomeOutput"></div>
                 <label class="btn btn-success pull-right" data-toggle="modal" data-target="#sourcesOfIncome">Add Sources of Income</label>
                   
                    <div class="clearfix"></div>
                     <br/>
                 
                 <table class="table table-bordered table-striped" id="dataTables-example14">
                     <thead>
                     <tr>
                         <th>#</th>
                         <th>Source of Income</th>
                         <th>Year</th>
                         <th>Actual</th>
                         <th>Expected</th>
                     </tr>
                        
                     </thead>
                     <tbody>
                         <%--
                     <%
                         var incomes = nav.SourcesOfIncome.Where(r => r.QA_No == qaNo);
                         int incomesCounter = 0;
                         foreach (var income in incomes)
                         {
                             incomesCounter++;
                             %>
                         <tr>
                             <td><% =incomesCounter %></td>
                             <td><% =income.incomedescription %></td>
                             <td><% =income.Year %></td>
                             <td><% =income.Actual %></td>
                              <td><% =income.Expected %></td>
                         </tr>
                         <%
                         }
                         %>
                    --%>
                     </tbody>
                 </table>
             </div>
            
         </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    (ii) List of University Creditors (indicating amounts) per year for the last five years
                </div>
                <div class="panel-body">
                    <div class="form-group"><select class="form-control" id="creditorType" style='display:none;'><option selected value="">Import Posts Data</option></select></div>
<div class="form-group"><input type="file" id="creditorChooser" class="btn btn-fill btn-primary btn-large" /></div>
<div id="creditorOutput"></div>
                    <label class="btn btn-success pull-right" data-toggle="modal" data-target="#universityCreditors">Add University Creditors</label>
                   
                    <div class="clearfix"></div>
                     <br/>
                    <table class="table table-bordered table-striped" id="dataTables-example15">
                        <thead>
                            <tr>
                                <th>SN</th>
                                <th>University Creditors</th>
                                <th>Year</th>
                                <th>Amount</th>
                            </tr>
                           
                        </thead>
                        <tbody>
<%--                        <%
                            var creditors = nav.CreditorsDebtors.Where(r => r.QA_No == qaNo&&r.Type=="Creditors");
                            int creditorsCounter = 0;
                            foreach (var creditor in creditors)
                            {
                                creditorsCounter++;
                                %>
                            <tr>
                            <td><% = creditorsCounter%></td>
                            <td><% = creditor.Description %></td>
                            <td><% = creditor.Year %></td>
                            <td><% = creditor.Amount %></td>
                        </tr>
                            <%
                            }
                             %>
                       --%>
                        </tbody>
                    </table>
                </div>
                
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    (iii) List of University debtors (including amounts per category) per year for the last five years
                </div>
                <div class="panel-body">
                    <label class="btn btn-success pull-right" data-toggle="modal" data-target="#universityDebtors">Add University Debtors</label>
                   
                    <div class="clearfix"></div>
                     <br/>
                    <table class="table table-bordered table-striped" id="dataTables-example16">
                        <thead>
                            <tr>
                                <th>SN</th>
                                <th>University Debtors</th>
                                <th>Year</th>
                                <th>Amount</th>
                            </tr>
                        </thead>
                        <tbody>
<%--                        <%
                            var debtors = nav.CreditorsDebtors.Where(r => r.QA_No == qaNo&&r.Type=="Debtors");
                            int debtorCounter = 0;
                            foreach (var debtor in debtors)
                            {
                                debtorCounter++;
                                %>
                            <tr>
                            <td><% = debtorCounter %></td>
                            <td><% = debtor.Description %></td>
                            <td><% = debtor.Year %></td>
                            <td><% = debtor.Amount %></td>
                        </tr>
                            <%
                            }
                             %>--%>
                        </tbody>
                    </table>
                </div>
               
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    (iv) The University operation budget and actual expenditure per year for the last five years 
                </div>
                <div class="panel-body">
                     <label class="btn btn-success pull-right" data-toggle="modal" data-target="#operationBudgetModal">Add Entries</label>                   
                    <div class="clearfix"></div>
                     <br/>
                    <table class="table table-bordered table-striped" id="dataTables-example17">
                        <thead>
                        <tr>
                             <th>#</th>
                            <th>Year</th>
                            <th>Operation Budget</th>
                            <th>Actual Expenditure</th>
                        </tr>
                        </thead>
                        <tbody>
<%--                        <%
                            var budgetActuals = nav.BudgetAndActual.Where(r => r.QA_No == qaNo&&r.Type=="Operation Budget");
                            int budgetActualsCounter = 0;
                            foreach (var budgetActual in budgetActuals)
                            {
                                budgetActualsCounter++;
                                %>
                            <tr>
                                <td><%=budgetActualsCounter%></td>
                                <td><%=budgetActual.year %></td>
                                <td><%=budgetActual.Budget_Allocation %></td>
                                <td><%=budgetActual.Actual_Expenditure %></td>
                            </tr>
                            <%
                             }
                        %>
                       --%>
                        </tbody>
                    </table>
                </div>
                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Save University Operation Budget and Actual Expenditure" ID="saveOperationBudget" OnClick="saveOperationBudget_Click"/>
                 <div class="clearfix"></div>
                </div>
            </div>
            <div class="panel panel-primary">
                <div class="panel-heading">
                   (v) Total Debt, Total Equity, Current Assets and Current Liabilities per year for the last five years
                </div>
                <div class="panel-body">
                     <label class="btn btn-success pull-right" data-toggle="modal" data-target="#debtEquityAssetsLiabilitiesModal">Add Entries</label>                   
                    <div class="clearfix"></div>
                     <br/>
                    <table class="table table-bordered table-striped" id="dataTables-example18">
                        <thead>
                        <tr>
                            <th>Year</th>
                            <th>Total Debt</th>
                            <th>Total Equity</th>
                            <th>Current Assets</th>
                            <th>Current Liabilities</th>
                        </tr>
                        </thead>
                        <tbody>
<%--                         <%
                             var debts = nav.BudgetAndActual.Where(r => r.QA_No == qaNo&&r.Type=="Debt Equity Assets Liabilities");
                             foreach (var budgetActual in debts)
                             {
                                %>
                            <tr>
                                <td><%=budgetActual.year %></td>
                                <td><%=budgetActual.Debt %></td>
                                <td><%=budgetActual.Equity %></td>
                                <td><%=budgetActual.Current_Assets %></td>
                                <td><%=budgetActual.Current_Liabilities %></td>
                            </tr>
                            <%
                             }
                        %>
                       --%>
                        </tbody>
                    </table>
                </div>
                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Save Details" id="addDebtEuityAssetsLiabilities" OnClick="addDebtEuityAssetsLiabilities_Click"/>
                    <div class="clearfix"></div>
                </div>
            </div>
            

             <div class="panel panel-default">
                <div class="panel-heading">
                    (vi) Budgetary allocation for Research and actual expenditure per year for the last five years
                </div>
                <div class="panel-body">
                     <label class="btn btn-success pull-right" data-toggle="modal" data-target="#researchBudgetaryAllocationModal">Add Entries</label>                   
                    <div class="clearfix"></div>
                     <br/>
                    <table class="table table-bordered table-striped" id="dataTables-example19">
                        <thead>
                        <tr>
                            <th>Year</th>
                            <th>Budgetary Allocation </th>
                            <th>Actual Expenditure</th>
                        </tr>
                        </thead>
                        <tbody>
<%--                        <%
                             var research = nav.BudgetAndActual.Where(r => r.QA_No == qaNo&&r.Type=="Research Budgetary Allocation");
                             foreach (var budgetActual in research)
                             {
                                %>
                            <tr>
                                <td><%=budgetActual.year %></td>
                                <td><%=budgetActual.Budget_Allocation %></td>
                                <td><%=budgetActual.Actual_Expenditure %></td>
                            </tr>
                            <%
                             }
                        %>--%>
                        </tbody>
                    </table>
                </div>
                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Save Budgetary Allocation for Research" ID="saveResearchAllocation" OnClick="saveResearchAllocation_Click"/>
                 <div class="clearfix"></div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    (vii) The amount of money attracted for Research in the University per year for the last five years
                </div>
                <div class="panel-body">
                     <label class="btn btn-success pull-right" data-toggle="modal" data-target="#researchAttractedModal">Add Entries</label>                   
                    <div class="clearfix"></div>
                     <br/>
                    <table class="table table-bordered table-striped">
                        <thead>
                        <tr>
                            <th>Year</th>
                            <th>Budgetary Allocation </th>
                            <th>Actual Expenditure</th>
                        </tr>
                        </thead>
                        <tbody>
<%--                         <%
                             var researchAttracted = nav.BudgetAndActual.Where(r => r.QA_No == qaNo&&r.Type=="Money Attracted for Research");
                             foreach (var budgetActual in researchAttracted)
                             {
                                %>
                            <tr>
                                <td><%=budgetActual.year %></td>
                                <td><%=budgetActual.Budget_Allocation %></td>
                                <td><%=budgetActual.Actual_Expenditure %></td>
                            </tr>
                            <%
                             }
                        %>--%>
                        </tbody>
                    </table>
                </div>
                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Save Money Attracted for Research" OnClick="ResearchAttracted_Click"/>
                 <div class="clearfix"></div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                   (viii)	Library budgetary allocation and actual expenditure per year for the last five years
                </div>
                <div class="panel-body">
                     <label class="btn btn-success pull-right" data-toggle="modal" data-target="#libraryBudgetaryAllocationModal">Add Entries</label>                   
                    <div class="clearfix"></div>
                     <br/>
                    <table class="table table-bordered table-striped" id="dataTables-example20">
                        <thead>
                        <tr>
                            <th>Year</th>
                            <th>Budgetary Allocation </th>
                            <th>Actual Expenditure</th>
                        </tr>
                        </thead>
                        <tbody>
<%--                        <%
                             var library = nav.BudgetAndActual.Where(r => r.QA_No == qaNo&&r.Type=="Library Budgetary Allocation");
                             foreach (var budgetActual in library)
                             {
                                %>
                            <tr>
                                <td><%=budgetActual.year %></td>
                                <td><%=budgetActual.Budget_Allocation %></td>
                                <td><%=budgetActual.Actual_Expenditure %></td>
                            </tr>
                            <%
                             }
                        %>--%>
                        </tbody>
                    </table>
                </div>
                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Save Library Budgetary Allocation" ID="saveLibrary" OnClick="saveLibrary_Click"/>
                 <div class="clearfix"></div>
                </div>
            </div>
           <div class="panel panel-default">
                <div class="panel-heading">
                   (ix)	Allocation and actual expenditure per year for the last five years
                </div>
                <div class="panel-body">
                     <label class="btn btn-success pull-right" data-toggle="modal" data-target="#allocationActualModal">Add Entries</label>                   
                    <div class="clearfix"></div>
                     <br/>
                    <table class="table table-bordered table-striped" id="dataTables-example21">
                        <thead>
                        <tr>
                            <th>Year</th>
                            <th>Budgetary Allocation </th>
                            <th>Actual Expenditure</th>
                        </tr>
                        </thead>
                        <tbody>
<%--                       <%
                             var allocationActual = nav.BudgetAndActual.Where(r => r.QA_No == qaNo&&r.Type=="Allocation and Actual Expenditure");
                             foreach (var budgetActual in allocationActual)
                             {
                                %>
                            <tr>
                                <td><%=budgetActual.year %></td>
                                <td><%=budgetActual.Budget_Allocation %></td>
                                <td><%=budgetActual.Actual_Expenditure %></td>
                            </tr>
                            <%
                             }
                        %>--%>
                        </tbody>
                    </table>
                </div>
                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Save Allocation and Actual Expenditure" ID="saveAllocationActual" OnClick="saveAllocationActual_Click"/>
                 <div class="clearfix"></div>
                </div>
            </div>
           
        </div>
        <div class="panel-footer">
            <div class="pull-right">
                <a href="InstitutionalQA.aspx?qa=<%=qaNo%>&step=<%=myStep+1 %>" class="btn btn-success">Next</a>
            </div>
            <div class="pull-left">
                <a href="InstitutionalQA.aspx?qa=<%=qaNo%>&step=<%=myStep-1 %>" class="btn btn-danger">Previous</a>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
    <%  
       }  else  if (myStep==6)
       {
         %>
    <div class="panel panel-primary">
        <div class="panel-heading">Educational Activities
            <label class="pull-right">Step <%=myStep %> of <%=maxSteps %></label>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">
            <h3>(a)	Academic Programmes</h3>
            <div runat="server" id="academicProgrammesFeedback"></div>
         <div class="panel panel-primary">
             <div class="panel-heading">(i)	List of all Academic Programmes with status of accreditation (specify Senate approved, CUE accredited), and Academic Qualification of Academic Leader</div>
             <div class="panel-body">
           <label class="btn btn-success pull-right" data-toggle="modal" data-target="#academicProgramme">Add Academic Programme</label>
                <div class="clearfix"></div>
                 <br/>
                 <table class="table table-bordered table-striped" id="dataTables-example22">
                     <thead>
                     <tr>
                         <th>SN.</th>
                         <th>Programme</th>
                         <th>Status of Accreditation</th>
                         <th>Highest Academic Qualification of Academic Leader</th>
                         <th>Duration of Programme in Months</th>
                     </tr>
                     </thead>
                     <tbody>
<%--                     <%
                         var programmes = nav.QAAcademicProgrammes;
                         int programmescounter = 0;
                         foreach (var program in programmes)
                         {
                             programmescounter++;
                             %>
                          <tr>
                         <td><% =programmescounter%></td>
                         <td><% =program.Programme %></td>
                         <td><% =program.Status_of_Accreditation %></td>
                         <td><% =program.Level_Name %></td>
                         <td><% =program.Programme_Duration %></td>
                     </tr>
                                 <%
                         }
                         %>--%>
                    
                     </tbody>
                 </table>
             </div>
         </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    (ii)	Summary of Academic Programmes per category (Diploma, Bachelors, Post graduate diploma, Masters, PhD) per school/faculty/institute
                </div>
                <div class="panel-body">
                     <label class="btn btn-success pull-right" data-toggle="modal" data-target="#academicProgrammesPerSchool">Add Entry</label>
                <div class="clearfix"></div>
                 <br/>
                    <table class="table table-bordered table-striped" id="dataTables-example23">
                        <thead>
                        <tr>
                             <th>#</th>
                            <th>School/Faculty/Institute</th>
                            <th>PHD</th>
                            <th>Masters</th>
                            <th>Postgraduate Diploma</th>
                            <th>Bachelors</th>
                            <th>Diploma</th>
                            <th>Certificate</th>
                        </tr>
                        </thead>
                        <tbody>
<%--                        <%
                            var summaries = nav.QAAccProgrammesPerCategory;
                            int summariesCounter = 0;
                            foreach (var summary in summaries)
                            {
                                summariesCounter++;
                                %>
                             <tr>
                             <td><%=summariesCounter %></td>
                            <td><%=summary.School_Faculty_Institute %></td>
                             <td><%=summary.PHD %></td>
                             <td><%=summary.Masters %></td>
                             <td><%=summary.Post_Graduate_Diploma %></td>
                             <td><%=summary.Bachelors %></td>
                             <td><%=summary.Diploma %></td>
                             <td><%=summary.Certificate %></td>
                        </tr> 
                            <%
                            } %>
                        
                           --%>
                        </tbody>
                    </table>
                </div>
                
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    (iv) Academic Programmes offered under collaboration per School/Faculty/ Institute
                </div>
                <div class="panel-body">
                    
                      <label class="btn btn-success pull-right" data-toggle="modal" data-target="#academicProgrammeCollaboration">Add Programme</label>
                <div class="clearfix"></div>
                 <br/>
                    <table class="table table-bordered table-striped" id="dataTables-example24">
                        <thead>
                        <tr>
                            <th>#</th>
                            <th>School/Faculty/Institute</th>
                            <th>Academic Programme</th>
                            <th>Collaborating Institution</th>
                        </tr>
                        </thead>
                        <tbody>
<%--                        <%
                            var programs = nav.QAAcademicProgrammes;
                            int programsCounter = 0;
                            foreach (var program in programs)
                            {

                                programsCounter++;
                             %>
                          <tr>
                         <td><% =programsCounter %></td>
                         <td><% =program.School_Name %></td>
                         <td><% =program.Programme %></td>
                         <td><% =program.Collaborating_Institution %></td>
                     </tr>
                                 <%
                         }
                         %>--%>
                        </tbody>
                    </table>
                </div>
            </div>
            <h3>(b)	Student Admission/Enrollment</h3>
            <div class="panel panel-default">
                <div class="panel-heading">(i)	Student enrollment per Academic Programme, per year, by gender </div>
                <div class="panel-body">
                    <div class="form-group">
                        <p>Kindly upload the student errollment per academic programmme, per year, by gender details</p>
                        <strong>Upload Excel Sheet:</strong>
                        <asp:FileUpload runat="server"/>
                    </div>
                    
                    <table class="table table-bordered table-striped" id="dataTables-example25">
                        <thead>
                        <tr>
                            <th rowspan="2">Academic Programme</th>
                            <th colspan="2" style="text-align: center"><% =DateTime.Now.Year-4 %></th>
                            <th colspan="2" style="text-align: center"><% =DateTime.Now.Year-3 %></th>
                            <th colspan="2" style="text-align: center"><% =DateTime.Now.Year-2 %></th>
                            <th colspan="2" style="text-align: center"><% =DateTime.Now.Year-1 %></th>
                            <th colspan="2" style="text-align: center"><% =DateTime.Now.Year %></th>
                        </tr>
                            <tr>
                                <th>M</th>
                                <th>F</th>
                                <th>M</th>
                                <th>F</th>
                                <th>M</th>
                                <th>F</th>
                                <th>M</th>
                                <th>F</th>
                                <th>M</th>
                                <th>F</th>
                            </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>Bachelor of Science(Computer Science)</td>
                            <td>10</td>
                            <td>10</td>
                            <td>10</td>
                            <td>10</td>
                            <td>10</td>
                            <td>10</td>
                            <td>10</td>
                            <td>10</td>
                            <td>10</td>
                            <td>10</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    (ii)	Summary of Number of Kenyans and International Students enrolled in the University by category
                </div>
                <div class="panel-body">
                      <label class="btn btn-success pull-right" data-toggle="modal" data-target="#kenyaInternationalSummary">Add Summary</label>
                <div class="clearfix"></div>
                 <br/>
                    <table class="table table-bordered table-striped" id="dataTables-example26">
                        <thead>
                        <tr>
                            <th>SN</th>
                            <th>Level</th>
                            <th>Kenyan Students</th>
                            <th>International Students</th>
                        </tr>
                        </thead>
                        <tbody>
                        <% var students = nav.KenyanInternational.Where(r => r.Qa_No == qaNo);
                            int studentscounter = 0;
                            foreach (var student in students)
                            {
                                studentscounter++;
                               %>
                            <tr>
                            <td><%=studentscounter %></td>
                            <td><%=student.Academic_Level_Name %></td>
                            <td><%=student.No_of_Kenyan_Students %></td>
                            <td><%=student.No_of_International_Students %></td>
                        </tr> 
                                    <%
                           }
                            
                             %>
                       
                        </tbody>
                    </table>
                </div>
                <div class="panel-footer">
                     <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Save Student Summary"/>
                 <div class="clearfix"></div>
                </div>
            </div>
            
            <div class="panel panel-default">
                <div class="panel-heading">Government and Privately sponsored students </div>
                <div class="panel-body">
                    <table class="table table-bordered table-striped" id="dataTables-example27">
                        <thead>
                        <tr>
                            <th>SN</th>
                            <th>Sponsorship</th>
                            <th><% = DateTime.Now.Year-4 %></th>
                            <th><% = DateTime.Now.Year-3 %></th>
                            <th><% = DateTime.Now.Year-2 %></th>
                            <th><% = DateTime.Now.Year-1 %></th>
                            <th><% = DateTime.Now.Year %></th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>1</td>
                            <td>Government sponsored students</td>
                             <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                             <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                             <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                             <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                             <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                        </tr>
                            <tr>
                            <td>2</td>
                            <td>Privately sponsored students</td>
                             <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                             <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                             <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                             <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                             <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="panel-footer">
                      <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Save Student Sponsorship"/>
                 <div class="clearfix"></div>
                </div>
            </div>
            <h3>(c)	Student Assessment</h3>
            
            <div class="panel panel-default">
                <div class="panel-heading">Student Assessment</div>
                <div class="panel-body">
            <div class="form-group">
                <strong>(iii)	Do students have online access to examinations results? </strong>
                <i>(Tick if yes)</i> <asp:Checkbox runat="server"/>
            </div>
            <div class="form-group">
                <strong>(iv)	If Yes in 7 (c) (iii) above, how long after the examinations?  </strong> <br/>
                 <asp:Checkbox runat="server" Text="3 Months "/>
                 <asp:Checkbox runat="server" Text="6 Months "/>
                 <asp:Checkbox runat="server" Text="9 Months "/>
                 <asp:Checkbox runat="server" Text="12 Months "/>
            </div> 
            <div class="form-group">
                <strong>(v)	Is PhD graduation pegged on publication(s)? </strong>
                <i>(Tick if yes)</i> <asp:Checkbox runat="server"/>
            </div>
            <div class="form-group">
                <strong>(vi)	If Yes in 7 (c) (v), how many publications?  </strong> <br/>
                 <asp:Checkbox runat="server" Text="1 Publication"/>
                 <asp:Checkbox runat="server" Text="2 Publications"/>
                 <asp:Checkbox runat="server" Text="3 Publications"/>
                 <asp:Checkbox runat="server" Text="Above 3 Publications"/>
            </div>
            
            </div>
                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Save Student Assessment"/>
                 <div class="clearfix"></div>
                </div>
               
            </div>
             <h3>(d)	Quality of (Academic) Staff</h3>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        (i)	Age brackets of Staff per category (Professors, Associate Professors, Senior Lecturers, Tutorial fellows, Graduate Assistants, Technicians/Technologists, Research Staff)
                    </div>
                    <div class="panel-body">
                        <div id="feedback" style="display: none"></div>
                             <label class="btn btn-success pull-right" data-toggle="modal" data-target="#qualityOfAcademicStaff">Add Category</label>
                     <div class="clearfix"></div>
                         <br/>
                        
                        <table class="table table-bordered table-striped" id="dataTables-example28">
                            <thead>
                            <tr>
                                <th rowspan="2">Category</th>
                                <th colspan="5" style="text-align: center;">Age bracket</th>
                            </tr>
                                <tr>
                                    <th>20-29</th>
                                    <th>30-39</th>
                                    <th>40-49</th>
                                    <th>50-59</th>
                                    <th>60 and Above</th>
                                </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>Professor</td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                            </tr>
                                <tr>
                                <td>Associate Professor</td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                            </tr> <tr>
                                <td>Senior Lecturer/ Senior Research Fellow</td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                            </tr> <tr>
                                <td>Lecturer/Research Fellow</td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                            </tr> <tr>
                                <td>Tutorial Fellow/Junior Research Fellow</td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                            </tr><tr>
                                <td>Graduate Assistant/Research Assistant</td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                            </tr><tr>
                                <td>Technicians/Technologists</td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                                <td><asp:Textbox runat="server" CssClass="form-control" TextMode="Number"/></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="panel-footer">
                         <asp:Button runat="server" CssClass="btn btn-success pull-right btnInsertQAStaff" Text="Save Staff Age Brackets" id="addQAstaff"/>
                 <div class="clearfix"></div>
                    </div>
                </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    (iii) On Staff Appraisal:
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <strong>Are the Staff Appraised: </strong>
                        <br/>
                        <ol>
                            <li>By Students <i>(Tick if yes)</i> <asp:Checkbox runat="server"/></li>
                            <li>By Fellow Staff <i>(Tick if yes)</i> <asp:Checkbox runat="server"/></li>
                            <li>By Management  <i>(Tick if yes)</i> <asp:Checkbox runat="server"/></li>
                        </ol>
                    </div>
                    <div class="form-group">
                        <strong>How often are Staff Appraised? </strong>
                        <br/>
                        <asp:Checkbox runat="server" text="Monthly"/>
                        <asp:Checkbox runat="server" text="Quarterly"/>
                        <asp:Checkbox runat="server" text="Bi annually"/>
                        <asp:Checkbox runat="server" text="Annually"/>
                    </div>
                    <div class="form-group">
                        <strong>Do students evaluate course and Instructor? </strong>
                        <i>(Check if yes)</i> <asp:Checkbox runat="server"/>
                    </div> 
                    <div class="form-group">
                        <strong>Are staff given Appraisal feedback? </strong>
                        <i>(Check if yes)</i> <asp:Checkbox runat="server"/>
                    </div>
                </div>
                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Save Staff Appraisal"/>
                 <div class="clearfix"></div>
                </div>
            </div>
            

             </div>
        <div class="panel-footer">
            <div class="pull-right">
                <a href="InstitutionalQA.aspx?qa=<%=qaNo%>&step=<%=myStep+1 %>" class="btn btn-success">Next</a>
            </div>
            <div class="pull-left">
                <a href="InstitutionalQA.aspx?qa=<%=qaNo%>&step=<%=myStep-1 %>" class="btn btn-danger">Previous</a>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
    <%  
       } else  if (myStep==7)
       {
         %>
    <div class="panel panel-primary">
        <div class="panel-heading">Achievements/Outcomes
            <label class="pull-right">Step <%=myStep %> of <%=maxSteps %></label>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">
         <div class="panel panel-primary">
             <div class="panel-heading">
                 (a) University Graduation Statistics per year for the last five years
             </div>
             <div class="panel-body">
                 <table class="table table-bordered table-striped">
                     <thead>
                     <tr>
                         <th>Year</th>
                         <th>PHD</th>
                         <th>Masters</th>
                         <th>PGD</th>
                         <th>Bachelor</th>
                         <th>Diploma</th>
                         <th>Certificate</th>
                     </tr>
                     </thead>
                     <tbody>
                     <tr>
                         <td>2016</td>
                         <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                         <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                         <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                         <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                         <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                         <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                     </tr><tr>
                         <td>2017</td>
                         <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                         <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                         <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                         <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                         <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                         <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                     </tr><tr>
                         <td>2018</td>
                         <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                         <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                         <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                         <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                         <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                         <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                     </tr><tr>
                         <td>2019</td>
                         <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                         <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                         <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                         <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                         <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                         <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                     </tr><tr>
                         <td>2020</td>
                         <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                         <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                         <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                         <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                         <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                         <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                     </tr>
                     </tbody>
                 </table>
                 <!-- Year (specify)	Category
	PhD	Masters	PGD	Bachelor	Diploma	Certificate	Total
 -->
             </div>
             <div class="panel-footer">
                 <asp:Button runat="server" CssClass ="btn btn-success pull-right" Text="Save Details"/>
                 <div class="clearfix"></div>
             </div>
         </div>
            
            
        </div>
        <div class="panel-footer">
            <div class="pull-right">
                <a href="InstitutionalQA.aspx?qa=<%=qaNo%>&step=<%=myStep+1 %>" class="btn btn-success">Next</a>
            </div>
            <div class="pull-left">
                <a href="InstitutionalQA.aspx?qa=<%=qaNo%>&step=<%=myStep-1 %>" class="btn btn-success">Previous</a>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
    <%  
       } else  if (myStep==8)
       {
         %>
    <div class="panel panel-primary">
        <div class="panel-heading">Colleges, Campuses and Collaborating Institutions
            <label class="pull-right">Step <%=myStep %> of <%=maxSteps %></label>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">
           
         <!-- SN Name of College or Campus	Year Established	Accreditation Status -->
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Name of college or Campus</strong>
                        <asp:Textbox runat="server" CssClass="form-control" placeholder="Name of college or Campus"/>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Year Established</strong>
                        <asp:Textbox runat="server" CssClass="form-control" placeholder="Year Established"/>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Accreditation Status</strong>
                        <asp:DropDownList runat="server" CssClass="form-control" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <br/>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Add College or Campus"/>
                    </div>

            </div>
            <table class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>SN</th>
                    <th>Name of College or Campus</th>
                    <th>Year Established</th>
                    <th>Accreditation Status</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>1</td>
                    <td>Machakos Campus</td>
                    <td>2017</td>
                    <td>CUE Accredited</td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="panel-footer">
            <div class="pull-right">
                <!--<a href="InstitutionalQA.aspx?step=" class="btn btn-success">Next</a>-->
            </div>
            <div class="pull-left">
                <a href="InstitutionalQA.aspx?qa=<%=qaNo%>&step=<%=myStep-1 %>" class="btn btn-success">Previous</a>
            </div><div class="pull-right">
                <a href="InstitutionalQA.aspx?qa=<%=qaNo%>&step=<%=myStep+1 %>" class="btn btn-success">Next</a>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
    <%  
       } else if (myStep == 9)
       {
            %>
  <div class="panel panel-primary">
      <div class="panel-heading">RATING OF QUALITY OF THE UNIVERSITY 
          
          <label class="pull-right">Step <%=myStep %> of <%=maxSteps %></label>
            <div class="clearfix"></div>
      </div>
      <div class="panel-body">
           <table class="table table-bordered table-striped">
          <thead>
          <tr>
          <th>Item/Area</th>
          <th>1</th>
          <th>2</th>
          <th>3</th>
          <th>4</th>
          <th>5</th>
          <th>6</th>
          <th>7</th>
              </tr>
          </thead>
<tr><td>1. Requirements of stakeholders	</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
i.	The university has a clear idea about the relevant demands and needs of the government. </td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>							
ii.	The university has a clear idea about the  relevant demands and needs of the labour  market	</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>						
iii.	The university has a clear idea about the  relevant demands and needs of the students/parents</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>							
iv.	The university has a clear idea about the  relevant demands and needs of the academic world	</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>						
Overall opinion	</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
2.	Mission, Vision, Goals and Aims		</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>					
i.	The university has a clearly formulated mission statement</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td> 							
ii.	The mission statement is publicly known </td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>							
iii.	The mission statement is in line with the academic and social context</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>							
iv.	The university has a clear vision on its role in society.</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>							
Overall opinion			</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>				
3.	The Policy Plan		</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>					
i.	The university has a clear policy and strategic plan formulated in line with the mission statement.							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
ii.	The policy has adequately  been translated in a strategic plan 							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
iii.	The policy plan regulates clearly the programmes at offer, the research and the community outreach							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
Overall opinion							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
4.	Governance and Management of the University							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
i.	The governance structure of the university is clear and adequate							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
ii.	The university has a clear management structure in which the decision-making processes, competencies and responsibilities have been clearly defined.							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
Overall opinion							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
5.	Human resources							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
i.	The university takes care of high-quality faculty staff and support staff  by clearly defining their responsibility, and by evaluating their performance on a regular basis by means of  an adequate staff appraisal system 							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
ii.	The university develops the body of knowledge possessed by its academics and support staff to keep pace with changes in each academic discipline.							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
iii.	The university  provides for a system of staff development 							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
iv.	The university establishes an activity plan and evaluates activities to encourage students, academics and other staff to be conscientious in thoughts and, speech.  							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
v.	The university enhances the professional ethics of its students, academics and other personnel							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
Overall opinion							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
6.	Funding and Financial Management							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
i.	The university has adequate funding to achieve the goals and aims.							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
ii.	The university has an adequate financial management system.							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
Overall opinion							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
7.	Educational Activities							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
i.	The programmes at offer meet the expectations of the stakeholders							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
ii.	The programmes have clearly formulated learning outcomes							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
iii.	The programmes are coherent and up to date							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
iv.	The student assessment is adequate and  efficient							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
v.	The student assessment is objective and trustworthy							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
vi.	Student assessment is consistent in time and between the programmes							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
vii.	Student assessment is done according a variety of methods							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
viii.	The examination committees function adequately							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
ix.	The staff is competent and qualified							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
x.	Recruitment and promotion of staff is based on merit system, including teaching, research and community outreach							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
xi.	The university has a well-functioning appraisal system							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
xii.	The university has clearly formulated admission criteria 							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
xiii.	If there is a selection, the procedure and criteria are clear, adequate and transparent</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
						
xiv.	Facilities and infrastructure are sufficient and adequate</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>							
xv.	Facilities and infrastructure are up-to date							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
xvi.	The computer facilities are adequate 							
Overall opinion							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
8.	Research 							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
i.	The university has a clear research policy, setting the direction of research and deciding about research profile and research activities							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
ii.	The university has a clear policy, for the protection of creative efforts and especially for the protection of economic investment in creative efforts (Intellectual Property Right Policy).							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
iii.	The university has a clear code of conduct for research, including a code of ethics. 							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
Overall opinion							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
9.	Community Outreach							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
The university has clear guidelines on consultancy and community outreach							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
Overall opinion							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
10.	Benchmarking							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
The university uses the instrument of benchmarking for analysing the quality of its core activities and its management.							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
Overall opinion							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
11.	Quality Assurance							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
i.	The university has a clear policy and procedures for QA							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
ii.	The university has an adequate monitoring system							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
iii.	There is a periodic review of the core activities (education, research and community services)							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
iv.	The university has a clear quality assurance system of the student assessment							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
v.	The university has a clear quality assurance of the quality of the staff  		</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>					
vi.	Idem and adequate quality assurance of the facilities							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
vii.	The university carries out self-assessments on a regular basis 							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
viii.	The university has a well-functioning management Information systems							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
ix.	The university has a Handbook on Quality Assurance							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
Overall opinion							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
12.	Achievements							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
The university has the means and opportunities to check whether the achievements are in line with the expected outcomes.							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
Overall opinion							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
13.	Stakeholder satisfaction							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
The university has a structured method for obtaining feedback from stakeholders							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
Overall opinion							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
14. University Colleges, Campuses and Collaborating Institutions							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
i.	The university has a clear system of establishing University Colleges, Campuses, and Collaborating institutions							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
ii.	The university has a clear mechanism of assessing quality of University Colleges, Campuses, and Collaborating institutions							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
Overall opinion							</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr><tr><td>
							
Overall verdict		</td> <td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td><td><asp:CheckBox runat="server"/></td></tr></table> 
      </div>
       <div class="panel-footer">
            <div class="pull-right">
                <!--<a href="InstitutionalQA.aspx?step=" class="btn btn-success">Next</a>-->
            </div>
            <div class="pull-left">
                <a href="InstitutionalQA.aspx?qa=<%=qaNo%>&step=<%=myStep-1 %>" class="btn btn-success">Previous</a>
            </div><div class="pull-right">
                <asp:Button runat="server" CssClass="btn btn-success" Text="Save Changes"/>
                <asp:Button runat="server" CssClass="btn btn-success" Text="Submit"/>
            </div>
            <div class="clearfix"></div>
        </div>
  </div>

         <%
       } %>
    <div id="addFullTime" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Add Full Time Staff</h4>
      </div>
      <div class="modal-body">
        <div class="form-group">
            <strong>Category:</strong>
            <asp:DropDownList runat="server" ID="fullTimerCategory" CssClass="form-control"/>
        </div>
          <div class="form-group">
              <strong>No. Full Establishment:</strong>
              <asp:TextBox runat="server" ID="fullTimerNoFullEstablishment" CssClass="form-control" TextMode="Number" placeholder="No. at Full Establishment"/>
          </div>
           <div class="form-group">
              <strong>Male:</strong>
              <asp:TextBox runat="server" ID="fullTimerMale" CssClass="form-control" TextMode="Number" placeholder="Male"/>
          </div> 
          
         <div class="form-group">
              <strong>Female:</strong>
              <asp:TextBox runat="server" ID="fullTimerfemale" CssClass="form-control" TextMode="Number" placeholder="Female"/>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Add Full Time Staff" ID="addFullTimeStaff" OnClick="addFullTimeStaff_Click"/>
      </div>
    </div>

  </div>
</div>
   
<div id="addPartTime" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Add Part Time Staff</h4>
      </div>
      <div class="modal-body">
        <div class="form-group">
            <strong>Category:</strong>
            <asp:DropDownList runat="server" ID="partTimerCategory" CssClass="form-control"/>
        </div>
         
           <div class="form-group">
              <strong>Male:</strong>
              <asp:TextBox runat="server" ID="partTimerMale" CssClass="form-control" TextMode="Number" placeholder="Male"/>
          </div> 
          
         <div class="form-group">
              <strong>Female:</strong>
              <asp:TextBox runat="server" ID="partTimerfemale" CssClass="form-control" TextMode="Number" placeholder="Female"/>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Add Part Time Staff" ID="addPartTimeStaff" OnClick="addPartTimeStaff_Click"/>
      </div>
    </div>

  </div>
</div>

<div id="addAdministrativeStaffModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Add Administrative Staff</h4>
      </div>
      <div class="modal-body">
        <div class="form-group">
            <strong>Category:</strong>
            <asp:DropDownList runat="server" ID="administrativeStaffCategory" CssClass="form-control"/>
        </div>
         
           <div class="form-group">
              <strong>Male:</strong>
              <asp:TextBox runat="server" ID="administrativeMale" CssClass="form-control" TextMode="Number" placeholder="Male"/>
          </div> 
          
         <div class="form-group">
              <strong>Female:</strong>
              <asp:TextBox runat="server" ID="administrativefemale" CssClass="form-control" TextMode="Number" placeholder="Female"/>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Add Administrative Staff" ID="addAdministrativeStaff" OnClick="addAdministrativeStaff_Click"/>
      </div>
    </div>

  </div>
</div>
<div id="staffDevelopmentAndTraining" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Number of Staff offered development and training in the last five years</h4>
      </div>
      <div class="modal-body">
        <div class="form-group">
            <strong>Training Category:</strong>
            <asp:DropDownList runat="server" ID="developmentTrainingCategory" CssClass="form-control"/>
        </div>
          <div class="form-group">
            <strong>Staff Category:</strong>
            <asp:DropDownList runat="server" ID="staffcategory" CssClass="form-control"/>
        </div>
          <div class="form-group">
            <strong>Year:</strong>
            <asp:DropDownList runat="server" ID="developmentTrainingYear" CssClass="form-control"/>
        </div>
          <div class="form-group">
            <strong>Male:</strong>
            <asp:TextBox runat="server" ID="developmentTrainingMale" CssClass="form-control" PlaceHolder="Male"/>
        </div> 
          <div class="form-group">
            <strong>Female:</strong>
            <asp:TextBox runat="server" ID="developmentTrainingFemale" CssClass="form-control" PlaceHolder="Female"/>
        </div>
         
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Add Development & Training" ID="addDevelopmentTraining" OnClick="addDevelopmentTraining_Click"/>
      </div>
    </div>

  </div>
</div>
    <% int currentYear = DateTime.Now.Year; %>
<div id="sourcesOfIncome" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Sources of income in KShs. Millions (expected and actual) for the last five years</h4>
      </div>
      <div class="modal-body">
        <div class="form-group">
            <strong>Source of Income:</strong>
            <asp:DropDownList runat="server" ID="sourceOfIncome" CssClass="form-control"/>
        </div>
           <div class="form-group">
            <strong>Year:</strong>
            <asp:DropDownList runat="server" ID="sourceOfIncomeYear" CssClass="form-control"/>
        </div>
          <div class="form-group">
            <strong>Expected:</strong>
            <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="incomeSourceExpected"></asp:TextBox>
        </div>
          <div class="form-group">
            <strong>Actual:</strong>
             <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="incomeSourceActual"></asp:TextBox>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Add Source of Income" ID="addSourceOfIncome" OnClick="addSourceOfIncome_Click" />
      </div>
    </div>

  </div>
</div>

<div id="universityCreditors" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">List of University Creditors (indicating amounts) per year for the last five years </h4>
      </div>
      <div class="modal-body">
        <div class="form-group">
            <strong>University Creditor:</strong>
            <asp:DropDownList runat="server" ID="universityCreditor" CssClass="form-control"/>
        </div> 
          <div class="form-group">
            <strong>Year:</strong>
            <asp:DropDownList runat="server" ID="universityCreditorYear" CssClass="form-control"/>
        </div> 
          <div class="form-group">
            <strong>Amount:</strong>
           <asp:TextBox runat="server" CssClass="form-control"  ID="universityCreditorAmount" placeholder="Amount"></asp:TextBox>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Add Creditor" ID="addCreditor" OnClick="addCreditor_Click" />
      </div>
    </div>

  </div>
</div>
<div id="universityDebtors" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">List of University Debtors (indicating amounts) per year for the last five years </h4>
      </div>
      <div class="modal-body">
        <div class="form-group">
            <strong>University Debtor:</strong>
            <asp:DropDownList runat="server" ID="universityDebtor" CssClass="form-control"/>
        </div>
           <div class="form-group">
            <strong>Year:</strong>
            <asp:DropDownList runat="server" ID="universityDebtorYear" CssClass="form-control"/>
        </div> 
          <div class="form-group">
            <strong>Amount:</strong>
              <asp:TextBox runat="server" CssClass="form-control" ID="universityDebtorAmount"/>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Add Debtor" ID="addDebtor" OnClick="addDebtor_Click" />
      </div>
    </div>

  </div>
</div>

<div id="academicProgramme" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">List of Academic Programmes</h4>
      </div>
      <div class="modal-body">
          <div class="form-group">
            <strong>Programme Name:</strong>
            <asp:TextBox runat="server" ID="programmeName" CssClass="form-control" placeholder="Programme Name"/>
        </div>
        <div class="form-group">
            <strong>Status of Accreditation:</strong>
            <asp:DropDownList runat="server" ID="programmeAccreditationStatus" CssClass="form-control"/>
        </div>
          <div class="form-group">
            <strong>Highest Academic Qualification of Academic Leader:</strong>
            <asp:DropDownList runat="server" ID="academicLeaderHighestQualification" CssClass="form-control"/>
        </div> 
          <div class="form-group">
            <strong>Duration of Programme in Months:</strong>
            <asp:TextBox runat="server" ID="programmeDuration" CssClass="form-control" placeholder="Programme Duration"/>
        </div>
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Add Programme" ID="addProgramme" OnClick="addProgramme_Click" />
      </div>
    </div>

  </div>
</div>

<div id="academicProgrammesPerSchool" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Summary of Academic Programmes Per School</h4>
      </div>
      <div class="modal-body">
          <div class="form-group">
            <strong>School:</strong>
            <asp:DropDownList runat="server" ID="programmeSchool" CssClass="form-control"/>
        </div>
          
        
         <table class="table table-bordered table-striped">
             <thead>
             <tr>
                 <th>Level</th>
                 <th>No. Of Academic Programmes</th>
             </tr>
             </thead>
             <tbody>
             <tr>
                 <td>P.H.D.:</td>
                 <td> <asp:TextBox runat="server" ID="schoolPhdSummary" CssClass="form-control" placeholder="No. Of Academic Programmes"/></td>
             </tr>
                 <tr>
                 <td>Masters:</td>
                 <td> <asp:TextBox runat="server" ID="schoolMastersSummary" CssClass="form-control" placeholder="No. Of Academic Programmes"/></td>
             </tr> 
                 <tr>
                 <td>PGD:</td>
                 <td> <asp:TextBox runat="server" ID="schoolPGDSummary" CssClass="form-control" placeholder="No. Of Academic Programmes"/></td>
             </tr>
                 <tr>
                 <td>Bachelors:</td>
                 <td> <asp:TextBox runat="server" ID="schoolBachelorsSummary" CssClass="form-control" placeholder="No. Of Academic Programmes"/></td>
             </tr>
                 <tr>
                 <td>Diploma:</td>
                 <td> <asp:TextBox runat="server" ID="schoolDiplomaSummary" CssClass="form-control" placeholder="No. Of Academic Programmes"/></td>
             </tr>
                 <tr>
                 <td>Certificate:</td>
                 <td> <asp:TextBox runat="server" ID="schoolCertificateSummary" CssClass="form-control" placeholder="No. Of Academic Programmes"/></td>
             </tr>
             </tbody>
         </table>
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Add School Summary" ID="addSchoolSummary" OnClick="addSchoolSummary_Click" />
      </div>
    </div>

  </div>
</div>

<div id="academicProgrammeCollaboration" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">List of Academic Programmes Offered Under Collaboration Per School</h4>
      </div>
      <div class="modal-body">
          <div class="form-group">
            <strong>School:</strong>
            <asp:DropDownList runat="server" ID="collaboratingSchool" CssClass="form-control"/>
        </div>
          <div class="form-group">
            <strong>Programme Name:</strong>
            <asp:TextBox runat="server" ID="collaboratingProgrammeName" CssClass="form-control" placeholder="Programme Name"/>
        </div> 
          <div class="form-group">
            <strong>Collaborating Institution:</strong>
            <asp:TextBox runat="server" ID="collaboratingInstitution" CssClass="form-control" placeholder="Collaborating Institution"/>
        </div>
        
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Add Programme" ID="addCollaborationProgramme" OnClick="addCollaborationProgramme_Click" />
      </div>
    </div>

  </div>
</div>

<div id="kenyaInternationalSummary" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Summary of No. of Kenyan & International Students</h4>
      </div>
      <div class="modal-body">
          <div class="form-group">
            <strong>Programme Level:</strong>
            <asp:DropDownList runat="server" ID="kenyaInternationalProgrammeLevel" CssClass="form-control"/>
        </div>
          <div class="form-group">
            <strong>No. of Kenyan Students:</strong>
            <asp:TextBox runat="server" ID="kenyanStudents" CssClass="form-control" placeholder="No. of Kenyan Students"/>
        </div> 
          <div class="form-group">
            <strong>No. of International Students:</strong>
            <asp:TextBox runat="server" ID="internationalStudents" CssClass="form-control" placeholder="No. of International Students"/>
        </div>
        
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Add Summary" ID="addKenyanInternational" OnClick="addKenyanInternational_Click" />
      </div>
    </div>

  </div>
</div>

<div id="qualityOfAcademicStaff" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Quality of Academic Staff</h4>
      </div>
      <div class="modal-body">
          <div class="form-group">
            <strong>Category:</strong>
            <asp:DropDownList runat="server" ID="qualityAcademicStaffCategory" CssClass="form-control"/>
        </div>
          <div class="form-group">
            <strong>Age Bracket:</strong>
            <asp:DropDownList runat="server" ID="qualityAcademicAgeBracket" CssClass="form-control"/>
        </div>
          <div class="form-group">
            <strong>No of Staff:</strong>
           <asp:TextBox runat="server" ID="qualityAcademicNoofStaff" CssClass="form-control" placeholder="No of Staff"/>
        </div>
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Add Quality of Academic Staff" ID="addQualityAcademicStaff" OnClick="addQualityAcademicStaff_Click" />
      </div>
    </div>

  </div>
</div>

<div id="operationBudgetModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Operation Budget</h4>
      </div>
      <div class="modal-body">
          <div class="form-group">
            <strong>Year:</strong>
            <asp:DropDownList runat="server" ID="operationBudgetYear" CssClass="form-control"/>
        </div>
          <div class="form-group">
            <strong>Operation Budget:</strong>
           <asp:TextBox runat="server" ID="operationBudget" CssClass="form-control" placeholder="Operation Budget"/>
        </div> 
           <div class="form-group">
            <strong>Actual Expenditure:</strong>
           <asp:TextBox runat="server" ID="actualExpenditure" CssClass="form-control" placeholder="Actual Expenditure"/>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Add Operation Budget" OnClick="saveOperationBudget_Click" />
      </div>
    </div>

  </div>
</div>

<div id="debtEquityAssetsLiabilitiesModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Total Debt, Equity, Current assets and Current Liabilities</h4>
      </div>
      <div class="modal-body">
          <div class="form-group">
            <strong>Year:</strong>
            <asp:DropDownList runat="server" ID="debtEquityYear" CssClass="form-control"/>
        </div>
          <div class="form-group">
            <strong>Total Debt:</strong>
           <asp:TextBox runat="server" ID="totalDebt" CssClass="form-control" placeholder="Total Debt"/>
        </div> 
          <div class="form-group">
            <strong>Total Equity:</strong>
           <asp:TextBox runat="server" ID="totalEquity" CssClass="form-control" placeholder="Total Equity"/>
        </div> 
           <div class="form-group">
            <strong>Current Assets:</strong>
           <asp:TextBox runat="server" ID="currentAssets" CssClass="form-control" placeholder="Current Assets"/>
        </div> 
          <div class="form-group">
            <strong>Current Liabilities:</strong>
           <asp:TextBox runat="server" ID="currentLiabilities" CssClass="form-control" placeholder="Current Liabilities"/>
        </div> 
          
         
          
        
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Add Entries" OnClick="addDebtEuityAssetsLiabilities_Click" />
      </div>
    </div>

  </div>
</div>

<div id="researchBudgetaryAllocationModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Budgetary Allocation for Research</h4>
      </div>
      <div class="modal-body">
          <div class="form-group">
            <strong>Year:</strong>
            <asp:DropDownList runat="server" ID="researchBudgetaryYear" CssClass="form-control"/>
        </div>
          <div class="form-group">
            <strong>Operation Budget:</strong>
           <asp:TextBox runat="server" ID="researchBudgetaryAllocation" CssClass="form-control" placeholder="Budgetary Allocation"/>
        </div> 
           <div class="form-group">
            <strong>Actual Expenditure:</strong>
           <asp:TextBox runat="server" ID="researchBudgetaryExpenditure" CssClass="form-control" placeholder="Actual Expenditure"/>
        </div>
         
          
        
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Add Budgetary Allocation for Research" OnClick="saveResearchAllocation_Click" />
      </div>
    </div>

  </div>
</div>

<div id="researchAttractedModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Amount Attracted for Research</h4>
      </div>
      <div class="modal-body">
          <div class="form-group">
            <strong>Year:</strong>
            <asp:DropDownList runat="server" ID="researchAttractedYear" CssClass="form-control"/>
        </div>
          <div class="form-group">
            <strong>Budgetary Allocation:</strong>
           <asp:TextBox runat="server" ID="researchAttractedAllocation" CssClass="form-control" placeholder="Budgetary Allocation"/>
        </div> 
           <div class="form-group">
            <strong>Actual Expenditure:</strong>
           <asp:TextBox runat="server" ID="researchAttractedExpenditure" CssClass="form-control" placeholder="Actual Expenditure"/>
        </div>
         
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Add Amount Attracted for Research" OnClick="ResearchAttracted_Click" />
      </div>
    </div>

  </div>
</div>

<div id="libraryBudgetaryAllocationModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Library Budgetary Allocation</h4>
      </div>
      <div class="modal-body">
          <div class="form-group">
            <strong>Year:</strong>
            <asp:DropDownList runat="server" ID="libraryBudgetaryYear" CssClass="form-control"/>
        </div>
          <div class="form-group">
            <strong>Operation Budget:</strong>
           <asp:TextBox runat="server" ID="libraryBudgetaryAllocation" CssClass="form-control" placeholder="Budgetary Allocation"/>
        </div> 
           <div class="form-group">
            <strong>Actual Expenditure:</strong>
           <asp:TextBox runat="server" ID="libraryBudgetaryExpenditure" CssClass="form-control" placeholder="Actual Expenditure"/>
        </div>
         
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Add Library Budgetary Allocation" OnClick="saveLibrary_Click" />
      </div>
    </div>

  </div>
</div>
    
 <div id="allocationActualModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Allocation and Actual Expenditure</h4>
      </div>
      <div class="modal-body">
          <div class="form-group">
            <strong>Year:</strong>
            <asp:DropDownList runat="server" ID="allocationActualYear" CssClass="form-control"/>
        </div>
          <div class="form-group">
            <strong>Operation Budget:</strong>
           <asp:TextBox runat="server" ID="allocationActualAllocation" CssClass="form-control" placeholder="Budgetary Allocation"/>
        </div> 
           <div class="form-group">
            <strong>Actual Expenditure:</strong>
           <asp:TextBox runat="server" ID="allocationActualExpenditure" CssClass="form-control" placeholder="Actual Expenditure"/>
        </div>
         
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Add Allocation & Actual Expenditure" OnClick="saveAllocationActual_Click" />
      </div>
    </div>

  </div>
</div>
    
<script src="js/http_unpkg.com_sweetalert_dist_sweetalert.min.js"></script>
<script src="js/http_rawgit.com_eligrey_FileSaver.js_master_FileSaver.js"></script>
<script src="js/http_unpkg.com_xlsx_dist_xlsx.full.min.js"></script>
    <script src="js/excel_uploader.js"></script>
    <script>
        $(document).ready(function () {
            //staffTrainingType staffTrainingChooser staffTrainingOutput
        var var1 = new ExcelUploader({
            maxInAGroup: 100,
            serverColumnNames: ["100"],
            importTypeSelector: "#staffTrainingType",
            fileChooserSelector: "#staffTrainingChooser",
           outputSelector: "#staffTrainingOutput",
            extraData: { _token: "23333323323223323232" },
            receiverUrl: ["addStaffTraining"],
            username: "<% = Session["Code"] %>",
            password: "<% =Session["Password"] %>",
            qaNo: "<% =Request.QueryString["qa"] %>"
        });
            var var2 = new ExcelUploader({
            maxInAGroup: 100,
            serverColumnNames: ["100"],
            importTypeSelector: "#sourceOfIncomeType",
            fileChooserSelector: "#sourceOfIncomeChooser",
            outputSelector: "#sourceOfIncomeOutput",
            extraData: { _token: "23333323323223323232" },
            receiverUrl: ["addSourcesOfIncome"],
            username: "<% = Session["Code"] %>",
            password: "<% =Session["Password"] %>",
            qaNo: "<% =Request.QueryString["qa"] %>"
            });
            var var3 = new ExcelUploader({
            maxInAGroup: 100,
            serverColumnNames: ["100"],
            importTypeSelector: "#creditorType",
            fileChooserSelector: "#creditorChooser",
            outputSelector: "#creditorOutput",
            extraData: { _token: "23333323323223323232" },
            receiverUrl: ["addCreditors"],
            username: "<% = Session["Code"] %>",
            password: "<% =Session["Password"] %>",
            qaNo: "<% =Request.QueryString["qa"] %>"
        });
    });
</script>
     <script>
         $(document).ready(function() {
             $('#dataTables-example').DataTable({
                 responsive: true
             });
         });
         $(document).ready(function () {
             $('#dataTables-example1').DataTable({
                 responsive: true
             });
         });
         $(document).ready(function () {
             $('#dataTables-example3').DataTable({
                 responsive: true
             });
         });
         $(document).ready(function () {
             $('#dataTables-example4').DataTable({
                 responsive: true
             });
         });
         $(document).ready(function () {
             $('#dataTables-example5').DataTable({
                 responsive: true
             });
         });
         $(document).ready(function () {
             $('#dataTables-example6').DataTable({
                 responsive: true
             });
         });
         $(document).ready(function () {
             $('#dataTables-example7').DataTable({
                 responsive: true
             });
         });
         $(document).ready(function () {
             $('#dataTables-example8').DataTable({
                 responsive: true
             });
         });
         $(document).ready(function () {
             $('#dataTables-example9').DataTable({
                 responsive: true
             });
         });
         $(document).ready(function () {
             $('#dataTables-example10').DataTable({
                 responsive: true
             });
         });
         $(document).ready(function () {
             $('#dataTables-example11').DataTable({
                 responsive: true
             });
         });
         $(document).ready(function () {
             $('#dataTables-example12').DataTable({
                 responsive: true
             });
         });
         $(document).ready(function () {
             $('#dataTables-example13').DataTable({
                 responsive: true
             });
         });
         $(document).ready(function () {
             $('#dataTables-example14').DataTable({
                 responsive: true
             });
         });
         $(document).ready(function () {
             $('#dataTables-example15').DataTable({
                 responsive: true
             });
         });
         $(document).ready(function () {
             $('#dataTables-example16').DataTable({
                 responsive: true
             });
         });
         $(document).ready(function () {
             $('#dataTables-example17').DataTable({
                 responsive: true
             });
         });
         $(document).ready(function () {
             $('#dataTables-example18').DataTable({
                 responsive: true
             });
         });
         $(document).ready(function () {
             $('#dataTables-example19').DataTable({
                 responsive: true
             });
         });
         $(document).ready(function () {
             $('#dataTables-example20').DataTable({
                 responsive: true
             });
         });
         $(document).ready(function () {
             $('#dataTables-example21').DataTable({
                 responsive: true
             });
         });
         $(document).ready(function () {
             $('#dataTables-example22').DataTable({
                 responsive: true
             });
         });
         $(document).ready(function () {
             $('#dataTables-example23').DataTable({
                 responsive: true
             });
         });
         $(document).ready(function () {
             $('#dataTables-example24').DataTable({
                 responsive: true
             });
         });
         $(document).ready(function () {
             $('#dataTables-example25').DataTable({
                 responsive: true
             });
         });
         $(document).ready(function () {
             $('#dataTables-example26').DataTable({
                 responsive: true
             });
         });
         $(document).ready(function () {
             $('#dataTables-example27').DataTable({
                 responsive: true
             });
         });
         $(document).ready(function () {
             $('#dataTables-example28').DataTable({
                 responsive: true
             });
         });
        
     </script>
</asp:Content>
