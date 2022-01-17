<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="CreateUser.aspx.cs" Inherits="CreateUser" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .trclass
        {
         
        }
        tbody, tfoot, thead, tr, th, td {
             padding: 1em !important;
            
        }
        .ddlselect
        {
            width:100%;
        }
        .btnsave {
    width: 100%;
    background-color: royalblue;
}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contentbody" Runat="Server">
    <!DOCTYPE html>

    <html xmlns="http://www.w3.org/1999/xhtml">

    <body class="pagedefaults">

        <asp:ScriptManager ID="asm1" runat="server">
        </asp:ScriptManager>       
        <div class="subsidemenureddiv">  
            <h4 id="pid" runat="server" ></h4>
           <table style="margin-top: 10px; margin-left: 10px; font-family: 'Sakkal Majalla'; font-size: 18px;" id="tblheader1">
                 <tr>
                   <td>
                       <asp:Label runat="server" ID="lblEntity">Wings</asp:Label>
                   </td>
                   <td>
                       <asp:DropDownList runat="server" ID="ddldir" AutoPostBack="true" CssClass="ddlselect" AppendDataBoundItems="true">
                           <asp:ListItem Text="IUML" Value="IUML"></asp:ListItem>
                            <asp:ListItem Text="MYL" Value="MYL"></asp:ListItem>
                            <asp:ListItem Text="MSF" Value="MSF"></asp:ListItem>
                            <asp:ListItem Text="ITWING" Value="ITWING"></asp:ListItem>
                           <asp:ListItem Text="WL" Value="WL"></asp:ListItem>
                            <asp:ListItem Text="Admin" Value="Admin"></asp:ListItem>
                       </asp:DropDownList>
                   </td>
                    <td>
                       <span></span>
                   </td>
               </tr>
               <tr >
                   <td>
                       <asp:Label runat="server" ID="lblUsername">Username:</asp:Label>
                   </td>
                   <td>
                       <asp:TextBox runat="server" ID="txtUserName" OnTextChanged="txtUserName_TextChanged" AutoPostBack="true" ValidationGroup="saveuser"></asp:TextBox>
                       <asp:RequiredFieldValidator ID="fv1" runat="server" ErrorMessage="<b>Username is required</b>" ControlToValidate="txtUserName" ForeColor="Red" ValidationGroup="saveuser" Display="None" SetFocusOnError="true"></asp:RequiredFieldValidator>
                       <ajaxToolkit:ValidatorCalloutExtender ID="exfv1" runat="server" TargetControlID="fv1"></ajaxToolkit:ValidatorCalloutExtender>
                   </td>
                   <td>
                       <%--<asp:CheckBox runat="server" Text="Enable" ID="chkEnabled" />--%>
                       <span></span>
                   </td>
               </tr>
               <tr >
                   <td>
                       <asp:Label runat="server" ID="lblPwd">Password:</asp:Label>
                   </td>
                   <td>
                       <asp:TextBox runat="server" ID="txtPwd" TextMode="Password" ValidationGroup="saveuser"></asp:TextBox>
                       <asp:RequiredFieldValidator ID="fv2" runat="server" ErrorMessage="<b>password is required</b>" ControlToValidate="txtPwd" ForeColor="Red" ValidationGroup="saveuser" Display="None" SetFocusOnError="true"></asp:RequiredFieldValidator>
                      <%-- <ajaxToolkit:ValidatorCalloutExtender ID="exfv2" runat="server" TargetControlID="fv2"></ajaxToolkit:ValidatorCalloutExtender>--%>
                   </td>
                   <td>
                       <span></span>
                   </td>
               </tr>
               <%--<tr >
                   <td>
                       <asp:Label runat="server" ID="lblConfirmPwd">Confirm Password</asp:Label>
                   </td>
                   <td>
                       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:TextBox runat="server" ID="txtConfirmPwd" TextMode="Password"></asp:TextBox>
                       <asp:RequiredFieldValidator ID="fv4" runat="server" ErrorMessage="<b>confirm password is required</b>" ControlToValidate="txtConfirmPwd" ForeColor="Red" ValidationGroup="saveuser" Display="None" SetFocusOnError="true"></asp:RequiredFieldValidator>
                       <ajaxToolkit:ValidatorCalloutExtender ID="exfv4" runat="server" TargetControlID="fv4"></ajaxToolkit:ValidatorCalloutExtender>
                       <asp:CompareValidator ID="CompareValidator1" runat="server"
                           ControlToValidate="txtConfirmPwd"
                           CssClass="ValidationError"
                           ControlToCompare="txtPwd"
                           ErrorMessage="Passpord mismatch"
                           ToolTip="Password must be the same" />
                   </td>
                     <td>
                       <%--<asp:CheckBox runat="server" Text="Enable" Visible="false" ID="CheckBox12" />--%>
                        <%--  <span></span>
                   </td>
               </tr>--%>
                          
             
              <%-- <tr>
                   <td>
                       <asp:Label runat="server" ID="lbldpts">Department</asp:Label>
                   </td>
                   <td>
                       <asp:DropDownList runat="server" ID="ddldpts" CssClass="ddlselect" AutoPostBack="true">
                           <asp:ListItem></asp:ListItem>
                       </asp:DropDownList>
                   </td>
               </tr> --%>             
               <tr>
                   <td>
                       <asp:Button runat="server" Text="Save" ID="btnSave" OnClick="btnSave_Click" CssClass="btnsave" ValidationGroup="saveuser"/>
                   </td>
                   <td>
                       <asp:Button runat="server" Text="Cancel" ID="btncancel" OnClick="btncancel_Click" CssClass="btnsave" />
                   </td>
                    <td>
                       <span></span>
                   </td>

               </tr>
           </table>
        </div>
    </body>
    </html>
</asp:Content>

