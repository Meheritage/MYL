using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.Text;
//using System.Drawing;
using System.Text.RegularExpressions;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;

public partial class PrintCard : System.Web.UI.Page
{
    string connectionstring = ConfigurationManager.ConnectionStrings["Register"].ConnectionString;
    string TempimageFilePathfront;
    string TempimageFilePathback;
    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            searchcard(Convert.ToString(Session["RegNo"]));
        }
        catch (Exception ex)
        {
            StreamWriter sw = new StreamWriter(Server.MapPath("~/Errorlog.txt"), true);
            sw.WriteLine(DateTime.Now.ToString() + " PrintCard -> Page_Load");
            sw.WriteLine(DateTime.Now.ToString() + ex.StackTrace);
            sw.WriteLine(DateTime.Now.ToString() + ex.Message);
            sw.WriteLine(DateTime.Now.ToString() + ex.InnerException);
            sw.Flush();
            sw.Close();
        }
    }

    public void searchcard(string strRegno)
    {
        SqlDataAdapter daSearchCard = new SqlDataAdapter();
        try
        {
            using (SqlConnection con = new SqlConnection(connectionstring))
            {
                con.Open();
                if (Convert.ToString(Session["RegIsprint"]) == "Card not Printed")
                {
                    Random rnd = new Random();
                    string randomNumber = (rnd.Next(100, 999)).ToString();
                    SqlCommand cmd = new SqlCommand("spGenerateCardNo @regno, @memberno, @isprint", con);
                    cmd.Parameters.AddWithValue("@regno", strRegno);
                    cmd.Parameters.AddWithValue("@memberno", randomNumber);
                    cmd.Parameters.AddWithValue("@isprint", 1);
                    cmd.ExecuteNonQuery();
                }
                con.Close();
                DataTable dtSearchCard = new DataTable();
                daSearchCard = new SqlDataAdapter("SELECT * FROM tblregisteration WHERE regNo=" + strRegno, con);
                daSearchCard.Fill(dtSearchCard);
                if (dtSearchCard.Rows.Count > 0)
                {
                    string strprofilepic = string.Empty;
                    if (Convert.ToString(dtSearchCard.Rows[0]["regphotoloc"]) != "")
                    {
                        strprofilepic = Server.MapPath(Convert.ToString(dtSearchCard.Rows[0]["regphotoloc"]));
                    }
                    string strOriginalPath = string.Empty;
                    string strNewFilePath = string.Empty;
                    string strNewFilePath1 = string.Empty;
                    switch (Convert.ToString(Session["UserWing"]))
                    {
                        case "MYL":
                            strOriginalPath = "~/assets/MYL.pdf";
                            strNewFilePath = "~/assets/IDCard/MYL/MYL_" + Convert.ToString(dtSearchCard.Rows[0]["regMobileNo"]) + ".pdf";
                            strNewFilePath1 = "MYL_" + Convert.ToString(dtSearchCard.Rows[0]["regMobileNo"]) + ".pdf";
                            break;
                        case "WL":
                            strOriginalPath = "~/assets/newWL.pdf";
                            strNewFilePath = "~/assets/IDCard/WL/WL_" + Convert.ToString(dtSearchCard.Rows[0]["regMobileNo"]) + ".pdf";
                            strNewFilePath1 = "WL_" + Convert.ToString(dtSearchCard.Rows[0]["regMobileNo"]) + ".pdf";
                            break;
                        case "ITWING":
                            strOriginalPath = "~/assets/IT.pdf";
                            strNewFilePath = "~/assets/IDCard/ITW/ITW_" + Convert.ToString(dtSearchCard.Rows[0]["regMobileNo"]) + ".pdf";
                            strNewFilePath1 = "ITW_" + Convert.ToString(dtSearchCard.Rows[0]["regMobileNo"]) + ".pdf";
                            break;
                    }



                    AddTextToPdf(Server.MapPath(strOriginalPath), Server.MapPath(strNewFilePath), dtSearchCard, strprofilepic);
                    Session["Printpath"] = Server.MapPath(strOriginalPath);
                    Session["strNewFilePath"] = strNewFilePath1;
                    Session["strNewFilePath1"] = Server.MapPath(strNewFilePath);
                    Session["isDownload"] = "1";
                    // ViewPrintDocs(Server.MapPath(strOriginalPath));

                   
                    Response.Redirect("MembersList.aspx", true);
                    //Response.ContentType = "Application/pdf";
                    //Response.AppendHeader("Content-Disposition", "attachment; filename=" + strNewFilePath1);
                    //Response.TransmitFile(Server.MapPath(strNewFilePath));
                    //Response.End();                   
                }
                else
                {
                }
            }
        }
        catch (Exception ex)
        {
            StreamWriter sw = new StreamWriter(Server.MapPath("~/Errorlog.txt"), true);
            sw.WriteLine(DateTime.Now.ToString() + " PrintCard -> searchcard");
            sw.WriteLine(DateTime.Now.ToString() + ex.StackTrace);
            sw.WriteLine(DateTime.Now.ToString() + ex.Message);
            sw.WriteLine(DateTime.Now.ToString() + ex.InnerException);
            sw.Flush();
            sw.Close();
        }
        finally
        {
            //  ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('உறுப்பினர் அட்டை பதிவிறக்கம் செய்யப்பட்டுள்ளது .');window.location.href='IndexReg.aspx';", true);        
        }
    }


    public void ViewPrintDocs(string docPath)
    {
        string strDocNotFound = "You cannot view the document temporarily.";
        //string docPath = "EmployeeDocs/SLChronicalDetails.pdf";
        if (docPath != null)
        {

            ScriptManager.RegisterStartupScript(this, typeof(string), "OPEN_WINDOW", "var Mleft = (screen.width/2)-(760/2);var Mtop = (screen.height/2)-(700/2);window.open( '" + docPath + "', null, 'height=700,width=760,status=yes,toolbar=no,scrollbars=yes,menubar=no,location=no,top=\'+Mtop+\', left=\'+Mleft+\'' );", true);
        }
        else
        {
            Response.Write("<script>alert('" + strDocNotFound + "')</script>");
        }

    }

    //protected void btnsubmit_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        //searchcard();
    //        // printcard();
    //      //  AddTextToPdf("C:/Users/mohammedk/Desktop/ML/assets/MYL.pdf", "C:/Users/mohammedk/Desktop/ML/assets/MYL1.pdf","hello pdf ");
    //    }
    //    catch(Exception ex)
    //    {
    //        StreamWriter sw = new StreamWriter(Server.MapPath("~/Errorlog.txt"), true);
    //        sw.WriteLine(DateTime.Now.ToString() + " PrintCard -> btnsubmit_Click");
    //        sw.WriteLine(DateTime.Now.ToString() + ex.StackTrace);
    //        sw.WriteLine(DateTime.Now.ToString() + ex.Message);
    //        sw.WriteLine(DateTime.Now.ToString() + ex.InnerException);
    //        sw.Flush();
    //        sw.Close();
    //    }
    //}

    public void AddTextToPdf(string inputPdfPath, string outputPdfPath, DataTable dtprintdata, string strprofilepath)

    {
        //create PdfReader object to read from the existing document
        using (PdfReader reader = new PdfReader(inputPdfPath))
        //create PdfStamper object to write to get the pages from reader 
        using (PdfStamper stamper = new PdfStamper(reader, new FileStream(outputPdfPath, FileMode.Create)))
        {
            //select two pages from the original document
            reader.SelectPages("1-2");

            //gettins the page size in order to substract from the iTextSharp coordinates
            var pageSize = reader.GetPageSize(1);

            // PdfContentByte from stamper to add content to the pages over the original content
            PdfContentByte pbover = stamper.GetOverContent(1);
            
            // Below code for setting the id card in pdf -> Start
            if (!(strprofilepath == string.Empty || strprofilepath == ""))
            {
                System.Drawing.Image imgPhoto = System.Drawing.Image.FromFile(strprofilepath);
                imgPhoto = resizeImage(imgPhoto, new Size(1000, 1000));
                iTextSharp.text.Image image = iTextSharp.text.Image.GetInstance(imgPhoto, System.Drawing.Imaging.ImageFormat.Jpeg);
                image.ScaleToFit(180f, 180f);
                image.SetAbsolutePosition(46, 85);
                pbover.AddImage(image);
            }

            // The below method is for writing all particulars to the image 
            TextToImage(dtprintdata);

            // The below code is to add the particulars image  to pdf.
            string Front_filePath = Server.MapPath("~/assets/images") + "/Front_" + Session.SessionID.ToString() + ".jpg";
            System.Drawing.Image imgPhoto1 = System.Drawing.Image.FromFile(TempimageFilePathfront);
            iTextSharp.text.Image image1 = iTextSharp.text.Image.GetInstance(imgPhoto1, System.Drawing.Imaging.ImageFormat.Jpeg);
            image1.ScaleToFit(300f, 300f);
            image1.SetAbsolutePosition(250, 125);
            pbover.AddImage(image1);

            PdfContentByte pbover1 = stamper.GetOverContent(2);
            string Back_filePath = Server.MapPath("~/assets/images") + "/Back_" + Session.SessionID.ToString() + ".jpg";
            System.Drawing.Image imgPhoto2 = System.Drawing.Image.FromFile(TempimageFilePathback);
            iTextSharp.text.Image image2 = iTextSharp.text.Image.GetInstance(imgPhoto2, System.Drawing.Imaging.ImageFormat.Jpeg);
            image2.ScaleToFit(270f, 300f);
            image2.SetAbsolutePosition(145, 90);
            pbover1.AddImage(image2);
            stamper.Close();

            // Below code is to close the object and delete the temp generated files.
            imgPhoto1.Dispose();
            imgPhoto2.Dispose();
            File.Delete(TempimageFilePathfront);
            File.Delete(TempimageFilePathback);
        }
    }
    public void TextToImage(DataTable dtprintdata)
    {

        try
        {
            string Name = Convert.ToString(dtprintdata.Rows[0]["regName"]);
            string membershipid = Convert.ToString(dtprintdata.Rows[0]["regConfirmCode"]);
            string designation = Convert.ToString(dtprintdata.Rows[0]["regWard"]);
            string district = Convert.ToString(dtprintdata.Rows[0]["regDistrict"]);

            string Address1 = Convert.ToString(dtprintdata.Rows[0]["regAddress"]);
            string Address2 = Convert.ToString(dtprintdata.Rows[0]["regAddress2"]);
            string Address3 = Convert.ToString(dtprintdata.Rows[0]["regAddress3"]);
            string dateofbirth = Convert.ToDateTime(dtprintdata.Rows[0]["regDOB"]).ToString("dd-MM-yyyy");
            string contact = Convert.ToString(dtprintdata.Rows[0]["regMobileNo"]);
            string blood = Convert.ToString(dtprintdata.Rows[0]["regBlood"]);            

            PointF Location_Name = new PointF(20f, 40f);
            PointF Location_membershipid = new PointF(20f, 100f);
            PointF Location_designation = new PointF(20f, 160f);
            PointF Location_district = new PointF(20f, 220f);

            PointF Location_Address1 = new PointF(10f, 10f);
            //PointF Location_Address2 = new PointF(10f, 56f);
            //PointF Location_Address3 = new PointF(10f, 106f);
            PointF Location_dateofbirth = new PointF(10f, 176f);
            PointF Location_contact = new PointF(10f, 231f);
            PointF Location_blood = new PointF(10f, 288f);

            string imageFilePathfront = HttpContext.Current.Server.MapPath("~/assets/images/Front.jpg");
            TempimageFilePathfront = HttpContext.Current.Server.MapPath("~/assets/images/Front_" + Guid.NewGuid() + ".jpg");
            Bitmap bitmap1 = (Bitmap)System.Drawing.Image.FromFile(imageFilePathfront);//load the image file

            using (Graphics graphics = Graphics.FromImage(bitmap1))
            {
                using (System.Drawing.Font NiceFont = new System.Drawing.Font("Franklin Gothic Demi", 20, FontStyle.Bold))
                {
                    graphics.DrawString(Name, NiceFont, Brushes.Black, Location_Name);
                    graphics.DrawString(membershipid, NiceFont, Brushes.Black, Location_membershipid);
                    graphics.DrawString(designation, NiceFont, Brushes.Black, Location_designation);
                    graphics.DrawString(district, NiceFont, Brushes.Black, Location_district);
                }
            }
            bitmap1.Save(TempimageFilePathfront);//save the image file

            string imageFilePathback = HttpContext.Current.Server.MapPath("~/assets/images/Back.jpg");
            TempimageFilePathback = HttpContext.Current.Server.MapPath("~/assets/images/Back_" + Guid.NewGuid() + ".jpg");
            Bitmap bitmap2 = (Bitmap)System.Drawing.Image.FromFile(imageFilePathback);//load the image file

            using (Graphics graphics = Graphics.FromImage(bitmap2))
            {
                using (System.Drawing.Font NiceFont = new System.Drawing.Font("Franklin Gothic Demi", 20, FontStyle.Bold))
                {
                    Location_Address1 = new PointF(10f, 09.5f);
                    graphics.DrawString(Address1, NiceFont, Brushes.Black, Location_Address1);
                    graphics.DrawString(dateofbirth, NiceFont, Brushes.Black, Location_dateofbirth);
                    graphics.DrawString(contact, NiceFont, Brushes.Black, Location_contact);
                    graphics.DrawString(blood, NiceFont, Brushes.Black, Location_blood);
                }
            }
            bitmap2.Save(TempimageFilePathback);//save the image file
        }


        catch (Exception ex)
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


    public static System.Drawing.Image resizeImage(System.Drawing.Image imgToResize, Size size)
    {
        return (System.Drawing.Image)(new Bitmap(imgToResize, size));
    }
    public static string sentence(string statement)
    {
        // statement.Replace('\r\n', ' ');
        statement = Regex.Replace(statement, @"\t|\n|\r", " ");
        //if (statement.Length > 25)
        //{
        //    string[] words = new string[2];
        //    var words1 = statement.Substring(0,25);
        //    var words3 = statement.Substring(25);

        //    words[0] = words1;
        //    words[1] = words3;
        //    // var words = statement.Split(' ');
        //    StringBuilder completedWord = new StringBuilder();
        //    int charCount = 0;

        //    if (words.Length > 1)
        //    {
        //        for (int i = 0; i <= words.Length - 1; i++)
        //        {
        //            charCount += words[i].Length;
        //           // if (charCount > 25)
        //           // {
        //                //completedWord.AppendLine();
        //             //   completedWord.Append("~");
        //             //   charCount = 0;
        //            //}

        //            if (charCount > 25)
        //            {
        //                completedWord.Append("~");
        //            }
        //            completedWord.Append(words[i]);
        //            // completedWord.Append(" ");
        //        }
        //    }

        //    //// add the last word
        //    //if (completedWord.Length + words[words.Length - 1].Length >= 25)
        //    //{
        //    //    completedWord.AppendLine();
        //    //}
        //   // completedWord.Append(words[words.Length - 1]);
        //    return Convert.ToString(completedWord);
        //}
        return statement;
    }

}