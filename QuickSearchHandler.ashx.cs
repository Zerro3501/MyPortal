using System;
using System.Data;
using System.Data.OracleClient;
using System.Web;

namespace Web_Portal
{
    public class Handler1 : IHttpHandler
    {
        string connStr = "User Id=gm_test;Password=gm_test;Data Source=f40";
        OracleConnection orcl_conn;
        OracleCommand cmd;
        OracleDataReader reader;
        DataTable data_table = new DataTable();


        public void ProcessRequest(HttpContext context)
        {

            context.Response.ContentType = "text/plain";


            string searchParam = ""; //Текст строки поиска
            string searchDB = "";
            string SelectedBuilding = "";
            if (context.Request.QueryString["searchParam"] != null) searchParam = context.Request.QueryString["searchParam"];
            else { }
            if (context.Request.QueryString["searchDB"] != null) searchDB = context.Request.QueryString["searchDB"];
            else { }
            if (context.Request.QueryString["SelectedBuilding"] != null) SelectedBuilding = context.Request.QueryString["SelectedBuilding"];
            else { }


            //Запрос 15ти записей по введённой в поиске строке
            if (searchParam != "")
            {
                orcl_conn = new OracleConnection(connStr);
                orcl_conn.Open();
                cmd = orcl_conn.CreateCommand();
                //   cmd.CommandText = "select geometry2 from GMMIR.V_BUILD";
                // cmd.CommandText = "select* from table(select e.GEOMETRY2.SDO_ORDINATES from GMMIR.V_BUILD e where IPID =8960 )";
                cmd.CommandText = $"select NAME from GM_TEST.{searchDB} where ROWNUM <= 15 and NAME like '{searchParam}%'";
                //cmd.CommandText = $"select ADDRESS from GM_TEST.{searchDB} where ROWNUM <= 15 and ADDRESS like UPPER('%{searchParam}%')";

                reader = cmd.ExecuteReader(); //Неопознанная ошибка???

                string result = "";
                while (reader.Read())
                {

                    result += reader.GetValue(0) + ",,";
                }
                context.Response.Write(result);
            }
            //Получение объекта по завершённому слову
            else if (SelectedBuilding != "")
            {
                orcl_conn = new OracleConnection(connStr);
                orcl_conn.Open();
                cmd = orcl_conn.CreateCommand();

                cmd.CommandText = $"select id from GM_TEST.{searchDB} where ROWNUM <= 15 and NAME like '{SelectedBuilding}%'";
                reader = cmd.ExecuteReader(); //Неопознанная ошибка???

                string result = "";
                while (reader.Read())
                {

                    result += reader.GetValue(0);
                }
                context.Response.Write(result);
            }
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