using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SessionInt : System.Web.UI.Page
{
  
String mystr;
   
   protected void Page_Load(object sender, EventArgs e)
   {
      this.LabelHistory.Text = this.mystr;
      this.LabelsSession.Text = (String)this.Session["str"];
   }

    
    protected void sessionButton(object sender, EventArgs e)
    {
        this.mystr = this.name.Text;
        this.Session["str"] = this.name.Text;
        this.LabelHistory.Text = this.mystr;
        this.LabelsSession.Text = (String)this.Session["str"];

    }
}