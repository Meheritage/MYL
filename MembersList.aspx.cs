using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Configuration;
using System.IO.Compression;
using System.Globalization;
using System.Collections;
using ExcelLibrary.SpreadSheet;
using System.Drawing;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;




public partial class MembersList : System.Web.UI.Page
{

    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Register"].ConnectionString);
       
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {            
            if (!Page.IsPostBack)
            {
                btnSearch.BackColor = Color.FromArgb(56, 106, 138);
                if (Convert.ToString(Session["printed"]) == "1")
                {
                    BindGrid("1");
                    btnPrintedMemberslist.BackColor = Color.FromArgb(234, 188, 18); //"rgb(234 188 18)";
                    btnNewMemberslist.BackColor = Color.FromArgb(56, 106, 138);
                }
                else
                {
                    BindGrid("0");
                    btnNewMemberslist.BackColor = Color.FromArgb(234, 188, 18); //"rgb(234 188 18)";
                    btnPrintedMemberslist.BackColor = Color.FromArgb(56, 106, 138);
                }
                //if (Convert.ToString(Session["Printpath"]) != null || Convert.ToString(Session["Printpath"]) != "")
                //{
                //    ScriptManager.RegisterStartupScript(this, typeof(string), "OPEN_WINDOW", "var Mleft = (screen.width/2)-(760/2);var Mtop = (screen.height/2)-(700/2);window.open( '" + Convert.ToString(Session["Printpath"]) + "', null, 'height=700,width=760,status=yes,toolbar=no,scrollbars=yes,menubar=no,location=no,top=\'+Mtop+\', left=\'+Mleft+\'' );", true);
                //}

            if (Convert.ToString(Session["isDownload"]) == "1")
                {  
                    Response.ContentType = "Application/pdf";
                    Response.AppendHeader("Content-Disposition", "attachment; filename=" + Convert.ToString(Session["strNewFilePath"]));
                    Response.TransmitFile(Convert.ToString(Session["strNewFilePath1"]));
                    Response.End();
                    Session["strNewFilePath"] = "";
                    Session["strNewFilePath1"] = "";
                    Session["isDownload"] = "0";
                }
            }            
        }
        catch(Exception ex)
        {
            StreamWriter sw = new StreamWriter(Server.MapPath("~/Errorlog.txt"), true);
            sw.WriteLine(DateTime.Now.ToString() + "Memberlist.aspx --> Pageload");
            sw.WriteLine(DateTime.Now.ToString() + ex.StackTrace);
            sw.WriteLine(DateTime.Now.ToString() + ex.Message);
            sw.WriteLine(DateTime.Now.ToString() + ex.InnerException);
            sw.Flush();
            sw.Close();
        }
    }
    private void BindGrid(string strprint)
    {
        SqlDataAdapter daMemberlist = new SqlDataAdapter();
        try
        {
            //btndownload.Visible = true;
            btnDelete.Visible = true;
            
            //if (Convert.ToString(Session["UserWing"]) == "MYL")
            //{
            //    strquery = "regTeam ='MYL'"; 
            //}else
            //{
            //    strquery = "regTeam !='MYL'";
            //}

            string basequery = string.Empty;
            string DynamicQuery = string.Empty;
            basequery = "SELECT * FROM tblregisteration where Isactive = 1";
            DataTable dtMemberlist = new DataTable();

            //*****************************************************
            // This is for inclusion for search criteria
            //*****************************************************
            if (txtSearch.Text != "") 
            {
                DynamicQuery = " and regName LIKE '%" + txtSearch.Text + "%' ";
                basequery = basequery + DynamicQuery;
                txtSearch.Text = "";
            }

            //*****************************************************
            // This is for inclusion of zone
            //*****************************************************
            if (Convert.ToInt32(Session["UserZone"]) != 0) 
            {
                DynamicQuery = " and regZone=" + Convert.ToInt32(Session["UserZone"]);
                basequery = basequery + DynamicQuery;
            }

            //*****************************************************
            // This is to define the card is already Printed or not
            //*******************************************************
            if (strprint == "1")  
            {
                DynamicQuery = " and regprint=1";
                btnPrintedMemberslist.BackColor = Color.FromArgb(234, 188, 18); //"rgb(234 188 18)";
                btnNewMemberslist.BackColor = Color.FromArgb(56, 106, 138);
            }
            else
            {
                DynamicQuery = " and regprint=0";
                btnNewMemberslist.BackColor = Color.FromArgb(234, 188, 18); //"rgb(234 188 18)";
                btnPrintedMemberslist.BackColor = Color.FromArgb(56, 106, 138);
            }
            basequery = basequery + DynamicQuery;

            //*****************************************************
            // This is to define the team or Wing
            //*****************************************************
            DynamicQuery = " and regTeam ='" + Convert.ToString(Session["UserWing"]) + "' "; 
            basequery = basequery + DynamicQuery;



            //string strSelectqury = string.Empty;
            //if (Convert.ToInt32(Session["UserZone"])==0)
            //{
            //    strSelectqury = "SELECT * FROM tblregisteration where Isactive=1 and " + strTeamquery + strrprint;
            //}
            //else
            //{
            //    strSelectqury = "SELECT * FROM tblregisteration where Isactive=1 and regZone=" + Convert.ToInt32(Session["UserZone"]) + " and " + strTeamquery + strrprint;
            //}
            daMemberlist = new SqlDataAdapter(basequery, con);
            //daMemberlist = new SqlDataAdapter("SELECT * FROM tblregisteration where Isactive=1 and regprint=0 and " + strTeamquery, con);
            daMemberlist.Fill(dtMemberlist);
            //lblCount.Text = "Records Count : " + dtMemberlist.Rows.Count.ToString();
            if (dtMemberlist.Rows.Count > 0)
            {
                DataView dv = dtMemberlist.DefaultView;
                dv.Sort = "regNo desc";
                DataTable sortedDT = dv.ToTable();
                grdMembersList.DataSource = sortedDT;
                grdMembersList.DataBind();
            }
            else
            {              
                DataView dv = dtMemberlist.DefaultView;
                dv.Sort = "regNo asc";
                DataTable sortedDT = dv.ToTable();
                grdMembersList.DataSource = null;
                grdMembersList.DataBind();
                //btndownload.Visible = false;
                btnDelete.Visible= false;
            }
        }
        catch (Exception ex)
        {
            StreamWriter sw = new StreamWriter(Server.MapPath("~/Errorlog.txt"), true);
            sw.WriteLine(DateTime.Now.ToString() + "Memberlist.aspx --> BindGrid");
            sw.WriteLine(DateTime.Now.ToString() + ex.StackTrace);
            sw.WriteLine(DateTime.Now.ToString() + ex.Message);
            sw.WriteLine(DateTime.Now.ToString() + ex.InnerException);
            sw.Flush();
            sw.Close();
        }
    }

    protected void grdMembersList_RowDataBound(object sender, Obout.Grid.GridRowEventArgs e)
    {
        if (e.Row.RowType == Obout.Grid.GridRowType.DataRow)
        {
            if (e.Row.Cells[9].Text == "True")
            {                
                    e.Row.Cells[9].ForeColor = System.Drawing.Color.Green;
                    e.Row.Cells[9].Text = "Card Printed";                             
            }
            else if (e.Row.Cells[9].Text == "False")
            {
                e.Row.Cells[9].ForeColor = System.Drawing.Color.Green;
                e.Row.Cells[9].Text = "Card not Printed";
            }

            
            switch (Convert.ToString(Session["UserWing"]))
            {
                case "MSF":                    
                    e.Row.Cells[10].Visible = false;
                    break;
                case "IUML":
                    e.Row.Cells[10].Visible = false;
                    break;                
            }
        }        
    }
    
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        try
        {
            Session["RegNo"] = grdMembersList.Rows[Int32.Parse(((Button)sender).CommandArgument)].Cells[1].Text;
            Session["isDownload"] = "0";
            //string applType = grdApplications.Rows[Int32.Parse(((Button)sender).CommandArgument)].Cells[6].Text;
            Response.Redirect("IndexReg.aspx?RegEd=2", false);
        }
        catch(Exception ex)
        {
            StreamWriter sw = new StreamWriter(Server.MapPath("~/Errorlog.txt"), true);
            sw.WriteLine(DateTime.Now.ToString() + " MembersList -> btnEdit_Click");
            sw.WriteLine(DateTime.Now.ToString() + ex.StackTrace);
            sw.WriteLine(DateTime.Now.ToString() + ex.Message);
            sw.WriteLine(DateTime.Now.ToString() + ex.InnerException);
            sw.Flush();
            sw.Close();
        }
    }
    protected void btnPrint_Click(object sender, EventArgs e)
    {
        try
        {
            Session["MNo"] = grdMembersList.Rows[Int32.Parse(((Button)sender).CommandArgument)].Cells[4].Text;
            Session["RegNo"] = grdMembersList.Rows[Int32.Parse(((Button)sender).CommandArgument)].Cells[1].Text;
            Session["RegIsprint"] = grdMembersList.Rows[Int32.Parse(((Button)sender).CommandArgument)].Cells[9].Text;
            Response.Redirect("PrintCard.aspx");
        }
        catch (Exception ex)
        {
            StreamWriter sw = new StreamWriter(Server.MapPath("~/Errorlog.txt"), true);
            sw.WriteLine(DateTime.Now.ToString() + "Memberlist.aspx --> btnPrint_Click");
            sw.WriteLine(DateTime.Now.ToString() + ex.StackTrace);
            sw.WriteLine(DateTime.Now.ToString() + ex.Message);
            sw.WriteLine(DateTime.Now.ToString() + ex.InnerException);
            sw.Flush();
            sw.Close();
        }

    }
    
    protected void btndownload_Click(object sender, EventArgs e)
    {
        try
        {
            string strrRegno = string.Empty;
            DataSet dsDownload = new DataSet();
            Random rnd = new Random();
            string randomNumber = (rnd.Next(1,100)).ToString();
            strrRegno = hdnslectedvalue.Value;
            strrRegno = strrRegno.Remove(strrRegno.Length - 1);
            dsDownload = Common.DownloadAllselectedRecord(strrRegno);
            hdnslectedvalue.Value = "";
            string strfilepath = "RegisterMembers_" + DateTime.Now.ToString("ddMMyyyy")+ "_" + randomNumber + ".xlsx";
            if (dsDownload.Tables[0].Rows.Count>0)
            {
                createexcel(dsDownload, strfilepath);
               // CreateEmployeeDetTblSLChronical(dsDownload.Tables[0],"TEST DEPARTMENT");

                Response.ContentType = "application/vnd.ms-excel";
                Response.AppendHeader("Content-Disposition", "attachment; filename=" + strfilepath);
                Response.TransmitFile(Server.MapPath("~/assets/MemberListDownload/" + strfilepath));
                Response.End();

                //string returnUrl = Request.QueryString["ReturnUrl"];
                //if (!string.IsNullOrEmpty(returnUrl))
                //{
                //    Response.Redirect("MembersList.aspx?file=" + Server.UrlEncode(returnUrl));
                //}

                //ifrm_dcbform.Attributes["src"] = strfilepath;                
                // Response.AddHeader("Content-Disposition", "attachment;filename=" + strfilepath);
                // Response.WriteFile(Server.MapPath("~/assets/MemberListDownload/" + strfilepath));
                //ifrm_dcbform


                //BindGrid(Convert.ToString(Session["printed"]));
                //ClientScript.RegisterStartupScript(this.GetType(), "alert", "window.location.href='MembersList.aspx';", true);
                //  Response.Redirect("MembersList.aspx");
            }
            else
            {
            }
           
        }
        catch (Exception ex)
        {
            StreamWriter sw = new StreamWriter(Server.MapPath("~/Errorlog.txt"), true);
            sw.WriteLine(DateTime.Now.ToString() + "Memberlist.aspx --> btndownload_Click");
            sw.WriteLine(DateTime.Now.ToString() + ex.StackTrace);
            sw.WriteLine(DateTime.Now.ToString() + ex.Message);
            sw.WriteLine(DateTime.Now.ToString() + ex.InnerException);
            sw.Flush();
            sw.Close();
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            string strrRegno = string.Empty;  
            strrRegno = hdnslectedvalue.Value;
            strrRegno = strrRegno.Remove(strrRegno.Length - 1);
            Common.DeleteAllselectedRecord(strrRegno);
            hdnslectedvalue.Value = "";
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('தேர்தெடுத்த உறுப்பினர்களின் தகவல்கள் நீக்கப்பட்டுள்ளது.');window.location.href='MembersList.aspx';", true);
        }
        catch (Exception ex)
        {
            StreamWriter sw = new StreamWriter(Server.MapPath("~/Errorlog.txt"), true);
            sw.WriteLine(DateTime.Now.ToString() + "Memberlist.aspx --> btnDelete_Click");
            sw.WriteLine(DateTime.Now.ToString() + ex.StackTrace);
            sw.WriteLine(DateTime.Now.ToString() + ex.Message);
            sw.WriteLine(DateTime.Now.ToString() + ex.InnerException);
            sw.Flush();
            sw.Close();
        }
    }

    private void createexcel(DataSet ds, string strFilepathname)
    {       
        if (File.Exists(Server.MapPath("~/assets/MemberListDownload/"+ strFilepathname)))
        {
            System.IO.File.Delete(Server.MapPath("~/assets/MemberListDownload/" + strFilepathname));
        }
        //Excel Exporting
        CreateExcelDocs cr = new CreateExcelDocs();
        Microsoft.Office.Interop.Excel.Workbook wrkbuk = null;
        wrkbuk = cr.createDoc();

        //Adding Headers
        cr.createHeaders(1, 1, "Name", true, 10, "n", "A1", "AD1");
        cr.createHeaders(1, 2, "Parents Name", true, 10, "n", "A1", "AD1");
        cr.createHeaders(1, 3, "Gender", true, 10, "n", "A1", "AD1");
        cr.createHeaders(1, 4, "Date of birth", true, 10, "n", "A1", "AD1");
        cr.createHeaders(1, 5, "Identity Type", true, 10, "n", "A1", "AD1");
        cr.createHeaders(1, 6, "Identity Number", true, 10, "n", "A1", "AD1");
        cr.createHeaders(1, 7, "District", true, 10, "n", "A1", "AD1");
        cr.createHeaders(1, 8, "Consituency", true, 10, "n", "A1", "AD1");
        cr.createHeaders(1, 9, "Mobile No", true, 10, "n", "A1", "AD1");
        cr.createHeaders(1, 10, "Address", true, 10, "n", "A1", "AD1");
        cr.createHeaders(1, 11, "Wings", true, 10, "n", "A1", "AD1");
        cr.createHeaders(1, 12, "Blood Group", true, 10, "n", "A1", "AD1");        
        //Adding data to row
        int excelrow = 2;
        string strDob = string.Empty;
        for (int row = 0; row < ds.Tables[0].Rows.Count; row++)
        {          
            strDob = Convert.ToDateTime(ds.Tables[0].Rows[row]["regDOB"].ToString()).ToString("dd/MM/yyyy");

            cr.addData(excelrow, 1, Convert.ToString(ds.Tables[0].Rows[row]["regName"]), "A1", "AD1", "#,##0");
            cr.addData(excelrow, 2, Convert.ToString(ds.Tables[0].Rows[row]["regParentName"]), "A1", "AD1", "#,##0");
            cr.addData(excelrow, 3, Convert.ToString(ds.Tables[0].Rows[row]["regGender"]), "A1", "AD1", "#,##0");
            cr.addData(excelrow, 4, strDob, "A1", "AD1", "#,##0");
            cr.addData(excelrow, 5, Convert.ToString(ds.Tables[0].Rows[row]["regIdentityType"]), "A1", "AD1", "#,##0");
          
            cr.addData(excelrow, 6, Convert.ToString(ds.Tables[0].Rows[row]["regVoterid"]), "A1", "AD1", "#,##0");
            cr.addData(excelrow, 7, Convert.ToString(ds.Tables[0].Rows[row]["regDistrict"]), "A1", "AD1", "DD/MM/YYYY");
            cr.addData(excelrow, 8, Convert.ToString(ds.Tables[0].Rows[row]["regConstituency"]), "A1", "AD1", "DD/MM/YYYY");
            cr.addData(excelrow, 9, Convert.ToString(ds.Tables[0].Rows[row]["regMobileNo"]), "A1", "AD1", "#,##0");
            cr.addData(excelrow, 10, Convert.ToString(ds.Tables[0].Rows[row]["regAddress"]), "A1", "AD1", "#,##0");
            cr.addData(excelrow, 11, Convert.ToString(ds.Tables[0].Rows[row]["regTeam"]), "A1", "AD1", "#,##0");
            cr.addData(excelrow, 12, Convert.ToString(ds.Tables[0].Rows[row]["regBlood"]), "A1", "AD1", "#,##0");
          
            excelrow++;           
        }
        wrkbuk.SaveAs(Server.MapPath("~/assets/MemberListDownload/" + strFilepathname));
        wrkbuk.Close(0);

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

    protected void btnNewMember_Click(object sender, EventArgs e)
    {
        try
        {
            Session["printed"] = "0";
            BindGrid("0");            
        }
        catch (Exception ex)
        {
            StreamWriter sw = new StreamWriter(Server.MapPath("~/Errorlog.txt"), true);
            sw.WriteLine(DateTime.Now.ToString() + "Memberlist.aspx --> btnNewMember_Click");
            sw.WriteLine(DateTime.Now.ToString() + ex.StackTrace);
            sw.WriteLine(DateTime.Now.ToString() + ex.Message);
            sw.WriteLine(DateTime.Now.ToString() + ex.InnerException);
            sw.Flush();
            sw.Close();
        }
    }

    protected void btnNewUser_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("CreateUser.aspx");
        }
        catch (Exception ex)
        {
            StreamWriter sw = new StreamWriter(Server.MapPath("~/Errorlog.txt"), true);
            sw.WriteLine(DateTime.Now.ToString() + "Memberlist.aspx --> btnNewMember_Click");
            sw.WriteLine(DateTime.Now.ToString() + ex.StackTrace);
            sw.WriteLine(DateTime.Now.ToString() + ex.Message);
            sw.WriteLine(DateTime.Now.ToString() + ex.InnerException);
            sw.Flush();
            sw.Close();
        }
    }
    protected void btnPrintedmembers_Click(object sender, EventArgs e)
    {
        try
        {
            Session["printed"] = "1";
            BindGrid("1");            
        }
        catch (Exception ex)
        {
            StreamWriter sw = new StreamWriter(Server.MapPath("~/Errorlog.txt"), true);
            sw.WriteLine(DateTime.Now.ToString() + "Memberlist.aspx --> btnPrintedmembers_Click");
            sw.WriteLine(DateTime.Now.ToString() + ex.StackTrace);
            sw.WriteLine(DateTime.Now.ToString() + ex.Message);
            sw.WriteLine(DateTime.Now.ToString() + ex.InnerException);
            sw.Flush();
            sw.Close();
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToString(Session["printed"]) == "1")
            {
                BindGrid("1");
            }
            else
            {
                BindGrid("0");
            } 
        }
        catch (Exception ex)
        {
            StreamWriter sw = new StreamWriter(Server.MapPath("~/Errorlog.txt"), true);
            sw.WriteLine(DateTime.Now.ToString() + "Memberlist.aspx --> btnSearch_Click");
            sw.WriteLine(DateTime.Now.ToString() + ex.StackTrace);
            sw.WriteLine(DateTime.Now.ToString() + ex.Message);
            sw.WriteLine(DateTime.Now.ToString() + ex.InnerException);
            sw.Flush();
            sw.Close();
        }
    }




    protected void ExportToPDF(object sender, EventArgs e)
    {
        string strrRegno = string.Empty;
        DataSet dsDownload = new DataSet();
        Random rnd = new Random();
        string randomNumber = (rnd.Next(1, 100)).ToString();
        strrRegno = hdnslectedvalue.Value;
        strrRegno = strrRegno.Remove(strrRegno.Length - 1);
        dsDownload = Common.DownloadAllselectedRecord(strrRegno);
        hdnslectedvalue.Value = "";
        string strfilepath = "RegisterMembers_" + DateTime.Now.ToString("ddMMyyyy") + "_" + randomNumber + ".pdf";
        using (StringWriter sw = new StringWriter())
        {
            using (HtmlTextWriter hw = new HtmlTextWriter(sw))
            {
                //Hide the Column containing CheckBox
                grdMembersList.Columns[0].Visible = false;
                int i = 0;
                int j = 0;
                string str1 = string.Empty;
                foreach (Obout.Grid.GridRow row in grdMembersList.Rows)
                {                   
                    if (row.RowType == Obout.Grid.GridRowType.DataRow)
                    {
                        str1 = row.Cells[1].Text;
                        //Hide the Row if CheckBox is not checked
                       // CheckBox details = (row.FindControl("chk_grid_" + str1) as CheckBox);
                        row.Visible = (row.FindControl("chk_grid_" + str1) as CheckBox).Checked;
                        // row.Visible = (row.FindControl("chkSelect") as CheckBox).Checked;
                    }
                }

                grdMembersList.RenderControl(hw);
                StringReader sr = new StringReader(sw.ToString());
                Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
                HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
                PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
                pdfDoc.Open();
                htmlparser.Parse(sr);
                pdfDoc.Close();

                Response.ContentType = "application/pdf";
                Response.AddHeader("content-disposition", "attachment;filename="+ strfilepath);
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.Write(pdfDoc);
                Response.End();
            }
        }
    }
}