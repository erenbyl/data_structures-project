<%@ Page Language="C#" AutoEventWireup="true" CodeFile="kitap_detay.aspx.cs" Inherits="WebApplication1.kitap_detay" %>

<!DOCTYPE html>
<html lang="tr">
<head>
  <meta charset="UTF-8">
  <title>Kitap Detay</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', 'Roboto', sans-serif;
      background: linear-gradient(135deg, #e0f7fa, #e1bee7);
    }

    .main-layout {
      display: flex;
      height: 100vh;
    }

    .left-sidebar {
      width: 250px;
      background-color: #fff;
      border-right: 1px solid #e0e0e0;
      box-shadow: 2px 0 5px rgba(0, 0, 0, 0.05);
      padding: 20px;
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    .left-sidebar img {
      width: 120px;
      height: auto;
      margin-bottom: 20px;
      border-radius: 10px;
    }

    .left-sidebar button {
      width: 100%;
      padding: 12px 10px;
      margin: 8px 0;
      background-color: #4a90e2;
      color: white;
      border: none;
      border-radius: 8px;
      font-size: 1rem;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    .left-sidebar button:hover {
      background-color: #3b7dd8;
    }

    .main-content {
      flex: 1;
      padding: 40px;
      overflow-y: auto;
    }

    .container {
      max-width: 900px;
      background: #fff;
      padding: 30px;
      border-radius: 15px;
      box-shadow: 0 6px 20px rgba(0,0,0,0.1);
      display: flex;
      flex-direction: column;
      gap: 30px;
    }

    .d-flex {
      display: flex;
      gap: 30px;
      align-items: flex-start;
    }

    img#kapakResmi {
      max-width: 280px;
      border-radius: 10px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    }

    #kitapBilgileri {
      flex: 1;
    }

    h2 {
      font-weight: 700;
      font-size: 26px;
    }

    .durum-container {
      display: flex;
      align-items: center;
      gap: 10px;
      margin-top: 15px;
    }

    #musaitDurum {
      width: 20px;
      height: 20px;
      border-radius: 5px;
    }

    #musaitYazi {
      font-weight: bold;
    }

    .btn-primary {
      background-color: #0d6efd;
      border: none;
      border-radius: 8px;
      padding: 8px 16px;
      margin-top: 15px;
      font-weight: 500;
    }

    .btn-primary:hover {
      background-color: #0b5ed7;
    }

    .benzer-kitaplar {
      margin-top: 40px;
      border-top: 1px solid #dee2e6;
      padding-top: 20px;
    }

    .kitap-kart {
      border-radius: 10px;
      overflow: hidden;
      transition: transform 0.2s ease, box-shadow 0.3s ease;
      height: 100%;
    }

    .kitap-kart:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 20px rgba(0,0,0,0.1);
    }

    .kitap-resim {
      height: 180px;
      object-fit: contain;
      padding: 10px;
    }

    .kitap-kategori {
      font-size: 12px;
      background-color: #e9ecef;
      padding: 3px 8px;
      border-radius: 12px;
      display: inline-block;
      margin-bottom: 5px;
    }
  </style>
</head>

