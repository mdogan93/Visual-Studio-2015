using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_Management_ManageProductTypes : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        ProductTypeModel model = new ProductTypeModel();
        WebShop_ProductTypes pt = createProductType();

  
        lblResult.Text = model.InsertProductType(pt);

    }

    private WebShop_ProductTypes createProductType()
    {
        WebShop_ProductTypes p = new WebShop_ProductTypes();
        p.TypeName = txtName.Text;
        return p;
    }
}