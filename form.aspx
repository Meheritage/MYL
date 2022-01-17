<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPagewithoutLogin.master" AutoEventWireup="true" CodeFile="form.aspx.cs" Inherits="form" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="http://code.jquery.com/jquery-1.10.2.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            $('#Contentbody_dtleaveFrmdate_popupDiv').datepicker({
                endDate: '-18y'
            });

            $('.input-validation-error').filter(":first").focus()
            //$('#Contentbody_dtleaveFrmdate_container').datepicker({ endDate: '-18Y' });
        });
       
        function showpreview(input) {

            if (input.files && input.files[0]) {

                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#imgEditphoto').css('visibility', 'visible');
                    $('#imgEditphoto').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }

        function checkTemp(sender,args)
        {            
            if (document.getElementById("Contentbody_chkboxotherparty").checked)
            {               
                args.IsValid = true;
                return;
            }
            else
            {                
                args.IsValid = false;
            }
        }
    </script>

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
    <script type="text/javascript">
        function AllowAlphabet(e) {
            isIE = document.all ? 1 : 0
            keyEntry = !isIE ? e.which : event.keyCode;
            if (((keyEntry >= '65') && (keyEntry <= '90')) || ((keyEntry >= '97') && (keyEntry <= '122')) || (keyEntry == '46') || (keyEntry == '32') || keyEntry == '45')
                return true;
            else {
              //  alert('Please Enter Only Character values.');
                return false;
            }
        }
        function Allownumbers(e) {

            //isIE = document.all ? 1 : 0
            //keyEntry = !isIE ? e.which : event.keyCode;
            //if (((keyEntry >= '65') && (keyEntry <= '90')) || ((keyEntry >= '97') && (keyEntry <= '122')) || (keyEntry == '46') || (keyEntry == '32') || keyEntry == '45')
            //    return false;
            //else {
            //      //alert('Please Enter Only Character values.');
            //    return true;
            //}

            isIE = document.all ? 1 : 0
            keyEntry = !isIE ? e.which : event.keyCode;
            if (keyEntry > 31 && (keyEntry < 48 || keyEntry > 57))
                return false;
            else {
                return true;
            }
        }
        function allowAlphaNumericSpace(e) {
            var code = ('charCode' in e) ? e.charCode : e.keyCode;
            if (!(code == 32) && // space
              !(code > 47 && code < 58) && // numeric (0-9)
              !(code > 64 && code < 91) && // upper alpha (A-Z)
              !(code > 96 && code < 123)) { // lower alpha (a-z)
                e.preventDefault();
            }
        }
    </script>
    <script type="text/javascript">
varvalidFiles=["bmp","gif","png","jpg","jpeg"];
functionCheckExt(obj)
{
varsource=obj.value;
varext=source.substring(source.lastIndexOf(".")+1,source.length).toLowerCase();
for(vari=0;i<validFiles.length;i++)
{
if(validFiles[i]==ext)
break;
}
if(i>=validFiles.length)
{
alert("THATISNOTAVALIDIMAGE\nPleaseloadanimagewithanextentionofoneofthefollowing:\n\n"+validFiles.join(","));
}
}
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contentbody" Runat="Server">
   
    <div><%--<h1>IUML - உறுப்பினர் பதிவு</h1>--%></div>
   
         <asp:ScriptManager ID="asm1" runat="server" EnablePageMethods="true">
        </asp:ScriptManager>
        <fieldset class="box_shadow">
                                            <div class="form-card">     
                                                <asp:Label ID="lblMsg" CssClass="lblerrormsg"  runat="server" Text=""></asp:Label>	 
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="label-control"><b>முழுப்பெயர் <span class="asterisk">*</span></b></label>
                                                                <input runat="server" class="form-control track" type="text" onkeypress="return AllowAlphabet(event)" name="name" id="name" placeholder="தங்களது முழுப்பெயர்" maxlength="20" />
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" SetFocusOnError="true" runat="server" ControlToValidate="name" ErrorMessage="முழுப்பெயர் பதிவிடவும்" ValidationGroup="One" ForeColor="Red" Font-Names="Impact"></asp:RequiredFieldValidator>
                                                           
                                                                 </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="label-control"><b>தந்தை/கணவர் பெயர் <span class="asterisk">*</span></b></label>
                                                                <input runat="server" class="form-control track" type="text" onkeypress="return AllowAlphabet(event)" name="father_name" id="father_name" placeholder="தங்களது தந்தை / கணவர் பெயர்" maxlength="20" />
                                                              <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator2" runat="server" ControlToValidate="father_name" ErrorMessage="தந்தை/கணவர் பெயர் பதிவிடவும்" ValidationGroup="One" ForeColor="Red" Font-Names="Impact"></asp:RequiredFieldValidator>
                                                         </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">                                                     
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class='label-control'><b>பாலினம் <span class="asterisk">*</span></b></label>
                                                                <select runat="server" class="form-control track selectpicker" id="gender" name="gender">
                                                                    <option value="0">பாலினத்தைத் தேர்ந்தெடுக்கவும்</option>
                                                                    <option value="Male">ஆண்</option>
                                                                    <option value="Female">பெண்</option>
                                                                    <option value="Other">மற்றவை</option>
                                                                </select>
                                                                  <asp:RequiredFieldValidator SetFocusOnError="true"  ID="RequiredFieldValidator3" runat="server"   ControlToValidate="gender"   InitialValue="0" ValidationGroup="One"   ErrorMessage="* பாலினத்தைத் தேர்ந்தெடுக்கவும்"  ForeColor="Red" Font-Names="Impact" ></asp:RequiredFieldValidator>        
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group dobdiv">
                                                                  <label class="label-control"><b>பிறந்த தேதி <span class="asterisk">*</span></b></label><br />
                                                            <%--    <input runat="server" class="form-control track" type="text" name="name" id="Text1" placeholder="தங்களது முழுப்பெயர்" />--%>
                                                                  <asp:TextBox ID="txtfromdate" class="form-control track datewidth" onkeypress="return Allownumbers(event)"  runat="server" contenteditable="false"></asp:TextBox>
                                                    <asp:Image ID="ImgFrmdate" runat="server" ImageUrl="assets/Images/icon2.gif" CssClass="datecontrol" />
                                                     <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtfromdate" ErrorMessage="பிறந்த தேதி பதிவிடவும்" ValidationGroup="One" ForeColor="Red" Font-Names="Impact"></asp:RequiredFieldValidator>
                                                                 <ajaxToolkit:CalendarExtender runat="server"  ID="dtleaveFrmdate" Format="dd/MM/yyyy" PopupButtonID="ImgFrmdate" TargetControlID="txtfromdate" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--<div class="row">
                                                        
                                                    </div>-->
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="label-control"><b>ஏதேனும் ஒரு அடையாள அட்டை <small class="text-muted small-text"></small></b> </label>
                                                                <select  runat="server" class="form-control track selectpicker" data-size="8" name="identitycard" id="identitycard">
                                                                        <option value="0" hidden> ஏதேனும் ஒரு அடையாள அட்டை தேர்ந்தெடுக்கவும் </option>
                                                                         <option value="Driving License">ஓட்டுநர் உரிமை</option>
                                                                         <option value="Voter Id">வாக்காளர் அட்டை</option>
                                                                         <option value="Aadthar card">ஆதார் அட்டை</option>  
                                                                         <option value="Passport">பாஸ்போர்ட் அட்டை</option>                                                                        
                                                                    </select>
                                                                 <asp:RequiredFieldValidator SetFocusOnError="true"  ID="RequiredFieldValidator5" runat="server" ValidationGroup="One"   ControlToValidate="identitycard"   InitialValue="0"   ErrorMessage="* ஏதேனும் ஒரு அடையாள அட்டை தேர்ந்தெடுக்கவும்"  ForeColor="Red" Font-Names="Impact" ></asp:RequiredFieldValidator>        
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="label-control"><b>அடையாள அட்டை எண் <small class="asterisk">*</small></b></label>
                                                                <input runat="server" onkeypress="allowAlphaNumericSpace(event)" class="form-control track" type="text" name="identityCardNo"  id="identityCardNo" placeholder="தங்களது அடையாள அட்டை எண்" />
                                                               <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator6" runat="server" ControlToValidate="identityCardNo" ErrorMessage="அடையாள அட்டை எண்ணைப் பதிவிடவும்" maxlength="15" ValidationGroup="One" ForeColor="Red" Font-Names="Impact"></asp:RequiredFieldValidator>
                                                            </div>
                                                        </div>                                                      
                                                    </div>

                                                <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="label-control"><b>மொபைல் எண்  <small class="asterisk">*</small></b> </label>
                                                               <div class="input-group mobile_new_input" style="border:1px solid black; border-radius:5px;">
                                <span class="input-group-addon" style="background-color:none !important">+91</span>
                                    <input type="text" class="form-control new_input group only_mobile" runat="server" id="txtMobileNo" name="signup_mobile" onkeypress="return Allownumbers(event)" placeholder="10 இலக்க மொபைல் எண்ணைப் பதிவிடவும்" maxlength="10"/>
                              <br />
                                                                    </div><asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtMobileNo" ErrorMessage="மொபைல் எண்ணைப் பதிவிடவும்" ValidationGroup="One" ForeColor="Red" Font-Names="Impact"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"  ControlToValidate="txtMobileNo" ErrorMessage="10 இலக்க மொபைல் எண்ணைப் பதிவிடவும்" ValidationGroup="One"  ValidationExpression="[0-9]{10}" ForeColor="Red" Font-Names="Impact"></asp:RegularExpressionValidator> 
                                                                <%-- <input runat="server" class="form-control track voterinput" type="text" name="Mobileno" id="Mobileno" placeholder="தங்களது கைப்பேசி எண்" />--%>
                                                            </div>
                                                        </div>
                                                     <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="label-control"><b>வாட்சப் எண் </b> </label>
                                                               <div class="input-group mobile_new_input" style="border:1px solid black;border-radius:5px;">
                                <span class="input-group-addon" >+91</span>
                                    <input type="text" class="form-control new_input group only_mobile" runat="server" id="txtwhatsapp"  name="signup_whatsapp" onkeypress="return Allownumbers(event)" placeholder="10 இலக்க மொபைல் எண்ணைப் பதிவிடவும்" maxlength="10"/>
                                                                   <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server"  ControlToValidate="txtwhatsapp" ErrorMessage="10 இலக்க மொபைல் எண்ணைப் பதிவிடவும்" ValidationGroup="One1"  ValidationExpression="[0-9]{10}" ForeColor="Red" Font-Names="Impact"></asp:RegularExpressionValidator>--%>
                              <br />
                                                                    </div>
                                                               
                                                                <%-- <input runat="server" class="form-control track voterinput" type="text" name="Mobileno" id="Mobileno" placeholder="தங்களது கைப்பேசி எண்" />--%>
                                                            </div>
                                                        </div>
                                                                                                          
                                                    </div>


                                                    <div class="row">                                                       
                                                        <div class="col-md-6 electrol">

                                                                 <div class="form-group">
                                                                    <label class="label-control"><b>மாவட்டத்தைத் தேர்ந்தெடுக்கவும் <span class="asterisk">*</span></b></label>
                                                                    <select runat="server" class="form-control track selectpicker" data-live-search="true" data-size="8" name="district" id="district">
                                                                        <%--<option value="0" hidden> மாவட்டத்தைத் தேர்ந்தெடுக்கவும் </option>
                                                                         <option value="Chennai Central">மத்திய சென்னை </option>
                                                                         <option value="Chennai South">தென் சென்னை</option>
                                                                         <option value="Chennai North" >வட சென்னை</option>
                                                                         <option value="Thiruvallur West" >திருவள்ளூர் மேற்கு</option>
                                                                         <option value="Thiruvallur East">திருவள்ளூர் கிழக்கு </option>
                                                                         <option value="Kanchipuram">காஞ்சிபுரம்</option>
                                                                         <option value="Chengalpattu  North" >செங்கல்பட்டு வடக்கு</option>
                                                                         <option value="Chengalpattu South" >செங்கல்பட்டு தெற்கு</option>
                                                                         <option value="Viluppuram">விழுப்புரம் </option>
                                                                         <option value="Kallakkurichi">கள்ளக்குறிச்சி</option>
                                                                         <option value="Tiruvannamalai South" >திருவண்ணாமலை தெற்கு</option>
                                                                         <option value="Tiruvannamalai North" >திருவண்ணாமலை வடக்கு</option>
                                                                         <option value="Tirupathur">திருப்பத்தூர் </option>
                                                                         <option value="Vellore">வேலூர்</option>
                                                                         <option value="Cuddalore South" >கடலூர் தெற்கு</option>
                                                                         <option value="Cuddalore North" >கடலூர் வடக்கு</option>
                                                                         <option value="Nagaipattinam North">நாகப்பட்டினம் வடக்கு </option>
                                                                         <option value="Nagaipattinam South">நாகப்பட்டினம் தெற்கு </option>
                                                                         <option value="Thanjavur South" >தஞ்சாவூர் தெற்கு</option>
                                                                         <option value="Thanjavur North" >தஞ்சாவூர் வடக்கு</option>
                                                                         <option value="Perambalur">பெரம்பலூர்</option>
                                                                         <option value="Trichy South">திருச்சி தெற்கு</option>
                                                                         <option value="Trichy North" >திருச்சி வடக்கு</option>
                                                                         <option value="Pudukkottai" >புதுக்கோட்டை</option>
                                                                         <option value="Krishnagiri">கிருஷ்ணகிரி</option>
                                                                         <option value="Salem">சேலம்</option>
                                                                         <option value="Erode South" >ஈரோடு தெற்கு</option>
                                                                         <option value="Erode North" >ஈரோடு வடக்கு</option>
                                                                         <option value="Dindigul South">திண்டுக்கல் மேற்கு</option>
                                                                         <option value="Dindigul East">திண்டுக்கல் கிழக்கு</option>
                                                                         <option value="karur" >கரூர்</option>
                                                                         <option value="Coimbatore North" >கோயமுத்தூர் வடக்கு</option>
                                                                        <option value="Coimbatore South" >கோயமுத்தூர் தெற்கு</option>
                                                                         <option value="Theni" >தேனி</option>
                                                                         <option value="Virudhunagar">விருதுநகர்</option>
                                                                         <option value="Madurai South">மதுரை தெற்கு</option>
                                                                         <option value="Madurai North" >மதுரை வடக்கு</option>
                                                                         <option value="Thoothukudi" >தூத்துக்குடி</option>
                                                                         <option value="Tenkasi">தென்காசி</option>
                                                                         <option value="Tirunelveli">திருநெல்வேலி</option>
                                                                         <option value="Nilgiris" >நீலகிரி</option>
                                                                         <option value="Thiruvarur" >திருவாரூர்</option>
                                                                         <option value="Ramanathapuram">இராமநாதபுரம்</option>
                                                                         <option value="Kanniyakumari">கன்னியாகுமரி</option>
                                                                         <option value="Sivaganga" >சிவகங்கை</option>
                                                                         <option value="Dharmapuri">தருமபுரி</option>
                                                                        <option value="Thiruppur North">திருப்பூர் வடக்கு</option>
                                                                         <option value="Thiruppur South">திருப்பூர் தெற்கு</option>
                                                                         <option value="Namakkal" >நாமக்கல்</option> --%>
                                                                    </select>
                                                             <asp:RequiredFieldValidator SetFocusOnError="true"  ID="RequiredFieldValidator9" runat="server" ValidationGroup="One"   ControlToValidate="district"   InitialValue="0"   ErrorMessage="* மாவட்டத்தைத் தேர்ந்தெடுக்கவும்"  ForeColor="Red" Font-Names="Impact" ></asp:RequiredFieldValidator>                                                                    
                                                                </div>

                                                          <div class="form-group">
                                                                   <%-- <label class='label-control'><b>சட்டமன்றத் தொகுதி <span class="asterisk">*</span></b></label>
                                                               <select runat="server" class="form-control track selectpicker constitu"  data-live-search="true" data-size="8" name="constiuency" id="constiuency">
                                                                    <option value="0" hidden>சட்டமன்றத் தொகுதியைத் தேர்ந்தெடுக்கவும் </option>
                                                                    <option value="Gummidipoondi" >கும்மிடிபூண்டி</option>
                                                                    <option value="Ponneri">பொன்னேரி</option>
                                                                    <option value="Tiruttani">திருத்தனி</option>
                                                                    <option value="Thiruvallur">திருவள்ளூர்</option>
                                                                    <option value="Poonmallae">பூவிருந்தவல்லி</option>
                                                                    <option value="Avadi">ஆவடி</option>
                                                                    <option value="Maduravoyal">மதுரவாயல்</option>
                                                                    <option value="Ambattur">அம்பத்தூர்</option>
                                                                    <option value="Madavaram">மாதவரம்</option>
                                                                    <option value="Thiruvottiyur">திருவொற்றியூர்</option>
                                                                    <option value="Dr.Radhakrishnan Nagar">ஆர்.கே நகர் </option>
                                                                    <option value="Perambur">பெரம்பூர்</option>
                                                                    <option value="Kolathur">கொளத்தூர்</option>
                                                                    <option value="Villivakkam">வில்லிவாக்கம்</option>
                                                                    <option value="Thiru-Vi-Ka-Nagar">திரு வி.க நகர்</option>
                                                                    <option value="Egmore">எழும்பூர்</option>
                                                                    <option value="Royapuram">ராயபுரம்</option>
                                                                    <option value="Harbour">துறைமுகம்</option>
                                                                    <option value="Chepauk">சேப்பாக்கம்</option>
                                                                    <option value="Thousand Lights">ஆயிரம் விளக்கு</option>
                                                                    <option value="Anna Nagar">அண்ணா நகர்</option>
                                                                    <option value="Virugampakkam">விருகம்பாக்கம்</option>
                                                                    <option value="Saidapet">சைதாப்பேட்டை</option>
                                                                    <option value="Thiyagarayanagar">தியாகராய நகர்</option>
                                                                    <option value="Mylapore">மயிலாப்பூர்</option>
                                                                    <option value="Velachery">வேளச்சேரி</option>
                                                                    <option value="Shozhinganallur">சோழிங்கநல்லூர்</option>
                                                                    <option value="Alandur">ஆலந்தூர்</option>
                                                                    <option value="Sriperumbudur">ஸ்ரீபெரும்புதூர்</option>
                                                                    <option value="Pallavaram">பல்லாவரம்</option>
                                                                    <option value="Tambaram">தாம்பரம்</option>
                                                                    <option value="Chengalpattu">செங்கல்பட்டு</option>
                                                                    <option value="Thiruporur">திருப்போரூர்</option>
                                                                    <option value="Cheyyur">செய்யூர்</option>
                                                                    <option value="Madurantakam">மதுராந்தகம்</option>
                                                                    <option value="Uthiramerur">உத்திரமேரூர்</option>
                                                                    <option value="Kancheepuram">காஞ்சிபுரம்</option>
                                                                   <option value="Arakkonam">அரக்கோணம்</option>
                                                                    <option value="Sholingur">சோளிங்கர்</option>
                                                                    <option value="Katpadi">காட்பாடி</option>
                                                                    <option value="Ranipet">இராணிப்பேட்டை</option>
                                                                    <option value="Arcot">ஆற்காடு</option>
                                                                    <option value="Vellore">வேலூர்</option>
                                                                    <option value="Anaikattu">அணைக்கட்டு</option>
                                                                    <option value="Kilvaithinankuppam">கே.வி குப்பம் </option>
                                                                    <option value="Gudiyattam">குடியாத்தம்</option>
                                                                    <option value="Vaniyambadi">வாணியம்பாடி</option>
                                                                    <option value="Ambur">ஆம்பூர்</option>
                                                                    <option value="Jolarpet">ஜோலர்பெட்</option>
                                                                    <option value="Tirupattur">திருப்பத்தூர்</option>
                                                                    <option value="Uthangarai">ஊத்தங்கரை</option>
                                                                    <option value="Bargur">பர்கூர் </option>
                                                                    <option value="Krishnagiri">கிருஷ்ணகிரி</option>
                                                                    <option value="Veppanahalli">வேப்பனபள்ளி</option>
                                                                    <option value="Hosur">ஓசூர்</option>
                                                                    <option value="Thalli">தளி </option>
                                                                    <option value="Palacodu">பாலக்கோடு</option>
                                                                    <option value="Pennagaram">பென்னாகரம்</option>
                                                                    <option value="Dharmapuri">தர்மபுரி</option>
                                                                    <option value="Pappireddippatti">பாப்பிரெட்டிப்பட்டி</option>
                                                                    <option value="Harur">அரூர்</option>
                                                                    <option value="Chengam">செங்கம்</option>
                                                                    <option value="Tiruvannamalai">திருவண்ணாமலை</option>
                                                                    <option value="Kilpennathur">கீழ்பென்னாத்தூர்</option>
                                                                    <option value="Kalasapakkam">கலசபாக்கம்</option>
                                                                    <option value="Polur">போளூர்</option>
                                                                    <option value="Arani">ஆரணி</option>
                                                                    <option value="Cheyyar">செய்யாறு</option>
                                                                    <option value="Vandavasi" >வந்தவாசி</option>
                                                                    <option value="Gingee">செஞ்சி</option>
                                                                    <option value="Mailam">மயிலம் </option>
                                                                    <option value="Tindivanam">திண்டிவனம்</option>
                                                                    <option value="Vanur">வானூர்</option>
                                                                    <option value="Villupuram">விழுப்புரம்</option>
                                                                    <option value="Vikravandi">விக்கிரவாண்டி</option>
                                                                    <option value="Tirukkoyilur">திருக்கோவிலூர்</option>
                                                                    <option value="Ulundurpettai">உளுந்தூர்பேட்டை</option>
                                                                    <option value="Rishivandiyam">ரிஷிவந்தியம்</option>
                                                                    <option value="Sankarapuram">சங்கராபுரம்</option>
                                                                    <option value="Kallakurichi">கள்ளக்குறிச்சி</option>
                                                                    <option value="Gangavalli">கங்கவள்ளி</option>
                                                                    <option value="Attur">ஆத்தூர்</option>
                                                                    <option value="Yercaud">ஏற்காடு</option>
                                                                    <option value="Omalur">ஓமலூர்</option>
                                                                    <option value="Mettur">மேட்டூர்</option>
                                                                    <option value="Edappadi">எடப்பாடி</option>
                                                                    <option value="Sankari">சங்கரகிரி </option>
                                                                    <option value="Salem (West)">சேலம் மேற்கு </option>
                                                                    <option value="Salem (North)">சேலம் வடக்கு </option>
                                                                    <option value="Salem (South)">சேலம் தெற்கு </option>
                                                                    <option value="Veerapandi">வீரபாண்டி</option>
                                                                    <option value="Rasipuram">ராசிபுரம்</option>
                                                                    <option value="Senthamangalam">சேந்தமங்கலம்</option>
                                                                    <option value="Namakkal">நாமக்கல்</option>
                                                                    <option value="Paramathi-Velur">பரமத்தி-வேலூர்</option>
                                                                    <option value="Tiruchengodu">திருசெங்கோடு</option>
                                                                    <option value="Kumarapalayam">குமாரபாளையம் </option>
                                                                    <option value="Erode (East)">ஈரோடு கிழக்கு </option>
                                                                    <option value="Erode (West)">ஈரோடு மேற்கு </option>
                                                                    <option value="Modakkurichi">மொடக்குறிச்சி</option>
                                                                    <option value="Perundurai">பெருந்துறை</option>
                                                                    <option value="Bhavani">பவானி</option>
                                                                    <option value="Anthiyur">அந்தியூர்</option>
                                                                    <option value="Gobichettipalayam">கோபிச்செட்டிப்பாளையம்</option>
                                                                    <option value="Bhavanisagar">பவானிசாகர்</option>
                                                                   <option value="Udhagamandalam">உதகமண்டலம்</option>
                                                                    <option value="Gudalur">கூடலூர்</option>
                                                                    <option value="Coonoor">குன்னூர்</option>
                                                                    <option value="Mettuppalayam">மேட்டுப்பாளையம்</option>
                                                                    <option value="Sulur">சூலூர்</option>
                                                                    <option value="Kavundampalayam">கவுண்டன்பாளையம் </option>
                                                                    <option value="Coimbatore (North)">கோவை வடக்கு </option>
                                                                    <option value="Thondamuthur">தொண்டாமுத்தூர்</option>
                                                                    <option value="Coimbatore (South)">கோவை தெற்கு </option>
                                                                    <option value="Singanallur">சிங்காநல்லூர்</option>
                                                                    <option value="Kinathukadavu">கிணத்துக்கடவு</option>
                                                                    <option value="Pollachi">பொள்ளாச்சி</option>
                                                                    <option value="Valparai">வால்பாறை</option>
                                                                    <option value="Palani">பழனி</option>
                                                                    <option value="Oddanchatram">ஒட்டன்சத்திரம்</option>
                                                                    <option value="Athoor">ஆத்தூர்</option>
                                                                    <option value="Nilakkottai">நிலகோட்டை</option>
                                                                    <option value="Natham">நத்தம்</option>
                                                                    <option value="Dindigul">திண்டுக்கல்</option>
                                                                    <option value="Vedasandur">வேடசந்தூர்</option>
                                                                    <option value="Aravakurichi">அரவக்குறிச்சி</option>
                                                                    <option value="Karur">கரூர்</option>
                                                                    <option value="Krishnarayapuram">கிருஷ்ணராயபுரம்</option>
                                                                    <option value="Kulithalai">குளித்தலை</option>
                                                                    <option value="Manapparai">மணப்பாறை</option>
                                                                    <option value="Srirangam">திருவரங்கம்</option>
                                                                    <option value="Tiruchirappalli (West)">திருச்சி மேற்கு</option>
                                                                    <option value="Tiruchirappalli (East)">திருச்சி கிழக்கு</option>
                                                                    <option value="Thiruverumbur">திருவெறும்பூர்</option>
                                                                    <option value="Lalgudi">லால்குடி</option>
                                                                    <option value="Manachanallur">மண்ணச்சநல்லூர்</option>
                                                                   <option value="Musiri" >முசிறி</option>
                                                                    <option value="Thuraiyur">துறையூர்</option>
                                                                    <option value="Perambalur">பெரம்பலூர்</option>
                                                                    <option value="Kunnam">குன்னம்</option>
                                                                    <option value="Tittakudi">திட்டக்குடி</option>
                                                                    <option value="Vriddhachalam">விருத்தாச்சலம்</option>
                                                                    <option value="Neyveli">நெய்வேலி</option>                                                                   
                                                                    <option value="Cuddalore">கடலூர்</option>
                                                                    <option value="Kurinjipadi">குறிஞ்சிப்பாடி</option>
                                                                    <option value="Bhuvanagiri">புவனகிரி</option>
                                                                    <option value="Chidambaram">சிதம்பரம்</option>
                                                                    <option value="Kattumannarkoil">காட்டுமன்னார்கோயில்</option>
                                                                    <option value="Sirkazhi">சீர்காழி</option>
                                                                    <option value="Mayiladuthurai">மயிலாடுதுறை</option>
                                                                    <option value="Nagapattinam">நாகப்பட்டினம்</option>
                                                                    <option value="Kilvelur">கீழ்வேளூர்</option>
                                                                    <option value="Vedaranyam">வேதாரண்யம்</option>
                                                                    <option value="Thiruthuraipoondi">திருத்துறைப்பூண்டி</option>
                                                                    <option value="Mannargudi">மன்னார்குடி</option>
                                                                    <option value="Thiruvarur">திருவாரூர்</option>
                                                                    <option value="Nannilam">நன்னிலம்</option>
                                                                    <option value="Thiruvidaimarudur">திருவிடைமருதூர்</option>
                                                                    <option value="Kumbakonam">கும்பகோணம்</option>
                                                                    <option value="Papanasam">பாபநாசம்</option>
                                                                    <option value="Thiruvaiyaru">திருவையாறு</option>
                                                                    <option value="Thanjavur">தஞ்சாவூர்</option>
                                                                    <option value="Orathanadu">ஒரத்தநாடு</option>
                                                                    <option value="Pattukkottai">பட்டுக்கோட்டை</option>
                                                                    <option value="Peravurani">பேராவூரணி</option>
                                                                    <option value="Gandharvakottai">கந்தர்வகோட்டை</option>
                                                                    <option value="Viralimalai">விராலிமலை</option>
                                                                    <option value="Pudukkottai">புதுக்கோட்டை</option>
                                                                    <option value="Thirumayam">திருமயம்</option>
                                                                    <option value="Alangudi">ஆலங்குடி</option>
                                                                    <option value="Aranthangi">அறந்தாங்கி</option>
                                                                    <option value="Karaikudi">காரைக்குடி</option>
                                                                   <option value="Tiruppattur">திருப்பத்தூர்</option>                                                                  
                                                                    <option value="Manamadurai">மானமதுரை</option>
                                                                    <option value="Melur">மேலூர்</option>
                                                                    <option value="Madurai East">மதுரை கிழக்கு</option>
                                                                    <option value="Sholavandan">சோழவந்தான்</option>
                                                                    <option value="Madurai North">மதுரை வடக்கு</option>
                                                                    <option value="Madurai South">மதுரை தெற்கு</option>
                                                                    <option value="Madurai Central">மதுரை சென்ட்ரல்</option>
                                                                    <option value="Madurai West">மதுரை மேற்கு</option>
                                                                    <option value="Thiruparankundram">திருப்பரங்குன்றம்</option>
                                                                    <option value="Thirumangalam">திருமங்கலம்</option>
                                                                    <option value="Usilampatti">உசிலம்பட்டி</option>
                                                                    <option value="Andipatti">ஆண்டிப்பட்டி</option>
                                                                    <option value="Periyakulam">பெரியகுளம்</option>
                                                                    <option value="Bodinayakanur">போடிநாயக்கனூர்</option>
                                                                    <option value="Cumbum">கம்பம்</option>
                                                                    <option value="Rajapalayam">இராசபாளையம்</option>
                                                                    <option value="Srivilliputhur">ஸ்ரீவில்லிபுத்தூர்</option>
                                                                    <option value="Sattur">சாத்தூர்</option>
                                                                    <option value="Sivakasi">சிவகாசி</option>
                                                                    <option value="Virudhunagar">விருதுநகர்</option>
                                                                    <option value="Aruppukkottai">அருப்புக்கோட்டை</option>
                                                                    <option value="Tiruchuli">திருச்சுழி</option>
                                                                    <option value="Paramakudi">பரமக்குடி</option>
                                                                    <option value="Tiruvadanai">திருவடனை</option>
                                                                    <option value="Ramanathapuram">இராமநாதபுரம்</option>
                                                                    <option value="Mudhukulathur">முதுகுளத்தூர் </option>
                                                                    <option value="Vilathikulam">விளாத்திகுளம்</option>
                                                                    <option value="Thoothukkudi">தூத்துக்குடி</option>
                                                                    <option value="Tiruchendur">திருச்செந்தூர்</option>
                                                                    <option value="Srivaikuntam" >ஸ்ரீ வைகுண்டம்</option>
                                                                    <option value="Ottapidaram">ஒட்டபிடாரம்</option>
                                                                    <option value="Kovilpatti">கோவில்பட்டி</option>
                                                                    <option value="Sankarankovil">சங்கரன்கோவில்</option>
                                                                    <option value="Vasudevanallur">வாசுதேவநல்லூர்</option>
                                                                    <option value="Kadayanallur">கடையநல்லூர்</option>
                                                                    <option value="Tenkasi">தென்காசி</option>
                                                                    <option value="Alangulam">ஆலங்குளம்</option>
                                                                    <option value="Tirunelveli">திருநெல்வேலி</option>
                                                                    <option value="Ambasamudram">அம்பாசமுத்திரம்</option>
                                                                    <option value="Palayamkottai">பாளையங்கோட்டை</option>
                                                                    <option value="Nanguneri">நாங்குநேரி</option>
                                                                    <option value="Radhapuram">ராதாபுரம்</option>
                                                                    <option value="Kanniyakumari">கன்னியாகுமரி</option>
                                                                    <option value="Nagercoil">நாகர்கோவில்</option>
                                                                    <option value="Colachal">குளச்சல் </option>
                                                                    <option value="Padmanabhapuram">பத்மனாபபுரம்</option>
                                                                    <option value="Vilavancode">விளவன்கோடு</option>
                                                                    <option value="Killiyoor">கிள்ளியூர்</option>
                                                                    <option value="Ariyalur">அரியலூர்</option>
                                                                    <option value="Jayankondam">ஜெயங்கொண்டம்</option>
                                                                    <option value="Dharapuram">தாராபுரம்</option>
                                                                    <option value="Kangayam">காங்கேயம்</option>
                                                                    <option value="Avanashi">அவிநாசி</option>
                                                                    <option value="Tiruppur North">திருப்பூர் (வடக்கு)</option>
                                                                    <option value="Tiruppur South">திருப்பூர் தெற்கு</option>
                                                                    <option value="Paramathi-Velur">பரமதி-வேலூர்</option>
                                                                    <option value="Palladam">பல்லடம்</option>
                                                                    <option value="Udumalaipettai">உடுமலைப்பேட்டை </option>
                                                                    <option value="Madathukulam">மடத்துக்குளம்</option>                                                                    
                                                                </select> --%>
                                                               <%--<asp:RequiredFieldValidator SetFocusOnError="true"  ID="RequiredFieldValidator8" runat="server" ValidationGroup="One"   ControlToValidate="constiuency"   InitialValue="0"   ErrorMessage="* சட்டமன்றத் தொகுதியைத் தேர்ந்தெடுக்கவும்"  ForeColor="Red" Font-Names="Impact" ></asp:RequiredFieldValidator>  --%>                                                                  
                                                           </div>  
                                                        
                                                       <%-- <div class="form-group">
                                                                    <label class="label-control"><b>அணியைத் தேர்ந்தெடுக்கவும் <span class="asterisk">*</span></b></label>
                                                                    <select runat="server" class="form-control track selectpicker" data-live-search="true" data-size="8" name="team" id="team">
                                                                        <option value="0" hidden> அணியைத் தேர்ந்தெடுக்கவும் </option>
                                                                         <option value="IUML">முஸ்லீம் லீக் (IUML)</option>
                                                                         <option value="MYL">முஸ்லீம் இளைஞர் அணி (MYL)</option>
                                                                         <option value="MSF">முஸ்லீம்  மாணவர் பேரவை (MSF)</option>
                                                                         <option value="WL" >மகளிர் அணி(WL)</option>
                                                                         <option value="ITWING" >தகவல் தொழில்நுட்ப அணி  (IT Wing)</option>
                                                                    </select>
                                                                     <asp:RequiredFieldValidator SetFocusOnError="true"  ID="RequiredFieldValidator11" runat="server" ValidationGroup="One"   ControlToValidate="team"   InitialValue="0"   ErrorMessage="* அணியைத் தேர்ந்தெடுக்கவும்"  ForeColor="Red" Font-Names="Impact" ></asp:RequiredFieldValidator>                                                              
                                                                </div>--%> 
                                                            
                                                            <div class="form-group">
                                                                <label class="label-control"><b>இரத்த வகை  <small class="text-muted small-text"></small></b> </label>
                                                                <select runat="server" class="form-control track selectpicker" data-size="8" name="bloodgroup" id="bloodgroup">
                                                                        <option value="" hidden> ஒரு இரத்த வகையை தேர்ந்தெடுக்கவும் </option>
                                                                         <option value="A+">A+</option>
                                                                         <option value="A-">A-</option>
                                                                         <option value="B+">B+</option> 
                                                                         <option value="B-">B-</option>
                                                                         <option value="O+">O+</option>
                                                                         <option value="O-">O-</option>
                                                                         <option value="AB+">AB+</option>
                                                                         <option value="AB-">AB-</option>                                                                        
                                                                    </select>                                                                 
                                                            </div>
                                                        
                                                             
                                                            <div class="form-group">
                                                                <label class="label-control"><b>மின்னஞ்சல் முகவரி <small class="text-muted small-text"></small></b></label>
                                                                <input runat="server" class="form-control track" type="text" name="emailid" id="emailid" placeholder="தங்களது மின்னஞ்சல் முகவரி" maxlength="40" />
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="emailid" ForeColor="Red" ValidationGroup="One" ValidationExpression="^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$" Display = "Dynamic" ErrorMessage = "Invalid email address"/>
                                                            </div>
                                                       
                                                        
                                                        </div>
                                                            <div class="col-md-6 electrol">   
                                                               <div class="form-group">
                                                                    <label class='label-control'><b> விலாசம் 1 (Address1) <span class="asterisk">*</span></b></label>    
                                                          <%--  <input runat="server" class="form-control track" type="text" onkeypress="return AllowAlphabet(event)" name="name" id="Text1" placeholder="தங்களது முழுப்பெயர்" />--%>
                                                                   <textarea id="txtadress" name="txtadress" class="form-control track" runat="server" rows="5" cols="25" maxlength="125"></textarea>  
                                                        <asp:RequiredFieldValidator SetFocusOnError="true" ID="RequiredFieldValidator10" runat="server" ControlToValidate="txtadress" ErrorMessage="விலாசம் பதிவிடவும் " ValidationGroup="One" ForeColor="Red" Font-Names="Impact"></asp:RequiredFieldValidator>
                                                               </div>     
                                                                <textarea id="txtadress2" name="txtadress2" class="form-control track" runat="server" rows="1" cols="50" maxlength="25" visible="false"></textarea>
                                                                <textarea id="txtadress3" name="txtadress3" class="form-control track" runat="server" rows="1" cols="50" maxlength="25" visible="false"></textarea>
                                                               
                                                               <%-- <div class="form-group" style="margin-bottom:3em" >
                                                                    <label class='label-control'><b> விலாசம் 2(Address2) <span class="asterisk"></span></b></label>
                                                                   <textarea id="txtadress2" name="txtadress2" class="form-control track" runat="server" rows="1" cols="50" maxlength="25" visible="false"></textarea>  
                                                              </div> 
                                                              <div class="form-group">
                                                                    <label class='label-control'><b> விலாசம் 3 (Address3) <span class="asterisk"></span></b></label> 
                                                                   <textarea id="txtadress3" name="txtadress3" class="form-control track" runat="server" rows="1" cols="50" maxlength="25" visible="false"></textarea>  
                                                               </div> --%>
                                                                                                                               
                                                                 </div>
                                                        </div> 
                                                  <div class="row">                                                     
                                                       <div class="col-md-6">                                                      
                                                            <div class="form-group" id="Photoinsert" runat="server">
                                                                 <label class="label-control"><b>புகைப்படத்தைப் பதிவேற்றவும்<small class="asterisk">*</small></b> </label>
                                                                <asp:FileUpload ID="FileUpload1"  runat="server" onchange="CheckExt(this)" />   
                                                                 <b> <small class="form-text text-muted">
                                                                இப்புகைப்படம் உங்கள் அடையாள அட்டையில் இடம்பெறும்
                                                            </small></b> 
                                                               <%-- <asp:RequiredFieldValidator  ID="RequiredFieldValidator13"  runat="server" ControlToValidate="FileUpload1" ValidationGroup="One"   ErrorMessage="புகைப்படத்தைப் பதிவேற்றவும்!" ForeColor="Red" Font-Names="Impact"  ></asp:RequiredFieldValidator>   --%>                                                       
                                                            </div> 
                                                             <div class="form-group" id="updatephoto" runat="server" visible="false">
                                                                 <label class="label-control"><b>புகைப்படத்தைப் பதிவேற்றவும்<small class="asterisk">*</small></b> </label>
                                                               <br /> <asp:Image runat="server" ID="imgEditphoto" ImageUrl="#" height="75px" Width="75px"/>
                                                                 <asp:FileUpload ID="FileUpload2" runat="server" onchange="showpreview(this);" ></asp:FileUpload> 
                                                                 <b> <small class="form-text text-muted">
                                                                இப்புகைப்படம் உங்கள் அடையாள அட்டையில் இடம்பெறும்
                                                            </small></b> 
                                                                <%--<asp:RequiredFieldValidator  ID="RequiredFieldValidator12"  runat="server" ControlToValidate="imgEditphoto" ErrorMessage="புகைப்படத்தைப் பதிவேற்றவும்!" ForeColor="Red" Font-Names="Impact"  ></asp:RequiredFieldValidator>                                                          --%>
                                                            </div>                                           
                                                        </div>
                                                       
                                                  </div>
                                                 <div class="row">                                                         
                                                     <div class="col-md-6">
                                                          <div class="form-group">
                                                               <label id="lbldes" Visible="false" runat="server" class="label-control"><b>உறுப்பினரின் பதவி</b> </label>
                                                              <input runat="server" class="form-control track" type="text" Visible="false" name="txtdesination" id="txtdesination" placeholder="உறுப்பினரின் பதவி" />
                                                             <%--  <asp:TextBox  runat="server" ID="txtdesination" Visible="false"></asp:TextBox>--%>
                                                              </div>
                                                         </div>
                                                     </div>
                                                   <div class="row">
                                                     <div class="col-md-12">
                                                             <div class="form-group">
                                                                 <asp:CheckBox runat="server" CssClass="chkboxotherparty" ID="chkboxotherparty" text=" "/>
                                                                 <span style="color: #d01172;font-weight: 600;font-size: 14px;"> நான் எந்தவொரு அரசியல் கட்சியிலும் உறுப்பினராகயில்லை என்பதை உறுதியளிக்கிறேன். மேலும்  உறுப்பினர் கட்டணம் ரூ 20 செலுத்தி உறுப்பினர் அட்டை பெற்று கொள்வேன்.</span>
                                                               <asp:CustomValidator id="valcheckBoxTemp" SetFocusOnError="true" runat="server" ClientValidationFunction="checkTemp" ErrorMessage="உறுதியளிக்கவும்" ForeColor="Red" Font-Names="Impact"  ValidationGroup="One" ></asp:CustomValidator>
                                                                 <%-- <asp:RequiredFieldValidator  ID="RequiredFieldValidator12" runat="server" ValidationGroup="One"   ControlToValidate="chkboxotherparty"   InitialValue="0"   ErrorMessage="* அணியைத் தேர்ந்தெடுக்கவும்"  ForeColor="Red" Font-Names="Impact" ></asp:RequiredFieldValidator>                                                              --%>
                                                                  </div>
                                                     </div>
                                                  </div>
                                                </div>
                                        <asp:Button ID="btnsubmit" OnClick="btnsubmit_Click" ValidationGroup="One" class="btn btn-custom next" runat="server" Text="Submit" />
                                        <asp:Button ID="btnUpdate" OnClick="btnUpdate_Click" ValidationGroup="One" class="btn btn-custom next" runat="server" Text="Update" Visible="false" />
                                        <asp:Button ID="btncancel" OnClick="btnCancel_Click" ValidationGroup="One" BackColor="red" class="btn btn-custom next" runat="server" Text="Cancel" Visible="false" />
                                          
                                        </fieldset>


   
</asp:Content>



