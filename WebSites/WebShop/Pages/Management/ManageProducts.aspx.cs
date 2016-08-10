using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_Management_ManageProducts : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getImages();

            if (!String.IsNullOrWhiteSpace(Request.QueryString["id"]))
            {
                int id = Convert.ToInt32(Request.QueryString["id"]);
                FillPage(id);
            }
           
        }
    }

    private void FillPage(int id)
    {
        ProductModel productModel = new ProductModel();
        WebShop_Products product =  productModel.GetProductById(id);

        txtDescription.Text = product.Description;
        txtName.Text = product.ProductName;
        txtPrice.Text = (product.Price).ToString();
        ddlProductImage.SelectedValue = product.Image;
        ddlProductType.SelectedValue = product.TypeId.ToString();

    }
    private void getImages()
    {
        try
        {
            //Get all file paths
            string[] images = Directory.GetFiles(Server.MapPath("~/Gallery/Products/"));

            // get all file names
            ArrayList imageList = new ArrayList();
            foreach (string image in images)
            {
                string imageName = image.Substring(image.LastIndexOf(@"\", StringComparison.Ordinal) + 1);
                imageList.Add(imageName);
               
            }
            ddlProductImage.DataSource = imageList;
            ddlProductImage.AppendDataBoundItems = true;
            ddlProductImage.DataBind();
        }
        catch(Exception e)
        {
            lblResult.Text = e.ToString();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        ProductModel productModel = new ProductModel();
        WebShop_Products temp = CreateProduct();
        if (!String.IsNullOrWhiteSpace(Request.QueryString["id"]))
        {
            int id = Convert.ToInt32(Request.QueryString["id"]);
            lblResult.Text = productModel.UpdateProduct(id, temp);
        }
        else
        {
            lblResult.Text = productModel.InsertProduct(temp);
        }

    }

    private WebShop_Products CreateProduct()
    {
        WebShop_Products temp = new WebShop_Products();
        temp.ProductName = txtName.Text;
        temp.Price = Convert.ToInt32(txtPrice.Text);
        temp.Image = ddlProductImage.SelectedValue;
        temp.TypeId = Convert.ToInt32(ddlProductType.SelectedValue);
        temp.Description = txtDescription.Text;
        return temp;
        
    }
}