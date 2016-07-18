<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Search.aspx.cs" Inherits="Search" %>

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
                <td><asp:Label runat="server" Text="Search Keyword : " Width="200px"></asp:Label></td>
                <td><asp:TextBox ID="query" runat="server" Width="200px"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="width:200px"><asp:Label runat="server" Text="Apply Filter to Gender :"></asp:Label></td>
                <td><asp:RadioButtonList  ID="genderFilter" runat="server" style="width:200px"> 
                         <asp:ListItem Value="Male">Male</asp:ListItem>
                         <asp:ListItem Value="Female">Female</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td> <asp:Label runat="server" Text="Apply Filter to Hobbies" Width="200px" ></asp:Label></td>
                <td> <asp:CheckBoxList Width="200px" ID="hobbyFilter" runat="server" >
                        <asp:ListItem Text="Basketball" Value="Basketball" ></asp:ListItem>
                        <asp:ListItem Text="Football" Value="Football" ></asp:ListItem>
                        <asp:ListItem Text="Snowboard" Value="Snowboard" ></asp:ListItem>
                        <asp:ListItem Text="Fitness" Value="Fitness" ></asp:ListItem>         
                     </asp:CheckBoxList></td>
            </tr>

            <tr>
                <td><asp:Label runat="server" Text="Apply Filter to City" Width="200px"></asp:Label></td>
                <td><asp:DropDownList Width="200px" ID="cityFilter" runat="server" >
                        <asp:ListItem Value="all" Text="all" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="Ankara" Text="Ankara"></asp:ListItem>
                        <asp:ListItem Value="Antalya" Text="Antalya"></asp:ListItem>
                        <asp:ListItem Value="Bursa" Text="Bursa"></asp:ListItem>
                        <asp:ListItem Value="İstanbul" Text="İstanbul"></asp:ListItem>
                        <asp:ListItem Value="İzmir" Text="İzmir"></asp:ListItem>
                    </asp:DropDownList></td>
            </tr>

            <tr>
                <td style="width:200px"></td>
                <td><asp:Button ID="sendQuery" runat="server" Text="Search" onClick="doSearchClick" BorderWidth="2px"/></td>
            </tr>
        </table>
        
        
      
        
         
        <!-- Search Results -->
        <asp:GridView ID="searchResult" runat="server" AutoGenerateColumns="false"  >
            <Columns>
                <asp:TemplateField headertext="Send E-mail">
                    <ItemTemplate>
                        <asp:CheckBox ID="RowCheck" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField headerText="Name" DataField="name" />
                <asp:BoundField headerText="Surname" DataField="surname" />
                <asp:BoundField headerText="Gender" DataField="gender"/>
                <asp:BoundField headerText="Phone" DataField="telephone" />
                <asp:BoundField headerText="E-mail" DataField="email"/>
                <asp:BoundField headerText="City" DataField="city"/>
                <asp:BoundField headerText="Hobby" DataField="hobby"/>
            </Columns>
        </asp:GridView>

        <!-- Appears when search result is post backed-->
        <asp:Panel runat="server" ID="mailPanel">
            <asp:Button ID="sendEmail" runat="server" Text="Send" OnClick="doSend"/>
            <table>
                <tr>
                    <td><asp:Label ID="subjectHeader" runat="server" Width="100px" Text="Subject"></asp:Label></td>
                    <td><asp:TextBox ID="mailSubject" runat="server" Width="250px"></asp:TextBox></td>
                </tr>
                <tr >
                    <td><asp:Label ID="contentHeader" runat="server" Width="100px" Text="Content"></asp:Label></td>
                    <td><asp:TextBox ID="mailContent" runat="server" Width="250px" Height="300px"></asp:TextBox></td>
                </tr>
            </table>
        </asp:Panel>
    </div>
    </form>
    <a href="Search.aspx">Search Page</a>
    <br />
    <a href="AddUser.aspx">Add a new member</a>

</body>
</html>
