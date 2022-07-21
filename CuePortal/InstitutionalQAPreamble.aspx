<%@ Page Language="C#" MasterPageFile="~/QAMaster.Master" AutoEventWireup="true" CodeBehind="InstitutionalQAPreamble.aspx.cs" Inherits="CicPortal.InstitutionalQAPreamble" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row" style="background-color: #f5f5f5;">
        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
            <%--<p class="pull-right" style="font-size:15px"><a href="Downloads/CUE Portal User Guide.pdf"><i class="fa fa-file-pdf-o"></i>Curriculum Document GuideLines</a></p>--%>
            <h3 style="color: Highlight"><b>Universities Institutional Quality Audit</b></h3>
            <strong>Follow the following processes to complete the appplication process</strong>
        </div>
        <hr />
        <div class="panel-heading">
            <div class="row">
                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                    <p>
                        All Universities in Kenya are established under section 13 (1) of The Universities Act No. 42 of 2012; Revised 2018 [2012]. The Commission for University Education (CUE) is mandated under Section 5 (1) of the Act to undertake regular inspections, monitoring and evaluation of Universities to ensure compliance with the provisions of the Act. In the exercise of its mandate the Commission carries out Regular Institution Quality Audit of Chartered universities, university constituent colleges and campuses every five years under regulations 17 (1) (2) (3) and (4) of the Universities Regulations 2014.

Quality assurance is primarily the responsibility of every university, managed at the level of core activities of the university stated as teaching/learning, research and community outreach. The enabling environment for the core activities includes university policies, strategy, governance and management, human and financial resources, facilities, among others. It is therefore important for the university to carry out a critical self-assessment of the institution as a whole, and write a comprehensive self-assessment report (SAR) to facilitate internal and external quality assurance. Based on The Universities Act; Universities Regulations, and Universities Standards and Guidelines, the quality aspects/criteria for institutional self-assessment are as follows
             <ol type="1">
                 <li>Requirements set by Stakeholders</li>
                 <li>University Governance and Management</li>
                 <ol type="a">
                     <li>Governance and Management including</li>
                     <li>Human Resource</li>
                     <li>Funding and Financial Management</li>
                 </ol>
                 <li>Core Educational Activities</li>
                 <ol type="a">
                     <li>Educational Activities</li>
                     <li>Research and Innovation</li>
                     <li>Community Outreach/Service</li>
                 </ol>
                 <li>Research</li>
                 <li>Community Outreach</li>
                 <li>Benchmarking</li>
                 <li>Quality Assurance</li>
                 <li>Colleges, Campuses and Collaborating institutions</li>
                 <li>Achievements/outcomes</li>
                 <li>Satisfaction of the Stakeholders</li>
             </ol>
                </div>
                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                    <strong>Institutional Quality Audit Fees Schedule</strong>
                </div>
                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                    <hr />
                <table class="table table-striped table-bordered table-hover dataTable2" id="dataTables-example">
                    <thead>
                        <tr>
                            <th>Description</th>
                            <th>Amount (KSH.)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><%="Quality Assurance charges per student enrolled paid once at admission in a University programme (Bachelors, Masters, phD, P/G Diploma)" %></td>
                            <td><%="1,000" %></td>
                        </tr>
                        <tr>
                            <td><%="Institutional Quality Audit Fees Charges" %></td>
                            <td><%="900,000" %></td>
                        </tr>
                    </tbody>
                </table>
                </div>
                <asp:Button runat="server" CssClass="btn btn-success pull-right fa fa-arrow-right" Style="margin-right: 100px;" Text="Next" ID="Next" OnClick="Proceed_Onclick" />
            </div>
        </div>
    </div>
</asp:Content>
