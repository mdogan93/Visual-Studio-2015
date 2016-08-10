<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ManageProductTypes.aspx.cs" Inherits="Pages_Management_ManageProductTypes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 
        <p><asp:Label ID="lblName" runat="server" Text="Label">Name:</asp:Label></p>
        <p><asp:TextBox ID="txtName" runat="server"></asp:TextBox></p>
        <p><asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"/></p>
        <p><asp:Label ID="lblResult" runat="server" Text="Result"></asp:Label></p>
</asp:Content>

