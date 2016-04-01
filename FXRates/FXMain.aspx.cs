using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using System.Net;
using Newtonsoft.Json;
using System.Text;

namespace FXRate
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        private string baseURL = "http://apilayer.net/api";
        private string accessKey = "?access_key=3aa1675d116d7828ce8df0926e4fe95c";
        private string jsonFormat = "&format=1";
        private string callback = "&callback=processJSON";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Get currency list
                var url = baseURL + "/list" + accessKey;
                var currList = getJSONdata<currList>(url);
                var datasource = (from x in currList.Currencies
                                 select new
                                 {
                                     x.Key,
                                     x.Value,
                                     DisplayText = String.Format("{0} - {1}", x.Key, x.Value)
                                 });

                ddSource.DataSource = datasource;
                ddSource.DataTextField = "DisplayText";
                ddSource.DataValueField = "Key";
                ddSource.DataBind();
                
                lstCurrencies.DataSource = datasource;
                lstCurrencies.DataTextField = "DisplayText";
                lstCurrencies.DataValueField = "Key";
                lstCurrencies.DataBind();
            }
        }

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

        private static T getJSONdata<T>(string url) where T : new()
        {
            using (var w = new WebClient())
            {
                var json_data = string.Empty;
                // attempt to download JSON data as a string
                try
                {
                    json_data = w.DownloadString(url);
                }
                catch (Exception) { }
                // if string with JSON data is not empty, deserialize it to class and return its instance 
                return !string.IsNullOrEmpty(json_data) ? JsonConvert.DeserializeObject<T>(json_data) : new T();
            }
        }

        protected void btnGetFXRates_Click(object sender, EventArgs e)
        {
            string source = ddSource.SelectedValue;
            StringBuilder targets = new StringBuilder();
            string targetList = "";

            foreach (ListItem li in lstCurrencies.Items)
            {
                if (li.Selected)
                    targets.Append(li.Value + ",");
            }

            if (targets.Length > 0)
            {
                targetList = targets.ToString().Substring(0, targets.Length - 1);
            }

            // ------- Should use this but free API does not allow changing source
            //string url = baseURL + "/live" + accessKey + "&source=" + source
            //    + "&currencies=" + targetList + jsonFormat;
            
            // Hence using this where I am fixing source to USD
            string url = baseURL + "/live" + accessKey + "&source=USD"
                + "&currencies=" + targetList + jsonFormat;

            getRatesData(url);
            
        }

        public void getRatesData(string url)
        {
            var CurrencyRates = getJSONdata<CurrencyRates>(url);
            grdResults.DataSource = CurrencyRates.Quotes;
            grdResults.DataBind();
        }
    }
}