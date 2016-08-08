<%@ Page Language="C#" AutoEventWireup="true" CodeFile="registration.aspx.cs" Inherits="registration" EnableViewState="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Last but not most step</title>
    <link rel="stylesheet" href="Scss/registration.css" />
</head>
<body>

    <form id="form1" runat="server">
        <div class="regForm">
            <h2>Sahibinden Kayıt</h2>
            <!--Registration Form Starts here -->

            <div class="left-regForm">
                <!--  Username Starts Here  -->
                <div class="segment">
                    <div class="segment-label">
                        <asp:Label runat="server" Text="Kullanıcı adı "></asp:Label>
                    </div>
                    <div class="segment-value">
                        <asp:TextBox ID="username" runat="server"> </asp:TextBox>
                    </div>
                    <span></span>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="username" Display="None"
                        ErrorMessage="Please provide your username">
                    </asp:RequiredFieldValidator>
                </div>
                <!--  Username Ends Here  -->

                <!--  Password Starts Here -->
                <div class="segment">
                    <div class="segment-label">

                        <asp:Label runat="server" Text="Şifre "></asp:Label>
                    </div>
                    <div class="segment-value">
                        <asp:TextBox TextMode="Password" Display="None" MaxLength="16" ID="password" runat="server"> </asp:TextBox>
                    </div>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="password" Display="None"
                        ErrorMessage="Please provide your password">
                    </asp:RequiredFieldValidator>
                </div>
                <!-- Password Ends Here  -->

                <!-- E-mail Starts Here  -->
                <div class="segment">
                    <div class="segment-label">
                        <asp:Label runat="server" Text="E-mail "></asp:Label>
                    </div>
                    <div class="segment-value">
                        <asp:TextBox ID="email" runat="server"> </asp:TextBox>
                    </div>
                    <asp:RegularExpressionValidator runat="server" ControlToValidate="email" ToolTip="Required" ErrorMessage="Enter a valid email address"
                        ValidationExpression="^[a-z0-9](\.?[a-z0-9_-]){0,}@[a-z0-9-]+\.([a-z]{1,6}\.)?[a-z]{2,6}$" Display="None">
                    </asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator runat="server" ToolTip="Required" ErrorMessage="Provide an e-mail address"
                        ControlToValidate="email" Display="None"></asp:RequiredFieldValidator>
                </div>
                <!-- E-mail Ends Here  -->

                <!-- Phone Starts Here   -->
                <div class="segment">
                    <div class="segment-label">
                        <asp:Label runat="server" Text="Telefon"></asp:Label>
                    </div>
                    <div class="segment-value">
                        <asp:TextBox ID="phone" runat="server"> </asp:TextBox>                       
                    </div>
                </div>
                <!-- Phone Ends Here -->
            </div>
            <!-- Left-regForm Ends Here-->


            <div class="right-regForm">

                <!-- Name Starts Here -->
                <div class="segment">
                    <div class="segment-label">
                        <asp:Label runat="server" Text="İsim "></asp:Label>
                    </div>
                    <div class="segment-value">
                        <asp:TextBox ID="name" runat="server"> </asp:TextBox>
                    </div>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="name" Display="None"
                        ErrorMessage="Please provide your name">
                    </asp:RequiredFieldValidator>
                </div>
                <!-- Name Ends Here -->

                <!-- SurName Starts Here  -->
                <div class="segment">
                    <div class="segment-label">
                        <asp:Label runat="server" Text="Soyisim "></asp:Label>
                    </div>
                    <div class="segment-value">
                        <asp:TextBox ID="surname" runat="server"> </asp:TextBox>
                    </div>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="surname" Display="None"
                        ErrorMessage="Please provide your surname">
                    </asp:RequiredFieldValidator>
                </div>
                <!-- SurName Ends Here  -->

                <!-- Gender Starts Here -->
                <div class="segment">
                    <div class="segment-label">
                        <asp:Label runat="server" Text="Cinsiyet "></asp:Label>
                    </div>
                    <div class="segment-value">
                        <asp:RadioButtonList CssClass="radioButtonList" ID="gender" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Value="1">Erkek</asp:ListItem>
                            <asp:ListItem Value="2">Kadın</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="gender"
                        ErrorMessage="Please choose your gender" Display="None">
                    </asp:RequiredFieldValidator>

                </div>
                <!-- SurName Ends Here  -->

                <!-- Education Starts Here-->
                <div class="segment">
                    <div class="segment-label">
                        <asp:Label runat="server" Text="Eğitim Durumu" ></asp:Label>
                    </div>
                    <div class="segment-value">
                        <asp:DropDownList ID="Education"  runat="server" AutoPostBack="true" OnSelectedIndexChanged="Education_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                    <asp:RequiredFieldValidator ID="checkCity"
                        runat="server" ControlToValidate="Education"
                        ErrorMessage="Please choose your Education" Display="None">
                    </asp:RequiredFieldValidator>
                </div>
                <!-- Education Ends Here-->

                <!-- Favorite Team Starts Here-->
                <div class="segment">
                    <div class="segment-label">
                        <asp:Label runat="server" Text="Meslek"></asp:Label>

                    </div>
                    <div class="segment-value">
                        <asp:DropDownList ID="Job" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Job_SelectedIndexChanged">
                            <asp:ListItem Value="0">Seçiniz</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                        runat="server" ControlToValidate="Job"
                        ErrorMessage="Please choose your Job" Display="None">
                    </asp:RequiredFieldValidator>
                </div>
                <!-- Favorite Team Ends Here-->

                <!-- Birthday Starts Here-->
                <div class="segment">
                    <div class="segment-label">
                        <asp:Label runat="server" Text="Doğum Günü "></asp:Label>
                    </div>
                    <div class="segment-value">
                        <asp:DropDownList ID="dateDay" runat="server" AutoPostBack="True"></asp:DropDownList>
                        <asp:DropDownList ID="dateMonth" runat="server">
                            <asp:ListItem Value="00">-Ay-</asp:ListItem>
                            <asp:ListItem Value="01">Ocak</asp:ListItem>
                            <asp:ListItem Value="02">Şubat</asp:ListItem>
                            <asp:ListItem Value="03">Mart</asp:ListItem>
                            <asp:ListItem Value="04">Nisan</asp:ListItem>
                            <asp:ListItem Value="05">Mayıs</asp:ListItem>
                            <asp:ListItem Value="06">Haziran</asp:ListItem>
                            <asp:ListItem Value="07">Temmuz</asp:ListItem>
                            <asp:ListItem Value="08">Ağustos</asp:ListItem>
                            <asp:ListItem Value="09">Eylül</asp:ListItem>
                            <asp:ListItem Value="10">Ekim</asp:ListItem>
                            <asp:ListItem Value="11">Kasım</asp:ListItem>
                            <asp:ListItem Value="12">Aralık</asp:ListItem>
                        </asp:DropDownList>
                        <asp:DropDownList ID="dateYear" runat="server" AutoPostBack="True"></asp:DropDownList>
                    </div>

                </div>
                <!-- Birthday Ends Here-->

                <div class="segment">
                    <div class="segment-label">
                        <asp:Label ID="Label1" runat="server" />
                    </div>
                    <div class="segment-value">
                        <asp:Button Text="Submit" OnClick="submitInfo" runat="server" />
                    </div>
                </div>
            </div>
            <!-- Right Panel Ends Here-->
        </div>
        <!-- Reg Form Ends Here -->
        <div class="left-regForm clear-left">
            <table >
                <tr>
                    <td>
                        <asp:ValidationSummary
                            ID="valSum"
                            DisplayMode="BulletList"
                            runat="server"
                            HeaderText="Your Errors in order"
                            Font-Names="verdana"
                            Font-Size="12"
                            ShowMessageBox="true"
                            ShowSummary="false" />
                    </td>
                </tr>
            </table>
        </div>
        <asp:Label runat="server" ID="debug"></asp:Label>
    </form>


</body>
</html>
