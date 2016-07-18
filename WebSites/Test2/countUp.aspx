<%@ Page Language="C#" AutoEventWireup="true" CodeFile="countUp.aspx.cs" Inherits="countUp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >

   <head runat="server">
      <title>
         Untitled Page
      </title>
   </head>
   
   <body>
      <form id="form1" runat="server">
      
         <div>
            <h3>View State demo</h3>
         
            Page Counter:
            
            <asp:Label ID="lblCounter" runat="server" />
            <asp:Button ID="btnIncrement" runat="server" Text="Add Count" onClick="btnIncrement_Click" />
         </div>
         
      </form>
   </body>
   
</html>