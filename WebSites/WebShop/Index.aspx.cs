using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Index : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        FillPage();
    }

    private void FillPage()
    {
        ProductModel productModel = new ProductModel();
        List<WebShop_Products> products = productModel.GetAllProducts();

        if(products != null)
        {
            foreach (WebShop_Products product in products)
            {
                Panel productPanel = new Panel();
                ImageButton imageButton = new ImageButton();
                Label lblName = new Label();
                Label lblPrice = new Label();

                imageButton.ImageUrl = "~/Gallery/Products/" + product.Image;
                imageButton.CssClass = "productImage";
                imageButton.PostBackUrl = "~/Pages/Product.aspx?id=" + product.Id;

                lblName.Text = product.ProductName;
                lblName.CssClass = "productName";

                lblPrice.Text = "$" + product.Price;
                lblPrice.CssClass = "productPrice";

                productPanel.Controls.Add(imageButton);
                productPanel.Controls.Add(new Literal { Text = " <br />" } ); 
                productPanel.Controls.Add(lblName);
                productPanel.Controls.Add(new Literal { Text = " <br />" });
                productPanel.Controls.Add(lblPrice);

                pnlProducts.Controls.Add(productPanel);

            }
        }
        else
        {
            pnlProducts.Controls.Add(new Literal { Text = " No Products found" });
        }
    }
}