using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class registration : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack) return;
        else
        {
            var yearList = new ArrayList();
            yearList.Add("-Year-");
            for (var i = 1940; i <= 2015; i++)
            {
                yearList.Add(i);
            }
            dateYear.DataSource = yearList;
            dateYear.DataBind();

            var dayList = new ArrayList();
            dayList.Add("-Day-");
            for (var i = 1; i <= 31; i++)
            {
                dayList.Add(i);
            }
            dateDay.DataSource = dayList;
            dateDay.DataBind();
        }
    }

    protected void submitInfo(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            Label1.Text = "THANKS";
        }
        else
        {
            Label1.Text = "Missing Fields";
        }
    }

}