<%@ Page Title="" Language="C#" MasterPageFile="~/QAMaster.Master" AutoEventWireup="true" CodeBehind="RoadmapReport.aspx.cs" Inherits="CicPortal.RoadmapReport" %>
<%@ Import Namespace="CicPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="row">
  <div class="col-md-12 col-lg-12">

        <div class="widget">
        
            <div class="widget-header"> <i class="icon-file"></i>
                <h3>Roadmap Details</h3>
            </div>
            <div class="widget-content">
                <div id="feedback" runat="server"></div>
                <div class="form-group">
                    <iframe runat="server" class="col-sm-12 col-xs-12 col-md-10 col-lg-10" height="500px" ID="payslipFrame" style="margin-top: 10px;" ></iframe>
                </div>          
            </div>
          </div>
   </div>

</div>
        <br />
    <asp:Button runat="server" style="margin-left:2%" CssClass="btn btn-success" Text="Go To HomePage" ID="GoToPreviousPage" OnClick="GoToPreviousPage_Click"/>
    <br />
</asp:Content>
