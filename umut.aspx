<%@ Page Language="C#" AutoEventWireup="true" CodeFile="umut.aspx.cs" Inherits="WebApplication1.umut" %>

<!DOCTYPE html>
<html lang="tr">
    <style>
  /* Aktif sekme için stil */
  .nav-item .nav-link.active {
    background-color: rgba(255, 255, 255, 0.2);
    border-radius: 4px;
    text-decoration: underline;
  }
</style>

<head>
    <style>
    #suggestions {
        max-height: 300px;
        overflow-y: auto;
        width: 100%;
        border-radius: 0 0 8px 8px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        z-index: 1000;
    }

    #suggestions .list-group-item {
        padding: 10px 15px;
        transition: all 0.2s ease;
        background-color: #fff;
        border-left: 3px solid transparent;
    }

    #suggestions .list-group-item:hover {
        background-color: #f8f9fa;
        border-left: 3px solid #007bff;
    }

    /* Mobil cihazlarda öneri kutusu stil ayarları */
    @media (max-width: 768px) {
        #suggestions {
            position: absolute;
            width: calc(100% - 2rem);
        }
    }
</style>

  <meta charset="UTF-8">
  <title>Akıllı Kütüphane</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
      .section-header {
  background-color: white;
  border-left: 5px solid #007BFF;
  padding-left: 15px;
  border-radius: 8px;
  animation: fadeInDown 0.5s ease;
  box-shadow: 0 4px 10px rgba(0,0,0,0.05);
}


    body {
  background: linear-gradient(135deg, #e0f7fa, #e1bee7);
}


.card {
  box-shadow: 0 6px 16px rgba(0,0,0,0.15);
  border-radius: 16px;
}


.section-header h2 {
  margin: 0;
  font-family: 'Segoe UI', 'Roboto', sans-serif;
  font-weight: 600;
  font-size: 24px;
  display: flex;
  align-items: center;
}


h2::before {
  content: '📚';
  margin-right: 10px;
  font-size: 30px;
}

.card {
  border: none;
  border-radius: 15px;
  overflow: hidden;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  box-shadow: 0 4px 16px rgba(0,0,0,0.08);
  background-color: white;
  animation: fadeInUp 0.5s ease;
}

.card:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 20px rgba(0,0,0,0.15);
}

.card-img-top {
  height: 320px;
  object-fit: cover;
  border-bottom: 1px solid #eee;
}

.card-title {
  font-size: 20px;
  font-weight: 600;
}

.card-text em {
  font-size: 14px;
  color: #555;
}

/* Kategori Rozetleri */
.card-text strong::after {
  content: '';
  display: inline-block;
  margin-left: 6px;
  width: 10px;
  height: 10px;
  border-radius: 50%;
}

.card-text:has(strong:contains("Distopya")) strong::after {
  background-color: #dc3545;
}

.card-text:has(strong:contains("Klasik")) strong::after {
  background-color: #0d6efd;
}

.card-text:has(strong:contains("Tarih")) strong::after {
  background-color: #198754;
}

.card-text:has(strong:contains("Biyografi")) strong::after {
  background-color: #ffc107;
}

/* NAVBAR */
.navbar {
  background: linear-gradient(90deg, #0052cc, #3399ff) !important;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.nav-link,
.dropdown-item {
  color: #fff !important;
  font-weight: 500;
  transition: background 0.2s;
}

.nav-link:hover,
.dropdown-item:hover {
  background-color: rgba(255, 255, 255, 0.2) !important;
  border-radius: 5px;
}

#suggestions .list-group-item {
  background-color: #ffffff;
  border: 1px solid #ccc;
  border-radius: 4px;
  margin-top: 2px;
  transition: background-color 0.2s ease;
}

#suggestions .list-group-item:hover {
  background-color: #e9ecef;
}

/* ANİMASYONLAR */
@keyframes fadeInUp {
  from {opacity: 0; transform: translateY(20px);}
  to {opacity: 1; transform: translateY(0);}
}

@keyframes fadeInDown {
  from {opacity: 0; transform: translateY(-20px);}
  to {opacity: 1; transform: translateY(0);}
}

/* KARANLIK MOD (manuel geçişli yapılabilir) */
body.dark-mode {
  background: #121212;
  color: #eee;
}

body.dark-mode .card {
  background-color: #1f1f1f;
  color: #fff;
}

body.dark-mode .navbar {
  background: #000 !important;
}

