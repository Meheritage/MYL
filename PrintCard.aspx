<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintCard.aspx.cs" Inherits="PrintCard" %>


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


        /* The Modal (background) */
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content/Box */
.modal-content {
  background-color: #fefefe;
  margin: 15% auto; /* 15% from the top and centered */
  padding: 20px;
  border: 1px solid #888;
  width: 80%; /* Could be more or less, depending on screen size */
}

/* The Close Button */
.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}
    </style>
     <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">

<style>

    body{
        background: #EFF7FE;
      padding-top: 15px;
}
.main-section{
	border:1px solid #138496;
	background-color: #fff;
}
.profile-header{
	background-color: #17a2b8;
	height:150px;
}
.user-detail{
	margin:-50px 0px 30px 0px;
}
.user-detail img{
	height:100px;
	width:100px;
}
.user-detail h5{
	margin:15px 0px 5px 0px;
}
.user-social-detail{
	padding:15px 0px;
	background-color: #17a2b8;
}
.user-social-detail a i{
	color:#fff;
	font-size:23px;
	padding: 0px 5px;
}
    @media (min-width: 992px) {
        .col-lg-4 {
            -ms-flex: 0 0 33.333333%;
            flex: 0 0 33.333333%;
            max-width: 28.333333%;
        }
    }
    .user-social-detail {
    padding: 0px 0px;
     background-color: #3bb78f;
    background-image: linear-gradient(315deg, #3bb78f 0%, #0bab64 74%);
}
    .footer{
        font-size: 17px;
    padding-top: 7px;
    font-weight: 600;
    }

    .profile-header {
        background-color: #3bb78f;
        background-image: linear-gradient(315deg, #3bb78f 0%, #0bab64 74%);
        height: 100px;
        font-weight:600;
        padding-top:4px;
        font-size: 25px;
    }
    .dvsearch
    {
        padding-top:6%;
    }

    body {
    background: #568ebf;
    padding-top: 15px;
}
    .modal {
        display: block;
    }
    .modal-content {
        width: 85%;
        margin: 5% auto;
        
    }
</style>
    <style type="text/css" media="print">
    #lb1{
    display:block;
    }
    </style>
</head>

<body>
	
	<div class="limiter">
		<div class="container-login100 bckr">          
			<div class="wrap-login100">                
				<form runat="server" class="login100-form validate-form">
					  
				</form>
			</div>
		</div>
	</div>
	


	
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
	<script src="vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="login/js/main.js"></script>
    <script src="assets/js/main.js"></script>
    <script type="text/javascript">
        var modal = document.getElementById("myModal");
        var span = document.getElementsByClassName("close")[0];
        // When the user clicks on <span> (x), close the modal
        span.onclick = function() {
            modal.style.display = "none";
        }
    </script>
</body>
</html>

















