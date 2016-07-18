using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Linq;

public partial class AddUser : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void submitInfo(object sender, EventArgs e)
    {
        String tempHobby ="";

        List<String> selectedHobby = new List<String>();
        foreach (ListItem item in Hobby.Items)
            if (item.Selected) tempHobby += (item.Value + " " );

        //for (int i = 0; i < selectedHobby.Count; i++)
        //   tempHobby+= (selectedHobby[i]+ " " );
        
 
        try{
            XDocument doc = XDocument.Load("C:/Users/mehmet/Documents/Visual Studio 2013/WebSites/Test2/Test1.xml");
            XElement addLoc = doc.Element("members");
            addLoc.Add(new XElement("member",
                            new XElement("name", name.Text),
                            new XElement("surname", surname.Text),
                            new XElement("gender", gender.Text),
                            new XElement("telephone", phone.Text),
                            new XElement("email", email.Text),
                            new XElement("city", city.Text),
                            new XElement("hobby", tempHobby)));
            doc.Save("C:/Users/mehmet/Documents/Visual Studio 2013/WebSites/Test2/Test1.xml");    
        }
        catch (FileNotFoundException){
            new XDocument(
                new XElement("members",
                    new XElement("member",
                        new XElement("name", name.Text),
                        new XElement("surname", surname.Text),
                        new XElement("gender", gender.Text),
                        new XElement("telephone", phone.Text),
                        new XElement("email", email.Text),
                        new XElement("city", city.Text),
                        new XElement("hobby", tempHobby)
                    )
                )   
            ).Save("C:/Users/mehmet/Documents/Visual Studio 2013/WebSites/Test2/Test1.xml");

        }
        complete.Text = "User is succesfully added to database";

         
    }
        
}