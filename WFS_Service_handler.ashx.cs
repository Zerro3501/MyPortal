using MSXML;
using System.Net;
using System.Web;

namespace Web_Portal
{
    /// <summary>
    /// Сводное описание для Handler3
    /// </summary>
    public class Handler3 : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";

            string layer_name = ""; //недописанная строка запроса
            if (context.Request.QueryString["layer_name"] != null) layer_name = context.Request.QueryString["layer_name"];
            else { }

            string url = $"http://localhost:8080/geoserver/cite/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=cite%3A{layer_name}&maxFeatures=50&outputFormat=application%2Fjson";

            var objXML = new XMLHTTPRequest();

            objXML.open("GET", url);
            objXML.send();

            WebRequest request = WebRequest.Create(url);
            WebResponse response = request.GetResponse();

            var response_text = "";

            using (System.IO.StreamReader stream = new System.IO.StreamReader(response.GetResponseStream(), System.Text.Encoding.UTF8))
            {
                response_text = stream.ReadToEnd();
            }

            //string path = "C:/Projects_VS/Web_Portal/GeoJson/text_GeoJSON_copy.json";
            //using (System.IO.StreamWriter stream = new System.IO.StreamWriter(path, false))
            //{
            //    stream.Write(response_text);
            //}

            context.Response.Write(response_text);
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