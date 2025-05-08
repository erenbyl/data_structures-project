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
                if (Application["DilekListesi"] == null)
                {
                    Application["DilekListesi"] = new Hashtable();
                }

            }
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

        protected void btnGonder_Click(object sender, EventArgs e)
        {
            string dilek = txtGerıdonus.Text.Trim();
            if (!string.IsNullOrEmpty(dilek))
            {
                Hashtable dilekListesi = (Hashtable)Application["DilekListesi"];
                string anahtar = "dilek_" + DateTime.Now.Ticks;
                dilekListesi[anahtar] = dilek;
                Application["DilekListesi"] = dilekListesi;

                lblDurum.Text = "Dilek/Şikayet başarıyla kaydedildi.";
                lblDurum.ForeColor = System.Drawing.Color.Green;


            }
            else
            {
                lblDurum.Text = "Lütfen boş bir metin girmeyiniz!";
                lblDurum.ForeColor = System.Drawing.Color.Red;
            }
        }
        // HTML içeriğini sade metne dönüştürmek için (opsiyonel)
        private string TemizleHTML(string html)
        {
            return html.Replace("<br />", "\r\n").Replace("<strong>", "").Replace("</strong>", "").Replace("<div>", "").Replace("</div>", "");
        }
    }
}
