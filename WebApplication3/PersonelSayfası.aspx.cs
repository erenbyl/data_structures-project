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
                // Uygulama genelinde saklanan duyuru listesi
                Hashtable duyurular = Application["Duyurular"] as Hashtable;
                if (duyurular == null)
                    duyurular = new Hashtable();

                string duyuruMetni = "📌 <b>" + baslik + "</b><br/>" + icerik;
                string anahtar = "duyuru_" + DateTime.Now.Ticks;

                duyurular[anahtar] = duyuruMetni;
                Application["Duyurular"] = duyurular;

                lblDurum.Text = "✅ Duyuru başarıyla kaydedildi.";
                lblDurum.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                lblDurum.Text = "❗ Lütfen başlık ve içerik giriniz.";
                lblDurum.ForeColor = System.Drawing.Color.Red;
            }
        } }

    }


