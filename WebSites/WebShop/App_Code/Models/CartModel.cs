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
}