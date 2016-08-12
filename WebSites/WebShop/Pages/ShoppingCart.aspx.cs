using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_ShoppingCart : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string userId = User.Identity.GetUserId();
        GetPurchasesInCart(userId);

    }

    private void GetPurchasesInCart(string userId)
    {
        CartModel model = new CartModel();
        double subTotal = 0;
        List<WebShop_Cart> purchaseList = model.GetOrdersInCart(userId);

        CreateShopTable(purchaseList, out subTotal);

        double vat = subTotal * 0.18;
        double totalAmount = subTotal + vat + 15;
        litVat.Text = "$" + vat;
        litTotalAmount.Text = "$" + totalAmount;
        litTotal.Text = "$" + subTotal;


    }

    private void CreateShopTable(List<WebShop_Cart> purchaseList, out double subTotal)
    {
        subTotal = 0;
        ProductModel model = new ProductModel();
        foreach (WebShop_Cart cart in purchaseList)
        {
            WebShop_Products product = model.GetProductById(cart.ProductId);



            Panel productPanel = new Panel();
            ImageButton imageButton = new ImageButton {ImageUrl = String.Format("~/Gallery/Products/{0}", product.Image),
                                                        PostBackUrl = String.Format("~/Pages/Product.aspx?id={0}", product.Id)};
            LinkButton lnkDelete = new LinkButton
            {
                PostBackUrl = String.Format("~/Pages/ShoppingCart.aspx?productId={0}", cart.Id),
                Text = "Delete Item",
                ID = "del" + cart.Id
            };

            lnkDelete.Click += Delete_item;

            int[] amount = Enumerable.Range(1, 20).ToArray();
            DropDownList ddlAmount = new DropDownList
            {
                DataSource = amount,
                AppendDataBoundItems = true,
                AutoPostBack = true,
                ID = cart.Id.ToString()
            };

            ddlAmount.DataBind();
            ddlAmount.SelectedValue = cart.Amount.ToString();
            ddlAmount.SelectedIndexChanged += ddlAmount_SelectedIndexChanged;

            Table table = new Table { CssClass = "cartTable" };
            TableRow a = new TableRow();
            TableRow b = new TableRow();


            TableCell a1 = new TableCell {RowSpan=2,Width=50};
            TableCell a2 = new TableCell{Text = string.Format("<h4>{0}</h4><br/>{1}<br/>In Stock",
                                            product.ProductName, "Item No:" + product.Id),
                                            HorizontalAlign = HorizontalAlign.Left, Width=350
            };
            TableCell a3 = new TableCell{Text= "Unit Price <hr/>" };
            TableCell a4 = new TableCell{Text= "Quantity <hr/>"   };
            TableCell a5 = new TableCell{Text= "Item Total<hr/>"  };
            TableCell a6 = new TableCell { };

            /***********************/ 
            TableCell b1 = new TableCell {};
            TableCell b2 = new TableCell { Text = "$" + product.Price};
            TableCell b3 = new TableCell {};
            TableCell b4 = new TableCell { Text = "$" + (cart.Amount * product.Price) };
            TableCell b5 = new TableCell {};
            TableCell b6 = new TableCell { };


            a1.Controls.Add(imageButton);
            a6.Controls.Add(lnkDelete);
            b3.Controls.Add(ddlAmount);
            a.Cells.Add(a1);
            a.Cells.Add(a2);
            a.Cells.Add(a3);
            a.Cells.Add(a4);
            a.Cells.Add(a5);
            a.Cells.Add(a6);

            b.Cells.Add(b1);
            b.Cells.Add(b2);
            b.Cells.Add(b3);
            b.Cells.Add(b4);
            b.Cells.Add(b5);
            b.Cells.Add(b6);

            table.Rows.Add(a);
            table.Rows.Add(b);

            pnlShoppingCart.Controls.Add(table);

            subTotal += Convert.ToDouble(cart.Amount * product.Price);

        }

        Session[User.Identity.GetUserId()] = purchaseList;
    }

    private void Delete_item(object sender, EventArgs e)
    {
        LinkButton selectedLink = (LinkButton)sender;
        string link = selectedLink.ID.Replace("del", "");
        int cartId = Convert.ToInt32(link);

        CartModel model = new CartModel();
        model.DeleteFromCart(cartId);

        Response.Redirect("~/Pages/ShoppingCart.aspx");
    }

    private void ddlAmount_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList selectedList = (DropDownList)sender;
        int quantity = Convert.ToInt32(selectedList.SelectedValue);
        int cartId = Convert.ToInt32(selectedList.ID);

        CartModel model = new CartModel();
        model.UpdateQuantity(cartId, quantity);

        Response.Redirect("~/Pages/ShoppingCart.aspx");

    }
}