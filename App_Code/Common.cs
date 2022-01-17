using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Security.Cryptography;
using System.Text;
using System.Data;
using System.Configuration;
using System.IO;
using System.Data.SqlClient;

/// <summary>
/// Summary description for Common
/// </summary>
public class Common
{
    public static string connectionstring = ConfigurationManager.ConnectionStrings["Register"].ConnectionString;
    public Common()
    {
        
    }
    public static string EncryptHashText(string password, bool useHashing)
    {
        DataSet dskey = new DataSet();
        dskey = GetKeyConfiguration();

        byte[] keyArray;
        byte[] toEncryptArray = UTF8Encoding.UTF8.GetBytes(password);

        AppSettingsReader appSettingsReader = new AppSettingsReader();

        string key = dskey.Tables[0].Rows[0]["Keyvalue"].ToString(); //you can give anything here..

        //If hashing use get hashcode regards to your key
        if (useHashing)
        {
            MD5CryptoServiceProvider hashMD5 = new MD5CryptoServiceProvider();
            keyArray = hashMD5.ComputeHash(UTF8Encoding.UTF8.GetBytes(key));
            //Always release the resources and flush data of the Cryptographic service provide. Best Practice
            hashMD5.Clear();
        }
        else
        {
            keyArray = UTF8Encoding.UTF8.GetBytes(key);
        }

        TripleDESCryptoServiceProvider tripleDES = new TripleDESCryptoServiceProvider();
        //Set the secret key for the tripleDES algorithm
        tripleDES.Key = keyArray;
        //Mode of operation. there are other 4 modes.. We choose ECB(Electronic code Book)
        tripleDES.Mode = CipherMode.ECB;
        //Padding mode(if any extra byte added)
        tripleDES.Padding = PaddingMode.PKCS7;
        ICryptoTransform cTransform = tripleDES.CreateEncryptor();
        //Transform the specified region of bytes array to resultArray
        byte[] resultArray = cTransform.TransformFinalBlock(toEncryptArray, 0, toEncryptArray.Length);


        //Release resources held by TripleDes Encryptor
        tripleDES.Clear();

        //Return the encrypted data into unreadable string format
        return Convert.ToBase64String(resultArray, 0, resultArray.Length);       
    }
    public static string DecryptStringAES(string cipherText)
    {
        var keybytes = Encoding.UTF8.GetBytes("8080808080808080");
        var iv = Encoding.UTF8.GetBytes("8080808080808080");

        var encrypted = Convert.FromBase64String(cipherText);
        var decriptedFromJavascript = DecryptStringFromBytes(encrypted, keybytes, iv);
        return string.Format(decriptedFromJavascript);
    }
    private static string DecryptStringFromBytes(byte[] cipherText, byte[] key, byte[] iv)
    {
        // Check arguments.  
        if (cipherText == null || cipherText.Length <= 0)
        {
            throw new ArgumentNullException("cipherText");
        }
        if (key == null || key.Length <= 0)
        {
            throw new ArgumentNullException("key");
        }
        if (iv == null || iv.Length <= 0)
        {
            throw new ArgumentNullException("key");
        }

        // Declare the string used to hold  
        // the decrypted text.  
        string plaintext = null;

        // Create an RijndaelManaged object  
        // with the specified key and IV.  
        using (var rijAlg = new RijndaelManaged())
        {
            //Settings  
            rijAlg.Mode = CipherMode.CBC;
            rijAlg.Padding = PaddingMode.PKCS7;
            rijAlg.FeedbackSize = 128;

            rijAlg.Key = key;
            rijAlg.IV = iv;

            // Create a decrytor to perform the stream transform.  
            var decryptor = rijAlg.CreateDecryptor(rijAlg.Key, rijAlg.IV);

            try
            {
                // Create the streams used for decryption.  
                using (var msDecrypt = new MemoryStream(cipherText))
                {
                    using (var csDecrypt = new CryptoStream(msDecrypt, decryptor, CryptoStreamMode.Read))
                    {

                        using (var srDecrypt = new StreamReader(csDecrypt))
                        {
                            // Read the decrypted bytes from the decrypting stream  
                            // and place them in a string.  
                            plaintext = srDecrypt.ReadToEnd();

                        }

                    }
                }
            }
            catch
            {
                plaintext = "keyError";
            }
        }

        return plaintext;
    }
    public string Decrypt(string cipherString, bool useHashing)
    {
        DataSet dskey = new DataSet();
        dskey = GetKeyConfiguration();
        byte[] keyArray;

        //Get the byte code of the string
        byte[] toEncryptArray = Convert.FromBase64String(cipherString);
        AppSettingsReader settingsReader = new AppSettingsReader();
        //Same key to open the lock!
        string key = dskey.Tables[0].Rows[0]["Keyvalue"].ToString(); ; //keep both key same..

        if (useHashing)
        {
            //If hashing was used get the hash code with regards to your key
            MD5CryptoServiceProvider hashmd5 = new MD5CryptoServiceProvider();
            keyArray = hashmd5.ComputeHash(UTF8Encoding.UTF8.GetBytes(key));
            //Release any resource held by the MD5CryptoServiceProvider
            hashmd5.Clear();
        }
        else
        {
            //If hashing was not implemented get the byte code of the key
            keyArray = UTF8Encoding.UTF8.GetBytes(key);
        }

        TripleDESCryptoServiceProvider tripleDES = new TripleDESCryptoServiceProvider();
        //Set the secret key for the tripleDES algorithm
        tripleDES.Key = keyArray;
        //Mode of operation. there are other 4 modes.. We choose ECB(Electronic code Book)
        tripleDES.Mode = CipherMode.ECB;
        //Padding mode(if any extra byte added)
        tripleDES.Padding = PaddingMode.PKCS7;

        ICryptoTransform cTransform = tripleDES.CreateDecryptor();
        byte[] resultArray = cTransform.TransformFinalBlock(
                                toEncryptArray, 0, toEncryptArray.Length);
        //Release resources held by TripleDes Encryptor                
        tripleDES.Clear();

        //Return the Clear decrypted TEXT
        return UTF8Encoding.UTF8.GetString(resultArray);
    }
    public static DataSet GetKeyConfiguration()
    {
        System.Data.DataSet dsKeyDet = new DataSet();
        using (SqlConnection con = new SqlConnection(connectionstring))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("spGetKeyConfiguration ", con);
            SqlDataAdapter sadp = new SqlDataAdapter(cmd);
            sadp.Fill(dsKeyDet);
            cmd.Dispose();
            con.Close();
        }
        return dsKeyDet;

    }

    public static void DeleteAllselectedRecord(string Regno)
    {
        using (SqlConnection con = new SqlConnection(connectionstring))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("DeleteAllselectedRecord @regNo", con);
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@regNo", Regno);
            var empseq = cmd.ExecuteScalar();
            cmd.Dispose();
            con.Close();
            //DataSet dsEmpReq = new DataSet();
            //adp.Fill(dsEmpReq);
            //adp.Dispose();
            //con.Close();           
        }
    }

    public static DataSet DownloadAllselectedRecord(string Regno)
    {
        using (SqlConnection con = new SqlConnection(connectionstring))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("DownloadAllselectedRecord @regNo", con);
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@regNo", Regno);
            DataSet dsEmpReq = new DataSet();
            adp.Fill(dsEmpReq);
            adp.Dispose();
            con.Close();
            return dsEmpReq;
        }
    }
}