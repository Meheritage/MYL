using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Globalization;
using System.Web.Configuration;
using System.Threading;

public partial class Index : System.Web.UI.Page
{
    string connectionstring = ConfigurationManager.ConnectionStrings["Register"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("form.aspx", false);
        }
        catch(Exception ex)
        {
            StreamWriter sw = new StreamWriter(Server.MapPath("~/Errorlog.txt"), true);
            sw.WriteLine(DateTime.Now.ToString() + " Index -> Pageload");
            sw.WriteLine(DateTime.Now.ToString() + ex.StackTrace);
            sw.WriteLine(DateTime.Now.ToString() + ex.Message);
            sw.WriteLine(DateTime.Now.ToString() + ex.InnerException);
            sw.Flush();
            sw.Close();
            Response.Redirect("Index.aspx", false);
        }
    }   

}