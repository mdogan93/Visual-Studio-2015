<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Repeater.aspx.cs" Inherits="Repeater" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" >
 <head>
    <title>Repeater Example</title>
 </head>
 <body>

    <h3>Repeater Example</h3>

    <form id="form1" runat="server">

       <b>Repeater1:</b>

       <br />

       <asp:Repeater id="Repeater1" OnItemCommand="R1_ItemCommand" runat="server">
          <HeaderTemplate>
             <table border="1">
                <tr>
                   <td><b>Company</b></td>
                   <td><b>Symbol</b></td>
                </tr>
          </HeaderTemplate>

          <ItemTemplate>
             <tr>
                <td> <%# DataBinder.Eval(Container.DataItem, "Name") %> </td>
                <td> <ASP:Button Text=<%# DataBinder.Eval(Container.DataItem, "Ticker") %> runat="server" /></td>
             </tr>
          </ItemTemplate>

          <FooterTemplate>
             </table>
          </FooterTemplate>

       </asp:Repeater>
       <br />

       <asp:Label id="Label2" font-names="Verdana" ForeColor="Green" font-size="10pt" runat="server"/>
    </form>
 </body>
 </html>
