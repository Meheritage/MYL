<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MembersList.aspx.cs" Inherits="MembersList" EnableEventValidation="false"  %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .ob_gBody .ob_gC, .ob_gBody .ob_gCW {
            border: 1px solid black;
        }
        .col-md-10 {
            max-width:100% !important;
        }
        @media (min-width: 1200px) {
            .col-lg-10 {
                 width:100% !important;
            }
        }
        .row {
            display:inline;
        }
        .btnShaOpen
        {
             background-color:#f15d3b;             
        }
        .btnShaOpen1
        {
             background-color:#79f13b;
        }
        .btnShaOpen {
    line-height: 14px;
    border: 0;
    width: 50px;
    height: 33px;
    /*background-color: rgba(56,106,139,1);*/
    color: transparent;
    text-decoration: none;
    text-align: center;
    font-family: 'Sakkal Majalla';
    font-weight: bold;
    cursor: pointer;
    margin: 3px 0px;
    background-size: contain;
    /*border-radius: 21px;*/
    background-image: url(../assets/Images/EditCom.png);
    background-position-y: 0px;
    background-position-x: 5px;
    background-repeat: no-repeat;
    background-color: transparent;
}
         .btnShaprint {
    line-height: 14px;
    border: 0;
    width: 30px;
    height: 20px;
    /*background-color: rgba(56,106,139,1);*/
    color: transparent;
    text-decoration: none;
    text-align: center;
    font-family: 'Sakkal Majalla';
    font-weight: bold;
    cursor: pointer;
    margin: 3px 0px;
    background-size: contain;
    /*border-radius: 21px;*/
    background-image: url(../assets/Images/print.png);
    background-position-y: 0px;
    background-position-x: 5px;
    background-repeat: no-repeat;
    background-color: transparent;
}
        .container {
            max-width: 100% !important;
        }
        .griddiv {
    /*position: absolute;*/
    /*top: 100px;
    left: 0px;*/
    height: 82.5%;
    width: 100%;
    background-color: #fff;
    /*border: 1px solid #30425e;*/
}
        .btnDispatchAll {
            left:7%;
    margin-top: -20px;
    position: absolute;
    margin-left: 200px;
    height: 18px;
    line-height: 14px;
    border: 0;
    width: 70px;   
    background-color: rgba(56, 106, 138, 1);
    color: white;
    text-decoration: none;   
    font-family: 'Sakkal Majalla'; 
    background-position-y: 5px;
    background-position-x: 5px;
    background-repeat: no-repeat;
    cursor: pointer;
}
        .btnDispatchAllN {
            /*left:20%;*/
    margin-top: -10px;
    position: absolute;
    /*margin-left: 200px;*/
    height: 28px;
    line-height: 14px;
    border: 0;
    width: 120px;   
    background-color: rgba(56, 106, 138, 1);
    color: white;
    text-decoration: none;   
    font-family: 'Sakkal Majalla'; 
    background-position-y: 5px;
    background-position-x: 5px;
    background-repeat: no-repeat;
    cursor: pointer;
    font-weight:600;
    font-size:15px;
     border-radius:5px 5px 0 0;
}
         .btnDispatchAllN1 {
           left:18%;
    margin-top: -10px;
    position: absolute;
    /*margin-left: 200px;*/
    height: 28px;
    line-height: 14px;
    border: 0;
    width: 120px;   
    background-color: rgba(56, 106, 138, 1);
    color: white;
    text-decoration: none;   
    font-family: 'Sakkal Majalla'; 
    background-position-y: 5px;
    background-position-x: 5px;
    background-repeat: no-repeat;
    cursor: pointer;
    font-weight:600;
    font-size:15px;
}


         .btnDispatchAll1 {            
    margin-top: -10px;
    position: absolute;
    margin-left: 125px;
    height: 28px;
    line-height: 14px;
    border: 0;
    width: 120px;    
    background-color: rgba(56, 106, 138, 1);
    color: white;
    text-decoration: none;    
    font-family: 'Sakkal Majalla';   
    background-position-y: 5px;
    background-position-x: 5px;
    background-repeat: no-repeat;
    cursor: pointer;
    font-weight:600;
    font-size:15px;
    border-radius:5px 5px 0 0;
}

  
        


         .btnSearch1{ 
    margin-top: -10px;
    position: absolute;
    margin-left: -125px;
    height: 28px;
    line-height: 14px;
    border: 0;
    width: 120px;    
    background-color: rgba(56, 106, 138, 1);
    color: white;
    text-decoration: none;    
    font-family: 'Sakkal Majalla';   
    background-position-y: 5px;
    background-position-x: 5px;
    background-repeat: no-repeat;
    cursor: pointer;
    font-weight:600;
    font-size:15px;
    border-radius:5px 5px 0 0;
}

