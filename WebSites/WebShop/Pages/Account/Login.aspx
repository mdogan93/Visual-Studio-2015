<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Pages_Account_Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p>
        <asp:Literal ID="litStatus" runat="server"></asp:Literal>
    </p>
    <p>
        Username</p>
    <p>
        <asp:TextBox ID="txtUserName" runat="server" CssClass="inputs"></asp:TextBox>
    </p>
    <p>
        Password</p>
    <p>
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="inputs"></asp:TextBox>
    </p>
     <p>
        <asp:Button ID="Button1" runat="server" CssClass="button" Text="Submit" OnClick="Button1_Click"/>
    </p>
</asp:Content>

