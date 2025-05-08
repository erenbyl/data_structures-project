using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication3
{
    public partial class AcilDurum : System.Web.UI.Page
    {
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
                    case "Deprem": return 5;
                    case "Yangın": return 4;
                    case "Sel": return 3;
                    case "Heyelan": return 2;
                    case "Trafik Kazası": return 1;
                    default: return 0;
                }
            }


            public override string ToString()
            {
                return $"{Tur} - {Konum} (Öncelik: {Oncelik})";
            }
        }


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



            /*public Ihbar EnYuksekOncelikliIhbarAl()
            {
                if (heap.Count == 0)
                    return null;
                
                
                Ihbar enYuksekIhbar = heap[0];

                
                heap[0] = heap[heap.Count - 1];
                heap.RemoveAt(heap.Count - 1);
                AsagiTasima(0);

                return enYuksekIhbar;
            }*/


            private void AsagiTasima(int index)
            {
                int leftChild = 2 * index + 1;
                int rightChild = 2 * index + 2;
                int largest = index;


                if (leftChild < heap.Count && heap[leftChild].Oncelik > heap[largest].Oncelik)
                {
                    largest = leftChild;
                }


                if (rightChild < heap.Count && heap[rightChild].Oncelik > heap[largest].Oncelik)
                {
                    largest = rightChild;
                }


                if (largest != index)
                {
                    (heap[index], heap[largest]) = (heap[largest], heap[index]);
                    AsagiTasima(largest);
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
            string konum = ddlKonum.SelectedValue;



            Ihbar yeniIhbar = new Ihbar(tur, konum);
            AcilDurumHeap heap = (AcilDurumHeap)Application["Heap"];

            heap.Ekle(yeniIhbar);
            lblSonuc.ForeColor = System.Drawing.Color.Green;
            lblSonuc.Text = "İhbar alındı: " + yeniIhbar.ToString();
            lblSonuc.Visible = true;



            GuncelleIhbarListesi();


        }



        private const string EkipKodu = "1234";


        protected void btnKodGiris_Click(object sender, EventArgs e)
        {
            string girilenKod = txtKod.Text;

            if (girilenKod == EkipKodu)
            {
                Session["KodDogru"] = true;
                lblKodSonuc.Text = "Kod doğru! İhbarlar şimdi görüntülenebilir.";
                lblKodSonuc.ForeColor = System.Drawing.Color.Green;
                lblKodSonuc.Visible = true;

                gelenIhbarlarPanel.Visible = true;


                GuncelleIhbarListesi();


            }
            else
            {
                lblKodSonuc.Text = "Yanlış kod. Lütfen tekrar deneyin.";
                lblKodSonuc.ForeColor = System.Drawing.Color.Red;
                lblKodSonuc.Visible = true;
            }
        }



        private void GuncelleIhbarListesi()
        {


            AcilDurumHeap heap = (AcilDurumHeap)Application["Heap"];
            List<Ihbar> liste = heap.TumunuListele();

            List<Ihbar> geciciListe = new List<Ihbar>();
            AcilDurumHeap geciciHeap = new AcilDurumHeap();

            foreach (var ihbar in heap.TumunuListele())
            {
                geciciHeap.Ekle(ihbar);
            }

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

            html += "</ul>";

            litListe.Text = html;
        }
        protected void btnCikar_Click(object sender, EventArgs e)
        {
            AcilDurumHeap heap = (AcilDurumHeap)Application["Heap"];

            Ihbar cikarilan = heap.Cikar();

            if (cikarilan != null)
            {
                lblSonuc.Text = "Çıkarılan ihbar: " + cikarilan.ToString();
            }
            else
            {
                lblSonuc.Text = "Çıkarılacak ihbar kalmadı.";
            }

            GuncelleIhbarListesi();
        }
    }
}