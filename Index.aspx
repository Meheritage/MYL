<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPagewithoutLogin.master" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="Index" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="http://code.jquery.com/jquery-1.10.2.min.js" type="text/javascript"></script>
    

    <style>
        .datewidth {
            width:60%;
            display:inline-block;
        }

        .dropdown-item.active, .dropdown-item:active {
    background-color: #19ab46;
}

        .mobilno{
            width:60%;
            display:inline-block;
        }
        .btnsubmit {
            width:20%;
            background-color:aqua;
            color:black;
            font-weight:600;
        }
        .constitu
        {
            margin-bottom: 2rem;
        }
        /*.input-group-addon {
    background: #3bb78f;
}*/
        .input-group-addon {
    padding: .5rem .75rem;
    margin-bottom: 0;
    font-size: 1rem;
    font-weight: 400;
    line-height: 1.25;
    color: #495057;
    text-align: center;
    /*background-color: #3bb78f;*/
    border: 1px solid rgba(0,0,0,.15);
    border-radius: .25rem;
}
        #surveyForm .btn-custom {
            background-color: #4aab18;
        }

         .lblerrormsg {
            color:red;
            font-size:18px;
            font-weight:600;
            left:20%;
        }
         .box_shadow {
    -webkit-box-shadow: 0px 0px 21px 0px rgba(0,110,24,1) !important;
    -moz-box-shadow: 0px 0px 21px 0px rgba(0,110,24,1) !important;
    box-shadow: 0px 0px 21px 0px rgba(0,110,24,1)!important;
}
        </style>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contentbody" Runat="Server">
 
  
</asp:Content>



