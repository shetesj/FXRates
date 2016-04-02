using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using System.Net;
using Newtonsoft.Json;
using System.Text;
using FXRates.Models;
using System.Data;

namespace FXRates
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        private string baseURL = "http://apilayer.net/api";
        private string accessKey = "?access_key=3aa1675d116d7828ce8df0926e4fe95c";
        private string jsonFormat = "&format=1";
        private static Dictionary<string, string> dctCurrencies;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Get currency list
                var url = baseURL + "/list" + accessKey;
                var currList = getJSONdata<currList>(url);
                dctCurrencies = currList.Currencies;
                var datasource = (from x in dctCurrencies
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
                
                // Preselecting USD as the free API does not allow to change source
                ListItem item = ddSource.Items.FindByValue("USD");
                if (item != null)
                    item.Selected = true;
                
                lstCurrencies.DataSource = datasource;
                lstCurrencies.DataTextField = "DisplayText";
                lstCurrencies.DataValueField = "Key";
                lstCurrencies.DataBind();

                divLbls.Visible = false;
            }
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
            string url = baseURL + "/live" + accessKey + "&source=" + source
                + "&currencies=" + targetList + jsonFormat;

            getRatesData(url);
            
        }

        public void getRatesData(string url)
        {
            var CurrencyRates = getJSONdata<CurrencyRates>(url);
            string dest = String.Empty;
            string source = String.Empty;
            DataTable dt = new DataTable();
            dt.Columns.Add(new DataColumn("Currency", typeof(string)));
            dt.Columns.Add(new DataColumn("Rate", typeof(decimal)));

            foreach (var qoute in CurrencyRates.Quotes)
            {
                source = qoute.Key.Substring(0, 3);
                dest = qoute.Key.Substring(3);
                DataRow dRow = dt.NewRow();
                dRow[0] = dest + " - " + dctCurrencies[dest];
                dRow[1] = qoute.Value;
                dt.Rows.Add(dRow);
            }
            if (dt.Rows.Count > 0)
                divLbls.Visible = true;
            grdResults.DataSource = dt;
            grdResults.DataBind();
            System.DateTime dtDateTime =
                new DateTime(1970, 1, 1, 0, 0, 0).AddSeconds(CurrencyRates.TimeStamp).ToLocalTime();
            lblTimestamp.Text = dtDateTime.ToString();
            lblBaseValue.Text = source + " - " + dctCurrencies[source];
        }
    }
}