<body>
  <div class="main-layout">
    <!-- Sol Menü -->
    <div class="left-sidebar">
      <img src="https://raw.githubusercontent.com/erenbyl/data_structures-project/main/logo.jpg" alt="Logo" />
      <button onclick="location.href='WebForm1.aspx'">🏠 Ana Sayfa</button>
      <button onclick="location.href='TopluTasimasi.aspx'">🚌 Toplu Taşıma</button>
      <button onclick="location.href='AcilDurum.aspx'">🚨 Acil Durumlar</button>
      <button onclick="location.href='WebForm3.aspx'">💊 İlaç Sorgulama</button>
      <button onclick="location.href='umut.aspx'">📚 Dijital Kütüphane</button>
      <button onclick="location.href='PersonelGiris.aspx'">👤 Personel Girişi</button>
    </div>

    <!-- Kitap Detay İçeriği -->
    <div class="main-content">
      <div class="container">
        <div class="d-flex">
          <img id="kapakResmi" />
          <div id="kitapBilgileri">
            <h2 id="kitapBaslik">Kitap Adı</h2>
            <p><strong>Yazar:</strong> <span id="kitapYazar"></span></p>
            <p><strong>Kategori:</strong> <span id="kitapKategori"></span></p>
            <p><strong>Özet:</strong> <span id="kitapOzet"></span></p>

            <div class="durum-container">
              <div id="musaitDurum"></div>
              <span id="musaitYazi"></span>
            </div>

            <button id="btnOduncAl" class="btn btn-primary">Ödünç Al</button>
          </div>
        </div>

        <div class="benzer-kitaplar mt-4">
          <h3 class="mb-3">Aynı Kategorideki Kitaplar</h3>
          <div id="benzerKitaplar" class="row g-3"></div>
        </div>
      </div>
    </div>
  </div>

  <!-- JS -->
  <script>
      class KitapHashTable {
          constructor(size = 101) {
              this.table = new Array(size);
              this.size = size;
              this.count = 0;
          }

          hash(str) {
              let hash = 5381;
              for (let i = 0; i < str.length; i++) {
                  hash = ((hash << 5) + hash) + str.charCodeAt(i);
              }
              return Math.abs(hash % this.size);
          }

          put(key, value) {
              const index = this.hash(key);
              if (!this.table[index]) this.table[index] = [];
              for (let i = 0; i < this.table[index].length; i++) {
                  if (this.table[index][i].key === key) {
                      this.table[index][i].value = value;
                      return;
                  }
              }
              this.table[index].push({ key, value });
              this.count++;
          }

          get(key) {
              const index = this.hash(key);
              if (!this.table[index]) return null;
              for (let i = 0; i < this.table[index].length; i++) {
                  if (this.table[index][i].key === key) {
                      return this.table[index][i].value;
                  }
              }
              return null;
          }

          keys() {
              const keys = [];
              for (let i = 0; i < this.size; i++) {
                  if (this.table[i]) {
                      for (let j = 0; j < this.table[i].length; j++) {
                          keys.push(this.table[i][j].key);
                      }
                  }
              }
              return keys;
          }
      }

      const kitaplarHash = new KitapHashTable();
      const urlParams = new URLSearchParams(window.location.search);
      const kitapAdi = urlParams.get("kitap");

      fetch('kitaplar.json')
          .then(res => res.json())
          .then(data => {
              data.forEach(kitap => {
                  kitaplarHash.put(kitap.isim, kitap);
              });

              const kitap = kitaplarHash.get(kitapAdi);
              if (!kitap) {
                  document.querySelector('.container').innerHTML = "<h3>Kitap bulunamadı.</h3>";
                  return;
              }

              document.getElementById('kitapBaslik').textContent = kitap.isim;
              document.getElementById('kapakResmi').src = "images/kapaklar/" + kitap.kapak;
              document.getElementById('kitapYazar').textContent = kitap.yazar;
              document.getElementById('kitapKategori').textContent = kitap.kategori;
              document.getElementById('kitapOzet').textContent = kitap.ozet;

              let oduncDurumlari = JSON.parse(localStorage.getItem("oduncDurumlari") || "{}");
              let kitapMusait = !(kitap.isim in oduncDurumlari && oduncDurumlari[kitap.isim] === true);

              function guncelleMusaitlik(durum) {
                  const kutu = document.getElementById('musaitDurum');
                  const yazi = document.getElementById('musaitYazi');
                  const buton = document.getElementById('btnOduncAl');
                  if (durum) {
                      kutu.style.backgroundColor = 'green';
                      yazi.textContent = 'Müsait';
                      buton.disabled = false;
                      buton.textContent = 'Ödünç Al';
                  } else {
                      kutu.style.backgroundColor = 'red';
                      yazi.textContent = 'Müsait değil';
                      buton.disabled = true;
                      buton.textContent = 'Zaten Ödünçte';
                  }
              }

              guncelleMusaitlik(kitapMusait);

              document.getElementById("btnOduncAl").addEventListener("click", function () {
                  oduncDurumlari[kitap.isim] = true;
                  localStorage.setItem("oduncDurumlari", JSON.stringify(oduncDurumlari));
                  guncelleMusaitlik(false);
              });

              benzerKitaplariGoster(data, kitap);
          });

      function benzerKitaplariBul(kitaplar, aktifKitap) {
          return kitaplar
              .filter(k => k.kategori === aktifKitap.kategori && k.isim !== aktifKitap.isim)
              .slice(0, 4);
      }

      function benzerKitaplariGoster(kitaplar, aktifKitap) {
          const benzerKitaplar = benzerKitaplariBul(kitaplar, aktifKitap);
          const container = document.getElementById('benzerKitaplar');

          if (benzerKitaplar.length === 0) {
              container.innerHTML = '<p class="text-muted">Bu kategoride başka kitap bulunamadı.</p>';
              return;
          }

          container.innerHTML = '';
          benzerKitaplar.forEach(kitap => {
              const oduncDurumlari = JSON.parse(localStorage.getItem("oduncDurumlari") || "{}");
              const kitapMusait = !(kitap.isim in oduncDurumlari && oduncDurumlari[kitap.isim] === true);

              const html = `
          <div class="col-md-3">
            <div class="card kitap-kart" onclick="window.location.href='kitap_detay.aspx?kitap=${encodeURIComponent(kitap.isim)}'">
              <img src="images/kapaklar/${kitap.kapak}" class="card-img-top kitap-resim" alt="${kitap.isim}">
              <div class="card-body">
                <span class="kitap-kategori">${kitap.kategori}</span>
                <h5 class="card-title">${kitap.isim}</h5>
                <p class="card-text text-muted">${kitap.yazar}</p>
                <div class="d-flex align-items-center mt-2">
                  <div style="width: 10px; height: 10px; border-radius: 50%; background-color: ${kitapMusait ? 'green' : 'red'}; margin-right: 5px;"></div>
                  <small>${kitapMusait ? 'Müsait' : 'Ödünçte'}</small>
                </div>
              </div>
            </div>
          </div>`;
              container.innerHTML += html;
          });
      }
  </script>
</body>
</html>
