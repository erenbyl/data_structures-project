using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using System.Diagnostics;

namespace WebApplication3
{
    public partial class TopluTasima : System.Web.UI.Page
    {
        private Graf graf;

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
                    foreach (var dugum in dugumler)
                    {
                        dugum.Ziyaret = false;
                        dugum.Mesafe = int.MaxValue;
                        dugum.Onceki = null;
                    }

                    var baslangic = dugumler.Find(d => d.Name == baslangicDuragi);
                    if (baslangic == null)
                        return null;
                    baslangic.Mesafe = 0;

                    var hedef = dugumler.Find(d => d.Name == hedefDuragi);
                    if (hedef == null)
                        return null;

                    var kuyruk = new List<Dugum>();
                    kuyruk.Add(baslangic);

                    while (kuyruk.Count > 0)
                    {
                        var guncel = kuyruk.OrderBy(d => d.Mesafe).First();
                        kuyruk.Remove(guncel);

                        if (guncel == hedef)
                            break;

                        guncel.Ziyaret = true;

                        foreach (var kenar in guncel.komsuDuraklar)
                        {
                            var komsu = kenar.Sonraki;
                            if (komsu.Ziyaret)
                                continue;

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

                    if (hedef.Onceki == null && hedef != baslangic)
                        return null;

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

        private Graf VarsayilanGrafOlustur()
        {
            try
            {
                var g = new Graf();

                foreach (var d in TumDuraklar)
                    g.DurakEkle(d);

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

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (graf == null)
                {
                    graf = VarsayilanGrafOlustur();
                }

                if (!IsPostBack)
                {
                    ddlNereden.DataSource = TumDuraklar;
                    ddlNereye.DataSource = TumDuraklar;
                    ddlNereden.DataBind();
                    ddlNereye.DataBind();

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

        protected void btnSorgula_Click(object sender, EventArgs e)
        {
            lblSonuc.Visible = true;

            string nereden = ddlNereden.SelectedValue;
            string nereye = ddlNereye.SelectedValue;

            if (ddlNereden.SelectedItem.Text == "Seçiniz" || ddlNereye.SelectedItem.Text == "Seçiniz")
            {
                lblSonuc.Text = "Lütfen hem başlangıç hem de hedef durak seçiniz.";
                return;
            }

            if (nereden == nereye)
            {
                lblSonuc.Text = "Başlangıç ve varış durakları aynı olamaz.";
                return;
            }

            var yolSonucu = graf.EnKisaYoluBul(nereden, nereye);
            if (yolSonucu == null)
            {
                lblSonuc.Text = "Ulaşım yolu bulunamadı.";
                return;
            }

            var yol = yolSonucu.Item1;
            int toplamMesafe = yolSonucu.Item2;

            string rota = string.Join(" → ", yol);

            lblSonuc.Text = $"Seçilen rota: <strong>{rota}</strong><br/>" +
                            $"Toplam mesafe: <strong>{toplamMesafe} km</strong><br/>";
        }


        private OtobusHatti OtobusHatlariArasiTekHatKontrolu(string baslangic, string hedef, List<string> yol)
        {
            try
            {
                foreach (var hat in OtobusHatlari)
                {
                    if (!hat.Duraklar.Contains(baslangic) || !hat.Duraklar.Contains(hedef))
                        continue;

                    int baslangicIndex = hat.Duraklar.IndexOf(baslangic);
                    int hedefIndex = hat.Duraklar.IndexOf(hedef);

                    bool dogruYon = true;

                    if (baslangicIndex < hedefIndex)
                    {
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
        private void RotayiHesaplaVeGoster(string baslangic, string hedef, List<string> yol)
        {
            try
            {
                var rotaSegmentleri = new List<RotaSegmenti>();

                for (int i = 0; i < yol.Count - 1; i++)
                {
                    string nereden = yol[i];
                    string nereye = yol[i + 1];

                    var uygunHat = OtobusHatlari
                        .Where(h => h.Duraklar.Contains(nereden) && h.Duraklar.Contains(nereye))
                        .FirstOrDefault(h =>
                        {
                            int idx1 = h.Duraklar.IndexOf(nereden);
                            int idx2 = h.Duraklar.IndexOf(nereye);
                            return Math.Abs(idx1 - idx2) == 1;
                        });

                    string hat = uygunHat?.HatAdi ?? "Bilinmiyor";

                    var d1 = graf.dugumler.Find(d => d.Name == nereden);
                    if (d1 == null) continue;

                    var komsuKenar = d1.komsuDuraklar.FirstOrDefault(k => k.Sonraki.Name == nereye);
                    if (komsuKenar == null) continue;

                    var mesafeKm = komsuKenar.MesafeKm;

                    int hiz = uygunHat?.HizKmSaat ?? 60; // Varsayılan 60 km/saat
                    var sure = (double)mesafeKm / hiz * 60;

                    rotaSegmentleri.Add(new RotaSegmenti(nereden, nereye, hat, mesafeKm, sure));
                }

                string sonuc = "";
                double toplamSure = 0;
                double toplamMesafe = 0;
                string oncekiHat = "";

                foreach (var segment in rotaSegmentleri)
                {
                    if (oncekiHat != "" && segment.Hat != oncekiHat)
                    {
                        toplamSure += AKTARMA_SURESI;
                        sonuc += $"🔁 Aktarma süresi: {AKTARMA_SURESI} dakika<br/>";
                    }

                    sonuc += $"🚍 <b>{segment.Hat}</b> ile <b>{segment.Nereden}</b> → <b>{segment.Nereye}</b> ({segment.Mesafe} km - {Math.Round(segment.Sure)} dk)<br/>";

                    toplamSure += segment.Sure;
                    toplamMesafe += segment.Mesafe;
                    oncekiHat = segment.Hat;
                }

                sonuc += $"<br/>🛣 Toplam mesafe: <b>{toplamMesafe} km</b><br/>" +
                          $"⏱ Tahmini süre: <b>{Math.Round(toplamSure)} dakika</b>";

                lblSonuc.Text = sonuc;
            }
            catch (Exception ex)
            {
                lblSonuc.Text = $"❌ Rota hesaplama hatası: {ex.Message}";
                Debug.WriteLine($"RotayiHesaplaVeGoster hatası: {ex.Message}");
            }
        }
    }
    }
