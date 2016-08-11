using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for UserInfoModel
/// </summary>
public class UserInfoModel
{
    public UserInfoModel()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    
    public WebShop_UserInformation getUserInformation(string guId)
    {
        PixAdvertEntities db = new PixAdvertEntities();
        WebShop_UserInformation item = (from x in db.WebShop_UserInformation
                                        where x.GUID == guId
                                        select x).FirstOrDefault();

        return item;
    }
    public void InsertUserInformation(WebShop_UserInformation info)
    {
        PixAdvertEntities db = new PixAdvertEntities();
        db.WebShop_UserInformation.Add(info);
        db.SaveChanges();
    }

}







