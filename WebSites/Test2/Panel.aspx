<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Panel.aspx.cs" Inherits="Panel" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
<form id="form1" runat="server">
   <div>
      <asp:Panel ID="pnldynamic" runat="server" BorderColor="#990000" 
         BorderStyle="Solid" Height="150px"  ScrollBars="Auto" style="width:60%" BackColor="#CCCCFF"  Font-Names="Courier" HorizontalAlign="Center">
     
         This panel shows dynamic control generation:
         <br />
         <br />
      </asp:Panel>
   </div>

   <table style="width: 51%;">
      <tr>
         <td >No of Labels:</td>
         <td >
            <asp:DropDownList ID="ddllabels" runat="server">
               <asp:ListItem>0</asp:ListItem>
               <asp:ListItem>1</asp:ListItem>
               <asp:ListItem>2</asp:ListItem>
               <asp:ListItem>3</asp:ListItem>
               <asp:ListItem>4</asp:ListItem>
            </asp:DropDownList>
         </td>
      </tr>

      <tr>
         <td > </td>
         <td > </td>
      </tr>

      <tr>
         <td >No of Text Boxes :</td>
         <td >
            <asp:DropDownList ID="ddltextbox" runat="server">
               <asp:ListItem>0</asp:ListItem>
               <asp:ListItem>1</asp:ListItem>
               <asp:ListItem>2</asp:ListItem>
               <asp:ListItem>3</asp:ListItem>
               <asp:ListItem>4</asp:ListItem>
            </asp:DropDownList>
         </td>
      </tr>

      <tr>
         <td > </td>
         <td> </td>
      </tr>

      <tr>
         <td >
            <asp:CheckBox ID="chkvisible" runat="server" 
               Text="Make the Panel Visible" />
         </td>

         <td >
            <asp:Button ID="btnrefresh" runat="server" Text="Refresh Panel" 
               style="width:129px" />
         </td>
      </tr>
   </table>
</form>
</body>
</html>
