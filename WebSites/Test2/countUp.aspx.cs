using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class countUp : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected int counter
    {
        get
        {
            if (ViewState["pcounter"] != null)
            {
                return ((int)ViewState["pcounter"]);
            }
            else
            {
                return 1;
            }
        }

        set
        {
            ViewState["pcounter"] = value;
        }
    }

    protected void btnIncrement_Click(object sender, EventArgs e)
    {
        lblCounter.Text = counter.ToString();
        counter++;
    }

}