using System;
using System.Collections;
using System.Web.UI;

namespace WebApplication3
{
    public partial class PersonelSayfası : System.Web.UI.Page
    {
        // 💾 Tüm uygulama için geçerli statik tablolar
        public static Hashtable duyuruTablosu = new Hashtable();
        public static Hashtable sikayetTablosu = new Hashtable();

        protected void Page_Load(object sender, EventArgs e)
        {

            {
                if (!IsPostBack)
                {
                    if (Session["GirisYapanPersonel"] != null)
                    {
                        lblPersonelAdi.Text = Session["GirisYapanPersonel"].ToString();
                    }
                }
                if (!IsPostBack)
                {
                    if (Application["DilekListesi"] != null)
                    {
                        Hashtable dilekListesi = (Hashtable)Application["DilekListesi"];

                        // Dilekleri birleştirip göster
                        string tumDilekler = "";
                        foreach (DictionaryEntry entry in dilekListesi)
                        {
                            tumDilekler += "- " + entry.Value.ToString() + Environment.NewLine;
                        }

                        txtSikayet.Text = tumDilekler;
                    }
                    else
                    {
                        txtSikayet.Text = "Hiç dilek/şikayet bulunmamaktadır.";
                    }
                }
            }
        }

        protected void btnDuyuruKaydet_Click(object sender, EventArgs e)
        {
            string baslik = txtBaslık.Text.Trim();
            string icerik = txtIcerik.Text.Trim();

            if (!string.IsNullOrEmpty(baslik) && !string.IsNullOrEmpty(icerik))
            {
                // 1. Bellekte tutulan Application-level duyuru tablosu
                Hashtable duyurular = Application["Duyurular"] as Hashtable;
                if (duyurular == null)
                    duyurular = new Hashtable();

                string duyuruMetni = "📌 <b>" + baslik + "</b><br/>" + icerik;
                string anahtar = "duyuru_" + DateTime.Now.Ticks;

                // RAM'e yaz
                duyurular[anahtar] = duyuruMetni;
                Application["Duyurular"] = duyurular;

                // 2. CSV dosyasına kalıcı olarak yaz
                try
                {
                    string filePath = Server.MapPath("~/App_Data/duyurular.csv");
                    string timeStamp = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                    string line = $"\"{timeStamp}\",\"{baslik.Replace("\"", "\"\"")}\",\"{icerik.Replace("\"", "\"\"")}\"";

                    // Dosya yoksa başlık yaz
                    if (!System.IO.File.Exists(filePath))
                    {
                        System.IO.File.WriteAllText(filePath, "Tarih,Baslik,Icerik\n");
                    }

                    // Satırı ekle
                    System.IO.File.AppendAllText(filePath, line + Environment.NewLine);
                }
                catch (Exception ex)
                {
                    lblDurum.Text = $"❌ Duyuru RAM'de kaydedildi ancak dosyaya yazılırken hata oluştu: {ex.Message}";
                    lblDurum.ForeColor = System.Drawing.Color.OrangeRed;
                    return;
                }

                lblDurum.Text = "✅ Duyuru başarıyla kaydedildi.";
                lblDurum.ForeColor = System.Drawing.Color.Green;
                txtBaslık.Text = "";
                txtIcerik.Text = "";
            }
            else
            {
                lblDurum.Text = "❗ Lütfen başlık ve içerik giriniz.";
                lblDurum.ForeColor = System.Drawing.Color.Red;
            }
        }
    }

    }


