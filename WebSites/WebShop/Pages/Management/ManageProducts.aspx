<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ManageProducts.aspx.cs" Inherits="Pages_Management_ManageProducts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <p>
        <asp:Label ID="lblName" runat="server" Text="Label">Product Name:</asp:Label>
    </p>
    <p>
        <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
    </p>
    <p>
        Product Type:</p>
    <p>
        <asp:DropDownList ID="ddlProductType" runat="server" DataSourceID="SqlDataSource1" DataTextField="TypeName" DataValueField="Id">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:PixAdvertConnectionString %>" SelectCommand="SELECT * FROM [WebShop_ProductTypes] ORDER BY [TypeName]"></asp:SqlDataSource>
    </p>
    <p>
        <asp:Label ID="lblPrice" runat="server" Text="Label">Price:</asp:Label>
    </p>
    <p>
        <asp:TextBox ID="txtPrice" runat="server"></asp:TextBox>
    </p>
    <p>
        Image:</p>
    <p>
        <asp:DropDownList ID="ddlProductImage" runat="server">
        </asp:DropDownList>
    </p>
    <p>
        <asp:Label ID="lblDescription" runat="server" Text="Label">Description:</asp:Label>
    </p>
    <p>
        <asp:TextBox ID="txtDescription" runat="server" Height="60px" TextMode="MultiLine" Width="212px"></asp:TextBox>
    </p>
    <p>
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
    </p>
    <p>
        <asp:Label ID="lblResult" runat="server" ></asp:Label>
    </p>

</asp:Content>

