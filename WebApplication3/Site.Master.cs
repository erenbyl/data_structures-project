using System;
using System.Web.UI;

namespace WebApplication3
{
    public partial class Site : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.DataBind();
           
            
        }
        public string GetActive(string page)
        {
            string currentPage = System.IO.Path.GetFileName(Request.Url.AbsolutePath);
            return currentPage.Equals(page, StringComparison.OrdinalIgnoreCase) ? "nav-link active-link" : "nav-link";
        }

    }
}
