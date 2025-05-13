using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using System.Diagnostics;

namespace WebApplication3
{
    /// Toplu taşıma rotalarını hesaplama ve gösterme
    public partial class TopluTasima : System.Web.UI.Page
    {
        // Graf değişkeni sınıf seviyesinde tanımlanmalı
        private Graf graf;

        // Aktarmada bekleme süresi (dakika)
        private const int AKTARMA_SURESI = 5;

        /// Graf yapısındaki düğüm sınıfı - durakları temsil eder
        class Dugum
        {
            public string Name { get; set; }
            public List<Kenar> komsuDuraklar { get; set; } = new List<Kenar>();
            public bool Ziyaret { get; set; } = false;
            public int Mesafe { get; set; } = int.MaxValue;
            public Dugum Onceki { get; set; } = null;
            public Dugum(string name) { Name = name; }

            public override string ToString()
            {
                return Name;
            }
        }

        /// Graf yapısındaki kenar sınıfı - duraklar arası bağlantıları temsil eder
        class Kenar
        {
            public Dugum Sonraki { get; set; }
            public int MesafeKm { get; set; }
            public Kenar(Dugum sonraki, int mesafeKm) { Sonraki = sonraki; MesafeKm = mesafeKm; }
        }

        /// Otobüs hattı bilgilerini tutan sınıf
        class OtobusHatti
        {
            public string HatAdi { get; set; }
            public List<string> Duraklar { get; set; }
            public int HizKmSaat { get; set; }

            public OtobusHatti(string hatAdi, List<string> duraklar, int hizKmSaat)
            {
                HatAdi = hatAdi;
                Duraklar = duraklar;
                HizKmSaat = hizKmSaat;
            }

            public override string ToString()
            {
                return HatAdi;
            }
        }

        /// Duraklar arası rota segmenti
        class RotaSegmenti
        {
            public string Nereden { get; set; }
            public string Nereye { get; set; }
            public string Hat { get; set; }
            public double Mesafe { get; set; }
            public double Sure { get; set; }

            public RotaSegmenti(string nereden, string nereye, string hat, double mesafe, double sure)
            {
                Nereden = nereden;
                Nereye = nereye;
                Hat = hat;
                Mesafe = mesafe;
                Sure = sure;
            }
        }

        /// Graf yapısı - duraklar ve aralarındaki bağlantıları temsil eder
        class Graf
        {
            public List<Dugum> dugumler = new List<Dugum>();

            /// Grafa yeni durak ekler
            public void DurakEkle(string name)
            {
                if (string.IsNullOrEmpty(name))
                    throw new ArgumentNullException("Durak adı boş olamaz");

                if (!dugumler.Any(d => d.Name == name))
                    dugumler.Add(new Dugum(name));
            }

            /// İki durak arasında hat oluşturur (çift yönlü bağlantı)
            public void HatOlustur(string from, string to, int mesafe)
            {
                if (string.IsNullOrEmpty(from) || string.IsNullOrEmpty(to))
                    throw new ArgumentNullException("Durak adları boş olamaz");

                if (mesafe <= 0)
                    throw new ArgumentException("Mesafe pozitif bir değer olmalıdır");

                var d1 = dugumler.Find(d => d.Name == from);
                var d2 = dugumler.Find(d => d.Name == to);

                if (d1 == null)
                    throw new ArgumentException($"Durak bulunamadı: {from}");
                if (d2 == null)
                    throw new ArgumentException($"Durak bulunamadı: {to}");

                if (!d1.komsuDuraklar.Any(k => k.Sonraki == d2))
                    d1.komsuDuraklar.Add(new Kenar(d2, mesafe));
                if (!d2.komsuDuraklar.Any(k => k.Sonraki == d1))
                    d2.komsuDuraklar.Add(new Kenar(d1, mesafe));
            }

