﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;

public partial class PixAdvertEntities : DbContext
{
    public PixAdvertEntities()
        : base("name=PixAdvertEntities")
    {
    }

    protected override void OnModelCreating(DbModelBuilder modelBuilder)
    {
        throw new UnintentionalCodeFirstException();
    }

    public virtual DbSet<WebShop_Cart> WebShop_Cart { get; set; }
    public virtual DbSet<WebShop_Products> WebShop_Products { get; set; }
    public virtual DbSet<WebShop_ProductTypes> WebShop_ProductTypes { get; set; }
    public virtual DbSet<WebShop_UserInformation> WebShop_UserInformation { get; set; }
}
