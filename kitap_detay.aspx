<%@ Page Language="C#" AutoEventWireup="true" CodeFile="kitap_detay.aspx.cs" Inherits="WebApplication1.kitap_detay" %>


<!DOCTYPE html>
<html lang="tr">
<head>
  <meta charset="UTF-8">
  <title>Kitap Detay</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
      button, .btn {
  font-weight: 500;
  border-radius: 8px;
  padding: 8px 16px;
  transition: background-color 0.2s ease;
}

.btn-primary {
  background-color: #0d6efd;
  border: none;
}

.btn-primary:hover {
  background-color: #0b5ed7;
}

    body {
  background: linear-gradient(135deg, #e0f7fa, #e1bee7);
  font-family: 'Segoe UI', 'Roboto', sans-serif;
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 100vh;
  margin: 0;
}


.card {
  border: none;
  border-radius: 16px;
  box-shadow: 0 6px 16px rgba(0,0,0,0.15);
  padding: 20px;
  background-color: white;
}


    .container {
      max-width: 900px;
      background: #fff;
      padding: 30px;
      border-radius: 15px;
      box-shadow: 0 6px 20px rgba(0,0,0,0.1);
      display: flex;
      gap: 30px;
      align-items: start;
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
  font-family: 'Segoe UI', 'Roboto', sans-serif;
  font-weight: 700;
  font-size: 26px;
}


    p {
  font-size: 16px;
  color: #333;
}

.badge-danger {
  background-color: #dc3545;
  font-weight: bold;
  border-radius: 6px;
  padding: 5px 10px;
}


    #musaitDurum {
      width: 20px;
      height: 20px;
      border-radius: 5px;
      margin-right: 10px;
    }

    #musaitYazi {
      font-weight: bold;
    }

    #btnOduncAl {
      margin-top: 15px;
    }

    .durum-container {
      display: flex;
      align-items: center;
      gap: 10px;
      margin-top: 15px;
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
 <div class="container" style="flex-direction: column; align-items: stretch;">
  <!-- Kitap detayları için flex container -->
  <div class="d-flex gap-4">
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
  
  <!-- Benzer kitaplar için alt kısım -->
  <div class="benzer-kitaplar mt-4">
    <h3 class="mb-3">Aynı Kategorideki Kitaplar</h3>
    <div id="benzerKitaplar" class="row g-3">
      <!-- Benzer kitaplar burada listelenecek -->
    </div>
  </div>
</div>


</div>

  <!-- JS -->
  <script>
      // Hash Table sınıfı
      class KitapHashTable {
          constructor(size = 101) { // Asal sayı tercih edilir
              this.table = new Array(size);
              this.size = size;
              this.count = 0;
          }

          // Hash fonksiyonu (basit bir djb2 hash algoritması)
          hash(str) {
              let hash = 5381;
              for (let i = 0; i < str.length; i++) {
                  hash = ((hash << 5) + hash) + str.charCodeAt(i);
              }
              return Math.abs(hash % this.size);
          }

          // Eleman ekleme
          put(key, value) {
              const index = this.hash(key);

              if (!this.table[index]) {
                  this.table[index] = [];
              }

              // Çakışma kontrolü (collision handling)
              for (let i = 0; i < this.table[index].length; i++) {
                  if (this.table[index][i].key === key) {
                      this.table[index][i].value = value; // Var olan değeri güncelle
                      return;
                  }
              }

              // Yeni değer ekle
              this.table[index].push({ key, value });
              this.count++;
          }

          // Eleman getirme
          get(key) {
              const index = this.hash(key);

              if (!this.table[index]) {
                  return null;
              }

              for (let i = 0; i < this.table[index].length; i++) {
                  if (this.table[index][i].key === key) {
                      return this.table[index][i].value;
                  }
              }

              return null;
          }

          // Eleman silme
          remove(key) {
              const index = this.hash(key);

              if (!this.table[index]) {
                  return false;
              }

              for (let i = 0; i < this.table[index].length; i++) {
                  if (this.table[index][i].key === key) {
                      this.table[index].splice(i, 1);
                      this.count--;
                      return true;
                  }
              }

              return false;
          }

          // Eleman var mı kontrolü
          contains(key) {
              return this.get(key) !== null;
          }

          // Tüm anahtarları getir
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

          // Tüm değerleri getir
          values() {
              const values = [];
              for (let i = 0; i < this.size; i++) {
                  if (this.table[i]) {
                      for (let j = 0; j < this.table[i].length; j++) {
                          values.push(this.table[i][j].value);
                      }
                  }
              }
              return values;
          }

          // Hash tablosunu temizle
          clear() {
              this.table = new Array(this.size);
              this.count = 0;
          }

          // Hash tablosunun doluluk oranı
          loadFactor() {
              return this.count / this.size;
          }
      }

      // Global kitap hash tablosu
      const kitaplarHash = new KitapHashTable();

    const urlParams = new URLSearchParams(window.location.search);
    const kitapAdi = urlParams.get("kitap");

      fetch('kitaplar.json')
          .then(res => res.json())
          .then(data => {
              // Tüm kitapları hash table'a ekle
              data.forEach(kitap => {
                  // Kitap adını anahtar, kitap nesnesini değer olarak ekle
                  kitaplarHash.put(kitap.isim, kitap);
              });

              const kitap = kitaplarHash.get(kitapAdi); // Hash Table'dan kitabı al

              if (!kitap) {
                  document.querySelector('.container').innerHTML = "<h3>Kitap bulunamadı.</h3>";
                  return;
              }

              document.getElementById('kitapBaslik').textContent = kitap.isim;
              document.getElementById('kapakResmi').src = "images/kapaklar/" + kitap.kapak;
              document.getElementById('kitapYazar').textContent = kitap.yazar;
              document.getElementById('kitapKategori').textContent = kitap.kategori;
              document.getElementById('kitapOzet').textContent = kitap.ozet;

              // localStorage kontrol
              let oduncDurumlari = JSON.parse(localStorage.getItem("oduncDurumlari") || "{}");
              let kitapMusait = kitap.musait;
              if (kitap.isim in oduncDurumlari && oduncDurumlari[kitap.isim] === true) {
                  kitapMusait = false; // Kitap ödünçteyse müsait değildir
              } else {
                  kitapMusait = true; // Aksi halde müsaittir
              }

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

              // Hash table kullanarak benzer kitapları göster
              benzerKitaplariGoster(data, kitap);
          });

      // Benzer kitapları bulma fonksiyonu
      function benzerKitaplariBul(kitaplar, aktifKitap) {
          // Hash table'dan aynı kategorideki kitapları al
          return kitaplar
              .filter(k => k.kategori === aktifKitap.kategori && k.isim !== aktifKitap.isim)
              .slice(0, 4); // En fazla 4 benzer kitap göster
      }


      // Ana kitap yüklendikten sonra aynı kategorideki kitapları göster
      function benzerKitaplariGoster(kitaplar, aktifKitap) {
          const benzerKitaplar = benzerKitaplariBul(kitaplar, aktifKitap);
          const container = document.getElementById('benzerKitaplar');

          if (benzerKitaplar.length === 0) {
              container.innerHTML = '<p class="text-muted">Bu kategoride başka kitap bulunamadı.</p>';
              return;
          }

          container.innerHTML = '';
          benzerKitaplar.forEach(kitap => {
              // Kitap müsaitlik durumunu kontrol et
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
      </div>
    `;
              container.innerHTML += html;
          });
      }


  </script>
</body>
</html>
