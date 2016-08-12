using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ChartModel
/// </summary>
public class CartModel
{
    public string InsertCart(WebShop_Cart cart)
    {
        try
        {
            PixAdvertEntities db = new PixAdvertEntities();
            db.WebShop_Cart.Add(cart);
            db.SaveChanges();
            return cart.DatePurchased + "was inserted";
            


        }
        catch (Exception e)
        {
            return "error" + e;
        }
    }

    public string UpdateChart(int id, WebShop_Cart cart)
    {
        try
        {
            PixAdvertEntities db = new PixAdvertEntities();
            WebShop_Cart temp = db.WebShop_Cart.Find(id);

            temp.DatePurchased = cart.DatePurchased;
            temp.IsInChart = cart.IsInChart;
            temp.ProductId = cart.ProductId;
            temp.ClientId = cart.ClientId;
            temp.Amount = cart.Amount;

            db.SaveChanges();
            return cart.DatePurchased + "was changed ";
        }
        catch (Exception e)
        {
            return "error" + e;
        }
    }

    public string DeleteFromCart(int id)
    {
        try
        {
            PixAdvertEntities db = new PixAdvertEntities();
            WebShop_Cart temp = db.WebShop_Cart.Find(id);
            db.WebShop_Cart.Attach(temp);
            db.WebShop_Cart.Remove(temp);
            return temp.DatePurchased + " was removed";
        }
        catch (Exception e)
        {
            return "error" + e;
        }
    }

    public List<WebShop_Cart> GetOrdersInCart(string userId){

        PixAdvertEntities db = new PixAdvertEntities();
        List<WebShop_Cart> orders = (from x in db.WebShop_Cart
                               where x.ClientId == userId && x.IsInChart
                               orderby x.DatePurchased
                               select x).ToList();

        return orders;     
    }

    public int GetAmountOfOrders(string userId)
    {
        try
        {
            PixAdvertEntities db = new PixAdvertEntities();
            int amount = (from x in db.WebShop_Cart
                          where x.ClientId == userId && x.IsInChart
                          select x.Amount).Sum();
            return amount;

        }
        catch
        {

        }
        return 0;
    }

    public void UpdateQuantity(int id, int quantity)
    {
        PixAdvertEntities db = new PixAdvertEntities();
        WebShop_Cart item = db.WebShop_Cart.Find(id);

        item.Amount = quantity;
        db.SaveChanges();

    }
    
    public void MarkOrdersAsPaid(List<WebShop_Cart> carts)
    {
        PixAdvertEntities db = new PixAdvertEntities();
        if(carts != null)
        {
            foreach(WebShop_Cart cart in carts)
            {
                WebShop_Cart temp = db.WebShop_Cart.Find(cart.Id);
                temp.DatePurchased = DateTime.Now;
                temp.IsInChart = false;
                
            }
            db.SaveChanges();
        }

    }

}