using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CicPortal
{
    public class QASARResponse
    {
        public string SurveyNo { get; set; }
        public string SectionCode { get; set; }
        public string SectionDesc { get; set; }
        public string QuestionType { get; set; }
        public string QuestionId { get; set; }
        public string QuestionDescription { get; set; }
        public string OpenQuiz { get; set; }
        public string ClosedQuiz { get; set; }
        public string SDate { get; set; }
        public string AttachedDoc { get; set; }
        public string QuestionResponseCode { get; set; }
    }
}