body.dark-mode #suggestions .list-group-item {
  background-color: #333;
  color: #fff;
  border-color: #444;
}

    .navbar {
      background-color: #007BFF !important;
    }

    .navbar-brand {
      font-weight: bold;
      font-size: 24px;
      color: white !important;
    }

    .nav-link, .dropdown-item {
      color: white !important;
      font-weight: 500;
    }

    .dropdown-menu {
      background-color: #007BFF;
      border: none;
    }

    .dropdown-item:hover {
      background-color: #0056b3;
      color: white;
    }

    .nav-link:hover {
      text-decoration: underline;
    }

    .search-box {
      width: 200px;
    }

    .btn-login {
      margin-right: 10px;
    }

    /* HOVER İLE AÇILMASINI SAĞLAYAN ÖZEL CSS */
    @media (min-width: 992px) {
      .dropdown:hover .dropdown-menu {
        display: block;
        margin-top: 0;
      }
    }
  </style>
</head>
    <script>
        // Hash Table sınıfı
        class KitapHashTable {
            constructor(size = 101) { // Asal sayı tercih edilir
                this.table = new Array(size);
                this.size = size;
                this.count = 0;
            }

            // Hash fonksiyonu ve diğer metotlar (kitap_detay.aspx'teki ile aynı)
            hash(str) {
                let hash = 5381;
                for (let i = 0; i < str.length; i++) {
                    hash = ((hash << 5) + hash) + str.charCodeAt(i);
                }
                return Math.abs(hash % this.size);
            }

            // Diğer metotlar...
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

        // Global kitap hash tablosu
        const kitaplarHash = new KitapHashTable();

        document.addEventListener('DOMContentLoaded', function () {
            // URL'den aktif sekmeyi al
            const urlParams = new URLSearchParams(window.location.search);
            const activeTab = urlParams.get('activeTab');

            if (activeTab) {
                // Tüm linkleri kontrol et
                document.querySelectorAll('.navbar-nav .nav-link').forEach(link => {
                    // Link, aktif sekmeyle eşleşiyorsa
                    if (link.textContent.trim() === activeTab) {
                        link.classList.add('active');
                    }
                });
            }

            // Tüm menü linklerine tıklama olayı ekle
            document.querySelectorAll('.navbar-nav .nav-link:not(.dropdown-toggle)').forEach(link => {
                link.addEventListener('click', function (e) {
                    // Dropdown toggle değilse, mevcut URL'ye activeTab parametresi ekle
                    if (!this.classList.contains('dropdown-toggle')) {
                        const tabName = this.textContent.trim();
                        const currentUrl = new URL(this.href);
                        currentUrl.searchParams.set('activeTab', tabName);
                        this.href = currentUrl.toString();
                    }
                });
            });
        });
    </script>

<body>
   
<nav class="navbar navbar-expand-lg navbar-dark px-4">
 <a class="navbar-brand" href="umut.aspx">ULUDAĞ KÜTÜPHANE</a>

  
  <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
    <span class="navbar-toggler-icon"></span>
  </button>
  
  <div class="collapse navbar-collapse" id="navbarNav">

   <ul class="navbar-nav me-auto mb-2 mb-lg-0">
  <!-- Diğer sekmeler -->
  <li class="nav-item"><a class="nav-link" href="rezervasyon.aspx">Rezervasyonlarım</a></li>
    </ul>



    <form class="d-flex position-relative" role="search">
  <input class="form-control me-2 search-box" type="search" placeholder="Ara..." aria-label="Ara" id="globalSearch">
 <!-- <a href="giris.aspx" class="btn btn-light btn-login">Giriş Yap</a> -->
  <div id="suggestions" class="list-group position-absolute" style="top: 38px; z-index: 999;"></div>
    </form>


  </div>
</nav>
    <!-- KİTAPLARIN LİSTELENECEĞİ ALAN -->
<div class="container mt-5">
  <div class="section-header shadow-sm p-3 mb-4 rounded d-inline-block">
  <h2 class="mb-0">Tüm Kitaplar</h2>
  </div>

  <div id="kitaplarListesi" class="row"></div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        fetch(`kitaplar.json?timestamp=${new Date().getTime()}`)
            .then(res => res.json())
            .then(data => {
                const container = document.getElementById('kitaplarListesi');
                container.innerHTML = ''; // Eski içerikleri temizle
                data.forEach(kitap => {
                    const html = `
                   <div class="col-md-4">
                       <div class="card mb-4 shadow-sm kitap-karti" data-kitap="${kitap.isim}" style="cursor: pointer;">
                           <img src="images/kapaklar/${kitap.kapak}" class="card-img-top" alt="${kitap.isim}" style="height: 300px; object-fit: contain;">
                           <div class="card-body">
                               <h5 class="card-title">${kitap.isim}</h5>
                               <p class="card-text"><strong>Yazar:</strong> ${kitap.yazar}</p>
                               <p class="card-text"><strong>Kategori:</strong> ${kitap.kategori}</p>
                               <p class="card-text"><em>${kitap.ozet}</em></p>
                           </div>
                       </div>
                   </div>
               `;
                    container.innerHTML += html;
                });
            })
            .catch(error => console.error('JSON yükleme hatası:', error));


    </script>
    <!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- 👇 OTOMATİK TAMAMLAMA KODLARI BURAYA -->
<script>
    // Prefix hash table'ı (hızlı prefix araması için)
    const prefixHash = new KitapHashTable();

    function prefixleriEkle(kitapIsmi) {
        // Bir kitap isminin tüm prefixlerini hash table'a ekle
        const isim = kitapIsmi.toLowerCase();
        for (let i = 1; i <= isim.length; i++) {
            const prefix = isim.substring(0, i);
            if (!prefixHash.get(prefix)) {
                prefixHash.put(prefix, []);
            }

            const mevcutListe = prefixHash.get(prefix);
            if (!mevcutListe.includes(kitapIsmi)) {
                mevcutListe.push(kitapIsmi);
            }
            prefixHash.put(prefix, mevcutListe);
        }
    }

    let kitapIsimleri = [];

    // JSON'dan kitap isimlerini çek ve hash table'a ekle
    fetch('kitaplar.json')
        .then(res => res.json())
        .then(data => {
            // Kitapları hash table'a ekle
            data.forEach(kitap => {
                kitaplarHash.put(kitap.isim, kitap);
                prefixleriEkle(kitap.isim); // Prefix tablosuna da ekle
            });

            // Arama için isim listesi de tutalım
            kitapIsimleri = data.map(k => k.isim);
            console.log("Hash table ve kitap isimleri yüklendi. Toplam: " + kitaplarHash.count);
        });


    const input = document.getElementById('globalSearch');
    const suggestionBox = document.getElementById('suggestions');

    input.addEventListener('input', function () {
        const value = this.value.toLowerCase();
        suggestionBox.innerHTML = '';

        if (value.length < 1) return;

        // Hash table kullanarak aramayla eşleşen kitapları bul
        const filtreli = aramaFiltrele(value);

        filtreli.forEach(eslesen => {
            const item = document.createElement('a');
            item.classList = 'list-group-item list-group-item-action';
            item.textContent = eslesen;
            item.href = '#';
            item.onclick = function () {
                window.location.href = "kitap_detay.aspx?kitap=" + encodeURIComponent(eslesen);
            };

            suggestionBox.appendChild(item);
        });
    });

    // Kutunun dışına tıklanınca önerileri gizle
    document.addEventListener('click', function (e) {
        if (!suggestionBox.contains(e.target) && e.target !== input) {
            suggestionBox.innerHTML = '';
        }
    });

    // Hash table kullanarak arama yapan fonksiyon
    function aramaFiltrele(arananMetin) {
        const aranan = arananMetin.toLowerCase();

        // Önce prefix hash table'dan tam eşleşme ara
        const prefixEslesenleri = prefixHash.get(aranan) || [];

        // Prefix tam eşleşme yoksa, içeren tüm kelimeleri ara
        if (prefixEslesenleri.length === 0) {
            const sonuclar = [];
            const tumIsimler = kitaplarHash.keys();

            for (const isim of tumIsimler) {
                if (isim.toLowerCase().includes(aranan)) {
                    sonuclar.push(isim);
                    // En fazla 5 sonuç göster
                    if (sonuclar.length >= 5) break;
                }
            }

            return sonuclar;
        }

        return prefixEslesenleri.slice(0, 5);
    }
</script>

    <script>
        document.addEventListener("click", function (e) {
            const card = e.target.closest(".kitap-karti");
            if (card) {
                const kitapIsmi = card.getAttribute("data-kitap");
                window.location.href = "kitap_detay.aspx?kitap=" + encodeURIComponent(kitapIsmi);
            }
        });
    </script>

</body>
</html>


</body>
</html>
