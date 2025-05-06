using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using static WebApplication1.OtobusSorgula;

namespace WebApplication1
{
    public partial class TopluTasima : System.Web.UI.Page
    {
        //Düğümlerim için bir sınıf oluşturuyorum önce
        //Sonra kenarlar için bir sınıf oluşturuyorum
        //Ardından graf sınıfımda graf oluşturmak için gerekli fonksiyonları oluşturdum.
        class Dugum
        {
            public string Name { get; set; }
            public List<Kenar> komsuDuraklar { get; set; } = new List<Kenar>();
            //Constructor
            public Dugum(string name)
            {
                Name = name;
            }
        }

        class Kenar
        {
            public Dugum Sonraki { get; set; }
            public int MesafeKm { get; set; }
            //Consturctor
            public Kenar(Dugum sonraki, int mesafeKm)
            {
                Sonraki = sonraki;
                MesafeKm = mesafeKm;
            }
        }

        class OtobusHatti
        {
            public string HatAdi { get; set; }
            public List<string> Duraklar { get; set; }
            public int HizKmSaat { get; set; } // yeni özellik

            public OtobusHatti(string hatAdi, List<string> duraklar, int hizKmSaat)
            {
                HatAdi = hatAdi;
                Duraklar = duraklar;
                HizKmSaat = hizKmSaat;
            }
        }



        class Graf
        {
            public List<Dugum> komsuDuraklar { get; set; } = new List<Dugum>();
            public void DurakEkle(string name)
            {
                komsuDuraklar.Add(new Dugum(name));
            }
            //Yönsüz hat oluşturma fonksiyonu oluşturdum a<->b oldu yani
            public void HatOlustur(string from, string to, int weight)
            {
                Dugum fromNode = komsuDuraklar.Find(n => n.Name == from);
                Dugum toNode = komsuDuraklar.Find(n => n.Name == to);

                if (fromNode != null && toNode != null)
                {
                    // Eğer bağlantı zaten varsa tekrar ekleme
                    if (!fromNode.komsuDuraklar.Any(k => k.Sonraki == toNode))
                    {
                        fromNode.komsuDuraklar.Add(new Kenar(toNode, weight));
                    }
                    if (!toNode.komsuDuraklar.Any(k => k.Sonraki == fromNode))
                    {
                        toNode.komsuDuraklar.Add(new Kenar(fromNode, weight));
                    }
                }
            }
            public int MesafeHesapla(string durak1, string durak2)
            {
                Dugum d1 = komsuDuraklar.Find(d => d.Name == durak1);
                if (d1 == null) return int.MaxValue;

                var kenar = d1.komsuDuraklar.FirstOrDefault(k => k.Sonraki.Name == durak2);
                if (kenar != null)
                    return kenar.MesafeKm;
                else
                    return int.MaxValue; // bağlantı yoksa
            }



        }
        protected void Page_Load(object sender, EventArgs e)
        {
            Graf OtobusHattı = new Graf();
            //Tüm duraklar eklendi
            OtobusHattı.DurakEkle("Yurtlar Durağı");
            OtobusHattı.DurakEkle("Kütüphane Durağı");
            OtobusHattı.DurakEkle("Kampüs Durağı");
            OtobusHattı.DurakEkle("Metro Durağı");
            OtobusHattı.DurakEkle("Fakülte Durağı");
            OtobusHattı.DurakEkle("Hastane Durağı");
            OtobusHattı.DurakEkle("Eczane Durağı");
            //Tüm kenarlar ağırlıklarıyla beraber oluşturuldu
            OtobusHattı.HatOlustur("Yurtlar Durağı", "Kütüphane Durağı", 2);
            OtobusHattı.HatOlustur("Kütüphane Durağı", "Kampüs Durağı", 5);
            OtobusHattı.HatOlustur("Kütüphane Durağı", "Fakülte Durağı", 3);
            OtobusHattı.HatOlustur("Kampüs Durağı", "Metro Durağı", 7);
            OtobusHattı.HatOlustur("Fakülte Durağı", "Metro Durağı", 8);
            OtobusHattı.HatOlustur("Fakülte Durağı", "Hastane Durağı", 4);
            OtobusHattı.HatOlustur("Metro Durağı", "Hastane Durağı", 2);
            OtobusHattı.HatOlustur("Hastane Durağı", "Eczane Durağı", 1);

            // Otobus hatlari tanimlaniyor
            List<OtobusHatti> tumOtobusler = new List<OtobusHatti>();

            // Hat 1: Yurtlar -> Kütüphane -> Kampüs -> Metro
            OtobusHatti kirmizi_otobus = new OtobusHatti("Kırmızı", new List<string>
            {"Yurtlar Durağı","Kütüphane Durağı","Fakülte Durağı","Hastane Durağı", "Eczane Durağı"},40);
            tumOtobusler.Add(kirmizi_otobus);

            // Hat 2: Fakülte -> Hastane -> Eczane
            OtobusHatti mavi_otobus = new OtobusHatti("Mavi", new List<string>
            {"Yurtlar Durağı","Kütüphane Durağı","Kampüs Durağı","Metro Durağı","Hastane Durağı","Eczane Durağı"},30);
            tumOtobusler.Add(mavi_otobus);

            // Hat 2: Fakülte -> Hastane -> Eczane
            OtobusHatti yesil_otobus = new OtobusHatti("Yeşil", new List<string>
            {"Kütüphane Durağı","Kampüs Durağı","Metro Durağı","Fakütle Durağı"},35);
            tumOtobusler.Add(yesil_otobus);




        }

