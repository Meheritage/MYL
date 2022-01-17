using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net;
using System.Text;
using System.Collections.Specialized;
using System.Globalization;
using System.Web.Configuration;
using System.Threading;
using System.Threading.Tasks;
using System.Security.Cryptography;


public partial class login : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Register"].ConnectionString);
   // Common comobj = new Common();
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
            }
        }
        catch (Exception ex)
        {
            StreamWriter sw = new StreamWriter(Server.MapPath("~/Errorlog.txt"), true);
            sw.WriteLine(DateTime.Now.ToString() + "Login.aspx --> Page Load");
            sw.WriteLine(DateTime.Now.ToString() + ex.StackTrace);
            sw.WriteLine(DateTime.Now.ToString() + ex.Message);
            sw.WriteLine(DateTime.Now.ToString() + ex.InnerException);
            sw.Flush();
            sw.Close();
        }
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {        
        SqlDataAdapter daLoginExist = new SqlDataAdapter();
        try
        {
            Session["isDownload"] = "0";
            //Put a breakpoint below and get into the function to decrypt tthe password
            string hdnpw = Common.DecryptStringAES(hdnPassword.Value.ToString());
            string password = string.Empty;
            string salt = string.Empty;
            salt = hdnpw.Substring(1, 3);
            password = Common.EncryptHashText(salt + hdnpw, true);
            string session = System.Web.HttpContext.Current.Session.SessionID;
            //Logincredentials with Encryptedpassword          
            
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT * FROM [tblregUser] WHERE (([username] = @username) AND ([userpass] = @userpass))", con);
            cmd.Parameters.AddWithValue("@username", txtuserName.Text);           
            cmd.Parameters.AddWithValue("@userpass", password);
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            System.Data.DataTable dtLoginExist = new System.Data.DataTable();
            adp.Fill(dtLoginExist);
            adp.Dispose();
            cmd.Dispose();
            con.Close();
            if (dtLoginExist.Rows.Count > 0)
            {
                Session["UserWing"] = Convert.ToString(dtLoginExist.Rows[0]["useraccess"]);
                Session["Userid"] = Convert.ToString(dtLoginExist.Rows[0]["username"]);
                Session["UserZone"] = Convert.ToString(dtLoginExist.Rows[0]["Zone"]);
                // createa a new GUID and save into the session
                string guid = Guid.NewGuid().ToString();
                Session["AuthToken"] = guid;
                // now create a new cookie with this guid value
                Response.Cookies.Add(new HttpCookie("AuthToken", guid));
                if (Convert.ToString(dtLoginExist.Rows[0]["useraccess"])== "MYLREG")
                {
                    Response.Redirect("IndexReg.aspx", false);
                }
                else if (Convert.ToString(dtLoginExist.Rows[0]["useraccess"]) == "WLREG")
                {
                    Response.Redirect("IndexReg.aspx", false);
                }
                else
                {
                    Response.Redirect("MembersList.aspx", false);
                }
               
               // Response.Redirect("CreateUser.aspx", false);
            }
            else
            {
                lblMsg.Text = "Login failed";
            }

                //DataTable dtLoginExist = new DataTable();
                //daLoginExist = new SqlDataAdapter("SELECT * FROM tblregUser WHERE username='" + txtuserName.Text + "' AND userpass='"+ txtUserpass.Text + "'", con);
                //daLoginExist.Fill(dtLoginExist);       

            //    if (Convert.ToInt32(dtLoginExist.Rows.Count) > 0)
            //{
            //    Session["UserWing"] = Convert.ToString(dtLoginExist.Rows[0]["useraccess"]);
            //    Response.Redirect("MembersList.aspx", false);
            //}
            //else
            //{
            //    lblMsg.Text = "Login failed";
            //}
        }
        catch (Exception ex)
        {            
            StreamWriter sw = new StreamWriter(Server.MapPath("~/Errorlog.txt"), true);
            sw.WriteLine(DateTime.Now.ToString() + "login.aspx -> btnsubmit_Click");
            sw.WriteLine(DateTime.Now.ToString() + ex.StackTrace);
            sw.WriteLine(DateTime.Now.ToString() + ex.Message);
            sw.WriteLine(DateTime.Now.ToString() + ex.InnerException);
            sw.Flush();
            sw.Close();
        }
    }
}