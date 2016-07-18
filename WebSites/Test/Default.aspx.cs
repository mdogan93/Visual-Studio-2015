using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{

  protected void Button_Click(object sender, EventArgs e){
    switch (((Button)sender).ID)
    {
        case "Button1":
            if (TextBoxValidator1.IsValid)
            {
                Label1.Text = "TextBox validates.";
            }
            else
            {
                Label1.Text = "";
                Label4.Text = "";
            }
            break;
        case "Button2":
            // Must explicitly cause Validate here because 
            // Button2 has CausesValidation set to false.
            Validate("Group2");
            if (CustomValidator.IsValid)
            {
                Label2.Text = "CheckBox validates.";
            }
            else
            {
                Label2.Text = "";
                Label4.Text = "";
            }
            break;
        default:
            Label1.Text = "";
            Label2.Text = "";
            break;

    }
}

// Custom validator for check box.
protected void CustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
{
    args.IsValid = (CheckBox1.Checked == true);
}

protected void Page_Load(object sender, EventArgs e)
{
    if (IsPostBack && Context.Request.Form["__EVENTTARGET"] == "TextBox2")
    {
        // Handle AutoPostBack TextBox.
        Validate("Group3");
        if (Page.IsValid)
        {
            Label3.Text = "AutoPostBack TextBox validates.";
        }
        else
        {
            Label3.Text = "";
            Label4.Text = "";
        }
    }

}

protected void Button3_Click(object sender, EventArgs e)
{
    Validate();
    if (Page.IsValid)
        Label4.Text = "All controls valid.";
    else
    {
        Label1.Text = "";
        Label2.Text = "";
        Label3.Text = "";
        Label4.Text = "";
    }

}
}