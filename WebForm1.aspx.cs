using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        // İhbar sınıfı
        public class Ihbar
        {
            public string Tur { get; set; }
            public string Konum { get; set; }
            public int Oncelik { get; set; }

            public Ihbar(string tur, string konum)
            {
                Tur = tur;
                Konum = konum;
                Oncelik = GetOncelikFromTur(tur); // Türüne göre öncelik belirle
            }

            // Türlere göre öncelik sıralaması yap
            private int GetOncelikFromTur(string tur)
            {
                switch (tur)
                {
                    case "Deprem": return 5;
                    case "Yangın": return 4;
                    case "Sel": return 3;
                    case "Heyelan": return 2;
                    case "Trafik Kazası": return 1;
                    default: return 0;
                }
            }

            // İhbar bilgilerini string olarak döndür
            public override string ToString()
            {
                return $"{Tur} - {Konum} (Öncelik: {Oncelik})";
            }
        }

        // Heap yapısı
        public class AcilDurumHeap
        {
            private List<Ihbar> heap = new List<Ihbar>();

            // Yeni ihbar ekleme
            public void Ekle(Ihbar ihbar)
            {
                heap.Add(ihbar);
                YukariTasima(heap.Count - 1);
            }

            // Yukarıya doğru sıralama yaparak yerleştirme
            private void YukariTasima(int index)
            {
                while (index > 0)
                {
                    int parent = (index - 1) / 2;
                    if (heap[index].Oncelik <= heap[parent].Oncelik) break;

                    (heap[index], heap[parent]) = (heap[parent], heap[index]);
                    index = parent;
                }
            }
            public Ihbar Cikar()
            {
                if (heap.Count == 0)
                    return null;

                Ihbar enUst = heap[0];
                heap[0] = heap[heap.Count - 1];
                heap.RemoveAt(heap.Count - 1);
                AsagiTasima(0);
                return enUst;
            }


            // En yüksek öncelikli öğeyi al
            public Ihbar EnYuksekOncelikliIhbarAl()
            {
                if (heap.Count == 0)
                    return null; // Eğer heap boşsa, null döndür

                // En yüksek öncelikli öğe başta olacak
                Ihbar enYuksekIhbar = heap[0];

                // İlk öğeyi kaldır, son öğeyi al ve sıralama yap
                heap[0] = heap[heap.Count - 1];
                heap.RemoveAt(heap.Count - 1);
                AsagiTasima(0);

                return enYuksekIhbar;
            }

            // Aşağıya taşıma işlemi
            private void AsagiTasima(int index)
            {
                int leftChild = 2 * index + 1;
                int rightChild = 2 * index + 2;
                int largest = index;

                // Sol çocuk var ve sol çocuğun önceliği daha büyükse, yer değiştir
                if (leftChild < heap.Count && heap[leftChild].Oncelik > heap[largest].Oncelik)
                {
                    largest = leftChild;
                }

                // Sağ çocuk var ve sağ çocuğun önceliği daha büyükse, yer değiştir
                if (rightChild < heap.Count && heap[rightChild].Oncelik > heap[largest].Oncelik)
                {
                    largest = rightChild;
                }

                // Eğer en büyük öğe, mevcut öğeden farklıysa, yer değiştir ve tekrar aşağıya taşı
                if (largest != index)
                {
                    (heap[index], heap[largest]) = (heap[largest], heap[index]);
                    AsagiTasima(largest);  // Rekürsif olarak aşağıya taşıma işlemini devam ettir
                }
            }
            public List<Ihbar> TumunuListele()
            {
                return new List<Ihbar>(heap);
            }


        }



        // Sayfa yüklendiğinde heap yapısını oluştur
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Application["Heap"] == null)
            {
                Application["Heap"] = new AcilDurumHeap();
            }


        }

        // İhbar gönderildiğinde işlemleri yap
        protected void btnGonder_Click(object sender, EventArgs e)
        {
            string tur = ddlTur.SelectedValue;
            string konum = txtKonum.Text;

            if (string.IsNullOrWhiteSpace(konum))
            {
                lblSonuc.ForeColor = System.Drawing.Color.Red;
                lblSonuc.Text = "Lütfen konum bilgisi giriniz.";
                lblSonuc.Visible = true;
                return;
            }

            Ihbar yeniIhbar = new Ihbar(tur, konum);
            AcilDurumHeap heap = (AcilDurumHeap)Application["Heap"];

            heap.Ekle(yeniIhbar);
            lblSonuc.ForeColor = System.Drawing.Color.Green;
            lblSonuc.Text = "İhbar alındı: " + yeniIhbar.ToString();
            lblSonuc.Visible = true;
            txtKonum.Text = "";

            GuncelleIhbarListesi();


        }



        private const string EkipKodu = "1234";  // Kısa ve kolay bir kod

        // Ekip kodu doğrulama
        protected void btnKodGiris_Click(object sender, EventArgs e)
        {
            string girilenKod = txtKod.Text;

            if (girilenKod == EkipKodu)  // Kod doğruysa
            {
                Session["KodDogru"] = true;  // Doğruysa session'a kaydediyoruz
                lblKodSonuc.Text = "Kod doğru! İhbarlar şimdi görüntülenebilir.";
                lblKodSonuc.ForeColor = System.Drawing.Color.Green;
                lblKodSonuc.Visible = true;

                gelenIhbarlarPanel.Visible = true;

                // Gelen ihbarları göster
                GuncelleIhbarListesi();


            }
            else
            {
                lblKodSonuc.Text = "Yanlış kod. Lütfen tekrar deneyin.";
                lblKodSonuc.ForeColor = System.Drawing.Color.Red;
                lblKodSonuc.Visible = true;
            }
        }


        // İhbarları güncelleyen fonksiyon
        private void GuncelleIhbarListesi()
        {

            /*if (Session["KodDogru"] != null && (bool)Session["KodDogru"])  // Kod doğrulandıysa
            {*/
            AcilDurumHeap heap = (AcilDurumHeap)Application["Heap"];
            List<Ihbar> liste = heap.TumunuListele();

            List<Ihbar> geciciListe = new List<Ihbar>();
            AcilDurumHeap geciciHeap = new AcilDurumHeap();

            // Mevcut heap'teki tüm elemanları geçici heap'e kopyala
            foreach (var ihbar in heap.TumunuListele())
            {
                geciciHeap.Ekle(ihbar);
            }

            // Geçici heap'ten sırayla çıkararak öncelikli listeyi oluştur
            Ihbar cikan;
            while ((cikan = geciciHeap.Cikar()) != null)
            {
                geciciListe.Add(cikan);
            }

            string html = "<ul>";
            foreach (var ihbar in geciciListe)
            {
                html += $"<li>{ihbar.Tur} - {ihbar.Konum} (Öncelik: {ihbar.Oncelik})</li>";
            }
            /* foreach (var ihbar in liste)
             {
                 html += $"<li>{ihbar.ToString()}</li>";
             }*/
            html += "</ul>";

            litListe.Text = html; // Literal kontrolüne yazdır
        }
        protected void btnCikar_Click(object sender, EventArgs e)
        {
            AcilDurumHeap heap = (AcilDurumHeap)Application["Heap"]; // ✅ Heap erişimi

            Ihbar cikarilan = heap.Cikar(); // Veya heap.EnYuksekOncelikliIhbarAl();

            if (cikarilan != null)
            {
                lblSonuc.Text = "Çıkarılan ihbar: " + cikarilan.ToString();
            }
            else
            {
                lblSonuc.Text = "Çıkarılacak ihbar kalmadı.";
            }

            GuncelleIhbarListesi(); // Listeyi güncelle
        }

    }


}

