        protected void btnSorgula_Click(object sender, EventArgs e)
        {
            // Graf'ı oluştur
            Graf otobusHattiGraf = new Graf();
            otobusHattiGraf.DurakEkle("Yurtlar Durağı");
            otobusHattiGraf.DurakEkle("Kütüphane Durağı");
            otobusHattiGraf.DurakEkle("Kampüs Durağı");
            otobusHattiGraf.DurakEkle("Metro Durağı");
            otobusHattiGraf.DurakEkle("Fakülte Durağı");
            otobusHattiGraf.DurakEkle("Hastane Durağı");
            otobusHattiGraf.DurakEkle("Eczane Durağı");

            otobusHattiGraf.HatOlustur("Yurtlar Durağı", "Kütüphane Durağı", 2);
            otobusHattiGraf.HatOlustur("Kütüphane Durağı", "Kampüs Durağı", 5);
            otobusHattiGraf.HatOlustur("Kütüphane Durağı", "Fakülte Durağı", 3);
            otobusHattiGraf.HatOlustur("Kampüs Durağı", "Metro Durağı", 7);
            otobusHattiGraf.HatOlustur("Fakülte Durağı", "Metro Durağı", 8);
            otobusHattiGraf.HatOlustur("Fakülte Durağı", "Hastane Durağı", 4);
            otobusHattiGraf.HatOlustur("Metro Durağı", "Hastane Durağı", 2);
            otobusHattiGraf.HatOlustur("Hastane Durağı", "Eczane Durağı", 1);
            string nereden = ddlNereden.SelectedValue;
            string nereye = ddlNereye.SelectedValue;

            if (nereden == nereye)
            {
                lblSonuc.Text = "Zaten aynı duraktasınız.";
                return;
            }


            // Otobüs hatlarını hızla birlikte tanımla
            List<OtobusHatti> tumOtobusler = new List<OtobusHatti>
            {
            new OtobusHatti("Kırmızı", new List<string> { "Yurtlar Durağı", "Kütüphane Durağı", "Fakülte Durağı", "Hastane Durağı", "Eczane Durağı" }, 40),
            new OtobusHatti("Mavi", new List<string> { "Yurtlar Durağı", "Kütüphane Durağı", "Kampüs Durağı", "Metro Durağı", "Hastane Durağı", "Eczane Durağı" }, 30),
            new OtobusHatti("Yeşil", new List<string> { "Kütüphane Durağı", "Kampüs Durağı", "Metro Durağı", "Fakülte Durağı" }, 35)
            };

            bool bulundu = false;
            string sonuc = "";

            foreach (var otobus in tumOtobusler)
            {
                if (otobus.Duraklar.Contains(nereden) && otobus.Duraklar.Contains(nereye))
                {
                    int i1 = otobus.Duraklar.IndexOf(nereden);
                    int i2 = otobus.Duraklar.IndexOf(nereye);

                    if (i1 > i2) // tersse sırayı çevir
                    {
                        int temp = i1;
                        i1 = i2;
                        i2 = temp;
                    }

                    int toplamMesafe = 0;

                    for (int i = i1; i < i2; i++)
                    {
                        string durakA = otobus.Duraklar[i];
                        string durakB = otobus.Duraklar[i + 1];
                        int mesafe = otobusHattiGraf.MesafeHesapla(durakA, durakB);
                        if (mesafe != int.MaxValue)
                            toplamMesafe += mesafe;
                    }

                    
                    double sureDakika = (double)toplamMesafe / otobus.HizKmSaat * 60 ;

                    sonuc += $"🚌 <span style='color:{otobus.HatAdi.ToLower()}'>{otobus.HatAdi} otobüs</span> ile tahmini süre: <b>{sureDakika:F1} dakika</b><br />";
                    bulundu = true;
                }
            }

            lblSonuc.Text = bulundu ? sonuc : "Doğrudan giden bir otobüs hattı bulunamadı.";

        }




    }
}