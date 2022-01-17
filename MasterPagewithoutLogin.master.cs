using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPagewithoutLogin : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //headerimg.Attributes["src"] = ResolveUrl("~/assets/images/mylh1.jpg");
            //headerimg1.Attributes["src"] = ResolveUrl("~/assets/images/mylh1.jpg");
        }
    }
    //protected void cmdlogout_Click(object sender, EventArgs e)
    //{
    //    Session["Userid"] = "";
    //    Session["UserWing"] = "";
    //    Session.Clear();
    //    Session.Abandon();
    //    Session.RemoveAll();

    //    if (Request.Cookies["ASP.NET_SessionId"] != null)
    //    {
    //        Response.Cookies["ASP.NET_SessionId"].Value = string.Empty;
    //        Response.Cookies["ASP.NET_SessionId"].Expires = DateTime.Now.AddMonths(-20);
    //    }

    //    if (Request.Cookies["AuthToken"] != null)
    //    {
    //        Response.Cookies["AuthToken"].Value = string.Empty;
    //        Response.Cookies["AuthToken"].Expires = DateTime.Now.AddMonths(-20);
    //    }
    //    Response.Redirect("login.aspx");
    //}
}
