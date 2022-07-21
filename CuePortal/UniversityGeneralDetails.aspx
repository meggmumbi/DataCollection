<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/ChooseServiceMaster.Master" CodeBehind="UniversityGeneralDetails.aspx.cs" Inherits="CicPortal.UniversityGeneralDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<%@ Import Namespace="CicPortal" %>
 <%

         var nav2 = Config.ReturnNav();
          if (Convert.ToString(Session["type"]) == "old")
          {
               var nav = Config.ReturnNav();
      %>
    <div class="row">
                <div class="col-lg-3 col-md-6">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-users fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">
                                      <%--  <%
                                             int students = nav.studentEnrolmentList.Where(r=>r.University_Code==Convert.ToString(Session["UniversityCode"])).ToList().Count;
                                             %>
                                        <% =students %>--%>
                                    </div>
                                    <div>Students Enrolled</div>
                                </div>
                            </div>
                        </div>
                        <a href="Students.aspx">
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
                                      <%--  <%
                                            int academicStaff = nav.University_Staff_Details.Where(r=>r.Institution_Code==Convert.ToString(Session["UniversityCode"])).ToList().Count;
                                            %>
                                        <% =academicStaff %>--%>
                                    </div>
                                    <div>Teaching Staff</div>
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
                                      <%--  <% int programs = nav.Programs.Where(r => r.Accreditation_Status == "CUE Accredited" && r.Institution_Code == Convert.ToString( Session["UniversityCode"])).ToList().Count; %>
                                        <% =programs %>--%>
                                    </div>
                                    <div>Teaching Programs</div>
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
                                    <i class="fa fa-building fa-5x"></i>
                                </div>
                                <div class="col-xs-9 text-right">
                                    <div class="huge">
                                      <%--<% int campuses = nav.campuses.Where(r => r.University_Code == Convert.ToString(Session["UniversityCode"])).ToList().Count; %>
                                        <%=campuses %>--%>
                                    </div>
                                    <div>University Campuses</div>
                                </div>
                            </div>
                        </div>
                        <a href="Campuses.aspx">
                            <div class="panel-footer">
                                <span class="pull-left">View Details</span>
                                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
           <%{
              var profiles = nav.UniversityProfile.Where(r => r.No == Convert.ToString(Session["UniversityCode"]));
              foreach (var profile in profiles)
              {
         %>
     <div class="row">
           <div runat="server" id="feedback"></div>
         <div class="col-md-11 col-lg-11 col-sm-11 col-xs-11">
         <div class="panel panel-green">
             <p>* University General Details. Click Update University Details to amend incase of any changes</p>
             <div class="panel-heading">
                 University Details
             </div>
             <div class="panel-body">
                 <table class="table table-bordered table-striped">
                    
                     <tr><td><strong>University Name:</strong></td><td><%=profile.Name %></td></tr>
                     <tr><td><strong>Status/Category/Authority of Operation:</strong></td><td><%=profile.Status_Category %></td></tr>
                     <tr><td><strong>Sponsor of Institution:</strong></td><td><%=profile.Sponsor_of_Institution %></td></tr>
                     <tr><td><strong>University Email Address:</strong></td><td><%=profile.E_Mail %></td></tr>
                     <tr><td><strong>University Phone Number:</strong></td><td><%=profile.Phone_No %></td></tr>
                     <tr><td><strong>University Post address:</strong></td><td><%=profile.Address + " " + profile.Post_Code + " " + profile.City %></td></tr>
                     <tr><td><strong>County of Location of Main Campus:</strong></td><td><%=profile.countyName %></td></tr>
                     <tr><td><strong>Constituency of Location of Main Campus:</strong></td><td><%=profile.ConstituencyName %></td></tr>
                     <tr><td><strong>Town of Location of Main Campus:</strong></td><td><%=profile.Town_of_Main_Campus %></td></tr>
                    
                 </table>
             </div>
             <div class="panel-footer">
                 <label class="btn btn-success pull-right" data-toggle="modal" data-target="#universityDetails">Update University Details</label>
                 <div class="clearfix"></div>
             </div>
         </div>
         <div class="panel panel-default">
             <p>*University Current Vice Chancellor Details. Click Update Vice Chancellor Details to amend incase of any changes</p>
             <div class="panel-heading">
                 Vice Chancellor Details
             </div>
             <div class="panel-body">
                 <table class="table table-bordered table-striped">
                     <tr><td><strong>Vice Chancellor Name:</strong></td><td><%=profile.VC_Name %></td></tr>
                     <tr><td><strong>Vice Chancellor Highest Academic Qualification:</strong></td><td><%=profile.VC_Highest_Academic %></td></tr>
                     <tr><td><strong>Vice Chancellor Domain of Specialization:</strong></td><td><%=profile.DomainName %></td></tr>
                     <tr><td><strong>Vice Chancellor Official Email Address:</strong></td><td><%=profile.VC_Official_Email_Address %></td></tr>
                     <tr><td><strong>Vice Chancellor Official Phone Number:</strong></td><td><%=profile.VC_Official_Phone %></td></tr>
                 </table>
             </div>
             <div class="panel-footer"> 
                 <label class="btn btn-success pull-right" data-toggle="modal" data-target="#vcDetails">Update Vice Chancellor Details</label>
                 <div class="clearfix"></div>
             </div>
         </div>             
        </div>
     </div>      
  
     <%                    
    }
    }
   %>
                  
    <% }
          else
          {
              %>
        <div class="row" style="margin: 10px;">
            <div class="panel panel-default">
                <div class="panel-heading">Profile</div>
                <div class="panel-body">
                <table class="table table-bordered table-striped">
                <%
                    var nav = Config.ReturnNav();
                    int code = Convert.ToInt32( Session["Code"]);
                    var users = nav.UniversitySignup.Where(r => r.Code == code);
                    foreach (var user in users)
                    {%>
                    <tr><td>Proposed Name:</td><td><%=user.Proposed_Name %></td></tr>
                    <tr><td>Principal Academic Focus:</td><td><%=user.Domain_Description %></td></tr>
                    <tr><td>Ministry of Education Code:</td><td><%=user.Ministry_of_Education_Code %></td></tr>
                    <tr><td>KRA PIN:</td><td><%=user.Kra_Pin %></td></tr>
                    <tr><td>Proposed Location:</td><td><%=user.Proposed_Location %></td></tr>
                    <tr><td>Sponsor:</td><td><%=user.Sponsor %></td></tr>
                    <tr><td>County:</td><td><%=user.County_Name %></td></tr>
                    <tr><td>Constituency:</td><td><%=user.ConstituencyName %></td></tr>
                    <tr><td>Post Address:</td><td><%=user.Post_Address %></td></tr>
                    <tr><td>Post Code:</td><td><%=user.Post_Code %></td></tr>
                    <tr><td>Website:</td><td><%=user.Institution_Website %></td></tr>
                    <tr><td>Phone Number:</td><td><%=user.Phone_Number %></td></tr>
                    <tr><td>Email Address:</td><td><%=user.Email_Address %></td></tr>
                <%    
                    }
                     %>
            </table>

            </div>
        </div>
       
    </div>
    <%
          } %>
    <div id="universityDetails" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Edit University Details</h4>
      </div>
      <div class="modal-body">
          <div class="row">
          <div class="form-group col-lg-6 col-md-6">
              <strong>University Name:</strong><br/>
              <label id="universityName" runat="server"></label>
          </div>
        <div class="form-group col-lg-6 col-md-6">
            <strong>Status/Category/Authority of Operation:</strong>
            <asp:DropDownList runat="server" CssClass="form-control" ID="statusCategory"/>
        </div>
          <div class="form-group col-lg-6 col-md-6">
              <strong>Sponsor of Institution:</strong>
               <asp:DropDownList runat="server" CssClass="form-control" ID="institutionSponsor"/>
          </div>
          <div class="form-group col-lg-6 col-md-6">
              <strong>University Email Address:</strong>
               <asp:TextBox runat="server" CssClass="form-control" ID="institutionEmailAddress"/>
          </div>
          <div class="form-group col-lg-6 col-md-6">
              <strong>University Phone Number:</strong>
               <asp:TextBox runat="server" CssClass="form-control" ID="institutionPhoneNumber" onpaste="return false;"  MaxLength="10" />
         
          </div>
          <div class="form-group col-lg-6 col-md-6">
              <strong>University Post Address:</strong>
               <asp:TextBox runat="server" CssClass="form-control" ID="institutionPostAddress"/>
          </div> 
          <div class="form-group col-lg-6 col-md-6">
              <strong>University Post Code:</strong>
               <asp:DropDownList runat="server" CssClass="form-control" ID="institutionPostCode"/>
          </div>
          <div class="form-group col-lg-6 col-md-6">
              <strong>County of Location of Main Campus:</strong>
               <asp:DropDownList runat="server" CssClass="form-control" ID="mainCampusCounty"/>
          </div>
          <div class="form-group col-lg-6 col-md-6">
              <strong>Constituency of Location of Main Campus:</strong>
              <asp:DropDownList runat="server" CssClass="form-control" ID="mainCampusConstituency"  />
          </div>
          <div class="form-group col-lg-6 col-md-6">
              <strong>Town of Location of Main Campus:</strong>
              <asp:TextBox runat="server" CssClass="form-control" ID="mainCampusTown" />
          </div>
              </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          <asp:Button runat="server" Text="Save Changes" CssClass="btn btn-success" ID="editGeneralDetails" OnClick="editGeneralDetails_Click"/>
      </div>
    </div>

  </div>
