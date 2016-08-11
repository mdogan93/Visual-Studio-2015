using Microsoft.AspNet.Identity;
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
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (!String.IsNullOrWhiteSpace(Request.QueryString["id"]))
        {
            string clientId = Context.User.Identity.GetUserId();
            if(clientId != null)
            {         
                int proId = Convert.ToInt32(Request.QueryString["id"]);
                int amount = Convert.ToInt32(ddlAmount.SelectedValue);

                WebShop_Cart cart = new WebShop_Cart();
                cart.Amount = amount;
                cart.ClientId = clientId;
                cart.ProductId = proId;
                cart.DatePurchased = DateTime.Now;
                cart.IsInChart = true;

                CartModel cartModel = new CartModel();
                lblResult.Text=cartModel.InsertCart(cart);
            }
            else
            {
                lblResult.Text = "Please login to order items";
            }




        }
    }
    
}