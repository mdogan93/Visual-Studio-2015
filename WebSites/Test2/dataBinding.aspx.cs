using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Collections;
public partial class dataBinding : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        IList bklist = createbooklist();

        if (!this.IsPostBack)
        {
            this.ListBox1.DataSource = bklist;
            this.ListBox1.DataTextField = "Book";
            this.ListBox1.DataValueField = "Author";

            this.DropDownList1.DataSource = bklist;
            this.DropDownList1.DataTextField = "Book";
            this.DropDownList1.DataValueField = "Author";

            this.RadioButtonList1.DataSource = bklist;
            this.RadioButtonList1.DataTextField = "Book";
            this.RadioButtonList1.DataValueField = "Author";

            this.CheckBoxList1.DataSource = bklist;
            this.CheckBoxList1.DataTextField = "Book";
            this.CheckBoxList1.DataValueField = "Author";

            this.DataBind();
        }
    }

    protected IList createbooklist()
    {
        ArrayList allbooks = new ArrayList();
        booklist bl;

        bl = new booklist("UNIX CONCEPTS", "SUMITABHA DAS");
        allbooks.Add(bl);

        bl = new booklist("PROGRAMMING IN C", "RICHI KERNIGHAN");
        allbooks.Add(bl);

        bl = new booklist("DATA STRUCTURE", "TANENBAUM");
        allbooks.Add(bl);

        bl = new booklist("NETWORKING CONCEPTS", "FOROUZAN");
        allbooks.Add(bl);

        bl = new booklist("PROGRAMMING IN C++", "B. STROUSTROUP");
        allbooks.Add(bl);

        bl = new booklist("ADVANCED JAVA", "SUMITABHA DAS");
        allbooks.Add(bl);

        return allbooks;
    }

    protected void ListBox1_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.lbllistbox.Text = this.ListBox1.SelectedValue;
    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.lbldrpdown.Text = this.DropDownList1.SelectedValue;
    }

    protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.lblrdlist.Text = this.RadioButtonList1.SelectedValue;
    }

    protected void CheckBoxList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.lblchklist.Text = this.CheckBoxList1.SelectedValue;
    }
}