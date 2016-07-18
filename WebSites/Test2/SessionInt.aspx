<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SessionInt.aspx.cs" Inherits="SessionInt" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table>

            <tr>
                <td><asp:Label ID="nameLabel" runat="server" Text=" Type your name : " style="width:100px"></asp:Label></td>
                <td><asp:TextBox ID="name" runat="server"  style="width:150px"/></td>
            </tr>
            <tr>
                <td><asp:Label ID="surnameLabel" runat="server" Text=" Type your surname : " style="width:100px"></asp:Label></td>
                <td><asp:TextBox ID="surname" runat="server" style="width:150px" /></td>
            
            </tr>
            <tr>
                <td> &nbsp </td>
                <td><asp:Button ID="submit" runat ="server" Text="Submit" OnClick="sessionButton" style="width:60px"/> </td>
            </tr>
          
        </table>
    </div>
    </form>
    <div>
        <h3>&nbsp &nbsp &nbsp Output</h3>

        <table>
            <tr>
                <td style="width: 40px"></td>
                <td> Label Session  </td>
                <td><asp:Label ID="LabelsSession" runat="server" ></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 40px"></td>
                <td> Label History  </td>
                <td><asp:Label ID="LabelHistory" runat="server" ></asp:Label></td>
            </tr>
        </table>
    </div>
</body>
</html>
