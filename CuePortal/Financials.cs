using System;
using System.Collections.Generic;

namespace CicPortal
{

    public class Financials
    {
        public string source { get; set; }
        public decimal expected { get; set; }
        public decimal actual { get; set; }
        public decimal amounts { get; set; }
        public string credits { get; set; }
        public string debtor { get; set; }
        public decimal debtoramounts { get; set; }
        public string financialstartdate { get; set; }
        public string financialenddate { get; set; }

    }

}