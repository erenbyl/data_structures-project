using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;

namespace WebApplication3
{
    public partial class PersonelGiris : System.Web.UI.Page
    {
        static Hashtable personelTablosu = new Hashtable();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // İlk yüklemede örnek personel ekleyelim
                if (personelTablosu.Count == 0)
                {
                    personelTablosu.Add("beyza", "5620");
                    personelTablosu.Add("Dilara", "6774");
                    personelTablosu.Add("Berra", "ayse123");
                    personelTablosu.Add("FurT", "2412");
                    personelTablosu.Add("Mertcan", "7555");
                    personelTablosu.Add("Kaan", "2657");
                }
            }
        }
        protected void btnGiris_Click(object sender, EventArgs e)
        {
            string kullaniciAdi = txtKullanici.Text.Trim();
            string sifre = txtSifre.Text.Trim();

            if (personelTablosu.ContainsKey(kullaniciAdi))
            {
                string kayitliSifre = (string)personelTablosu[kullaniciAdi];
                if (kayitliSifre == sifre)
                {
                    // Giriş başarılı → Session'a kaydet ve yönlendir
                    Session["GirisYapanPersonel"] = kullaniciAdi;
                    Response.Redirect("PersonelSayfası.aspx");
                }
                else
                {
                    // Şifre yanlış
                    Response.Write("<script>alert('Şifre yanlış!')</script>");
                }
            }
            else
            {
                // Kullanıcı adı yanlış
                Response.Write("<script>alert('Kullanıcı bulunamadı!')</script>");
            }

            // Burada gerçek doğrulama işlemi yapılabilir (şimdilik varsayalım doğru)
            if (!string.IsNullOrEmpty(kullaniciAdi))
            {
                // 🔐 Kullanıcıyı Session'da sakla
                Session["GirisYapanPersonel"] = kullaniciAdi;

                // ✅ PersonelSayfasi.aspx sayfasına yönlendir
               
            }

           
        }
    }
    }