/* // İhbar sınıfı
public class Ihbar
{
    public string Tur { get; set; }
    public string Konum { get; set; }
    public int Oncelik { get; set; }

    public Ihbar(string tur, string konum)
    {
        Tur = tur;
        Konum = konum;
        Oncelik = GetOncelikFromTur(tur);
    }

    private int GetOncelikFromTur(string tur)
    {
        switch (tur)
        {
            case "Yangın": return 1;
            case "Deprem": return 2;
            case "Sel": return 3;
            case "Trafik Kazası": return 4;
            default: return 0;
        }
    }

    public override string ToString()
    {
        return $"{Tur} - {Konum} (Öncelik: {Oncelik})";
    }
}

// Heap yapısı
public class AcilDurumHeap
{
    private List<Ihbar> heap = new List<Ihbar>();

    public void Ekle(Ihbar ihbar)
    {
        heap.Add(ihbar);
        YukariTasima(heap.Count - 1);
    }

    private void YukariTasima(int index)
    {
        while (index > 0)
        {
            int parent = (index - 1) / 2;
            if (heap[index].Oncelik <= heap[parent].Oncelik) break;

            (heap[index], heap[parent]) = (heap[parent], heap[index]);
            index = parent;
        }
    }

    public List<Ihbar> TumunuListele()
    {
        return new List<Ihbar>(heap);
    }
}

protected void Page_Load(object sender, EventArgs e)
{
    if (Application["Heap"] == null)
    {
        Application["Heap"] = new AcilDurumHeap();
    }
}

protected void btnGonder_Click(object sender, EventArgs e)
{
    string tur = ddlTur.SelectedValue;
    string konum = txtKonum.Text;

    if (string.IsNullOrWhiteSpace(konum))
    {
        lblSonuc.ForeColor = System.Drawing.Color.Red;
        lblSonuc.Text = "Konum boş olamaz.";
        return;
    }

    Ihbar yeniIhbar = new Ihbar(tur, konum);
    AcilDurumHeap heap = (AcilDurumHeap)Application["Heap"];
    heap.Ekle(yeniIhbar);

    lblSonuc.ForeColor = System.Drawing.Color.Green;
    lblSonuc.Text = "İhbar alındı: " + yeniIhbar.ToString();
    txtKonum.Text = "";
}
}

}*/
