using System;
using System.Collections;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication3
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        private static readonly Hashtable pharmacyStocks = Hashtable.Synchronized(new Hashtable()); // <eczaneAdı, Hashtable<ilacAdı, stok>>
        private static readonly Hashtable dutyPharmacies = Hashtable.Synchronized(new Hashtable()); // <eczaneAdı, bool>
        private const string PharmacistPassword = "eczane123";
        private string StockCsvFilePath;
        private string DutyCsvFilePath;


        protected void Page_Load(object sender, EventArgs e)
        {
            StockCsvFilePath = Server.MapPath("~/App_Data/duty_pharmacies.csv");
            DutyCsvFilePath = Server.MapPath("~/App_Data/pharmacy_stocks.csv");
            if (!IsPostBack)
            {
                UpdateDutyList();
                LoadStocksFromCsv();
                LoadDutyPharmaciesFromCsv();
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string name = txtPharmacyName.Text.Trim().ToLower();
            string pass = txtPassword.Text;

            if (name != "eren eczanesi" && name != "umut eczanesi" && name != "dilara eczanesi")
            {
                litLoginStatus.Text = "<div class='alert alert-danger'>❌ Sadece 'eren eczanesi', 'umut eczanesi' veya 'dilara eczanesi' giriş yapabilir.</div>";
                pnlPharmacist.Visible = false;
                return;
            }


            Session["CurrentPharmacy"] = name;

            lock (pharmacyStocks.SyncRoot)
            {
                if (!pharmacyStocks.ContainsKey(name))
                    pharmacyStocks[name] = Hashtable.Synchronized(new Hashtable());
            }

            pnlPharmacist.Visible = true;
            litLoginStatus.Text = $"<div class='alert alert-success'>✔ Hoş geldiniz, {name}!</div>";
            UpdateDutyList();
        }

        protected void btnUpdateStock_Click(object sender, EventArgs e)
        {
            string currentPharmacy = Session["CurrentPharmacy"] as string;
            if (string.IsNullOrEmpty(currentPharmacy))
            {
                litUpdateStatus.Text = "<div class='alert alert-danger'>❌ Lütfen önce giriş yapın.</div>";
                return;
            }

            string medicine = txtMedicineName.Text.Trim().ToLower();
            if (string.IsNullOrEmpty(medicine))
            {
                litUpdateStatus.Text = "<div class='alert alert-warning'>⚠ Lütfen bir ilaç adı girin.</div>";
                return;
            }

            if (!int.TryParse(txtStockCount.Text.Trim(), out int count))
            {
                litUpdateStatus.Text = "<div class='alert alert-warning'>⚠ Geçerli bir sayı girin.</div>";
                return;
            }

            lock (pharmacyStocks.SyncRoot)
            {
                Hashtable stockMap = (Hashtable)pharmacyStocks[currentPharmacy];
                if (stockMap == null)
                {
                    stockMap = Hashtable.Synchronized(new Hashtable());
                    pharmacyStocks[currentPharmacy] = stockMap;
                }

                int currentStock = stockMap.ContainsKey(medicine) ? (int)stockMap[medicine] : 0;
                int newStock = currentStock + count;

                if (newStock < 0)
                {
                    litUpdateStatus.Text = "<div class='alert alert-danger'>❌ Stok negatife düşemez.</div>";
                    return;
                }

                if (newStock == 0)
                    stockMap.Remove(medicine);
                else
                    stockMap[medicine] = newStock;

                litUpdateStatus.Text = $"<div class='alert alert-success'>✔ \"{medicine}\" stoğu: {newStock} adet.</div>";
                SaveStocksToCsv();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string medicine = txtSearchMedicine.Text.Trim().ToLower();
            if (string.IsNullOrEmpty(medicine))
            {
                litSearchResult.Text = "<div class='alert alert-warning'>⚠ Lütfen bir ilaç adı girin.</div>";
                return;
            }

            string result = $"🔍 \"{medicine}\" için sonuçlar:<ul class='list-group mt-2'>";
            bool found = false;

            lock (pharmacyStocks.SyncRoot)
            {
                foreach (DictionaryEntry entry in pharmacyStocks)
                {
                    string pharmacy = (string)entry.Key;
                    Hashtable stockMap = (Hashtable)entry.Value;

                    if (stockMap != null && stockMap.ContainsKey(medicine) && (int)stockMap[medicine] > 0)
                    {
                        found = true;
                        result += $"<li class='list-group-item'><strong>{pharmacy}</strong>: {stockMap[medicine]} adet</li>";
                    }
                }
            }

            result += "</ul>";
            litSearchResult.Text = found
                ? result
                : $"<div class='alert alert-info'>\"{medicine}\" hiçbir eczanede bulunamadı.</div>";
        }

        protected void btnToggleDuty_Click(object sender, EventArgs e)
        {
            string currentPharmacy = Session["CurrentPharmacy"] as string;
            if (string.IsNullOrEmpty(currentPharmacy))
            {
                litDutyStatus.Text = "<div class='alert alert-danger'>❌ Lütfen önce giriş yapın.</div>";
                return;
            }

            lock (dutyPharmacies.SyncRoot)
            {
                if (dutyPharmacies.ContainsKey(currentPharmacy))
                {
                    dutyPharmacies.Remove(currentPharmacy);
                    litDutyStatus.Text = "<div class='alert alert-warning'>⚠ Nöbetçi listesinden çıkarıldı.</div>";
                }
                else
                {
                    dutyPharmacies[currentPharmacy] = true;
                    litDutyStatus.Text = "<div class='alert alert-success'>✔ Nöbetçi eczanelere eklendi.</div>";
                }
            }

            SaveDutyPharmaciesToCsv();
            UpdateDutyList();
        }

        private void UpdateDutyList()
        {
            bltDutyPharmacies.Items.Clear();
            lock (dutyPharmacies.SyncRoot)
            {
                foreach (DictionaryEntry entry in dutyPharmacies)
                {
                    bltDutyPharmacies.Items.Add(entry.Key.ToString());
                }
            }
        }

        private void LoadStocksFromCsv()
        {
            if (File.Exists(StockCsvFilePath))
            {
                var lines = File.ReadAllLines(StockCsvFilePath);
                foreach (var line in lines)
                {
                    var parts = line.Split(',');
                    string pharmacyName = parts[0].Trim();
                    string medicineName = parts[1].Trim();
                    int stockCount = int.Parse(parts[2].Trim());

                    if (!pharmacyStocks.ContainsKey(pharmacyName))
                        pharmacyStocks[pharmacyName] = Hashtable.Synchronized(new Hashtable());

                    Hashtable stockMap = (Hashtable)pharmacyStocks[pharmacyName];
                    stockMap[medicineName] = stockCount;
                }
            }
        }

        private void SaveStocksToCsv()
        {
            // CSV dosyasını yazmaya açıyoruz. Var olan dosyayı silmek istemediğimiz için ikinci parametreyi true yapıyoruz.
            using (var writer = new StreamWriter(StockCsvFilePath, false))
            {
                lock (pharmacyStocks.SyncRoot)
                {
                    // Eczanelerin stoklarını yazıyoruz
                    foreach (DictionaryEntry entry in pharmacyStocks)
                    {
                        string pharmacyName = (string)entry.Key;
                        Hashtable stockMap = (Hashtable)entry.Value;

                        // Stokları yazıyoruz
                        foreach (DictionaryEntry stockEntry in stockMap)
                        {
                            string medicineName = (string)stockEntry.Key;
                            int stockCount = (int)stockEntry.Value;

                            // Eczane adı, ilaç adı ve stok miktarını CSV formatında yazıyoruz
                            writer.WriteLine($"{pharmacyName},{medicineName},{stockCount}");
                        }
                    }
                }
            }
        }


        private void LoadDutyPharmaciesFromCsv()
        {
            if (File.Exists(DutyCsvFilePath))
            {
                var lines = File.ReadAllLines(DutyCsvFilePath);
                foreach (var line in lines)
                {
                    string pharmacyName = line.Trim();
                    dutyPharmacies[pharmacyName] = true;
                }
            }
        }

        private void SaveDutyPharmaciesToCsv()
        {
            using (var writer = new StreamWriter(DutyCsvFilePath, false)) 
            {
                lock (dutyPharmacies.SyncRoot)
                {
                    foreach (DictionaryEntry entry in dutyPharmacies)
                    {
                        writer.WriteLine(entry.Key.ToString());
                    }
                }
            }
        }
    }
}