            /// Dijkstra algoritması ile iki durak arasındaki en kısa yolu bulur
            public Tuple<List<string>, int> EnKisaYoluBul(string baslangicDuragi, string hedefDuragi)
            {
                try
                {
                    // Düğümleri sıfırla
                    foreach (var dugum in dugumler)
                    {
                        dugum.Ziyaret = false;
                        dugum.Mesafe = int.MaxValue;
                        dugum.Onceki = null;
                    }

                    // Başlangıç düğümünü al
                    var baslangic = dugumler.Find(d => d.Name == baslangicDuragi);
                    if (baslangic == null)
                        return null;
                    baslangic.Mesafe = 0;

                    // Hedef düğümü al
                    var hedef = dugumler.Find(d => d.Name == hedefDuragi);
                    if (hedef == null)
                        return null;

                    // Öncelikli kuyruk (PriorityQueue) kullanımı ile optimizasyon
                    var kuyruk = new List<Dugum>();
                    kuyruk.Add(baslangic);

                    while (kuyruk.Count > 0)
                    {
                        // En küçük mesafeye sahip düğümü bul ve çıkar
                        var guncel = kuyruk.OrderBy(d => d.Mesafe).First();
                        kuyruk.Remove(guncel);

                        // Hedef bulunduğunda sonlandır
                        if (guncel == hedef)
                            break;

                        guncel.Ziyaret = true;

                        // Komşu düğümleri gez
                        foreach (var kenar in guncel.komsuDuraklar)
                        {
                            var komsu = kenar.Sonraki;
                            if (komsu.Ziyaret)
                                continue;

                            // Yeni mesafeyi hesapla
                            int yeniMesafe = guncel.Mesafe + kenar.MesafeKm;
                            if (yeniMesafe < komsu.Mesafe)
                            {
                                komsu.Mesafe = yeniMesafe;
                                komsu.Onceki = guncel;

                                if (!kuyruk.Contains(komsu))
                                    kuyruk.Add(komsu);
                            }
                        }
                    }

                    // Hedef düğüme ulaşılamadıysa null döndür
                    if (hedef.Onceki == null && hedef != baslangic)
                        return null;

                    // Yolu oluştur
                    var yol = new List<string>();
                    var current = hedef;
                    while (current != null)
                    {
                        yol.Insert(0, current.Name);
                        current = current.Onceki;
                    }

                    return new Tuple<List<string>, int>(yol, hedef.Mesafe);
                }
                catch (Exception ex)
                {
                    Debug.WriteLine($"EnKisaYoluBul hatası: {ex.Message}");
                    return null;
                }
            }
        }

        /// Sistemdeki otobüs hatları
        static List<OtobusHatti> OtobusHatlari = new List<OtobusHatti>
        {
            new OtobusHatti("Kırmızı", new List<string>{ "Hastane Durağı", "Okul Durağı", "Park Durağı", "Belediye Durağı", "Veteriner Durağı"}, 60),
            new OtobusHatti("Mavi", new List<string>{ "Park Durağı", "Stadyum Durağı", "Market Durağı", "Belediye Durağı"}, 53),
            new OtobusHatti("Yeşil", new List<string>{ "Stadyum Durağı", "Market Durağı", "Belediye Durağı", "Veteriner Durağı" }, 61)
        };

        /// Sistemdeki tüm duraklar
        static string[] TumDuraklar = {
            "Hastane Durağı", "Okul Durağı", "Park Durağı",
            "Stadyum Durağı", "Market Durağı", "Belediye Durağı", "Veteriner Durağı"
        };

        /// Varsayılan şehir grafını oluşturur
        private Graf VarsayilanGrafOlustur()
        {
            try
            {
                var g = new Graf();

                // Tüm durakları ekle
                foreach (var d in TumDuraklar)
                    g.DurakEkle(d);

                // Duraklar arası bağlantıları tanımla (km cinsinden)
                g.HatOlustur("Hastane Durağı", "Okul Durağı", 3);
                g.HatOlustur("Okul Durağı", "Park Durağı", 5);
                g.HatOlustur("Park Durağı", "Stadyum Durağı", 10);
                g.HatOlustur("Stadyum Durağı", "Market Durağı", 12);
                g.HatOlustur("Market Durağı", "Belediye Durağı", 9);
                g.HatOlustur("Belediye Durağı", "Veteriner Durağı", 2);
                g.HatOlustur("Belediye Durağı", "Park Durağı", 7);

                return g;
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"Graf oluşturma hatası: {ex.Message}");
                throw;
            }
        }

        /// Sayfa yüklendiğinde çalışan metot
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                // Graf'ı başlat
                if (graf == null)
                {
                    graf = VarsayilanGrafOlustur();
                }

