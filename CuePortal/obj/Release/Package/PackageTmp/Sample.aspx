<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Sample.aspx.cs" Inherits="CicPortal.Sample" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="panel panel-primary">
        <div class="panel-heading">Schools, Faculties and Institutes
            <label class="pull-right">Step <%=myStep %> of <%=maxSteps %></label>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">
            <table class="table table-bordered table-striped">
                <thead>
                <tr>
                <th>Category</th>
                <th>No</th>
                <th>Name</th>
                    </tr>
                </thead>
                <tbody>
                <tr>
                    <td>School</td>
                    <td>1</td>
                    <td>School of Computing and Informatics</td>
                </tr>
                </tbody>
            </table>
            <br/>
            <hr/>
            <div class="row">
                <div class="col-md-3 col-lg-3">
                    <div class="form-group">
                        <strong> Category:</strong>
                        <asp:DropDownList runat="server" CssClass="form-control" ID="otherInformationCategory"/>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong> Name:</strong>
                        <asp:Textbox runat="server" CssClass="form-control" ID="otherInformationName" placeholder="Name"/>
                    </div>
                </div>
                <div class="col-md-3 col-lg-3">
                    <div class="form-group">
                       <br/>
                        <asp:Button runat="server" CssClass="btn btn-success btn-block" ID="addOtherInformation" Text="Add"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel-footer"><div class="pull-right"><a href="InstitutionalQA.aspx?step=<%=myStep+1 %>" class="btn btn-success">Next</a></div><div class="clearfix"></div></div>
    </div>
    
      <div class="row">
                <div class="col-md-6 col-lg-6">
        
          <div class="form-group">
             
             <strong>a. Organograms for governance:</strong><i>Upload organograms for governance here</i>
             <asp:FileUpload runat="server" CssClass="form-control"/>
         </div>
                     <div class="form-group">
             
             <strong>b. Organograms for management:</strong><i>(b)	Upload organogram for management, also the University links with her affiliate’s e.g. colleges, campuses, collaborating institutions etc.) </i>
             <asp:FileUpload runat="server" CssClass="form-control"/>
         </div>
                </div>
                </div>
</asp:Content>
