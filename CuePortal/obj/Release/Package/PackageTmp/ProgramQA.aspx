<%@ Page Title="" Language="C#" MasterPageFile="~/QAMaster.Master" AutoEventWireup="true" CodeBehind="ProgramQA.aspx.cs" Inherits="CicPortal.ProgramQA" %>

<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%
        const int maxStep = 19;
        var nav = Config.ReturnNav();
        String QualityAuditNo = "";
        try
        {
            QualityAuditNo = Request.QueryString["QualityAuditNo"].Trim();
        }
        catch (Exception)
        {

        }
        int currentStep = 1;
        try
        {
            currentStep = Convert.ToInt32(Request.QueryString["step"]);
            if (currentStep > maxStep || currentStep < 1)
            {
                currentStep = 1;
            }
        }
        catch (Exception)
        {
            currentStep = 1;
        }
    %>
    <%
        if (currentStep == 1)
        {
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            1.	Background Information
            <label class="pull-right">Step <%=currentStep %> of <%=maxStep %></label>
            <div class="clearfix"></div>
        </div>
        <div id="basicinformations" runat="server"></div>
        <div class="panel-body">
            <div class="form-group">
                <strong>a. Name of Academic Programme </strong>
                <asp:TextBox runat="server" CssClass="form-control" ID="nameofprogramme" placeholder="Name of Academic Programme " />
            </div>
            <div class="form-group">
                <strong>b. Academic Programme Domain </strong>
                <asp:DropDownList runat="server" CssClass="form-control" ID="academicProgrammeDomain" />
            </div>
            <div class="form-group">
                <strong>c Give a brief description of the niche of the university  </strong>
                <asp:TextBox runat="server" CssClass="form-control" ID="universityniche" TextMode="MultiLine" />
            </div>
            <%-- <div class="form-group">
                <strong>c (i) Date of Accreditation/Approval   </strong>
                <asp:TextBox runat="server" CssClass="form-control" ID="accreditationDate" TextMode="Date" style="padding-top:0px;"/>
            </div>--%>
            <div class="form-group">
                <strong>d (i) Does the Academic Programme require approval by a relevant professional body?   </strong><i>(Tick if Yes)</i>
                <asp:CheckBox runat="server" CssClass="form-control" ID="requiresApproval" />
            </div>
            <div class="form-group">
                <strong>(ii) if yes in d(i) Kindly attach evidence</strong>
                <asp:FileUpload runat="server" CssClass="form-control" ID="professionbody" />
            </div>
            <div class="form-group">
                <strong>(iii) Is the Academic Programme approved by a professional body?    </strong><i>(Tick if Yes)</i>
                <asp:CheckBox runat="server" CssClass="form-control" ID="approvedByProfessionalBody" />
            </div>
            <div class="form-group">
                <strong>(iv) if yes in d(iii) Kindly attach evidence</strong>
                <asp:FileUpload runat="server" CssClass="form-control" ID="FileUpload3" />
            </div>
            <div class="form-group">
                <strong>(v) Indicate the name of the Professional body </strong>
                <asp:TextBox runat="server" CssClass="form-control" ID="professionalBody" />
            </div>
            <div class="form-group">
                <strong>(vi) Date of approval by the relevant professional body   </strong>
                <asp:TextBox runat="server" CssClass="form-control" ID="professionalBodyApprovalDate" TextMode="Date" Style="padding-top: 0px;" />
            </div>
            <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 form-group">
                <br />
                <asp:Button runat="server" ID="addBasicInformation" CssClass="btn btn-success" Text="Add Backgrounf Infromation" OnClick="addBackgoundInformation_Click" />
            </div>
        </div>
        <table class="table table-bordered table-striped dataTable">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Quality Audit No</th>
                    <th>Programme Name</th>
                    <th>Domain</th>
                    <th>Proffessional Body</th>
                    <th>Approvals</th>
                    <th>Date of Approval</th>
                    <th>Edit</th>
                    <%--  <th>Proceed</th>--%>
                </tr>
            </thead>
            <tbody>
                <% var details = nav.QualityAudits.Where(r => r.Institution_No == Convert.ToString(Session["UniversityCode"]) && r.Status == "Open" && r.QualityAudit_Completed == false);
                    string university = Convert.ToString(Session["UniversityCode"]);
                    int qualityauditcounter = 0;
                    foreach (var detail in details)
                    {
                        qualityauditcounter++;
                %>
                <tr>
                    <td><%=qualityauditcounter %></td>
                    <td><%=detail.Quality_Audit_No %></td>
                    <td><%=detail.Name_of_Academic_Programme %></td>
                    <td><%=detail.Programme_Domain %></td>
                    <td><%=detail.Name_of_the_Professional_body %></td>
                    <td><%=detail.Approval_by_Proffessional_Body %></td>
                    <td><%=detail.Date_of_approval_Proffessional %></td>
                    <td>
                        <label class="btn btn-success" onclick="editBasicInformations('<%=detail.Quality_Audit_No %>','<%=detail.Name_of_Academic_Programme %>','<%=detail.Programme_Domain %>','<%=detail.Approval_by_Proffessional_Body %>','<%=detail.Name_of_the_Professional_body %>','<%=detail.Date_of_approval_Proffessional %>');"><i class="fa fa-pencil"></i>Edit</label></td>
                    <%-- <td><a href="ProgramQA.aspx?QualityAuditNo=<%=detail.Quality_Audit_No %>&step=2" class="btn btn-success"><i class="fa fa-eye"></i>Proceed</a></td>--%>
                </tr>
                <%  
                    } %>
            </tbody>
        </table>

        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="FirstStep_Click" />
            <div class="clearfix"></div>
        </div>
    </div>
    <% }
        else if (currentStep == 2)
        {
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            2.	Requirements of Stakeholders
            <label class="pull-right">Step <%=currentStep %> of <%=maxStep %></label>
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
                <asp:Button runat="server" CssClass="btn btn-success " Text="Submit Stakeholder Details" ID="saveStakeHolders" OnClick="saveStakeHolders_Click" />
            </div>
            <table class="table table-bordered table-striped dataTable">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Quality Audit No</th>
                        <th>Stakeholder Name</th>
                        <th>A Stakeholder</th>
                        <th>Engaged Last 5 Yrs</th>
                        <th>Analyzed Needs Last 5 Yrs</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <% var stakeholderdetails = nav.KnowStakeholders.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]) && r.QA_No == QualityAuditNo);
                        string university = Convert.ToString(Session["UniversityCode"]);
                        int qualityauditcounter = 0;
                        foreach (var stakeholderdetail in stakeholderdetails)
                        {
                            qualityauditcounter++;
                    %>
                    <tr>
                        <td><%=qualityauditcounter %></td>
                        <td><%=stakeholderdetail.QA_No %></td>
                        <td><%=stakeholderdetail.Stakeholder_Name %></td>
                        <td><%=stakeholderdetail.A_Stakeholder %></td>
                        <td><%=stakeholderdetail.Engaged_for_last_5yrs %></td>
                        <td><%=stakeholderdetail.Analyzed_needs_last_5yrs %></td>
                        <td>
                            <label class="btn btn-success" onclick="editStakeholderRequirements('<%=stakeholderdetail.No %>','<%=stakeholderdetail.QA_No %>','<%=stakeholderdetail.Stakeholder_Name %>','<%=stakeholderdetail.A_Stakeholder %>','<%=stakeholderdetail.Engaged_for_last_5yrs %>','<%=stakeholderdetail.Analyzed_needs_last_5yrs %>');"><i class="fa fa-pencil"></i>Edit</label></td>
                        <td>
                            <label class="btn btn-danger" onclick="deleteRequirementsStakeholders('<%=stakeholderdetail.No %>','<%=stakeholderdetail.Stakeholder_Name %>');"><i class="fa fa-trash"></i>Delete</label></td>

                    </tr>
                    <%  
                        } %>
                </tbody>
            </table>
            <h3>Other Stakeholders</h3>
            <hr />
            <div id="feedbackOthers" runat="server"></div>
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Stakeholder</th>
                        <th>Engaged in the last five years?
                            <br />
                            (Check if yes) </th>
                        <th>Has the University analyzed the needs and requirements
                            <br />
                            of the stakeholder in the last five years?(Check if yes) </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <asp:TextBox runat="server" ID="otherStakeHolderName" CssClass="form-control" placeholder="Stakeholder Name" />
                        </td>
                        <td>
                            <asp:CheckBox runat="server" ID="stakeengaged" /></td>
                        <td>
                            <asp:CheckBox runat="server" ID="analyzeneeds" /></td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Add Stakeholder" OnClick="AddOtherStakeholder_Click" /></td>
                    </tr>
                </tbody>
            </table>
            <table class="table table-bordered table-striped dataTable">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Quality Audit No</th>
                        <th>Stakeholder Name</th>
                        <th>Engaged Last 5 Yrs</th>
                        <th>Analyzed Needs Last 5 Yrs</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <% var otherstakes = nav.OtherStakeholders.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"]) && r.QA_No == QualityAuditNo);
                        string universityCode = Convert.ToString(Session["UniversityCode"]);
                        int stakeholdercounter = 0;
                        foreach (var otherstake in otherstakes)
                        {
                            stakeholdercounter++;
                    %>
                    <tr>
                        <td><%=stakeholdercounter %></td>
                        <td><%=otherstake.QA_No %></td>
                        <td><%=otherstake.Stakeholder_Name %></td>
                        <td><%=otherstake.Engaged_5yrs %></td>
                        <td><%=otherstake.Analyzed_needs_5yrs %></td>
                        <td>
                            <label class="btn btn-success" onclick="editOtherStakeholders('<%=otherstake.No %>','<%=otherstake.QA_No %>','<%=otherstake.Stakeholder_Name %>','<%=otherstake.Engaged_5yrs %>','<%=otherstake.Analyzed_needs_5yrs %>');"><i class="fa fa-pencil"></i>Edit</label></td>
                        <td>
                            <label class="btn btn-danger" onclick="deleteOtherStakeholders('<%=otherstake.No %>','<%=otherstake.Stakeholder_Name %>');"><i class="fa fa-trash"></i>Delete</label></td>

                    </tr>
                    <%  
                        } %>
                </tbody>
            </table>
            <hr />
            <h3>Key strengths and weaknesses on identification of stakeholders and analysis of stakeholders’ requirements</h3>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="panel panel-primary">
                        <div runat="server" id="StrenghtsFeedback"></div>
                        <div class="panel-heading">
                            Key Strengths
                        </div>
                        <div class="panel-body">
                            <div class="form-group">
                                <strong>Strength:</strong>
                                <asp:TextBox runat="server" CssClass="form-control" placeholder="Strength" ID="stakeHolderStrength" TextMode="MultiLine" />
                            </div>
                            <div class="form-group">
                                <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Strength" ID="addStakeHolderStrength" OnClick="addStakeHolderStrength_Click" />
                            </div>
                            <table class="table table-bordered table-striped" id="dataTables-example1">
                                <thead>
                                    <tr>
                                        <th>SN</th>
                                        <th>Strength</th>
                                        <th>Edit</th>
                                        <th>Delete</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        var strengths = nav.StrengthsWeaknessOnStakeHolder.Where(r => r.QA_No == QualityAuditNo && r.Type == "Strength");
                                        string University_Code = Convert.ToString(Session["UniversityCode"]);
                                        int strengthscounter = 0;
                                        string strenghtdetails = "";
                                        int strengthnumber = 0;
                                        foreach (var strength in strengths)
                                        {
                                            strengthnumber = strength.No;
                                            strengthscounter++;
                                            var strenght = new Config().ObjNav().FngetStakeholderStrenght(QualityAuditNo, University_Code, strengthnumber);
                                            strenghtdetails = Regex.Replace(strenght, @"[^0-9a-zA-Z]+", " ");

                                    %>
                                    <tr>
                                        <td><%=strengthscounter %></td>
                                        <td><%=strenght %></td>
                                        <td>
                                            <label class="btn btn-success" onclick="editstakeholdersstrengths('<%=strength.No%>');"><i class="fa fa-pencil"></i>Edit</label></td>
                                        <td>
                                            <label class="btn btn-danger" onclick="deletestakeholdersstrengths('<%=strength.No%>');"><i class="fa fa-trash"></i>Delete</label></td>

                                    </tr>
                                    <%
                                            strengthnumber++;

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
                        <div runat="server" id="WeaknessesFeedbacks"></div>
                        <div class="panel-body">
                            <div class="form-group">
                                <strong>Weakness:</strong>
                                <asp:TextBox runat="server" CssClass="form-control" placeholder="Weakness" ID="stakeholderWeakness" TextMode="MultiLine" />
                            </div>
                            <div class="form-group">
                                <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Weakness" ID="addStakeHolderWeakness" OnClick="addStakeHolderWeakness_Click" />
                            </div>
                            <table class="table table-bordered table-striped" id="dataTables-example2">
                                <thead>
                                    <tr>
                                        <th>SN</th>
                                        <th>Weakness</th>
                                        <th>Edit</th>
                                        <th>Delete</th>

                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        var weaknesses = nav.StrengthsWeaknessOnStakeHolder.Where(r => r.QA_No == QualityAuditNo && r.Type == "Weakness");
                                        int weaknessescounter = 0;
                                        string weaknessdetails = "";
                                        int weaknessthnumber = 0;
                                        foreach (var weakness in weaknesses)
                                        {
                                            weaknessthnumber = weakness.No;
                                            weaknessescounter++;
                                            var weaknessdetail = new Config().ObjNav().FngetStakeholderWeakness(QualityAuditNo, University_Code, weaknessthnumber);
                                            weaknessdetails = Regex.Replace(weaknessdetail, @"[^0-9a-zA-Z]+", " ");
                                    %>
                                    <tr>
                                        <td><%=weaknessescounter%></td>
                                        <td><%=weaknessdetail %></td>
                                        <td>
                                            <label class="btn btn-success" onclick="editstakeholdersWeakness('<%=weakness.No %>');"><i class="fa fa-pencil"></i>Edit</label></td>
                                        <td>
                                            <label class="btn btn-danger" onclick="deletestakeholdersweakness('<%=weakness.No %>');"><i class="fa fa-trash"></i>Delete</label></td>
                                    </tr>
                                    <%
                                            weaknessthnumber++;
                                        } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="ValidateStakeholders_Click" />
            <div class="clearfix"></div>
        </div>
    </div>
    <% }
        else if (currentStep == 3)
        {
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            3.	Expected Learning Outcomes 
            <label class="pull-right">Step  <%=currentStep %> of <%=maxStep %></label>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">
            <div class="form-group">
                <p>(a)	State the Expected Learning Outcomes of the Academic Programme (knowledge, skills, areas of professional development, and attitude). Delineate the outcomes into generic; and professional/discipline specific.</p>
            </div>
            <div class="panel panel-default">
                <div runat="server" id="feebackgenericoutcome"></div>
                <div class="panel-heading">
                    Generic Expected Learning Outcomes
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-9 col-md-9">
                            <asp:TextBox CssClass="form-control" ID="genericlearningoutcome" placeholder="OutCome" runat="server" TextMode="MultiLine" />
                        </div>
                        <div class="col-lg-3 col-md-3">
                            <asp:Button CssClass="btn btn-success" Text="Add OutCome" runat="server" ID="addGenericOutCome" OnClick="addGenericOutCome_Click" />
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <table class="table table-bordered table-striped dataTable">
                            <thead>
                                <tr>
                                    <th>SN</th>
                                    <th>Outcome</th>
                                    <th>Edit</th>
                                    <th>Delete</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    var outcomes = nav.QAExpectedLearningOutcome.Where(r => r.QA_Number == QualityAuditNo && r.Learning_Outcome_Type == "Generic");
                                    int Outcomescounter = 0;
                                    string University_Code = Convert.ToString(Session["UniversityCode"]);
                                    string genericoutcomesdetails = "";
                                    int genereicoutcomenumber = 0;
                                    foreach (var outcome in outcomes)
                                    {
                                        genereicoutcomenumber = outcome.Code;
                                        Outcomescounter++;
                                        var genericoutcomes = new Config().ObjNav().FngetGenericOutcome(QualityAuditNo, University_Code, genereicoutcomenumber);
                                        genericoutcomesdetails = Regex.Replace(genericoutcomes, @"[^0-9a-zA-Z]+", " ");
                                %>
                                <tr>
                                    <td><%=Outcomescounter%></td>
                                    <td><%=genericoutcomes %></td>
                                    <td>
                                        <label class="btn btn-success" onclick="editGenericLearningOutcome();"><i class="fa fa-pencil"></i>Edit</label></td>
                                    <td>
                                        <label class="btn btn-danger" onclick="deleteGenericLearningOutcome('<%=outcome.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>
                                </tr>
                                <%

                                    } %>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    Professional/Discipline Specific Expected Learning Outcomes
                </div>
                <div class="panel-body">
                    <div runat="server" id="feedbackprofessional"></div>
                    <div class="row">
                        <div class="col-lg-9 col-md-9">
                            <asp:TextBox CssClass="form-control" placeholder="OutCome" runat="server" ID="proffessionallearningoutcome" TextMode="MultiLine" />
                        </div>
                        <div class="col-lg-3 col-md-3">
                            <asp:Button CssClass="btn btn-success" Text="Add OutCome" runat="server" ID="addproffessionalbody" OnClick="addProffessionalOutCome_Click" />
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <table class="table table-bordered table-striped dataTable">
                            <thead>
                                <tr>
                                    <th>SN</th>
                                    <th>Outcome</th>
                                    <th>Edit</th>
                                    <th>Delete</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    var learningoutcomes = nav.QAExpectedLearningOutcome.Where(r => r.QA_Number == QualityAuditNo && r.Learning_Outcome_Type == "Professional/Discipline Specific");
                                    int learningoutcomesCounter = 0;
                                    string professionalcoutcomesdetails = "";
                                    int professionaloutcomenumber = 0;
                                    foreach (var learningoutcome in learningoutcomes)
                                    {
                                        professionaloutcomenumber = learningoutcome.Code;
                                        learningoutcomesCounter++;
                                        var professionalcoutcomes = new Config().ObjNav().FngetProfessionalOutcome(QualityAuditNo, University_Code, professionaloutcomenumber);
                                        professionalcoutcomesdetails = Regex.Replace(professionalcoutcomes, @"[^0-9a-zA-Z]+", " ");
                                %>
                                <tr>
                                    <td><%=learningoutcomesCounter%></td>
                                    <td><%=professionalcoutcomes %></td>
                                    <td>
                                        <label class="btn btn-success" onclick="editProfessionalLearningOutcome();"><i class="fa fa-pencil"></i>Edit</label></td>
                                    <td>
                                        <label class="btn btn-danger" onclick="deleteProfessionalDiscipline('<%=learningoutcome.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>
                                </tr>
                                <%
                                        professionaloutcomenumber++;
                                    } %>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
            <div id="genericlearningoutcomedetails" runat="server"></div>
            <div class="form-group">
                <strong>(b)	How do the Expected Learning Outcomes fit into the University mission</strong>
                <asp:TextBox runat="server" CssClass="form-control" ID="expectedlearningfits" TextMode="MultiLine" placeholder="How do the Expected Learning Outcomes fit into the University mission" />
            </div>
            <div class="form-group">
                <strong>(c)	(i) Do the Expected Learning Outcomes reflect the requirements of the stakeholders of the Academic programme? </strong><i>(Tick if yes)</i>
                <asp:CheckBox runat="server" CssClass="form-control" ID="reflectrequirements" />
            </div>
            <div class="form-group">
                <asp:Button CssClass="btn btn-success" Text="Submit Details" runat="server" ID="adddetails" OnClick="adddetails_Click" />
            </div>
            <table class="table table-bordered table-striped dataTable">
                <thead>
                    <tr>
                        <th>SN</th>
                        <th>Quality Audit No</th>
                        <th>Outcome on University Mission</th>
                        <th>Stakeholders Requirements</th>
                        <th>Edit</th>

                    </tr>
                </thead>
                <tbody>
                    <%
                        var missions = nav.QualityAudits.Where(r => r.Institution_No == Convert.ToString(Session["UniversityCode"]) && r.Quality_Audit_No == QualityAuditNo);
                        int missioncounter = 0;
                        string weaknessdetails = "";
                        foreach (var mission in missions)
                        {
                            missioncounter++;
                    %>
                    <tr>
                        <td><%=missioncounter%></td>
                        <td><%=mission.Quality_Audit_No %></td>
                        <td><%="" %></td>
                        <td><%=mission.Outcome_Reflect_Stakeholders%></td>
                        <td>
                            <label class="btn btn-success" onclick="editUniversityMissionFits();"><i class="fa fa-pencil"></i>Edit</label></td>
                        <%-- <td>
                        <label class="btn btn-danger" onclick="deleteUniversityMissionFits('<%=mission.Quality_Audit_No %>');"><i class="fa fa-trash"></i>Delete</label></td>--%>
                    </tr>
                    <%

                        } %>
                </tbody>
            </table>
            <div class="panel panel-primary">
                <div class="panel-heading">
                    (ii)  For each relevant stakeholder identified in Step 2, state how their specific needs, demands or requirements have been addressed in the Expected Learning Outcomes.
                </div>
                <div class="panel-body">
                    <div id="specificneedsfeedback" runat="server"></div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Stakeholder
                            </strong>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="stakeholderslist" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Needs, demands, or requirements
                            </strong>
                            <asp:TextBox runat="server" CssClass="form-control" TextMode="MultiLine" ID="needsdemands" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>How stakeholder requirements are addressed in the Expected Learning Outcomes
                            </strong>
                            <asp:TextBox runat="server" CssClass="form-control" TextMode="MultiLine" ID="addressingrequirements" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <br />
                            <asp:Button runat="server" CssClass="btn btn-success" Text="Add Stakeholder Details" ID="specifineeds" OnClick="addSpecificNeedsDemands_Click" />
                        </div>
                    </div>
                </div>
                <div id="row">
                    <table class="table table-bordered table-striped dataTable">
                        <thead>
                            <tr>
                                <th>SN</th>
                                <th>Stakeholder</th>
                                <th>Needs, demands, or requirements</th>
                                <th>How stakeholder requirements are addressed in the Expected Learning Outcomes</th>
                                <th>Edit</th>
                                <th>Delete</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                var demands = nav.SpecificNeedsRequirements.Where(r => r.QA_Number == QualityAuditNo);
                                int demandscounter = 0;
                                string needsdemandsdetails = "";
                                string requrementsdetails = "";
                                foreach (var demand in demands)
                                {
                                    string stakeholder = "";
                                    if (demand.Stakeholder_Name == "ACADEMIA")
                                    {
                                        stakeholder = "ACADEMIA";
                                    }
                                    if (demand.Stakeholder_Name == "ALUMNI")
                                    {
                                        stakeholder = "ALUMNI";
                                    }
                                    if (demand.Stakeholder_Name == "LABOUR MAR")
                                    {
                                        stakeholder = "LABOUR MAR";
                                    }
                                    if (demand.Stakeholder_Name == "PROFESSION")
                                    {
                                        stakeholder = "PROFESSION";
                                    }
                                    if (demand.Stakeholder_Name == "GOVERNMENT")
                                    {
                                        stakeholder = "GOVERNMENT";
                                    }
                                    if (demand.Stakeholder_Name == "CIVIL")
                                    {
                                        stakeholder = "CIVIL";
                                    }
                                    if (demand.Stakeholder_Name == "DONORS")
                                    {
                                        stakeholder = "DONORS";
                                    }
                                    if (demand.Stakeholder_Name == "PARENTS")
                                    {
                                        stakeholder = "PARENTS";
                                    }
                                    if (demand.Stakeholder_Name == "SOCIETY IN")
                                    {
                                        stakeholder = "SOCIETY IN";
                                    }

                                    demandscounter++;
                                    var needsdemands = new Config().ObjNav().FngetNeedsDemands(QualityAuditNo, University_Code, stakeholder);
                                    needsdemandsdetails = Regex.Replace(needsdemands, @"[^0-9a-zA-Z]+", " ");
                                    var requrements = new Config().ObjNav().FngetStakeholderRequirements(QualityAuditNo, University_Code, stakeholder);
                                    requrementsdetails = Regex.Replace(requrements, @"[^0-9a-zA-Z]+", " ");

                            %>
                            <tr>
                                <td><%=demandscounter%></td>
                                <td><%=demand.Stakeholder_Name %></td>
                                <td><%=needsdemands %></td>
                                <td><%=requrements %></td>
                                <td>
                                    <label class="btn btn-success" onclick="editspecificneedsdemands();"><i class="fa fa-pencil"></i>Edit</label></td>

                                <td>
                                    <label class="btn btn-danger" onclick="deletespecificneedsdemands('<%=demand.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>
                            </tr>
                            <%

                                } %>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="form-group">
                <strong>(d)	How are the Expected Learning Outcomes communicated to staff, students, and external examiners?</strong><br />
                <div id="communicationfeedback" runat="server"></div>
                <table>
                    <tr>
                        <td>(i)	Memos </td>
                        <td>
                            <asp:CheckBox runat="server" ID="memos" />
                        </td>
                    </tr>
                    <tr>
                        <td>(ii) Newsletters/Posters/Emails&nbsp;&nbsp;&nbsp;&nbsp; </td>
                        <td>
                            <asp:CheckBox runat="server" ID="newsletters" />
                        </td>
                    </tr>
                    <tr>
                        <td>(iii) Meetings </td>
                        <td>
                            <asp:CheckBox runat="server" ID="meetings" />
                        </td>
                    </tr>
                    <tr>
                        <td>(iv) Conferences </td>
                        <td>
                            <asp:CheckBox runat="server" ID="conferences" />
                        </td>
                    </tr>
                </table>
                <br />
                (v)	Other <i>(Please enter as comma separated entries)</i>
                <asp:TextBox runat="server" CssClass="form-control" ID="othercommunis" TextMode="MultiLine" />
                <div class="form-group">
                    <br />
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Submit Communications Details" ID="submitcommunication" OnClick="addCommunicationDetails_Click" />
                </div>
            </div>
            <table class="table table-bordered table-striped dataTable">
                <thead>
                    <tr>
                        <th>SN</th>
                        <th>Memos   </th>
                        <th>Newsletters/Posters/Emails</th>
                        <th>Meetings </th>
                        <th>Conferences </th>
                        <th>Other </th>
                        <th>Edit</th>
                        <th>Delete</th>

                    </tr>
                </thead>
                <tbody>
                    <%
                        var communication = nav.OutcomeCommunicatons.Where(r => r.UniversityCode == Convert.ToString(Session["UniversityCode"]) && r.QA_Number == QualityAuditNo);
                        int commcounter = 0;
                        foreach (var comm in communication)
                        {
                            commcounter++;
                            //  var weaknessdetail= new Config().ObjNav().FngetStakeholderWeakness(QualityAuditNo,University_Code,weakcategory);
                            //  weaknessdetails = Regex.Replace(weaknessdetail, @"[^0-9a-zA-Z]+", " ");
                    %>
                    <tr>
                        <td><%=commcounter%></td>
                        <td><%=comm.Memos %></td>
                        <td><%=comm.Newsletters_Posters_Emails %></td>
                        <td><%=comm.Meetings %></td>
                        <td><%=comm.Conferences %></td>
                        <td><%="" %></td>
                        <td>
                            <label class="btn btn-success" onclick="editoutcomecommunications();"><i class="fa fa-pencil"></i>Edit</label></td>

                        <td>
                            <label class="btn btn-danger" onclick="deleteoutcomecommunications('<%=comm.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>

            <div class="form-group">
                <strong>(e)	Borrow from step 2, Based on your self-assessment state key strengths and weaknesses on achievements of expected learning outcomes?</strong>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <div class="panel panel-primary">
                            <div id="ountcomestrengthfeedback" runat="server"></div>
                            <div class="panel-heading">
                                Key Strengths
                            </div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <strong>Strength:</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" placeholder="Strength" ID="outcomestrength" TextMode="MultiLine" />
                                </div>
                                <div class="form-group">
                                    <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Strength" OnClick="addOutcomeStrenght_Click" />
                                </div>
                                <table class="table table-bordered table-striped dataTable">
                                    <thead>
                                        <tr>
                                            <th>SN</th>
                                            <th>Strength</th>
                                            <th>Edit</th>
                                            <td>Delete</td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            var outcomestrenghts = nav.ExpectedOutcomeStrenght.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Strength");
                                            string strenghtdetails = "";
                                            int outcomestrenghtsCounter = 0;
                                            foreach (var outcomestrenght in outcomestrenghts)
                                            {
                                                outcomestrenghtsCounter++;
                                                var strenght = new Config().ObjNav().FngetLearningOutcomeStrenght(QualityAuditNo, University_Code);
                                                strenghtdetails = Regex.Replace(strenght, @"[^0-9a-zA-Z]+", " ");
                                        %>
                                        <tr>
                                            <td><%=outcomestrenghtsCounter%></td>
                                            <td><%=strenght %></td>
                                            <td>
                                                <label class="btn btn-success" onclick="editstrengthsachievements();"><i class="fa fa-pencil"></i>Edit</label></td>
                                            <td>
                                                <label class="btn btn-danger" onclick="deletestrengthsachievements('<%=outcomestrenght.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>
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
                                <div id="weaknessesfeedback" runat="server"></div>
                                <div class="form-group">
                                    <strong>Weakness:</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" placeholder="Weakness" ID="outcomeweaknesses" TextMode="MultiLine" />
                                </div>
                                <div class="form-group">
                                    <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Weakness" OnClick="addWeaknesses_Click" />
                                </div>
                                <table class="table table-bordered table-striped dataTable">
                                    <thead>
                                        <tr>
                                            <th>SN</th>
                                            <th>Weakness</th>
                                            <th>Edit</th>
                                            <td>Delete</td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            var outcomeweaknesses = nav.ExpectedOutcomeWeaknesses.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Weakness");
                                            int outcomeweaknessescounter = 0;
                                            // string weaknessdetails="";
                                            foreach (var outcomestrenght in outcomeweaknesses)
                                            {
                                                outcomeweaknessescounter++;
                                                var weakness = new Config().ObjNav().FngetLearningOutcomeWeakness(QualityAuditNo, University_Code);
                                                weaknessdetails = Regex.Replace(weakness, @"[^0-9a-zA-Z]+", " ");
                                        %>
                                        <tr>
                                            <td><%=outcomeweaknessescounter%></td>
                                            <td><%=weakness%></td>
                                            <td>
                                                <label class="btn btn-success" onclick="editweaknessachievements();"><i class="fa fa-pencil"></i>Edit</label></td>

                                            <td>
                                                <label class="btn btn-danger" onclick="deleteweaknessachievements('<%=outcomestrenght.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>
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
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="ValidateExpectedLearningOutcomes_Click" />
            <div class="clearfix"></div>
        </div>
    </div>
    <% }
        else if (currentStep == 4)
        {
    %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            4.	Programme Specification/Description
            <label class="pull-right">Step <%=currentStep %> of <%=maxStep %></label>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">
            <div class="form-group">
                <strong>(a)	Describe the Academic Programme in terms of the following aspects which the learners are expected to demonstrate upon completion:
                </strong>
                <div runat="server" id="aspectdecsiptionfeedback"></div>
                <table class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>SN</th>
                            <th>Aspect</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <tbody>

                        <tr>
                            <td>1</td>
                            <td>Knowledge and understanding</td>
                            <td>
                                <asp:TextBox runat="server" TextMode="MultiLine" CssClass="form-control" ID="knowledgeaspect" />

                            </td>

                        </tr>
                        <tr>
                            <td>2</td>
                            <td>Cognitive skills (e.g. methodologies, critical analysis)</td>
                            <td>
                                <asp:TextBox runat="server" TextMode="MultiLine" CssClass="form-control" ID="cognitiveskills" /></td>

                        </tr>
                        <tr>
                            <td>3</td>
                            <td>Subject specific skills (e.g. laboratory skills, clinical skills)</td>
                            <td>
                                <asp:TextBox runat="server" TextMode="MultiLine" CssClass="form-control" ID="subjectaspects" /></td>

                        </tr>

                    </tbody>
                </table>
                <div class="row">
                    <div class="col-md-3 col-lg-3">
                        <div class="form-group">
                            <br />
                            <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Aspect Description" OnClick="addAspectDescription_Click" />
                        </div>
                    </div>
                </div>
            </div>

            <table class="table table-bordered table-striped dataTable">
                <thead>
                    <tr>
                        <th>SN</th>
                        <th>Knowledge and understanding</th>
                        <th>Cognitive skills</th>
                        <th>Subject specific skills</th>
                        <th>Edit</th>
                        <td>Delete</td>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var specifications = nav.ProgrammeSpecification.Where(r => r.UniversityCode == Convert.ToString(Session["UniversityCode"]) && r.QA_Number == QualityAuditNo);
                        int specificationscounter = 0;
                        string knowledgedetails = "";
                        string cognitivedetails = "";
                        string specificdetails = "";
                        foreach (var specification in specifications)
                        {
                            specificationscounter++;
                            var knowledge = new Config().ObjNav().FngetKnowledgeUnderstanding(QualityAuditNo, Convert.ToString(Session["UniversityCode"]));
                            knowledgedetails = Regex.Replace(knowledge, @"[^0-9a-zA-Z]+", " ");
                            var cognitive = new Config().ObjNav().FngetCognitiveSkills(QualityAuditNo, Convert.ToString(Session["UniversityCode"]));
                            cognitivedetails = Regex.Replace(cognitive, @"[^0-9a-zA-Z]+", " ");
                            var specific = new Config().ObjNav().FngetSubjectSpecific(QualityAuditNo, Convert.ToString(Session["UniversityCode"]));
                            specificdetails = Regex.Replace(specific, @"[^0-9a-zA-Z]+", " ");
                    %>
                    <tr>
                        <td><%=specificationscounter%></td>
                        <td><%=knowledge%></td>
                        <td><%=cognitive%></td>
                        <td><%=specific%></td>
                        <td>
                            <label class="btn btn-success" onclick="editlearningaspects();"><i class="fa fa-pencil"></i>Edit</label></td>
                        <td>
                            <label class="btn btn-danger" onclick="deletelearningaspects('<%=specification.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>
                    </tr>
                    <%

                        } %>
                </tbody>
            </table>
        </div>
        <div class="panel panel-default">
            <div class="panel-heading">
                (b)	State the Academic Programme Objectives
            </div>
            <div class="panel-body">
                <div id="Objectivefeedback" runat="server"></div>
                <div class="row">
                    <div class="col-md-9 col-lg-9">
                        <div class="form-group">
                            <strong>Academic Programme Objective</strong>
                            <asp:TextBox runat="server" CssClass="form-control" placeholder="Academic Programme Objective" ID="objectiveinstructions" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="col-md-3 col-lg-3">
                        <div class="form-group">
                            <br />
                            <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Objective" OnClick="addProgrammeObjective_Click" />
                        </div>
                    </div>
                </div>
                <table class="table table-bordered table-striped dataTable">
                    <thead>
                        <tr>
                            <th>Sn</th>
                            <th>Objective</th>
                            <th>Edit</th>
                            <td>Delete</td>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var programmeobject = nav.ProgrammeObjective.Where(r => r.QA_Number == QualityAuditNo);
                            int objectivecounter = 0;
                            string objectivesdetails = "";
                            string University_Code = Convert.ToString(Session["UniversityCode"]);
                            foreach (var programmeobjects in programmeobject)
                            {
                                objectivecounter++;
                                var objectives = new Config().ObjNav().FngetProgrammeObjective(QualityAuditNo, University_Code);
                                objectivesdetails = Regex.Replace(objectives, @"[^0-9a-zA-Z]+", " ");
                        %>
                        <tr>
                            <td><%=objectivecounter%></td>
                            <td><%=objectives %></td>
                            <td>
                                <label class="btn btn-success" onclick="editprogrammeobjectives();"><i class="fa fa-pencil"></i>Edit</label></td>

                            <td>
                                <label class="btn btn-danger" onclick="deleteprogrammeobjectives('<%=programmeobjects.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>
                        </tr>
                        <%

                            } %>
                    </tbody>
                </table>
            </div>
        </div>
        <h3>(c)	Organization of the Academic Programme</h3>
        <div class="panel panel-default">
            <div class="panel-heading">
                (i)	List the distribution of courses per semester for the entire duration of the Academic Programme
            </div>
            <div class="panel-body">
                <!--year of study, semester, course or unit, Specify if Basic; intermediate; Specialist; Optional (drop down)-->
                <div id="coursesdistribution" runat="server"></div>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Year of Study:</strong>
                            <asp:DropDownList runat="server" CssClass="form-control" placeholder="Year of Study" ID="yearofstudy" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Semester:</strong>
                            <asp:DropDownList runat="server" CssClass="form-control" placeholder="Semester" ID="semester" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Course  Unit:</strong>
                            <asp:DropDownList runat="server" CssClass="form-control" placeholder="Course or Unit" ID="coursescode" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Course Types:</strong>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="basicintermediate" />
                        </div>
                    </div>
                    <div class="col-md-3 col-lg-3">
                        <div class="form-group">
                            <br />
                            <asp:Button runat="server" CssClass="btn btn-success btn-block" ID="coursedistributions" Text="Add Course Distribution" OnClick="addDistributionCourses_Click" />
                        </div>
                    </div>
                </div>
                <br />
                <table class="table table-bordered table-striped dataTable">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Year of Study</th>
                            <th>Semester</th>
                            <th>Course or Unit</th>
                            <th>Basic/Intermediate/Specialist/Optional</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var coursedistr = nav.CoursesDistributions.Where(r => r.QA_Number == QualityAuditNo);
                            int coursescount = 0;
                            foreach (var coursedistrs in coursedistr)
                            {
                                coursescount++;
                        %>
                        <tr>
                            <td><%=coursescount%></td>
                            <td><%=coursedistrs.Year_of_Study %></td>
                            <td><%=coursedistrs.Semester %></td>
                            <td><%=coursedistrs.Course_Unit %></td>
                            <td><%=coursedistrs.Basic_Intermediate %></td>
                            <td>
                                <label class="btn btn-success" onclick="editprogrammeorganizations();"><i class="fa fa-pencil"></i>Edit</label></td>

                            <td>
                                <label class="btn btn-danger" onclick="deleteprogrammeorganizations('<%=coursedistrs.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>
                        </tr>
                        <%} %>
                    </tbody>
                </table>

                <div class="panel-body">
                    <div id="instructinaldetailsreasons" runat="server"></div>
                    <div class="form-group">
                        <strong>(ii)	How many instructional hours are allocated to the Academic Programme? </strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="instructionalhours" TextMode="MultiLine" />
                    </div>
                    <div class="form-group">
                        <strong>(d)	What is the rationale for the chosen the structure of the Academic Programme? </strong>
                        <asp:TextBox runat="server" TextMode="MultiLine" CssClass="form-control" ID="programmerationale" />
                    </div>
                    <div class="form-group">
                        <strong>(e)	(i) Has the programme structure been changed over the recent years?</strong><i> (Tick if Yes)</i>
                        <asp:CheckBox runat="server" CssClass="form-control" ID="programmestructure" />
                    </div>
                    <div class="form-group">
                        <strong>(ii) If Yes, state the change(s) and reason(s) for the change. </strong>
                        <asp:TextBox runat="server" CssClass="form-control" TextMode="MultiLine" ID="structurechanges" />
                    </div>
                    <div class="row">
                        <div class="col-md-3 col-lg-3">
                            <div class="form-group">
                                <br />
                                <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Submit Details" OnClick="addProgrammeDetails_Click" />
                            </div>
                        </div>
                    </div>
                    <table class="table table-bordered table-striped dataTable">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Quality Audit No.</th>
                                <th>Programme Structure</th>
                                <th>Instructional Hours</th>
                                <th>Rationale Structure</th>
                                <th>Changes/Reasons</th>
                                <th>Edit</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                var hoursdetails = nav.QualityAudits.Where(r => r.Quality_Audit_No == QualityAuditNo);
                                int hourscount = 0;
                                foreach (var hourscountdetail in hoursdetails)
                                {
                                    hourscount++;
                            %>
                            <tr>
                                <td><%=hourscount%></td>
                                <td><%=hourscountdetail.Quality_Audit_No %></td>
                                <td><%=hourscountdetail.Programme_Structure_Changed %></td>
                                <td><%="" %></td>
                                <td><%=""%></td>
                                <td><%=""%></td>
                                <td>
                                    <label class="btn btn-success" onclick="editprogrammestructure();"><i class="fa fa-pencil"></i>Edit</label></td>
                                <%-- <td><label class="btn btn-danger" onclick="deleteprogrammestructure('<%=hourscountdetail.Quality_Audit_No %>');"><i class="fa fa-trash"></i>Delete</label></td>--%>
                            </tr>
                            <%} %>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="panel-heading">
                        (f)	List the distribution of contact hours and units per subject area 
                    </div>
                    <div class="panel-body">
                        <!-- Subject Area	Unit	Contact Hours	Contact Hours per subject area	Percentage of Total Contact Hours -->
                        <div id="contacthoursfeedback" runat="server"></div>
                        <div class="row">
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <strong>Subject Area:</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" placeholder="Subject Area" ID="subjectarea" />
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <strong>Unit:</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" placeholder="Unit" ID="units" />
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <strong>Contact Hours per Subject Area:</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" placeholder="Contact Hours per Subject Area" ID="contacthours" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3 col-lg-3">
                                    <div class="form-group">
                                        <br />
                                        <asp:Button runat="server" CssClass="btn btn-success btn-block" ID="addcontacthoursdetails" Text="Add Contact Hours" OnClick="addContactHoursDetails_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <table class="table table-bordered table-striped dataTable">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Subject Area</th>
                                    <th>Unit</th>
                                    <th>Contact Hours per Subject Area</th>
                                    <th>Edit</th>
                                    <th>Delete</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    var coursecontacthour = nav.CoursesContactHours.Where(r => r.QA_Number == QualityAuditNo);
                                    int hourscounter = 0;
                                    foreach (var coursecontacthours in coursecontacthour)
                                    {
                                        hourscounter++;
                                %>
                                <tr>
                                    <td><%=hourscounter%></td>
                                    <td><%=coursecontacthours.Subject_Area %></td>
                                    <td><%=coursecontacthours.Unit_Name %></td>
                                    <td><%=coursecontacthours.Contact_Hours_per_Subject %></td>
                                    <td>
                                        <label class="btn btn-success" onclick="editprogrammecontacthours();"><i class="fa fa-pencil"></i>Edit</label></td>
                                    <td>
                                        <label class="btn btn-danger" onclick="deleteprogrammecontacthours('<%=coursecontacthours.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>
                                </tr>
                                <%

                                    } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    (g)	Indicate the distribution of Instructional hours of the Academic Programme per category (as applicable)
                </div>
                <div class="panel-body">
                    <div id="instructionalhousfeedback" runat="server"></div>
                    <table class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>SN</th>
                                <th>Category</th>
                                <th>Instruction Hours</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Laboratory/Farm</td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="labaratoryhpurs" TextMode="MultiLine" /></td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Practicum/Industrial attachment</td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="practicumhours" TextMode="MultiLine" />
                                </td>
                            </tr>
                            <%--  <tr><td>1</td><td>Lectures sessions</td><td><asp:TextBox runat="server" CssClass="form-control"/></td></tr>
                        <tr><td>1</td><td>Tutorial /Open-Learning sessions</td><td><asp:TextBox runat="server" CssClass="form-control"/></td></tr>
                        <tr><td>1</td><td>Laboratory/Practicum sessions</td><td><asp:TextBox runat="server" CssClass="form-control"/></td></tr>
                        <tr><td>1</td><td>Farm or similar practice sessions</td><td><asp:TextBox runat="server" CssClass="form-control"/></td></tr>--%>
                        </tbody>
                    </table>
                    <div class="row">
                        <div class="col-md-3 col-lg-3">
                            <div class="form-group">
                                <asp:Button runat="server" CssClass="btn btn-success btn-block" ID="instructionalhoursdetails" Text="Add Intructional Hours" OnClick="addInstructionalHoursDetails_Click" />
                            </div>
                        </div>
                    </div>
                </div>
                <table class="table table-bordered table-striped dataTable">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Qaulity Audit No.</th>
                            <th>Laboratory/Farm</th>
                            <th>Practicum/Industrial attachment</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var hourdistribution = nav.ProgramAccreditation.Where(r => r.Accreditation_No == QualityAuditNo);
                            int hourdistributioncounter = 0;
                            foreach (var coursecontacthours in coursecontacthour)
                            {
                                hourdistributioncounter++;
                        %>
                        <tr>
                            <td><%=hourdistributioncounter%></td>
                            <td><%=coursecontacthours.QA_Number %></td>
                            <td><%=coursecontacthours.Subject_Area %></td>
                            <td><%=coursecontacthours.Unit_Name %></td>
                            <td>
                                <label class="btn btn-success" onclick="editprogrammeinstructionalhours();"><i class="fa fa-pencil"></i>Edit</label></td>
                            <%--   <td>
                            <label class="btn btn-danger" onclick="deleteprogrammeinstructionalhours('<%=coursecontacthours.QA_Number %>');"><i class="fa fa-trash"></i>Delete</label></td>--%>
                        </tr>
                        <%

                            } %>
                    </tbody>
                </table>
                <div class="panel-body">
                    <div id="academicpublicfeedback" runat="server"></div>
                    <div class="form-group">
                        <strong>(h)	Has the University made public the academic programme/description? </strong><i>(Tick if Yes)</i>
                        <asp:CheckBox runat="server" ID="publiceademic" />
                    </div>
                    <div class="form-group">
                        <strong>(i)	Has the University communicated the specifications/descriptions of the Academic Programme to the following stakeholders? </strong><i>(Tick if Yes)</i>
                        <table>


                            <tr>
                                <td>(i) Staff </td>
                                <td>
                                    <asp:CheckBox runat="server" ID="staff" />
                                </td>
                            </tr>
                            <tr>
                                <td>(ii) Students </td>
                                <td>
                                    <asp:CheckBox runat="server" ID="students" />
                                </td>
                            </tr>
                            <tr>
                                <td>(iii) Employers </td>
                                <td>
                                    <asp:CheckBox runat="server" ID="employers" />

                                </td>

                            </tr>
                            <tr>
                                <td>(iv)	Statutory bodies that accredit higher education programmes &nbsp;&nbsp;&nbsp;&nbsp; </td>
                                <td>
                                    <asp:CheckBox runat="server" ID="statutorybodies" />

                                </td>

                            </tr>
                            <tr>
                                <td>(v)	Regulatory/professional bodies (where applicable) 	  </td>
                                <td>
                                    <asp:CheckBox runat="server" ID="proffessionalbodies" /></td>

                            </tr>
                        </table>
                        <br />
                        <div class="row">
                            <div class="col-md-3 col-lg-3">
                                <div class="form-group">
                                    <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Communication Details" OnClick="addCommunication_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <table class="table table-bordered table-striped dataTable">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Quality Audit No.</th>
                                <th>Staff</th>
                                <th>Students</th>
                                <th>Employers</th>
                                <th>Statutory</th>
                                <th>Requlatory</th>
                                <th>Edit</th>
                                <%-- <th>Delete</th>--%>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                var communicationsdetails = nav.QualityAudits.Where(r => r.Quality_Audit_No == QualityAuditNo);
                                int communicationsdetailscounter = 0;
                                foreach (var communicationsdetail in communicationsdetails)
                                {
                                    communicationsdetailscounter++;
                            %>
                            <tr>
                                <td><%=communicationsdetailscounter%></td>
                                <td><%=communicationsdetail.Quality_Audit_No %></td>
                                <td><%=communicationsdetail.StaffSpecificationCommunicated %></td>
                                <td><%=communicationsdetail.StudentsSpecCommunicated %></td>
                                <td><%=communicationsdetail.EmployersSpecsCommunicated %></td>
                                <td><%=communicationsdetail.StatutorySpecsCommunicated %></td>
                                <td><%=communicationsdetail.RegulatorySpecsCommunciated %></td>
                                <td>
                                    <label class="btn btn-success" onclick="edituniversitycommunications();"><i class="fa fa-pencil"></i>Edit</label></td>
                                <%--                        <td> <label class="btn btn-danger" onclick="deleteuniversitycommunications('<%=communicationsdetail.Quality_Audit_No %>');"><i class="fa fa-trash"></i>Delete</label></td>--%>
                            </tr>
                            <%

                                } %>
                        </tbody>
                    </table>
                </div>
                <div class="form-group">
                    <strong>Key strengths and weaknesses on Programme Description/Specification</strong>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <div class="panel panel-primary">
                                <div id="specificationstrengthfeedback" runat="server"></div>
                                <div class="panel-heading">
                                    Key Strengths
                                </div>
                                <div class="panel-body">
                                    <div class="form-group">
                                        <strong>Strength:</strong>
                                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Strength" ID="specificationstrength" TextMode="MultiLine" />
                                    </div>
                                    <div class="form-group">
                                        <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Strength" OnClick="addSpecificationstrength_Click" />
                                    </div>
                                    <table class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>SN</th>
                                                <th>Strength</th>
                                                <th>Edit</th>
                                                <th>Delete</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                var specificationstrenghts = nav.SpecificationStrenghtsWeaknesses.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Strengths");
                                                int specificationstrenghtCounter = 0;
                                                string specificationstrenghtdetails = "";
                                                foreach (var specificationstrength in specificationstrenghts)
                                                {
                                                    specificationstrenghtCounter++;
                                                    var specificationstrenght = new Config().ObjNav().FngetProgrammeSpecificationStrength(QualityAuditNo, University_Code);
                                                    specificationstrenghtdetails = Regex.Replace(specificationstrenght, @"[^0-9a-zA-Z]+", " ");
                                            %>
                                            <tr>
                                                <td><%=specificationstrenghtCounter%></td>
                                                <td><%=specificationstrenght%></td>
                                                <td>
                                                    <label class="btn btn-success" onclick="editprogrammedescriptionsstrenths();"><i class="fa fa-pencil"></i>Edit</label></td>

                                                <td>
                                                    <label class="btn btn-danger" onclick="deleteprogrammedescriptionsstrenths('<%=specificationstrength.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>

                                            </tr>
                                            <% } %>
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
                                    <div id="specificationweaknessfeedback" runat="server"></div>
                                    <div class="form-group">
                                        <strong>Weakness:</strong>
                                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Weakness" ID="specificationweakness" TextMode="MultiLine" />
                                    </div>
                                    <div class="form-group">
                                        <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Weakness" OnClick="addSpecificationWeakness_Click" />
                                    </div>
                                    <table class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>SN</th>
                                                <th>Weakness</th>
                                                <th>Edit</th>
                                                <th>Delete</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                var speicificationsweaknesses = nav.SpecificationStrenghtsWeaknesses.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Weakness");
                                                int speicificationweaknessescounter = 0;
                                                string specificationsweaknessdetails = "";
                                                foreach (var speicificationsweakness in speicificationsweaknesses)
                                                {
                                                    speicificationweaknessescounter++;
                                                    var specificationsweakness = new Config().ObjNav().FngetProgrammeSpecificationWeakness(QualityAuditNo, University_Code);
                                                    specificationsweaknessdetails = Regex.Replace(specificationsweakness, @"[^0-9a-zA-Z]+", " ");
                                            %>
                                            <tr>
                                                <td><%=speicificationweaknessescounter%></td>
                                                <td><%=specificationsweakness%></td>
                                                <td>
                                                    <label class="btn btn-success" onclick="editprogrammedescriptionsweakness();"><i class="fa fa-pencil"></i>Edit</label></td>

                                                <td>
                                                    <label class="btn btn-danger" onclick="deleteprogrammedescriptionsweakness('<%=speicificationsweakness.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>
                                            </tr>
                                            <%} %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="next_Click" />
                <div class="clearfix"></div>
            </div>
        </div>
        <% }
            else if (currentStep == 5)
            {
        %>
        <div class="panel panel-primary">
            <div class="panel-heading">
                5.	Programme Content/Curriculum 
            <label class="pull-right">Step <%=currentStep %> of <%=maxStep %></label>
                <div class="clearfix"></div>
            </div>
            <div class="panel-body">
                <div id="programmereviewedfeedback" runat="server"></div>
                <div class="form-group">
                    <strong>(a)	Has the Academic Programme been reviewed? </strong><i>(Tick if yes)</i>
                    <asp:CheckBox runat="server" ID="programmereviewd" />
                </div>
                <div class="form-group">
                    <strong>(b)	If Yes in 5 (a), Upload the Reviewed Academic Programme </strong>
                    <asp:FileUpload CssClass="form-control" runat="server" />
                </div>
                <div class="row">
                    <div class="col-md-3 col-lg-3">
                        <div class="form-group">
                            <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Programme Content" OnClick="addProgrammeContent_Click" />
                        </div>
                    </div>
                </div>
                <table class="table table-bordered table-striped dataTable">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Quality Audit No.</th>
                            <th>Programme Reviewed</th>
                            <th>Attached Reviewed Programme</th>
                            <th>Download</th>
                            <th>Edit</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var reviewdetails = nav.QualityAudits.Where(r => r.Quality_Audit_No == QualityAuditNo);
                            int reviewcounter = 0;
                            foreach (var review in reviewdetails)
                            {
                                reviewcounter++;

                        %>
                        <tr>
                            <td><%=reviewcounter%></td>
                            <td><%=review.Quality_Audit_No%></td>
                            <td><%=review.Programme_Reviewed %></td>
                            <td><%="" %></td>
                            <td><%=""%></td>
                            <td>
                                <label class="btn btn-success" onclick="editprogrammereviewdetails();"><i class="fa fa-pencil"></i>Edit</label></td>
                            <%--<td><label class="btn btn-danger" onclick="deleteprogrammereviewdetails('<%=review.Quality_Audit_No %>');"><i class="fa fa-trash"></i>Delete</label></td>--%>
                        </tr>
                        <%} %>
                    </tbody>
                </table>
            </div>
            <div class="form-group">
                <strong>Key Strengths and Weaknesses on Programme Content/Curriculum</strong>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <div class="panel panel-primary">
                            <div id="contentstrenthfeedback" runat="server"></div>
                            <div class="panel-heading">
                                Key Strengths
                            </div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <strong>Strength:</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" placeholder="Strength" ID="programcontentstrength" TextMode="MultiLine" />
                                </div>
                                <div class="form-group">
                                    <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Strength" OnClick="addProgramContentStrenght_Click" />
                                </div>
                                <table class="table table-bordered table-striped dataTable">
                                    <thead>
                                        <tr>
                                            <th>SN</th>
                                            <th>Strength</th>
                                            <th>Edit</th>
                                            <th>Delete</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            var contentstrenghts = nav.ProgramContentStrenght_Weaknes.Where(r => r.QA_Number == QualityAuditNo && r.Category == " Key Strengths");
                                            int contenttrenghtsCounter = 0;
                                            string University_Code = Convert.ToString(Session["UniversityCode"]);
                                            string specificationsstrengthdetails = "";
                                            foreach (var contentstrenght in contentstrenghts)
                                            {
                                                contenttrenghtsCounter++;
                                                var specificationsstrength = new Config().ObjNav().FngetProgrammeContentStrengths(QualityAuditNo, University_Code);
                                                specificationsstrengthdetails = Regex.Replace(specificationsstrength, @"[^0-9a-zA-Z]+", " ");
                                        %>
                                        <tr>
                                            <td><%=contenttrenghtsCounter%></td>
                                            <td><%=specificationsstrength%></td>
                                            <td>
                                                <label class="btn btn-success" onclick="editprogrammecontentstrengths();"><i class="fa fa-pencil"></i>Edit</label></td>
                                            <td>
                                                <label class="btn btn-danger" onclick="deleteprogrammecontentstrengths('<%=contentstrenght.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>
                                        </tr>
                                        <%} %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="panel panel-primary">
                            <div id="contentweaknessfeedback" runat="server"></div>
                            <div class="panel-heading">
                                Key Weaknesses
                            </div>
                            <div class="panel-body">

                                <div class="form-group">
                                    <strong>Weakness:</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" placeholder="Weakness" ID="programcontentweakness" TextMode="MultiLine" />
                                </div>
                                <div class="form-group">
                                    <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Weakness" OnClick="addProgramContentWeaknesses_Click" />
                                </div>
                                <table class="table table-bordered table-striped dataTable">
                                    <thead>
                                        <tr>
                                            <th>SN</th>
                                            <th>Weakness</th>
                                            <th>Edit</th>
                                            <th>Delete</th>

                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            var contentstrengths = nav.ProgramContentStrenght_Weaknes.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Weakness");
                                            int contentsweakcounter = 0;
                                            string specificationsweaknessdetails = "";
                                            foreach (var contentstrength in contentstrengths)
                                            {
                                                contentsweakcounter++;
                                                var specificationsweakness = new Config().ObjNav().FngetProgrammeContentWeakness(QualityAuditNo, University_Code);
                                                specificationsweaknessdetails = Regex.Replace(specificationsweakness, @"[^0-9a-zA-Z]+", " ");
                                        %>
                                        <tr>
                                            <td><%=contentsweakcounter%></td>
                                            <td><%=specificationsweakness%></td>
                                            <td>
                                                <label class="btn btn-success" onclick="editprogrammecontentweakness();"><i class="fa fa-pencil"></i>Edit</label></td>
                                            <td>
                                                <label class="btn btn-danger" onclick="deleteprogrammecontentweakness('<%=contentstrength.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>
                                        </tr>
                                        <%  } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="next_Click" />
                <div class="clearfix"></div>
            </div>
        </div>
        <% }
            else if (currentStep == 6)
            {
        %>
        <div class="panel panel-primary">
            <div class="panel-heading">
                6.	Organization of the Programme
            <label class="pull-right">Step <%=currentStep %> of <%=maxStep %></label>
                <div class="clearfix"></div>
            </div>
            <div class="panel-body">
                <div id="academicorganizationfeedback" runat="server"></div>
                <div class="form-group">
                    <strong>(a)	Specify the academic calendar in which the Academic Programme is organised:</strong>
                    <br />
                    <table>
                        <tr>
                            <td>(i)Semesters  </td>
                            <td>
                                <asp:CheckBox runat="server" ID="semesterprogramme" /><br />
                            </td>
                        </tr>
                        <tr>
                            <td>(ii)Trimesters&nbsp;&nbsp;&nbsp;&nbsp;  </td>
                            <td>
                                <asp:CheckBox runat="server" ID="trimestersprogramme" /><br />
                            </td>
                        </tr>
                        <tr>
                            <td>(iii)Quarters 	 </td>
                            <td>
                                <asp:CheckBox runat="server" ID="quartersprogramme" /><br />
                            </td>
                        </tr>
                    </table>
                    (iv)	Other (specify)
                    <asp:TextBox runat="server" CssClass="form-control" ID="othersprogramme" TextMode="MultiLine" /><br />
                </div>
                <div class="form-group">
                    <strong>(b)	(i) Does the department use a Credit Points System? </strong><i>(Tick if yes)</i>
                    <asp:CheckBox runat="server" ID="creditspointsdepartment" />
                </div>
                <div class="form-group">
                    <strong>(ii) If Yes, how are credits calculated? </strong>
                    <asp:TextBox runat="server" TextMode="MultiLine" CssClass="form-control" ID="creditscalculation" />
                </div>
                <div class="form-group">
                    <strong>(c)	Has the feedback of those involved in the academic programme being sought? </strong><i>(Tick if yes)</i>
                    <br />
                    <table>
                        <tr>
                            <td>(i)Students  </td>
                            <td>
                                <asp:CheckBox runat="server" ID="studentsfeedback" />
                            </td>
                        </tr>
                        <tr>
                            <td>(ii)Academic Staff &nbsp;&nbsp;&nbsp;&nbsp;	  </td>
                            <td>
                                <asp:CheckBox runat="server" ID="academicstafffeedback" />
                            </td>
                        </tr>
                        <tr>
                            <td>(iii)Alumni	</td>
                            <td>
                                <asp:CheckBox runat="server" ID="alumnifeedback" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="row">
                    <div class="col-md-3 col-lg-3">
                        <div class="form-group">
                            <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Organization Programme" OnClick="addOrganizationProgramme_Click" />
                        </div>
                    </div>
                </div>

                <table class="table table-bordered table-striped dataTable">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Quality Audit No.</th>
                            <th>Semesters</th>
                            <th>Trimesters</th>
                            <th>Quarters</th>
                            <th>Credit Point System</th>
                            <th>Edit</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var organizationdetails = nav.QualityAudits.Where(r => r.Quality_Audit_No == QualityAuditNo);
                            int rorganizationcounter = 0;
                            foreach (var organization in organizationdetails)
                            {
                                rorganizationcounter++;

                        %>
                        <tr>
                            <td><%=rorganizationcounter%></td>
                            <td><%=organization.Quality_Audit_No%></td>
                            <td><%=organization.Semesters_Programme_Calender %></td>
                            <td><%=organization.Trimesters_Programme_Calender %></td>
                            <td><%=organization.Quarters_Programme_Calender %></td>
                            <td><%=organization.Use_Credit_Point_System %></td>
                            <td>
                                <label class="btn btn-success" onclick="editacademiccalenderdetails();"><i class="fa fa-pencil"></i>Edit</label></td>
                            <%-- <td>
                        <label class="btn btn-danger" onclick="deleteacademiccalenderdetails('<%=organization.Quality_Audit_No %>');"><i class="fa fa-trash"></i>Delete</label></td>--%>
                        </tr>
                        <%} %>
                    </tbody>
                </table>
            </div>
            <div class="form-group">
                <strong>Key strengths and weaknesses on Organization Programme</strong>
                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <div class="panel panel-primary">
                            <div id="programorganizationstrengthfeedback" runat="server"></div>
                            <div class="panel-heading">
                                Key Strengths
                            </div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <strong>Strength:</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" placeholder="Strength" ID="organizationstrength" TextMode="MultiLine" />
                                </div>
                                <div class="form-group">
                                    <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Strength" OnClick="addOrganizationStrength_Click" />
                                </div>
                                <table class="table table-bordered table-striped dataTable">
                                    <thead>
                                        <tr>
                                            <th>SN</th>
                                            <th>Strength</th>
                                            <th>Edit</th>
                                            <th>Delete</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            var organizationstrenghts = nav.OrganizationStrenght_Weakness.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Strengths");
                                            int organizationstrenghtsCounter = 0;
                                            string programorganizationstrengthdetails = "";
                                            string University_Code = Convert.ToString(Session["UniversityCode"]);
                                            foreach (var organizationstrenght in organizationstrenghts)
                                            {
                                                organizationstrenghtsCounter++;
                                                var programorganizationstrength = new Config().ObjNav().FngetProgrammeOrganizationStrengths(QualityAuditNo, University_Code);
                                                programorganizationstrengthdetails = Regex.Replace(programorganizationstrength, @"[^0-9a-zA-Z]+", " ");
                                        %>
                                        <tr>
                                            <td><%=organizationstrenghtsCounter%></td>
                                            <td><%=programorganizationstrength%></td>
                                            <td>
                                                <label class="btn btn-success" onclick="editorganizationalprogrammestrengths();"><i class="fa fa-pencil"></i>Edit</label></td>
                                            <td>
                                                <label class="btn btn-danger" onclick="deleteorganizationalprogrammestrengths('<%=organizationstrenght.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>

                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="panel panel-primary">
                            <div id="organizationweaknessfeedback" runat="server"></div>
                            <div class="panel-heading">
                                Key Weaknesses
                            </div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <strong>Weakness:</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" placeholder="Weakness" ID="organizationweakness" TextMode="MultiLine" />
                                </div>
                                <div class="form-group">
                                    <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Weakness" OnClick="addOrganizationWeaknesses_Click" />
                                </div>
                                <table class="table table-bordered table-striped dataTable">
                                    <thead>
                                        <tr>
                                            <th>SN</th>
                                            <th>Weakness</th>
                                            <th>Edit</th>
                                            <th>Delete</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            var organizationweaknesses = nav.OrganizationStrenght_Weakness.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Weakness");
                                            int organizationweaknessescounter = 0;
                                            string Programorganizationweaknessdetails = "";
                                            foreach (var organizationweakness in organizationweaknesses)
                                            {
                                                organizationweaknessescounter++;
                                                var Programorganizationweakness = new Config().ObjNav().FngetProgrammeOrganizationWeakness(QualityAuditNo, University_Code);
                                                Programorganizationweaknessdetails = Regex.Replace(Programorganizationweakness, @"[^0-9a-zA-Z]+", " ");
                                        %>
                                        <tr>
                                            <td><%=organizationweaknessescounter%></td>
                                            <td><%=Programorganizationweakness%></td>
                                            <td>
                                                <label class="btn btn-success" onclick="editorganizationalprogrammeweakness();"><i class="fa fa-pencil"></i>Edit</label></td>
                                            <td>
                                                <label class="btn btn-danger" onclick="deleteorganizationalprogrammeweakness('<%=organizationweakness.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="next_Click" />
                <div class="clearfix"></div>
            </div>
        </div>
        <% }
            else if (currentStep == 7)
            {
        %>
        <div class="panel panel-primary">
            <div class="panel-heading">
                7.	Didactic Concept and Teaching/Learning Strategy
            <label class="pull-right">Step  <%=currentStep %> of <%=maxStep %></label>
                <div class="clearfix"></div>
            </div>
            <div class="panel-body">
                <div id="didecticconceptfeedback" runat="server"></div>
                <div class="form-group">
                    <strong>(a)	Provide the didactic and pedagogical approaches of the Academic Programme.
                        <br />
                    </strong>
                    <table>
                        <tr>
                            <td>(i) Lecture   </td>
                            <td>
                                <asp:CheckBox runat="server" ID="lecture" />
                            </td>
                        </tr>
                        <tr>
                            <td>(ii) Discussion	   </td>
                            <td>
                                <asp:CheckBox runat="server" ID="discussion" />
                            </td>
                        </tr>
                        <tr>
                            <td>(iii) Question/answer  </td>
                            <td>
                                <asp:CheckBox runat="server" ID="question" />
                            </td>
                        </tr>
                        <tr>
                            <td>(iv) Brainstorming	 </td>
                            <td>
                                <asp:CheckBox runat="server" ID="brainstorming" />
                            </td>
                        </tr>
                        <tr>
                            <td>(v) Buzz groups </td>
                            <td>
                                <asp:CheckBox runat="server" ID="buzzgroups" />
                            </td>
                        </tr>
                        <tr>
                            <td>(vi) Role Plays </td>
                            <td>
                                <asp:CheckBox runat="server" ID="roleplays" />
                            </td>
                        </tr>
                        <tr>
                            <td>(vii) Class experiment </td>
                            <td>
                                <asp:CheckBox runat="server" ID="classexperiment" />
                            </td>
                        </tr>
                        <tr>
                            <td>(viii) Project/case study method	 </td>
                            <td>
                                <asp:CheckBox runat="server" ID="casestudymethod" />
                            </td>
                        </tr>
                        <tr>
                            <td>(ix) Demonstration/illustrations	 </td>
                            <td>
                                <asp:CheckBox runat="server" ID="demonstration" />
                            </td>
                        </tr>
                        <tr>
                            <td>(x)Field study/local environment trail method &nbsp;&nbsp;&nbsp;&nbsp;&nbsp </td>
                            <td>
                                <asp:CheckBox runat="server" ID="fieldstudy" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="form-group">
                    <strong>(b)	Is Information and Communication technology (ICT) integrated in the Academic Programme?</strong> <i>(Tick if yes)</i>
                    <asp:CheckBox runat="server" ID="ictacademic" />
                </div>
                <div class="form-group">
                    <strong>(c)	 (i) Is research part of the Academic Programme?</strong> <i>(Tick if yes)</i>
                    <asp:CheckBox runat="server" ID="researchcademic" />
                </div>
                <div class="form-group">
                    <strong>(ii)  Indicate which course(s) exposes students to research methods?</strong> <i>(Tick if yes)</i>
                    <asp:CheckBox runat="server" ID="coursemethods" />
                </div>
                <div class="form-group">
                    <strong>(iii)  When are students taught research methods in the academic programme? Provide Year and Semester. </strong>
                    <div class="row">
                        <div class="col-md-6 col-lg-6 col-sm-6">
                            <div class="form-group"><strong>Year</strong><asp:DropDownList runat="server" CssClass="form-control" ID="researchmethodyear" /></div>
                        </div>

                        <div class="col-md-6 col-lg-6 col-sm-6">
                            <div class="form-group"><strong>Semester</strong><asp:DropDownList runat="server" CssClass="form-control" ID="reasearchmethodsemester" /></div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <strong>(d)	Does the Academic Programme require students to undertake community/industrial attachment/internship (specify) as part of the practical teaching and learning strategies?  </strong><i>(Tick if yes)</i>
                    <asp:CheckBox runat="server" ID="requireattachment" />
                </div>

                <div class="form-group">
                    <strong>(e)	If yes in 7 (d), Provide the community/industrial attachment/internship, duration and credit points in the Academic Programme  </strong>
                    <div class="row">
                        <div class="col-lg-4 col-md-4">
                            <div class="form-group"><strong>Type of Community/Industrial attachment</strong><asp:TextBox runat="server" CssClass="form-control" ID="industrialattachment" /></div>
                        </div>

                        <div class="col-lg-4 col-md-4">
                            <div class="form-group"><strong>Duration (in Months)</strong><asp:TextBox runat="server" CssClass="form-control" ID="durations" /></div>
                        </div>

                        <div class="col-lg-4 col-md-4">
                            <div class="form-group"><strong>Credit Points</strong><asp:TextBox runat="server" CssClass="form-control" ID="creditpoints" /></div>
                        </div>

                    </div>
                    <div class="form-group">
                        <strong>(f)	Is community/industrial attachment/internship a compulsory part of the programme? </strong><i>(Tick if yes)</i>
                        <asp:CheckBox runat="server" ID="internshipcompulsory" />
                    </div>
                    <div class="row">
                        <div class="col-md-3 col-lg-3">
                            <div class="form-group">
                                <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Organization Programme" OnClick="addDedacticConcept_Click" />
                            </div>
                        </div>
                    </div>
                    <table class="table table-bordered table-striped dataTable">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Quality Audit No.</th>
                                <th>Lecture </th>
                                <th>Discussion </th>
                                <th>Question</th>
                                <th>Brainstorming </th>
                                <th>Edit</th>
                                <th>Delete</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                var didacticconcepts = nav.DidacticConceptStrategy.Where(r => r.QA_Number == QualityAuditNo);
                                int didacticcounter = 0;
                                foreach (var didacticconcept in didacticconcepts)
                                {
                                    didacticcounter++;

                            %>
                            <tr>
                                <td><%=didacticcounter%></td>
                                <td><%=didacticconcept.QA_Number%></td>
                                <td><%=didacticconcept.Lecture %></td>
                                <td><%=didacticconcept.Discussion %></td>
                                <td><%=didacticconcept.Question_answer %></td>
                                <td><%=didacticconcept.Brainstorming %></td>
                                <td>
                                    <label class="btn btn-success" onclick="editdidacticconcepts();"><i class="fa fa-pencil"></i>Edit</label></td>
                                <td>
                                    <label class="btn btn-danger" onclick="deletedidacticconcepts('<%=didacticconcept.QA_Number %>');"><i class="fa fa-trash"></i>Delete</label></td>
                            </tr>
                            <%} %>
                        </tbody>
                    </table>
                    <strong>(g)	Key Strengths and Weaknesses on community/industrial attachment/internship of the Academic Programme </strong>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Key Strengths
                                </div>
                                <div class="panel-body">
                                    <div id="internshipfeedback" runat="server"></div>
                                    <div class="form-group">
                                        <strong>Strength:</strong>
                                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Strength" ID="internshipstrength" TextMode="MultiLine" />
                                    </div>
                                    <div class="form-group">
                                        <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Strength" OnClick="addInternshipStregnth_Click" />
                                    </div>
                                    <table class="table table-bordered table-striped dataTable">
                                        <thead>
                                            <tr>
                                                <th>SN</th>
                                                <th>Strength</th>
                                                <td>Edit</td>
                                                <td>Delete</td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                var internshipstrenght = nav.InternshipStrenghtsWeakness.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Strength");
                                                int attachocounter = 0;
                                                string University_Code = Convert.ToString(Session["UniversityCode"]);
                                                string programinternshipstrengthdetails = "";
                                                foreach (var internshipstrenghts in internshipstrenght)
                                                {
                                                    attachocounter++;
                                                    var programinternshipstrength = new Config().ObjNav().FngetProgrammeAttachmentStrength(QualityAuditNo, University_Code);
                                                    programinternshipstrengthdetails = Regex.Replace(programinternshipstrength, @"[^0-9a-zA-Z]+", " ");
                                            %>
                                            <tr>
                                                <td><%=attachocounter%></td>
                                                <td><%=programinternshipstrengthdetails %></td>
                                                <td>
                                                    <label class="btn btn-success" onclick="editdidacticconceptstrengths();"><i class="fa fa-pencil"></i>Edit</label></td>
                                                <td>
                                                    <label class="btn btn-danger" onclick="deletedidacticconceptstrengths('<%=internshipstrenghts.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>
                                            </tr>
                                            <%

                                                }
                                            %>
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
                                    <div id="wekanessesfeedback" runat="server"></div>
                                    <div class="form-group">
                                        <strong>Weakness:</strong>
                                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Weakness" ID="internshipweakness" TextMode="MultiLine" />
                                    </div>
                                    <div class="form-group">
                                        <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Weakness" OnClick="addInternshipWeakness_Click" />
                                    </div>
                                    <table class="table table-bordered table-striped dataTable">
                                        <thead>
                                            <tr>
                                                <th>SN</th>
                                                <th>Weakness</th>
                                                <th>Edit</th>
                                                <th>Delete</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                var internshipweakness = nav.InternshipStrenghtsWeakness.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Weakness");
                                                int weaknesscounter = 0;
                                                string programinternshipweaknessdetails = "";
                                                foreach (var internshipweaknesss in internshipweakness)
                                                {
                                                    weaknesscounter++;
                                                    var programinternshipweakness = new Config().ObjNav().FngetProgrammeAttachmentWeakness(QualityAuditNo, University_Code);
                                                    programinternshipweaknessdetails = Regex.Replace(programinternshipweakness, @"[^0-9a-zA-Z]+", " ");
                                            %>
                                            <tr>
                                                <td><%=weaknesscounter%></td>
                                                <td><%=programinternshipweakness %></td>
                                                <td>
                                                    <label class="btn btn-success" onclick="editdidacticconceptweakness();"><i class="fa fa-pencil"></i>Edit</label></td>
                                                <td>
                                                    <label class="btn btn-danger" onclick="deletedidacticconceptweakness('<%=internshipweaknesss.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>
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
                    <div class="form-group">
                        <strong>(h)  Identify key strengths and weaknesses of your other didactic and pedagogical approaches of the academic programme?</strong>
                        <div class="row">
                            <div class="col-md-6 col-lg-6">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        Key Strengths
                                    </div>
                                    <div class="panel-body">
                                        <div id="didacticfeedbackstrenght" runat="server"></div>
                                        <div class="form-group">
                                            <strong>Strength:</strong>
                                            <asp:TextBox runat="server" CssClass="form-control" placeholder="Strength" ID="didacticstrenght" TextMode="MultiLine" />
                                        </div>
                                        <div class="form-group">
                                            <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Strength" OnClick="addDidacticStrengths_Click" />
                                        </div>
                                        <table class="table table-bordered table-striped dataTable">
                                            <thead>
                                                <tr>
                                                    <th>SN</th>
                                                    <th>Strength</th>
                                                    <th>Edit</th>
                                                    <th>Delete</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    var didacticstrenght = nav.DidacticStrenghtsWeakness.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Strength");
                                                    int didacticconceptcounter = 0;
                                                    string programdidacticstrenthdetails = "";
                                                    foreach (var didacticstrenghts in didacticstrenght)
                                                    {
                                                        didacticconceptcounter++;
                                                        var programdidacticstrenths = new Config().ObjNav().FngetProgrammeDidacticStrength(QualityAuditNo, University_Code);
                                                        programdidacticstrenthdetails = Regex.Replace(programdidacticstrenths, @"[^0-9a-zA-Z]+", " ");
                                                %>
                                                <tr>
                                                    <td><%=didacticconceptcounter%></td>
                                                    <td><%=programdidacticstrenths %></td>
                                                    <td>
                                                        <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                                    <td>
                                                        <label class="btn btn-danger" onclick="deleteprogramdidacticstrenths('<%=didacticstrenghts.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>
                                                </tr>
                                                <%

                                                    }
                                                %>
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
                                        <div id="didacticweaknessesfeedback" runat="server"></div>
                                        <div class="form-group">
                                            <strong>Weakness:</strong>
                                            <asp:TextBox runat="server" CssClass="form-control" placeholder="Weakness" ID="didacticweaknesses" TextMode="MultiLine" />
                                        </div>
                                        <div class="form-group">
                                            <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Weakness" OnClick="addDidacticWeaknesses_Click" />
                                        </div>
                                        <table class="table table-bordered table-striped dataTable">
                                            <thead>
                                                <tr>
                                                    <th>SN</th>
                                                    <th>Weakness</th>
                                                    <th>Edit</th>
                                                    <th>Delete</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <%
                                                        var didacticweaknesses = nav.DidacticStrenghtsWeakness.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Weakness");
                                                        int didacticcounters = 0;
                                                        string programdidacticweaknessdetails = "";
                                                        foreach (var didacticweaknessess in didacticweaknesses)
                                                        {
                                                            didacticcounters++;
                                                            var programdidacticweakness = new Config().ObjNav().FngetProgrammeDidacticWeakness(QualityAuditNo, University_Code);
                                                            programdidacticweaknessdetails = Regex.Replace(programdidacticweakness, @"[^0-9a-zA-Z]+", " ");
                                                    %>
                                                <tr>
                                                    <td><%=didacticcounters%></td>
                                                    <td><%=programdidacticweakness%></td>
                                                    <td>
                                                        <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                                    <td>
                                                        <label class="btn btn-danger" onclick="deletedidacticweaknesses('<%=didacticweaknessess.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>
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
                    <div class="panel-footer">
                        <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
                        <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="next_Click" />
                        <div class="clearfix"></div>
                    </div>
                </div>
                <% }
                    else if (currentStep == 8)
                    {
                %>
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        8.	Student Assessment 
            <label class="pull-right">Step <%=currentStep %> of <%=maxStep %></label>
                        <div class="clearfix"></div>
                    </div>
                    <div class="panel-body">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                (a)	Identify the variety of assessment methods of the Academic Programme
                            </div>
                            <div class="panel-body">
                                <div id="assessmentfeedback" runat="server"></div>
                                <table class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th>Sn</th>
                                            <th>Assessment Method</th>
                                            <th>Check if Applicable</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <tr>
                                            <td>1</td>
                                            <td>Sit in Continuous Assessment Tests </td>
                                            <td>
                                                <asp:CheckBox runat="server" ID="sitcats" /></td>
                                        </tr>
                                        <tr>
                                            <td>2</td>
                                            <td>Take Away Continuous Assessment Test   </td>
                                            <td>
                                                <asp:CheckBox runat="server" ID="takecats" /></td>
                                        </tr>
                                        <tr>
                                            <td>3</td>
                                            <td>Term Papers  </td>
                                            <td>
                                                <asp:CheckBox runat="server" ID="termpapers" /></td>
                                        </tr>
                                        <tr>
                                            <td>4</td>
                                            <td>Sit-In Examinations   </td>
                                            <td>
                                                <asp:CheckBox runat="server" ID="sitinexams" /></td>
                                        </tr>
                                        <tr>
                                            <td>5</td>
                                            <td>Re-Sit Examinations   </td>
                                            <td>
                                                <asp:CheckBox runat="server" ID="resitexams" /></td>
                                        </tr>
                                        <tr>
                                            <td>6</td>
                                            <td>Re-Take Examinations   </td>
                                            <td>
                                                <asp:CheckBox runat="server" ID="retakeexams" /></td>
                                        </tr>
                                        <tr>
                                            <td>7</td>
                                            <td>Supplementary Examinations   </td>
                                            <td>
                                                <asp:CheckBox runat="server" ID="supexams" /></td>
                                        </tr>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="form-group">
                            <strong>(b)	How long does it take to release results from the time:</strong><br />
                            <strong><i>i. Examinations are ministered.</i></strong><br />
                            <asp:TextBox ID="TextBox106" runat="server" CssClass="form-control" TextMode="MultiLine" />
                            <strong><i>ii. Dissertations/thesis/projects have been submitted.</i></strong>
                            <asp:TextBox ID="examreleasetime" runat="server" CssClass="form-control" TextMode="MultiLine" />
                        </div>
                        <div class="form-group">
                            <strong>(c) (i)Do you use the GPA system?</strong><i>Tick if yes</i>
                            <asp:CheckBox runat="server" ID="usegpasystem" />
                        </div>
                        <div class="row">
                            <div class="col-md-3 col-lg-3">
                                <div class="form-group">
                                    <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Student Assessment" OnClick="addStudentAssessment_Click" />
                                </div>
                            </div>
                        </div>
                        <table class="table table-bordered table-striped dataTable">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Quality Audit No.</th>
                                    <th>Sit in CATS </th>
                                    <th>Take Ways CATS </th>
                                    <th>Term Papers</th>
                                    <th>Sit In Exams </th>
                                    <th>Resit Exams</th>
                                    <th>ReTake Exams</th>
                                    <th>Sup Exams</th>
                                    <th>Edit</th>
                                    <th>Delete</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    var studentsassments = nav.Students_Assessment.Where(r => r.QA_Number == QualityAuditNo);
                                    int assescounter = 0;
                                    foreach (var studentsassment in studentsassments)
                                    {
                                        assescounter++;

                                %>
                                <tr>
                                    <td><%=assescounter%></td>
                                    <td><%=studentsassment.QA_Number%></td>
                                    <td><%=studentsassment.Sit_in_CATS %></td>
                                    <td><%=studentsassment.Take_Aways_CATS %></td>
                                    <td><%=studentsassment.Term_Papers %></td>
                                    <td><%=studentsassment.Sit_In_Examinations %></td>
                                    <td><%=studentsassment.Re_Sit_Examinations %></td>
                                    <td><%=studentsassment.Re_Take_Examinations %></td>
                                    <td><%=studentsassment.Supplementary_Examinations %></td>
                                    <td>
                                        <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                    <td>
                                        <label class="btn btn-danger" onclick="deletestudentsassments('<%=studentsassment.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>
                                </tr>
                                <%} %>
                            </tbody>
                        </table>
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                (c)	 (ii)If yes in c(i), Enter the Grading of the Academic Programme
                            </div>
                            <div class="panel-body">
                                <div id="gradingsystemfeedback" runat="server"></div>
                                <table class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th>Sn</th>
                                            <th>Grade</th>
                                            <th>Score Range </th>
                                            <th>GPA Points </th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <tr>
                                            <td>1</td>
                                            <td id="gradeA">A</td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" ID="gradAscorerange" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" ID="gradeAgpapoints" /></td>

                                        </tr>
                                        <tr>
                                            <td>2</td>
                                            <td>B</td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" ID="gradeBscorerange" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" ID="gradeBgpapoints" /></td>

                                        </tr>
                                        <tr>
                                            <td>3</td>
                                            <td>C</td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" ID="gradeCscorerange" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" ID="gradeCgpapoints" /></td>
                                        </tr>
                                        <tr>
                                            <td>4</td>
                                            <td>D</td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" ID="gradeDscorerange" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" ID="gradeDgpapoints" /></td>
                                        </tr>
                                        <tr>
                                            <td>5</td>
                                            <td>E</td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" ID="gradeEscorerange" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" ID="gradeEgpapoints" /></td>
                                        </tr>

                                    </tbody>
                                </table>
                                <div class="row">
                                    <div class="col-md-3 col-lg-3">
                                        <div class="form-group">
                                            <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Programme Grading" OnClick="addProgrammeGrading_Click" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <table class="table table-bordered table-striped dataTable">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Quality Audit No.</th>
                                        <th>Grade </th>
                                        <th>Score Range </th>
                                        <th>GPA Points</th>
                                        <th>Edit</th>
                                        <th>Delete</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        var studentsassmentss = nav.Students_Assessment.Where(r => r.QA_Number == QualityAuditNo);
                                        int assescounters = 0;
                                        foreach (var studentsassment in studentsassmentss)
                                        {
                                            assescounters++;

                                    %>
                                    <tr>
                                        <td><%=assescounter%></td>
                                        <td><%=studentsassment.QA_Number%></td>
                                        <td><%=studentsassment.Sit_in_CATS %></td>
                                        <td><%=studentsassment.Take_Aways_CATS %></td>
                                        <td><%=studentsassment.Term_Papers %></td>
                                        <td>
                                            <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                        <td>
                                            <label class="btn btn-danger" onclick="deleteprogrammegrading('<%=studentsassment.QA_Number %>');"><i class="fa fa-trash"></i>Delete</label></td>
                                    </tr>
                                    <%} %>
                                </tbody>
                            </table>
                        </div>
                        <div id="antiplagiarismfeedback" runat="server"></div>
                        <div class="form-group">
                            <strong>(iii)	Is the grading/marking criteria; and the pass/fail criteria published to students? </strong><i>(Tick if yes)</i>
                            <asp:CheckBox runat="server" ID="passfailcriteria" />
                        </div>
                        <div class="form-group">
                            <strong>(iv)	In which ways are assessment/examination regulations and procedures communicated to students? </strong><i>(Tick the ones applicable)</i><br />
                            <table>
                                <tr>
                                    <td>•	Memos	  </td>
                                    <td>
                                        <asp:CheckBox runat="server" ID="memocommunication" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>• Newsletters/Posters/Emails  </td>
                                    <td>
                                        <asp:CheckBox runat="server" ID="newslettercommunications" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>•	Meetings 	 </td>
                                    <td>
                                        <asp:CheckBox runat="server" ID="meetingscommunications" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>•	Conferences			 </td>
                                    <td>
                                        <asp:CheckBox runat="server" ID="conferencecommunication" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>•	Announcements of the Results&nbsp;&nbsp;&nbsp;&nbsp; </td>
                                    <td>
                                        <asp:CheckBox runat="server" ID="announcementscommunication" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>•	Students Handbook			 </td>
                                    <td>
                                        <asp:CheckBox runat="server" ID="studentshandbook" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>•	Student website			 </td>
                                    <td>
                                        <asp:CheckBox runat="server" ID="studentswebsite" />
                                    </td>
                                </tr>
                            </table>
                            <br />
                            •	Other (specify) 
                            <br />
                            <asp:TextBox runat="server" ID="otherspecify" CssClass="form-control" TextMode="MultiLine" />
                            <br />
                        </div>
                        <div class="form-group">
                            <strong>(v)	Is there a mechanism of capturing students’ complaints and level of satisfaction on the assessment/examination regulations and procedures?  </strong><i>(Tick if yes)</i>
                            <asp:CheckBox runat="server" ID="capturingcompalints" />
                        </div>
                        <div class="form-group">
                            <strong>(d)	 Does the university have an examination board at relevant levels?   </strong><i>(Tick if yes)</i>
                            <asp:CheckBox runat="server" ID="examinationboard" />
                        </div>
                        <div class="form-group">
                            <strong>(e)	 Does the University have  an anti-plagiarism policy?   </strong><i>(Tick if yes)</i>
                            <asp:CheckBox runat="server" ID="antiplagiarismpolicy" />
                        </div>
                        <div class="form-group">
                            <strong>(f)	 Does the University have Anti-plagiarism software?   </strong><i>(Tick if yes)</i>
                            <asp:CheckBox runat="server" ID="antiplagiarismsoftware" />
                        </div>
                        <div class="form-group">
                            <strong>(g)	 Has the university instituted mechanisms to curb plagiarism (attach a sample plagiarism report)?   </strong><i>(Tick if yes)</i>
                            <asp:CheckBox runat="server" ID="curbantiplagiarims" /><br />
                            <asp:FileUpload runat="server" />
                        </div>
                        <div class="row">
                            <div class="col-md-3 col-lg-3">
                                <div class="form-group">
                                    <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Submit Details" OnClick="addAntiPlagiarismDetails_Click" />
                                </div>
                            </div>
                        </div>
                        <table class="table table-bordered table-striped dataTable">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Quality Audit No.</th>
                                    <th>Memos  </th>
                                    <th>Newsletters </th>
                                    <th>Meetings </th>
                                    <th>Students Handbook </th>
                                    <th>Student website</th>
                                    <th>Edit</th>
                                    <th>Delete</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    var studentsassmentdetails = nav.Students_Assessment.Where(r => r.QA_Number == QualityAuditNo);
                                    int assesmentcounters = 0;
                                    foreach (var studentsassmentdetail in studentsassmentdetails)
                                    {
                                        assesmentcounters++;

                                %>
                                <tr>
                                    <td><%=assesmentcounters%></td>
                                    <td><%=studentsassmentdetail.QA_Number%></td>
                                    <td><%=studentsassmentdetail.Communicated_via_Memo %></td>
                                    <td><%=studentsassmentdetail.Communicated_via_NewsLetters %></td>
                                    <td><%=studentsassmentdetail.Communicated_via_Meetings %></td>
                                    <td><%=studentsassmentdetail.Students_Handbook %></td>
                                    <td><%=studentsassmentdetail.Communicated_via_Website %></td>
                                    <td>
                                        <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                    <td>
                                        <label class="btn btn-danger" onclick="deleteAntiPlagiarismDetails('<%=studentsassmentdetail.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>
                                </tr>
                                <%} %>
                            </tbody>
                        </table>
                    </div>
                    <div class="form-group">
                        <strong>Key strengths and weaknesses on Student Assessment on the Programme</strong>
                        <div class="row">
                            <div class="col-md-6 col-lg-6">
                                <div class="panel panel-primary">
                                    <div id="studentsassessmentfeedback" runat="server"></div>
                                    <div class="panel-heading">
                                        Key Strengths
                                    </div>
                                    <div class="panel-body">
                                        <div class="form-group">
                                            <strong>Strength:</strong>
                                            <asp:TextBox runat="server" CssClass="form-control" placeholder="Strength" ID="studentsassesmentstrength" TextMode="MultiLine" />
                                        </div>
                                        <div class="form-group">
                                            <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Strength" OnClick="addassesmenstrength_Click" />
                                        </div>
                                        <table class="table table-bordered table-striped dataTable">
                                            <thead>
                                                <tr>
                                                    <th>SN</th>
                                                    <th>Strength</th>
                                                    <th>Edit</th>
                                                    <th>Delete</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    var studentsassesmentstrengths = nav.StudentsAssesWeaknessStrength.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Strength");
                                                    int studentsassesstrenghtsCounter = 0;
                                                    string studentsassessmentstrenthdetails = "";
                                                    string University_Code = Convert.ToString(Session["UniversityCode"]);
                                                    foreach (var assessstrenght in studentsassesmentstrengths)
                                                    {
                                                        studentsassesstrenghtsCounter++;
                                                        var studentsassessmentstrenth = new Config().ObjNav().FngetStudentsAssesmentStrength(QualityAuditNo, University_Code);
                                                        studentsassessmentstrenthdetails = Regex.Replace(studentsassessmentstrenth, @"[^0-9a-zA-Z]+", " ");
                                                %>
                                                <tr>
                                                    <td><%=studentsassesstrenghtsCounter%></td>
                                                    <td><%=studentsassessmentstrenth%></td>
                                                    <td>
                                                        <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                                    <td>
                                                        <label class="btn btn-danger" onclick="deletestudentsassesmentstrengths('<%=assessstrenght.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>

                                                </tr>
                                                <%} %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6">
                                <div class="panel panel-primary">
                                    <div id="studentassessmentweaknessfeedback" runat="server"></div>
                                    <div class="panel-heading">
                                        Key Weaknesses
                                    </div>
                                    <div class="panel-body">
                                        <div class="form-group">
                                            <strong>Weakness:</strong>
                                            <asp:TextBox runat="server" CssClass="form-control" placeholder="Weakness" ID="studentassesmentweakness" TextMode="MultiLine" />
                                        </div>
                                        <div class="form-group">
                                            <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Weakness" OnClick="addassessmentWeaknesses_Click" />
                                        </div>
                                        <table class="table table-bordered table-striped dataTable">
                                            <thead>
                                                <tr>
                                                    <th>SN</th>
                                                    <th>Weakness</th>
                                                    <th>Edit</th>
                                                    <th>Delete</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    var studentsassesweaknesses = nav.StudentsAssesWeaknessStrength.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Weakness");
                                                    int studentsassesweaknessescounter = 0;
                                                    string studentsassessmentweaknessdetails = "";
                                                    foreach (var studentweakness in studentsassesweaknesses)
                                                    {
                                                        studentsassesweaknessescounter++;
                                                        var studentsassessmentweakness = new Config().ObjNav().FngetStudentsAssesmentWeakness(QualityAuditNo, University_Code);
                                                        studentsassessmentweaknessdetails = Regex.Replace(studentsassessmentweakness, @"[^0-9a-zA-Z]+", " ");
                                                %>
                                                <tr>
                                                    <td><%=studentsassesweaknessescounter%></td>
                                                    <td><%=studentsassessmentweakness%></td>
                                                    <td>
                                                        <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                                    <td>
                                                        <label class="btn btn-danger" onclick="deletestudentsassesweaknesses('<%=studentweakness.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>

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
                        <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
                        <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="next_Click" />
                        <div class="clearfix"></div>
                    </div>
                </div>
                <% }
                    else if (currentStep == 9)
                    {
                %>
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        9.	Quality of Teaching Staff 
            <label class="pull-right">Step <%=currentStep %> of <%=maxStep %></label>
                        <div class="clearfix"></div>
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <strong>(a)	Academic Programme Leader</strong>
                            <div class="row">
                                <div id="academicleaderfeedback" runat="server"></div>
                                <div class="col-md-4 col-lg-4">
                                    <div class="form-group">
                                        <strong>ID Number</strong>
                                        <asp:TextBox runat="server" CssClass="form-control" ID="idnumber" />
                                    </div>
                                </div>
                                <div class="col-md-4 col-lg-4">
                                    <div class="form-group">
                                        <strong>Full Name</strong>
                                        <asp:TextBox runat="server" CssClass="form-control" ID="fullnames" />
                                    </div>
                                </div>
                                <div class="col-md-4 col-lg-4">
                                    <div class="form-group">
                                        <strong>University level teaching experience(yrs.)</strong>
                                        <asp:TextBox runat="server" CssClass="form-control" ID="teachingexperience" />
                                    </div>
                                </div>
                                <div class="col-md-4 col-lg-4">
                                    <div class="form-group">
                                        <strong>Bachelors Specialization</strong>
                                        <asp:TextBox runat="server" CssClass="form-control" ID="bachelorsspecialization" />
                                    </div>
                                </div>
                                <div class="col-md-4 col-lg-4">
                                    <div class="form-group">
                                        <strong>Masters Specialization</strong>
                                        <asp:TextBox runat="server" CssClass="form-control" ID="mastersspecialization" />
                                    </div>
                                </div>
                                <div class="col-md-4 col-lg-4">
                                    <div class="form-group">
                                        <strong>Doctorate Specialization</strong>
                                        <asp:TextBox runat="server" CssClass="form-control" ID="doctoratespecialization" />
                                    </div>
                                </div>
                                <div class="col-md-4 col-lg-4">
                                    <div class="form-group">
                                        <strong>Terms of employment</strong>
                                        <asp:DropDownList runat="server" CssClass="form-control" ID="termsofemployment" />
                                    </div>
                                </div>
                                <div class="col-md-4 col-lg-4">
                                    <div class="form-group">
                                        <strong>Highest level of Academic Qualification</strong>
                                        <asp:DropDownList runat="server" CssClass="form-control" ID="highestacademiclevel" />
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3 col-lg-3">
                                    <div class="form-group">
                                        <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Submit Academic Leader Details" OnClick="addAcademicLeaderDetails_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <table class="table table-bordered table-striped dataTable">
                            <thead>
                                <tr>
                                    <th>SN</th>
                                    <th>ID Number</th>
                                    <th>Full Name</th>
                                    <th>University Teaching Experience</th>
                                    <th>Terms of Employment</th>
                                    <th>Highest level of Academic Qualification</th>
                                    <th>Edit</th>
                                    <th>Delete</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    var studentsleader = nav.AcademicProgrammeLeader.Where(r => r.QA_Number == QualityAuditNo);
                                    int studentleaderCounter = 0;
                                    foreach (var studentlead in studentsleader)
                                    {
                                        studentleaderCounter++;
                                %>
                                <tr>
                                    <td><%=studentleaderCounter%></td>
                                    <td><%=studentlead.Leader_ID_Number%></td>
                                    <td><%=studentlead.Leader_Full_Name%></td>
                                    <td><%=studentlead.Teaching_Experience_Years%></td>
                                    <td><%=studentlead.Terms_of_employment%></td>
                                    <td><%=studentlead.Highest_Qualifications%></td>
                                    <td>
                                        <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                    <td>
                                        <label class="btn btn-danger" onclick="deleteProgrammeLeader('<%=studentlead.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>

                                </tr>
                                <%

                                    } %>
                            </tbody>
                        </table>
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                (b)	Size of Full Time Academic Staff for the Academic Programme and their Qualification 
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered table-striped" id="fulltimestaffsize">
                                    <thead>
                                        <tr>
                                            <th colspan="12" style="text-align: center;">Summary of Current Full Time Academic Staff by Designation, Gender and Age</th>
                                        </tr>
                                        <tr>
                                            <%--<th rowspan="3" style="text-align: center;">SN</th>--%>
                                            <th rowspan="3" style="text-align: center;">Designation</th>
                                            <th colspan="3" style="text-align: center">Below 30</th>
                                            <th colspan="3" style="text-align: center">31-39</th>
                                            <th colspan="3" style="text-align: center">40-49</th>
                                            <th colspan="3" style="text-align: center">50-59</th>
                                            <th colspan="3" style="text-align: center">60 and above</th>
                                        </tr>
                                        <tr>
                                            <th>M</th>
                                            <th>F</th>
                                            <th>I</th>
                                            <th>M</th>
                                            <th>F</th>
                                            <th>I</th>
                                            <th>M</th>
                                            <th>F</th>
                                            <th>I</th>
                                            <th>M</th>
                                            <th>F</th>
                                            <th>I</th>
                                            <th>M</th>
                                            <th>F</th>
                                            <th>I</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <tr>
                                            <%--  <td>1</td>--%>
                                            <td>
                                                <input type="text" value="Professor" disabled="disabled" /></td>
                                            <td>
                                                <input type="text" class="form-control" /></td>
                                            <td>
                                                <input type="text" class="form-control" /></td>
                                            <td>
                                                <input type="text" class="form-control" /></td>
                                            <td>
                                                <input type="text" class="form-control" /></td>
                                            <td>
                                                <input type="text" class="form-control" /></td>
                                            <td>
                                                <input type="text" class="form-control" /></td>
                                            <td>
                                                <input type="text" class="form-control" /></td>
                                            <td>
                                                <input type="text" class="form-control" /></td>
                                            <td>
                                                <input type="text" class="form-control" /></td>
                                            <td>
                                                <input type="text" class="form-control" /></td>
                                            <td>
                                                <input type="text" class="form-control" /></td>
                                            <td>
                                                <input type="text" class="form-control" /></td>
                                            <td>
                                                <input type="text" class="form-control" /></td>
                                            <td>
                                                <input type="text" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                        </tr>
                                        <tr>
                                            <%-- <td>2</td>--%>
                                            <td>
                                                <input type="text" value="Associate Professor" disabled="disabled" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                        </tr>
                                        <tr>
                                            <%-- <td>3</td>--%>
                                            <td>
                                                <input type="text" value="Senior Lecturer" disabled="disabled" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                        </tr>
                                        <tr>
                                            <%--   <td>4</td>--%>
                                            <td>
                                                <input type="text" value="Lecturer" disabled="disabled" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                        </tr>
                                        <tr>
                                            <%-- <td>5</td>--%>
                                            <td>
                                                <input type="text" value="Tutorial Fellow" disabled="disabled" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                        </tr>
                                        <tr>
                                            <%--<td>6</td>--%>
                                            <td>
                                                <input type="text" value="Graduate Assistant" disabled="disabled" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                        </tr>
                                        <tr>
                                            <%-- <td>7</td>--%>
                                            <td>
                                                <input type="text" value="Assistant Lecturer" disabled="disabled" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                        </tr>
                                        <tr>
                                            <%--  <td>8</td>--%>
                                            <td>
                                                <input type="text" value="Research Staff" disabled="disabled" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                        </tr>
                                        <%--<tr>--%>
                                        <%-- <%--  <td>9</td>--%>
                                        <%-- <td>
                                                <input type="text" value="Visiting Staff" disabled="disabled" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                        </tr>
                                        <tr>--%>
                                        <%--<td>10</td>--%>
                                        <%--   <td>
                                                <input type="text" value="Adjunct Staff" disabled="disabled" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>--%>
                                        <%--   </tr>--%>
                                    </tbody>
                                </table>
                                <div class="row">
                                    <div class="col-md-3 col-lg-3">
                                        <div class="form-group">
                                            <input type="button" id="btnSaveFulltimeStaff" class="btn btn-success  btn-block" value="Submit Full-Time Academic Staff" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                (c)	Size of Part Time Academic Staff for the Academic Programme and their Qualification 
                            </div>
                            <div class="panel-body">
                                <table class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th colspan="12" style="text-align: center;">Summary of Current Part Time Academic Staff by Designation, Gender and Age</th>
                                        </tr>
                                        <tr>
                                            <th rowspan="3" style="text-align: center;">SN</th>
                                            <th rowspan="3" style="text-align: center;">Designation</th>
                                            <th colspan="3" style="text-align: center">Below 30</th>
                                            <th colspan="3" style="text-align: center">31-39</th>
                                            <th colspan="3" style="text-align: center">40-49</th>
                                            <th colspan="3" style="text-align: center">50-59</th>
                                            <th colspan="3" style="text-align: center">60 and above</th>
                                        </tr>
                                        <tr>
                                            <th>M</th>
                                            <th>F</th>
                                            <th>Intersex</th>
                                            <th>M</th>
                                            <th>F</th>
                                            <th>Intersex</th>
                                            <th>M</th>
                                            <th>F</th>
                                            <th>Intersex</th>
                                            <th>M</th>
                                            <th>F</th>
                                            <th>Intersex</th>
                                            <th>M</th>
                                            <th>F</th>
                                            <th>Intersex</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>1</td>
                                            <td>Professor</td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                        </tr>
                                        <tr>
                                            <td>2</td>
                                            <td>Associate Professor</td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                        </tr>
                                        <tr>
                                            <td>3</td>
                                            <td>Senior Lecturer</td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                        </tr>
                                        <tr>
                                            <td>4</td>
                                            <td>Lecturer</td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                        </tr>
                                        <tr>
                                            <td>5</td>
                                            <td>Tutorial Fellow</td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                        </tr>
                                        <tr>
                                            <td>6</td>
                                            <td>Graduate Assistant</td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                        </tr>
                                        <tr>
                                            <td>7</td>
                                            <td>Assistant Lecturer</td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                        </tr>
                                        <tr>
                                            <td>8</td>
                                            <td>Research Staff</td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                        </tr>
                                        <%-- <tr>
                                            <td>9</td>
                                            <td>Visiting Staff</td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                        </tr>
                                        <tr>
                                            <td>10</td>
                                            <td>Adjunct Staff</td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" /></td>
                                        </tr>--%>
                                    </tbody>
                                </table>
                                <div class="row">
                                    <div class="col-md-3 col-lg-3">
                                        <div class="form-group">
                                            <asp:Button runat="server" CssClass="btn btn-success btn-block" ID="parttimeacademicstaff" Text="Submit Part-Time Academic Staff" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <strong>(d)	(i) Does the university have a mechanism for appraising academic staff? (Attach evidence)</strong> <i>(Tick if yes)</i>
                            <asp:CheckBox runat="server" /><br />
                            <asp:FileUpload runat="server" />
                        </div>
                        <div class="form-group">
                            <strong>(d)	(i)	If yes in 9 (d) (i), how regular is staff appraisal carried out? </strong><i>(Select the one applicable)</i>
                            <br />
                            <table>
                                <tr>
                                    <td>(i)	Monthly			 </td>
                                    <td>
                                        <asp:CheckBox runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>(ii)	  Quarterly	 </td>
                                    <td>
                                        <asp:CheckBox runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>(iii)	  Semi-annually	&nbsp;&nbsp;&nbsp; </td>
                                    <td>
                                        <asp:CheckBox runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>(iv)	 Annually		 </td>
                                    <td>
                                        <asp:CheckBox runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div class="form-group">
                        <strong>Key strengths and weaknesses on Quality of Teaching Staff</strong>
                        <div class="row">
                            <div class="col-md-6 col-lg-6">
                                <div class="panel panel-primary">
                                    <div id="qualitystaffstrengthfeedback" runat="server"></div>
                                    <div class="panel-heading">
                                        Key Strengths
                                    </div>
                                    <div class="panel-body">
                                        <div class="form-group">
                                            <strong>Strength:</strong>
                                            <asp:TextBox runat="server" CssClass="form-control" placeholder="Strength" ID="qualitystaffstrength" TextMode="MultiLine" />
                                        </div>
                                        <div class="form-group">
                                            <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Strength" OnClick="addQualityStaffStrenght_Click" />
                                        </div>
                                        <table class="table table-bordered table-striped dataTable">
                                            <thead>
                                                <tr>
                                                    <th>SN</th>
                                                    <th>Strength</th>
                                                    <th>Edit</th>
                                                    <th>Delete</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    var qualitystaffstrength1 = nav.QualityStaffWeaknessStrength.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Strengths");
                                                    int qualitystaffCounter = 0;
                                                    string qualitystaffdetails = "";
                                                    string University_Code = Convert.ToString(Session["UniversityCode"]);
                                                    foreach (var qualitystaffstrength0 in qualitystaffstrength1)
                                                    {
                                                        qualitystaffCounter++;
                                                        var qualitystaff = new Config().ObjNav().FngetQualityStaffStrength(QualityAuditNo, University_Code);
                                                        qualitystaffdetails = Regex.Replace(qualitystaff, @"[^0-9a-zA-Z]+", " ");
                                                %>
                                                <tr>
                                                    <td><%=qualitystaffCounter%></td>
                                                    <td><%=qualitystaff%></td>
                                                    <td>
                                                        <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                                    <td>
                                                        <label class="btn btn-danger" onclick="deletequalitystaffstrength('<%=qualitystaffstrength0.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>

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
                                        <div id="qualitystaffweaknesfeedback" runat="server"></div>
                                        <div class="form-group">
                                            <strong>Weakness:</strong>
                                            <asp:TextBox runat="server" CssClass="form-control" placeholder="Weakness" ID="qualitystaffweaknes" TextMode="MultiLine" />
                                        </div>
                                        <div class="form-group">
                                            <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Weakness" OnClick="addQualitystaffWeaknesses_Click" />
                                        </div>
                                        <table class="table table-bordered table-striped dataTable">
                                            <thead>
                                                <tr>
                                                    <th>SN</th>
                                                    <th>Weakness</th>
                                                    <th>Edit</th>
                                                    <th>Delete</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    var qualitystaffweaknesses1 = nav.QualityStaffWeaknessStrength.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Weakness");
                                                    int staffscounter = 0;
                                                    string qualitystaffweaknessdetails = "";
                                                    foreach (var qualitystaffweaknesses0 in qualitystaffweaknesses1)
                                                    {
                                                        staffscounter++;
                                                        var qualitystaffweakness = new Config().ObjNav().FngetQualityStaffWeakness(QualityAuditNo, University_Code);
                                                        qualitystaffweaknessdetails = Regex.Replace(qualitystaffweakness, @"[^0-9a-zA-Z]+", " ");
                                                %>
                                                <tr>
                                                    <td><%=staffscounter%></td>
                                                    <td><%=qualitystaffweakness%></td>
                                                    <td>
                                                        <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                                    <td>
                                                        <label class="btn btn-danger" onclick="deletequalitystaffweakness('<%=qualitystaffweaknesses0.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>

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
                        <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
                        <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="next_Click" />
                        <div class="clearfix"></div>
                    </div>
                </div>
                <% 
                    }
                    else if (currentStep == 10)
                    {
                %>
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        10.	Number of Non Teaching staff 
            <label class="pull-right">Step <%=currentStep %> of <%=maxStep %></label>
                        <div class="clearfix"></div>
                    </div>
                    <div class="panel-body">

                        <div class="panel panel-default">
                            <div class="panel-heading">Fill the table below, where it is applicable for the Academic Programme</div>
                            <div class="panel-body">
                                <div id="nonteachingstafffeedback" runat="server"></div>
                                <table class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th>SN</th>
                                            <th>Category</th>
                                            <th>Number of Non Teaching  Staff</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>1</td>
                                            <td>Laboratories Staff</td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="labaratorystaff" />

                                            </td>

                                        </tr>
                                        <tr>
                                            <td>2</td>
                                            <td>Computer Laboratories  Staff</td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="computerlabstaff" />

                                            </td>
                                        </tr>
                                        <tr>
                                            <td>3</td>
                                            <td>Administrative Staff for the Academic Programme</td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="administrativesatff" /></td>

                                        </tr>
                                        <tr>
                                            <td>4</td>
                                            <td>Workshops Staff</td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="workshopstaff" /></td>

                                        </tr>
                                        <tr>
                                            <td>5</td>
                                            <td>Education and Communication Technology Staff </td>
                                            <td>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="educationcomstaff" /></td>

                                        </tr>
                                    </tbody>
                                </table>
                                <div class="row">
                                    <div class="col-md-3 col-lg-3">
                                        <div class="form-group">
                                            <asp:Button runat="server" CssClass="btn btn-success btn-block" ID="nonteachingstaff" Text="Submit Non-Teaching Staff" OnClick="addNonTeachingStaff_Click" />
                                        </div>
                                    </div>
                                </div>
                                <table class="table table-bordered table-striped dataTable">
                                    <thead>
                                        <tr>
                                            <th>SN</th>
                                            <th>Quality Number</th>
                                            <th>Laboratories Staff</th>
                                            <th>Computer Laboratories Staff</th>
                                            <th>Workshops Staff</th>
                                            <th>Administrative Staff </th>
                                            <th>Edit</th>
                                            <th>Delete</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            var NonTeachingStaffs = nav.QualityNonTeachingStaff.Where(r => r.QA_Number == QualityAuditNo);
                                            int NonTeachingStaffCounter = 0;
                                            foreach (var NonTeachingStaff in NonTeachingStaffs)
                                            {
                                                NonTeachingStaffCounter++;
                                        %>
                                        <tr>
                                            <td><%=NonTeachingStaffCounter%></td>
                                            <td><%=NonTeachingStaff.QA_Number%></td>
                                            <td><%=NonTeachingStaff.Laboratories_Staff%></td>
                                            <td><%=NonTeachingStaff.Computer_Laboratories_Staff%></td>
                                            <td><%=NonTeachingStaff.Workshops_Staff%></td>
                                            <td><%=NonTeachingStaff.Administrative_Staff%></td>
                                            <td>
                                                <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                            <td>
                                                <label class="btn btn-danger" onclick="deleteNonTeachingStaff('<%=NonTeachingStaff.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>

                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                                <div class="form-group">
                                    <strong>Key strengths and weaknesses on Quality of Support Staff</strong>
                                    <div class="row">
                                        <div class="col-md-6 col-lg-6">
                                            <div class="panel panel-primary">
                                                <div id="qualitysupportstrengthfeedback" runat="server"></div>
                                                <div class="panel-heading">
                                                    Key Strengths
                                                </div>
                                                <div class="panel-body">
                                                    <div class="form-group">
                                                        <strong>Strength:</strong>
                                                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Strength" ID="qualitysupportstaffstrength" TextMode="MultiLine" />
                                                    </div>
                                                    <div class="form-group">
                                                        <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Strength" OnClick="addSupportStaffStrenght_Click" />
                                                    </div>
                                                    <table class="table table-bordered table-striped dataTable">
                                                        <thead>
                                                            <tr>
                                                                <th>SN</th>
                                                                <th>Strength</th>
                                                                <th>Edit</th>
                                                                <th>Delete</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <%
                                                                var qualitysupportstaffs = nav.QualityStaffWeaknessStrength.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Strengths");
                                                                int qualitysupportstaffsCounter = 0;
                                                                string qualitysupportstaffStrengthdetails = "";
                                                                string University_Code = Convert.ToString(Session["UniversityCode"]);
                                                                foreach (var qualitysupportstaff in qualitysupportstaffs)
                                                                {
                                                                    qualitysupportstaffsCounter++;
                                                                    var qualitysupportstaffStrength = new Config().ObjNav().FngetQualityStaffStrength(QualityAuditNo, University_Code);
                                                                    qualitysupportstaffStrengthdetails = Regex.Replace(qualitysupportstaffStrength, @"[^0-9a-zA-Z]+", " ");
                                                            %>
                                                            <tr>
                                                                <td><%=qualitysupportstaffsCounter%></td>
                                                                <td><%=qualitysupportstaffStrength%></td>
                                                                <td>
                                                                    <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                                                <td>
                                                                    <label class="btn btn-danger" onclick="deletequalitysupportstaffstrengths('<%=qualitysupportstaff.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>
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
                                                <div id="qualitysupportweaknessfeedback" runat="server"></div>
                                                <div class="panel-heading">
                                                    Key Weaknesses
                                                </div>
                                                <div class="panel-body">
                                                    <div class="form-group">
                                                        <strong>Weakness:</strong>
                                                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Weakness" ID="qualitysupportstaffweakness" TextMode="MultiLine" />
                                                    </div>
                                                    <div class="form-group">
                                                        <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Weakness" OnClick="addSupportStaffWeaknesses_Click" />
                                                    </div>
                                                    <table class="table table-bordered table-striped dataTable">
                                                        <thead>
                                                            <tr>
                                                                <th>SN</th>
                                                                <th>Weakness</th>
                                                                <th>Edit</th>
                                                                <th>Delete</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <%
                                                                var supportstaffweaknesses = nav.QualityStaffWeaknessStrength.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Weakness");
                                                                int supportstaffweaknesscounter = 0;
                                                                string qualitysupportstaffweaknessdetails = "";
                                                                foreach (var supportstaffweakness in supportstaffweaknesses)
                                                                {
                                                                    supportstaffweaknesscounter++;
                                                                    var qualitysupportstaffweakness = new Config().ObjNav().FngetQualityStaffWeakness(QualityAuditNo, University_Code);
                                                                    qualitysupportstaffweaknessdetails = Regex.Replace(qualitysupportstaffweakness, @"[^0-9a-zA-Z]+", " ");
                                                            %>
                                                            <tr>
                                                                <td><%=supportstaffweaknesscounter%></td>
                                                                <td><%=qualitysupportstaffweakness%></td>
                                                                <td>
                                                                    <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                                                <td>
                                                                    <label class="btn btn-danger" onclick="deletequalitysupportstaffweakness('<%=supportstaffweakness.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>

                                                            </tr>
                                                            <% } %>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel-footer">
                        <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
                        <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="next_Click" />
                        <div class="clearfix"></div>
                    </div>
                </div>
                <% }
                    else if (currentStep == 11)
                    {
                %>
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        11.	Student Profile
            <label class="pull-right">Step  <%=currentStep %> of <%=maxStep %></label>
                        <div class="clearfix"></div>
                    </div>
                    <div class="panel-body">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                (a)	Summary current total number of students enrolled in the Academic Programme
                            </div>
                            <div class="panel-body">
                                <div id="studentprofilefeedback" style="display: none" runat="server"></div>
                                <table class="table table-bordered table-striped" id="studentsprofiles">
                                    <thead>
                                        <tr>
                                            <%--<th rowspan="2">SN</th>--%>
                                            <th rowspan="2">Academic Year (Specify)</th>
                                            <th style="text-align: center" colspan="3">Government Sponsored</th>
                                            <th style="text-align: center" colspan="3">Self -Sponsored</th>
                                            <th rowspan="2">Kenyan Students</th>
                                            <th rowspan="2">International Students</th>




                                        </tr>
                                        <tr>
                                            <th>M</th>
                                            <th>F</th>
                                            <th>Intersex</th>
                                            <th>M</th>
                                            <th>F</th>
                                            <th>Intersex</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <%--<td>1</td>--%>
                                            <td>
                                                <input type="text" class="form-control" value="First Year" disabled="disabled" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                        </tr>
                                        <tr>
                                            <%-- <td>2</td>--%>
                                            <td>
                                                <input type="text" class="form-control" value="Second Year" disabled="disabled" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                        </tr>
                                        <tr>
                                            <%-- <td>3</td>--%>
                                            <td>
                                                <input type="text" class="form-control" value="Third Year" disabled="disabled" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                        </tr>
                                        <tr>
                                            <%-- <td>4</td>--%>
                                            <td>
                                                <input type="text" class="form-control" value="Fourth Year" disabled="disabled" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                        </tr>
                                        <tr>
                                            <%-- <td>5</td>--%>
                                            <td>
                                                <input type="text" class="form-control" value="Fifth Year" disabled="disabled" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                        </tr>
                                        <tr>
                                            <%--  <td>6</td>--%>
                                            <td>
                                                <input type="text" class="form-control" value="Sixth Year" disabled="disabled" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>

                                        </tr>
                                        <tr>
                                            <%-- <td>7</td>--%>
                                            <td>
                                                <input type="text" class="form-control" value="Other Years" disabled="disabled" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                            <td>
                                                <input type="number" class="form-control" /></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="row">
                                    <div class="col-md-3 col-lg-3">
                                        <div class="form-group">
                                            <input type="button" id="btnSaveStudents" class="btn btn-success  btn-block" value="Submit Student Profile Details" />
                                        </div>
                                    </div>
                                </div>
                                <table class="table table-bordered table-striped dataTable">
                                    <thead>
                                        <tr>
                                            <th>SN</th>
                                            <th>Quality Number</th>
                                            <th>Academic Year</th>
                                            <th>Government Male</th>
                                            <th>Government Female</th>
                                            <th>Kenyan Students</th>
                                            <th>International Students</th>
                                            <th>Edit</th>
                                            <th>Delete</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            var StudentsProfiles = nav.Students_Profile.Where(r => r.QA_Number == QualityAuditNo);
                                            int StudentsProfileCounter = 0;
                                            foreach (var StudentsProfile in StudentsProfiles)
                                            {
                                                StudentsProfileCounter++;
                                        %>
                                        <tr>
                                            <td><%=StudentsProfileCounter%></td>
                                            <td><%=StudentsProfile.QA_Number%></td>
                                            <td><%=StudentsProfile.Academic_Year%></td>
                                            <td><%=StudentsProfile.Government_Sponsored_Male%></td>
                                            <td><%=StudentsProfile.Government_Sponsored_Female%></td>
                                            <td><%=StudentsProfile.Kenyan_Students%></td>
                                            <td><%=StudentsProfile.International_Students%></td>
                                            <td>
                                                <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                            <td>
                                                <label class="btn btn-danger" onclick="deleteStudentsProfile('<%=StudentsProfile.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>

                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                                <div class="form-group">
                                    <strong>Key strengths and weaknesses on Student Profile</strong>
                                    <div class="row">
                                        <div class="col-md-6 col-lg-6">
                                            <div class="panel panel-primary">
                                                <div id="studentprofilestrengthfeedback" runat="server"></div>
                                                <div class="panel-heading">
                                                    Key Strengths
                                                </div>
                                                <div class="panel-body">
                                                    <div class="form-group">
                                                        <strong>Strength:</strong>
                                                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Strength" ID="Studentsprofilestrength" TextMode="MultiLine" />
                                                    </div>
                                                    <div class="form-group">
                                                        <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Strength" OnClick="addStudentProfileStrenght_Click" />
                                                    </div>
                                                    <table class="table table-bordered table-striped dataTable">
                                                        <thead>
                                                            <tr>
                                                                <th>SN</th>
                                                                <th>Strength</th>
                                                                <th>Edit</th>
                                                                <th>Delete</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <%
                                                                var studentsstrenghts = nav.StudentProfileWeaknessStrength.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Strengths");
                                                                int studentsstrenghtCounter = 0;
                                                                string studentsprofilestrengthsdetails = "";
                                                                string University_Code = Convert.ToString(Session["UniversityCode"]);

                                                                foreach (var studentsstrenght in studentsstrenghts)
                                                                {
                                                                    studentsstrenghtCounter++;
                                                                    var studentsprofilestrengths = new Config().ObjNav().FngetStudentProfileStrength(QualityAuditNo, University_Code);
                                                                    studentsprofilestrengthsdetails = Regex.Replace(studentsprofilestrengths, @"[^0-9a-zA-Z]+", " ");
                                                            %>
                                                            <tr>
                                                                <td><%=studentsstrenghtCounter%></td>
                                                                <td><%=studentsprofilestrengths%></td>
                                                                <td>
                                                                    <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                                                <td>
                                                                    <label class="btn btn-danger" onclick="deleteStudentsprofilestrengths('<%=studentsstrenght.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>


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
                                                <div id="studentprofileweaknessfeedback" runat="server"></div>
                                                <div class="panel-heading">
                                                    Key Weaknesses
                                                </div>
                                                <div class="panel-body">

                                                    <div class="form-group">
                                                        <strong>Weakness:</strong>
                                                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Weakness" ID="studentprofileweakness" TextMode="MultiLine" />
                                                    </div>
                                                    <div class="form-group">
                                                        <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Weakness" OnClick="addStudentProfileWeaknesses_Click" />
                                                    </div>
                                                    <table class="table table-bordered table-striped dataTable">
                                                        <thead>
                                                            <tr>
                                                                <th>SN</th>
                                                                <th>Weakness</th>
                                                                <th>Edit</th>
                                                                <th>Delete</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <%
                                                                var studentprofileweaknesses = nav.SpecificationStrenghtsWeaknesses.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Weakness");
                                                                int studentprofileweaknesscounter = 0;
                                                                string studentsprofilesweaknessdetails = "";
                                                                foreach (var studentprofileweakness in studentprofileweaknesses)
                                                                {
                                                                    studentprofileweaknesscounter++;
                                                                    var studentsprofilesweakness = new Config().ObjNav().FngetStudentProfileWeakness(QualityAuditNo, University_Code);
                                                                    studentsprofilesweaknessdetails = Regex.Replace(studentsprofilesweakness, @"[^0-9a-zA-Z]+", " ");

                                                            %>
                                                            <tr>
                                                                <td><%=studentprofileweaknesscounter%></td>
                                                                <td><%=studentsprofilesweakness%></td>
                                                                <td>
                                                                    <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                                                <td>
                                                                    <label class="btn btn-danger" onclick="deleteStudentsprofileweakness('<%=studentprofileweakness.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>


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
                            </div>
                        </div>
                    </div>
                    <div class="panel-footer">
                        <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
                        <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="next_Click" />
                        <div class="clearfix"></div>
                    </div>
                </div>
                <% }
                    else if (currentStep == 12)
                    {
                %>
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        12.	Student Advice/Support
            <label class="pull-right">Step  <%=currentStep %> of <%=maxStep %></label>
                        <div class="clearfix"></div>
                    </div>
                    <div class="panel-body">
                        <div id="supportstudentsfeedback" runat="server"></div>
                        <div class="form-group">
                            <strong>(a)	Identify the availability of the following student support programmes </strong><i>(Check where Applicable)</i>

                            <table>
                                <tr>
                                    <td>(i)	Prospectus for the Academic programme</td>
                                    <td>
                                        <asp:CheckBox runat="server" ID="prospectusforprogramme" /></td>
                                </tr>
                                <tr>
                                    <td>(ii)	Student orientation.</td>
                                    <td>
                                        <asp:CheckBox runat="server" ID="studentsorientation" /></td>
                                </tr>
                                <tr>
                                    <td>(iii)	Student coaching and mentorship</td>
                                    <td>
                                        <asp:CheckBox runat="server" ID="studentscoaching" /></td>
                                </tr>
                                <tr>
                                    <td>(iv)	Peer counselling</td>
                                    <td>
                                        <asp:CheckBox runat="server" ID="peercounselling" /></td>
                                </tr>
                                <tr>
                                    <td>(v)	Open fora with relevant professionals</td>
                                    <td>
                                        <asp:CheckBox runat="server" ID="openforaproffessional" /></td>
                                </tr>
                                <tr>
                                    <td>(vi)	Open fora with relevant Industry</td>
                                    <td>
                                        <asp:CheckBox runat="server" ID="openforarelevantindustry" /></td>
                                </tr>
                                <tr>
                                    <td>(vii)	Contact with students with problem cases on their progress records &nbsp;&nbsp;&nbsp;&nbsp; </td>
                                    <td>
                                        <asp:CheckBox runat="server" ID="cantwithstudents" /></td>
                                </tr>
                                <tr>
                                    <td>(viii)	Remedial/preventive actions for students with progress problems </td>
                                    <td>
                                        <asp:CheckBox runat="server" ID="remedialpreventiveactions" /></td>
                                </tr>
                                <tr>
                                    <td>(ix)	Others (specify)  </td>
                                    <br />
                                    <td>
                                        <asp:TextBox CssClass="form-control" runat="server" ID="otherspecifys" TextMode="MultiLine" /></td>
                                </tr>
                            </table>
                        </div>
                        <div class="form-group">
                            <strong>(b)	Is there attention paid to coaching: </strong><i>(Tick if yes)</i>
                            <br />
                            (i)	First year students?
                            <asp:CheckBox runat="server" ID="orientationfirstyearstudents" /><br />
                            (ii)	Advanced students
                            <asp:CheckBox runat="server" ID="orientationdavancedstudents" /><br />
                        </div>
                        <div class="form-group">
                            <strong>(c)	(i) 	 Are potential students of the Academic Programme engaged by the University	: </strong><i>(Tick if yes)</i>
                            <asp:CheckBox runat="server" ID="potentailstudentsengaged" />
                        </div>
                        <div class="form-group">
                            <strong>(ii)	Are potential students of the Academic Programme given opportunity to evaluate information in the student prospectus </strong><i>(Tick if yes)</i>
                            <asp:CheckBox runat="server" ID="potentialstudentsevaluate" />
                        </div>
                        <div class="form-group">
                            <strong>(d)	Are there facilities to provide study skills to students with study problems: </strong><i>(Tick if yes)</i><br />

                            <table>
                                <tr>
                                    <td>(i)	In the department</td>
                                    <td>
                                        <asp:CheckBox runat="server" ID="departmentfacilities" /><br />
                                </tr>
                                <tr>
                                    <td>(ii) Centrally in the university &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                    <td>
                                        <asp:CheckBox runat="server" ID="centrallyfacilities" /><br />
                                </tr>
                            </table>

                        </div>
                        <div class="form-group">
                            <strong>(e)	Are students in the Academic Programme advised on problems concerning: </strong><i>(Tick if yes)</i><br />
                            <table>
                                <tr>
                                    <td>(i)	 	Course options</td>
                                    <td>
                                        <asp:CheckBox runat="server" ID="courseoptionadvice" /><br />
                                </tr>
                                <tr>
                                    <td>(ii)	Change of options, </td>
                                    <td>
                                        <asp:CheckBox runat="server" ID="changeoptionsadvice" /><br />
                                </tr>
                                <tr>
                                    <td>(iii)	Interruption or termination of studies?	&nbsp;&nbsp;&nbsp;  </td>
                                    <td>
                                        <asp:CheckBox runat="server" ID="interruptionadvice" /><br />
                                </tr>
                            </table>
                        </div>

                        <div class="form-group">
                            <strong>(f)	(i) Are students provided with information on career prospects?  </strong><i>(Tick if yes)</i>
                            <asp:CheckBox runat="server" ID="careerprespectsinformation" />
                        </div>
                        <div class="form-group">
                            <strong>(g)	Are there opportunities for students to familiarize themselves with the labour market in terms of application course and practical training?  </strong><i>(Tick if yes)</i>
                            <asp:CheckBox runat="server" ID="studentslabourmarket" />
                        </div>
                        <div class="col-md-3 col-lg-3">
                            <div class="form-group">
                                <asp:Button runat="server" CssClass="btn btn-success pull-left" ID="studentsprofile" Text="Submit Student Advice/Support" OnClick="addStudentProfile_Click" />
                            </div>
                        </div>
                    </div>
                    <br />
                    <div class="panel-body">
                        <table class="table table-bordered table-striped dataTable">
                            <thead>
                                <tr>
                                    <th>SN</th>
                                    <th>Quality Number</th>
                                    <th>Programme Prospectus</th>
                                    <th>Student Orientation</th>
                                    <th>Student coaching</th>
                                    <th>Peer counselling</th>
                                    <th>Edit</th>
                                    <th>Delete</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    var studentssupportsdetails = nav.StudentsSuppport.Where(r => r.QA_Number == QualityAuditNo);
                                    int studentssupportsdetailsCounter = 0;
                                    foreach (var studentssupportsdetail in studentssupportsdetails)
                                    {
                                        studentssupportsdetailsCounter++;
                                %>
                                <tr>
                                    <td><%=studentssupportsdetailsCounter%></td>
                                    <td><%=studentssupportsdetail.QA_Number%></td>
                                    <td><%=studentssupportsdetail.Prospectus_for_Programme%></td>
                                    <td><%=studentssupportsdetail.Student_orientation%></td>
                                    <td><%=studentssupportsdetail.Student_coaching%></td>
                                    <td><%=studentssupportsdetail.Peer_Counselling%></td>
                                    <td>
                                        <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                    <td>
                                        <label class="btn btn-danger" onclick="deletestudentssupportsdetail('<%=studentssupportsdetail.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>

                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                    <div class="form-group">
                        <strong>Key strengths and weaknesses on Student Advice/Support</strong>
                        <div class="row">
                            <div class="col-md-6 col-lg-6">
                                <div class="panel panel-primary">
                                    <div id="studentssupportstrengthfeedback" runat="server"></div>
                                    <div class="panel-heading">
                                        Key Strengths
                                    </div>
                                    <div class="panel-body">
                                        <div class="form-group">
                                            <strong>Strength:</strong>
                                            <asp:TextBox runat="server" CssClass="form-control" placeholder="Strength" ID="studentsupportstrength" TextMode="MultiLine" />
                                        </div>
                                        <div class="form-group">
                                            <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Strength" OnClick="addStudentsSupportStrenght_Click" />
                                        </div>
                                        <table class="table table-bordered table-striped dataTable">
                                            <thead>
                                                <tr>
                                                    <th>SN</th>
                                                    <th>Strength</th>
                                                    <th>Edit</th>
                                                    <th>Delete</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    var studentsupportstrenghts = nav.StudentSupportWeaknessStrength.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Strengths");
                                                    int studentsupportstrenghtCounter = 0;
                                                    string studentssupportsstrengthdetails = "";
                                                    string University_Code = Convert.ToString(Session["UniversityCode"]);
                                                    foreach (var studentsupportstrenght in studentsupportstrenghts)
                                                    {
                                                        studentsupportstrenghtCounter++;
                                                        var studentssupportsstrength = new Config().ObjNav().FngetStudentSupportStrength(QualityAuditNo, University_Code);
                                                        studentssupportsstrengthdetails = Regex.Replace(studentssupportsstrength, @"[^0-9a-zA-Z]+", " ");

                                                %>
                                                <tr>
                                                    <td><%=studentsupportstrenghtCounter%></td>
                                                    <td><%=studentssupportsstrength%></td>
                                                    <td>
                                                        <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                                    <td>
                                                        <label class="btn btn-danger" onclick="deletestudentsupportstrenght('<%=studentsupportstrenght.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>

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
                                    <div id="studentsupportweaknessfeedback" runat="server"></div>
                                    <div class="panel-heading">
                                        Key Weaknesses
                                    </div>
                                    <div class="panel-body">

                                        <div class="form-group">
                                            <strong>Weakness:</strong>
                                            <asp:TextBox runat="server" CssClass="form-control" placeholder="Weakness" ID="studentsupportweakness" TextMode="MultiLine" />
                                        </div>
                                        <div class="form-group">
                                            <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Weakness" OnClick="addStudentSupportWeaknesses_Click" />
                                        </div>
                                        <table class="table table-bordered table-striped dataTable">
                                            <thead>
                                                <tr>
                                                    <th>SN</th>
                                                    <th>Weakness</th>
                                                    <th>Edit</th>
                                                    <th>Delete</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    var studentssupportweaknesses = nav.StudentSupportWeaknessStrength.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Weakness");
                                                    int outcomeweaknessescounter = 0;
                                                    string studentssupportweaknessdetails = "";
                                                    foreach (var studentssupportweaknes in studentssupportweaknesses)
                                                    {
                                                        outcomeweaknessescounter++;
                                                        var studentssupportweakness = new Config().ObjNav().FngetStudentSupportWeakness(QualityAuditNo, University_Code);
                                                        studentssupportweaknessdetails = Regex.Replace(studentssupportweakness, @"[^0-9a-zA-Z]+", " ");

                                                %>
                                                <tr>
                                                    <td><%=outcomeweaknessescounter%></td>
                                                    <td><%=studentssupportweakness%></td>
                                                    <td>
                                                        <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                                    <td>
                                                        <label class="btn btn-danger" onclick="deletestudentssupportweaknes('<%=studentssupportweaknes.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>

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
                </div>
                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
                    <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="next_Click" />
                    <div class="clearfix"></div>
                </div>
            </div>
            <% }
                else if (currentStep == 13)
                {
            %>
            <div class="panel panel-primary">
                <div class="panel-heading">
                    13.	Facilities & Infrastructure
            <label class="pull-right">Step  <%=currentStep %> of <%=maxStep %></label>
                    <div class="clearfix"></div>
                </div>
                <div class="panel-body">
                    <strong>(a)	Physical resources to deliver the Academic programme, including equipment, materials and Information Technology
                    </strong>
                    <table class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th rowspan="2">Item</th>
                                <th rowspan="2">Number</th>
                                <th colspan="2">Capacity </th>
                                <th colspan="2">Usage</th>
                            </tr>
                            <tr>
                                <th>square metres</th>
                                <th>No. of students</th>
                                <th>Specific to Department</th>
                                <th>Shared</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td rowspan="5">Lecture rooms</td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>0 - 20</td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                            </tr>
                            <tr>

                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>21-40</td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                            </tr>
                            <tr>

                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>41-60</td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                            </tr>
                            <tr>

                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>61-100</td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                            </tr>
                            <tr>

                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>Over 100</td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                            </tr>
                            <tr>
                                <td>Conference Halls</td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                            </tr>
                            <tr>
                                <td>Lecture theatres</td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                            </tr>
                            <tr>
                                <td>Assembly hall/Auditorium</td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                            </tr>
                            <tr>
                                <td>Lecturer’s Offices</td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                            </tr>
                            <tr>
                                <td>Science Laboratories</td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                            </tr>
                            <tr>
                                <td>Computer laboratories</td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                            </tr>
                            <tr>
                                <td>Library </td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                            </tr>
                            <tr>
                                <td>Seminar room </td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                            </tr>
                            <tr>
                                <td>Computer laboratories</td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                            </tr>
                            <tr>
                                <td>Workshops</td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                                <td>
                                    <asp:TextBox runat="server" CssClass="form-control" /></td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="row">
                        <div class="col-md-3 col-lg-3">
                            <div class="form-group">
                                <input type="button" id="btnSavephysical" class="btn btn-success  btn-block btnSaveDidactic" value="Submit Didactic Aids and Tools" />
                            </div>
                        </div>
                    </div>
                    <table class="table table-bordered table-striped dataTable">
                        <thead>
                            <tr>
                                <th>SN</th>
                                <th>Quality Number</th>
                                <th>Laboratories Staff</th>
                                <th>Computer Laboratories Staff</th>
                                <th>Workshops Staff</th>
                                <th>Administrative Staff </th>
                                <th>Edit</th>
                                <th>Delete</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                var NonTeachingStaffs = nav.QualityNonTeachingStaff.Where(r => r.QA_Number == QualityAuditNo);
                                int NonTeachingStaffCounter = 0;
                                foreach (var NonTeachingStaff in NonTeachingStaffs)
                                {
                                    NonTeachingStaffCounter++;
                            %>
                            <tr>
                                <td><%=NonTeachingStaffCounter%></td>
                                <td><%=NonTeachingStaff.QA_Number%></td>
                                <td><%=NonTeachingStaff.Laboratories_Staff%></td>
                                <td><%=NonTeachingStaff.Computer_Laboratories_Staff%></td>
                                <td><%=NonTeachingStaff.Workshops_Staff%></td>
                                <td><%=NonTeachingStaff.Administrative_Staff%></td>
                                <td>
                                    <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                <td>
                                    <label class="btn btn-danger" onclick="deleteRationale('<%=NonTeachingStaff.QA_Number %>');"><i class="fa fa-trash"></i>Delete</label></td>

                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                    <strong>(b)	Equipment and Teaching materials for the Academic Programme</strong>
                    <div class="row">
                        <div class="panel panel-default">
                            <div class="panel-heading">Add Equipment and Teaching materials for the Academic Programme</div>
                            <div class="panel-body">
                                <div id="feedbackequipment" runat="server"></div>
                                <div class="row">
                                    <div class="col-md-6 col-lg-6">
                                        <div class="form-group">
                                            <strong>Item Name:</strong>
                                            <asp:TextBox runat="server" CssClass="form-control" ID="itemname" />
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-lg-6">
                                        <div class="form-group">
                                            <strong>Item Total Number:</strong>
                                            <asp:TextBox runat="server" CssClass="form-control" ID="itemnumber" />
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 col-lg-6">
                                        <div class="form-group">
                                            <strong>Item Usage:</strong>
                                            <asp:DropDownList runat="server" ID="itemsusage" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-lg-3">
                            <div class="form-group">
                                <asp:Button runat="server" CssClass="btn btn-success pull-left" ID="addphysicalresources" Text="Submit Equipment" OnClick="addTeachingEquipments_Click" />
                            </div>
                        </div>
                    </div>
                    <br />
                    <table class="table table-bordered table-striped dataTable">
                        <thead>
                            <tr>
                                <th>SN</th>
                                <th>Quality Number</th>
                                <th>Item Name</th>
                                <th>Item Total Number</th>
                                <th>Edit</th>
                                <th>Delete</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                var teachingsmaterials = nav.Teaching_Equipments.Where(r => r.QA_Number == QualityAuditNo);
                                int teachingsmaterialsCounter = 0;
                                foreach (var teachingsmaterial in teachingsmaterials)
                                {
                                    teachingsmaterialsCounter++;
                            %>
                            <tr>
                                <td><%=teachingsmaterialsCounter%></td>
                                <td><%=teachingsmaterial.QA_Number%></td>
                                <td><%=teachingsmaterial.Item_Name%></td>
                                <td><%=teachingsmaterial.Item_Total_Number%></td>
                                <td>
                                    <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                <td>
                                    <label class="btn btn-danger" onclick="deleteteachingsmaterial('<%=teachingsmaterial.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>

                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>


                <%--  <table class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th rowspan="2">Item</th>
                    <th rowspan="2">Number</th>
                    <th colspan="2">Usage</th>
                </tr>
                    <tr>
                        <th>Specific to Department</th>
                        <th>Shared</th>
                    </tr>
                </thead>
                <tbody>
                <tr>
                    <td>Desk Top Computers (PCS)</td>
                    <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                    <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                    <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                </tr><tr>
                    <td>Laptops/Note Books</td>
                    <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                    <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                    <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                </tr><tr>
                    <td>Projectors Power Point-Projectors</td>
                    <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                    <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                    <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                </tr><tr>
                    <td>Smart boards</td>
                    <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                    <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                    <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                </tr><tr>
                    <td>Scanners </td>
                    <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                    <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                    <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                </tr><tr>
                    <td>Printers </td>
                    <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                    <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                    <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                </tr><tr>
                    <td>Computer Software </td>
                    <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                    <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                    <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                </tr><tr>
                    <td>Special Equipment </td>
                    <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                    <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                    <td><asp:Textbox runat="server" CssClass="form-control"/></td>
                </tr>
                </tbody>
            </table>--%>
                <div class="panel-body">
                    <strong>(d)	Didactic aids and tools of the Academic Programme</strong>
                    <div class="row">
                        <table class="table table-bordered table-striped" id="didactictools">
                            <thead>
                                <tr>
                                    <th rowspan="2">Didactic Aids and Tools</th>
                                    <th rowspan="2">Number</th>
                                    <th colspan="2">Usage</th>
                                </tr>
                                <tr>
                                    <th>Specific to Department</th>
                                    <th>Shared</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%-- <tr>
                                    <td>
                                        <input type="text" class="form-control" value="Books" disabled="disabled" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                </tr>--%>
                                <%-- <tr>
                                    <td>
                                        <input type="text" class="form-control" value="Brochures" disabled="disabled" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                </tr>--%>
                                <%--      <tr>
                                    <td>
                                        <input type="text" class="form-control" value="Magazines" disabled="disabled" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                </tr>--%>
                                <tr>
                                    <td>
                                        <input type="text" class="form-control" value="Academic journals" disabled="disabled" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                </tr>
                                <%--  <tr>
                                    <td>
                                        <input type="text" class="form-control" value="Posters" disabled="disabled" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                </tr>--%>
                                <%--    <tr>
                                    <td>
                                        <input type="text" class="form-control" value="Information sheets" disabled="disabled" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                </tr>--%>
                                <tr>
                                    <td>
                                        <input type="text" class="form-control" value="Internet Bandwith" disabled="disabled" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                </tr>
                                <%--   <tr>
                                    <td>
                                        <input type="text" class="form-control" value="Intranet" disabled="disabled" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                </tr>--%>
                                <%--   <tr>
                                    <td>
                                        <input type="text" class="form-control" value="CD-Roms" disabled="disabled" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="text" class="form-control" value="Maps" disabled="disabled" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="text" class="form-control" value="Aerial photograph" disabled="disabled" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                </tr>--%>
                                <%--  <tr>
                                    <td>
                                        <input type="text" class="form-control" value="Satellite image" disabled="disabled" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                </tr>--%>
                                <tr>
                                    <td>
                                        <input type="text" class="form-control" value="Core Texts " disabled="disabled" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="text" class="form-control" value="Other(specify)" disabled="disabled" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                    <td>
                                        <input type="number" class="form-control" /></td>
                                </tr>
                            </tbody>
                        </table>

                        <div class="col-md-3 col-lg-3">
                            <div class="form-group">
                                <input type="button" id="btnSaveDidactic" class="btn btn-success  btn-block" value="Submit Didactic Aids and Tools" />
                            </div>
                        </div>
                    </div>
                    <table class="table table-bordered table-striped dataTable">
                        <thead>
                            <tr>
                                <th>SN</th>
                                <th>Quality Number</th>
                                <th>Academic Year</th>
                                <th>Government Male</th>
                                <th>Government Female</th>
                                <th>Kenyan Students</th>
                                <th>International Students</th>
                                <th>Edit</th>
                                <th>Delete</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                var StudentsProfiles = nav.Students_Profile.Where(r => r.QA_Number == QualityAuditNo);
                                int StudentsProfileCounter = 0;
                                foreach (var StudentsProfile in StudentsProfiles)
                                {
                                    StudentsProfileCounter++;
                            %>
                            <tr>
                                <td><%=StudentsProfileCounter%></td>
                                <td><%=StudentsProfile.QA_Number%></td>
                                <td><%=StudentsProfile.Academic_Year%></td>
                                <td><%=StudentsProfile.Government_Sponsored_Male%></td>
                                <td><%=StudentsProfile.Government_Sponsored_Female%></td>
                                <td><%=StudentsProfile.Kenyan_Students%></td>
                                <td><%=StudentsProfile.International_Students%></td>
                                <td>
                                    <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                <td>
                                    <label class="btn btn-danger" onclick="deleteStudentsProfile('<%=StudentsProfile.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>

                            </tr>
                            <% } %>
                        </tbody>
                    </table>

                    <div class="form-group">
                        <strong>Key strengths and weaknesses on Facilities and Infrustructure of the Programme</strong>
                        <div class="row">
                            <div class="col-md-6 col-lg-6">
                                <div class="panel panel-primary">
                                    <div id="facilitiesstrengthfeedback" runat="server"></div>
                                    <div class="panel-heading">
                                        Key Strengths
                                    </div>
                                    <div class="panel-body">
                                        <div class="form-group">
                                            <strong>Strength:</strong>
                                            <asp:TextBox runat="server" CssClass="form-control" placeholder="Strength" ID="facilitiesstrength" TextMode="MultiLine" />
                                        </div>
                                        <div class="form-group">
                                            <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Strength" OnClick="addFacilitiesStrenght_Click" />
                                        </div>
                                        <table class="table table-bordered table-striped dataTable">
                                            <thead>
                                                <tr>
                                                    <th>SN</th>
                                                    <th>Strength</th>
                                                    <th>Edit</th>
                                                    <th>Delete</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    var facilitiesstrenthdescriptions = nav.FacilitiesWeaknessStrength.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Strengths");
                                                    int facilitiesstrengthsCounter = 0;
                                                    string facilitiesstrengthsdetails = "";
                                                    string University_Code = Convert.ToString(Session["UniversityCode"]);
                                                    foreach (var facilitiesstrenthdescription in facilitiesstrenthdescriptions)
                                                    {
                                                        facilitiesstrengthsCounter++;
                                                        var facilitiesstrengths = new Config().ObjNav().FngetFacilitiesStrength(QualityAuditNo, University_Code);
                                                        facilitiesstrengthsdetails = Regex.Replace(facilitiesstrengths, @"[^0-9a-zA-Z]+", " ");

                                                %>
                                                <tr>
                                                    <td><%=facilitiesstrengthsCounter%></td>
                                                    <td><%=facilitiesstrengths%></td>
                                                    <td>
                                                        <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                                    <td>
                                                        <label class="btn btn-danger" onclick="deletefacilitiesstrengths('<%=facilitiesstrenthdescription.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>

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
                                    <div id="facilitiesweaknessfeedback" runat="server"></div>
                                    <div class="panel-heading">
                                        Key Weaknesses
                                    </div>
                                    <div class="panel-body">

                                        <div class="form-group">
                                            <strong>Weakness:</strong>
                                            <asp:TextBox runat="server" CssClass="form-control" placeholder="Weakness" ID="facilitiesweakness" TextMode="MultiLine" />
                                        </div>
                                        <div class="form-group">
                                            <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Weakness" OnClick="addFacilitiesWeaknesses_Click" />
                                        </div>
                                        <table class="table table-bordered table-striped dataTable">
                                            <thead>
                                                <tr>
                                                    <th>SN</th>
                                                    <th>Weakness</th>
                                                    <th>Edit</th>
                                                    <th>Delete</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    var facilitiesweaknessesdescriptions = nav.FacilitiesWeaknessStrength.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Weakness");
                                                    int facilitiesweaknessescounter = 0;
                                                    string facilitiesweaknessesdetails = "";
                                                    foreach (var facilitiesweaknessesdescription in facilitiesweaknessesdescriptions)
                                                    {
                                                        facilitiesweaknessescounter++;
                                                        var facilitiesweaknesses = new Config().ObjNav().FngetFacilitiesWeakness(QualityAuditNo, University_Code);
                                                        facilitiesweaknessesdetails = Regex.Replace(facilitiesweaknesses, @"[^0-9a-zA-Z]+", " ");
                                                %>
                                                <tr>
                                                    <td><%=facilitiesweaknessescounter%></td>
                                                    <td><%=facilitiesweaknesses%></td>
                                                    <td>
                                                        <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                                    <td>
                                                        <label class="btn btn-danger" onclick="deletefacilitiesweaknesses('<%=facilitiesweaknessesdescription.Code %>');"><i class="fa fa-trash"></i>Delete</label></td>

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
                </div>
            </div>
            <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="next_Click" />
                <div class="clearfix"></div>
            </div>
        </div>
        <% }
            else if (currentStep == 14)
            {
        %>
        <div class="panel panel-primary">
            <div class="panel-heading">
                14.	Student Evaluation
            <label class="pull-right">Step<%=currentStep %> of <%=maxStep %></label>
                <div class="clearfix"></div>
            </div>
            <div class="panel-body">
                <div id="studentevaluationfeedback" runat="server"></div>
                <%--<strong>a)System of assessment and examination</strong>--%>
                <p>
                    <strong>(a)Do students carry out evaluation of the following aspects of the Academic programme?<i>(Tick if Yes)</i><br />
                    </strong>
                    <table>
                        <tr>
                            <td>(i) The Academic Programme</td>
                            <td>
                                <asp:CheckBox runat="server" ID="evaluateprogramme" /><br />
                        </tr>
                        <tr>
                            <td>(ii) Facilities of the Academic Programme</td>
                            <td>
                                <asp:CheckBox runat="server" ID="evaluateprogrammefacilities" /><br />
                        </tr>
                        <tr>
                            <td>(iii) Delivery Methods of the Academic Programme</td>
                            <td>
                                <asp:CheckBox runat="server" ID="evaluatedeliverymethods" /><br />
                        </tr>
                        <tr>
                            <td>(iv)  Instructors of the Academic Programme	</td>
                            <td>
                                <asp:CheckBox runat="server" ID="evaluateinsturtors" /><br />
                        </tr>
                        <tr>
                            <td>(v)  System of assessment and examination	</td>
                            <td>
                                <asp:CheckBox runat="server" ID="CheckBox30" /><br />
                        </tr>
                        <tr>
                            <td>(b)  Does the department provide the students with feedback on what is done with the outcomes of the evaluation?&nbsp;&nbsp;&nbsp;	</td>
                            <td>
                                <asp:CheckBox runat="server" ID="studentsevaluationoutcomes" /><br />
                        </tr>
                        <tr>
                            <td>(c)   Are Staff given feedback on evaluation done by Students?</td>
                            <td>
                                <asp:CheckBox runat="server" ID="staffevaluationoutcomes" /><br />
                        </tr>
                    </table>

                    (d) Other Specify<br />
                    <asp:TextBox runat="server" CssClass="form-control" ID="otherspecifyevaluation" TextMode="MultiLine"></asp:TextBox><br />


                </p>
                <strong>b) How often are student evaluations of aspects in (a) carried out?<i>(Tick if Yes)</i></strong><br />
                <table>
                    <tr>
                        <td>i. Semesterly </td>
                        <td>
                            <asp:CheckBox runat="server" ID="semesterly" /><br />
                    </tr>
                    <tr>
                        <td>ii. Semi-annually.  </td>
                        <td>
                            <asp:CheckBox runat="server" ID="semiannuallys" /><br />
                    </tr>
                    <tr>
                        <td>iii. Annually.   </td>
                        <td>
                            <asp:CheckBox runat="server" ID="annuallys" /><br />
                    </tr>
                    <tr>
                        <td>ix. Once during the programme &nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <asp:CheckBox runat="server" ID="onceprogramme" /><br />
                    </tr>
                    <tr>
                        <td>x. Never. </td>
                        <td>
                            <asp:CheckBox runat="server" ID="never" /><br />
                    </tr>
                </table>
                <br />
                <strong>c) Attach Evidence for section (b) above</strong>
                <asp:FileUpload runat="server" ID="studentsevaluationsevidences" /><br />
                <strong>d) How long after evaluation is feedback given to:<i>(Tick if Yes)</i></strong><br />
                <strong>a. Students<i>(Tick if Yes)</i>?</strong>
                <br />

                <table>
                    <tr>
                        <td>i. The following semester within the academic year.&nbsp;&nbsp;&nbsp; </td>
                        <td>
                            <asp:CheckBox runat="server" ID="studentsthefolloingsem" /><br />
                    </tr>
                    <tr>
                        <td>ii. Once during the programme. </td>
                        <td>
                            <asp:CheckBox runat="server" ID="studentsonceprogram" /><br />
                    </tr>
                    <tr>
                        <td>iii. Never.</td>
                        <td>
                            <asp:CheckBox runat="server" ID="studentsnever" /><br />
                    </tr>
                </table>
                <br />
                <strong>b. . Staff<i>(Tick if Yes)</i>?</strong><br />
                <table>
                    <tr>
                        <td>i. The following semester within the academic year. &nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <asp:CheckBox runat="server" ID="stafffollowingsem" /><br />
                    </tr>
                    <tr>
                        <td>ii. Once during the programme. </td>
                        <td>
                            <asp:CheckBox runat="server" ID="staffonceprogramme" /><br />
                    </tr>
                    <tr>
                        <td>iii. Never. </td>
                        <td>
                            <asp:CheckBox runat="server" ID="staffnever" /><br />
                    </tr>
                </table>
                <br />
                <div class="row">
                    <div class="col-md-3 col-lg-3">
                        <div class="form-group">
                            <asp:Button runat="server" CssClass="btn btn-success pull-left" ID="studentsevaluation" Text="Submit Students Evaluation Details" OnClick="addStudentsEvaluations_Click" />
                        </div>
                    </div>
                </div>
                <br />
                <table class="table table-bordered table-striped dataTable">
                    <thead>
                        <tr>
                            <th>SN</th>
                            <th>Quality Number</th>
                            <th>Academic Year</th>
                            <th>Government Male</th>
                            <th>Government Female</th>
                            <th>Kenyan Students</th>
                            <th>International Students</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var StudentsProfiles = nav.Students_Profile.Where(r => r.QA_Number == QualityAuditNo);
                            int StudentsProfileCounter = 0;
                            foreach (var StudentsProfile in StudentsProfiles)
                            {
                                StudentsProfileCounter++;
                        %>
                        <tr>
                            <td><%=StudentsProfileCounter%></td>
                            <td><%=StudentsProfile.QA_Number%></td>
                            <td><%=StudentsProfile.Academic_Year%></td>
                            <td><%=StudentsProfile.Government_Sponsored_Male%></td>
                            <td><%=StudentsProfile.Government_Sponsored_Female%></td>
                            <td><%=StudentsProfile.Kenyan_Students%></td>
                            <td><%=StudentsProfile.International_Students%></td>
                            <td><label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                            <td><label class="btn btn-danger" onclick="deleteStudentsEvaluations('<%=StudentsProfile.QA_Number %>');"><i class="fa fa-trash"></i>Delete</label>
                            </td>

                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <div class="form-group">
                    <strong>Key strengths and weaknesses on Students Evaluation</strong>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <div class="panel panel-primary">
                                <div id="studentevaluationstrengthsfeedback" runat="server"></div>
                                <div class="panel-heading">
                                    Key Strengths
                                </div>
                                <div class="panel-body">
                                    <div class="form-group">
                                        <strong>Strength:</strong>
                                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Strength" ID="studentevaluationstrengths" TextMode="MultiLine" />
                                    </div>
                                    <div class="form-group">
                                        <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Strength" OnClick="addStudentsEvaluationStrenght_Click" />
                                    </div>
                                    <table class="table table-bordered table-striped dataTable">
                                        <thead>
                                            <tr>
                                                <th>SN</th>
                                                <th>Strength</th>
                                                <th>Edit</th>
                                                <th>Delete</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                var studentsevaluationsstrengthdescriptions = nav.StudentsEvalWeaknessStrengths.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Strengths");
                                                int studentsevaluationsstrengthCounter = 0;
                                                string studentsevaluationsstrengthdetails = "";
                                                string University_Code = Convert.ToString(Session["UniversityCode"]);
                                                foreach (var studentsevaluationsstrengthdescription in studentsevaluationsstrengthdescriptions)
                                                {
                                                    studentsevaluationsstrengthCounter++;
                                                    var studentsevaluationsstrength = new Config().ObjNav().FngetStudentsEvaluationsStrength(QualityAuditNo, University_Code);
                                                    studentsevaluationsstrengthdetails = Regex.Replace(studentsevaluationsstrength, @"[^0-9a-zA-Z]+", " ");
                                            %>
                                            <tr>
                                                <td><%=studentsevaluationsstrengthCounter%></td>
                                                <td><%=studentsevaluationsstrength%></td>
                                                <td>
                                                    <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                                <td>
                                                    <label class="btn btn-danger" onclick="deletestudentsevaluationsstrength('<%=studentsevaluationsstrengthdescription.Code %>');"><i class="fa fa-trash"></i>Delete</label>
                                                </td>
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
                                <div id="studentsevaluationweaknessfeedback" runat="server"></div>
                                <div class="panel-heading">
                                    Key Weaknesses
                                </div>
                                <div class="panel-body">

                                    <div class="form-group">
                                        <strong>Weakness:</strong>
                                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Weakness" ID="studentsevaluationweakness" TextMode="MultiLine" />
                                    </div>
                                    <div class="form-group">
                                        <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Weakness" OnClick="addStudentsEvaluationsWeaknesses_Click" />
                                    </div>
                                   <table class="table table-bordered table-striped dataTable">
                                        <thead>
                                            <tr>
                                                <th>SN</th>
                                                <th>Weakness</th>
                                                <th>Edit</th>
                                                <th>Delete</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                var studentsevaluationsweaknessesdescriptions = nav.StudentsEvalWeaknessStrengths.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Weakness");
                                                int studentsevaluationsweaknessescounter = 0;
                                                string studentsevaluationsweaknessesdetails = "";
                                                foreach (var studentsevaluationsweaknessesdescription in studentsevaluationsweaknessesdescriptions)
                                                {
                                                    studentsevaluationsweaknessescounter++;
                                                    var studentsevaluationsweaknesses = new Config().ObjNav().FngetStudentsEvaluationsWeakness(QualityAuditNo, University_Code);
                                                    studentsevaluationsweaknessesdetails = Regex.Replace(studentsevaluationsweaknesses, @"[^0-9a-zA-Z]+", " ");

                                            %>
                                            <tr>
                                                <td><%=studentsevaluationsweaknessescounter%></td>
                                                <td><%=studentsevaluationsweaknesses%></td>
                                                <td>
                                                    <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                                <td>
                                                    <label class="btn btn-danger" onclick="deletestudentsevaluationsweaknesses('<%=studentsevaluationsweaknessesdescription.Code %>');"><i class="fa fa-trash"></i>Delete</label>
                                                </td>
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
            </div>

            <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="next_Click" />
                <div class="clearfix"></div>
            </div>
        </div>
        <% }
            else if (currentStep == 15)
            {
        %>
        <div class="panel panel-primary">
            <div class="panel-heading">
                15.	Curriculum Design and Evaluation
            <label class="pull-right">Step <%=currentStep %> of <%=maxStep %></label>
                <div class="clearfix"></div>
            </div>
            <div id="curriculumnevaluationfeedback" runat="server"></div>
            <div class="panel-body">
                <table>
                    <tr>
                        <td>(a)Indicate if the following are undertaken during curriculum design/redesign and evaluation.&nbsp;&nbsp;&nbsp;<i>(Tick if Yes)</i></td>
                        <td>
                            <%--  <asp:CheckBox runat="server" ID="CheckBox37" /><br />--%>
                    </tr>
                    <tr>
                        <td style="padding-left: 15px !important">(i) Needs assessment involving stakeholders during curriculum design/redesign &nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <asp:CheckBox runat="server" ID="needassessment" /><br />
                    </tr>
                    <tr>
                        <td style="padding-left: 15px !important">(ii) Were employer and tracer studies carried out to advice on the curriculum design</td>
                        <td>
                            <asp:CheckBox runat="server" ID="employertracerstudies" /><br />
                    </tr>
                    <tr>
                        <td>(b)	The Curriculum is aligned to the Niche of the University <i>(Tick if Yes)</i></td>
                        <td>
                            <asp:CheckBox runat="server" ID="nicheofuniversity" /><br />
                    </tr>
                    <%--<tr>
                                    <td> (c)	Were Employer and tracer studies were carried out to advice on curriculum design? 	</td>
                                    <td>
                                       <asp:CheckBox runat="server" ID="employertracerstudies" /><br />
                                </tr>--%>
                    <tr>
                        <td>(c) During curriculum designing, benchmarking with other institutions is undertaken.<i>(Tick if Yes)</i></td>
                        <td>
                            <asp:CheckBox runat="server" ID="benchmarkinginstructions" /><br />
                    </tr>
                    <tr>
                        <td>(d) The department collaborates with, and participates in international networks activities.<i>(Tick if Yes)</i></td>
                        <td>
                            <asp:CheckBox runat="server" ID="collaboratiionwithinternational" /><br />
                    </tr>

                    <tr>
                        <td>(e) Is there a programme or curriculum committee<i>(Tick if Yes)</i>?</td>
                        <td>
                            <asp:CheckBox runat="server" ID="Checkbox34" /><br />
                    </tr>
                    <tr>
                        <td>(f) Does the evaluation of the programme involve:<i>(Tick if Yes)</i>  &nbsp;&nbsp;&nbsp;</td>

                    </tr>
                </table>
                <table>
                    <tr>
                        <td style="padding-left: 15px !important">
                            <li>Alumni </li>
                        </td>
                        <td>
                            <asp:CheckBox runat="server" ID="CheckBox35" /><br />
                    </tr>
                    <tr>
                        <td style="padding-left: 15px !important">
                            <li>Students &nbsp;&nbsp;</li>
                        </td>
                        <td>
                            <asp:CheckBox runat="server" ID="CheckBox1" /><br />
                    </tr>
                </table>
                <tr>
                    <td>(g)	At what level is the Programme Evaluated<i>(Tick if Yes)</i>?</td>
                    <td>
                </tr>

                <table>
                    <tr>

                        <td style="padding-left: 15px !important">
                            <li>Course level</li>
                        </td>
                        <td>
                            <asp:CheckBox runat="server" ID="courselevelevaluation" /><br />

                    </tr>
                    <tr>
                        <td style="padding-left: 15px !important">
                            <li>Curriculum Level&nbsp;&nbsp;&nbsp;</li>
                        </td>
                        <td>
                            <asp:CheckBox runat="server" ID="curriculmnevaluationlevel" /><br />

                    </tr>
                </table>
                <br />
                <table>
                    <tr>
                        <td>(h) Are the students involved in evaluating the programme<i>(Tick if Yes)</i>? &nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <asp:CheckBox runat="server" ID="studentsinvolvedevaluation" /><br />
                    </tr>
                    <tr>
                        <td>(i) If yes in 15 (h),are the results of the evaluation:<i>(Tick if Yes)</i>&nbsp;&nbsp;&nbsp;</td>
                        <td>
                    </tr>
                    <tr>
                        <td style="padding-left: 15px !important">
                            <li>Made known to students and lecturers?</li>
                        </td>
                        <td>
                            <asp:CheckBox runat="server" ID="studentslecturersknow" /><br />
                    </tr>
                    <tr>
                        <td style="padding-left: 15px !important">
                            <li>Applied in subsequent reviews? </li>
                        </td>
                        <td>
                            <asp:CheckBox runat="server" ID="appliedsubsequentreviews" /><br />
                    </tr>
                </table>
                <br />
                <div class="row">
                    <div class="col-md-3 col-lg-3">
                        <div class="form-group">
                            <asp:Button runat="server" CssClass="btn btn-success pull-left" ID="curriculumnevaluation" Text="Submit Curriculum Design and Evaluation Details" OnClick="addCurriculumnEvaluation_Click" />
                        </div>
                    </div>
                </div>
                <br />
                <table class="table table-bordered table-striped dataTable">
                    <thead>
                        <tr>
                            <th>SN</th>
                            <th>Quality Number</th>
                            <th>Academic Year</th>
                            <th>Government Male</th>
                            <th>Government Female</th>
                            <th>Kenyan Students</th>
                            <th>International Students</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var StudentsProfiles = nav.Students_Profile.Where(r => r.QA_Number == QualityAuditNo);
                            int StudentsProfileCounter = 0;
                            foreach (var StudentsProfile in StudentsProfiles)
                            {
                                StudentsProfileCounter++;
                        %>
                        <tr>
                            <td><%=StudentsProfileCounter%></td>
                            <td><%=StudentsProfile.QA_Number%></td>
                            <td><%=StudentsProfile.Academic_Year%></td>
                            <td><%=StudentsProfile.Government_Sponsored_Male%></td>
                            <td><%=StudentsProfile.Government_Sponsored_Female%></td>
                            <td><%=StudentsProfile.Kenyan_Students%></td>
                            <td><%=StudentsProfile.International_Students%></td>
                            <td>
                                <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                            <td>
                                <label class="btn btn-danger" onclick="deleteCurriculumDesign('<%=StudentsProfile.Code %>');"><i class="fa fa-trash"></i>Delete</label>
                            </td>

                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <div class="form-group">
                    <strong>Key strengths and weaknesses on Curriculumn Design & Evaluation</strong>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <div class="panel panel-primary">
                                <div id="curriculumndesignstrengthsfeedback" runat="server"></div>
                                <div class="panel-heading">
                                    Key Strengths
                                </div>
                                <div class="panel-body">
                                    <div class="form-group">
                                        <strong>Strength:</strong>
                                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Strength" ID="curriculumndesignstrengths" TextMode="MultiLine" />
                                    </div>
                                    <div class="form-group">
                                        <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Strength" OnClick="addCurriculumndesignStrengths_Click" />
                                    </div>
                                    <table class="table table-bordered table-striped dataTable">
                                        <thead>
                                            <tr>
                                                <th>SN</th>
                                                <th>Strength</th>
                                                <th>Edit</th>
                                                <th>Delete</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                var curriculumndesignstrengthsinfos = nav.CurriculumnWeaknessStrength.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Strengths");
                                                int curriculumndesignstrengthsCounter = 0;
                                                string curriculumndesignstrengthsdetails = "";
                                                string University_Code = Convert.ToString(Session["UniversityCode"]);
                                                foreach (var curriculumndesignstrengthsinfo in curriculumndesignstrengthsinfos)
                                                {
                                                    curriculumndesignstrengthsCounter++;
                                                    var curriculumndesignstrengths = new Config().ObjNav().FngetCurriculumnDesignStrength(QualityAuditNo, University_Code);
                                                    curriculumndesignstrengthsdetails = Regex.Replace(curriculumndesignstrengths, @"[^0-9a-zA-Z]+", " ");
                                            %>
                                            <tr>
                                                <td><%=curriculumndesignstrengthsCounter%></td>
                                                <td><%=curriculumndesignstrengths%></td>
                                                <td>
                                                    <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                                <td>
                                                    <label class="btn btn-danger" onclick="deletecurriculumndesignstrengthsinfo('<%=curriculumndesignstrengthsinfo.Code %>');"><i class="fa fa-trash"></i>Delete</label>
                                                </td>
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
                                    <div id="curriculumndesignweaknessfeedback" runat="server"></div>
                                    <div class="form-group">
                                        <strong>Weakness:</strong>
                                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Weakness" ID="curriculumndesignweakness" TextMode="MultiLine" />
                                    </div>
                                    <div class="form-group">
                                        <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Weakness" OnClick="addCurriculumnDesignWeaknesses_Click" />
                                    </div>
                                    <table class="table table-bordered table-striped dataTable">
                                        <thead>
                                            <tr>
                                                <th>SN</th>
                                                <th>Weakness</th>
                                                <th>Edit</th>
                                                <th>Delete</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                var curriculumndesignweaknessinfos = nav.CurriculumnWeaknessStrength.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Weakness");
                                                int curriculumndesignweaknesscounter = 0;
                                                string curriculumndesignweaknessdetails = "";
                                                foreach (var curriculumndesignweaknessinfo in curriculumndesignweaknessinfos)
                                                {
                                                    curriculumndesignweaknesscounter++;
                                                    var curriculumndesignweakness = new Config().ObjNav().FngetCurriculumnDesignWeakness(QualityAuditNo, University_Code);
                                                    curriculumndesignweaknessdetails = Regex.Replace(curriculumndesignweakness, @"[^0-9a-zA-Z]+", " ");

                                            %>
                                            <tr>
                                                <td><%=curriculumndesignweaknesscounter%></td>
                                                <td><%=curriculumndesignweakness%></td>
                                                <td>
                                                    <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                                <td>
                                                    <label class="btn btn-danger" onclick="deletecurriculumndesignweaknessinfo('<%=curriculumndesignweaknessinfo.Code %>');"><i class="fa fa-trash"></i>Delete</label>
                                                </td>
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
            </div>
            <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="next_Click" />
                <div class="clearfix"></div>
            </div>
        </div>
        <% }
            else if (currentStep == 16)
            {
        %>
        <div class="panel panel-primary">
            <div class="panel-heading">
                16.	Staff Development Activities
            <label class="pull-right">Step <%=currentStep %> of <%=maxStep %></label>
                <div class="clearfix"></div>
            </div>
            <div id="staffdevelopmentfeedback" runat="server"></div>
            <div class="panel-body">
                (a)	The University has a training programme for the academic staff on:<i>(Tick if Yes)</i><br />
                <table>
                    <tr>
                        <td style="padding-left: 15px !important">(i)	Curriculum design	</td>
                        <td>
                            <asp:CheckBox runat="server" ID="curriculumndesign" /><br />
                    </tr>
                    <tr>
                        <td style="padding-left: 15px !important">(ii)	Test development and construction &nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <asp:CheckBox runat="server" ID="testdevelopment" /><br />
                    </tr>
                    <tr>
                        <td style="padding-left: 15px !important">(iii)	 Teaching skills &nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <asp:CheckBox runat="server" ID="teachingskills" /><br />
                    </tr>
                    <tr>
                        <td style="padding-left: 15px !important">(iv )	 ICT integration in teaching and learning &nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <asp:CheckBox runat="server" ID="ictintergration" /><br />
                    </tr>
                    <tr>
                        <td>(b)	The university offers the academic staff possibilities to develop and extend their teaching abilities. &nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <asp:CheckBox runat="server" ID="extendteachingabilities" /><br />
                    </tr>
                    <tr>
                        <td>(c)	The University provides opportunities and support to Staff to pursue further studies &nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <asp:CheckBox runat="server" ID="pursuefurtherstudies" /><br />
                    </tr>
                    <tr>
                        <td>(d)Does the university have a mechanism for identifying teaching staff development needs in relation to curriculum and institutional requirements <i>(Tick if yes)</i> &nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <asp:CheckBox runat="server" ID="CheckBox3" /><br />
                    </tr>
                </table>
                (e) Attach Evidence on Staff Development Activities
                            <asp:FileUpload ID="attachevidence" runat="server" /><br />

                <div class="row">
                    <div class="col-md-3 col-lg-3">
                        <div class="form-group">
                            <asp:Button runat="server" CssClass="btn btn-success pull-left" ID="staffdevelopment" Text="Submit Staff Development Activities" OnClick="addStaffDevelopmentActivities_Click" />
                        </div>
                    </div>
                </div>
                <br />
                <table class="table table-bordered table-striped dataTable">
                    <thead>
                        <tr>
                            <th>SN</th>
                            <th>Quality Number</th>
                            <th>Academic Year</th>
                            <th>Government Male</th>
                            <th>Government Female</th>
                            <th>Kenyan Students</th>
                            <th>International Students</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var StudentsProfiles = nav.Students_Profile.Where(r => r.QA_Number == QualityAuditNo);
                            int StudentsProfileCounter = 0;
                            foreach (var StudentsProfile in StudentsProfiles)
                            {
                                StudentsProfileCounter++;
                        %>
                        <tr>
                            <td><%=StudentsProfileCounter%></td>
                            <td><%=StudentsProfile.QA_Number%></td>
                            <td><%=StudentsProfile.Academic_Year%></td>
                            <td><%=StudentsProfile.Government_Sponsored_Male%></td>
                            <td><%=StudentsProfile.Government_Sponsored_Female%></td>
                            <td><%=StudentsProfile.Kenyan_Students%></td>
                            <td><%=StudentsProfile.International_Students%></td>
                            <td>
                                <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                            <td>
                                <label class="btn btn-danger" onclick="deleteRationale('<%=StudentsProfile.QA_Number %>');"><i class="fa fa-trash"></i>Delete</label>
                            </td>

                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <div class="form-group">
                    <strong>Key strengths and weaknesses on Students Development Activities</strong>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <div class="panel panel-primary">
                                <div id="studentdevelopmentstrengthfeedback" runat="server"></div>
                                <div class="panel-heading">
                                    Key Strengths
                                </div>
                                <div class="panel-body">
                                    <div class="form-group">
                                        <strong>Strength:</strong>
                                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Strength" ID="studentdevelopmentstrength" TextMode="MultiLine" />
                                    </div>
                                    <div class="form-group">
                                        <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Strength" OnClick="addStudentsDevelopmentStrenght_Click" />
                                    </div>
                                    <table class="table table-bordered table-striped dataTable">
                                        <thead>
                                            <tr>
                                                <th>SN</th>
                                                <th>Strength</th>
                                                <th>Edit</th>
                                                <th>Delete</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                var studentsdevelopmentstrengthinfos = nav.StudentsDevWeaknessStrength.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Strengths");
                                                int studentsdevelopmentstrengthsCounter = 0;
                                                string studentsdevelopmentstrengthsdetails = "";
                                                string University_Code = Convert.ToString(Session["UniversityCode"]);
                                                foreach (var studentsdevelopmentstrengthinfo in studentsdevelopmentstrengthinfos)
                                                {
                                                    studentsdevelopmentstrengthsCounter++;
                                                    var studentsdevelopmentstrengths = new Config().ObjNav().FngetStudentsDevelopmentStrength(QualityAuditNo, University_Code);
                                                    studentsdevelopmentstrengthsdetails = Regex.Replace(studentsdevelopmentstrengths, @"[^0-9a-zA-Z]+", " ");

                                            %>
                                            <tr>
                                                <td><%=studentsdevelopmentstrengthsCounter%></td>
                                                <td><%=studentsdevelopmentstrengths%></td>
                                                <td>
                                                    <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                                <td>
                                                    <label class="btn btn-danger" onclick="deletestudentsdevelopmentstrengthinfo('<%=studentsdevelopmentstrengthinfo.Code %>');"><i class="fa fa-trash"></i>Delete</label>
                                                </td>

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
                                <div id="studentsdevelopmentweaknessfeeback" runat="server"></div>
                                <div class="panel-heading">
                                    Key Weaknesses
                                </div>
                                <div class="panel-body">

                                    <div class="form-group">
                                        <strong>Weakness:</strong>
                                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Weakness" ID="studentsdevelopmentweakness" TextMode="MultiLine" />
                                    </div>
                                    <div class="form-group">
                                        <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Weakness" OnClick="addStudentsDevelopmentWeaknesses_Click" />
                                    </div>
                                    <table class="table table-bordered table-striped dataTable">
                                        <thead>
                                            <tr>
                                                <th>SN</th>
                                                <th>Weakness</th>
                                                <th>Edit</th>
                                                <th>Delete</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                var studentsdevelopmentweaknessinfos = nav.StudentsDevWeaknessStrength.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Weakness");
                                                int studentsdevelopmentweaknesscounter = 0;
                                                string studentsdevelopmentweaknessdetails = "";
                                                foreach (var studentsdevelopmentweaknessinfo in studentsdevelopmentweaknessinfos)
                                                {
                                                    studentsdevelopmentweaknesscounter++;
                                                    var studentsdevelopmentweakness = new Config().ObjNav().FngetStudentsDevelopmentWeakness(QualityAuditNo, University_Code);
                                                    studentsdevelopmentweaknessdetails = Regex.Replace(studentsdevelopmentweakness, @"[^0-9a-zA-Z]+", " ");

                                            %>
                                            <tr>
                                                <td><%=studentsdevelopmentweaknesscounter%></td>
                                                <td><%=studentsdevelopmentweakness%></td>
                                                <td>
                                                    <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                                <td>
                                                    <label class="btn btn-danger" onclick="deletestudentsdevelopmentweaknessinfo('<%=studentsdevelopmentweaknessinfo.Code %>');"><i class="fa fa-trash"></i>Delete</label>
                                                </td>
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
            </div>
            <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="next_Click" />
                <div class="clearfix"></div>
            </div>
        </div>
        <% }
            else if (currentStep == 17)
            {
        %>
        <div class="panel panel-primary">
            <div class="panel-heading">
                17.	Benchmarking
            <label class="pull-right">Step <%=currentStep %> of <%=maxStep %></label>
                <div class="clearfix"></div>
            </div>
            <div id="benchmarkingfeedback" runat="server"></div>
            <div class="panel-body">
                <table>

                    <tr>
                        <td>(a)  Does the university undertake benchmarking to analyse the quality and performance of the programme?<i>(Tick if Yes)</i>&nbsp;&nbsp;</td>
                        <td>

                            <asp:CheckBox runat="server" ID="Checkbox6" /><br />
                    </tr>
                    <tr>
                        <td>(b)  Does the university have a benchmarking guideline/policy?<i>(Tick if Yes)</i>	</td>
                        <td>
                            <asp:CheckBox runat="server" ID="Checkbox5" /><br />
                    </tr>
                    <tr>
                        <td>(c)	Is the University using a guideline/policy benchmarking for the programme?<i>(Tick if Yes)</i></td>
                        <td>
                            <asp:CheckBox runat="server" ID="policybenchmarking" /><br />
                    </tr>
                    <tr>
                        <td>(d)	Is the information collected from benchmarking?<i>(Tick if Yes)</i></td>
                    </tr>
                    <tr>
                        <td style="padding-left: 15px !important">(i)	 Analysed</td>
                        <td>
                            <asp:CheckBox runat="server" ID="benchmarkinganalysed" /><br />
                    </tr>
                    <tr>
                        <td style="padding-left: 15px !important">(ii)	Used by management for decision making</td>
                        <td>
                            <asp:CheckBox runat="server" ID="benchmarkingusedbymarnagement" /><br />
                    </tr>
                </table>
                <br />
                <div class="row">
                    <div class="col-md-3 col-lg-3">
                        <div class="form-group">
                            <asp:Button runat="server" CssClass="btn btn-success pull-left" ID="benchmarking" Text="Submit Benhcmarking Details" OnClick="addBenchmarkingDetails_Click" />
                        </div>
                    </div>
                </div>
                <br />
                <table class="table table-bordered table-striped dataTable">
                    <thead>
                        <tr>
                            <th>SN</th>
                            <th>Quality Number</th>
                            <th>Academic Year</th>
                            <th>Government Male</th>
                            <th>Government Female</th>
                            <th>Kenyan Students</th>
                            <th>International Students</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var StudentsProfiles = nav.Students_Profile.Where(r => r.QA_Number == QualityAuditNo);
                            int StudentsProfileCounter = 0;
                            foreach (var StudentsProfile in StudentsProfiles)
                            {
                                StudentsProfileCounter++;
                        %>
                        <tr>
                            <td><%=StudentsProfileCounter%></td>
                            <td><%=StudentsProfile.QA_Number%></td>
                            <td><%=StudentsProfile.Academic_Year%></td>
                            <td><%=StudentsProfile.Government_Sponsored_Male%></td>
                            <td><%=StudentsProfile.Government_Sponsored_Female%></td>
                            <td><%=StudentsProfile.Kenyan_Students%></td>
                            <td><%=StudentsProfile.International_Students%></td>
                            <td>
                                <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                            <td>
                                <label class="btn btn-danger" onclick="deleteRationale('<%=StudentsProfile.QA_Number %>');"><i class="fa fa-trash"></i>Delete</label>
                            </td>

                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <div class="form-group">
                    <strong>Key strengths and weaknesses on BenchMarking</strong>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <div class="panel panel-primary">
                                <div id="benchmarkingstrengthsfeedback" runat="server"></div>
                                <div class="panel-heading">
                                    Key Strengths
                                </div>
                                <div class="panel-body">
                                    <div class="form-group">
                                        <strong>Strength:</strong>
                                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Strength" ID="benchmarkingstrengths" TextMode="MultiLine" />
                                    </div>
                                    <div class="form-group">
                                        <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Strength" OnClick="addBenchmarkingStrenght_Click" />
                                    </div>
                                    <table class="table table-bordered table-striped dataTable">
                                        <thead>
                                            <tr>
                                                <th>SN</th>
                                                <th>Strength</th>
                                                <th>Edit</th>
                                                <th>Delete</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                var Benchmarkingstrenghtsinfos = nav.BenchmarkingWeaknessStrength.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Strengths");
                                                int BenchmarkingstrengthsCounter = 0;
                                                string Benchmarkingstrengthsdetails = "";
                                                string University_Code = Convert.ToString(Session["UniversityCode"]);
                                                foreach (var Benchmarkingstrenghtsinfo in Benchmarkingstrenghtsinfos)
                                                {
                                                    BenchmarkingstrengthsCounter++;
                                                    var Benchmarkingstrengths = new Config().ObjNav().FngetBenchmarkingStrength(QualityAuditNo, University_Code);
                                                    Benchmarkingstrengthsdetails = Regex.Replace(Benchmarkingstrengths, @"[^0-9a-zA-Z]+", " ");

                                            %>
                                            <tr>
                                                <td><%=BenchmarkingstrengthsCounter%></td>
                                                <td><%=Benchmarkingstrengths%></td>
                                                <td>
                                                    <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                                <td>
                                                    <label class="btn btn-danger" onclick="deleteBenchmarkingstrenghtsinfo('<%=Benchmarkingstrenghtsinfo.Code %>');"><i class="fa fa-trash"></i>Delete</label>
                                                </td>
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
                                <div id="benchmarkingweaknessfeedback" runat="server"></div>
                                <div class="panel-heading">
                                    Key Weaknesses
                                </div>
                                <div class="panel-body">

                                    <div class="form-group">
                                        <strong>Weakness:</strong>
                                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Weakness" ID="benchmarkingweakness" TextMode="MultiLine" />
                                    </div>
                                    <div class="form-group">
                                        <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Weakness" OnClick="addBenchmarkingWeaknesses_Click" />
                                    </div>
                                    <table class="table table-bordered table-striped dataTable">
                                        <thead>
                                            <tr>
                                                <th>SN</th>
                                                <th>Weakness</th>
                                                <th>Edit</th>
                                                <th>Delete</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                var Benchmarkingweaknessinfos = nav.BenchmarkingWeaknessStrength.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Weakness");
                                                int BenchmarkingweaknessCounter = 0;
                                                string Benchmarkingweaknessdetails = "";
                                                foreach (var Benchmarkingweaknessinfo in Benchmarkingweaknessinfos)
                                                {
                                                    BenchmarkingweaknessCounter++;
                                                    var Benchmarkingweakness = new Config().ObjNav().FngetBenchmarkingWeakness(QualityAuditNo, University_Code);
                                                    Benchmarkingweaknessdetails = Regex.Replace(Benchmarkingweakness, @"[^0-9a-zA-Z]+", " ");

                                            %>
                                            <tr>
                                                <td><%=BenchmarkingweaknessCounter%></td>
                                                <td><%=Benchmarkingweakness%></td>
                                                <td>
                                                    <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                                <td>
                                                    <label class="btn btn-danger" onclick="deleteBenchmarkingweaknessinfo('<%=Benchmarkingweaknessinfo.Code %>');"><i class="fa fa-trash"></i>Delete</label>
                                                </td>
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
            </div>
            <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="next_Click" />
                <div class="clearfix"></div>
            </div>
        </div>
        <% }
            else if (currentStep == 18)
            {
        %>
        <div class="panel panel-primary">
            <div class="panel-heading">
                18.	The Achievements: The Graduates
            <label class="pull-right">Step <%=currentStep %> of <%=maxStep %></label>
                <div class="clearfix"></div>
            </div>
            <div id="graduatefeedback" runat="server"></div>
            <div class="panel-body">
                <table>
                    <tr>
                        <td>(a)	 Is there a mechanism for tracking students from the start to the end of the duration?<i>(Tick if Yes)</i>&nbsp;&nbsp;&nbsp;&nbsp; </td>
                        <td>
                            <asp:CheckBox runat="server" ID="trackingprogress" /><br />
                        </td>
                    </tr>
                    <%-- <tr>
                                <td> (b)	Does the department know where the dropout students go?<i>(Tick if Yes)</i></td>
                                <td>
                                    <asp:CheckBox runat="server" ID="dropoutsawareness" /><br />
                                </td>
                            </tr>--%>
                    <tr>
                        <td>(b)  Is there a mechanism for tracing dropout students to establish?<i>(Tick if Yes)</i></td>
                        <td>
                            <asp:CheckBox runat="server" ID="dropoutsawareness" /><br />
                        </td>
                        <table>
                            <tr>
                                <td style="padding-left: 15px !important">
                                    <li>Reasons for dropouts?</li>
                                </td>
                                <td>
                                    <asp:CheckBox runat="server" ID="CheckBox2" /><br />
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-left: 15px !important">
                                    <li>Where dropout students go?</li>
                                </td>
                                <td>
                                    <asp:CheckBox runat="server" ID="CheckBox4" /><br />
                                </td>
                            </tr>
                        </table>
                    </tr>

                    <tr>
                        <td>(c)	Does the University document reasons for student dropout?<i>(Tick if Yes)</i></td>
                        <td>
                            <asp:CheckBox runat="server" ID="dropoutreasonsdocumented" /><br />
                        </td>
                    </tr>
                </table>
                (d)	If yes in 18 (c), provide the distribution of percentage analysis of the following options:
                            <br />
                <table>
                    <tr>
                        <td style="padding-left: 15px !important">(i)	Financial Challenges			 </td>
                        <td>
                            <asp:TextBox runat="server" ID="financialchallenges" />%
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 15px !important">(ii)	Poor Secondary School Preparation	 </td>
                        <td>
                            <asp:TextBox runat="server" ID="poorsecondary" />%<br />
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 15px !important">(iii)	Conflict with work and family commitments </td>
                        <td>
                            <asp:TextBox runat="server" ID="conflictwithwork" />%<br />
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 15px !important">(iv)	Examinations Challenges		 </td>
                        <td>
                            <asp:TextBox runat="server" ID="examinationchallenges" />%<br />
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 15px !important">(v)	Lack of quality time with teachers and counsellors	 </td>
                        <td>
                            <asp:TextBox runat="server" ID="lackofqualitytime" />%<br />
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 15px !important">(vi)	Lack of peer support 		 </td>
                        <td>
                            <asp:TextBox runat="server" ID="lackofpeersupport" />%<br />
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 15px !important">(vii)	Health issues			 </td>
                        <td>
                            <asp:TextBox runat="server" ID="healthissues" />%<br />
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 15px !important">(viii)	Disciplinary grounds</td>
                        <td>
                            <asp:TextBox runat="server" ID="disciplinarygrounds" />%
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 15px !important">(ix)	Other (specify)	</td>
                        <td>
                            <asp:TextBox runat="server" ID="otherspecifygraduates" />%<br />
                        </td>
                    </tr>
                </table>
                (e)	Does the department use the information from its tracking system to provide guidance to students and to improve on the completion rate?<i>(Tick if Yes)</i><asp:CheckBox runat="server" ID="trackinginforused" /><br />
                (f)	Does the university have a mechanism/system for establishing the employment rate of the department?<i>(Tick if Yes)</i>
                <asp:CheckBox runat="server" ID="employmentrateawareness" /><br />
                (g)	If yes in (f), then Indicate what percentage are still unemployed 2 years after graduation.<i>(Tick if Yes)</i>?
                            <br />
                <table>
                    <tr>
                        <td style="padding-left: 15px !important">i) Below 25% &nbsp;&nbsp;&nbsp;  </td>
                        <td>
                            <asp:CheckBox runat="server" ID="below25unemployment" />
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 15px !important">ii) 25-50%  </td>
                        <td>
                            <asp:CheckBox runat="server" ID="between2550unemplyment" /><br />
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 15px !important">iii) 51-75% </td>
                        <td>
                            <asp:CheckBox runat="server" ID="between5175unemployment" /><br />
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 15px !important">iv) Over 75%</td>
                        <td>
                            <asp:CheckBox runat="server" ID="over75unemployment" /><br />
                        </td>
                    </tr>
                </table>

                (h) What is the average time taken in (years) for a student to complete the programme?<br />
                <asp:TextBox ID="TextBox108" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox><br />

                <div class="row">
                    <div class="col-md-3 col-lg-3">
                        <div class="form-group">
                            <asp:Button runat="server" CssClass="btn btn-success pull-left" ID="graduatesachievement" Text="Submit Graduates Achievement Details" OnClick="addGraduatesAcheievement_Click" />
                        </div>
                    </div>
                </div>
                <table class="table table-bordered table-striped dataTable">
                    <thead>
                        <tr>
                            <th>SN</th>
                            <th>Quality Number</th>
                            <th>Academic Year</th>
                            <th>Government Male</th>
                            <th>Government Female</th>
                            <th>Kenyan Students</th>
                            <th>International Students</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var StudentsProfiles = nav.Students_Profile.Where(r => r.QA_Number == QualityAuditNo);
                            int StudentsProfileCounter = 0;
                            foreach (var StudentsProfile in StudentsProfiles)
                            {
                                StudentsProfileCounter++;
                        %>
                        <tr>
                            <td><%=StudentsProfileCounter%></td>
                            <td><%=StudentsProfile.QA_Number%></td>
                            <td><%=StudentsProfile.Academic_Year%></td>
                            <td><%=StudentsProfile.Government_Sponsored_Male%></td>
                            <td><%=StudentsProfile.Government_Sponsored_Female%></td>
                            <td><%=StudentsProfile.Kenyan_Students%></td>
                            <td><%=StudentsProfile.International_Students%></td>
                            <td>
                                <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                            <td>
                                <label class="btn btn-danger" onclick="deleteRationale('<%=StudentsProfile.QA_Number %>');"><i class="fa fa-trash"></i>Delete</label>
                            </td>

                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <div class="form-group">
                    <strong>Key strengths and weaknesses on Achievement of Graduates</strong>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <div class="panel panel-primary">
                                <div id="graduatesstrengthsfeedback" runat="server"></div>
                                <div class="panel-heading">
                                    Key Strengths
                                </div>
                                <div class="panel-body">
                                    <div class="form-group">
                                        <strong>Strength:</strong>
                                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Strength" ID="graduatesachievementstrengths" TextMode="MultiLine" />
                                    </div>
                                    <div class="form-group">
                                        <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Strength" OnClick="addGraduatesStrenght_Click" />
                                    </div>
                                     <table class="table table-bordered table-striped dataTable">
                                        <thead>
                                            <tr>
                                                <th>SN</th>
                                                <th>Strength</th>
                                                <th>Edit</th>
                                                <th>Delete</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                var graduatestrenghtsinfos = nav.GraduatesAchivWeaknessStrength.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Strengths");
                                                int graduatestrenghtsCounter = 0;
                                                string graduatesstrengthsdetails = "";
                                                string University_Code = Convert.ToString(Session["UniversityCode"]);
                                                foreach (var graduatestrenghtsinfo in graduatestrenghtsinfos)
                                                {
                                                    graduatestrenghtsCounter++;
                                                    var graduatesstrengths = new Config().ObjNav().FngetGraduatesStrength(QualityAuditNo, University_Code);
                                                   graduatesstrengthsdetails = Regex.Replace(graduatesstrengths, @"[^0-9a-zA-Z]+", " ");
                                            %>
                                            <tr>
                                                <td><%=graduatestrenghtsCounter%></td>
                                                <td><%=graduatesstrengths%></td>
                                                <td>
                                                    <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                                <td>
                                                    <label class="btn btn-danger" onclick="deletegraduatestrenghtsinfo('<%=graduatestrenghtsinfo.Code %>');"><i class="fa fa-trash"></i>Delete</label>
                                                </td>
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

                                <div id="graduatesweaknessfeedback" runat="server"></div>
                                <div class="panel-heading">
                                    Key Weaknesses
                                </div>
                                <div class="panel-body">
                                    <div class="form-group">
                                        <strong>Weakness:</strong>
                                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Weakness" ID="graduateachievementsweakness" TextMode="MultiLine" />
                                    </div>
                                    <div class="form-group">
                                        <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Weakness" OnClick="addGraduatesWeaknesses_Click" />
                                    </div>
                                    <table class="table table-bordered table-striped dataTable">
                                        <thead>
                                            <tr>
                                                <th>SN</th>
                                                <th>Weakness</th>
                                                <th>Edit</th>
                                                <th>Delete</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                var graduatesweaknessesinfos = nav.GraduatesAchivWeaknessStrength.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Weakness");
                                                int graduatesweaknessescounter = 0;
                                                string graduatesweaknessesdetails = "";
                                                foreach (var graduatesweaknessesinfo in graduatesweaknessesinfos)
                                                {
                                                    graduatesweaknessescounter++;
                                                    var graduatesweaknesses = new Config().ObjNav().FngetGraduatesWeakness(QualityAuditNo, University_Code);
                                                    graduatesweaknessesdetails = Regex.Replace(graduatesweaknesses, @"[^0-9a-zA-Z]+", " ");
                                            %>
                                            <tr>
                                                <td><%=graduatesweaknessescounter%></td>
                                                <td><%=graduatesweaknesses%></td>
                                                <td>
                                                    <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                                <td>
                                                    <label class="btn btn-danger" onclick="deletegraduateweaknesssinfo('<%=graduatesweaknessesinfo.Code %>');"><i class="fa fa-trash"></i>Delete</label>
                                                </td>
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
            </div>
            <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="next_Click" />
                <div class="clearfix"></div>
            </div>
        </div>
        <% }
            else if (currentStep == 19)
            {
        %>
        <div class="panel panel-primary">
            <div class="panel-heading">
                19.	Stakeholders Satisfaction
            <label class="pull-right">Step <%=currentStep %> of <%=maxStep %></label>
                <div class="clearfix"></div>
            </div>
            <div id="stakeholderssatisfactionfeedback" runat="server"></div>
            <div class="panel-body">
                <strong>(a) Students Opinions<i>(Tick if Yes)</i></strong><br />
                <p>
                    <table>
                        (i)	Does the department have student opinion about:
                    <tr>
                        <td style="padding-left: 15px !important">•	The courses	 </td>
                        <td>
                            <asp:CheckBox runat="server" ID="courseopinion" />
                        </td>
                    </tr>
                        <tr>
                            <td style="padding-left: 15px !important">•	The programme</td>
                            <td>
                                <asp:CheckBox runat="server" ID="programmeopinion" />
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 15px !important">•The teaching	</td>
                            <td>
                                <asp:CheckBox runat="server" ID="teachingopinion" />
                            </td>
                        </tr>
                        <tr>
                            <td>(ii)	The department processes students complains 	</td>
                            <td>
                                <asp:CheckBox runat="server" ID="studentscomplaints" />
                            </td>
                        </tr>
                        <tr>
                            <td>(iii)	Students are given feedback on their complains</td>
                            <td>
                                <asp:CheckBox runat="server" ID="complaintsfeedback" />
                            </td>
                        </tr>
                        <tr>
                            <td>(iv)	Information from students’ complains is used in decision making &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td>
                                <asp:CheckBox runat="server" ID="decisionmakingcomplaints" /><br />
                            </td>
                    </table>
                    (v)  Attach Evidence on Students Opinion
                <asp:FileUpload ID="FileUpload1" runat="server" /><br />
                    <strong>(b) Alumni/Graduates Opinion<i>(Tick if Yes)</i></strong><br />
                    (i) How regular does the department interview Alumni/graduates of the programme 
                 <table>
                     <tr>
                         <td style="padding-left: 15px !important">• At Graduation </td>
                         <td>
                             <asp:CheckBox runat="server" ID="graduationopinion" />
                         </td>
                     </tr>
                     <tr>
                         <td style="padding-left: 15px !important">•  Annually	</td>
                         <td>
                             <asp:CheckBox runat="server" ID="annallyinterview" />
                         </td>
                     </tr>
                     <tr>
                         <td style="padding-left: 15px !important">•	Every two Years &nbsp;&nbsp;&nbsp;	</td>
                         <td>
                             <asp:CheckBox runat="server" ID="everytwoyears" />
                         </td>
                     </tr>
                     <tr>
                         <td style="padding-left: 15px !important">•	Never </td>
                         <td>
                             <asp:CheckBox runat="server" ID="neverinterviewed" />
                         </td>
                     </tr>
                 </table>


                    (ii)	Is the feedback of the alumni used in programme review?
                    <asp:CheckBox runat="server" ID="alumniprogrammereview" /><br />
                    (iii)   Attach Evidence on Alumni/Graduates Opinion.
                <asp:FileUpload ID="FileUpload4" runat="server" /><br />
                    <strong>(c) Labour Market Opinion<i>(Tick if Yes)</i></strong><br />
                    <table>
                        <tr>
                            <td style="padding-left: 15px !important">(i) Are there structured contacts with employers and the labour market for getting feedback on graduates? &nbsp;&nbsp;&nbsp; </td>
                            <td>
                                <asp:CheckBox runat="server" ID="labourmarketcontacts" />
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 15px !important">(ii)	The department analyses feedback from labour market</td>
                            <td>
                                <asp:CheckBox runat="server" ID="labourmarketfeedback" />
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 15px !important">(iii) Feedback from the labour market is utilized in programme review and redesign</td>
                            <td>
                                <asp:CheckBox runat="server" ID="labourmarketfeedbackutilization" /><br />
                            </td>
                        </tr>

                    </table>
                    (iii) Attach Evidence on Stakeholders Satisfaction
                <asp:FileUpload ID="FileUpload2" runat="server" />
                </p>
                <div class="row">
                    <div class="col-md-3 col-lg-3">
                        <div class="form-group">
                            <asp:Button runat="server" CssClass="btn btn-success pull-left" ID="stakeholderssatisfaction" Text="Submit Stakeholders Satisfaction Details" OnClick="addStakeholdersSatisfaction_Click" />
                        </div>
                    </div>
                </div>
                <br />
                <table class="table table-bordered table-striped dataTable">
                    <thead>
                        <tr>
                            <th>SN</th>
                            <th>Quality Number</th>
                            <th>Academic Year</th>
                            <th>Government Male</th>
                            <th>Government Female</th>
                            <th>Kenyan Students</th>
                            <th>International Students</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var StudentsProfiles = nav.Students_Profile.Where(r => r.QA_Number == QualityAuditNo);
                            int StudentsProfileCounter = 0;
                            foreach (var StudentsProfile in StudentsProfiles)
                            {
                                StudentsProfileCounter++;
                        %>
                        <tr>
                            <td><%=StudentsProfileCounter%></td>
                            <td><%=StudentsProfile.QA_Number%></td>
                            <td><%=StudentsProfile.Academic_Year%></td>
                            <td><%=StudentsProfile.Government_Sponsored_Male%></td>
                            <td><%=StudentsProfile.Government_Sponsored_Female%></td>
                            <td><%=StudentsProfile.Kenyan_Students%></td>
                            <td><%=StudentsProfile.International_Students%></td>
                            <td>
                                <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                            <td>
                                <label class="btn btn-danger" onclick="deleteRationale('<%=StudentsProfile.QA_Number %>');"><i class="fa fa-trash"></i>Delete</label>
                            </td>

                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <div class="form-group">
                    <strong>Key strengths and weaknesses on Stakeholder Satisifactions</strong>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <div class="panel panel-primary">
                                <div id="satisfactionsstrengthsfeedback" runat="server"></div>
                                <div class="panel-heading">
                                    Key Strengths
                                </div>
                                <div class="panel-body">
                                    <div class="form-group">
                                        <strong>Strength:</strong>
                                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Strength" ID="satisfactionsstrengths" TextMode="MultiLine" />
                                    </div>
                                    <div class="form-group">
                                        <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Strength" OnClick="addStakeholdersSatisfactionsStrenght_Click" />
                                    </div>
                                    <table class="table table-bordered table-striped dataTable">
                                        <thead>
                                            <tr>
                                                <th>SN</th>
                                                <th>Strength</th>
                                                <th>Edit</th>
                                                <th>Delete</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                var satisfactionsstrengthsinfos = nav.SatisfactionsWeaknessStrengths.Where(r => r.QA_Number == QualityAuditNo && r.Category == "Key Strengths");
                                                int satisfactionsstrengthsCounter = 0;
                                                string satisfactionsstrengthsdetails = "";
                                                string University_Code = Convert.ToString(Session["UniversityCode"]);
                                                foreach (var satisfactionsstrengthsinfo in satisfactionsstrengthsinfos)
                                                {
                                                    satisfactionsstrengthsCounter++;
                                                    var satisfactionsstrengths = new Config().ObjNav().FngetStakeholdersSatisactionsStrength(QualityAuditNo, University_Code);
                                                    satisfactionsstrengthsdetails = Regex.Replace(satisfactionsstrengths, @"[^0-9a-zA-Z]+", " ");
                                            %>
                                            <tr>
                                                <td><%=satisfactionsstrengthsCounter%></td>
                                                <td><%=satisfactionsstrengths%></td>
                                                <td>
                                                    <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                                <td>
                                                    <label class="btn btn-danger" onclick="deletesatisfactionsstrengthsinfo('<%=satisfactionsstrengthsinfo.Code %>');"><i class="fa fa-trash"></i>Delete</label>
                                                </td>
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
                                <div id="satisfactionsweaknessfeedback" runat="server"></div>
                                <div class="panel-heading">
                                    Key Weaknesses
                                </div>
                                <div class="panel-body">
                                    <div class="form-group">
                                        <strong>Weakness:</strong>
                                        <asp:TextBox runat="server" CssClass="form-control" placeholder="Weakness" ID="satisfactionsweakness" TextMode="MultiLine" />
                                    </div>
                                    <div class="form-group">
                                        <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Weakness" OnClick="addStakholdersSatisfactionsWeaknesses_Click" />
                                    </div>
                                    <table class="table table-bordered table-striped dataTable">
                                        <thead>
                                            <tr>
                                                <th>SN</th>
                                                <th>Weakness</th>
                                                <th>Edit</th>
                                                <th>Delete</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                var satisfactionsweaknessesinfos = nav.SatisfactionsWeaknessStrengths.Where(r => r.QA_Number == QualityAuditNo);
                                                int satisfactionsweaknessescounter = 0;
                                                string satisfactionsweaknessdetails = "";
                                                foreach (var satisfactionsweaknessesinfo in satisfactionsweaknessesinfos)
                                                {
                                                    satisfactionsweaknessescounter++;
                                                    var satisfactionsweakness = new Config().ObjNav().FngetStakeholdersSatisfactionsWeakness(QualityAuditNo, University_Code);
                                                    satisfactionsweaknessdetails = Regex.Replace(satisfactionsweakness, @"[^0-9a-zA-Z]+", " ");
                                            %>
                                            <tr>
                                                <td><%=satisfactionsweaknessescounter%></td>
                                                <td><%=satisfactionsweakness%></td>
                                                <td>
                                                    <label class="btn btn-success"><i class="fa fa-pencil"></i>Edit</label></td>
                                                <td>
                                                    <label class="btn btn-danger" onclick="deletesatisfactionsweaknessesinfo('<%=satisfactionsweaknessesinfo.Code %>');"><i class="fa fa-trash"></i>Delete</label>
                                                </td>
                                            </tr>
                                            <% } %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
                <div class="clearfix"></div>
            </div>
        </div>
        <% } %>
        <script type="text/javascript">
            function editBasicInformations(qaNo, programme,domain, approval, proffesssionalbody, dateofapproval) {
                document.getElementById("MainContent_qualityauditnumber").value = qaNo;
                document.getElementById("MainContent_editNameofAcademicProgramme").value = programme;
                document.getElementById("MainContent_editprogrammedomain").value = domain;
                document.getElementById("MainContent_editrequireapprovals").value = approval;
                document.getElementById("MainContent_editprofessionalbosyname").value = proffesssionalbody;
                document.getElementById("MainContent_editdateprofessionalbodyapproval").value = dateofapproval;
                $("#editBasicInfrmationModal").modal();
            }
            function editStakeholderRequirements(No,QaNo,Stakeholdername,Astakeholder,Engaged,Analyzed) {
                document.getElementById("MainContent_editprimarynumber").value = No;
                document.getElementById("MainContent_editqualityauditnumber").value = QaNo;
                document.getElementById("MainContent_editstakeholder").value = Stakeholdername;
                document.getElementById("MainContent_editAstakeholder").value = Astakeholder;
                document.getElementById("MainContent_editengaged").value = Engaged;
                document.getElementById("MainContent_editanalyzedneeds").value = Analyzed;
                $("#editStakeholderRequirementsModal").modal();
            }
            function editOtherStakeholders(No, QaNumber, name, engaged, analyzed) {
                document.getElementById("MainContent_editotherprimarynumber").value = No;
                document.getElementById("MainContent_editotherQualityAuditNumber").value = QaNumber;
                document.getElementById("MainContent_editotherstakeholders").value = name;
                document.getElementById("MainContent_editotherstakeholderengaged").value = engaged;
                document.getElementById("MainContent_editotheranalyzednneds").value = analyzed;
                $("#editOtherStakeholderModal").modal();
            }
            function editstakeholdersstrengths(Number) {
                document.getElementById("MainContent_editstakeholderstrengthsNumber").value = Number;
                $("#editKeyStakeholdersStrengthsModal").modal();
            }
            function editGenericLearningOutcome() {
                $("#editGenericLearningOutcomeModal").modal();
            }
            function editProfessionalLearningOutcome() {
                $("#editProfessionalLearningOutcomeModal").modal();
            }
            function editUniversityMissionFits() {
                $("#editUniversityMissionModal").modal();
            }
            function editspecificneedsdemands() {
                $("#editspecificneedsdemandsModal").modal();
            }
            function editoutcomecommunications() {
                $("#editoutcomecommunicationsModal").modal();
            }
            function editstrengthsachievements() {
                $("#editstrengthsachievementsModal").modal();
            }
            function editweaknessachievements() {
                $("#editstrengthsachievementsModal").modal();
            }
            function editlearningaspects() {
                $("#editlearningaspectsModal").modal();
            }
            function editprogrammeobjectives() {
                $("#editprogrammeobjectivesModal").modal();
            }
            function editprogrammeorganizations() {
                $("#editprogrammeorganizationsModal").modal();
            }
            function editprogrammestructure() {
                $("#editprogrammestructureModal").modal();
            }
            function editprogrammecontacthours() {
                $("#editprogrammecontacthoursModal").modal();
            }
            function editprogrammeinstructionalhours() {
                $("#editprogrammeinstructionalhoursModal").modal();
            }
            function edituniversitycommunications() {
                $("#edituniversitycommunicationsModal").modal();
            }
            function editprogrammedescriptionsstrenths() {
                $("#editprogrammedescriptionsstrenthsModal").modal();
            }
            function editprogrammedescriptionsweakness() {
                $("#editprogrammedescriptionsweaknessModal").modal();
            }
            function editprogrammereviewdetails() {
                $("#editprogrammereviewdetailsModal").modal();
            }
            function editprogrammecontentstrengths() {
                $("#editprogrammecontentstrengthsModal").modal();
            }
            function editprogrammecontentweakness() {
                $("#editprogrammecontentweaknessModal").modal();
            }
            function editacademiccalenderdetails() {
                $("#editacademiccalenderdetailsModal").modal();
            }
            function editorganizationalprogrammestrengths() {
                $("#editorganizationalprogrammestrengthsModal").modal();
            }
            function editorganizationalprogrammeweakness() {
                $("#editorganizationalprogrammeweaknessModal").modal();
            }
            function editdidacticconcepts() {
                $("#editdidacticconceptsModal").modal();
            }
            function editdidacticconceptstrengths() {
                $("#editdidacticconceptstrengthsModal").modal();
            }
            function editdidacticconceptweakness() {
                $("#editdidacticconceptweaknessModal").modal();
            }
            function deletestakeholdersstrengths(id) {
                document.getElementById("MainContent_deletestakeholderstrengthcode").value = id;
                $("#deletestakeholderstrengthModal").modal();
            }
            function deletestakeholdersweakness(id) {
                document.getElementById("MainContent_deletestakeholderweaknesscode").value = id;
                $("#deletestakeholderweaknessModal").modal();
            }
            function deleteRequirementsStakeholders(code, stakeholderName) {
                document.getElementById("deletestakeholdername").innerText = stakeholderName;
                document.getElementById("MainContent_stakeholdercode").value = code;
                $("#deletestakeholdersModal").modal();
            }
            function deleteOtherStakeholders(code, name) {
                document.getElementById("deleteotherstakeholdername").innerText = name;
                document.getElementById("MainContent_deleteotherstakeholdercode").value = code;
                $("#deleteotherstakeholdersModal").modal();
            }
        </script>
        <script type="text/javascript">
            function deleteGenericLearningOutcome(code) {
                document.getElementById("MainContent_deletegenericCode").value = code;
                $("#deleteGenericLearningOutcomeModal").modal();
            }
            function deleteProfessionalDiscipline(code) {
                document.getElementById("MainContent_deleteprofessionalCode").value = code;
                $("#deletedeleteProfessionalDisciplineModal").modal();
            }
            function deleteUniversityMissionFits(code) {
                //  document.getElementById("MainContent_deleteRationaleCode").value = code;
                $("#deleteUniversityMissionFitsModal").modal();
            }
            function deletespecificneedsdemands(code) {
                document.getElementById("MainContent_deleteneedsrequirementsCode").value = code;
                $("#deletespecificneedsdemandsModal").modal();
            }
            function deleteoutcomecommunications(code) {
                document.getElementById("MainContent_deletecommunicationsCode").value = code;
                $("#deleteoutcomecommunicationsModal").modal();
            }
            function deletestrengthsachievements(code) {
                document.getElementById("MainContent_deleteOutcomeStrengthsCode").value = code;
                $("#deletestrengthsachievementsModal").modal();
            }
            function deleteweaknessachievements(code) {
                document.getElementById("MainContent_deleteOutcomeWeaknessCode").value = code;
                $("#deleteweaknessachievementsModal").modal();
            }
            function deletelearningaspects(code) {
                document.getElementById("MainContent_deletelearningaspectsCode").value = code;
                $("#deletelearningaspectsModal").modal();
            }
            function deleteprogrammeobjectives(code) {
                document.getElementById("MainContent_deleteprogrammeobjectivesCode").value = code;
                $("#deleteprogrammeobjectivesModal").modal();
            }
            function deleteprogrammeorganizations(code) {
                document.getElementById("MainContent_deleteprogrammeorganizationsCode").value = code;
                $("#deleteprogrammeorganizationsModal").modal();
            }
            function deleteprogrammestructure(code) {
                //  document.getElementById("MainContent_deleteRationaleCode").value = code;
                $("#deleteprogrammestructureModal").modal();
            }
            function deleteprogrammecontacthours(code) {
                document.getElementById("MainContent_deleteprogrammecontacthoursCode").value = code;
                $("#deleteprogrammecontacthoursModal").modal();
            }
            function deleteprogrammeinstructionalhours(code) {
                //  document.getElementById("MainContent_deleteRationaleCode").value = code;
                $("#deleteprogrammeinstructionalhoursModal").modal();
            }
            function deleteuniversitycommunications(code) {
                //  document.getElementById("MainContent_deleteRationaleCode").value = code;
                $("#deleteuniversitycommunicationsModal").modal();
            }
            function deleteprogrammedescriptionsstrenths(code) {
                document.getElementById("MainContent_deleteprogrammedescriptionsstrenthsCode").value = code;
                $("#deleteprogrammedescriptionsstrenthsModal").modal();
            }
            function deleteprogrammedescriptionsweakness(code) {
                document.getElementById("MainContent_deleteprogrammedescriptionsweaknessCode").value = code;
                $("#deleteprogrammedescriptionsweaknessModal").modal();
            }
            editprogrammecontentweakness
            function deleteprogrammereviewdetails(code) {
                //  document.getElementById("MainContent_deleteRationaleCode").value = code;
                $("#deleteprogrammereviewdetailsModal").modal();
            }
            function deleteprogrammecontentstrengths(code) {
                document.getElementById("MainContent_deleteprogrammecontentstrengthsCode").value = code;
                $("#deleteprogrammecontentstrengthsModal").modal();
            }
            function deleteprogrammecontentweakness(code) {
                document.getElementById("MainContent_deleteprogrammecontentweaknessCode").value = code;
                $("#deleteprogrammecontentweaknessModal").modal();
            } editorganizationalprogrammestrengths
            function deleteacademiccalenderdetails(code) {
                //  document.getElementById("MainContent_deleteRationaleCode").value = code;
                $("#deleteacademiccalenderdetailsModal").modal();
            }
            function deleteorganizationalprogrammestrengths(code) {
                document.getElementById("MainContent_deleteorganizationalprogrammestrengthsCode").value = code;
                $("#deleteorganizationalprogrammestrengthsModal").modal();
            }
            function deleteorganizationalprogrammeweakness(code) {
                document.getElementById("MainContent_deleteorganizationalprogrammeweaknessCode").value = code;
                $("#deleteorganizationalprogrammeweaknessModal").modal();
            }
            function deletedidacticconcepts(code) {
                //  document.getElementById("MainContent_deleteRationaleCode").value = code;
                $("#deletedidacticconceptsModal").modal();
            }
            function deletedidacticconceptstrengths(code) {
                document.getElementById("MainContent_deletedidacticconceptstrengthsCode").value = code;
                $("#deletedidacticconceptstrengthsModal").modal();
            }
            function deletedidacticconceptweakness(code) {
                document.getElementById("MainContent_deletedidacticconceptweaknessCode").value = code;
                $("#deletedidacticconceptweaknessModal").modal();
            }
            function deleteprogramdidacticstrenths(code) {
                document.getElementById("MainContent_deleteprogramdidacticstrenthsCode").value = code;
                $("#deleteprogramdidacticstrenthsModal").modal();
            }
            function deletedidacticweaknesses(code) {
                document.getElementById("MainContent_deletedidacticweaknessesCode").value = code;
                $("#deletedidacticweaknessesModal").modal();
            }
            function deletestudentsassments(code) {
                document.getElementById("MainContent_deletestudentsassmentsCode").value = code;
                $("#deletestudentsassmentsModal").modal();
            }
            function deleteAntiPlagiarismDetails(code) {
                document.getElementById("MainContent_deleteAntiPlagiarismDetailsCode").value = code;
                $("#deleteAntiPlagiarismDetailsModal").modal();
            }
            function deletestudentsassesmentstrengths(code) {
                document.getElementById("MainContent_deletestudentsassesmentstrengthsCode").value = code;
                $("#deletestudentsassesmentstrengthsModal").modal();
            }
            function deletestudentsassesweaknesses(code) {
                document.getElementById("MainContent_deletestudentsassesweaknessesCode").value = code;
                $("#deletestudentsassesweaknessesModal").modal();
            }
            function deleteProgrammeLeader(code) {
                document.getElementById("MainContent_deleteProgrammeLeaderCode").value = code;
                $("#deleteProgrammeLeaderModal").modal();
            }
            function deletequalitystaffstrength(code) {
                document.getElementById("MainContent_deletequalitystaffstrengthCode").value = code;
                $("#deletequalitystaffstrengthModal").modal();
            }
            function deletequalitystaffweakness(code) {
                document.getElementById("MainContent_deletequalitystaffweaknessCode").value = code;
                $("#deletequalitystaffweaknessModal").modal();
            }
            function deleteNonTeachingStaff(code) {
                document.getElementById("MainContent_deleteNonTeachingStaffCode").value = code;
                $("#deleteNonTeachingStaffModal").modal();
            }
            function deletequalitysupportstaffstrengths(code) {
                document.getElementById("MainContent_deletequalitysupportstaffstrengthsCode").value = code;
                $("#deletequalitysupportstaffModal").modal();
            }
            function deletequalitysupportstaffweakness(code) {
                document.getElementById("MainContent_deletequalitysupportstaffweaknessCode").value = code;
                $("#deletequalitysupportstaffweaknessModal").modal();
            }
            function deleteStudentsProfile(code) {
                document.getElementById("MainContent_deleteStudentsProfileCode").value = code;
                $("#deleteStudentsProfileModal").modal();
            }
            function deleteStudentsprofilestrengths(code) {
                document.getElementById("MainContent_deleteStudentsprofilestrengthsCode").value = code;
                $("#deleteStudentsprofilestrengthsModal").modal();
            }
            function deleteStudentsprofileweakness(code) {
                document.getElementById("MainContent_deleteStudentsprofileweaknessCode").value = code;
                $("#deleteStudentsprofileweaknessModal").modal();
            }
            function deletestudentssupportsdetail(code) {
                document.getElementById("MainContent_deletestudentssupportsdetailCode").value = code;
                $("#deletestudentssupportsdetailModal").modal();
            }
            function deletestudentsupportstrenght(code) {
                document.getElementById("MainContent_deletestudentsupportstrenghtCode").value = code;
                $("#deletestudentsupportstrenghtModal").modal();
            }
            function deletestudentssupportweaknes(code) {
                document.getElementById("MainContent_deletestudentssupportweaknesCode").value = code;
                $("#deletestudentssupportweaknesModal").modal();
            }
            function deleteteachingsmaterial(code) {
                document.getElementById("MainContent_deleteteachingsmaterialCode").value = code;
                $("#deleteteachingsmaterialModal").modal();
            }
            function deletefacilitiesstrengths(code) {
                document.getElementById("MainContent_deletefacilitiesstrengthsCode").value = code;
                $("#deletefacilitiesstrengthsModal").modal();
            } 
            function deletefacilitiesweaknesses(code) {
                document.getElementById("MainContent_deletefacilitiesweaknessesCode").value = code;
                $("#deletefacilitiesweaknessesModal").modal();
            }
            function deleteStudentsEvaluations(code) {
                document.getElementById("MainContent_deleteStudentsEvaluationsCode").value = code;
                $("#deleteStudentsEvaluationsModal").modal();
            } 
            function deletestudentsevaluationsstrength(code) {
                document.getElementById("MainContent_deletestudentsevaluationsstrengthCode").value = code;
                $("#deletestudentsevaluationsstrengthModal").modal();
            } 
            function deletestudentsevaluationsweaknesses(code) {
                document.getElementById("MainContent_deletestudentsevaluationsweaknessesCode").value = code;
                $("#deletestudentsevaluationsweaknessesModal").modal();
            } 
            function deleteCurriculumDesign(code) {
                document.getElementById("MainContent_deleteCurriculumDesignCode").value = code;
                $("#deleteCurriculumDesignModal").modal();
            } 
            function deletecurriculumndesignstrengthsinfo(code) {
                document.getElementById("MainContent_deletecurriculumndesignstrengthsinfoCode").value = code;
                $("#deletecurriculumndesignstrengthsinfoModal").modal();
            } 
            function deletecurriculumndesignweaknessinfo(code) {
                document.getElementById("MainContent_deletecurriculumndesignweaknessinfoCode").value = code;
                $("#deletecurriculumndesignweaknessinfoModal").modal();
            } 
            function deletestudentsdevelopmentstrengthinfo(code) {
                document.getElementById("MainContent_deletestudentsdevelopmentstrengthinfoCode").value = code;
                $("#deletestudentsdevelopmentstrengthinfoModal").modal();
            } 
            function deletestudentsdevelopmentweaknessinfo(code) {
                document.getElementById("MainContent_deletestudentsdevelopmentweaknessinfoCode").value = code;
                $("#deletestudentsdevelopmentweaknessinfoModal").modal();
            } 
            function deleteBenchmarkingstrenghtsinfo(code) {
                document.getElementById("MainContent_deleteBenchmarkingstrenghtsinfoCode").value = code;
                $("#deleteBenchmarkingstrenghtsinfoModal").modal();
            } 
            function deleteBenchmarkingweaknessinfo(code) {
                document.getElementById("MainContent_deleteBenchmarkingweaknessinfoCode").value = code;
                $("#deleteBenchmarkingweaknessinfoModal").modal();
            } 
            function deletegraduatestrenghtsinfo(code) {
                document.getElementById("MainContent_deletegraduatestrenghtsinfoCode").value = code;
                $("#deletegraduatestrenghtsinfoModal").modal();
            } 
            function deletegraduateweaknesssinfo(code) {
                document.getElementById("MainContent_deletegraduateweaknesssinfoCode").value = code;
                $("#deletegraduateweaknesssinfoModal").modal();
            } 
            function deletesatisfactionsstrengthsinfo(code) {
                document.getElementById("MainContent_deletesatisfactionsstrengthsinfoCode").value = code;
                $("#deletesatisfactionsstrengthsinfoModal").modal();
            }
            function deletesatisfactionsweaknessesinfo(code) {
                document.getElementById("MainContent_deletesatisfactionsweaknessesinfoCode").value = code;
                $("#deletesatisfactionsweaknessesinfoModal").modal();
            }
        </script>
        <script>
            $(document).ready(function () {
                $('.dataTable').DataTable({
                    responsive: true
                });
            });
        </script>
        <script type="text/javascript">
            $(document).ready(function () {
                $('#dataTables-example0').DataTable({
                    responsive: true
                });
            });
            $(document).ready(function () {
                $('#dataTables-example').DataTable({
                    responsive: true
                });
            });
        </script>
        <script type="text/javascript">
            $(document).ready(function () {
                $('#dataTables-example1').DataTable({
                    responsive: true
                });
            });
        </script>
        <script type="text/javascript">
            $(document).ready(function () {
                $('#dataTables-example2').DataTable({
                    responsive: true
                });
            });
        </script>
 <div id="deletesatisfactionsweaknessesinfoModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting the Stakeholders Satisfaction Weakness</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Stakeholders Satisfactions Weakness?</p>
                        <asp:TextBox runat="server" ID="deletesatisfactionsweaknessesinfoCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete  Weakness" ID="Button41" OnClick="deletesatisfactionsweaknessesinfo_Click" />
                    </div>
                </div>
            </div>
        </div>
 <div id="deletesatisfactionsstrengthsinfoModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting the Stakeholders Satisfaction Strengths</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Stakeholders Satisfactions Strengths?</p>
                        <asp:TextBox runat="server" ID="deletesatisfactionsstrengthsinfoCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete  Strengths" ID="deletesatisfactionsstrengthsinfo" OnClick="deletesatisfactionsstrengthsinfo_Click" />
                    </div>
                </div>
            </div>
        </div>
 <div id="deletegraduateweaknesssinfoModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting the Graduates Weakness</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the  Graduates Weakness?</p>
                        <asp:TextBox runat="server" ID="deletegraduateweaknesssinfoCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete  Weakness" ID="deletegraduateweaknesssinfo" OnClick="deletegraduateweaknesssinfo_Click" />
                    </div>
                </div>
            </div>
        </div>
 <div id="deletegraduatestrenghtsinfoModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting the Graduates Strengths</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the  Graduates Strengths?</p>
                        <asp:TextBox runat="server" ID="deletegraduatestrenghtsinfoCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete  Strengths" ID="deletegraduatestrenghtsinfo" OnClick="deletegraduatestrenghtsinfo_Click" />
                    </div>
                </div>
            </div>
        </div>
   <div id="deleteBenchmarkingweaknessinfoModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Benchmarking Weakness</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the  Benchmarking Weakness ?</p>
                        <asp:TextBox runat="server" ID="deleteBenchmarkingweaknessinfoCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete  Weakness" ID="Button36" OnClick="deleteBenchmarkingweaknessinfo_Click" />
                    </div>
                </div>
            </div>
        </div>
   <div id="deleteBenchmarkingstrenghtsinfoModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Benchmarking Strengths</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the  Benchmarking Strengths ?</p>
                        <asp:TextBox runat="server" ID="deleteBenchmarkingstrenghtsinfoCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete  Strengths" ID="Button35" OnClick="deleteBenchmarkingstrenghtsinfo_Click" />
                    </div>
                </div>
            </div>
        </div>
       <div id="deletestudentsdevelopmentweaknessinfoModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting  Staff Development Activities Weakness</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the  Staff Development Activities Weakness?</p>
                        <asp:TextBox runat="server" ID="deletestudentsdevelopmentweaknessinfoCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete  Strengths" ID="deletestudentsdevelopmentweaknessinfo" OnClick="deletestudentsdevelopmentweaknessinfo_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deletestudentsdevelopmentstrengthinfoModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting  Staff Development Activities Weakness</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the  Staff Development Activities Weakness?</p>
                        <asp:TextBox runat="server" ID="deletestudentsdevelopmentstrengthinfoCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete  Strengths" ID="deletestudentsdevelopmentstrengthinfo" OnClick="deletestudentsdevelopmentstrengthinfo_Click" />
                    </div>
                </div>
            </div>
        </div>
            <div id="deletecurriculumndesignweaknessinfoModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Curriculum Design Weakness</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Curriculum Design Weakness?</p>
                        <asp:TextBox runat="server" ID="deletecurriculumndesignweaknessinfoCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete  Weakness" ID="deletecurriculumndesignweaknessinfo" OnClick="deletecurriculumndesignweaknessinfo_Click" />
                    </div>
                </div>
            </div>
        </div>
         <div id="deletecurriculumndesignstrengthsinfoModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Curriculum Design Strengths</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Curriculum Design Strengths?</p>
                        <asp:TextBox runat="server" ID="deletecurriculumndesignstrengthsinfoCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete  Strengths" ID="deletecurriculumndesignstrengthsinfo" OnClick="deletecurriculumndesignstrengthsinfo_Click" />
                    </div>
                </div>
            </div>
        </div>
       <div id="deleteCurriculumDesignModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Students Evaluations Weakness</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Students Evaluations Weakness?</p>
                        <asp:TextBox runat="server" ID="deleteCurriculumDesignCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete  Strengths" ID="deleteCurriculumDesign" OnClick="deletestudentsevaluationsweaknesses_Click" />
                    </div>
                </div>
            </div>
        </div>
       <div id="deletestudentsevaluationsweaknessesModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Students Evaluations Weakness</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Students Evaluations Weakness?</p>
                        <asp:TextBox runat="server" ID="deletestudentsevaluationsweaknessesCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete  Strengths" ID="Button30" OnClick="deletestudentsevaluationsweaknesses_Click" />
                    </div>
                </div>
            </div>
        </div>
       <div id="deletestudentsevaluationsstrengthModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Students Evaluations Strengths</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Students Evaluations Strengths?</p>
                        <asp:TextBox runat="server" ID="deletestudentsevaluationsstrengthCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete  Strengths" ID="Button29" OnClick="deletestudentsevaluationsstrength_Click" />
                    </div>
                </div>
            </div>
        </div>
     <div id="deleteStudentsEvaluationsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Students Evaluations</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Students Evaluations?</p>
                        <asp:TextBox runat="server" ID="deleteStudentsEvaluationsCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Students Evaluations" ID="Button23" OnClick="deletestudentsevaluations_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deletefacilitiesweaknessesModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Facilities Weakness</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Facilities Weakness?</p>
                        <asp:TextBox runat="server" ID="deletefacilitiesweaknessesCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Facilities Strengths" ID="Button19" OnClick="deletefacilitiesweaknesses_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deletefacilitiesstrengthsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Facilities Strengths</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Facilities Strengths?</p>
                        <asp:TextBox runat="server" ID="deletefacilitiesstrengthsCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Facilities Strengths" ID="Button17" OnClick="deletefacilitiesstrengths_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deleteteachingsmaterialModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Teaching Material</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Teaching Materials?</p>
                        <asp:TextBox runat="server" ID="deleteteachingsmaterialCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Teaching Materials" ID="Button16" OnClick="deleteteachingsmaterial_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deletestudentssupportweaknesModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Student Support Weakness</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Student Support Weakness?</p>
                        <asp:TextBox runat="server" ID="deletestudentssupportweaknesCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Student Support Weakness" ID="Button14" OnClick="deletestudentssupportweaknes_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deletestudentsupportstrenghtModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Student Support Strengths</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Student Support Strengths?</p>
                        <asp:TextBox runat="server" ID="deletestudentsupportstrenghtCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Student Support Strengths" ID="Button11" OnClick="deletestudentsupportstrenght_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deletestudentssupportsdetailModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Student Support Details</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Student Support Details?</p>
                        <asp:TextBox runat="server" ID="deletestudentssupportsdetailCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Student Support" ID="deletestudentssupportsdetail" OnClick="deletestudentssupportsdetail_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deleteStudentsprofileweaknessModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Student Profile Weakness</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Student Profile Weakness?</p>
                        <asp:TextBox runat="server" ID="deleteStudentsprofileweaknessCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Student Profile" ID="deleteStudentsprofileweakness" OnClick="deleteStudentsprofileweakness_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deleteStudentsprofilestrengthsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Student Profile Strengths</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Student Profile Strengths?</p>
                        <asp:TextBox runat="server" ID="deleteStudentsprofilestrengthsCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Student Profile" ID="deleteStudentsprofilestrengths" OnClick="deleteStudentsprofilestrengths_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deleteStudentsProfileModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Student Profile</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Student Profile?</p>
                        <asp:TextBox runat="server" ID="deleteStudentsProfileCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Student Profile" ID="deleteStudentsProfile" OnClick="deleteStudentProfile_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deletequalitysupportstaffweaknessModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Teaching Staff Weakness</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Teaching Staff Weakness?</p>
                        <asp:TextBox runat="server" ID="deletequalitysupportstaffweaknessCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Strengths" ID="Button9" OnClick="deleteQualitySupportstaffWeakness_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deletequalitysupportstaffModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Teaching Staff Strengths</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Teaching Staff Strengths?</p>
                        <asp:TextBox runat="server" ID="deletequalitysupportstaffstrengthsCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Strengths" ID="deletequalitysupportstaffstrengths" OnClick="deleteQualitySupportStaffstrengths_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deleteNonTeachingStaffModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Teaching Staff</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Teaching Staff?</p>
                        <asp:TextBox runat="server" ID="deleteNonTeachingStaffCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Staff" ID="deleteteachingstaff" OnClick="deleteNonTeachingStaff_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deletequalitystaffstrengthModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Quality Staff Strength </h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Quality Staff Strength ?</p>
                        <asp:TextBox runat="server" ID="deletequalitystaffstrengthCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Strength" ID="deletequalitystaffstrength" OnClick="deletequalitystaffstrength_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deletequalitystaffweaknessModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Quality Staff Weakness </h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Weakness ?</p>
                        <asp:TextBox runat="server" ID="deletequalitystaffweaknessCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Weakness" ID="deletequalitystaffweakness" OnClick="deletequalitystaffweakness_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deleteProgrammeLeaderModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Academic Leader</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Academic Leader ?</p>
                        <asp:TextBox runat="server" ID="deleteProgrammeLeaderCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Weakness" ID="deleteProgrammeLeader" OnClick="deleteProgrammeLeader_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deletestudentsassesweaknessesModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Weakness</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Students Assesment Weakness ?</p>
                        <asp:TextBox runat="server" ID="deletestudentsassesweaknessesCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Weakness" ID="deletestudentsassesweaknesses" OnClick="deletestudentsassesweaknesses_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deletestudentsassesmentstrengthsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Strengths</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Students Assesment Strengths ?</p>
                        <asp:TextBox runat="server" ID="deletestudentsassesmentstrengthsCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Strengths" ID="deletestudentsassesmentstrengths" OnClick="deletestudentsassesmentstrengths_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deleteAntiPlagiarismDetailsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Anti-Plagiarism Details</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Anti-Plagiarism Details ?</p>
                        <asp:TextBox runat="server" ID="deleteAntiPlagiarismDetailsCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Anti-Plagiarism Details" ID="deleteAntiPlagiarismDetails" OnClick="deleteAntiPlagiarismDetails_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deletestudentsassmentsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Students Assesments</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Students Assesments ?</p>
                        <asp:TextBox runat="server" ID="deletestudentsassmentsCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Student Assessment" ID="Button8" OnClick="deletestudentsassments_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deletedidacticweaknessesModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Weakness</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Didactic Weakness ?</p>
                        <asp:TextBox runat="server" ID="deletedidacticweaknessesCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Weaknesss" ID="deletedidacticweakness" OnClick="deletedidacticweaknessesCode_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deleteprogramdidacticstrenthsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Strengths</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Didactic Strengths ?</p>
                        <asp:TextBox runat="server" ID="deleteprogramdidacticstrenthsCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Strengths" ID="Button4" OnClick="deleteprogramdidacticstrenths_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deletestakeholdersModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting StakeHolders</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Stakeholder Details <strong id="deletestakeholdername"></strong>?</p>
                        <asp:TextBox runat="server" ID="stakeholdercode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Stakeholder" ID="stakeholdersdetails" OnClick="deletestakeholders_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deletestakeholderstrengthModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting StakeHolders Strength</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Stakeholder Strength ?</p>
                        <asp:TextBox runat="server" ID="deletestakeholderstrengthcode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Stakeholder Strength" ID="stakeholderssterngths" OnClick="deletestakeholderStrength_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deletestakeholderweaknessModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting StakeHolders Weakness</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Stakeholder Weakness ?</p>
                        <asp:TextBox runat="server" ID="deletestakeholderweaknesscode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Stakeholder Weakness" ID="deletestakeholderweakness" OnClick="deletestakeholderWeakness_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deleteotherstakeholdersModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting StakeHolders</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Stakeholder Details <strong id="deleteotherstakeholdername"></strong>?</p>
                        <asp:TextBox runat="server" ID="deleteotherstakeholdercode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Stakeholder" ID="otherstakeholders" OnClick="deleteotherstakeholders_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deletedidacticconceptstrengthsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Didactic Concepts Strengths</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Programme Didactic Concepts Strengths?</p>
                        <asp:TextBox runat="server" ID="deletedidacticconceptstrengthsCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Strengths" ID="deletedidacticconceptstrengths" OnClick="deletedidacticconceptstrengths_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deletedidacticconceptweaknessModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Didactic Concepts Weakness</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Programme Didactic Concepts Weakness?</p>
                        <asp:TextBox runat="server" ID="deletedidacticconceptweaknessCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Weakness" ID="deletedidacticconceptweakness" OnClick="deletedidacticconceptweakness_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deleteorganizationalprogrammestrengthsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Programme Organizations Strengths</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Programme Organizations Strengths?</p>
                        <asp:TextBox runat="server" ID="deleteorganizationalprogrammestrengthsCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Strengths" ID="eleteorganizationalprogrammestrengths" OnClick="deleteorganizationalprogrammestrengths_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deletedidacticconceptsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Didactic Concept and Teaching/Learning Strategy</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Didactic Concept and Teaching/Learning Strategy?</p>
                        <asp:TextBox runat="server" ID="TextBox96" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Didactic Concept" ID="Button45" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deleteorganizationalprogrammeweaknessModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Programme Organizations Weakness</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Programme Organizations Weakness?</p>
                        <asp:TextBox runat="server" ID="deleteorganizationalprogrammeweaknessCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Weakness" ID="deleteorganizationalprogrammeweakness" OnClick="deleteorganizationalprogrammeweakness_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deleteacademiccalenderdetailsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Programme Content Strengths</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Programme Content Strengths?</p>
                        <asp:TextBox runat="server" ID="TextBox89" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Strengths" ID="Button40" />
                    </div>
                </div>
            </div>
        </div>

        <div id="deleteprogrammecontentstrengthsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Programme Content Strengths</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Programme Content Strengths?</p>
                        <asp:TextBox runat="server" ID="deleteprogrammecontentstrengthsCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Strengths" ID="deleteprogrammecontentstrengths" OnClick="deleteprogrammecontentstrengths_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deleteprogrammecontentweaknessModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Programme Content Weakness</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Programme Content Weakness?</p>
                        <asp:TextBox runat="server" ID="deleteprogrammecontentweaknessCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Weakness" ID="deleteprogrammecontentweaknes" OnClick="deleteprogrammecontentweakness_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deleteprogrammedescriptionsstrenthsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Programme Descrptions Strengths</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Programme Descriptions Strengths?</p>
                        <asp:TextBox runat="server" ID="deleteprogrammedescriptionsstrenthsCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Strengths" ID="deleteprogrammedescriptionsstrenths" OnClick="deleteprogrammedescriptionsstrenths_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deleteprogrammereviewdetailsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Programme Review Details</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Programme Content?</p>
                        <asp:TextBox runat="server" ID="TextBox80" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Content" ID="Button33" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deleteprogrammedescriptionsweaknessModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Programme Descrptions Weakness</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Programme Descriptions Weakness?</p>
                        <asp:TextBox runat="server" ID="deleteprogrammedescriptionsweaknessCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Weakness" ID="deleteprogrammedescriptionsweaknese" OnClick="deleteprogrammedescriptionsweakness_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deleteuniversitycommunicationsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Programme University Communications</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Programme Communications?</p>
                        <asp:TextBox runat="server" ID="TextBox73" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Communications" ID="Button27" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deleteprogrammeinstructionalhoursModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Programme Instructional Hours</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Programme Instructional Hours?</p>
                        <asp:TextBox runat="server" ID="TextBox70" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Instructional Hours" ID="Button25" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deleteprogrammecontacthoursModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Programme Contact Hours</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Programme Contacts Hours?</p>
                        <asp:TextBox runat="server" ID="deleteprogrammecontacthoursCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Contacts Hours" ID="deleteprogrammecontacthours" OnClick="deleteprogrammecontacthours_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deleteprogrammestructureModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Programme Stucture</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Programme Stucture?</p>
                        <asp:TextBox runat="server" ID="TextBox59" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Programme Stucture" ID="Button21" />
                    </div>
                </div>
            </div>
        </div>
        <div id="deleteprogrammeorganizationsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Programme Organization</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Programme Organization?</p>
                        <asp:TextBox runat="server" ID="deleteprogrammeorganizationsCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Programme Organization" ID="deletecoursedistribution" OnClick="deleteCourseDistributions_Click" />
                    </div>
                </div>

            </div>
        </div>
        <div id="deleteprogrammeobjectivesModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Programme Objectives</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Programme Objectives?</p>
                        <asp:TextBox runat="server" ID="deleteprogrammeobjectivesCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Programme Objectives" ID="deleteprogrammeobjectives" OnClick="deleteprogrammeobjectives_Click" />
                    </div>
                </div>

            </div>
        </div>
        <div id="deletelearningaspectsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Learning Aspects</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Learning Aspects?</p>
                        <asp:TextBox runat="server" ID="deletelearningaspectsCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Learning Aspects Details" ID="deletelearningaspects" OnClick="deletelearningaspects_Click" />
                    </div>
                </div>

            </div>
        </div>
        <div id="deletestrengthsachievementsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Key Strengths  on achievements of Expected Learning Outcomes</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Strengths  on achievements of Expected Learning Outcomes?</p>
                        <asp:TextBox runat="server" ID="deleteOutcomeStrengthsCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Achievements Strengths Details" ID="deleteOutcomeStrengths" OnClick="deleteoutcomestrengths_Click" />
                    </div>
                </div>

            </div>
        </div>
        <div id="deleteweaknessachievementsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Key Weakness  on achievements of Expected Learning Outcomes</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Weaknesss  on achievements of Expected Learning Outcomes?</p>
                        <asp:TextBox runat="server" ID="deleteOutcomeWeaknessCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Achievements Weakness Details" ID="deleteachievementsOutcomeWeakness" OnClick="deleteExpectedOutcomeWeakness_Click" />
                    </div>
                </div>

            </div>
        </div>
        <div id="deleteoutcomecommunicationsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Expected Learning Outcomes Communication to staff, students, and external examiners</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the  Communication Details?</p>
                        <asp:TextBox runat="server" ID="deletecommunicationsCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Communication Details" ID="deletecommunications" OnClick="deleteCommunications_Click" />
                    </div>
                </div>

            </div>
        </div>
        <div id="deletespecificneedsdemandsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Specific Needs, Demands</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the  Specific Needs, Demands?</p>
                        <asp:TextBox runat="server" ID="deleteneedsrequirementsCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Specific Needs, Demands" ID="deleteneedsrequirements" OnClick="deleteneedsRequirements_Click" />
                    </div>
                </div>

            </div>
        </div>
        <div id="deleteUniversityMissionFitsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting  Expected Learning Outcomes on the University mission</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the  Expected Learning Outcomes on the University mission?</p>
                        <asp:TextBox runat="server" ID="TextBox20" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Expected Learning Outcomes" ID="Button6" />
                    </div>
                </div>

            </div>
        </div>
        <div id="deleteGenericLearningOutcomeModal" class="modal fade" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Generic Expected Learning Outcomes</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Generic Expected Learning Outcomes?</p>
                        <asp:TextBox runat="server" ID="deletegenericCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Generic Expected Learning Outcomes" ID="deleteGenericOutcome" OnClick="deleteGenericOutcome_Click" />
                    </div>
                </div>

            </div>
        </div>
        <div id="deletedeleteProfessionalDisciplineModal" class="modal fade" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Confirm Deleting Professional/Discipline Specific Expected Learning Outcomes</h4>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete the Professional/Discipline Specific Expected Learning Outcomes?</p>
                        <asp:TextBox runat="server" ID="deleteprofessionalCode" type="hidden" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Professional/Discipline  Outcomes" ID="deleteprofessionaloutcome" OnClick="deleteProfessionalOutcome_Click" />
                    </div>
                </div>

            </div>
        </div>
        <div id="editBasicInfrmationModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Update Basic Informations </h4>
                    </div>
                    <div id="EditFeedback1" runat="server"></div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="qualityauditnumber" type="hidden" />
                        <div class="form-group">
                            <strong>a) Name of Academic Programme</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="editNameofAcademicProgramme" placeholder="Name of Academic Programme" />
                        </div>
                        <div class="form-group">
                            <strong>b) Academic Programme Domain:</strong>
                            <asp:DropDownList runat="server" ID="editprogrammedomain" CssClass="form-control"></asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <strong>c) Give a brief description of the niche of the university:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="edituniversityniche" placeholder="Give a brief description of the niche of the university" TextMode="MultiLine" />
                        </div>
                        <div class="form-group">
                            <strong>d) Does the Academic Programme require approval by a relevant professional body? (Tick if Yes):</strong>
                            <asp:CheckBox runat="server" ID="editrequireapprovals" CssClass="form-control" />
                        </div>
                        <div class="form-group">
                            <strong>e) if yes in d(i) Kindly attach evidence:</strong>
                            <asp:FileUpload runat="server" />
                        </div>
                        <div class="form-group">
                            <strong>f) Is the Academic Programme approved by a professional body? (Tick if Yes):</strong>
                             <asp:CheckBox runat="server" ID="editapprovedbyprofessionalbody" CssClass="form-control" />
                        </div>
                        <div class="form-group">
                            <strong>g) if yes in d(iii) Kindly attach Evidence:</strong>
                            <asp:FileUpload runat="server" />
                        </div>
                        <div class="form-group">
                            <strong>d) Indicate the name of the Professional body:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="editprofessionalbosyname" placeholder="Professional body" TextMode="MultiLine" />
                        </div>
                        <div class="form-group">
                            <strong>h)  Date of approval by the relevant professional body:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="editdateprofessionalbodyapproval" placeholder="Date of Approval" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Update Basic Informations" OnClick="UpdateBasicInformations_Click" />
                    </div>
                </div>
            </div>
        </div>

        <div id="editStakeholderRequirementsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Update Requirements of Stakeholders </h4>
                    </div>
                    <div class="panel-body">
                      <div class="modal-body">
                        <asp:TextBox runat="server" ID="editprimarynumber" type="hidden" />
                        <div class="form-group">
                            <strong>Quality Audit Number:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="editqualityauditnumber" placeholder="Stakeholder" TextMode="MultiLine" />
                        </div>
                    </div>
                     <div class="modal-body">
                       
                        <div class="form-group">
                            <strong>Stakeholder:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="editstakeholder" placeholder="Stakeholder" TextMode="MultiLine" />
                        </div>
                    </div>
                     <div class="modal-body">
                        <div class="form-group">
                            <strong>A Stakeholder?(Check if yes):</strong>
                            <asp:CheckBox runat="server" CssClass="form-control" ID="editAstakeholder"/>
                        </div>
                    </div>
                     <div class="modal-body">
                        <div class="form-group">
                            <strong>Engaged in the last five years?(Check if yes):</strong>
                            <asp:CheckBox runat="server" CssClass="form-control" ID="editengaged"/>
                        </div>
                    </div>
                     <div class="modal-body">
                        <div class="form-group">
                            <strong>Has the University analyzed the needs and requirements of the stakeholder in the last five years?(Check if yes):</strong>
                            <asp:CheckBox runat="server" CssClass="form-control" ID="editanalyzedneeds" />
                        </div>
                    </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                            <asp:Button runat="server" CssClass="btn btn-success" Text="Update Stakeholder Requirements" ID="Button1" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="editOtherStakeholderModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Update Requirements of Stakeholders </h4>
                    </div>
                    <div class="panel-body">
                       <div class="modal-body">
                        <asp:TextBox runat="server" ID="editotherprimarynumber" type="hidden" />
                        <div class="form-group">
                            <strong>Quality Audit Number:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="editotherQualityAuditNumber" placeholder="Quality Audit Number" TextMode="MultiLine" />
                        </div>
                     <div class="modal-body">
                        <div class="form-group">
                            <strong>Stakeholder:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="editotherstakeholders" placeholder="Stakeholder" TextMode="MultiLine" />
                        </div>
                    </div>
                      <div class="modal-body">
                        <div class="form-group">
                            <strong>Engaged in the last five years?(Check if yes):</strong>
                            <asp:CheckBox runat="server" CssClass="form-control" ID="editotherstakeholderengaged"/>
                        </div>
                    </div>
                 <div class="modal-body">
                        <div class="form-group">
                            <strong>Has the University analyzed the needs and requirements of the stakeholder in the last five years?(Check if yes):</strong>
                            <asp:CheckBox runat="server" CssClass="form-control" ID="editotheranalyzednneds"/>
                        </div>
                    </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Update Stakeholder" OnClick="AddOtherStakeholder_Click" /></td>
                        </div>
                      </div>
                    </div>
                   </div>
                </div>
            </div>
        </div>
        <div id="editstrengthsachievementsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Key Stakeholders’ Achievements Strengths</h4>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="editRationaleCode" type="hidden" />
                        <div class="form-group">
                            <strong>Key Strengths:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="TextBox10" placeholder="Key Stakeholders’ Achievements Strengths" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Update Key Strengths" ID="editProgramRationale" />
                    </div>
                </div>

            </div>
        </div>
        <div id="editweaknesssachievementsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Key Stakeholders’ Achievements Weakness</h4>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="TextBox40" type="hidden" />
                        <div class="form-group">
                            <strong>Key Strengths:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="TextBox41" placeholder="Key Stakeholders’ Achievements Weakness" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Update Key Weakness" ID="Button13" />
                    </div>
                </div>

            </div>
        </div>
        <div id="editGenericLearningOutcomeModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Generic Expected Learning Outcomes</h4>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="TextBox11" type="hidden" />
                        <div class="form-group">
                            <strong>Generic Expected Learning Outcomes:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="TextBox12" placeholder="Generic Expected Learning Outcomes" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Update Generic Expected Learning Outcomes" ID="Button2" />
                    </div>
                </div>

            </div>
        </div>
        <div id="editProfessionalLearningOutcomeModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Professional/Discipline Specific Expected Learning Outcomes</h4>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="TextBox13" type="hidden" />
                        <div class="form-group">
                            <strong>Professional/Discipline Specific Expected Learning Outcomes:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="TextBox14" placeholder="Generic Expected Learning Outcomes" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Update Professional/Discipline OutComes" ID="Button3" />
                    </div>
                </div>

            </div>
        </div>
        <div id="editUniversityMissionModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Expected Learning Outcomes On the University mission</h4>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="TextBox16" type="hidden" />
                        <div class="form-group">
                            <strong>How do the Expected Learning Outcomes fit into the University mission:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="TextBox17" placeholder="Generic Expected Learning Outcomes" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="TextBox18" type="hidden" />
                        <div class="form-group">
                            <strong>Do the Expected Learning Outcomes reflect the requirements of the stakeholders of the Academic programme? (Tick if yes):</strong>
                            <asp:CheckBox runat="server" CssClass="form-control" ID="TextBox19" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Update Expected Learning Outcome Details" ID="Button5" />
                    </div>
                </div>

            </div>
        </div>
        <div id="editspecificneedsdemandsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Specific Needs, Demands or Requirements</h4>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="TextBox21" type="hidden" />
                        <div class="form-group">
                            <strong>Stakeholder:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="TextBox22" placeholder="Stakeholder" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="TextBox24" type="hidden" />
                        <div class="form-group">
                            <strong>Needs, demands, or requirements:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="TextBox25" placeholder="Needs, demands, or requirements" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="TextBox26" type="hidden" />
                        <div class="form-group">
                            <strong>How stakeholder requirements are addressed in the Expected Learning Outcomes:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="TextBox27" placeholder="Expected Learning Outcomes" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Update Specific Needs, Demands  Details" ID="Button7" />
                    </div>
                </div>

            </div>
        </div>
        <div id="editoutcomecommunicationsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Specific Needs, Demands or Requirements</h4>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="TextBox29" type="hidden" />
                        <div class="form-group">
                            <strong>Memos:</strong>
                            <asp:CheckBox runat="server" CssClass="form-control" ID="TextBox30" />
                        </div>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="TextBox31" type="hidden" />
                        <div class="form-group">
                            <strong>Newsletters/Posters/Emails:</strong>
                            <asp:CheckBox runat="server" CssClass="form-control" ID="TextBox32" />
                        </div>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="TextBox33" type="hidden" />
                        <div class="form-group">
                            <strong>Meetings:</strong>
                            <asp:CheckBox runat="server" CssClass="form-control" ID="TextBox34" />
                        </div>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="TextBox35" type="hidden" />
                        <div class="form-group">
                            <strong>Conferences:</strong>
                            <asp:CheckBox runat="server" CssClass="form-control" ID="CheckBox9" />
                        </div>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="TextBox36" type="hidden" />
                        <div class="form-group">
                            <strong>Other (Please enter as comma separated entries):</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="CheckBox10" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Update Communicatins Details" ID="Button10" />
                    </div>
                </div>

            </div>
        </div>
        <div id="editKeyStakeholdersStrengthsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Key Stakeholders’ requirements Strengths</h4>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="editstakeholderstrengthsNumber" type="hidden" />
                        <div class="form-group">
                            <strong>Key Strengths:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="editstakeholderstrenghts" placeholder="Key Stakeholders’ requirements Strengths" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Update Key Strength" ID="Button12" />
                    </div>
                </div>

            </div>
        </div>

        <div id="editlearningaspectsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Academic Programme Learning Aspects</h4>
                    </div>
                    <strong>Describe the Academic Programme in terms of the following aspects which the learners are expected to demonstrate upon completion:
                    </strong>
                    <table class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>SN</th>
                                <th>Aspect</th>
                                <th>Description</th>
                            </tr>
                        </thead>
                        <tbody>

                            <tr>
                                <td>1</td>
                                <td>Knowledge and understanding</td>
                                <td>
                                    <asp:TextBox runat="server" TextMode="MultiLine" CssClass="form-control" ID="TextBox43" />

                                </td>

                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Cognitive skills (e.g. methodologies, critical analysis)</td>
                                <td>
                                    <asp:TextBox runat="server" TextMode="MultiLine" CssClass="form-control" ID="TextBox44" /></td>

                            </tr>
                            <tr>
                                <td>3</td>
                                <td>Subject specific skills (e.g. laboratory skills, clinical skills)</td>
                                <td>
                                    <asp:TextBox runat="server" TextMode="MultiLine" CssClass="form-control" ID="TextBox45" /></td>

                            </tr>

                        </tbody>
                    </table>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Update Learning Aspects" ID="Button15" />
                    </div>
                </div>

            </div>
        </div>
        <div id="editprogrammeobjectivesModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Programme Objectives</h4>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="TextBox48" type="hidden" />
                        <div class="form-group">
                            <strong>Programme Objectives:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="TextBox49" placeholder="Programme Objectives" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Update Programme Objectives" ID="Button18" />
                    </div>
                </div>
            </div>
        </div>
        <div id="editprogrammeorganizationsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Programme Organizations</h4>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="TextBox51" type="hidden" />
                        <div class="form-group">
                            <strong>Year of Study:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="TextBox52" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="TextBox53" type="hidden" />
                        <div class="form-group">
                            <strong>Semester:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="TextBox54" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="TextBox55" type="hidden" />
                        <div class="form-group">
                            <strong>Basic/Intermediate/Specialist/Optional:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="TextBox56" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="TextBox57" type="hidden" />
                        <div class="form-group">
                            <strong>Course or Unit:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="TextBox58" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Update Programme Organizations" ID="Button20" />
                    </div>
                </div>
            </div>
        </div>
        <div id="editprogrammestructureModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Academic Programme Details</h4>
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <strong>(ii)	How many instructional hours are allocated to the Academic Programme? </strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="TextBox60" TextMode="MultiLine" />
                        </div>
                        <div class="form-group">
                            <strong>(d)	What is the rationale for the chosen the structure of the Academic Programme? </strong>
                            <asp:TextBox runat="server" TextMode="MultiLine" CssClass="form-control" ID="TextBox61" />
                        </div>
                        <div class="form-group">
                            <strong>(e)	(i) Has the programme structure been changed over the recent years?</strong><i> (Tick if Yes)</i>
                            <asp:CheckBox runat="server" CssClass="form-control" ID="CheckBox11" />
                        </div>
                        <div class="form-group">
                            <strong>(ii) If Yes, state the change(s) and reason(s) for the change. </strong>
                            <asp:TextBox runat="server" CssClass="form-control" TextMode="MultiLine" ID="TextBox62" />
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                            <asp:Button runat="server" CssClass="btn btn-success" Text="Update Programme Details" ID="Button22" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="editprogrammecontacthoursModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Programme Contact Hours</h4>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="TextBox64" type="hidden" />
                        <div class="form-group">
                            <strong>Subject Area:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="TextBox65" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="TextBox66" type="hidden" />
                        <div class="form-group">
                            <strong>Units:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="TextBox67" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="TextBox68" type="hidden" />
                        <div class="form-group">
                            <strong>Contact Hours Per Subject Area:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="TextBox69" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Update Contacts Hours" ID="Button24" />
                    </div>
                </div>
            </div>
        </div>
        <div id="editprogrammeinstructionalhoursModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Programme Instructional  Hours</h4>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Indicate the distribution of Instructional hours of the Academic Programme per category (as applicable)
                        </div>
                        <div class="panel-body">
                            <div id="Div1" runat="server"></div>
                            <table class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>SN</th>
                                        <th>Category</th>
                                        <th>Instruction Hours</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td>Laboratory/Farm</td>
                                        <td>
                                            <asp:TextBox runat="server" CssClass="form-control" ID="TextBox71" TextMode="MultiLine" /></td>
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td>Practicum/Industrial attachment</td>
                                        <td>
                                            <asp:TextBox runat="server" CssClass="form-control" ID="TextBox72" TextMode="MultiLine" />
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                <asp:Button runat="server" CssClass="btn btn-success" Text="Update Contacts Hours" ID="Button26" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="edituniversitycommunicationsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Programme Contact Hours</h4>
                    </div>
                    <div class="form-group">
                        <strong>(i)	Has the University communicated the specifications/descriptions of the Academic Programme to the following stakeholders? </strong><i>(Tick if Yes)</i>
                        <table>


                            <tr>
                                <td>(i) Staff </td>
                                <td>
                                    <asp:CheckBox runat="server" ID="CheckBox13" />
                                </td>
                            </tr>
                            <tr>
                                <td>(ii) Students </td>
                                <td>
                                    <asp:CheckBox runat="server" ID="CheckBox14" />
                                </td>
                            </tr>
                            <tr>
                                <td>(iii) Employers </td>
                                <td>
                                    <asp:CheckBox runat="server" ID="CheckBox15" />

                                </td>

                            </tr>
                            <tr>
                                <td>(iv)	Statutory bodies that accredit higher education programmes  </td>
                                <td>
                                    <asp:CheckBox runat="server" ID="CheckBox16" />

                                </td>

                            </tr>
                            <tr>
                                <td>(v)	Regulatory/professional bodies (where applicable) 	  </td>
                                <td>
                                    <asp:CheckBox runat="server" ID="CheckBox17" /></td>

                            </tr>
                        </table>
                        <br />
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                            <asp:Button runat="server" CssClass="btn btn-success" Text="Update Contacts Hours" ID="Button28" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="editprogrammedescriptionsstrenthsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Key Programme Specifications Strengths</h4>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="TextBox76" type="hidden" />
                        <div class="form-group">
                            <strong>Key Weakness:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="TextBox77" placeholder="Key Stakeholders’ requirements Strengths" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Update Key Weakness" ID="Button31" />
                    </div>
                </div>

            </div>
        </div>
        <div id="editprogrammedescriptionsweaknessModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Key Programme Specification’  Weakness</h4>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="TextBox78" type="hidden" />
                        <div class="form-group">
                            <strong>Key Weakness:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="TextBox79" placeholder="Key Stakeholders’ requirements Strengths" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Update Key Weakness" ID="Button32" />
                    </div>
                </div>

            </div>
        </div>
        <div id="editprogrammereviewdetailsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Programme Content/Curriculums</h4>
                    </div>
                    <div class="panel-body">
                        <div id="Div2" runat="server"></div>
                        <div class="form-group">
                            <strong>(a)	Has the Academic Programme been reviewed? </strong><i>(Tick if yes)</i>
                            <asp:CheckBox runat="server" ID="CheckBox12" />
                        </div>
                        <div class="form-group">
                            <strong>(b)	If Yes in 5 (a), Upload the Reviewed Academic Programme </strong>
                            <asp:FileUpload CssClass="form-control" runat="server" />
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                            <asp:Button runat="server" CssClass="btn btn-success" Text="Update Programme Content" ID="Button34" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="editprogrammecontentstrengthsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Key Programme Content Strengths</h4>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="TextBox83" type="hidden" />
                        <div class="form-group">
                            <strong>Key Weakness:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="TextBox84" placeholder="Key Stakeholders’ requirements Strengths" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Update Key Strengths" ID="Button37" />
                    </div>
                </div>

            </div>
        </div>
        <div id="editprogrammecontentweaknessModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Key Programme Content Weakness</h4>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="TextBox85" type="hidden" />
                        <div class="form-group">
                            <strong>Key Weakness:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="TextBox86" placeholder="Key Stakeholders’ requirements Strengths" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Update Key Weakness" ID="Button38" />
                    </div>
                </div>
            </div>
        </div>
        <div id="editacademiccalenderdetailsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Programme Calender Details</h4>
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <strong>(a)	Specify the academic calendar in which the Academic Programme is organised:</strong>
                            <br />
                            (i)	Semesters 
                    <asp:CheckBox runat="server" ID="CheckBox18" /><br />
                            (ii)	Trimesters
                    <asp:CheckBox runat="server" ID="CheckBox19" /><br />
                            (iii)	Quarters 	
                    <asp:CheckBox runat="server" ID="CheckBox20" /><br />
                            (iv)	Other (specify)
                    <asp:TextBox runat="server" CssClass="form-control" ID="TextBox87" TextMode="MultiLine" /><br />
                        </div>
                        <div class="form-group">
                            <strong>(b)	(i) Does the department use a Credit Points System? </strong><i>(Tick if yes)</i>
                            <asp:CheckBox runat="server" ID="CheckBox21" />
                        </div>
                        <div class="form-group">
                            <strong>(ii) If Yes, how are credits calculated? </strong>
                            <asp:TextBox runat="server" TextMode="MultiLine" CssClass="form-control" ID="TextBox88" />
                        </div>
                        <div class="form-group">
                            <strong>(c)	Has the feedback of those involved in the academic programme being sought? </strong><i>(Tick if yes)</i>
                            <br />
                            (i) Students
                    <asp:CheckBox runat="server" ID="CheckBox22" />
                            <br />
                            (ii)	Academic Staff	
                    <asp:CheckBox runat="server" ID="CheckBox23" />
                            <br />
                            (iii)	Alumni		
                    <asp:CheckBox runat="server" ID="CheckBox24" />
                            <br />
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                            <asp:Button runat="server" CssClass="btn btn-success" Text="Update Calender Details" ID="Button39" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="editorganizationalprogrammeweaknessModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Key Programme Organizations Weakness</h4>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="TextBox92" type="hidden" />
                        <div class="form-group">
                            <strong>Key Weakness:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="TextBox93" placeholder="Key Stakeholders’ requirements Strengths" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Update Key Weakness" ID="Button43" />
                    </div>
                </div>
            </div>
        </div>
        <div id="editorganizationalprogrammestrengthsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Key Programme Organizations Strengths</h4>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="TextBox94" type="hidden" />
                        <div class="form-group">
                            <strong>Key Strengths:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="TextBox95" placeholder="Key Stakeholders’ requirements Strengths" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Update Key Strengths" ID="Button44" />
                    </div>
                </div>
            </div>
        </div>
        <div id="editdidacticconceptsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Key Programme Organizations Strengths</h4>
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <strong>(b)	Is Information and Communication technology (ICT) integrated in the Academic Programme?</strong> <i>(Tick if yes)</i>
                            <asp:CheckBox runat="server" ID="CheckBox25" />
                        </div>
                        <div class="form-group">
                            <strong>(c)	 (i) Is research part of the Academic Programme?</strong> <i>(Tick if yes)</i>
                            <asp:CheckBox runat="server" ID="CheckBox26" />
                        </div>
                        <div class="form-group">
                            <strong>(ii)  Indicate which course(s) exposes students to research methods?</strong> <i>(Tick if yes)</i>
                            <asp:CheckBox runat="server" ID="CheckBox27" />
                        </div>
                        <div class="form-group">
                            <strong>(iii)  When are students taught research methods in the academic programme? Provide Year and Semester. </strong>
                            <div class="row">
                                <div class="col-md-6 col-lg-6 col-sm-6">
                                    <div class="form-group"><strong>Year</strong><asp:DropDownList runat="server" CssClass="form-control" ID="DropDownList1" /></div>
                                </div>

                                <div class="col-md-6 col-lg-6 col-sm-6">
                                    <div class="form-group"><strong>Semester</strong><asp:DropDownList runat="server" CssClass="form-control" ID="DropDownList2" /></div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <strong>(d)	Does the Academic Programme require students to undertake community/industrial attachment/internship (specify) as part of the practical teaching and learning strategies?  </strong><i>(Tick if yes)</i>
                            <asp:CheckBox runat="server" ID="CheckBox28" />
                        </div>

                        <div class="form-group">
                            <strong>(e)	If yes in 7 (d), Provide the community/industrial attachment/internship, duration and credit points in the Academic Programme  </strong>
                            <div class="row">
                                <div class="col-lg-4 col-md-4">
                                    <div class="form-group"><strong>Type of Community/Industrial attachment</strong><asp:TextBox runat="server" CssClass="form-control" ID="TextBox97" /></div>
                                </div>

                                <div class="col-lg-4 col-md-4">
                                    <div class="form-group"><strong>Duration (in Months)</strong><asp:TextBox runat="server" CssClass="form-control" ID="TextBox98" /></div>
                                </div>

                                <div class="col-lg-4 col-md-4">
                                    <div class="form-group"><strong>Credit Points</strong><asp:TextBox runat="server" CssClass="form-control" ID="TextBox99" /></div>
                                </div>

                            </div>
                            <div class="form-group">
                                <strong>(f)	Is community/industrial attachment/internship a compulsory part of the programme? </strong><i>(Tick if yes)</i>
                                <asp:CheckBox runat="server" ID="CheckBox29" />
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                <asp:Button runat="server" CssClass="btn btn-success" Text="Update Key Strengths" ID="Button46" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="editdidacticconceptstrengthsModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Key Programme Didactic Concepts Strengths</h4>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="TextBox102" type="hidden" />
                        <div class="form-group">
                            <strong>Key Strengths:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="TextBox103" placeholder="Key Stakeholders’ requirements Strengths" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Update Key Strengths" ID="Button49" />
                    </div>
                </div>
            </div>
        </div>
        <div id="editdidacticconceptweaknessModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Key Programme Didactic Concepts Weakness</h4>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox runat="server" ID="TextBox104" type="hidden" />
                        <div class="form-group">
                            <strong>Key Weakness:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="TextBox105" placeholder="Key Stakeholders’ requirements Strengths" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Update Key Weakness" ID="Button50" />
                    </div>
                </div>
            </div>
        </div>
</asp:Content>
