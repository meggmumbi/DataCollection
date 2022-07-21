<%@ Page Title="Program Accreditation" Language="C#" MasterPageFile="~/AccreditationMaster.Master" AutoEventWireup="true" CodeBehind="ProgramAccreditation.aspx.cs" Inherits="CicPortal.ProgramAccreditation" %>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>--%>
<%@ Import Namespace="CicPortal" %>
<%@ Import Namespace="System.IO" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%--<asp:ScriptManager ID="scriptManager" runat="server"></asp:ScriptManager>--%>
    <%
        const int maxStep = 11;
        var nav = Config.ReturnNav();
        String accreditationNo = "";
        try
        {
            accreditationNo = Request.QueryString["accreditationNo"].Trim();
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
        <div class="panel panel-default">
            <div class="panel-heading">
                Programme General Details<div class="pull-right"><i class="fa fa-angle-left"></i>Step 1 of <%= maxStep %> <i class="fa fa-angle-right"></i></div>
                <div class="clearfix"></div>
            </div>
        </div>
        <div class="panel-body">
            <center><h3><strong style="color:red" id="isEditing" runat="server" visible="false"></strong></h3></center><br />
            <div id="generalFeedback" runat="server"></div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Campus:<span style="color:red">*</span></strong>
                    <asp:DropDownList runat="server" ID="campus" CssClass="form-control" AppendDataBoundItems="true">
                        <asp:ListItem>--Select--</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="campus" InitialValue="--Select--" ErrorMessage="Please select campus, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Title of the Proposed Programme:<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" ID="programName" CssClass="form-control" placeholder="Programme Name" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="programName" ErrorMessage="Please enter Title of the Proposed Programme, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>

            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Duration of the Programme(YRS):<span style="color: red">*</span></strong>
                    <asp:TextBox runat="server" ID="programDuration" CssClass="form-control" placeholder="Programme Duration" TextMode="Number" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="programDuration" ErrorMessage="Please enter Duration of the Programme(YRS), it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Programme Domain:<span style="color: red">*</span></strong>
                    <asp:DropDownList runat="server" ID="programDomain" CssClass="form-control" AppendDataBoundItems="true">
                        <asp:ListItem>--Select--</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="programDomain" InitialValue="--Select--" ErrorMessage="Please select program domain, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>

            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Programme Level:<span style="color: red">*</span></strong>
                    <asp:DropDownList runat="server" ID="programLevel" CssClass="form-control" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="programLevel" InitialValue="--Select--" ErrorMessage="Please select program level, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Total Credit Hours/Lecture Hours Required for Graduation<span style="color: red">*</span></strong>
                    <asp:TextBox runat="server" ID="totalcredit" CssClass="form-control" TextMode="Number" placeholder="Total Credit Hours" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="totalcredit" ErrorMessage="Please enter Total Credit Hours/Lecture Hours Required for Graduation, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Total Course Units Required for Graduation<span style="color: red">*</span></strong>
                    <asp:TextBox runat="server" ID="totalcourse" CssClass="form-control" placeholder="Total Course Units" type="number" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="totalcourse" ErrorMessage="Please enter Total Course Units Required for Graduation, it cannot be empty!" ForeColor="Red" />
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Programme Specialization Areas</strong><br />
                    <i>(Please Check if the Programme  has Specialization Areas)</i>
                    <asp:CheckBox runat="server" ID="specializationareas" CssClass="form-control" />
                </div>
            </div>
            <div class="col-md-12 col-lg-12">
                 <div class="form-group">                   
                    <strong>Philosophy of the Programme<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" ID="philosophy" CssClass="form-control" TextMode="MultiLine" placeholder="Philosophy of the Programme" Height="200"/>                   
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="philosophy" ErrorMessage="Please enter Philosophy of the Programme, it cannot be empty!" ForeColor="Red" />
                   <%-- <asp:HtmlEditorExtender ID="editorphilosophy"  runat="server" TargetControlID="philosophy" />--%>
                </div>
            </div>
            <div class="col-md-12 col-lg-12">
                <div class="form-group">
                    <strong>Admission Requirements for the Proposed Programme:<span style="color: red">*</span></strong><br />
                    <i>(These should include the minimum requirements  applicable  to  candidates  directly  out  of secondary school education and seeking admission into the programme of the Institution)</i>
                    <asp:TextBox runat="server" ID="admission" CssClass="form-control" TextMode="MultiLine" placeholder="Admission Requirements" Height="200"/>
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="admission" ErrorMessage="Please enter Admission Requirements for the Proposed Programme, it cannot be empty!" ForeColor="Red" />
                   <%-- <asp:HtmlEditorExtender  runat="server" ID="editoradmission" TargetControlID="admission" />--%>
                </div>
            </div>
            <div class="col-md-12 col-lg-12">
                <div class="form-group">
                    <strong>Goal of the Programme:<span style="color: red">*</span></strong><br />
                    <i>(The goal refers to the general purpose of the programme.)</i>
                    <asp:TextBox runat="server" ID="goal" CssClass="form-control" TextMode="MultiLine" placeholder="Goal of the Programme" Height="200"/>
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="goal" ErrorMessage="Please enter Goal of the Programme, it cannot be empty!" ForeColor="Red" />
                    <%--<asp:HtmlEditorExtender  runat="server" ID="editorgoal" TargetControlID="goal" />--%>
                </div>
            </div>
            <div class="col-md-12 col-lg-12">
                <div class="form-group">
                    <strong>Course requirement for the Proposed Programme:<span style="color: red">*</span></strong><br />
                    <asp:TextBox runat="server" ID="coursereqirement" CssClass="form-control" TextMode="MultiLine" placeholder="Course requirement" Height="200"/>
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="coursereqirement" ErrorMessage="Please enter Course requirement for the Proposed Programme, it cannot be empty!" ForeColor="Red" />
                    <%--<asp:HtmlEditorExtender  runat="server" ID="editorcoursereqirement" TargetControlID="coursereqirement" />--%>
                </div>
            </div>
            <div class="col-md-12 col-lg-12">
                <div class="form-group">
                    <strong>Course Evaluation of the Programme:<span style="color: red">*</span></strong><br />
                    <asp:TextBox runat="server" ID="courseevaluations" CssClass="form-control" TextMode="MultiLine" placeholder="Course Evaluation " Height="200"/>
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="courseevaluations" ErrorMessage="Please enter Course Evaluation of the Programme, it cannot be empty!" ForeColor="Red" />
                   <%-- <asp:HtmlEditorExtender  runat="server" ID="editorcourseevaluations" TargetControlID="courseevaluations" />--%>
                </div>
            </div>

            <div class="col-md-12 col-lg-12">
                <div class="form-group">
                    <strong>Regulations on Credit Transfer in a programme<span style="color: red">*</span></strong><br />
                    <i>(These should include type of certifications recognized for purposes of credit transfer,The maximum number of credits permissible for transfer ,Level of courses eligible for credit transfer and Minimum grade required for credit transfer)</i>
                    <asp:TextBox runat="server" ID="requlations" CssClass="form-control" TextMode="MultiLine" placeholder="Regulations on Credit Transfer" Height="200"/>
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="requlations" ErrorMessage="Please enter Regulations on Credit Transfer in a programme, it cannot be empty!" ForeColor="Red" />
                    <%--<asp:HtmlEditorExtender  runat="server" ID="editorrequlations" TargetControlID="requlations" />--%>
                </div>
            </div>
            <div class="col-md-12 col-lg-12">
                <div class="form-group">
                    <strong>Examination Regulations<span style="color: red">*</span></strong><br />
                    <i>(This should also include examination malpractices, disciplinary action and mode of appeal)</i>
                    <asp:TextBox runat="server" ID="examinations" CssClass="form-control" TextMode="MultiLine" placeholder="Examination Regulations" Height="200"/>
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="examinations" ErrorMessage="Please enter Examination Regulations, it cannot be empty!" ForeColor="Red" />
                    <%--<asp:HtmlEditorExtender  runat="server" ID="editorexaminations" TargetControlID="examinations" />--%>
                </div>
            </div>
            <div class="col-md-12 col-lg-12">
                <div class="form-group">
                    <strong>Moderation of Examinations<span style="color: red">*</span></strong><br />
                    <i>(This should include the process of moderation and the role of internal and external examiners.)</i>
                    <asp:TextBox runat="server" ID="moderations" CssClass="form-control" TextMode="MultiLine" placeholder="Moderation of Examinations" Height="200"/>
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="moderations" ErrorMessage="Please enter Moderation of Examinations, it cannot be empty!" ForeColor="Red" />
                    <%--<asp:HtmlEditorExtender  runat="server" ID="editormoderations" TargetControlID="moderations" />--%>
                </div>
            </div>

            <div class="col-md-12 col-lg-12">
                <div class="form-group">
                    <strong>Management and Administration of the Programme<span style="color: red">*</span></strong><br />
                    <i>(This should include aspects the programme placement/housing, academic leadership and internal quality assurance mechanisms</i>
                    <asp:TextBox runat="server" ID="management" CssClass="form-control" TextMode="MultiLine" placeholder="Management and Administration of the Programme" Height="200"/>
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="management" ErrorMessage="Please enter Management and Administration of the Programme, it cannot be empty!" ForeColor="Red" />
                     <%--<asp:HtmlEditorExtender  runat="server" ID="editormanagement" TargetControlID="management" />--%>
                </div>
            </div>


            <div class="col-md-12 col-lg-12">
                <div class="form-group">
                    <strong>Graduation Requirements<span style="color: red">*</span></strong><br />
                    <i>(The graduation requirements should be explicitly provided and should include the passmark and the total number of credits/lecture hours required for graduation purposes.)</i>
                    <asp:TextBox runat="server" ID="graduation" CssClass="form-control" TextMode="MultiLine" placeholder="Graduation Requirements" Height="200"/>
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="graduation" ErrorMessage="Please enter Graduation Requirements, it cannot be empty!" ForeColor="Red" />
                   <%-- <asp:HtmlEditorExtender  runat="server" ID="editorgraduation" TargetControlID="graduation" />--%>
                </div>
            </div>
            <div class="col-md-12 col-lg-12">
                <div class="form-group">
                    <strong>Description of Thesis/Dissertation/Project (as applicable).<span style="color: red">*</span></strong><br />
                    <i>(The most applicable aspect of the programme, that is, Thesis, Dissertation orProject should be identified)</i>
                    <asp:TextBox runat="server" ID="description" CssClass="form-control" TextMode="MultiLine" placeholder="Description of Thesis" Height="200"/>
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="description" ErrorMessage="Please enter -Description of Thesis/Dissertation/Project (as applicable), it cannot be empty!" ForeColor="Red" />
                   <%-- <asp:HtmlEditorExtender  runat="server" ID="editordescription" TargetControlID="description" />--%>
                </div>
            </div>




           
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Student Assessment Policy/Criteria</strong>
                        <div class="container">
                            <fieldset class="row">
                                <label>
                                    <asp:CheckBox runat="server" ID="cats" />
                                    <span>Continuous Assessment Tests (CATs);</span>
                                </label>
                            </fieldset>
                            <fieldset class="row">
                                <label>
                                    <asp:CheckBox runat="server" ID="semester" />
                                    <span>End-Trimester/Quarter/Semester Exams</span>
                                </label>
                            </fieldset>
                            <fieldset class="row">
                                <label>
                                    <asp:CheckBox runat="server" ID="practicals" />
                                    <span>Practicals</span>
                                </label>
                            </fieldset>
                            <fieldset class="row">
                                <label>
                                    <asp:CheckBox runat="server" ID="others" />
                                    <span>Other Assessments</span>
                                </label>
                            </fieldset>
                        </div>
                    </div>
                </div>
            <hr />

           <div class="col-md-12 col-lg-12">
                <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                    <br />
                    <asp:Button runat="server" ID="Button4" CssClass="btn btn-success btn-block" Text="Save General Details" OnClick="adddGeneralDetails_Click" />
                </div>
            </div>
            <br />
            <br />
            <table class="table table-bordered table-striped dataTable">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Acccreditation No</th>
                        <th>Campus</th>
                        <th>Domain</th>
                        <th>Programme Level</th>
                        <th>Duration</th>
                        <th>Programme Title</th>
                        <th>Edit</th>
                        <th>Proceed</th>
                    </tr>
                </thead>
                <tbody>
                    <% var details = nav.ProgramAccreditation.Where(r => r.Institution_No == Convert.ToString(Session["UniversityCode"])&&r.Current_Version==true && r.Status == "Open");
                        string university = Convert.ToString(Session["UniversityCode"]);
                        int programesCounter = 0;
                        string phylosophydesciptions = "";
                        string admissionsdesciptions = "";
                        string goalsdesciptions = "";
                        string requirmentsdesciptions = "";
                        string examinationsdesciptions = "";
                        string graduationsdesciptions = "";
                        string thesisdesciptions = "";
                        string managementdesciptions = "";
                        string moderationsdesciptions = "";
                        string StudentAssessmentPolicy = "";
                        foreach (var detail in details)
                        {
                            programesCounter++;
                            var accreditationNumber = new Config().ObjNav().GetAccreditationNumber(university);
                            var phylosophy = new Config().ObjNav().FngetPhylosophy(accreditationNumber, university);
                            phylosophydesciptions = Regex.Replace(phylosophy, @"[^0-9a-zA-Z]+", " ");
                            var admissions = new Config().ObjNav().FngetAdmissionRequirement(accreditationNumber, university);
                            admissionsdesciptions = Regex.Replace(admissions, @"[^0-9a-zA-Z]+", " ");
                            var goals = new Config().ObjNav().FngetGoalProgramme(accreditationNumber, university);
                            goalsdesciptions = Regex.Replace(goals, @"[^0-9a-zA-Z]+", " ");
                            var requirments = new Config().ObjNav().FngetRequlationsProgramme(accreditationNumber, university);
                            requirmentsdesciptions = Regex.Replace(requirments, @"[^0-9a-zA-Z]+", " ");
                            var examinations = new Config().ObjNav().FngetExaminationsProgramme(accreditationNumber, university);
                            examinationsdesciptions = Regex.Replace(examinations, @"[^0-9a-zA-Z]+", " ");
                            var graduations = new Config().ObjNav().FngetGraduationsProgramme(accreditationNumber, university);
                            graduationsdesciptions = Regex.Replace(graduations, @"[^0-9a-zA-Z]+", " ");
                            var thesis = new Config().ObjNav().FngetThesisProgramme(accreditationNumber, university);
                            thesisdesciptions = Regex.Replace(thesis, @"[^0-9a-zA-Z]+", " ");
                            var management = new Config().ObjNav().FngetManagementProgramme(accreditationNumber, university);
                            managementdesciptions = Regex.Replace(management, @"[^0-9a-zA-Z]+", " ");
                            var moderations = new Config().ObjNav().FngetModerationsProgramme(accreditationNumber, university);
                            moderationsdesciptions = Regex.Replace(moderations, @"[^0-9a-zA-Z]+", " ");
                    %>
                    <tr>
                        <td><%=programesCounter %></td>
                        <td><%=detail.Accreditation_No %></td>
                        <td><%=detail.Campus_Name %></td>
                        <td><%=detail.Program_Domain %></td>
                        <td><%=detail.Program_Level %></td>
                        <td><%=detail.Programme_Duration %></td>
                        <td><%=detail.Program_Name %></td>
                        <td>
                            <label class="btn btn-info" onclick="editGeneralDetailsNewVersion('<%=detail.Accreditation_No %>','<%=detail.Program_Name %>');"><i class="fa fa-pencil"></i>Edit Programme</label></td>
                            <%--<label class="btn btn-success" onclick="editGeneralDetails('<%=detail.Accreditation_No %>','<%=detail.Campus_Name%>','<%=detail.Program_Domain%>','<%=detail.Program_Level%>','<%=detail.Programme_Duration%>','<%=detail.Program_Name%>','<%=detail.TotalCreditHours%>','<%=detail.TotalCourseUnits%>','<%=phylosophydesciptions%>','<%=admissionsdesciptions%>','<%=goalsdesciptions%>','<%=requirmentsdesciptions%>','<%=examinationsdesciptions%>','<%=graduationsdesciptions%>','<%=thesisdesciptions%>','<%=managementdesciptions%>','<%=moderationsdesciptions%>','<%=detail.Require_Specialization_Areas%>');"><i class="fa fa-pencil"></i>Edit</label></td>--%>
                        <td><a href="ProgramAccreditation.aspx?accreditationNo=<%=detail.Accreditation_No %>&step=2" class="btn btn-success"><i class="fa fa-eye"></i>Proceed</a></td>
                    </tr>
                    <%  
                        } %>
                </tbody>
            </table>


        </div>
        <%--        <div class="panel-footer">
            <div class="pull-right">
                <asp:Button runat="server" CssClass="btn btn-success" Text="Next" ID="nextOne" OnClick="FirstStep_Click" autopostback="false" />
            </div>
            <div class="clearfix"></div>

        </div>--%>
    </div>
    <%
        }
        else if (currentStep == 2)
        {
    %>

    <div class="panel panel-primary">
        <div class="panel panel-primary">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Programme Rationale(Please fill in all the 3 Programme Rationale Categories)<div class="pull-right"><i class="fa fa-angle-left"></i>Step 2 of <%=maxStep %> <i class="fa fa-angle-right"></i></div>
                    <div class="clearfix"></div>
                </div>
            </div>
            <div class="panel-body">
                <div id="rationaleFeedback" runat="server"></div>
                <div class="row">
                    <div class="col-md-4 col-lg-4 col-sm-6 col-xs-12 form-group">
                        <strong>Programme Rationale Category<span style="color:red">*</span></strong>
                        <asp:DropDownList runat="server" ID="rationaleCategory" CssClass="form-control" AppendDataBoundItems="true">
                            <asp:ListItem>--Select--</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="rationaleCategory" InitialValue="--Select--" ErrorMessage="Please select Programme Rationale Category, it cannot be empty!" ForeColor="Red" />
                    </div>
                    <div class="col-md-4 col-lg-4 col-sm-6 col-xs-12 form-group">
                        <strong>Programme Rationale Description<span style="color:red">*</span></strong>
                        <asp:TextBox runat="server" ID="rationaleCategoryDescription" TextMode="MultiLine" CssClass="form-control" placeholder="Category Description" />
                        <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="rationaleCategoryDescription" ErrorMessage="Please enter Programme Rationale Description, it cannot be empty!" ForeColor="Red" />
                    </div>
                </div>
                <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 form-group">
                    <br />
                    <asp:Button runat="server" ID="addrationale" CssClass="btn btn-success" Text="Add Rationale" OnClick="addrationale_Click" />
                </div>
            </div>
        </div>
        <br />
        <hr />
        <br />
        <table class="table table-bordered table-striped dataTable">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Rationale Category</th>
                    <th>Description</th>
                    <td>Edit</td>
                    <td>Delete</td>
                </tr>
            </thead>
            <tbody>
                <%
                    var rationales = nav.ProgramRationale.Where(r => r.Application_No == accreditationNo && r.Current_Version == true);
                    string University_Code = Convert.ToString(Session["UniversityCode"]);
                    int count = 0;
                    string categorydescr1 = "";
                    foreach (var rationale in rationales)
                    {
                        count++;
                        int category = 0;
                        if (rationale.Category == "Needs assessment/market survey/situation analysis")
                        {
                            category = 0;
                        }
                        if (rationale.Category == "Stakeholders Involvement")
                        {
                            category = 1;
                        }
                        if (rationale.Category == "Justification of the need for the programme")
                        {
                            category = 2;
                        }
                        var categorydescr = new Config().ObjNav().FngetRationaleDescription(accreditationNo, University_Code, category);
                        categorydescr1 = Regex.Replace(categorydescr, @"[^0-9a-zA-Z]+", " ");

                %>
                <tr>
                    <td><%=count %></td>
                    <td><%=rationale.Category %></td>
                    <td><%=categorydescr%></td>
                    <td>
                        <label class="btn btn-success" onclick="editRationale('<%=rationale.Category %>','<%=categorydescr1%>','<%=rationale.Code %>');"><i class="fa fa-pencil"></i>Edit</label></td>
                    <td>
                        <label class="btn btn-danger" onclick="deleteRationale('<%=rationale.Code %>','<%=rationale.Category %>');"><i class="fa fa-trash"></i>Delete</label></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <div class="panel-footer">
            <div class="pull-left">
                <asp:Button runat="server" CssClass="btn btn-warning" Text="Previous" OnClick="previous_Click" CausesValidation="false" />
            </div>
            <div class="pull-right">
                <asp:Button runat="server" CssClass="btn btn-success" Text="Next" OnClick="Validate_Rationale" CausesValidation="false"/>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
    <%
        }
        else if (currentStep == 3)
        {
    %>
    <div class="panel panel-primary">
        <div class="panel panel-default">
            <div class="panel-heading">
                Expected Learning Outcomes of the programme<div class="pull-right"><i class="fa fa-angle-left"></i>Step 3 of <%=maxStep %> <i class="fa fa-angle-right"></i></div>
                <div class="clearfix"></div>
                <p font-style: italic>The expected learning outcomes of the programme should be Specific, Measurable, Achievable, Realistic, and Time-bound (SMART), precise and concise and include specific knowledge, skills,areas of professional development, and attitudes </p>
            </div>
        </div>
        <div class="panel-body">
            <div id="learningOutcomeFeedback" runat="server"></div>
            <div class="row">
                <div class="col-md-4 col-lg-4 col-sm-6 col-xs-12 form-group">
                    <strong>Programme Learning Outcome Description:<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" ID="outcomeDescription" TextMode="MultiLine" CssClass="form-control" placeholder="Programme Learning Outcome Description" />
                    <asp:RequiredFieldValidator Display="dynamic" runat="server" ControlToValidate="outcomeDescription" ErrorMessage="Programme Learning Outcome Description, it cannot be empty!" ForeColor="Red" />
                </div>
                <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 form-group">
                    <br />
                    <asp:Button runat="server" ID="adOutcome" CssClass="btn btn-success" Text="Add Programme Learning Outcome" OnClick="adOutcome_Click" />
                </div>
            </div>
            <br />
            <hr />
            <br />
            <table class="table table-bordered table-striped dataTable">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Outcome Description</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var outcomes = nav.ProgramOutcomes.Where(r => r.Application_No == accreditationNo && r.Current_Version == true);
                        string University_Code = Convert.ToString(Session["UniversityCode"]);
                        int count = 0;
                        int outcomenumber = 0;
                        var outcomedescriptions = "";
                        var outcomedescriptions1 = "";
                        foreach (var outcome in outcomes)
                        {
                            count++;
                            outcomenumber = outcome.Code;
                            outcomedescriptions = new Config().ObjNav().FngetLearningOutcomeDescription(accreditationNo, University_Code, outcomenumber);
                            outcomenumber++;
                            outcomedescriptions1 = Regex.Replace(outcomedescriptions, @"[^0-9a-zA-Z]+", " ");
                    %>
                    <tr>
                        <td><%=count%></td>
                        <td><%=outcomedescriptions%></td>
                        <td>
                            <label class="btn btn-success" onclick="editLearningOutcome('<%=outcome.Code %>','<%=outcomedescriptions1%>')"><i class="fa fa-edit"></i>Edit</label></td>
                        <td>
                            <label class="btn btn-danger" onclick="deleteLearningOutcome('<%=outcome.Code%>','<%=outcome.Outcome_Code%>')"><i class="fa fa-trash"></i>Delete</label></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
        <div class="panel-footer">
            <div class="pull-left">
                <asp:Button runat="server" CssClass="btn btn-warning" Text="Previous" OnClick="previous_Click" CausesValidation="false"/>
            </div>
            <div class="pull-right">
                <asp:Button runat="server" CssClass="btn btn-success" Text="Next" OnClick="ValidateLearningOutcome_Click" CausesValidation="false"/>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
    <%
        }
        else if (currentStep == 4)
        {
    %>
    <div class="panel panel-primary">
        <div class="panel panel-default">
            <div class="panel-heading">
                Specialization Learning Outcomes of the Proposed Programme<i>(Please indicate atleast four specialization areas or "Not Applicable" for those Programmes without Specialization Areas)</i><div class="pull-right"><i class="fa fa-angle-left"></i>Step 4 of <%=maxStep %> <i class="fa fa-angle-right"></i></div>
                <div class="clearfix"></div>
            </div>
        </div>
        <div class="panel-body">
            <div id="specializationfeedback" runat="server"></div>
            <div class="row">
                <div class="col-md-4 col-lg-4 col-sm-6 col-xs-12 form-group">
                    <strong>Specialization Area<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" ID="specializations" CssClass="form-control" />
                </div>
                <div class="col-md-4 col-lg-4 col-sm-6 col-xs-12 form-group">
                    <strong>Specialization Learning Outcome:<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" ID="specializationdescript" TextMode="MultiLine" CssClass="form-control" placeholder="Specialization Outcome Description" />
                </div>
                <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 form-group">
                    <br />
                    <asp:Button runat="server" ID="addSpecialization" CssClass="btn btn-success" Text="Add Specialization Learning Outcome" OnClick="addSpecialization_Click" />
                </div>
            </div>
            <br />
            <hr />
            <br />
            <table class="table table-bordered table-striped dataTable">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Specialization Area</th>
                        <th>Specialization Learning Outcome</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var modes = nav.SpecializationsAreas.Where(r => r.Application_No == accreditationNo && r.Current_Version == true).ToList();
                        string University_Code = Convert.ToString(Session["UniversityCode"]);
                        int count = 0;
                        int ModeCounter = 0;
                        var tdescriptions = "";
                        foreach (var mode in modes)
                        {
                            ModeCounter = mode.Code;
                            var descriptions = new Config().ObjNav().FngetSpecializationDescription(accreditationNo, University_Code, ModeCounter);
                            tdescriptions = Regex.Replace(descriptions, @"[^0-9a-zA-Z]+", " ");
                            count++;
                    %>
                    <tr>
                        <td><%=count%></td>
                        <td><%=mode.Specialization_Area %></td>
                        <td><%=descriptions%></td>
                        <th>
                            <label class="btn btn-success" onclick="editspecializationsfunction('<%=mode.Code %>','<%=mode.Specialization_Area %>','<%=tdescriptions %>')"><i class="fa fa-edit"></i>Edit</label></th>
                        <th>
                            <label class="btn btn-danger" onclick="removespecialization('<%=mode.Code %>','<%=mode.Specialization_Area %>')"><i class="fa fa-trash"></i>Remove</label></th>

                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>

        </div>
        <div class="panel-footer">
            <div class="pull-left">
                <asp:Button runat="server" CssClass="btn btn-warning" Text="Previous" OnClick="previous_Click" CausesValidation="false"/>
            </div>
            <div class="pull-right">
                <asp:Button runat="server" CssClass="btn btn-success" Text="Next" OnClick="Validate_Specialization" CausesValidation="false"/>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>

    <%
        }
        else if (currentStep == 5)
        {
    %>
    <div class="panel panel-primary">
        <div class="panel panel-default">
            <div class="panel-heading">
                Mode of Delivery of the Programme<div class="pull-right"><i class="fa fa-angle-left"></i>Step 5 of <%=maxStep %> <i class="fa fa-angle-right"></i></div>
                <div class="clearfix"></div>
            </div>
        </div>
        <div class="panel-body">
            <div id="modeOfDeliveryFeedback" runat="server"></div>
            <div class="row">
                <div class="col-md-4 col-lg-4 col-sm-6 col-xs-12 form-group">
                    <strong>Delivery Mode:<span style="color:red">*</span></strong>
                    <asp:DropDownList runat="server" ID="deliveryMode" CssClass="form-control" AppendDataBoundItems="true">
                        <asp:ListItem>--Select--</asp:ListItem>
                    </asp:DropDownList>
                     <asp:RequiredFieldValidator Display="dynamic" runat="server" ID="validateresidence" ControlToValidate="deliveryMode" InitialValue="--Select--" ErrorMessage="Please select delivery mode, it cannot be empty!" ForeColor="Red" />
                </div>
                <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 form-group">
                    <br />
                    <asp:Button runat="server" ID="addDeliveryMode" CssClass="btn btn-success" Text="Add Delivery Mode" OnClick="addDeliveryMode_Click" />
                </div>
            </div>
            <br />
            <hr />
            <br />
            <table class="table table-bordered table-striped dataTable">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Delivery Mode Code</th>
                        <th>Delivery Mode Description</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <%

                        var modes = nav.ProgramDeliveryModes.Where(r => r.Application_No == accreditationNo && r.Current_Version == true);
                        int modescounter = 0;
                        foreach (var mode in modes)

                        {
                            modescounter++;
                    %>
                    <tr>
                        <td><%=modescounter %></td>
                        <td><%=mode.Delivery_Mode_Code %></td>
                        <td><%=mode.Delivery_Mode_Name %></td>
                        <th>
                            <label class="btn btn-danger" onclick="removeDeliveryMode('<%=mode.Delivery_Mode_Code %>','<%=mode.Delivery_Mode_Name %>')"><i class="fa fa-trash"></i>Delete</label></th>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
        <div class="panel-footer">
            <div class="pull-left">
                <asp:Button runat="server" CssClass="btn btn-warning" Text="Previous" OnClick="previous_Click" CausesValidation="false"/>
            </div>
            <div class="pull-right">
                <asp:Button runat="server" CssClass="btn btn-success" Text="Next" OnClick="Validate_DeliveryMode" CausesValidation="false"/>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
    <%
        }
        else if (currentStep == 6)
        {
    %>
    <div class="panel panel-primary">
        <div class="panel panel-default">
            <div class="panel-heading">
                Grading System<div class="pull-right"><i class="fa fa-angle-left"></i>Step 6 of <%=maxStep %> <i class="fa fa-angle-right"></i></div>
                <div class="clearfix"></div>
            </div>
        </div>
        <div class="panel-body">
            <div runat="server" id="gradingSystemFeedback"></div>
            <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                <asp:TextBox ID="checkboxstate" runat="server" Style="display: none"></asp:TextBox>
                <strong>GPA Grading System</strong>
                <asp:CheckBox runat="server" ID="chkPassport" onclick="ShowHideDiv(this)" />
            </div>
            <br />
            <div class="row">
            </div>
            <div class="row">
                <div id="gradecode1" class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                    <strong>Grade<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" ID="gSystemGradeCode" CssClass="form-control" placeholder="Grade" />
                </div>
                <div id="dvPassport1" class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group" style="display: none">
                    <strong>Enter GPA Points(4.0 Scale)<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" ID="gSystemGPAPoints" CssClass="form-control" placeholder="Enter GPA Points" DisplayFormatString="00.00" onkeyup="checkTB(this.value)"/>                 
                </div>
            </div>
            <div class="row">
                <div id="percentage1" class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                    <strong>Enter Minimum Percentage Score<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" ID="gPercentage1" CssClass="form-control" TextMode="Number" placeholder="Enter  Minimum Percentage" max="100"  min="0" value="0" step="0.001"/>
                    <asp:RegularExpressionValidator Display = "Dynamic" ControlToValidate = "gPercentage1" ID="RegularExpressionValidator1" ValidationExpression = "^[\s\S]{0,4}$" runat="server" ErrorMessage="Your Maximum limit is only 4 Characters"></asp:RegularExpressionValidator>
                </div>
                <div id="percentage2" class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                    <strong>Enter Maximum Percentage Score<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" ID="gPercentage2" CssClass="form-control" TextMode="Number" placeholder="Enter  Maximum Percentage" max="100" min="0" value="0" step="0.001"/>
                     <asp:RegularExpressionValidator Display = "Dynamic" ControlToValidate ="gPercentage2" ID="RegularExpressionValidator2" ValidationExpression = "^[\s\S]{0,4}$" runat="server" ErrorMessage="Your Minimum limit is only 4 Characters"></asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                <br />
                <asp:Button runat="server" ID="addGrade" CssClass="btn btn-success btn-block" Text="Add Grade" OnClick="addGrade_Click" />
            </div>
        </div>
        <br />
        <hr />
        <br />
        <table class="table table-bordered table-striped dataTable">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Grade</th>
                    <th>GPA Points(4.0 Scale)</th>
                    <th>Maximum Percentage</th>
                    <th>Minimum Percentage</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                <%
                    var grades = nav.ProgramGrading.Where(r => r.Application_No == accreditationNo);
                    int gradecounter = 0;
                    foreach (var grade in grades)
                    {
                    gradecounter++;
                %>
                <tr>

                    <td><%=gradecounter %></td>
                    <td><%=grade.Grade %></td>
                    <td><%= Convert.ToDecimal(grade.GPA_Points).ToString("0.00") %></td>
                    <td><%=grade.Maximum %></td>
                    <td><%=grade.Minimum %></td>
                    <td>
                        <label class="btn btn-success" onclick="editGradingSystem('<%=grade.Code %>','<%=grade.Grade %>','<%=grade.GPA_Points %>','<%=grade.Maximum %>','<%=grade.Minimum %>')"><i class="fa fa-edit"></i>Edit</label></td>
                    <td>
                        <label class="btn btn-danger" onclick="deleteGradingSystem('<%=grade.Code %>','<%=grade.Grade %>')"><i class="fa fa-trash"></i>Delete</label></td>
                </tr>
                <% 
                    }
                %>
            </tbody>
        </table>
    </div>
    <div class="panel-footer">
        <div class="pull-left">
            <asp:Button runat="server" CssClass="btn btn-warning" Text="Previous" OnClick="previous_Click" CausesValidation="false"/>
        </div>
        <div class="pull-right">
            <asp:Button runat="server" CssClass="btn btn-success" Text="Next" OnClick="Validate_GradingSystem" CausesValidation="false"/>
        </div>
        <div class="clearfix"></div>
    </div>
    <%
        }
        else if (currentStep == 7)
        {
    %>
    <div class="panel panel-primary">
        <div class="panel panel-default">
            <div class="panel-heading">
                Course Units for the Proposed Programme<div class="pull-right"><i class="fa fa-angle-left"></i>Step 7 of <%=maxStep %> <i class="fa fa-angle-right"></i></div>
                <div class="clearfix"></div>
                <strong><i>This include statements of knowledge, skills and attitude that the student would be expected to acquire, and the tasks he/she would be expected to perform or accomplish after taking the particular course and be smart</i></strong>
            </div>
        </div>
        <div class="panel-body">
            
            <%
                var prog = nav.programAccreditationTable.Where(x => x.Accreditation_No == accreditationNo).ToList();
                foreach(var itm in prog)
                {
                    %><center><h3 style="color:red"><strong>You are required to enter (<%=Convert.ToInt32(itm.TotalCourseUnits) %>) Total course units!</strong></h3></center><br /><%
                }
            %>
            <div runat="server" id="courseUnitsFeedback"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                    <strong>Course Code<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" ID="courseCode" CssClass="form-control" placeholder="Course Code" />

                </div>
                <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                    <strong>Course Title<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" ID="courseTitle" CssClass="form-control" placeholder="Course Title" />

                </div>
                <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                    <strong>Credit Hours/or Lecture hours<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" ID="creditHours" CssClass="form-control" TextMode="Number" placeholder="Credit Hours" />

                </div>
                <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                    <strong>Year Code<span style="color:red">*</span></strong>
                    <asp:DropDownList runat="server" ID="yearCode" CssClass="form-control" />
                </div>
                <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                    <strong>Course Semester/Trimister<span style="color: red">*</span></strong>
                    <asp:DropDownList runat="server" ID="coursesemester" CssClass="form-control" AppendDataBoundItems="true">
                        <asp:ListItem>--Select--</asp:ListItem>
                        <asp:ListItem Value="1">1</asp:ListItem>
                        <asp:ListItem Value="2">2</asp:ListItem>
                        <asp:ListItem Value="3">3</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                    <strong>Course Category<span style="color:red">*</span></strong>
                    <asp:DropDownList runat="server" ID="courseCategory" CssClass="form-control" />
                </div>
                <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                    <strong>Requires Prerequisite?<span style="color:red">*</span><i>Check if course has Prerequisite</i></strong>
                    <asp:CheckBox runat="server" ID="requiresPrerequisites" CssClass="form-control" AutoPostBack="true" OnCheckedChanged="requiresPrerequisites_CheckedChanged"/>
                </div>
                <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group" runat="server" visible="false" id="divPrerequisites">
                    <strong>Prerequisite<span style="color:red">*</span></strong>
                    <asp:DropDownList runat="server" ID="prerequisitie" CssClass="form-control" AppendDataBoundItems="true">
                        <asp:ListItem>--Select--</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                    <strong>Course Content<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" ID="coursecontent" CssClass="form-control" placeholder="Course Content" TextMode="MultiLine" />

                </div>
                <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                    <strong>Instructional Materials and/or Equipment<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" ID="instructions" CssClass="form-control" placeholder="Instructional Materials and/or Equipment" TextMode="MultiLine" />
                </div>

                <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                    <strong>Course Assessment<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" ID="courseassemnt" CssClass="form-control" placeholder="Course Assessment" TextMode="MultiLine" />

                </div>
                <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                    <strong>Learning Outcome One<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" ID="courselearningoutcome" CssClass="form-control" placeholder="Learning Outcome One" TextMode="MultiLine"  />
                </div>
                <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                    <strong>Learning Outcome Two<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" ID="LO2" CssClass="form-control" placeholder="Learning Outcome Two" TextMode="MultiLine" />
                </div>
                 <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                    <strong>Learning Outcome Three<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" ID="LO3" CssClass="form-control" placeholder="Learning Outcome Three" TextMode="MultiLine" />
                </div>
                <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                    <strong>Learning Outcome Four</strong>
                    <asp:TextBox runat="server" ID="LO4" CssClass="form-control" placeholder="Learning Outcome Four" TextMode="MultiLine" />
                </div>
                <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                    <strong>Learning Outcome Five</strong>
                    <asp:TextBox runat="server" ID="LO5" CssClass="form-control" placeholder="Learning Outcome Five" TextMode="MultiLine" />
                </div>
                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12 form-group">
                    <strong>Course Instructional Methods<span style="color:red">*</span></strong><i>(Please check at applicable  Course Instructional Methods)</i>
                    <div class="container">
                        <br />
                        <div class="row">
                            <fieldset class="col-sm-6">
                                <label>
                                    <asp:CheckBox runat="server" ID="discoverylearning" />
                                    <span>Discovery Learning</span>
                                </label>
                            </fieldset>
                            <fieldset class="col-sm-6">
                                <label>
                                    <asp:CheckBox runat="server" ID="problembasedlearning" />
                                    <span>Problem Based Learning</span>
                                </label>
                            </fieldset>
                            <fieldset class="col-sm-6">
                                <label>
                                    <asp:CheckBox runat="server" ID="experientiallearning" />
                                    <span>Experiential learning</span>
                                </label>
                            </fieldset>
                            <fieldset class="col-sm-6">
                                <label>
                                    <asp:CheckBox runat="server" ID="groupbasedlearning" />
                                    <span>Group-Based Learning</span>
                                </label>
                            </fieldset>
                            <fieldset class="col-sm-6">
                                <label>
                                    <asp:CheckBox runat="server" ID="leactures" />
                                    <span>Lectures</span>
                                </label>
                            </fieldset>
                            <fieldset class="col-sm-6">
                                <label>
                                    <asp:CheckBox runat="server" ID="independentstudies" />
                                    <span>Independent Studies</span>
                                </label>
                            </fieldset>
                            <fieldset class="col-sm-6">
                                <label>
                                    <asp:CheckBox runat="server" ID="pothers" onclick="ShowHideOthersDiv(this)" />
                                    <span>Others</span>
                                </label>
                            </fieldset>
                            <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group" style="display: none" id="othersinstructionalmethds">
                                <strong>Other Programme Instructional Methods:</strong>
                                <asp:TextBox runat="server" ID="otherinstructionalmethods" CssClass="form-control" placeholder="Other Programme Instructional Methods" TextMode="MultiLine" />

                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                    <br />
                    <asp:Button runat="server" ID="addCourse" CssClass="btn btn-success btn-block" Text="Add Course" OnClick="addCourse_Click" OnSelectedIndexChanged="CourseUnits_SelectedIndexChanged" AutoPostBack="True" />
                </div>
            </div>
            <br />
            <hr />
            <br />
            <table class="table table-bordered table-striped dataTable">
                <thead>
                    <tr>
                        <th>Course Code</th>
                        <th>Course Title</th>
                        <th>Credit Hours</th>
                        <th>Year Code</th>                        
                        <th>Course Category</th>
                        <th>Learning Outcome One</th>
                        <th>Learning Outcome Two</th>
                        <th>Learning Outcome Three</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        string AllData = new Config().ObjNav().FnGetProgramUnits2(accreditationNo);
                        String[] info = AllData.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                        if (info != null)
                        {
                            foreach (var allInfo in info)
                            {
                                String[] arr = allInfo.Split('*');
                                var ncoursecontent = Regex.Replace(arr[6], @"[^0-9a-zA-Z]+", " ");
                                var ninstructionalmaterials = Regex.Replace(arr[7], @"[^0-9a-zA-Z]+", " ");
                                var ncourseassessment = Regex.Replace(arr[8], @"[^0-9a-zA-Z]+", " ");
                                %>
                                <tr>
                                    <td><%=arr[0] %></td>
                                    <td><%=arr[1] %></td>
                                    <td><%=arr[2] %></td>
                                    <td><%=arr[3] %></td>
                                    <td><%=arr[5] %></td>
                                    <td><%=arr[9] %></td>
                                    <td><%=arr[10] %></td>
                                    <td><%=arr[11] %></td>
                                    <td>
                                        <label class="btn btn-success" onclick="editUnit('<%=arr[14] %>','<%=arr[0] %>','<%=arr[1] %>','<%=arr[2] %>','<%=arr[15]%>','<%=arr[4] %>','<%=arr[23] %>','<%=ncoursecontent %>','<%=ninstructionalmaterials %>','<%=ncourseassessment%>',
                                            '<%=arr[9]%>','<%=arr[10]%>','<%=arr[11]%>','<%=arr[12]%>','<%=arr[13]%>','<%=arr[16]%>','<%=arr[17]%>','<%=arr[18]%>','<%=arr[19]%>','<%=arr[20]%>','<%=arr[21]%>','<%=arr[22]%>')">
                                            <i class="fa fa-edit"></i>View / Edit</label></td>
                                    <td>
                                        <label class="btn btn-danger" onclick="deleteUnit('<%=arr[14] %>', '<%=arr[1] %>')"><i class="fa fa-trash"></i>Delete</label></td>
                                </tr>
                                <% 
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
        <div class="panel-footer">
            <div class="pull-left">
                <asp:Button runat="server" CssClass="btn btn-warning" Text="Previous" OnClick="previous_Click" CausesValidation="false"/>
            </div>
            <div class="pull-right">
                <asp:Button runat="server" CssClass="btn btn-success" Text="Next" OnClick="Validate_Course" CausesValidation="false"/>
            </div>
            <div class="clearfix"></div>
        </div>
        <% 
            }
            else if (currentStep == 8)
            {
        %>
        <div class="panel panel-primary">
            <div class="panel panel-primary">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Core Course Reading Materials. (<i>Please fill in atleast 5 Core Course Reading Materials for each course</i>)<div class="pull-right"><i class="fa fa-angle-left"></i>Step 8 of <%=maxStep %> <i class="fa fa-angle-right"></i></div>
                        <div class="clearfix"></div>
                    </div>
                </div>
                <div class="panel-body">
                    <div runat="server" id="booksFeedback"></div>
                    <div class="row">
                          <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                            <strong>Course<span style="color:red">*</span></strong>
                            <asp:DropDownList runat="server" ID="bookCourse" CssClass="form-control" />
                        </div>
                        <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                            <strong>Book Title<span style="color:red">*</span></strong>
                            <asp:TextBox runat="server" ID="bookTitle" CssClass="form-control" placeholder="Book Title" />
                        </div>
                        <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                            <strong>Authors:<span style="color:red">*</span></strong>
                            <asp:TextBox runat="server" ID="bookAuthors" CssClass="form-control" placeholder="Authors" TextMode="MultiLine" />
                        </div>
                        <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                            <strong>Year of Publication<span style="color:red">*</span></strong>
                            <asp:TextBox runat="server" ID="bookYearofPublication" CssClass="form-control" TextMode="Number" placeholder="Year of Publication" />
                        </div>
                        <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                            <strong>Publishers:<span style="color:red">*</span></strong>
                            <asp:TextBox runat="server" ID="bookPublishers" CssClass="form-control" placeholder="Publishers" />
                        </div>
                        <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                            <strong>Print</strong>
                            <asp:CheckBox runat="server" ID="bookPrint" CssClass="form-control" />
                        </div>
                        <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                            <strong>Electronic</strong>
                            <asp:CheckBox runat="server" ID="bookElectronic" CssClass="form-control" onclick="ShowURL(this)" />
                        </div>
                        <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group" style="display: none" id="dvShowElectronicUrl">
                            <strong>Online Access Link<span style="color:red">*</span></strong>
                            <asp:TextBox runat="server" ID="bookURL" CssClass="form-control" placeholder="URL" />
                        </div>
                        <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                            <br />
                            <asp:Button runat="server" ID="addBook" CssClass="btn btn-success btn-block" Text="Add Reading Material" OnClick="addBook_Click" />
                        </div>
                    </div>
                    <br />
                    <hr />
                    <br />
                    <table class="table table-bordered table-striped dataTable">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Book Title</th>
                                <th>Course</th>
                                <th>Year of Publication</th>
                                <th>Publishers</th>
                                <th>Print</th>
                                <th>Electronic</th>
                                <th>Edit</th>
                                <th>Delete</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% var books = nav.CourseCoreReadingMaterials.Where(r => r.Application_No == accreditationNo && r.Current_Version == true);
                                int bookscounter = 0;
                                foreach (var book in books)
                                {
                                    bookscounter++;
                            %>
                            <tr>
                                <td><%=bookscounter%></td>
                                <td><%=book.Book_Title %></td>
                                <td><%=book.Course_Title %></td>
                                <td><%=book.Year_of_Publication %></td>
                                <td><%=book.Publishers %></td>
                                <td><%=Convert.ToBoolean(book.Print)?"Yes":"No" %></td>
                                <td><%=Convert.ToBoolean(book.Electronic)?"Yes":"No" %></td>
                                <td>
                                    <label class="btn btn-success" onclick="editBook('<%=book.Book_Title %>', '<%=book.Code %>','<%=book.Course_Code %>','<%=book.Authors %>','<%=book.Year_of_Publication %>','<%=book.Publishers %>','<%=book.URL %>','<%=Convert.ToBoolean(book.Print)?"1":"0" %>','<%=Convert.ToBoolean(book.Electronic)?"1":"0" %>')"><i class="fa fa-edit"></i>Edit</label></td>
                                <td>
                                    <label class="btn btn-danger" onclick="deleteBook('<%=book.Book_Title %>', '<%=book.Code %>')"><i class="fa fa-trash"></i>Delete</label></td>
                            </tr>
                            <%  
                                } %>
                        </tbody>
                    </table>

                </div>
            </div>

            <div class="panel panel-primary">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Core Course Reference/Recommended Reading Materials. <div class="pull-right"><i class="fa fa-angle-left"></i>Step 8 of <%=maxStep %> <i class="fa fa-angle-right"></i></div>
                        <div class="clearfix"></div>
                    </div>
                </div>
                <div class="panel-body">
                    <div runat="server" id="reffeedback"></div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                            <strong>Course Code:<span style="color:red">*</span></strong>
                            <asp:DropDownList runat="server" ID="coursescodesref" CssClass="form-control"></asp:DropDownList>
                        </div>
                        <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                            <strong>Recommended Reference Materials:<span style="color:red">*</span></strong>
                            <asp:TextBox runat="server" ID="refmaterial" CssClass="form-control" placeholder="Course Content" TextMode="MultiLine" />
                        </div>
                        <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                            <br />
                            <asp:Button runat="server" ID="addrefence" CssClass="btn btn-success btn-block" Text="Add Reference Materials" OnClick="addCourseReference_Click" />
                        </div>
                    </div>
                    <br />
                    <hr />
                    <br />
                    <table class="table table-bordered table-striped dataTable">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Course Code</th>
                                <th>Reference Material</th>
                                <th>Edit</th>
                                <th>Delete</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                var course = nav.CourseReferenceMaterial.Where(r => r.Application_No == accreditationNo && r.Current_Version == true);
                                int counters = 0;
                                string refCounter = "";
                                string Universities = Convert.ToString(Session["UniversityCode"]);
                                string tdescriptions = "";
                                foreach (var unit in course)
                                {
                                    counters++;
                                    refCounter = unit.Course_Code;
                                    var descriptions = new Config().ObjNav().FngetReferenceMaterial(accreditationNo, Universities, refCounter);
                                    tdescriptions = Regex.Replace(descriptions, @"[^0-9a-zA-Z]+", " ");

                            %>
                            <tr>
                                <td><%=counters%></td>
                                <td><%=unit.Course_Code %></td>
                                <td><%=descriptions %></td>
                                <td>
                                    <label class="btn btn-success" onclick="editReference('<%=unit.Code %>','<%=tdescriptions%>')"><i class="fa fa-edit"></i>Edit</label></td>
                                <td>
                                    <label class="btn btn-danger" onclick="deleteReference('<%=unit.Code %>')"><i class="fa fa-trash"></i>Delete</label></td>

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
                    <asp:Button runat="server" CssClass="btn btn-warning" Text="Previous" OnClick="previous_Click" CausesValidation="false"/>
                </div>
                <div class="pull-right">
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Next" OnClick="Validate_ReadingMaterials" CausesValidation="false"/>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
    <%
        }
        else if (currentStep == 9)
        {
    %>
    <div class="panel panel-primary">
        <div class="panel panel-default">
            <div class="panel-heading">
                Programme Learning Outcomes and Course Matrix<div class="pull-right"><i class="fa fa-angle-left"></i>Step 9 of <%=maxStep %> <i class="fa fa-angle-right"></i></div>
                <div class="clearfix"></div>
                <strong><i>Indicate the​ courses that are covered by each expected learning outcome of the programme and specialization areas​</i></strong>
            </div>
        </div>
        <div class="panel-body">
            <div runat="server" id="coloFeedback"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                    <strong>Programme Learning Outcomes<span style="color:red">*</span></strong>
                    <asp:DropDownList runat="server" ID="coloOutcome" CssClass="form-control" />
                </div>
                <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                    <strong>Course Title<span style="color:red">*</span></strong>
                    <asp:DropDownList runat="server" ID="coloCourse" CssClass="form-control" />
                </div>
                <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                    <br />
                    <asp:Button runat="server" ID="addColo" CssClass="btn btn-success btn-block" Text="Add Course Learning Outcome" OnClick="addColo_Click" />
                </div>
            </div>
            <br />
            <hr />
            <br />
            <table class="table table-bordered table-striped dataTable">
                <thead>
                    <tr>
                        <th>Programme Learning Outcome</th>
                        <th>Course Code</th>
                        <th>Course Title</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var outcomes = nav.CourseLearningOutcome.Where(r => r.Application_No == accreditationNo && r.Current_Version == true);
                        foreach (var outcome in outcomes)
                        {
                    %>
                    <tr>
                        <td><%=outcome.Learning_Outcome_Description %></td>
                        <td><%=outcome.Course_Unit %></td>
                        <td><%=outcome.Course_Description %></td>
                        <td>
                            <label class="btn btn-success" onclick="editColo('<%=outcome.Course_Unit %>', '<%=outcome.Learning_Outcome %>', '<%=outcome.Code %>')"><i class="fa fa-edit"></i>Edit</label></td>
                        <td>
                            <label class="btn btn-danger" onclick="deleteColo('<%=outcome.Code %>')"><i class="fa fa-trash"></i>Delete</label></td>

                    </tr>
                    <%
                        } %>
                </tbody>
            </table>
        </div>
        <div class="panel-footer">
            <div class="pull-left">
                <asp:Button runat="server" CssClass="btn btn-warning" Text="Previous" OnClick="previous_Click" CausesValidation="false"/>
            </div>
            <div class="pull-right">
                <asp:Button runat="server" CssClass="btn btn-success" Text="Next" OnClick="ValidateCourse_LearningOutcome" CausesValidation="false"/>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
   <%
        }
        else if (currentStep == 10)
        {
    %>
    <div class="panel panel-primary">
        <div class="panel panel-default">
            <div class="panel-heading">
                Classfication of Degrees<div class="pull-right"><i class="fa fa-angle-left"></i>Step 10 of <%=maxStep %> <i class="fa fa-angle-right"></i></div>
                <div class="clearfix"></div>
            </div>
        </div>
        <div class="panel-body">
            <div id="classificationsFeedback" runat="server"></div>
            <div class="row">
                <div class="col-md-4 col-lg-4 col-sm-6 col-xs-12 form-group">
                    <strong>Classification:<span style="color:red">*</span></strong>
                    <asp:DropDownList runat="server" ID="txtclassifications" CssClass="form-control"/>
                </div>
                 <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                    <strong>Grade Point Average:<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" ID="gradepointsaverage" CssClass="form-control" placeholder="Grade Point Average" value="0" DisplayFormatString="00.00" onkeyup="checkTB(this.value)" />
                </div>
                 <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                    <strong>Percentage Level:<span style="color:red">*</span></strong>
                    <asp:TextBox runat="server" ID="percentagelevel" CssClass="form-control" placeholder="Percentage Level" value="0" DisplayFormatString="00.00" onkeyup="checkTB(this.value)" />
                </div>
                <div class="col-md-4 col-lg-4 col-sm-12 col-xs-12 form-group">
                    <br />
                    <asp:Button runat="server" ID="Button1" CssClass="btn btn-success" Text="Add Classification" OnClick="Degrees_ClassificationsClick" />
                </div>
            </div>
            <br />
            <hr />
            <br />
            <table class="table table-bordered table-striped dataTable">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Classification</th>
                        <th>Grade Point Average</th>
                        <th>Percentage Level</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        var modes = nav.ClassificationofDegrees.Where(r => r.Accreditation_Number == accreditationNo&& r.Current_Version==true);
                        int classificationCounter = 0;
                        foreach (var mode in modes)
                        {
                            classificationCounter++;
                    %>
                    <tr>
                        <td><%=classificationCounter%></td>
                        <td><%=mode.Classifications %></td>
                        <td><%= Convert.ToDecimal(mode.Grade_Point_Average).ToString("0.00") %></td>
                        <td><%=mode.Percentage_Level %></td>
                        <th> <label class="btn btn-success" onclick="editClassificatioDegrees('<%=mode.Entry_No %>', '<%=mode.Classifications %>', '<%=mode.Grade_Point_Average %>', '<%=mode.Percentage_Level %>')"><i class="fa fa-pencil"></i>Edit</label></th>
                        <th> <label class="btn btn-danger" onclick="deleteClassification('<%=mode.Entry_No %>', '<%=mode.Classifications %>')"><i class="fa fa-trash"></i>Delete</label></th>
                    </tr>
                    <%
                        } %>
                </tbody>
            </table>
        </div>
        <div class="panel-footer">
            <div class="pull-left">
                <asp:Button runat="server" CssClass="btn btn-warning" Text="Previous" OnClick="previous_Click" CausesValidation="false"/></div>
            <div class="pull-right">
                <asp:Button runat="server" CssClass="btn btn-success" Text="Next" OnClick="next_Click" CausesValidation="false"/></div>
            <div class="clearfix"></div>
        </div>
    </div>
    <%
        }
        else if (currentStep == 11)
        {
    %>
    <div class="panel panel-primary">
        <div class="form-group">
            <hr />
            <div runat="server" id="feedback"></div>
            <asp:Literal ID="ltEmbed" runat="server" />
        </div>
        <div class="panel panel-default">
            <div class="panel-heading">
                Appendices  (Under appendices,the following file formats are allowed:Pdf)<div class="pull-right"><i class="fa fa-angle-left"></i>Step 11 of <%= maxStep %> <i class="fa fa-angle-right"></i></div>
                <div class="clearfix"></div>

            </div>
        </div>
        <div class="panel-body">
            <h3 style="color:red"><strong>Kindly make sure you Preview / Print Programme to ensure all the fields have been saved before submitting to CUE to avoid Re-Submissions</strong></h3>
            <asp:Button runat="server" CssClass="btn btn-info pull-right" Text="Preview / Print Programme" OnClick="Unnamed_Click" CausesValidation="false"/>
            <br />
            <br />
            <div runat="server" id="documentsFeedback"></div>
            <div class="form-group">
                <strong>Appendix I:Need Assesment Report<span style="color:red">*</span></strong>
                <asp:FileUpload runat="server" ID="needassesmentreport" CssClass="form-control" Style="padding-top: 0px;" />
                 <asp:RequiredFieldValidator runat="server" ID="validatordescription" ControlToValidate="needassesmentreport" ErrorMessage="Please attach Appendix I:Need Assesment Report" ForeColor="Red" />
            </div>
            <div class="form-group">
                <strong>Appendix II:Facilities<span style="color:red">*</span></strong>
                <asp:FileUpload runat="server" ID="facilities" CssClass="form-control" Style="padding-top: 0px;" />
                 <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="facilities" ErrorMessage="Please attach Appendix II:Facilities" ForeColor="Red" />
            </div>
            <div class="form-group">
                <strong>Appendix III: Equipment and Teaching Materials<span style="color:red">*</span></strong>
                <asp:FileUpload runat="server" ID="equipment" CssClass="form-control" Style="padding-top: 0px;" />
                 <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="equipment" ErrorMessage="Please attach Appendix III: Equipment and Teaching Materials" ForeColor="Red" />
            </div>
            <div class="form-group">
                <strong>Appendix IV: Core-Texts and Journals<span style="color:red">*</span></strong>
                <asp:FileUpload runat="server" ID="coretext" CssClass="form-control" Style="padding-top: 0px;" />
                 <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="coretext" ErrorMessage="Please attach Appendix IV: Core-Texts and Journals" ForeColor="Red" />
            </div>
            <div class="form-group">
                <strong>Appendix V: Academic Staff<span style="color:red">*</span></strong>
                <asp:FileUpload runat="server" ID="academicstaff" CssClass="form-control" Style="padding-top: 0px;" />
                 <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ControlToValidate="academicstaff" ErrorMessage="Please attach Appendix V: Academic Staff" ForeColor="Red" />
            </div>
            <div class="form-group">
                <strong>Appendix VI: Relevant Support Staff:<span style="color:red">*</span></strong>
                <asp:FileUpload runat="server" ID="supportstaff" CssClass="form-control" Style="padding-top: 0px;" />
                 <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator5" ControlToValidate="supportstaff" ErrorMessage="Please attach Appendix VI: Relevant Support Staff" ForeColor="Red" />
            </div>
            <div class="form-group">
                <strong>Appendix VII: University Policy on Curriculum Development<span style="color:red">*</span></strong>
                <asp:FileUpload runat="server" ID="universitypolicy" CssClass="form-control" Style="padding-top: 0px;" />
                 <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator6" ControlToValidate="universitypolicy" ErrorMessage="Please attach Appendix VII: University Policy on Curriculum Development" ForeColor="Red" />
            </div>
            <div class="form-group">
                <strong>Appendix VIII: Senate Approval<span style="color:red">*</span></strong>
                <asp:FileUpload runat="server" ID="sennateapproval" CssClass="form-control" Style="padding-top: 0px;" />
                 <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator7" ControlToValidate="sennateapproval" ErrorMessage="Please attach Appendix VIII: Senate Approval" ForeColor="Red" />
            </div>
            <div class="form-group">
                <strong>Appendix IX:Require Evidence of Professional Body?</strong>
                      <asp:CheckBox runat="server" ID="myCheck" CssClass="form-control" onclick="myFunction(this)" />
            </div>
            <div id="proffessionalbody" class="form-group" style="display: none">
                <strong>Appendix X: Attach Evidence of Clearence of Professional Body:<span style="color:red">*</span></strong>
                <asp:FileUpload runat="server" ID="evidence" CssClass="form-control" Style="padding-top: 0px;" />
            </div>
        </div>
        <div class="panel-footer">
            <center> <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Appendices" ID="saveApplication" OnClick="saveApplication_Click" /></center>
        </div>
        <div class="panel panel-primary">
        <div class="panel-heading">
            All uploaded appendices
        </div>
        <div class="panel-body">
            <div runat="server" id="Div2"></div>
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Document Title</th>
                        <th>Download</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try
                        {
                            String fileFolderApplication = ConfigurationManager.AppSettings["FileFolderApplication"];
                            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Awaiting Completeness Card/";
                            String imprestNo = accreditationNo;
                            //imprestNo = imprestNo.Replace('/', '_');
                            //imprestNo = imprestNo.Replace(':', '_');
                            String documentDirectory = filesFolder + imprestNo + "/";
                            if (Directory.Exists(documentDirectory))
                            {
                                foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                {
                                    String url = documentDirectory;
                    %>
                    <tr>
                        <td><% =file.Replace(documentDirectory, "") %></td>
                       <td><a href="DownLoadProgramAppendix.aspx?applicationNo=<%=imprestNo %>&&fileName=<%=file.Replace(documentDirectory, "") %>" class="btn btn-success">Download</a></td>
                        <td>
                            <label class="btn btn-danger" onclick="deleteFile('<%=file.Replace(documentDirectory, "")%>');"><i class="fa fa-trash-o"></i>Delete</label></td>
                    </tr>
                    <%
                                }
                            }
                        }
                        catch (Exception)
                        {

                        }%>
                </tbody>
            </table>
        </div>

    </div>
        <div class="panel-footer">
            <div class="pull-left">
                <asp:Button runat="server" CssClass="btn btn-warning" Text="Previous" OnClick="previous_Click" CausesValidation="false"/>
            </div>

            <div class="pull-right">

                <asp:Button runat="server" CssClass="btn btn-success" Text="Submit to CUE" Style="margin-left: 30px;" OnClick="SendCUE_Click" CausesValidation="false"/>
            </div>
            <div class="clearfix">
            </div>
        </div>
    </div>

    <% } %>
    <script>
        $(document).ready(function () {
            $('.dataTable').DataTable({
                responsive: true
            });
        });
    </script>
    <script type="text/javascript">
        //OnClientClick="return functionConfirm();"
        function functionConfirm() {
            event.preventDefault();
            swal({
                title: "Are you sure to Submit?",
                text: "You will not be able to recover this details once you submit!",
                type: "warning",
                showCancelButton: true,
                confirmButtonClass: "btn-danger",
                confirmButtonText: "Yes, Submit to CUE!",
                cancelButtonText: "No, Cancel!",
                closeOnConfirm: false,
                closeOnCancel: false
            },
           function (isConfirm) {
               if (isConfirm) {
                   swal("Submitted!", "Your Programme Accreditation has been sucssefully submitted to CUE", "success");
                   window.location.href = "ProgramAccreditation.aspx";
               } else {
                   swal("Cancelled", "Your accreditation submission details has been cancelled :)", "error");
               }
           });
        }
    </script>
    <script>
        function editBook(bookTitle, bookCode, course, authors, yearOfPublication, publishers, url, print, electronic)
        {
            document.getElementById("MainContent_editBookCode").value = bookCode;
            document.getElementById("MainContent_editBookTitle").value = bookTitle;
            document.getElementById("MainContent_editBookCourse").value = course;
            document.getElementById("MainContent_editBookAuthors").value = authors;
            document.getElementById("MainContent_editBookPublicationYear").value = yearOfPublication;
            document.getElementById("MainContent_editBookPublishers").value = publishers;
            document.getElementById("MainContent_editBookURL").value = url;
            if (print == "1") {
                document.getElementById("MainContent_editBookPrint").checked = true;
            } if (electronic == "1") {
                document.getElementById("MainContent_editBookElectronic").checked = true;
            }
            $("#editBookModal").modal();
        }
        function deleteBook(bookTitle, bookCode) {
            document.getElementById("deleteBookTitle").innerText = bookTitle;
            document.getElementById("MainContent_deleteBookCode").value = bookCode;
            $("#deleteBookModal").modal();
        }
        function deleteClassification(entry, Classification) {
            document.getElementById("deleteclassificationcategory").innerText = Classification;
            document.getElementById("MainContent_deleteclassification").value = entry;
            $("#deleteClassificationsModal").modal();
        }
        function deleteColo(code) {
            document.getElementById("MainContent_deletecoloCode").value = code;
            $("#deletecoloModal").modal();
        }
        function editColo(unitCode, outComeCode, code) {
            document.getElementById("MainContent_editColoOutcome").value = outComeCode;
            document.getElementById("MainContent_editColoUnit").value = unitCode;
            document.getElementById("MainContent_editColoCode").value = code;
            $("#editcoloModal").modal();
        }
        //   AllUnits:=AllUnits+coursecode0+'*'+coursetitle1+'*'+credithours2+'*'+yearcode3+'*'+coursesem4+'*'+coursecategory5+'*'+coursecontent6+'*'+instructionalmaterials7+'*'+courseassessment8
        // +'*'+lo19+'*'+lo210+'*'+lo311+'*'+lo412+'*'+lo513+'*'+FORMAT(ProgrammeCourseMatrix.Code)14+'::::';

        function editUnit(code, courseCode, courseTitle, creditHours, yearCode, coursesem, coursecategory, cousecontent, coursematerial, courseassessment, LO1, LO2, LO3, LO4, LO5, discovery, experimental, lectures, problembased, groupbased, independent, others) {
            document.getElementById("MainContent_editUnitCode").value = code;
            document.getElementById("MainContent_editCourseCode").value = courseCode;
            document.getElementById("MainContent_editCourseTitle").value = courseTitle;
            document.getElementById("MainContent_editCourseCreditHours").value = creditHours;
            document.getElementById("MainContent_editCourseYearCode").value = yearCode;
            document.getElementById("MainContent_editCoursesem").value = coursesem;
            document.getElementById("MainContent_editCourseCategory").value = coursecategory;
            document.getElementById("MainContent_editCourseContent").value = cousecontent;
            document.getElementById("MainContent_editCourseMaterial").value = coursematerial;
            document.getElementById("MainContent_editCourseAssessment").value = courseassessment;
            document.getElementById("MainContent_editLO1").value = LO1;
            document.getElementById("MainContent_editLO2").value = LO2;
            document.getElementById("MainContent_editLO3").value = LO3;
            document.getElementById("MainContent_editLO4").value = LO4;
            document.getElementById("MainContent_editLO5").value = LO5;
            if (discovery == "Yes") {
                document.getElementById("MainContent_editdiscoverylearning").checked = true;
            }
            if (experimental == "Yes") {
                document.getElementById("MainContent_editexperientallearning").checked = true;
            }
            if (lectures == "Yes") {
                document.getElementById("MainContent_editlectures").checked = true;
            }
            if (problembased == "Yes") {
                document.getElementById("MainContent_editproblembased").checked = true;
            }
            if (groupbased == "Yes") {
                document.getElementById("MainContent_editgroupbasedlearning").checked = true;
            }
            if (independent == "Yes") {
                document.getElementById("MainContent_editindependentstudies").checked = true;
            }
            if (others == "Yes") {
                document.getElementById("MainContent_editcheckothers").checked = true;
            }
            $("#editCourseUnitModal").modal();
        }
        
        function editClassificatioDegrees(Entry_No, Classifications, Grade_Point_Average, Percentage_Level) {
            document.getElementById("MainContent_entryNumber").value = Entry_No;
            document.getElementById("MainContent_editclassification").value = Classifications;
            document.getElementById("MainContent_editgradepoints").value = Grade_Point_Average;
            document.getElementById("MainContent_editpercentagelevel").value = Percentage_Level;
            $("#editClassificationModal").modal();
        } 
        function editReference(code, title) {
            document.getElementById("MainContent_refcode").value = code;
            document.getElementById("MainContent_reftitle").value = title;
            $("#editRefModal").modal();
        }
        function deleteUnit(code, title) {
            document.getElementById("deleteUnitDescription").innerText = title;
            document.getElementById("MainContent_deleteUnitCode").value = code;
            $("#deleteCourseUnitModal").modal();
        }
        function deleteReference(code) {
            document.getElementById("MainContent_referencecode").value = code;
            $("#deleteCourseReferenceModal").modal();
        }

        function editGradingSystem(code, gradeCode, gpa, maxpercentage, minpaercentage) {
            document.getElementById("MainContent_editGradeCode").value = code;
            document.getElementById("MainContent_editGradeGradeCode").value = gradeCode;
            document.getElementById("MainContent_editmaximumpercentage").value = maxpercentage;
            document.getElementById("MainContent_editminimumpercentage").value = minpaercentage;
            $("#editGradingSystemModal").modal();
        }
        function deleteGradingSystem(code, gradeCode) {
            document.getElementById("deleteGradingSystemDescription").innerText = gradeCode;
            document.getElementById("MainContent_deleteGradeCode").value = code;
            $("#deleteGradingSystemModal").modal();
        }
        function removeDeliveryMode(mode, name) {
            document.getElementById("deleteDeliveryModeName").innerText = name;
            document.getElementById("MainContent_removeDeliveryMode").value = mode;
            $("#removeDeliveryModeModal").modal();
        }
        function removespecialization(mode, name) {
            document.getElementById("editspecializationDescription").innerText = name;
            document.getElementById("MainContent_deleteSpecializationCode").value = mode;
            $("#deleteSpecializationModal").modal();
        }
        function deleteRationale(code, category) {
            document.getElementById("MainContent_deleteRationaleCode").value = code;
            document.getElementById("deleteRationalecategory").innerText = category
            $("#deleteRationaleModal").modal();
        }
        function editRationale(category, description, code) {
            document.getElementById("MainContent_editRationaleCode").value = code;
            document.getElementById("MainContent_editProgramRationaleCategory").value = category;
            document.getElementById("MainContent_editProgramRationaleDescription").value = description;
            $("#editRationaleModal").modal();
        }
        function deleteLearningOutcome(codes, outcomenum) {
            document.getElementById("MainContent_deleteLearningOutcomeCode").value = codes;
            document.getElementById("outLearningOutcomeNo").innerText = outcomenum;
            $("#deleteLearningOutcomeModal").modal();
        }
        function editLearningOutcome(number, tdescription) {
            document.getElementById("MainContent_editLearningOutcomecode").value = number;
            document.getElementById("MainContent_editLearningOutcomedescription").value = tdescription;
            $("#editLearningOutcomeModal").modal();
        }
        function editspecializationsfunction(code, area, description) {
            document.getElementById("MainContent_editspecializationcode").value = code;
            document.getElementById("MainContent_editspecializationarea").value = area;
            document.getElementById("MainContent_editspecializationdescription").value = description;
            $("#editLearningSpecializationModal").modal();
        }
        function removeInstructionalMethod(mode, name) {
            document.getElementById("deleteInstructionalMethodName").innerText = name;
            document.getElementById("MainContent_editInstructionalMethodCode").value = mode;
            $("#removeInstructionalMethodModal").modal();
        }
        function editGeneralDetailsNewVersion(mode, name) {
            document.getElementById("progname").innerText = name;
            document.getElementById("MainContent_txtprogramID").value = mode;
            $("#editGeneralDetailsNewVersionModal").modal();
        }

        function deleteFile(fileName) {
            document.getElementById("filetoDeleteName").innerText = fileName;
            document.getElementById("MainContent_fileName").value = fileName;
            $("#deleteFileModal").modal();
        }

        function editGeneralDetails(accnum, campname, domain, level, duration, title, credithour, courseunits, phylosopi, admissiondescr, goaldescr, requiredescr, examsdescri, graduationdescr, thesisdescr, managedescr, moderedesc, studentpolicy, specialization) {
            document.getElementById("MainContent_accreditationnumber").value = accnum;
            document.getElementById("MainContent_campusname").value = campname;
            document.getElementById("MainContent_editdomain").value = domain;
            document.getElementById("MainContent_editlevel").value = level;
            document.getElementById("MainContent_editduration").value = duration;
            document.getElementById("MainContent_edittitle").value = title;
            document.getElementById("MainContent_editcredithours").value = credithour;
            document.getElementById("MainContent_edittotalcourse").value = courseunits;
            document.getElementById("MainContent_editphilosophy").value = phylosopi;
            document.getElementById("MainContent_editadmission").value = admissiondescr;
            document.getElementById("MainContent_editgoal").value = goaldescr;
            document.getElementById("MainContent_editrequlations").value = requiredescr;
            document.getElementById("MainContent_editexaminations").value = examsdescri;
            document.getElementById("MainContent_editgraduation").value = graduationdescr;
            document.getElementById("MainContent_editdescription").value = thesisdescr;
            document.getElementById("MainContent_editmanagement").value = managedescr;
            document.getElementById("MainContent_editmoderations").value = moderedesc;
            if (studentpolicy == "Continuous Assessment Tests") {
                document.getElementById("MainContent_editcats").checked = true;
            }
            else if (studentpolicy == "End-Trimester/Quarter/Semester") {
                document.getElementById("MainContent_editsemester").checked = true;
            }
            else if (studentpolicy == "Practicals") {
                document.getElementById("MainContent_editpracticals").checked = true;
            }
            else if (studentpolicy == "Other Assessments") {
                document.getElementById("MainContent_ editotherassessments").checked = true;
            }
            if (specialization = true) {
                document.getElementById("MainContent_editspecializationareas").checked = false;

            } else {
                document.getElementById("MainContent_editspecializationareas").checked = false;
            }
            $("#editGeneralDetailsModal").modal();
        }
    </script>
    <div id="editGeneralDetailsModal" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit General Details</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="modal-body">
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <strong>Accreditation Number:</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="accreditationnumber" placeholder="Programme Accreditation Number" />
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <strong>Campus Name:</strong>
                                    <asp:DropDownList runat="server" CssClass="form-control" ID="campusname" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="modal-body">
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <strong>Programme Title:</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="edittitle" placeholder="Programme Title" TextMode="MultiLine" />
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <strong>Programme Duration:</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="editduration" placeholder="Programme Duration" TextMode="MultiLine" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="modal-body">
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <strong>Philosophy of the Programme:</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="editphilosophy" placeholder="Programme Philosophy" TextMode="MultiLine" />
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <strong>Programme Domain:</strong>
                                    <asp:DropDownList runat="server" CssClass="form-control" ID="editdomain" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="modal-body">
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <strong>Total Credit Hours:</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="editcredithours" placeholder="Total Credit Hours" />
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <strong>Programme Level:</strong>
                                    <asp:DropDownList runat="server" CssClass="form-control" ID="editlevel" AppendDataBoundItems="true">
                                        <asp:ListItem></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="modal-body">
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <strong>Total Course Units:</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="edittotalcourse" placeholder="Programme Total Course Units" />
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <strong>Admission Requirements for the Proposed Programme:</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="editadmission" placeholder="Admission Requirements for the Proposed Programme" TextMode="MultiLine" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="modal-body">
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <strong>Goal of the Programme:</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="editgoal" placeholder="Programme Goal of the Programme" TextMode="MultiLine" />
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <strong>Regulations on Credit Transfer in a programme:</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="editrequlations" placeholder="Programme Regulations on Credit Transfer in a programme" TextMode="MultiLine" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="modal-body">
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <strong>Examination Regulations:</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="editexaminations" placeholder="Programme Examination Regulations" TextMode="MultiLine" />
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6" style="display:none">
                                <div class="form-group">
                                    <strong>Graduation Requirements:</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="editgraduation" placeholder="Programme Graduation Requirements" TextMode="MultiLine" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="modal-body">
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <strong>Description of Thesis/Dissertation/Project (As applicable):</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="editdescription" placeholder="Programme Description of Thesis/Dissertation/Project" TextMode="MultiLine" />
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <strong>Management and Administration of the Programme:</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="editmanagement" placeholder="Programme Rationale Description" TextMode="MultiLine" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="modal-body">
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <strong>Moderation of Examinations:</strong>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="editmoderations" placeholder="Programme Moderation of Examinations" TextMode="MultiLine" />
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6">
                                <strong>Programme Specialization Areas</strong><br />
                                <i>(Please Check if the Programme  has Specialization Areas)</i>
                                <asp:CheckBox runat="server" ID="editspecializationareas" CssClass="form-control" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="modal-body">
                            <div class="container">
                                <div class="col-md-6 col-lg-6">
                                    <strong>Student Assessment Policy/Criteria</strong>
                                </div>
                                <div class="container">
                                    <div class="row">
                                        <fieldset class="col-sm-6">
                                            <label>
                                                <asp:CheckBox runat="server" ID="editcats" />
                                                <span>Continuous Assessment Tests (CATs)</span>
                                            </label>
                                        </fieldset>
                                        <fieldset class="col-sm-6">
                                            <label>
                                                <asp:CheckBox runat="server" ID="editsemester" />
                                                <span>End-Trimester/Quarter/Semester</span>
                                            </label>
                                        </fieldset>
                                        <fieldset class="col-sm-6">
                                            <label>
                                                <asp:CheckBox runat="server" ID="editpracticals" />
                                                <span>Practicals</span>
                                            </label>
                                        </fieldset>
                                        <fieldset class="col-sm-6">
                                            <label>
                                                <asp:CheckBox runat="server" ID="editotherassessments" />
                                                <span>Other Assessments</span>
                                            </label>
                                        </fieldset>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Update General Details" ID="Button2" OnClick="editGeneralDetailsProgramme_Click" CausesValidation="false"/>
                </div>
            </div>

        </div>
    </div>
    <div id="deleteRationaleModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting Programme Rationale</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the Programme rationale?<strong id="deleteRationalecategory"></strong>?</p>
                    <asp:TextBox runat="server" ID="deleteRationaleCode" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Programme Rationale" ID="deleteProgramRationale" OnClick="deleteProgramRationale_Click" CausesValidation="false"/>
                </div>
            </div>

        </div>
    </div>

  <div id="deleteClassificationsModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting Classification</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the Classification?<strong id="deleteclassificationcategory"></strong>?</p>
                    <asp:TextBox runat="server" ID="deleteclassification" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Classsification" ID="Button5" OnClick="deleteClassification_Click" CausesValidation="false"/>
                </div>
            </div>
        </div>
    </div>

    <div id="deleteSpecializationModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting Specialization Area</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the Specialization Area <strong id="editspecializationDescription"></strong>in the category <strong id="editspecializationCode"></strong>?</p>
                    <asp:TextBox runat="server" ID="deleteSpecializationCode" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Speciaization" ID="editSpecialization" OnClick="deleteSpecializationArea_Click" CausesValidation="false"/>
                </div>
            </div>

        </div>
    </div>
    <div id="editRationaleModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Update Programme Rationale</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="editRationaleCode" type="hidden" />
                    <div class="form-group">
                        <strong>Category:</strong>
                        <asp:DropDownList runat="server" CssClass="form-control" ID="editProgramRationaleCategory" />
                    </div>
                    <div class="form-group">
                        <strong>Programme Rationale Description:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="editProgramRationaleDescription" placeholder="Programme Rationale Description" TextMode="MultiLine" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Update Programme Rationale" ID="editProgramRationale" OnClick="editProgramRationale_Click" CausesValidation="false" />
                </div>
            </div>

        </div>
    </div>

    <div id="deleteLearningOutcomeModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting Learning Outcome</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the learning outcome <strong id="outLearningOutcomeNo"></strong>?</p>
                    <asp:TextBox runat="server" ID="deleteLearningOutcomeCode" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Learning Outcome" ID="deleteLearningOutcome1" OnClick="deleteLearningOutcome_Click" CausesValidation="false"/>
                </div>
            </div>
        </div>
    </div>
    <div id="editClassificationModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Update Classification of Degrees</h4>
                </div>
                <div id="Div1" runat="server"></div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="entryNumber" type="hidden" />
                    <div class="form-group">
                        <strong>Classification :</strong>
                        <asp:DropDownList runat="server" CssClass="form-control" ID="editclassification" placeholder="Classification" />
                    </div>
                    <div class="form-group">
                        <strong>Grade Point Average:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="editgradepoints" placeholder="Grade Point Average"  TextMode="Number"/>
                    </div>
                     <div class="form-group">
                        <strong>Percentage Level:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="editpercentagelevel" placeholder="Percentage Level"  TextMode="Number"/>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Update Classifications" ID="Button6" OnClick="editClassification_Click" CausesValidation="false"/>
                </div>
            </div>

        </div>
    </div>
    <div id="editLearningSpecializationModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Update Specialization Area</h4>
                </div>
                <div id="EditFeedback1" runat="server"></div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="editspecializationcode" type="hidden" />
                    <div class="form-group">
                        <strong>Specialization Area:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="editspecializationarea" placeholder="Specialization Area" />
                    </div>
                    <div class="form-group">
                        <strong>Specialization Description:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="editspecializationdescription" placeholder="Specialization Description" TextMode="MultiLine" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Update Specialization" ID="editspecializations" OnClick="editSpecialization_Click" CausesValidation="false"/>
                </div>
            </div>

        </div>
    </div>
    <div id="editLearningOutcomeModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Update Programme Rationale</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="editLearningOutcomecode" type="hidden" />
                    <div class="form-group">
                        <strong>Outcome Description:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="editLearningOutcomedescription" placeholder="Outcome Description" TextMode="MultiLine" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Update Learning Outcomee" ID="editLearningOutcome1" OnClick="editLearningOutcome_Click" CausesValidation="false"/>
                </div>
            </div>
        </div>
    </div>
    <div id="removeDeliveryModeModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting Delivery Mode</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove the delivery mode <strong id="deleteDeliveryModeName"></strong>?</p>
                    <asp:TextBox runat="server" ID="removeDeliveryMode" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Delivery Mode" ID="deleteDeliveryMode" OnClick="deleteDeliveryMode_Click" CausesValidation="false"/>
                </div>
            </div>
        </div>
    </div>
    <div id="deleteGradingSystemModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting Grade</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the Grade <strong id="deleteGradingSystemDescription"></strong>?</p>
                    <asp:TextBox runat="server" ID="deleteGradeCode" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Grade" ID="deleteGrade" OnClick="deleteGrade_Click" CausesValidation="false"/>
                </div>
            </div>
        </div>
    </div>
    <div id="editGradingSystemModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Update Grade</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="editGradeCode" type="hidden" />
                    <div class="form-group">
                        <strong>Grade Code:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="editGradeGradeCode" placeholder="Grade Code" />
                    </div>
                    <%--  <div class="form-group">
                          <strong>Minimum:</strong>
                          <asp:TextBox runat="server" CssClass="form-control" ID="editGradeMinimum" placeholder="Minimum"/>
                      </div> 
                      <div class="form-group">
                          <strong>Maximum:</strong>
                          <asp:TextBox runat="server" CssClass="form-control" ID="editGradeMaximum" placeholder="Maximum"/>
                      </div> --%>
                    <%-- <div class="form-group">
                        <strong>G.P.A Points:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="editGradeGpa" placeholder="Minimum" />
                    </div>--%>
                    <div class="form-group">
                        <strong>Maximum Percentage:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="editmaximumpercentage" placeholder="Maximum Percentage" />
                    </div>
                    <div class="form-group">
                        <strong>Minimum Percentage:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="editminimumpercentage" placeholder="Minimum Percentage" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Update Grade" ID="editGrade" OnClick="editGrade_Click" CausesValidation="false"/>
                </div>
            </div>
        </div>
    </div>
    <div id="deleteCourseUnitModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting Unit</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the Unit <strong id="deleteUnitDescription"></strong>?</p>
                    <asp:TextBox runat="server" ID="deleteUnitCode" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Unit" ID="deleteUnit" OnClick="deleteUnit_Click" CausesValidation="false"/>
                </div>
            </div>
        </div>
    </div>
    <div id="deleteCourseReferenceModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting Course Refernce</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the Reference</p>
                    <asp:TextBox runat="server" ID="referencecode" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Unit" ID="Button3" OnClick="deleteReference_Click" CausesValidation="false"/>
                </div>
            </div>
        </div>
    </div>
    <div id="editCourseUnitModal" class="modal fade" role="dialog">
        <div class="modal-dialog" style="width:80%">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" style="color:darkblue">Update Course Unit</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="editUnitCode" type="hidden" />
                    <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Course Code:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="editCourseCode" placeholder="Course Code" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Course Title:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="editCourseTitle" placeholder="Course Title" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Credit Hours:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="editCourseCreditHours" placeholder="Credit Hours" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Year Code:</strong>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="editCourseYearCode" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Course Category:</strong>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="editCourseCategory" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Course Semester/Trimister:</strong>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="editCoursesem">
                                <asp:ListItem Value="1">1</asp:ListItem>
                                <asp:ListItem Value="2">2</asp:ListItem>
                                <asp:ListItem Value="3">3</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Course Content:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="editCourseContent" placeholder="Course Content:" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Instructional Materials and/or Equipment:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="editCourseMaterial" placeholder="Instructional Materials and/or Equipment:" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Course Assessment:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="editCourseAssessment" placeholder="Course Assessment:" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Learning Outcome One:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="editLO1" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Learning Outcome Two:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="editLO2" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Learning Outcome Three:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="editLO3" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Learning Outcome Four:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="editLO4" />
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <strong>Learning Outcome Five:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="editLO5" />
                        </div>
                    </div>
                    <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12 form-group">
                    <strong>Course Instructional Methods<span style="color:red">*</span></strong><i>(Please check at applicable  Course Instructional Methods)</i>
                    <div class="container">
                        <br />
                        <div class="row">
                            <fieldset class="col-sm-6">
                                <label>
                                    <asp:CheckBox runat="server" ID="editdiscoverylearning" />
                                    <span>Discovery Learning</span>
                                </label>
                            </fieldset>
                            <fieldset class="col-sm-6">
                                <label>
                                    <asp:CheckBox runat="server" ID="editproblembased" />
                                    <span>Problem Based Learning</span>
                                </label>
                            </fieldset>
                            <fieldset class="col-sm-6">
                                <label>
                                    <asp:CheckBox runat="server" ID="editexperientallearning" />
                                    <span>Experiential learning</span>
                                </label>
                            </fieldset>
                            <fieldset class="col-sm-6">
                                <label>
                                    <asp:CheckBox runat="server" ID="editgroupbasedlearning" />
                                    <span>Group-Based Learning</span>
                                </label>
                            </fieldset>
                            <fieldset class="col-sm-6">
                                <label>
                                    <asp:CheckBox runat="server" ID="editlectures" />
                                    <span>Lectures</span>
                                </label>
                            </fieldset>
                            <fieldset class="col-sm-6">
                                <label>
                                    <asp:CheckBox runat="server" ID="editindependentstudies" />
                                    <span>Independent Studies</span>
                                </label>
                            </fieldset>
                            <fieldset class="col-sm-6">
                                <label>
                                    <asp:CheckBox runat="server" ID="editcheckothers" onclick="ShowHideOthersDivEdit(this)" />
                                    <span>Others</span>
                                </label>
                            </fieldset>
                            <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group" style="display: none" id="editothersinstructionalmethds">
                                <strong>Other Programme Instructional Methods:</strong>
                                <asp:TextBox runat="server" ID="editotherss" CssClass="form-control" placeholder="Other Programme Instructional Methods" TextMode="MultiLine" />

                            </div>
                        </div>
                    </div>
                </div>
                 </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger pull-left" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Update Course Unit" ID="editCourse" OnClick="editCourse_Click" CausesValidation="false"/>
                </div>

            </div>

        </div>
    </div>
    <div id="editRefModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Update Reference Materials</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="TextBox2" type="hidden" />
                    <div class="form-group">
                        <strong>Reference Code:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="refcode" placeholder="Reference Code" />
                    </div>
                    <div class="form-group">
                        <strong>Course Code:</strong>
                        <asp:DropDownList runat="server" CssClass="form-control" ID="editscoursecode"></asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <strong>Reference Title:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="reftitle" placeholder="Reference Title" TextMode="MultiLine" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Update Reference" ID="editref" OnClick="editCourseRef_Click" CausesValidation="false"/>
                </div>
            </div>

        </div>
    </div>
    <div id="deletecoloModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting Course Learning Outcome</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the Course Learning Outcome ?</p>
                    <asp:TextBox runat="server" ID="deletecoloCode" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Outcome" ID="deleteColo" OnClick="deleteColo_Click" CausesValidation="false"/>
                </div>
            </div>
        </div>
    </div>
    <div id="editcoloModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Update Course Learning Outcome</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="editColoCode" type="hidden" />
                    <div class="form-group">
                        <strong>Learning Outcome:</strong>
                        <asp:DropDownList runat="server" CssClass="form-control" ID="editColoOutcome" />
                    </div>
                    <div class="form-group">
                        <strong>Course Unit:</strong>
                        <asp:DropDownList runat="server" CssClass="form-control" ID="editColoUnit" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Update Outcome" ID="editColo" OnClick="editColo_Click" CausesValidation="false"/>
                </div>
            </div>
        </div>
    </div>
    <%--  <div id="removeInstructionalMethodModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting Course Instructional Method</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove the delivery mode <strong id="deleteInstructionalMethodName"></strong>?</p>
                    <asp:TextBox runat="server" ID="editInstructionalMethodCode" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Instructional Method" ID="removeInstructionalMethod" OnClick="removeInstructionalMethod_Click" />
                </div>
            </div>
        </div>
    </div>--%>
    <div id="deleteBookModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting Book</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the book  <strong id="deleteBookTitle"></strong>?</p>
                    <asp:TextBox runat="server" ID="deleteBookCode" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Book" ID="deleteBook" OnClick="deleteBook_Click" CausesValidation="false"/>
                </div>
            </div>
        </div>
    </div>

        <div id="editGeneralDetailsNewVersionModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Editing</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to edit the programme: <strong id="progname"></strong>?</p>
                    <asp:TextBox runat="server" ID="txtprogramID" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger pull-left" data-dismiss="modal">No</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Yes" ID="yesEdit" CausesValidation="false" OnClick="yesEdit_Click"/>
                </div>
            </div>
        </div>
    </div>

    <div id="editBookModal" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Update Core Reading Material</h4>
                </div>
                <div class="modal-body">

                    <asp:TextBox runat="server" ID="editBookCode" type="hidden" />
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <strong>Book Title:</strong>
                                <asp:TextBox runat="server" CssClass="form-control" ID="editBookTitle" placeolder="Book Title" />
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <strong>Course:</strong>
                                <asp:DropDownList runat="server" CssClass="form-control" ID="editBookCourse" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <strong>Authors:</strong>
                                <asp:TextBox runat="server" CssClass="form-control" ID="editBookAuthors" placeolder="Authors" />
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <strong>Year of Publication:</strong>
                                <asp:TextBox runat="server" CssClass="form-control" ID="editBookPublicationYear" placeolder="Year of Publication" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <strong>Publishers:</strong>
                                <asp:TextBox runat="server" CssClass="form-control" ID="editBookPublishers" placeolder="Publishers" />
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <strong>URL:</strong>
                                <asp:TextBox runat="server" CssClass="form-control" ID="editBookURL" placeolder="URL" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <strong>Print:</strong>
                                <asp:CheckBox runat="server" CssClass="form-control" ID="editBookPrint" placeolder="Publishers" />
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <div class="form-group">
                                <strong>Electronic:</strong>
                                <asp:CheckBox runat="server" CssClass="form-control" ID="editBookElectronic" placeolder="URL" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Update Book" ID="editBook" OnClick="editBook_Click" CausesValidation="false"/>
                </div>
            </div>
        </div>
    </div>

    <div id="deleteFileModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting File</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the file <strong id="filetoDeleteName"></strong>?</p>
                    <asp:TextBox runat="server" ID="fileName" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" ID="deletefile" OnClick="deletefile_Click" CausesValidation="false"/>
                </div>
            </div>

        </div>
    </div>
    <script>
        function myFunction(myCheck) {
            var evidencecheckBox = document.getElementById("myCheck");
            var text = document.getElementById("proffessionalbody");
            if (myCheck.checked == true) {
                text.style.display = "block";
            } else {
                text.style.display = "none";
            }
        }
    </script>
    <script>
        function myGPASystem() {
            var checkBox1 = document.getElementById("gpacheckbox");
            var gradecode = document.getElementById("gradecode");
            var gpapoints = document.getElementById("gpapoints");
            if (checkBox1.checked == true) {
                gradecode.style.display = "block";
                gpapoints.style.display = "block";
            } else {
                gradecode.style.display = "block";
                minimumpoints.style.display = "block";
                maximumpoints.style.display = "block";
            }
        }
    </script>
    <script type="text/javascript">
        function ShowHideDiv(chkPassport) {
            var dvPassport = document.getElementById("dvPassport1");
            dvPassport.style.display = chkPassport.checked ? "block" : "none";
            if (chkPassport.checked == true) {
                dvPassport.style.display = "block";
            } else {
                dvPassport.style.display = "none";
            }
        }
    </script>
    <script type="text/javascript">
        function ShowHideOthersDiv(pothers) {
            var dvPassport = document.getElementById("othersinstructionalmethds");
            dvPassport.style.display = pothers.checked ? "block" : "none";
            if (pothers.checked == true) {
                dvPassport.style.display = "block";
            } else {
                dvPassport.style.display = "none";
            }
        }
    </script>
        <script type="text/javascript">
            function ShowHideOthersDivEdit(editcheckothers) {
            var dvPassport = document.getElementById("editothersinstructionalmethds");
            dvPassport.style.display = editcheckothers.checked ? "block" : "none";
            if (editcheckothers.checked == true) {
                dvPassport.style.display = "block";
            } else {
                dvPassport.style.display = "none";
            }
        }
    </script>
    <script type="text/javascript">
        function ShowURL(bookElectronic) {
            var dvElectronic = document.getElementById("dvShowElectronicUrl");
            dvElectronic.style.display = bookElectronic.checked ? "block" : "none";
            if (bookElectronic.checked == true) {
                dvElectronic.style.display = "block";
            } else {
                dvElectronic.style.display = "none";
            }
        }
    </script>
    <script type="text/javascript">
        function showDiv(divId, element) {
            document.getElementById(divId).style.display = element.text == "Others" ? 'block' : 'none';
        }
    </script>
    <script type="text/javascript">
        function ShowBody(checkbody) {
            var body = document.getElementById("evidence");
            body.style.display = nomalgrading.checked ? "block" : "none";
        }
    </script>
    <script type="text/javascript">
        function checkTB(val) {
            var allowedString = /^\d+(\.\d{0,2})?$/; // Allow 2 decimal place with numeric value
            if (allowedString.test(val) == false) {
                alert("The value " + val + " is not allowed, kindly input only numbers or decimal numbers e.g 5 or 5.50");
            }
        }
    </script>
</asp:Content>
