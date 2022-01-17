using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!Page.IsPostBack)
            {
                //for session regeneration and security
                if (Session["Userid"] != null && Session["AuthToken"] != null && Request.Cookies["AuthToken"] != null)
                {
                    if (!Session["AuthToken"].ToString().Equals(Request.Cookies["AuthToken"].Value))
                    {
                        Response.Redirect("login.aspx");
                    }
                }
                else
                {
                    string url = Request.Url.AbsoluteUri;
                    //if(url.Contains("Index.aspx"))
                    //{
                        //cmdlogout.Visible = false;
                    //}
                   // else
                   // {
                        Response.Redirect("login.aspx");
                   // }                    
                }

                if (Convert.ToString(Session["UserWing"]) == "MYLREG" || Convert.ToString(Session["UserWing"]) == "MYL")
                {
                    headerimg.Attributes["src"] = ResolveUrl("~/assets/images/header.jpg");
                    headerimg1.Attributes["src"] = ResolveUrl("~/assets/images/header.jpg");
                }
                else if (Convert.ToString(Session["UserWing"]) == "WLREG" || Convert.ToString(Session["UserWing"]) == "WL")
                {
                    headerimg.Attributes["src"] = ResolveUrl("~/assets/images/WLh1.jpg");
                    headerimg1.Attributes["src"] = ResolveUrl("~/assets/images/WLh1.jpg");
                }
            }
        }
        catch (Exception ex)
        {
            StreamWriter sw = new StreamWriter(Server.MapPath("~/Errorlog.txt"), true);
            sw.WriteLine(DateTime.Now.ToString() + "MasterPage.aspx --> Page Load");
            sw.WriteLine(DateTime.Now.ToString() + ex.StackTrace);
            sw.WriteLine(DateTime.Now.ToString() + ex.Message);
            sw.WriteLine(DateTime.Now.ToString() + ex.InnerException);
            sw.Flush();
            sw.Close();
        }
    }
    protected void cmdlogout_Click(object sender, EventArgs e)
    {
        Session["Userid"] = "";
        Session["UserWing"] = "";
        Session.Clear();
        Session.Abandon();
        Session.RemoveAll();

        if (Request.Cookies["ASP.NET_SessionId"] != null)
        {
            Response.Cookies["ASP.NET_SessionId"].Value = string.Empty;
            Response.Cookies["ASP.NET_SessionId"].Expires = DateTime.Now.AddMonths(-20);
        }

        if (Request.Cookies["AuthToken"] != null)
        {
            Response.Cookies["AuthToken"].Value = string.Empty;
            Response.Cookies["AuthToken"].Expires = DateTime.Now.AddMonths(-20);
        }
        Response.Redirect("login.aspx");
    }
}
