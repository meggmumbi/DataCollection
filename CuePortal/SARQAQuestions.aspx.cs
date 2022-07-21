using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CicPortal
{
    public partial class SARQAQuestions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void previouspage_Click(object sender, EventArgs e)
        {
            string SARNo = Request.QueryString["SARNo"];
            string sectionID = Request.QueryString["sectionID"];
            string Type = Request.QueryString["Type"];
            //+ "&&sectionID=" + sectionID
            Response.Redirect("QAqestions.aspx?SARNo=" + SARNo + "&&Type=" + Type);
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string InsertComponentItems(List<QASARResponse> cmpitems)
        {
            string tSurveyNo = "", tSectionCode = "", tSectionDesc = "", tQuestionType = "", tQuestionId = "", tQuestionDescription = "", tOpenQuiz = "", tClosedQuiz = "", tSDate = "", tAttachedDoc = "", tQuestionResponseCode = "";
            string results_0 = (dynamic)null;
            try
            {

                //Check for NULL.
                if (cmpitems == null)
                    cmpitems = new List<QASARResponse>();

                //Loop and insert records.
                foreach (QASARResponse oneitem in cmpitems)
                {
                    tSurveyNo = oneitem.SurveyNo;
                    tSectionCode = oneitem.SectionCode;
                    tSectionDesc = oneitem.SectionDesc;
                    tQuestionType = oneitem.QuestionType;
                    tQuestionId = oneitem.QuestionId;
                    tQuestionDescription = oneitem.QuestionDescription;
                    tOpenQuiz = oneitem.OpenQuiz;
                    tClosedQuiz = oneitem.ClosedQuiz;
                    tSDate = oneitem.SDate;
                    tAttachedDoc = oneitem.AttachedDoc;
                    tQuestionResponseCode = oneitem.QuestionResponseCode;

                    if (string.IsNullOrEmpty(tOpenQuiz))
                    {
                        tOpenQuiz = "";
                    }
                    if (string.IsNullOrEmpty(tClosedQuiz))
                    {
                        tClosedQuiz = "";
                    }
                    if (string.IsNullOrEmpty(tSDate))
                    {
                        tSDate = "";
                    }
                    if (string.IsNullOrEmpty(tAttachedDoc))
                    {
                        tAttachedDoc = "";
                    }
                    if (string.IsNullOrEmpty(tQuestionResponseCode))
                    {
                        tQuestionResponseCode = "";
                    }

                    if (tQuestionType == "Date")
                    {
                        int questionType = 3;
                        string status = new Config().ObjNav().FnAddDateAuditAnswers(tSurveyNo, tSectionCode, tSectionDesc, tQuestionId, tQuestionDescription, tSDate, questionType);
                        string[] info = status.Split('*');
                        results_0 = info[0];
                    }

                    else if (tQuestionType == "Closed-Ended")
                    {
                        int questionType = 1;
                        string status = new Config().ObjNav().FnAddLosedEndedAuditAnswers(tSurveyNo, tSectionCode, tSectionDesc, tQuestionId, tQuestionDescription, tClosedQuiz, questionType, tQuestionResponseCode);
                        string[] info = status.Split('*');
                        results_0 = info[0];
                    }

                    else if (tQuestionType == "Attachment")
                    {
                        try
                        {
                            string accreditationNo = tSurveyNo;
                            accreditationNo = accreditationNo.Replace('/', '_');
                            accreditationNo = accreditationNo.Replace(':', '_');
                            string path1 = Config.FilesLocation() + "Institution Audit Response/";
                            string str1 = Convert.ToString(accreditationNo);
                            string sectID = tSectionDesc;
                            string questionID = tQuestionDescription;
                            string folderName = path1 + str1 + "/";
                            bool DocUploaded = false;

                            bool error = false;
                            string message = "";
                            try
                            {
                                if (tAttachedDoc.Length > 0)
                                {
                                    string extension = System.IO.Path.GetExtension(tAttachedDoc);
                                    if (extension == ".pdf" || extension == ".PDF" || extension == ".Pdf")
                                    {
                                        string filename = sectID + "_" + questionID + "_" + "ATTACHMENT" + extension;
                                        if (!Directory.Exists(folderName))
                                        {
                                            Directory.CreateDirectory(folderName);
                                        }
                                        if (File.Exists(folderName + filename))
                                        {
                                            File.Delete(folderName + filename);
                                        }
                                        File.Create(folderName + filename);
                                        if (File.Exists(folderName + filename))
                                        {
                                            DocUploaded = true;
                                        }
                                    }
                                    else
                                    {
                                        error = true;
                                        message += message.Length > 0 ? "<br>" : "";
                                        message += "The file extension of the document is not allowed,Kindly upload pdf files only";
                                    }

                                }
                                else
                                {
                                    error = true;
                                    message += message.Length > 0 ? "<br>" : "";
                                    message += "The file extension of the document is not allowed,Kindly upload pdf files only";

                                }
                            }
                            catch (Exception ex)
                            {
                                error = true;
                                message += message.Length > 0 ? "<br>" : "";
                                message += "The file extension of the document is not allowed,Kindly upload pdf files only" + ex;
                            }

                            if (error)
                            {
                                message += "The file extension of the document is not allowed,Kindly upload pdf files only";
                            }
                            else
                            {
                                int questionType = 2;
                                string status = new Config().ObjNav().FnAddAttachmentAuditAnswers(tSurveyNo, tSectionCode, tSectionDesc, tQuestionId, tQuestionDescription, DocUploaded, questionType);
                                string[] info = status.Split('*');
                                results_0 = info[0];
                            }
                        }
                        catch (Exception ex)
                        {
                            results_0 = ex.Message;
                        }
                    }

                    else
                    {
                        int questionType = 0;
                        string status = new Config().ObjNav().FnAddAuditAnswers(tSurveyNo, tSectionCode, tSectionDesc, tQuestionId, tQuestionDescription, tOpenQuiz, questionType);
                        string[] info = status.Split('*');
                        results_0 = info[0];
                    }
                }
            }
            catch (Exception ex)
            {
                results_0 = ex.Message;
            }
            return results_0;
        }
    }
}