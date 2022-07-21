<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/ChooseServiceMaster.Master" CodeBehind="help.aspx.cs" Inherits="CicPortal.help" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="panel panel-primary">
       <div class="modal-body">
        <div class="page-wrapper">
       
                <div class="content container-fluid">
					<div class="row">
						<div class="col-md-8 col-md-offset-2">
								<h3 class="page-title">Commission Contact Details</h3>
								<div class="row">
									<div class="col-sm-6">
										<div class="form-group">
											<label>Commission Name <span class="text-danger">*</span></label>
											<asp:Label runat="server" class="form-control" type="text" Text="Commission for University Education"></asp:Label>
										</div>
									</div>
									<div class="col-sm-6">
										<div class="form-group">
											<label>Contact Person</label>
											<asp:Label runat="server" class="form-control" Text="The Commission Secretary" type="text"></asp:Label>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-12">
										<div class="form-group">
											<label>Address</label>
											<asp:Label runat="server"  class="form-control" Text="Red Hill Road,Off Limuru Road, Gigiri.P.O. Box 54999 – 00200, Nairobi, Kenya" type="text"></asp:Label>
										</div>
									</div>
									<div class="col-sm-6 col-md-6 col-lg-3">
										<div class="form-group">
											<label>Country</label>
											<asp:Label runat="server"  class="form-control"  Text="Kenya"></asp:Label>
										</div>
									</div>
									<div class="col-sm-6 col-md-6 col-lg-3">
										<div class="form-group">
											<label>City</label>
											<asp:Label runat="server" class="form-control" Text="Nairobi" type="text"></asp:Label>
										</div>
									</div>
									<div class="col-sm-6 col-md-6 col-lg-3">
										<div class="form-group">
											<label>State/Province/County</label>
											<asp:Label runat="server" class="form-control" Text="Nairobi" type="text"></asp:Label>
										</div>
									</div>
									<div class="col-sm-6 col-md-6 col-lg-3">
										<div class="form-group">
											<label>Postal Code</label>
                                            <asp:Label runat="server" class="form-control" Text="54999 – 00200" type="text"></asp:Label>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-6">
										<div class="form-group">
											<label>Email</label>
                                             <asp:Label runat="server" class="form-control"  Text="info@cue.or.ke" type="text"></asp:Label>
										</div>
									</div>
									<div class="col-sm-6">
										<div class="form-group">
											<label>Phone Number</label>
                                            <asp:Label runat="server" class="form-control"  Text=" +254 – 020 – 7205000, +254–780-656575"  type="text"></asp:Label>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-6">
										<div class="form-group">
											<label>Mobile Number</label>
                                              <asp:Label runat="server" class="form-control" Text="0717-445566, 0726-445566"  type="text"></asp:Label>
										</div>
									</div>
									<div class="col-sm-6">
										<div class="form-group">
											<label>Website Url</label>
                                             <asp:Label runat="server" class="form-control"  Text="http://www.cue.or.ke"  type="text"></asp:Label>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-12 text-center m-t-20">
									<p1>The Commission offices are located at Gigiri, Nairobi Kenya.</p1>
									</div>
							 	</div>
						 </div>
                         </div>
                    <div id="map-container-google-1" class="z-depth-1-half map-container" style="height: 500px">
                        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3988.9061126769784!2d36.790116314753966!3d-1.2252259991063281!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x182f17e0d78e1663%3A0x76e799c1b1f4565a!2sCommission%20For%20University%20Education!5e0!3m2!1sen!2ske!4v1595663298556!5m2!1sen!2ske" width="1050" height="450" frameborder="0" style="border:0;" allowfullscreen="" aria-hidden="false" tabindex="0"></iframe>
                     
                    </div>
                      </div>
				 	</div>
                </div>
          </div>
    </asp:Content>