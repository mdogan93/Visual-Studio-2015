using System;
using System.Data;
using System.Configuration;
using System.Linq;

using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using System.Xml.Linq;


public class booklist
{
    protected String bookname;
    protected String authorname;
    public booklist(String bname, String aname)
    {
        this.bookname = bname;
        this.authorname = aname;

    }

    public String Book
    {
        get
        {
            return this.bookname;
        }
        set
        {
            this.bookname = value;
        }
    }

    public String Author
    {
        get
        {
            return this.authorname;
        }
        set
        {
            this.authorname = value;
        }
    }
}
