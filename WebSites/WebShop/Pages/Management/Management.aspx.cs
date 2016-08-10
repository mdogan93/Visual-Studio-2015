using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_Management_Management : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {

    }

    protected void grdProducts_RowEditing(object sender, GridViewEditEventArgs e)
    {
        // Get Selected Row
        GridViewRow row = grdProducts.Rows[e.NewEditIndex];

        // Get Id of selected row 
        int rowId = Convert.ToInt32(row.Cells[1].Text);

        Response.Redirect("~/Pages/Management/ManageProducts.aspx?id=" + rowId);
    }
}