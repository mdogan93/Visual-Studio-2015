using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Repeater : System.Web.UI.Page
{
    void Page_Load(Object Sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            ArrayList values = new ArrayList();

            values.Add(new PositionData("Microsoft", "Msft"));
            values.Add(new PositionData("Intel", "Intc"));
            values.Add(new PositionData("Dell", "Dell"));

            Repeater1.DataSource = values;
            Repeater1.DataBind();
        }
    }

    protected void R1_ItemCommand(Object Sender, RepeaterCommandEventArgs e)
    {
        Label2.Text = "The " + ((Button)e.CommandSource).Text + " button has just been clicked; <br />";
    }

}

public class PositionData
{

    private string name;
    private string ticker;

    public PositionData(string name, string ticker)
    {
        this.name = name;
        this.ticker = ticker;
    }

    public string Name
    {
        get
        {
            return name;
        }
    }

    public string Ticker
    {
        get
        {
            return ticker;
        }
    }
}