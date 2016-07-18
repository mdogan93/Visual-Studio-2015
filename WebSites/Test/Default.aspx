<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
<form id="form1" runat="server">
    <div>
      TextBox
      <asp:TextBox ID="TextBox1" ValidationGroup="Group1" runat="server"></asp:TextBox>
      <asp:RequiredFieldValidator Display="Static" ID="TextBoxValidator1" ValidationGroup="Group1" runat="server" ControlToValidate="TextBox1" ErrorMessage="(please enter some text)" EnableClientScript="False"></asp:RequiredFieldValidator>
      <br />
      <br />
      <br />


      CheckBox
      <asp:CheckBox ID="CheckBox1" ValidationGroup="Group2" runat="server" />
      <asp:CustomValidator ID="CustomValidator" ValidationGroup="Group2" runat="server" Text="(this option required)" OnServerValidate="CustomValidator_ServerValidate" EnableClientScript="False"></asp:CustomValidator>
      <br />
      <asp:Button ID="Button1" ValidationGroup="Group1" CausesValidation="true" runat="server" Text="Validate Group1 Controls" OnClick="Button_Click" />
      <asp:Label ID="Label1" runat="server"></asp:Label>
      <br />
      <asp:Button ID="Button2" ValidationGroup="Group2" CausesValidation="false" runat="server" Text="Validate Group2 Controls" OnClick="Button_Click" />
      <asp:Label ID="Label2" runat="server"></asp:Label>
      <br />
      <br />
      AutoPostBack TextBox
      <asp:TextBox AutoPostBack="true" ID="TextBox2" ValidationGroup="Group3" runat="server" CausesValidation="true"></asp:TextBox>
      <asp:RequiredFieldValidator ID="TextBoxValidator2" ValidationGroup="Group3" runat="server" ControlToValidate="TextBox2" ErrorMessage="(please enter some text)" EnableClientScript="False"></asp:RequiredFieldValidator>
      <asp:Label ID="Label3" runat="server"></asp:Label>
      <br />
      <br />
      <asp:Button ID="Button3" CausesValidation="true" runat="server" Text="Validate All Controls" OnClick="Button3_Click" />
      <asp:Label ID="Label4" runat="server"></asp:Label>
    
    </div>
    </form>
</body>
</html>