                if (!IsPostBack)
                {
                    // Dropdown listelerini doldur
                    ddlNereden.DataSource = TumDuraklar;
                    ddlNereye.DataSource = TumDuraklar;
                    ddlNereden.DataBind();
                    ddlNereye.DataBind();

                    // "Seçiniz" seçeneği ekle
                    ddlNereden.Items.Insert(0, new ListItem("Seçiniz", ""));
                    ddlNereye.Items.Insert(0, new ListItem("Seçiniz", ""));
                }
            }
            catch (Exception ex)
            {
                lblSonuc.Text = $"Hata oluştu: {ex.Message}";
                Debug.WriteLine($"Page_Load hatası: {ex.Message}");
            }
        }

        /// Sorgula butonuna tıklandığında çalışan metot
        protected void btnSorgula_Click(object sender, EventArgs e)
        {
            try
            {
                // Seçilen durakları al
                string baslangic = ddlNereden.SelectedValue;
                string hedef = ddlNereye.SelectedValue;

                // Giriş doğrulama
                if (string.IsNullOrEmpty(baslangic) || string.IsNullOrEmpty(hedef))
                {
                    lblSonuc.Text = "⚠ Lütfen başlangıç ve hedef durak seçiniz.";
                    return;
                }

                if (baslangic == hedef)
                {
                    lblSonuc.Text = "⚠ Başlangıç ve hedef durak aynı olamaz.";
                    return;
                }

                // En kısa yolu bul
                var sonuc = graf.EnKisaYoluBul(baslangic, hedef);
                if (sonuc == null)
                {
                    lblSonuc.Text = "❌ İki durak arasında bir bağlantı bulunamadı.";
                    return;
                }

                var yol = sonuc.Item1;
                var toplamMesafe = sonuc.Item2;

                // Tek bir hatla bu rotayı gidebilir miyiz?
                var tekHat = OtobusHatlariArasiTekHatKontrolu(baslangic, hedef, yol);

                if (tekHat != null)
                {
                    // Tek hatla gidebiliyorsak
                    int sure = (int)Math.Round((double)toplamMesafe / tekHat.HizKmSaat * 60);
                    lblSonuc.Text = $"🚍 <b>{baslangic}</b> durağından <span style='color:{tekHat.HatAdi.ToLower()}'><b>{tekHat.HatAdi}</b></span> otobüsüne binin ve 🎯 <b>{hedef}</b> durağında inin.<br/>" +
                                    $"🛣 Mesafe: <b>{toplamMesafe} km</b><br/>" +
                                    $"⏱ Tahmini süre: <b>{sure} dakika</b>";
                }
                else
                {
                    // Birden fazla hat gerektiren rota hesapla
                    RotayiHesaplaVeGoster(baslangic, hedef, yol);
                }
            }
            catch (Exception ex)
            {
                lblSonuc.Text = $"❌ Bir hata oluştu: {ex.Message}";
                Debug.WriteLine($"btnSorgula_Click hatası: {ex.Message}");
            }
        }

        /// Verilen yol için tek bir otobüs hattı yeterli mi kontrol eder
        private OtobusHatti OtobusHatlariArasiTekHatKontrolu(string baslangic, string hedef, List<string> yol)
        {
            try
            {
                foreach (var hat in OtobusHatlari)
                {
                    // Her iki durak da bu hatta var mı?
                    if (!hat.Duraklar.Contains(baslangic) || !hat.Duraklar.Contains(hedef))
                        continue;

                    // İndekslerini al
                    int baslangicIndex = hat.Duraklar.IndexOf(baslangic);
                    int hedefIndex = hat.Duraklar.IndexOf(hedef);

                    // İndeksler arasında doğru yön kontrolü
                    bool dogruYon = true;

                    if (baslangicIndex < hedefIndex)
                    {
                        // İleriye doğru kontrol
                        for (int i = baslangicIndex; i <= hedefIndex; i++)
                        {
                            if (!yol.Contains(hat.Duraklar[i]))
                            {
                                dogruYon = false;
                                break;
                            }
                        }
                    }
                    else
                    {
                        // Geriye doğru kontrol
                        for (int i = baslangicIndex; i >= hedefIndex; i--)
                        {
                            if (!yol.Contains(hat.Duraklar[i]))
                            {
                                dogruYon = false;
                                break;
                            }
                        }
                    }

                    if (dogruYon)
                        return hat;
                }

                return null;
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"OtobusHatlariArasiTekHatKontrolu hatası: {ex.Message}");
                return null;
            }
        }

        /// Aktarma gerektiren bir rotayı hesaplar ve gösterir

        private void RotayiHesaplaVeGoster(string baslangic, string hedef, List<string> yol)
        {
            try
            {
                // Rotayı segmentlere ayır
                var rotaSegmentleri = new List<RotaSegmenti>();

                for (int i = 0; i < yol.Count - 1; i++)
                {
                    string nereden = yol[i];
                    string nereye = yol[i + 1];

                    // Bu iki durak arasında hangi hat var?
                    var uygunHat = OtobusHatlari
                        .Where(h => h.Duraklar.Contains(nereden) && h.Duraklar.Contains(nereye))
                        .FirstOrDefault(h =>
                        {
                            int idx1 = h.Duraklar.IndexOf(nereden);
                            int idx2 = h.Duraklar.IndexOf(nereye);
                            return Math.Abs(idx1 - idx2) == 1;
                        });

                    string hat = uygunHat?.HatAdi ?? "Bilinmiyor";

                    // Mesafeyi bul
                    var d1 = graf.dugumler.Find(d => d.Name == nereden);
                    if (d1 == null) continue;

                    var komsuKenar = d1.komsuDuraklar.FirstOrDefault(k => k.Sonraki.Name == nereye);
                    if (komsuKenar == null) continue;

                    var mesafeKm = komsuKenar.MesafeKm;

                    // Hızı bul ve süreyi hesapla
                    int hiz = uygunHat?.HizKmSaat ?? 60; // Varsayılan 60 km/saat
                    var sure = (double)mesafeKm / hiz * 60;

                    rotaSegmentleri.Add(new RotaSegmenti(nereden, nereye, hat, mesafeKm, sure));
                }

                // Hat değişimi sayısını belirle
                var hatlar = rotaSegmentleri.Select(r => r.Hat).Distinct().ToList();

                string mesaj;
                if (hatlar.Count > 1)
                {
                    mesaj = "⚠ Bu iki durak arasında direkt bir otobüs hattı yok. Aktarma yapmanız gerekiyor.<br/><br/>";
                }
                else if (hatlar.Count == 1 && hatlar[0] != "Bilinmiyor")
                {

                    double mesafe = rotaSegmentleri.Sum(r => r.Mesafe);
                    int sure = (int)Math.Round(rotaSegmentleri.Sum(r => r.Sure));

                    lblSonuc.Text = $"🚍 <b>{baslangic}</b> durağından <span style='color:{hatlar[0].ToLower()}'><b>{hatlar[0]}</b></span> otobüsüne binin ve 🎯 <b>{hedef}</b> durağında inin.<br/>" +
                                   $"🛣 Mesafe: <b>{mesafe:F1} km</b><br/>" +
                                   $"⏱ Tahmini süre: <b>{sure} dakika</b>";
                    return;
                }
                else
                {
                    mesaj = "🚌 Rotanız hesaplandı:<br/><br/>";
                }

                // Aktarma noktalarını belirle ve mesajı oluştur
                string oncekiHat = null;
                string neredenDuragi = rotaSegmentleri.Count > 0 ? rotaSegmentleri[0].Nereden : baslangic;
                double toplamSure = 0;
                double toplamMesafeAktarma = 0;
                int aktarmaSayisi = 0;

                foreach (var segment in rotaSegmentleri)
                {
                    toplamMesafeAktarma += segment.Mesafe;
                    toplamSure += segment.Sure;

                    if (segment.Hat != oncekiHat)
                    {
                        if (oncekiHat != null)
                        {
                            // Aktarma süresi ekle
                            toplamSure += AKTARMA_SURESI;
                            aktarmaSayisi++;
                            mesaj += $"🛑 <b>{neredenDuragi}</b> durağında inin ve <span style='color:{segment.Hat.ToLower()}'><b>{segment.Hat}</b></span> otobüsüne binin. ({AKTARMA_SURESI} dk aktarma süresi)<br/>";
                        }
                        else
                        {
                            mesaj += $"🚏 <b>{segment.Nereden}</b> durağından <span style='color:{segment.Hat.ToLower()}'><b>{segment.Hat}</b></span> otobüsüne binin.<br/>";
                        }
                    }

                    oncekiHat = segment.Hat;
                    neredenDuragi = segment.Nereye;
                }

                mesaj += $"🎯 <b>{hedef}</b> durağında inerek hedefe ulaşırsınız.<br/><br/>";
                mesaj += $"🛣 Toplam mesafe: <b>{toplamMesafeAktarma:F1} km</b><br/>";
                mesaj += $"⏱ Tahmini süre: <b>{(int)Math.Round(toplamSure)} dakika</b> ({aktarmaSayisi} aktarma)";

                lblSonuc.Text = mesaj;
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"RotayiHesaplaVeGoster hatası: {ex.Message}");
                throw;
            }
        }
    }
}