<%@ Page Language="C#" AutoEventWireup="true" CodeFile="errorCheck.aspx.cs" Inherits="errorCheck"  Trace ="false"%>
<%@ OutputCache Duration="25" VaryByParam="None" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
     <form id="form1" runat="server">
      
         <div>
            <asp:Label ID="lblheading" runat="server" Text="Tracing, Debuggin  and Error Handling">
            </asp:Label>
            
            <br /> <br />
            
            <asp:DropDownList ID="ddlquotes" runat="server" AutoPostBack="True"  onselectedindexchanged="ddlquotes_SelectedIndexChanged">
            </asp:DropDownList>
            
            <br /> <br />
            
            <asp:Label ID="lblquotes" runat="server">
            </asp:Label>
            
            <br /> <br />
            
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="mylink.htm">Link to:</asp:HyperLink>
         </div>
    </form>
</body>
</html>
