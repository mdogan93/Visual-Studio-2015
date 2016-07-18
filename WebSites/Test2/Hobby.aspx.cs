using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Hobby : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Selection_Change(Object sender, EventArgs e)
    {

        // Set the background color for days in the Calendar control
        // based on the value selected by the user from the 
        // DropDownList control.
        Calendar1.DayStyle.BackColor =
            System.Drawing.Color.FromName(ColorList.SelectedItem.Value);

    }
}