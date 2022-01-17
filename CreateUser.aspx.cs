using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


public partial class CreateUser : System.Web.UI.Page
{
    string strcon = Convert.ToString(ConfigurationManager.ConnectionStrings["Register"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!Page.IsPostBack)
            {
               
            }
        }
        catch (Exception ex)
        {
            StreamWriter sw = new StreamWriter(Server.MapPath("~/Errorlog.txt"), true);
            sw.WriteLine(DateTime.Now.ToString() + "CreateUser.aspx --> Page Load");
            sw.WriteLine(DateTime.Now.ToString() + ex.StackTrace);
            sw.WriteLine(DateTime.Now.ToString() + ex.Message);
            sw.WriteLine(DateTime.Now.ToString() + ex.InnerException);
            sw.Flush();
            sw.Close();
        }
    }

    protected void txtUserName_TextChanged(object sender, EventArgs e)
    {
        //if (txtUserName.Text != string.Empty)
        //    viewUser();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            saveUser();
            //clearFields();
        }
        catch(Exception ex)
        {
            StreamWriter sw = new StreamWriter(Server.MapPath("~/Errorlog.txt"), true);
            sw.WriteLine(DateTime.Now.ToString() + "CreateUser.aspx --> btnSave_Click");
            sw.WriteLine(DateTime.Now.ToString() + ex.StackTrace);
            sw.WriteLine(DateTime.Now.ToString() + ex.Message);
            sw.WriteLine(DateTime.Now.ToString() + ex.InnerException);
            sw.Flush();
            sw.Close();
        }        
    }

    protected void btncancel_Click(object sender, EventArgs e)
    {
        try
        {
           clearFields();
        }
        catch (Exception ex)
        {
            StreamWriter sw = new StreamWriter(Server.MapPath("~/Errorlog.txt"), true);
            sw.WriteLine(DateTime.Now.ToString() + "CreateUser.aspx --> btncancel_Click");
            sw.WriteLine(DateTime.Now.ToString() + ex.StackTrace);
            sw.WriteLine(DateTime.Now.ToString() + ex.Message);
            sw.WriteLine(DateTime.Now.ToString() + ex.InnerException);
            sw.Flush();
            sw.Close();
        }
    }
    private void clearFields()
    {
        Response.Redirect("CreateUser.aspx");
    }
    private void saveUser()
    {
        try
        {
            string password = string.Empty;
            string salt = string.Empty;
            salt = txtPwd.Text.Substring(1, 3);
            password = Common.EncryptHashText(salt + txtPwd.Text, true);
            using (SqlConnection con = new SqlConnection(strcon))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("spSaveUser @username,@password,@wings,@isenabled", con);
                cmd.Parameters.AddWithValue("@username", txtUserName.Text);
                cmd.Parameters.AddWithValue("@password", password);
                cmd.Parameters.AddWithValue("@wings", ddldir.SelectedValue);
                cmd.Parameters.AddWithValue("@isenabled", true );
                var userseq = cmd.ExecuteScalar();
                cmd.Dispose();
                con.Close();
                txtUserName.Text = "";
                txtPwd.Text = "";
              
                pid.InnerHtml = "User Created SuccessFully";
            }
        }
        catch (Exception ex)
        {
            StreamWriter sw = new StreamWriter(Server.MapPath("~/Errorlog.txt"), true);
            sw.WriteLine(DateTime.Now.ToString() + "CreateUser.aspx --> saveUser");
            sw.WriteLine(DateTime.Now.ToString() + ex.StackTrace);
            sw.WriteLine(DateTime.Now.ToString() + ex.Message);
            sw.WriteLine(DateTime.Now.ToString() + ex.InnerException);
            sw.Flush();
            sw.Close();
            pid.InnerHtml = "User Creation Failed";
        }        
    }
}