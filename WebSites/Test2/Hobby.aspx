<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Hobby.aspx.cs" Inherits="Hobby" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">

      <h3> DropDownList Example </h3>

      Select a background color for days in the calendar.

      <br /><br /> 
      <asp:Calendar id="Calendar1"
           ShowGridLines="True" 
           ShowTitle="True"
           runat="server"/>
      <br /><br />
      <table >

         <tr>

            <td>

               Background color:

            </td>

         </tr>

         <tr>

            <td>

               <asp:DropDownList id="ColorList" AutoPostBack="True" OnSelectedIndexChanged="Selection_Change" runat="server">

                  <asp:ListItem Selected="True" Value="White"> White </asp:ListItem>
                  <asp:ListItem Value="Silver"> Silver </asp:ListItem>
                  <asp:ListItem Value="DarkGray"> Dark Gray </asp:ListItem>
                  <asp:ListItem Value="Khaki"> Khaki </asp:ListItem>
                  <asp:ListItem Value="DarkKhaki"> Dark Khaki </asp:ListItem>

               </asp:DropDownList>

            </td>

         </tr>

      </table>

   </form>

</body>
</html>
