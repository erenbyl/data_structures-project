using System;
using System.Collections;
using System.Web.UI;

namespace WebApplication3
{
    public partial class DilekSikayet : System.Web.UI.Page
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
        }

        protected void btnGonder_Click(object sender, EventArgs e)
        {
            string dilek = txtDilek.Text.Trim();
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

        
    }
}
