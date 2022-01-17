<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>



<!DOCTYPE html>
<html lang="en">
<head>
	<title>IUML - உறுப்பினர் பதிவு</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	 <link rel="icon" type="image/png" href="assets/images/favicon.png"/>    
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="login/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="login/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="login/fonts/iconic/css/material-design-iconic-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="login/vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="login/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="login/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="login/vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="login/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="login/css/util.css">
	<link rel="stylesheet" type="text/css" href="login/css/main.css">
<!--===============================================================================================-->
     
    <style>
        .wrap-login100 {
  background:white !important;
        }
        .login100-form-title {
            color:black;
        }

        .login100-form-btn::before {
            background-color: black;
        }
        .login100-form-btn {
            background-color: black !important;
        }
        .input100 {
            color: black;
            background: #3bb78f;
        }

        .login100-form-btn {
            background:black;
            color:white;
            font-weight:600;
        }

        .bckr
        {
             background-color: #3bb78f;
             background-image: linear-gradient(315deg, #3bb78f 0%, #0bab64 74%);
             position:initial;
        }

        .wrap-login100 {
            padding: 0px 35px 37px 35px;
        }
       .p-t-27 {
    padding-top: 0px;
}
        .form-control:focus {
            /*background: #3bb78f;*/
             background: white;
        }

        .input-group-addon {
            background: #3bb78f;
        }

        .btnsubmit
        {
            background: gold;
        }

        .login100-form-logo {
            width: 100%;
        }
        .login100-form-title {
            font-size: 29px;
        }
        .lblerrormsg {
            color:red;
        }
         .box_shadow {
    /*-webkit-box-shadow: 0px 0px 21px 0px rgba(0,110,24,1) !important;
    -moz-box-shadow: 0px 0px 21px 0px rgba(0,110,24,1) !important;
    box-shadow: 0px 0px 21px 0px rgba(0,110,24,1)!important;*/

    -webkit-box-shadow: 0px 0px 120px 14px rgba(0,110,24,1);
-moz-box-shadow: 0px 0px 120px 14px rgba(0,110,24,1);
box-shadow: 0px 0px 120px 14px rgba(0,110,24,1);
}

        .attr_shadow {
            border-radius:5px;
            -webkit-box-shadow: 0px 0px 5px 0px rgba(40,145,31,1);
-moz-box-shadow: 0px 0px 5px 0px rgba(40,145,31,1);
box-shadow: 0px 0px 5px 0px rgba(40,145,31,1);
        }
    </style>
    <script src="assets/js/aes.js"></script>
   <script>

        function SubmitsEncry() {  
          
            var txtpassword = document.getElementById("<%=txtUserpass.ClientID %>").value.trim();  
  
            if (txtpassword == "") {  
                alert('Please enter Password');  
                return false;  
            }  
            else {  
                var key = CryptoJS.enc.Utf8.parse('8080808080808080');  
                var iv = CryptoJS.enc.Utf8.parse('8080808080808080');  
  
                var encryptedpassword = CryptoJS.AES.encrypt(CryptoJS.enc.Utf8.parse(txtpassword), key,  
                {  
                    keySize: 128 / 8,  
                    iv: iv,  
                    mode: CryptoJS.mode.CBC,  
                    padding: CryptoJS.pad.Pkcs7  
                }); 
                document.getElementById("<%=hdnPassword.ClientID %>").value = encryptedpassword;
            }  
        } 
   </script>
</head>

<body>
	
	<div class="limiter">

                 <div class="container-fluid" style="background-color:#006e18">
                                <img id="headerimg" runat="server" class="w-100 desktop" src="~/assets/images/header.jpg" alt="IUML Membership -Join Now" />
                </div>


		<div class="container-login100">          
			<div class="wrap-login100 box_shadow" style="margin-top:-100px !important">                
				<form runat="server" class="login100-form validate-form">
					<span class="login100-form-logo">
					<%--	<i class="zmdi zmdi-landscape"></i>--%>
                       <span class="login100-form-title ">	IUML - உறுப்பினர் பதிவு </span>
                      <%--  <img src="assets/images/favicon.png" style="border-radius:50%;width:70%" alt="flag" >--%>
					</span>

					<%--<span class="login100-form-title p-b-34 p-t-27">
						உறுப்பினர் சேர்க்கை
					</span>--%>
                    <div class="mobileno" id="dvMobileNo" runat="server">	
                        <div class="form-group mb-30">
                            <label><b>Username </b></label><br />
                            <div class="input-group mobile_new_input attr_shadow" style="border:1px solid black">
                                 <asp:TextBox ID="txtuserName" class="form-control new_input group only_mobile" runat="server" AutoCompleteType="disabled"></asp:TextBox>
                                   <%-- <input type="text" class="form-control new_input group only_mobile" runat="server" id="txtuserName" name="signup_mobile" placeholder="" maxlength="15">--%>
                             </div><br />
                            <div>
                                <label><b>Password </b></label><br />
                                <div class="input-group mobile_new_input attr_shadow" style="border:1px solid black">
                                      <asp:TextBox ID="txtUserpass" class="form-control new_input group only_mobile" runat="server" TextMode="Password" Onchange="return SubmitsEncry();"  Width="150px" AutoCompleteType="disabled"></asp:TextBox>
                                      <asp:HiddenField ID="hdnPassword" runat="server" />
<%--                                 <input type="text"  runat="server" id="txtUserpass" name="signup_mobile" placeholder="" maxlength="15">--%>
                            </div> </div>
                            <p class="input_error"></p><br/>
                            <asp:Label ID="lblMsg" CssClass="lblerrormsg"  runat="server" Text=""></asp:Label>			
                        </div>

					<div class="container-login100-form-btn">
                           <asp:Button ID="btnsubmit" OnClick="btnsubmit_Click" class="btn btn-custom next btnsubmit" runat="server" Text="Login" />						
					</div>	
                        </div>

                  </form>
			</div>
		</div>
	</div>
	

	<div id="dropDownSelect1"></div>
	
<!--===============================================================================================-->
	<script src="login/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="login/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="login/vendor/bootstrap/js/popper.js"></script>
	<script src="login/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="login/vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="login/vendor/daterangepicker/moment.min.js"></script>
	<script src="login/vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	
<!--===============================================================================================-->
	<script src="login/js/main.js"></script>
    <script src="assets/js/main.js"></script>
  
</body>
</html>