</div>
       <div id="vcDetails" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Edit Vice Chancellor Details</h4>
      </div>
      <div class="modal-body">
          <div class="row">
         
        <div class="form-group col-lg-6 col-md-6">
            <strong>Vice Chancellor Name:</strong>
            <asp:TextBox runat="server" CssClass="form-control" ID="vcName"/>
        </div> 
              <div class="form-group col-lg-6 col-md-6">
            <strong>Vice Chancellor Highest Academic Qualification:</strong>
            <asp:DropDownList runat="server" CssClass="form-control" ID="vcHighestAcademicLevel"/>
        </div>
          <div class="form-group col-lg-6 col-md-6">
              <strong>Vice Chancellor Domain of Specialization:</strong> 
               <asp:DropDownList runat="server" CssClass="form-control" ID="vcDomainOfSpecialization"/>
          </div>
          <div class="form-group col-lg-6 col-md-6">
              <strong>Vice Chancellor Official Email Address:</strong>
               <asp:TextBox runat="server" CssClass="form-control" ID="vcOfficialEmail"/>
          </div>
          <div class="form-group col-lg-6 col-md-6">
              <strong>Vice Chancellor Official Phone Number:</strong>
               <asp:TextBox runat="server" CssClass="form-control" ID="vcOfficialPhone"/>
          </div>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          <asp:Button runat="server" Text="Save Changes" CssClass="btn btn-success" ID="editVcDetails" OnClick="editVcDetails_Click"/>
      </div>
    </div>

  </div>
</div>
</asp:Content>
