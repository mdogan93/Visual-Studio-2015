using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ProductTypeModel
/// </summary>
public class ProductTypeModel
{
    public string InsertProductType(WebShop_ProductTypes productType)
    {
        try
        {
            PixAdvertEntities db = new PixAdvertEntities();
            db.WebShop_ProductTypes.Add(productType);
            db.SaveChanges();
            return productType.TypeName + "was inserted";


        }
        catch (Exception e)
        {
            return "error" + e;
        }
    }

    public string UpdateProductType(int id, WebShop_ProductTypes productType)
    {
        try
        {
            PixAdvertEntities db = new PixAdvertEntities();
            WebShop_ProductTypes temp = db.WebShop_ProductTypes.Find(id);

            temp.TypeName = productType.TypeName;

            db.SaveChanges();
            return productType.TypeName + "was changed ";
        }
        catch (Exception e)
        {
            return "error" + e;
        }
    }

    public string DeleteProductType(int id)
    {
        try
        {
            PixAdvertEntities db = new PixAdvertEntities();
            WebShop_ProductTypes temp = db.WebShop_ProductTypes.Find(id);
            db.WebShop_ProductTypes.Attach(temp);
            db.WebShop_ProductTypes.Remove(temp);
            return temp.TypeName + " was removed";
        }
        catch (Exception e)
        {
            return "error" + e;
        }
    }
}