using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CicPortal
{
    public class ResetPass
    {
        public String Message { get; set; }
        public String CurrentPassword { get; set; }
        public String NewPassword { get; set; }
        public String ConfirmPassword { get; set; }
        public String MemberNumber { get; set; }
    }
}