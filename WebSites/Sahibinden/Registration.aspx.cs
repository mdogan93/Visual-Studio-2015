using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class registration : System.Web.UI.Page
{
    private int? educationId
    {
        get { return (int?)ViewState["EducationId"]; }
        set { ViewState["EducationId"] = value; }
    }
    private int? jobId
    {
        get { return (int?)ViewState["jobId"]; }
        set { ViewState["jobId"] = value; }
    }

    SqlConnection connection = OpenSqlConnection();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                //Add this couple of lines If you are adding controls dynamically and you need to find a specific control (by name)
                DropDownList ddl = default(DropDownList);
                ddl = (DropDownList)FindControl("Education");

                System.Data.DataTable subjects = new System.Data.DataTable();
                System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter("Get_AdvertManagement_Educations", connection);
                adapter.Fill(subjects);

                Education.DataSource = subjects;
                Education.DataTextField = "EducationLevel";
                Education.DataValueField = "Id";
                Education.DataBind();
            }
            catch (Exception ex)
            {
                debug.Text = "error";
            }

            try
            {
                DropDownList ddl = default(DropDownList);
                ddl = (DropDownList)FindControl("Job");

                System.Data.DataTable subjects = new System.Data.DataTable();
                System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter("Get_AdvertManagement_Jobs", connection);
                adapter.Fill(subjects);

                Job.DataSource = subjects;
                Job.DataTextField = "JobName";
                Job.DataValueField = "Id";
                Job.DataBind();
            }
            catch (Exception ex)
            {
                debug.Text = "error";
            }

            var yearList = new ArrayList();
            yearList.Add("-Yıl-");
            for (var i = 1940; i <= 2015; i++)
            {
                yearList.Add(i);
            }
            dateYear.DataSource = yearList;
            dateYear.DataBind();

            var dayList = new ArrayList();
            dayList.Add("-Gün-");
            for (var i = 1; i <= 31; i++)
            {
                dayList.Add(i);
            }
            dateDay.DataSource = dayList;
            dateDay.DataBind();
        }
    }

    protected void submitInfo(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            Education.SelectedIndex = Education.Items.IndexOf(Education.Items.FindByText("value"));
            int genderVal = Convert.ToInt32(gender.SelectedValue);

            String tryBitch = "Insert_AdvertManagement_User '" + username.Text.ToString() + "','" + name.Text.ToString() + "','" + surname.Text.ToString() + "'," + genderVal + ",'"
                                + email.Text.ToString() + "','" + password.Text.ToString() + "'," + educationId + "," + jobId + ",'" + phone.Text.ToString() + "', '2016-05-05' ";
            SqlCommand cmd = new SqlCommand(tryBitch, connection);
            cmd.ExecuteNonQuery();


        }
        else
        {
            Label1.Text = "Missing Fields";
        }

    }


    static private string GetConnectionString()
    {
        // To avoid storing the connection string in your code, 
        // you can retrieve it from a configuration file.
        return "Data Source=PIXSERVER;Initial Catalog=PixAdvert;Integrated Security=True";
    }

    private static SqlConnection OpenSqlConnection()
    {
        string connectionString = GetConnectionString();
        SqlConnection connection = new SqlConnection();
        connection.ConnectionString = connectionString;
        connection.Open();

        return connection;

    }


    protected void Education_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Education.SelectedItem != null)
        {
            educationId = Convert.ToInt32(Education.SelectedValue);
        }
    }


    protected void Job_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Job.SelectedItem != null)
        {
            jobId = Convert.ToInt32(Job.SelectedValue);
        }

    }
}
