using MSXML;
using System.Data;
using System.Net;
using System.Web;
using System.Xml;

namespace Web_Portal
{
    /// <summary>
    /// Сводное описание для Handler2
    /// </summary>
    public class Handler2 : IHttpHandler
    {
        DataTable data_table = new DataTable();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";

            string FeatureInfo_params = "";

            if (context.Request.QueryString["FeatureInfo_params"] != null)
            {
                FeatureInfo_params = context.Request.QueryString["FeatureInfo_params"];
            }
            else { }


            var objXML = new XMLHTTPRequest();

            string url = "http://localhost:8080/geoserver/MyWorkSpace/wms?" + context.Request.QueryString;
            objXML.open("GET", url);
            objXML.send();

            WebRequest request = WebRequest.Create(url);
            WebResponse response = request.GetResponse();

            var response_text = "";

            using (System.IO.StreamReader stream = new System.IO.StreamReader(response.GetResponseStream(), System.Text.Encoding.UTF8))
            {
                response_text = stream.ReadToEnd();
            }

            XmlDocument doc = new XmlDocument();
            doc.LoadXml(response_text);
            try
            {
                var item4 = doc.ChildNodes[1].ChildNodes[1].ChildNodes[0].ChildNodes; //ненадёжно

                string result_string = "";
                for (int i = 2; i < item4.Count; i++)
                {
                    result_string += item4[i].Name.Replace("MyWorkSpace:", "") + "__" + item4[i].InnerXml + "; ";
                }
                context.Response.Write(result_string);

            }
            catch { context.Response.Write(""); }


        }
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}