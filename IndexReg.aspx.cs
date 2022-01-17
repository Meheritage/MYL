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

public partial class IndexReg : System.Web.UI.Page
{
    string connectionstring = ConfigurationManager.ConnectionStrings["Register"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        txtfromdate.Attributes.Add("readonly", "readonly");
        try
        {
            dtleaveFrmdate.EndDate = DateTime.Now.AddYears(-25);
            dtleaveFrmdate.StartDate = DateTime.Now.AddYears(-50);
            if (!IsPostBack)
            {
                BindDistrict();
                if (!String.IsNullOrEmpty(Request.QueryString["RegEd"]))
                {
                    // Query string value is there so now use it
                    int thePID = Convert.ToInt32(Request.QueryString["RegEd"]);
                    if(thePID ==2 && Convert.ToString(Session["RegNo"])!="")
                    {
                        Session["RegEd"] = "2";
                        ViewRequestDetails();
                    }
                }
                else
                {
                    if (Convert.ToString(Session["UserWing"]) == "MYLREG")
                    {
                        //team.Items[2].Selected = true;
                        //team.Disabled = true;
                    }
                    else if (Convert.ToString(Session["UserWing"]) == "WLREG")
                    {
                        gender.Items[2].Selected = true;
                        gender.Disabled = true;
                        //team.Items[4].Selected = true;
                        //team.Disabled = true;                        
                    }
                }
            }
        }
        catch(Exception ex)
        {
            StreamWriter sw = new StreamWriter(Server.MapPath("~/Errorlog.txt"), true);
            sw.WriteLine(DateTime.Now.ToString() + " JoinIUML -> Pageload");
            sw.WriteLine(DateTime.Now.ToString() + ex.StackTrace);
            sw.WriteLine(DateTime.Now.ToString() + ex.Message);
            sw.WriteLine(DateTime.Now.ToString() + ex.InnerException);
            sw.Flush();
            sw.Close();
            Response.Redirect("Index.aspx", false);
        }
    }
    private void BindDistrict()
    {
        SqlDataAdapter daViewRequestDetail = new SqlDataAdapter();
        DataSet ds = new DataSet();
        try
        {
            using (SqlConnection con = new SqlConnection(connectionstring))
            {
                DataTable dtViewRequestDetail = new DataTable();
                daViewRequestDetail = new SqlDataAdapter("SELECT * FROM tblDistrict WHERE isActive=1", con);
                daViewRequestDetail.Fill(ds);
                district.DataSource = ds;
                district.DataTextField = "DistDesc";
                district.DataValueField = "DistName";
                district.DataBind();
            }
        }
        catch (Exception ex)
        {
            StreamWriter sw = new StreamWriter(Server.MapPath("~/Errorlog.txt"), true);
            sw.WriteLine(DateTime.Now.ToString() + " Index.aspx -> BindDistrict");
            sw.WriteLine(DateTime.Now.ToString() + ex.StackTrace);
            sw.WriteLine(DateTime.Now.ToString() + ex.Message);
            sw.WriteLine(DateTime.Now.ToString() + ex.InnerException);
            sw.Flush();
            sw.Close();
            Response.Redirect("Index.aspx", false);
        }
    }
    private void ViewRequestDetails()
    {
        SqlDataAdapter daViewRequestDetail = new SqlDataAdapter();
        try
        {
            string strrMobileNo = Convert.ToString(Session["RegNo"]);
            using (SqlConnection con = new SqlConnection(connectionstring))
            {
                DataTable dtViewRequestDetail = new DataTable();
                if(Convert.ToString(Session["printed"])=="1")
                {
                    daViewRequestDetail = new SqlDataAdapter("SELECT * FROM tblregisteration WHERE regNo='" + strrMobileNo + "' AND isnull(regprint,0) =1", con);
                }
                else
                {
                    daViewRequestDetail = new SqlDataAdapter("SELECT * FROM tblregisteration WHERE regNo='" + strrMobileNo + "' AND isnull(regprint,0) =0", con);
                }
               
                daViewRequestDetail.Fill(dtViewRequestDetail);
                if (Convert.ToInt32(dtViewRequestDetail.Rows.Count) > 0)
                {
                    name.Value = Convert.ToString(dtViewRequestDetail.Rows[0]["regName"]);
                    father_name.Value = Convert.ToString(dtViewRequestDetail.Rows[0]["regParentName"]);
                    gender.Value= Convert.ToString(dtViewRequestDetail.Rows[0]["regGender"]);
                    // txtfromdate.Text = Convert.ToString(dtViewRequestDetail.Rows[0]["regDOB"]);
                    txtfromdate.Text = Convert.ToDateTime(dtViewRequestDetail.Rows[0]["regDOB"].ToString()).ToString("dd/MM/yyyy");

                    identitycard.Value = Convert.ToString(dtViewRequestDetail.Rows[0]["regIdentityType"]);
                    identityCardNo.Value = Convert.ToString(dtViewRequestDetail.Rows[0]["regVoterid"]);
                    txtMobileNo.Value = Convert.ToString(dtViewRequestDetail.Rows[0]["regMobileNo"]);
                    emailid.Value = Convert.ToString(dtViewRequestDetail.Rows[0]["regEmail"]);
                    //constiuency.Value = Convert.ToString(dtViewRequestDetail.Rows[0]["regConstituency"]);
                    txtadress.Value = Convert.ToString(dtViewRequestDetail.Rows[0]["regAddress"]);
                    district.Value = Convert.ToString(dtViewRequestDetail.Rows[0]["regDistrict"]);
                    //team.Value = Convert.ToString(dtViewRequestDetail.Rows[0]["regTeam"]);
                    // FileUpload1.ResolveUrl= Convert.ToString(dtViewRequestDetail.Rows[0]["regTeam"]);
                    imgEditphoto.ImageUrl = Convert.ToString(dtViewRequestDetail.Rows[0]["regphotoloc"]);
                    bloodgroup.Value= Convert.ToString(dtViewRequestDetail.Rows[0]["regBlood"]);
                    txtdesination.Value= Convert.ToString(dtViewRequestDetail.Rows[0]["regWard"]);
                    txtdesination.Visible = true;
                    txtadress2.Value = Convert.ToString(dtViewRequestDetail.Rows[0]["regAddress2"]);
                    txtadress3.Value = Convert.ToString(dtViewRequestDetail.Rows[0]["regAddress3"]);
                    txtwhatsapp.Value= Convert.ToString(dtViewRequestDetail.Rows[0]["regwhatsapp"]);                 
                    lbldes.Visible = true;
                    chkboxotherparty.Checked = true;
                    btnsubmit.Visible = false;
                    btnUpdate.Visible = true;
                    Photoinsert.Visible = false;
                    updatephoto.Visible = true;
                    btncancel.Visible = true;
                }
                else
                {
                    Response.Redirect("MembersList.aspx", false);
                }
            }
        }
        catch(Exception ex)
        {
            StreamWriter sw = new StreamWriter(Server.MapPath("~/Errorlog.txt"), true);
            sw.WriteLine(DateTime.Now.ToString() + " JoinIUML -> ViewRequestDetails");
            sw.WriteLine(DateTime.Now.ToString() + ex.StackTrace);
            sw.WriteLine(DateTime.Now.ToString() + ex.Message);
            sw.WriteLine(DateTime.Now.ToString() + ex.InnerException);
            sw.Flush();
            sw.Close();
            Response.Redirect("Index.aspx", false);
        }
    }
    private void UpdateEmployee()
    {
        Thread.CurrentThread.CurrentCulture = new CultureInfo("en-GB");
        try
        {
            using (SqlConnection con = new SqlConnection(connectionstring))
            {
                string strMobileNo = Convert.ToString(Session["RegNo"]);
                if (strMobileNo != string.Empty && Convert.ToString(Session["RegEd"])=="2")
                {
                 con.Open();                    
                    SqlCommand cmd = new SqlCommand("spUpdateMember @empName, @empPname, @empGender, @empemailid, @empVoterid,@empState,@empDistrict, @empConstituency,@empMobileNo, @empphotoloc, @empDOB,@empIdentityType,@empAddress,@empTeam,@empBlood,@empregNO,@empuser,@empregDestin,@empAddress2,@empAddress3,@empwhatsapp", con);
                cmd.Parameters.AddWithValue("@empName", name.Value);
                cmd.Parameters.AddWithValue("@empPname", father_name.Value);
                cmd.Parameters.AddWithValue("@empGender", gender.Value);
                cmd.Parameters.AddWithValue("@empemailid", emailid.Value);
                cmd.Parameters.AddWithValue("@empVoterid", identityCardNo.Value);
                cmd.Parameters.AddWithValue("@empState", "TamilNadu");
                cmd.Parameters.AddWithValue("@empDistrict", district.Value);
                cmd.Parameters.AddWithValue("@empConstituency", "0");
                cmd.Parameters.AddWithValue("@empMobileNo", txtMobileNo.Value);
                    string strFileName = string.Empty;
                    if (FileUpload2.HasFile)
                    {
                        string fileexe = Path.GetExtension(FileUpload2.FileName).ToLower();
                        if(fileexe == ".jpg" || fileexe == ".jpeg" || fileexe == ".png" || fileexe == ".bmp")
                        {
                            Random random = new Random();
                            int rndvalue = random.Next(100000);
                            strFileName = "~/assets/memberspoto/" + txtMobileNo.Value + "_" + identityCardNo.Value + rndvalue + fileexe;
                            FileUpload2.PostedFile.SaveAs(Server.MapPath(strFileName));
                        }
                        else
                        {
                            strFileName = imgEditphoto.ImageUrl;
                        }
                        //Random random = new Random();
                        //int rndvalue = random.Next(100000);
                        //strFileName = "~/assets/memberspoto/" + txtMobileNo.Value + "_" + identityCardNo.Value + rndvalue + fileexe;
                        //FileUpload2.PostedFile.SaveAs(Server.MapPath(strFileName));
                    }
                    else
                    {
                        strFileName = imgEditphoto.ImageUrl;
                    }              
               
                cmd.Parameters.AddWithValue("@empphotoloc",strFileName);
                if (!string.IsNullOrEmpty(txtfromdate.Text))
                {
                    DateTime dtdob = DateTime.ParseExact(txtfromdate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                    cmd.Parameters.AddWithValue("@empDOB", dtdob.ToString("yyyy-MM-dd"));
                }
                else
                {
                    cmd.Parameters.AddWithValue("@empDOB", "");
                }
                cmd.Parameters.AddWithValue("@empIdentityType", identitycard.Value);
                cmd.Parameters.AddWithValue("@empAddress", txtadress.Value);
                cmd.Parameters.AddWithValue("@empTeam", "MYL");
                cmd.Parameters.AddWithValue("@empBlood", bloodgroup.Value);
                cmd.Parameters.AddWithValue("@empregNO", strMobileNo);
                cmd.Parameters.AddWithValue("@empuser", Convert.ToString(Session["Loginuser"]));
                cmd.Parameters.AddWithValue("@empregDestin", txtdesination.Value);
                cmd.Parameters.AddWithValue("@empAddress2", txtadress2.Value);
                cmd.Parameters.AddWithValue("@empAddress3", txtadress3.Value);
                cmd.Parameters.AddWithValue("@empwhatsapp", txtwhatsapp.Value);

                    var empseq = cmd.ExecuteScalar();
                cmd.Dispose();
                con.Close();
                Session["RegNo"] = "";
               Session["RegEd"] = "";                
                }
            }
         }
        catch(Exception ex)
        {
            StreamWriter sw = new StreamWriter(Server.MapPath("~/Errorlog.txt"), true);
            sw.WriteLine(DateTime.Now.ToString() + " JoinIUML -> UpdateEmployee");
            sw.WriteLine(DateTime.Now.ToString() + ex.StackTrace);
            sw.WriteLine(DateTime.Now.ToString() + ex.Message);
            sw.WriteLine(DateTime.Now.ToString() + ex.InnerException);
            sw.Flush();
            sw.Close();
            Response.Redirect("Index.aspx", false);
        }
     }

    private void SaveEmployee()
    {
        Thread.CurrentThread.CurrentCulture = new CultureInfo("en-GB");
        try
        {
            string strMobileNo = Convert.ToString(Session["MobileNO"]);
            using (SqlConnection con = new SqlConnection(connectionstring))
            {
                if (strMobileNo != string.Empty)
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("spinsertNewMember @empName, @empPname, @empGender, @empemailid, @empVoterid,@empState,@empDistrict, @empConstituency,@empMobileNo, @empphotoloc, @empDOB,@empIdentityType,@empAddress,@empTeam,@empBlood,@empAddress2,@empAddress3", con);
                    //cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@empName", name.Value);
                    cmd.Parameters.AddWithValue("@empPname", father_name.Value);
                    cmd.Parameters.AddWithValue("@empGender", gender.Value);
                    cmd.Parameters.AddWithValue("@empemailid", emailid.Value);
                    cmd.Parameters.AddWithValue("@empVoterid", identityCardNo.Value);
                    cmd.Parameters.AddWithValue("@empState", "TamilNadu");
                    cmd.Parameters.AddWithValue("@empDistrict", district.Value);
                    cmd.Parameters.AddWithValue("@empConstituency", "0");                   
                    cmd.Parameters.AddWithValue("@empMobileNo", strMobileNo);

                    //string strFileName = string.Empty;
                    //string fileexe = Path.GetExtension(FileUpload1.FileName).ToLower();
                    //Random random = new Random();
                    //int rndvalue = random.Next(100000);
                    //strFileName = strMobileNo + "_" + identityCardNo.Value + rndvalue + fileexe;
                    //FileUpload1.PostedFile.SaveAs(Server.MapPath("~/assets/memberspoto/") + strFileName);

                    //cmd.Parameters.AddWithValue("@empphotoloc", "assets/memberspoto/" + strFileName);

                    string strFileName = string.Empty;
                    if (FileUpload1.HasFile)
                    {
                        string fileexe = Path.GetExtension(FileUpload1.FileName).ToLower();
                        if (fileexe == ".jpg" || fileexe == ".jpeg" || fileexe == ".png" || fileexe == ".bmp")
                        {                            
                            Random random = new Random();
                            int rndvalue = random.Next(100000);
                            strFileName = "~/assets/memberspoto/" + txtMobileNo.Value + "_" + identityCardNo.Value + rndvalue + fileexe;
                            FileUpload1.PostedFile.SaveAs(Server.MapPath(strFileName));
                        }
                        else
                        {
                            strFileName = "~/assets/memberspoto/white.jpg";
                        }
                    }
                    else
                    {
                        strFileName = "~/assets/memberspoto/white.jpg";
                    }

                    cmd.Parameters.AddWithValue("@empphotoloc", strFileName);

                    if (!string.IsNullOrEmpty(txtfromdate.Text))
                    {
                        DateTime dtdob = DateTime.ParseExact(txtfromdate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                        cmd.Parameters.AddWithValue("@empDOB", dtdob.ToString("yyyy-MM-dd"));
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@empDOB", "");
                    }                  
                    cmd.Parameters.AddWithValue("@empIdentityType", identitycard.Value);
                    cmd.Parameters.AddWithValue("@empAddress", txtadress.Value);
                    cmd.Parameters.AddWithValue("@empTeam", "MYL");
                    cmd.Parameters.AddWithValue("@empBlood", bloodgroup.Value);
                    cmd.Parameters.AddWithValue("@empAddress2", txtadress2.Value);
                    cmd.Parameters.AddWithValue("@empAddress3", txtadress3.Value);
                    cmd.Parameters.AddWithValue("@empwhatsapp", txtwhatsapp.Value);
                    var empseq = cmd.ExecuteScalar();
                    cmd.Dispose();
                    con.Close();
                }
                else
                {
                    Response.Redirect("Index.aspx", false);
                    //Server.Transfer("Index.aspx");
                }
            }
        }
        catch (Exception ex)
        {
            StreamWriter sw = new StreamWriter(Server.MapPath("~/Errorlog.txt"), true);
            sw.WriteLine(DateTime.Now.ToString() + " JoinIUML -> SaveEmployee");
            sw.WriteLine(DateTime.Now.ToString() + ex.StackTrace);
            sw.WriteLine(DateTime.Now.ToString() + ex.Message);
            sw.WriteLine(DateTime.Now.ToString() + ex.InnerException);
            sw.Flush();
            sw.Close();
            Response.Redirect("Index.aspx", false);
        }
    }       

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        SqlDataAdapter daMobilNoExist = new SqlDataAdapter();
        try
        {
            Session["MobileNO"] = txtMobileNo.Value;
            DataTable dtMobilNoExist = new DataTable();
            daMobilNoExist = new SqlDataAdapter("SELECT COUNT(*) FROM tblregisteration WHERE regMobileNo='" + txtMobileNo.Value + "' AND Isactive=1", connectionstring);
            daMobilNoExist.Fill(dtMobilNoExist);           
            if (Convert.ToInt32(dtMobilNoExist.Rows[0][0]) == 0)
            {
                SaveEmployee();
                btnsubmit.Enabled = false;
                //Response.Write("<script>alert('Registered successfully')</script>");
                Session["MobileNO"] = "";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('உங்கள் தகவல் பதிவுசெய்யப்பட்டுள்ளது. இந்திய யூனியன் முஸ்லீம் லீக்கில் இணைய விருப்பம் தெரிவித்ததற்கு நன்றி. விரைவில் மாவட்ட தலைமையிலிருந்து தொடர்ப்பு கொள்வார்கள்.');window.location.href='Index.aspx';", true);
               // Response.Redirect("JoinIUML.aspx", false);
            }
            else
            {
                lblMsg.Text = "Mobile No is already registered";
            }
            //SaveEmployee();
            //Response.Write("<script>alert('Registered successfully')</script>");
            //Session["MobileNO"] = "";
            //Session["MobileNOOTP"] = "";
            //Response.Redirect("Index.aspx", false);           
        }
        catch(Exception ex)
        {
            StreamWriter sw = new StreamWriter(Server.MapPath("~/Errorlog.txt"), true);
            sw.WriteLine(DateTime.Now.ToString() + " JoinIUML -> btnsubmit_Click");
            sw.WriteLine(DateTime.Now.ToString() + ex.StackTrace);
            sw.WriteLine(DateTime.Now.ToString() + ex.Message);
            sw.WriteLine(DateTime.Now.ToString() + ex.InnerException);
            sw.Flush();
            sw.Close();
            Response.Redirect("Index.aspx", false);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("MembersList.aspx", false);
    }
       
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        SqlDataAdapter daMobilNoExist = new SqlDataAdapter();
        try
        {           
            DataTable dtMobilNoExist = new DataTable();
            daMobilNoExist = new SqlDataAdapter("SELECT COUNT(*) FROM tblregisteration WHERE regNo='" + Convert.ToString(Session["RegNo"]) +"'" , connectionstring);
            daMobilNoExist.Fill(dtMobilNoExist);
            if (Convert.ToInt32(dtMobilNoExist.Rows[0][0]) > 0)
            {
                UpdateEmployee();
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('உங்கள் தகவல் பதிவுசெய்யப்பட்டுள்ளது.');window.location.href='MembersList.aspx';", true);
            }                                
        }
        catch (Exception ex)
        {
            StreamWriter sw = new StreamWriter(Server.MapPath("~/Errorlog.txt"), true);
            sw.WriteLine(DateTime.Now.ToString() + " JoinIUML -> btnUpdate_Click");
            sw.WriteLine(DateTime.Now.ToString() + ex.StackTrace);
            sw.WriteLine(DateTime.Now.ToString() + ex.Message);
            sw.WriteLine(DateTime.Now.ToString() + ex.InnerException);
            sw.Flush();
            sw.Close();
            Response.Redirect("Index.aspx", false);
        }
    }

}