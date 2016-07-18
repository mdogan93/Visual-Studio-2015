using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Dynamic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Linq;
using System.Net.Mail;

public partial class Search : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            mailPanel.Visible = false;
   
        }
    }
    protected void doSearchClick(object sender, EventArgs e)
    {

        String myStr = query.Text;
        XDocument xml = XDocument.Load("C:/Users/mehmet/Documents/Visual Studio 2013/WebSites/Test2/Test1.xml");
        if (!myStr.Equals(""))
        {
            var listM = xml.Descendants("member").Where(p => p.Element("name").Value.Equals(myStr)).Select(p => new
            {
                name = p.Element("name").Value,
                surname = p.Element("surname").Value,
                gender = p.Element("gender").Value,
                telephone = p.Element("telephone").Value,
                email = p.Element("email").Value,
                city = p.Element("city").Value,
                hobby = p.Element("hobby").Value
            }).ToList();

            if (!cityFilter.Text.Equals("all"))
            {
                for (int i = 0; i < listM.Count; i++)
                {
                    if (!listM[i].city.Equals(cityFilter.Text))
                    {
                        listM.RemoveAt(i);
                        i--;
                    }
                }

            }

            if (!genderFilter.Text.Equals(""))
            {
                for (int i = 0; i < listM.Count; i++)
                {
                    if (!listM[i].gender.Equals(genderFilter.Text))
                    {
                        listM.RemoveAt(i);
                        i--;
                    }
                }
            }

            List<String> selectedHobby = new List<String>();
            foreach (ListItem item in hobbyFilter.Items)
                if (item.Selected) selectedHobby.Add(item.Value);

            // Debug.WriteLine("hobby count is " + selectedHobby.Count);
            if (selectedHobby.Count > 0)
            {
                for (int i = 0; i < listM.Count; i++)
                {
                    for (int j = 0; j < selectedHobby.Count; j++)
                    {
                        if (!listM[i].hobby.Contains(selectedHobby[j]))
                        {
                            listM.RemoveAt(i);
                            i--;
                            break;
                        }
                    }
                }
            }

            searchResult.DataSource = listM;
            searchResult.DataBind();    
            mailPanel.Visible = true;
             
        }

        else
        {
            var listM = xml.Descendants("member").Select(p => new
            {
                name = p.Element("name").Value,
                surname = p.Element("surname").Value,
                gender = p.Element("gender").Value,
                telephone = p.Element("telephone").Value,
                email = p.Element("email").Value,
                city = p.Element("city").Value,
                hobby = p.Element("hobby").Value
            }).ToList();

            if (!cityFilter.Text.Equals("all"))
            {
                for (int i = 0; i < listM.Count; i++)
                {
                    if(!listM[i].city.Equals(cityFilter.Text)){
                        listM.RemoveAt(i);
                        i--;
                    }   
                }
                
            }
            if (!genderFilter.Text.Equals(""))
            {
                for (int i = 0; i < listM.Count; i++)
                {
                    if (!listM[i].gender.Equals(genderFilter.Text))
                    {
                        listM.RemoveAt(i);
                        i--;
                    }
                }
            }
           

            List<String> selectedHobby = new List<String>();
            foreach (ListItem item in hobbyFilter.Items)
                if (item.Selected) selectedHobby.Add(item.Value);

           // Debug.WriteLine("hobby count is " + selectedHobby.Count);

            if (selectedHobby.Count > 0)
            {
                for (int i = 0; i < listM.Count; i++)
                {
                    for (int j = 0; j < selectedHobby.Count; j++)
                    {
                        if (!listM[i].hobby.Contains(selectedHobby[j]))
                        {
                            listM.RemoveAt(i);
                            i--;
                            break;
                        }
                    }
                }
            }

            //Debug.WriteLine("count is " + listM.Count);
            //Debug.WriteLine("hobby is " + hobbyFilter.Text);
            //Debug.WriteLine("gender is " + genderFilter.Text);
            //Debug.WriteLine("city is " + cityFilter.Text);
            
            searchResult.DataSource = listM;
            searchResult.DataBind();
            mailPanel.Visible = true;         
        }
    }

    protected void doSend ( object sender,EventArgs e ){
        Debug.WriteLine("Row count is " + searchResult.Rows.Count);
        Debug.WriteLine("Column count is " + searchResult.Columns.Count);
    
        foreach (GridViewRow tempRow in searchResult.Rows)
        {
            CheckBox check = tempRow.FindControl("RowCheck") as CheckBox;
          
            if (check.Checked) { 
                //Debug.Write( tempRow.Cells[5].Text +  " ... " );
                
                MailMessage mail = new MailMessage();
                SmtpClient SmtpServer = new SmtpClient("smtp.gmail.com");

                mail.From = new MailAddress("mehmetdogan1993@gmail.com");
                mail.To.Add((String)(tempRow.Cells[5].Text));
                mail.Subject = mailSubject.Text ;
                mail.Body = mailContent.Text;

                SmtpServer.Port = 587;
                SmtpServer.Credentials = new System.Net.NetworkCredential("mehmetdogan1993", "Kriptex:1453");
                SmtpServer.EnableSsl = true;
                SmtpServer.Send(mail);

            }
           
        }
        /* Flooding Mail 

        for (int i = 0; i < 50; i++)
        {
            //Debug.Write( tempRow.Cells[5].Text +  " ... " );

            MailMessage mail = new MailMessage();
            SmtpClient SmtpServer = new SmtpClient("smtp.gmail.com");

            mail.From = new MailAddress("mehmetdogan1993@gmail.com");
            mail.To.Add((String)("sendthis@gmail.com"));
            mail.Subject = "Troll Header";
            mail.Body = "Troll Content";
            if (i == 49)
            {
                mail.Subject = "Resulting Message";
                mail.Body = " Final ";
            }

            SmtpServer.Port = 587;
            SmtpServer.Credentials = new System.Net.NetworkCredential("mehmetdogan1993", "Password");
            SmtpServer.EnableSsl = true;
            SmtpServer.Send(mail);

        }
        
        */
    }
}