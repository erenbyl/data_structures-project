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
                // 1. Bellekteki Hashtable'a ekle
                Hashtable dilekListesi = (Hashtable)Application["DilekListesi"];
                string anahtar = "dilek_" + DateTime.Now.Ticks;
                dilekListesi[anahtar] = dilek;
                Application["DilekListesi"] = dilekListesi;

                // 2. Kalıcı olarak CSV dosyasına yaz
                try
                {
                    // DOĞRU YOL: Server.MapPath kullan, sabit path kullanma
                    string dosyaYolu = Server.MapPath("~/App_Data/dilekler.csv");
                    string zamanDamgasi = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                    string satir = $"\"{zamanDamgasi}\",\"{dilek.Replace("\"", "\"\"")}\"";

                    if (!System.IO.File.Exists(dosyaYolu))
                    {
                        System.IO.File.WriteAllText(dosyaYolu, "Tarih,Mesaj\n");
                    }

                    System.IO.File.AppendAllText(dosyaYolu, satir + Environment.NewLine);

                    // Başarılı mesaj
                    lblDurum.Text = "✔ Dilek/Şikayet başarıyla kaydedildi.";
                    lblDurum.ForeColor = System.Drawing.Color.Green;
                    txtGerıdonus.Text = "";
                }
                catch (Exception ex)
                {
                    lblDurum.Text = $"❌ Dosyaya yazılırken hata oluştu: {ex.Message}";
                    lblDurum.ForeColor = System.Drawing.Color.Red;
                }
            }
            else
            {
                lblDurum.Text = "⚠ Lütfen boş bir metin girmeyiniz!";
                lblDurum.ForeColor = System.Drawing.Color.Red;
            }

            // Panelin açık kalmasını sağla
            ClientScript.RegisterStartupScript(this.GetType(), "OpenPanel", "document.getElementById('rightPanel').style.display='block';", true);
        }

        // HTML içeriğini sade metne dönüştürmek için (opsiyonel)
        private string TemizleHTML(string html)
        {
            return html.Replace("<br />", "\r\n").Replace("<strong>", "").Replace("</strong>", "").Replace("<div>", "").Replace("</div>", "");
        }
    }
}
