<%@ Page Language="C#" MasterPageFile="~/QAMaster.Master"  AutoEventWireup="true" CodeBehind="ProgrammeQAPreamble.aspx.cs" Inherits="CicPortal.ProgrammeQAPreamble" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row" style="background-color: #f5f5f5;">
        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
        <h3 style="color:Highlight"><b>Universities Programme Quality Audit</b></h3>
            </div>
        <hr/>
   <div class="panel-heading">
    <div class="row" >

       <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
       <p>The Commission for University Education (CUE) is mandated by Section 5 (1) (l) of The Universities Act No. 42 of 2012; Revised 2018 [2012] to approve and inspect university programme in Kenya. 
Programme Quality Audit is conducted by the Commission for University Education under Regulation 52 (6) (7) of the Universities Regulations, 2014. Under this regulation, every university, upon establishment, each university shall submit to the Commission a five-year peer review plan every five years; and carry out self-assessment of its programmes every cohort and submit a report on the same to the Commission for purposes of programme quality audit. 
Program quality audit seeks to determine the extent to which an accredited Academic Program meets or exceeds set Standards and Guidelines. The programme Self-Assessment Report (SAR) covers the following quality criteria: 
eria: <br />
        1.	Requirements of Stakeholders<br />
        2.	Expected learning outcomes (ELOs)<br />
        3.	Programme specification or description <br />
        4.	Programme content<br />
        5.	Organisation of the Programme<br />
        6.	Didactic concept/ teaching/learning strategy <br />
        7.	Student assessment <br />
        8.	Quality of academic staff<br />
        9.	Quality of support staff <br />
        10.	Profile of student<br />
        11.	Student advice/ support<br />
        12.	Facilities and Infrastructure <br />
        13.	Student evaluation <br />
        14.	Curriculum design <br />
        15.	Staff development activities<br />
        16.	Benchmarking<br />
        17.	Profile of graduates<br />
        18.	Satisfaction of Stakeholders<br />
        The above criteria are used as minimum requirements on quality aspects to the Self-Assessment Team assess quality in a systematic manner.<a href="Downloads/CUE Portal User Guide.pdf"><i class="fa fa-file-pdf-o" style="color:red"></i>Click here</a> to access the Guidelines for Programme Self –Assessment. Section 3.0 of the guidelines presents the outline for writing the Programme Self-Assessment Report (SAR). Proceed to submit the SAR once complete. 
        </p> 
                           <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                    <strong>Programme Quality Audit Fees Schedule</strong>
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
                            <td><%="Programme Quality Audit Fees Charges" %></td>
                            <td><%="320,000" %></td>
                        </tr>
                    </tbody>
                </table>
                </div>
            <h2 style="color:Highlight" ><u>Note:</u></h2>
        <p>Timelines for required responses are inbuilt, and the system will automatically terminate evaluation at the expiry of the given response period; if this happens, you will be required to make a fresh application for accreditation and make requisite payment.</p>
          </div>
         <asp:Button runat="server" CssClass="btn btn-success pull-right fa fa-arrow-right"  style="margin-right: 100px;" Text="Next" ID="Next" OnClick="Proceed_Onclick" />

        </div>
     </div>
    </div>
</asp:Content>