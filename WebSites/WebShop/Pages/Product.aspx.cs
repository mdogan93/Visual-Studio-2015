using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_Product : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        FillPage();
    }
    private void FillPage()
    {
        if (!String.IsNullOrWhiteSpace(Request.QueryString["id"]))
        {
            int id = Convert.ToInt32(Request.QueryString["id"]);
            ProductModel productModel = new ProductModel();
            WebShop_Products product = productModel.GetProductById(id);

            lblPrice.Text = "Price Per unit : <br/>$" + product.Price;
            lblTitle.Text = product.ProductName;
            lblDescription.Text = product.Description;
            lblItemNumber.Text = id.ToString();
            imgProduct.ImageUrl = "~/Gallery/Products/" + product.Image;


            int[] amount = Enumerable.Range(1, 20).ToArray();
            ddlAmount.DataSource = amount;
            ddlAmount.AppendDataBoundItems = true;
            ddlAmount.DataBind();


        }
    }
}