.btnDispatchAllApprove {
    left:14%;
    margin-top: -20px;
    position: absolute;
    margin-left: 320px;
    height: 18px;
    line-height: 14px;
    border: 0;
    width: 70px;
    /*height: 27px;*/
    /*border-radius: 21px;*/
    /*background-color: rgba(56, 106, 138, 1);*/
    background-color:red;
    color: white;
    text-decoration: none;
    /*text-align: right;*/
    font-family: 'Sakkal Majalla';
    /*background-image: url(../Images/open.png);*/
    background-position-y: 5px;
    background-position-x: 5px;
    background-repeat: no-repeat;
    cursor: pointer;
}

.btnDispatchAllReject {
    margin-top: -20px;
    position: absolute;
    margin-left: 440px;
    height: 18px;
    line-height: 14px;
    border: 0;
    width: 70px;
    /*height: 27px;*/
    /*border-radius: 21px;*/
    background-color: rgba(56, 106, 138, 1); /*rgba(44, 85, 116, 1);*/
    color: white;
    text-decoration: none;
    /*text-align: right;*/
    font-family: 'Sakkal Majalla';
    /*background-image: url(../Images/open.png);*/
    background-position-y: 5px;
    background-position-x: 5px;
    background-repeat: no-repeat;
    cursor: pointer;
}
         .box_shadow {
    -webkit-box-shadow: 0px 0px 5px 0px rgba(0,110,24,1) !important;
    -moz-box-shadow: 0px 0px 5px 0px rgba(0,110,24,1) !important;
    box-shadow: 0px 0px 5px 0px rgba(0,110,24,1)!important;
    border-radius:5px;
}
        .btn-radius {
             border-radius:5px 5px 0 0;
        }

    </style>
    
    <script>

        $(document).ready(function () {
          
            oboutGrid.prototype.selectRecordByClick = function () {
                return;
            }
            oboutGrid.prototype.showSelectionArea = function () {
                return;
            }
        });
      
        function SelectDeselect(oCheckbox) {

            var oElement = oCheckbox.parentNode;
            while (oElement != null && oElement.nodeName != "TR") {
                oElement = oElement.parentNode;
            }
            var vrselectedvalue = document.getElementById("Contentbody_hdnslectedvalue").value;
            if (oElement != null) {

                // oElement represents the row where the clicked      
                // checkbox reside
                var oContainer = oElement.parentNode;
                var iRecordIndex = -1;
                for (var i = 0; i < oContainer.childNodes.length; i++) {
                    if (oContainer.childNodes[i] == oElement) {
                        iRecordIndex = i;
                        break;
                    }
                }

                if (iRecordIndex != -1) {

                    if (oCheckbox.checked == true) {
                        // select the record
                        grdMembersList.selectRecord(iRecordIndex);
                        if (vrselectedvalue == "") {
                            vrselectedvalue = oCheckbox.name + ",";
                        }
                        else {
                            vrselectedvalue = vrselectedvalue + oCheckbox.name + ",";
                        }
                        document.getElementById("Contentbody_hdnslectedvalue").value = vrselectedvalue;
                        //alert(document.getElementById("Contentbody_hdnslectedvalue").value);
                    }
                    else {
                        // deselect the record
                        grdMembersList.deselectRecord(iRecordIndex);
                        vrselectedvalue = vrselectedvalue.replace(oCheckbox.name + ",", '');
                        document.getElementById("Contentbody_hdnslectedvalue").value = vrselectedvalue;
                       // alert(document.getElementById("Contentbody_hdnslectedvalue").value);
                    }
                }
            }
        }

        function stopEventPropagation(e) {
            if (!e) { e = window.event; }
            if (!e) { return false; }
            e.cancelBubble = true;
            if (e.stopPropagation) { e.stopPropagation(); }
        }

        function assignEventsToCheckboxes() {

            document.getElementById('ChkSelector').checked = false;

            // disable the record selection feature by clicking on the records
            var sRecordsIds = grdMembersList.getRecordsIds();
            var arrRecordsIds = sRecordsIds.split(",");
            for (var i = 0; i < arrRecordsIds.length; i++) {

                var oRecord = document.getElementById(arrRecordsIds[i]);
                if (oRecord) {
                    oRecord.onmousedown = function (e) { stopEventPropagation(e); };
                    oRecord.onclick = function (e) { stopEventPropagation(e); };
                }
            }

            // populate the previously checked checkboxes
            var arrPageSelectedRecords = grdMembersList.PageSelectedRecords;
            for (var i = 0; i < arrPageSelectedRecords.length; i++) {

                var oCheckbox = document.getElementById("chk_grid_" + arrPageSelectedRecords[i].applno);
                if (oCheckbox) {
                    oCheckbox.checked = true;
                }
            }

            // enable the record selection feature by selecting the checkboxes
            var arrCheckboxes = document.getElementsByTagName("INPUT");
            for (var i = 0; i < arrCheckboxes.length; i++) {

                if (arrCheckboxes[i].type == "checkbox" && (arrCheckboxes[i].id.indexOf("chk_grid_") == 0 || arrCheckboxes[i].id.indexOf("ChkGroupSelector_") == 0)) {
                    arrCheckboxes[i].onmousedown = function (e) { stopEventPropagation(e); };
                    if (arrCheckboxes[i].id.indexOf("chk_grid_") == 0) {
                        arrCheckboxes[i].onclick = function (e) { SelectDeselect(this); stopEventPropagation(e); manageMasterState(); };
                    } else {
                        arrCheckboxes[i].onclick = function (e) { toggleGroupSelection(this); stopEventPropagation(e); };
                    }
                }
            }

            manageMasterState();
        }

        function toggleSelection(checkbox) {

            var arrCheckboxes = document.getElementsByTagName("INPUT");
            for (var i = 0; i < arrCheckboxes.length; i++) {

                if (arrCheckboxes[i].type == "checkbox" && (arrCheckboxes[i].id.indexOf("chk_grid_") == 0 || arrCheckboxes[i].id.indexOf("ChkGroupSelector_") == 0)) {
                    if (arrCheckboxes[i].checked != checkbox.checked) {
                        arrCheckboxes[i].checked = checkbox.checked;
                        if (arrCheckboxes[i].id.indexOf("chk_grid_") == 0) {
                            SelectDeselect(arrCheckboxes[i]);
                        } else {
                            toggleGroupSelection(arrCheckboxes[i]);
                        }
                    }
                }
            }
        }

        function toggleGroupSelection(groupCheckBox) {
            debugger;
            var element = groupCheckBox.parentNode;
            while (element != null && element.nodeName != "TR") {

                element = element.parentNode;
            }

            var index = 0;
            while (element.previousSibling != null) {

                index++;
                element = element.previousSibling;
            }

            var applseq = 0;
            for (var i = index + 1; i < grdMembersList.Rows.length; i++) {

                if (grdMembersList.Rows[i] && grdMembersList.Rows[i].Cells) {
                    applseq = grdMembersList.Rows[i].Cells['regNo'].Value;
                    index = i;
                    break;
                }
            }

            for (var i = index; i < grdMembersList.Rows.length; i++) {

                
                if (grdMembersList.Rows[i] != null) {
                    applseq = grdMembersList.Rows[i].Cells['regNo'].Value;
                }
                //-------------------
                if (grdMembersList.Rows[i] == null || grdMembersList.Rows[i].Cells['regNo'].Value != applseq) {
                    break;
                }

                var checkBox = document.getElementById('chk_grid_' + grdMembersList.Rows[i].Cells['regNo'].Value)

                if (checkBox.checked != groupCheckBox.checked) {
                    checkBox.checked = groupCheckBox.checked;
                    SelectDeselect(checkBox);
                }
            }
        }

        function manageMasterState() {

            var newState = true;

            var groupCheckBox = null;
            var groupState = true;

            var arrCheckboxes = document.getElementsByTagName("INPUT");
            for (var i = 0; i < arrCheckboxes.length; i++) {
                if (arrCheckboxes[i].type == "checkbox") {
                    if (arrCheckboxes[i].id.indexOf("chk_grid_") == 0) {
                        if (arrCheckboxes[i].checked == false) {
                            newState = false;
                            groupState = false;
                            break;
                        }
                    } else if (arrCheckboxes[i].id.indexOf("ChkGroupSelector_") == 0) {
                        if (groupCheckBox != null) {
                            groupCheckBox.checked = groupState;
                            groupState = true;
                        }
                        groupCheckBox = arrCheckboxes[i];
                    }
                }
            }

            if (groupCheckBox != null) {
                groupCheckBox.checked = groupState;
                groupState = true;
            }

            document.getElementById('ChkSelector').checked = newState;
        }
 
        function validateselectedrecord()
        {
            var vrseelct = document.getElementById("Contentbody_hdnslectedvalue").value;
            if (vrseelct =="")
            {
                alert("ஏதாவது ஒரு உறுப்பினரை தேர்ந்தெடுக்கவும்.");
                return false;
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contentbody" Runat="Server">
     
    <iframe id="ifrm_dcbform" runat="server" visible="false" name="I5" scrolling="yes" style="height:300px; width:360px" src="~/File/print.pdf" ></iframe>

    <div class="form-row">
        <div class="col-sm-2">
            <asp:Button ID="btnNewMemberslist" runat="server"  Text="New Members" CssClass="btn-radius btn btn-success btn-sm" OnClick="btnNewMember_Click"  Visible="true"/>
            <asp:Button ID="btnPrintedMemberslist" runat="server" Text="Printed Members" CssClass="btn-radius btn btn-success btn-sm" OnClick="btnPrintedmembers_Click"  Visible="true"/>
            <%-- <asp:Button ID="btnUserCreation" runat="server" Width="120px" Text="Create User" CssClass="btnDispatchAllN1  btn btn-success" OnClick="btnNewUser_Click"  Visible="false"/>--%>
        </div>
        <div class="col-sm-10">
            <div class="float-right" style="padding-right:10px;">
            <asp:TextBox ID="txtSearch"  Width ="150px" CssClass="box_shadow"  runat="server"></asp:TextBox>  
                <i class="bi bi-search"></i>
            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="btn btn-primary btn-sm"  Visible="true" />
            </div>
        </div>     
    </div>

 
    <div class="griddiv"> 
          
       <%-- <asp:Button ID="btnExpretdet" runat="server" Width="90px" Text="Export To Excel" CssClass="btnDispatchAll" OnClick="btnExpretdet_Click"  Visible="false"/>--%>
       
        <asp:HiddenField runat="server" ID="hdnslectedvalue"/>

        
         <obout:Grid ID="grdMembersList" runat="server" FolderStyle="CSSStyles/OboutGrid/styles/style_5" CallbackMode="false" Serialize="true" AllowColumnResizing="true" AllowRecordSelection="true"
                            AllowGrouping="true" ShowGroupsInfo="false" AutoGenerateColumns="false" Height="99%" Width="100%" AllowAddingRecords="false" PageSize="100" AllowFiltering="true"
                            FolderExports="Reportdocs/exports" OnRowDataBound="grdMembersList_RowDataBound" >
                           <ClientSideEvents OnClientCallback="assignEventsToCheckboxes"/>
                            <Columns>
                               
                                 <obout:Column HeaderText="Select" runat="server" Width="50">
		            <TemplateSettings TemplateID="CheckTemplate"  HeaderTemplateId="HeaderTemplate" />
	            </obout:Column>
                                 <%--<obout:Column DataField="" ReadOnly="true" HeaderText="S.N0" Width="50" runat="server">
                                    <TemplateSettings TemplateId="tplNumbering" />
                                </obout:Column>--%>                               
                                <obout:Column DataField="regNo" AllowFilter="false" HeaderText="regNo" Width="5%" runat="server" Visible="false" />                                 
                                <obout:Column DataField="regName" AllowFilter="false" HeaderText="Name" Width="25%" runat="server"  />
                                <obout:Column DataField="regGender" AllowFilter="false" HeaderText="Gender" Width="5%" runat="server"  />
                                <obout:Column DataField="regMobileNo" AllowFilter="true" HeaderText="Mobile No" Width="10%" Wrap="true" runat="server" AllowGroupBy="true" ShowFilterCriterias="false" />
                                <obout:Column DataField="regwhatsapp" AllowFilter="true" HeaderText="Whatsapp No" Width="10%" Wrap="true" runat="server" AllowGroupBy="true" ShowFilterCriterias="false" />
                                <obout:Column DataField="regDistrict" AllowFilter="true" HeaderText="District" Width="10%" runat="server" Wrap="true" AllowGroupBy="true" ShowFilterCriterias="false" />   
                                 <obout:Column DataField="regAddress" AllowFilter="false" HeaderText="Address" Width="25%" runat="server" Wrap="true"  />   
                                  <obout:Column DataField="regBlood" AllowFilter="false" HeaderText="Blood Group" Width="5%" runat="server" Wrap="true"  />                                                                                                                       
                             <%--   <obout:Column DataField="regTeam" AllowFilter="true" HeaderText="Wings" Width="10%" runat="server" Wrap="true" AllowGroupBy="true"  />--%>
                                 <obout:Column DataField="regprint" AllowFilter="false" HeaderText="Printed" Width="10%" runat="server"  />
                                <obout:Column runat="server" Width="7%" DataField="" AllowEdit="true">
                                        <TemplateSettings TemplateId="editBtnTemplate" EditTemplateId="updateBtnTemplate" />
                                </obout:Column>
                                 <obout:Column runat="server" Width="7%" DataField="" AllowEdit="true">
                                        <TemplateSettings TemplateId="printBtnTemplate" EditTemplateId="printBtnTemplate" />
                                </obout:Column>
                            </Columns>
                            <TemplateSettings GroupHeaderTemplateId="GroupTemplate" />
                            <Templates>
                                 <obout:GridTemplate runat="server" ID="HeaderTemplate">
		            <Template>
			            <input type="checkbox" onclick="toggleSelection(this)" id="ChkSelector" />
		            </Template>
	            </obout:GridTemplate>
                                  <obout:GridTemplate runat="server" ID="CheckTemplate">
	                <Template>                        
	                    <input type="checkbox" id="chk_grid_<%# Container.DataItem["regNo"] %>" name="<%# Container.DataItem["regNo"] %>" onclick="SelectDeselect(this) " />
                    </Template>
                </obout:GridTemplate>
                                <obout:GridTemplate runat="server" ID="GridTemplate1">
                                    <Template>
                                        <b><%# Container.Value %> : (<%# Container.Group.PageRecordsCount %>/ <%# Container.Group.TotalRecordsCount %>)</b>
                                    </Template>
                                </obout:GridTemplate>
                               <%-- <obout:GridTemplate runat="server" ID="tplNumbering">
                                    <Template>
                                        <b><%# (Container.DataRecordIndex + 1) %>.</b>
                                    </Template>
                                </obout:GridTemplate>--%>
                                 <obout:GridTemplate runat="server" ID="editBtnTemplate">
                        <Template>
                              <asp:Button runat="server" ID="btnOpen" Class="btnShaOpen" ToolTip="Edit" Text="EDIT" OnClick="btnEdit_Click" CommandName="Edit" CommandArgument="<%# Container.PageDataRecordIndex %>" />
                        </Template>
                    </obout:GridTemplate>
                                  <obout:GridTemplate runat="server" ID="printBtnTemplate">
                        <Template>
                               <asp:Button runat="server" ID="btnprint" Class="btnShaprint" Text="PRINT" ToolTip="Card Print" OnClick="btnPrint_Click" CommandName="Print" CommandArgument="<%# Container.PageDataRecordIndex %>" />
                        </Template>
                    </obout:GridTemplate>
                            </Templates>
                        </obout:Grid>
        
    </div>
    <br />

     <div class="row">
        <div class="col-md-12">
            <%--<asp:Button runat="server" ID="btndownload" Visible="true" OnClientClick="return validateselectedrecord();" OnClick="ExportToPDF" CssClass="btn btn-info"  Width="100" Text ="Download" />--%>
        &nbsp;&nbsp;<asp:Button runat="server" ID="btnDelete" OnClientClick="return validateselectedrecord();" CssClass="btn btn-danger" OnClick="btnDelete_Click"  Width="100"  Text ="Delete" />
        </div>

         <div class="col-sm-10">
            <div class="float-right" style="padding-right:10px;">
            <asp:Label ID="lblCount"  Width ="150px" runat="server"></asp:Label>
                
            </div>
        </div> 
    </div>



     <%--<script type="text/javascript">
         document.getElementsByClassName("ob_gGADC").innerHTML = "";
        </script>--%>
</asp:Content>