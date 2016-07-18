using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class errorCheck : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Thread.Sleep(10000);
        Response.Write("This page was generated and cache at:" +
        DateTime.Now.ToString());
        if (!IsPostBack)
        {
            string[,] quotes = 
            {
            {"Imagination is more important than Knowledge.", "Albert Einsten"},
            {"Assume a virtue , if you have it not", "Shakespeare"},
            {"A man cannot be comfortable without his own approval", "Mark Twain"},
            {"Beware the young doctor and the old barber", "Benjamin Franklin"},
            {"Whatever begun in anger ends in shame", "Benjamin Franklin"}
         };
         
         for (int i=0; i<quotes.GetLength(0); i++){
            ddlquotes.Items.Add(new ListItem(quotes[i,0], quotes[i,1]));
         }
      }
   }

    protected void ddlquotes_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlquotes.SelectedIndex != -1)
        {
            lblquotes.Text = String.Format("{0}, Quote: {1}", ddlquotes.SelectedItem.Text, ddlquotes.SelectedValue);
        }
    }
}