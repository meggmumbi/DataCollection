using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CicPortal
{
    public class FeedbackModel
    {
        public string TfeedbackNo { get; set; }
        public string TSectionCode { get; set; }
        public int TFindingResponse { get; set; }
        public string TInstitutionResponse { get; set; }
    }
}