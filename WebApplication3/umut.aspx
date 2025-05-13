<%@ Page Language="C#" AutoEventWireup="true" CodeFile="umut.aspx.cs" Inherits="WebApplication1.umut" %>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Akıllı Kütüphane</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .main-layout {
    display: flex;
    height: calc(100vh - 60px);
    margin-top: 60px;
}
        body {
            margin: 0;
            font-family: Arial, sans-serif;
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

        .left-sidebar h2 {
            font-size: 1.2rem;
            margin-bottom: 20px;
            color: #333;
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
            padding: 30px;
            overflow-y: auto;
        }

        .section-header {
            background-color: white;
            border-left: 5px solid #007BFF;
            padding-left: 15px;
            border-radius: 8px;
            animation: fadeInDown 0.5s ease;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }

        .card {
            box-shadow: 0 6px 16px rgba(0,0,0,0.15);
            border-radius: 16px;
            transition: transform 0.3s ease;
            background-color: white;
            animation: fadeInUp 0.5s ease;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card-img-top {
            height: 300px;
            object-fit: contain;
        }

        #suggestions {
            max-height: 300px;
            overflow-y: auto;
            width: 100%;
            z-index: 1000;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
   


<body>
   
    <!-- Sayfa Gövdesi -->
<body>
    <div class="page-wrapper d-flex">
        <!-- Sol Menü -->
        <div class="left-sidebar">
            <img src="https://raw.githubusercontent.com/erenbyl/data_structures-project/main/logo.jpg" alt="Logo" />
            <button onclick="location.href='WebForm1.aspx'">🏠 Ana Sayfa</button>
            <button onclick="location.href='TopluTasima.aspx'">🚌 Toplu Taşıma</button>
            <button onclick="location.href='AcilDurum.aspx'">🚨 Acil Durumlar</button>
            <button onclick="location.href='WebForm3.aspx'">💊 İlaç Sorgulama</button>
            <button onclick="location.href='umut.aspx'">📚 Dijital Kütüphane</button>
            <button onclick="location.href='PersonelGiris.aspx'">👤 Personel Girişi</button>
        </div>

        <!-- Sağ Ana Kısım -->
        <div class="right-content flex-grow-1">
            <!-- Navbar -->
            <nav class="navbar navbar-expand-lg navbar-dark bg-primary px-4 shadow-sm" style="height: 60px;">
                <div class="container-fluid px-0">
                    <span class="navbar-brand fw-bold">ULUDAĞ KÜTÜPHANE</span>
                    <div class="ms-auto">
                        <a href="rezervasyon.aspx" class="btn btn-light fw-semibold">Rezervasyonlarım</a>
                    </div>
                </div>
            </nav>

            <!-- İçerik -->
            <div class="main-content p-4">
                <div class="section-header shadow-sm p-3 mb-4 rounded d-inline-block">
                    <h2 class="mb-0">Tüm Kitaplar</h2>
                </div>

                <form class="d-flex mb-4 position-relative" role="search">
                    <input class="form-control me-2 search-box" type="search" placeholder="Ara..." aria-label="Ara" id="globalSearch">
                    <div id="suggestions" class="list-group position-absolute" style="top: 38px; z-index: 999;"></div>
                </form>

                <div id="kitaplarListesi" class="row"></div>
            </div>
        </div>
    </div>


    <!-- JavaScript ve Kitap Fonksiyonları -->
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
        const prefixHash = new KitapHashTable();

        function prefixleriEkle(kitapIsmi) {
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

        fetch('kitaplar.json')
            .then(res => res.json())
            .then(data => {
                const container = document.getElementById('kitaplarListesi');
                container.innerHTML = '';
                data.forEach(kitap => {
                    kitaplarHash.put(kitap.isim, kitap);
                    prefixleriEkle(kitap.isim);
                    const html = `
                        <div class="col-md-4">
                            <div class="card mb-4 shadow-sm kitap-karti" data-kitap="${kitap.isim}" style="cursor: pointer;">
                                <img src="images/kapaklar/${kitap.kapak}" class="card-img-top" alt="${kitap.isim}">
                                <div class="card-body">
                                    <h5 class="card-title">${kitap.isim}</h5>
                                    <p class="card-text"><strong>Yazar:</strong> ${kitap.yazar}</p>
                                    <p class="card-text"><strong>Kategori:</strong> ${kitap.kategori}</p>
                                    <p class="card-text"><em>${kitap.ozet}</em></p>
                                </div>
                            </div>
                        </div>`;
                    container.innerHTML += html;
                });
            });

        const input = document.getElementById('globalSearch');
        const suggestionBox = document.getElementById('suggestions');

        input.addEventListener('input', function () {
            const value = this.value.toLowerCase();
            suggestionBox.innerHTML = '';
            if (value.length < 1) return;

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

        document.addEventListener('click', function (e) {
            if (!suggestionBox.contains(e.target) && e.target !== input) {
                suggestionBox.innerHTML = '';
            }

            const card = e.target.closest(".kitap-karti");
            if (card) {
                const kitapIsmi = card.getAttribute("data-kitap");
                window.location.href = "kitap_detay.aspx?kitap=" + encodeURIComponent(kitapIsmi);
            }
        });

        function aramaFiltrele(arananMetin) {
            const aranan = arananMetin.toLowerCase();
            const prefixEslesenleri = prefixHash.get(aranan) || [];

            if (prefixEslesenleri.length === 0) {
                const sonuclar = [];
                const tumIsimler = kitaplarHash.keys();
                for (const isim of tumIsimler) {
                    if (isim.toLowerCase().includes(aranan)) {
                        sonuclar.push(isim);
                        if (sonuclar.length >= 5) break;
                    }
                }
                return sonuclar;
            }
            return prefixEslesenleri.slice(0, 5);
        }
    </script>
</body>
</html>
