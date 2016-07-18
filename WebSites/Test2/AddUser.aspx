<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddUser.aspx.cs" Inherits="AddUser" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
   
    <h2 style="color:blueviolet">New Member Form</h2>
    <form id="form1" runat="server">
    <div>
        <table>
                <!-- Name //Textbox is used -->
            <tr>
                <td style="width:150px"><asp:Label runat="server" Text="Name :"></asp:Label></td>
                <td><asp:TextBox  ID="name" runat="server" style="width:150px"> </asp:TextBox></td>
                <td><asp:RequiredFieldValidator runat="server" ControlToValidate ="name"
                    ErrorMessage="Please provide your name" >
                    </asp:RequiredFieldValidator></td>
            </tr>

                <!-- SurName //Textbox is used  -->
            <tr>
                <td style="width:150px"><asp:Label runat="server" Text="Surname :"></asp:Label></td>
                <td><asp:TextBox  ID="surname" runat="server" style="width:150px"> </asp:TextBox></td>
                <td><asp:RequiredFieldValidator runat="server" ControlToValidate ="surname"
                    ErrorMessage="Please provide your surname" >
                    </asp:RequiredFieldValidator></td>
            </tr>

                <!-- Gender //RadioBox is used -->
            <tr>
                <td style="width:150px"><asp:Label runat="server" Text="Gender :"></asp:Label></td>
                <td><asp:RadioButtonList  ID="gender" runat="server" style="width:150px"> 
                         <asp:ListItem Value="Male">Male</asp:ListItem>
                         <asp:ListItem Value="Female">Female</asp:ListItem>
                     </asp:RadioButtonList></td>
                <td><asp:RequiredFieldValidator runat="server" ControlToValidate ="gender"
                    ErrorMessage="Please choose your gender" >
                    </asp:RequiredFieldValidator></td>
            </tr> 

                <!-- Phone //Textbox is used  -->
            <tr>
                <td style="width:150px">
                     <asp:Label runat="server" Text="Phone :"></asp:Label>
                </td>
                <td>
                     <asp:TextBox  ID="phone" runat="server" style="width:150px"> </asp:TextBox>
                </td>
            </tr>

                <!-- E-mail //Textbox is used  -->
            <tr>
                <td style="width:150px">
                     <asp:Label runat="server" Text="E-mail :"></asp:Label>
                </td>
                <td>
                     <asp:TextBox  ID="email" runat="server" style="width:150px"> </asp:TextBox>
                </td>
                <td><asp:RegularExpressionValidator runat="server" 
                        ControlToValidate="email" ErrorMessage="Enter a valid email address" 
                        ValidationExpression="^[^@\s]+@[^@\s]+$">
                    </asp:RegularExpressionValidator></td>
                <td><asp:RequiredFieldValidator runat="server" ErrorMessage="Provide an e-mail address" 
                    ControlToValidate="email"></asp:RequiredFieldValidator></td>
            </tr>    
          
               <!-- City //Dropdown List is used-->
            <tr>
                <td style="width:150px">
                     <asp:Label runat="server" Text="City :"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList  ID="city" runat="server" style="width:150px"> 
                      
                        <asp:ListItem Value="Ankara" >Ankara</asp:ListItem>
                        <asp:ListItem Value="Antalya" >Antalya</asp:ListItem>
                        <asp:ListItem Value="Bursa" >Bursa</asp:ListItem>
                        <asp:ListItem Value="İstanbul" >İstanbul</asp:ListItem> 
                        <asp:ListItem Value="İzmir" >İzmir</asp:ListItem>

                    </asp:DropDownList>
                                         
                </td>
               <td>
                    <asp:RequiredFieldValidator ID="checkCity" 
                    runat="server" ControlToValidate ="city"
                    ErrorMessage="Please choose your City" >
                    </asp:RequiredFieldValidator>
               </td>
         
            </tr> 
                     
         
             <!-- Hobby //CheckboxList is used  -->
            <tr>
                <td style="width:150px">
                     <asp:Label runat="server" Text="Hobbies :"></asp:Label>
                </td>
                
                <td>
                     <asp:CheckBoxList ID="Hobby" runat="server" >
                         <asp:ListItem Value="Football">Football</asp:ListItem>
                         <asp:ListItem Value="Basketball">Basketball</asp:ListItem>
                         <asp:ListItem Value="Fitness">Fitness</asp:ListItem>
                         <asp:ListItem Value="Snowboard">Snowboard</asp:ListItem>
                     </asp:CheckBoxList>
                </td>
            </tr>
            
            <tr>
                <td style="width:150px"></td>
                <td style="width:150px"><asp:Button ID="submit" Text="Submit" OnClick="submitInfo" runat="server" BorderStyle="Solid" /></td>
            </tr>
            <tr>
                <td style="width:150px"></td>
                <td style="width:150px"><asp:Label runat="server" ID="complete"></asp:Label></td>
            </tr>
        </table>
        
        
    </div>
    </form>
    <!-- Navigation -->
    <a href="Search.aspx">Search Page</a>
    <br />
    <a href="AddUser.aspx">Add a new member</a>
</body>
</html>
