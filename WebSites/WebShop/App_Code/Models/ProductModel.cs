using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ProductModel
/// </summary>
public class ProductModel
{
 
    public string InsertProduct(WebShop_Products product)
    {
        try
        {
            PixAdvertEntities db = new PixAdvertEntities();
            db.WebShop_Products.Add(product);
            db.SaveChanges();
            return product.ProductName + "was inserted";


        }
        catch(Exception e)
        {
            return "error" + e;
        }
    }

    public string UpdateProduct(int id, WebShop_Products product)
    {
        try
        {
            PixAdvertEntities db = new PixAdvertEntities();
            WebShop_Products temp = db.WebShop_Products.Find(id);

            temp.ProductName = product.ProductName;
            temp.Price = product.Price;
            temp.Image = product.Image;
            temp.TypeId = product.TypeId;
            temp.Description = product.Description;

            db.SaveChanges();
            return product.ProductName + "was changed ";
        }
        catch (Exception e)
        {
            return "error" + e ;
        }
    }

    public string DeleteProduct(int id)
    {
        try
        {
            PixAdvertEntities db = new PixAdvertEntities();
            WebShop_Products temp = db.WebShop_Products.Find(id);
            db.WebShop_Products.Attach(temp);
            db.WebShop_Products.Remove(temp);
            return temp.ProductName + " was removed";
        }
        catch (Exception e)
        {
            return "error" + e;
        }
    }

    public WebShop_Products GetProductById(int id)
    {
        try
        {
            PixAdvertEntities db = new PixAdvertEntities();
            WebShop_Products temp = db.WebShop_Products.Find(id);
            return temp;
        }
        catch (Exception e)
        {
            return null;
        }
    }

    public List<WebShop_Products> GetAllProducts()
    {
        try
        {
            PixAdvertEntities db = new PixAdvertEntities();
            List < WebShop_Products > products = (from x in db.WebShop_Products select x).ToList();
            return products;
        }
        catch (Exception e)
        {
            return null;
        }
    }
    public List<WebShop_Products> GetProductsByType(int typeId)
    {
        try
        {
            PixAdvertEntities db = new PixAdvertEntities();
            WebShop_Products temp = db.WebShop_Products.Find(typeId);
            List<WebShop_Products> products = (from x in db.WebShop_Products
                                               where x.TypeId == typeId
                                               select x).ToList();
            return products;
        }
        catch (Exception e)
        {
            return null;
        }
    }


}