using System;
using System.Collections;

namespace WebApplication3
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Application["Duyurular"] != null)
                {
                    Hashtable duyurular = (Hashtable)Application["Duyurular"];
                    string sonuc = "";

                    foreach (DictionaryEntry entry in duyurular)
                    {
                        sonuc += $"<div style='border-bottom:1px solid #ccc;margin-bottom:10px;'>{entry.Value}</div>";
                    }

                    litDuyurular.Text = sonuc;
                }
                else
                {
                    litDuyurular.Text = "<p>📭 Henüz duyuru eklenmemiştir.</p>";
                }
            }
            }
        

        // HTML içeriğini sade metne dönüştürmek için (opsiyonel)
        private string TemizleHTML(string html)
        {
            return html.Replace("<br />", "\r\n").Replace("<strong>", "").Replace("</strong>", "").Replace("<div>", "").Replace("</div>", "");
        }
    }
}
