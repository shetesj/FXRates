using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FXRates.Models
{
    public class currList
    {
        public string Success { get; set; }
        public string Terms { get; set; }
        public string Privacy { get; set; }
        public Dictionary<string, string> Currencies { get; set; }
    }

    public class CurrencyRates
    {
        public string Success { get; set; }
        public string Terms { get; set; }
        public string Privacy { get; set; }
        public string License { get; set; }
        public int TimeStamp { get; set; }
        public string Source { get; set; }
        public Dictionary<string, decimal> Quotes { get; set; }
    }

    public class OXR
    {
        public string Disclaimer { get; set; }
        public string License { get; set; }
        public int TimeStamp { get; set; }
        public string Base { get; set; }
        public Dictionary<string, decimal> Rates { get; set; }
    }
}