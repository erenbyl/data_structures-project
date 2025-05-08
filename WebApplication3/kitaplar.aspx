<%@ Page Language="C#" AutoEventWireup="true" CodeFile="kitaplar.aspx.cs" Inherits="WebApplication1.kitaplar" %>

<!DOCTYPE html>
<html lang="tr">
<head>
  <meta charset="UTF-8" />
  <title>Tüm Kitaplar</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', sans-serif;
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

    .kitap-kart {
      border: 1px solid #ddd;
      border-radius: 10px;
      padding: 15px;
      margin-bottom: 20px;
      box-shadow: 0 0 5px rgba(0,0,0,0.1);
      background-color: #fff;
      transition: transform 0.2s ease;
    }

    .kitap-kart:hover {
      transform: translateY(-5px);
      box-shadow: 0 8px 16px rgba(0,0,0,0.1);
    }

    .kitap-kapak {
      width: 100%;
      height: auto;
      max-height: 300px;
      object-fit: contain;
      border-radius: 8px;
      margin-bottom: 15px;
    }

    h2 {
      font-weight: 600;
      margin-bottom: 30px;
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

    <!-- İçerik -->
    <div class="main-content">
      <h2>📚 Tüm Kitaplar</h2>
      <div id="kitaplarListesi" class="row"></div>
    </div>
  </div>

  <!-- JS -->
  <script>
      fetch('kitaplar.json')
          .then(res => res.json())
          .then(data => {
              const container = document.getElementById('kitaplarListesi');
              data.forEach(kitap => {
                  const html = `
            <div class="col-md-4">
              <div class="kitap-kart">
                <img src="images/kapaklar/${kitap.kapak}" alt="${kitap.isim}" class="kitap-kapak" />
                <h5>${kitap.isim}</h5>
                <p><strong>Yazar:</strong> ${kitap.yazar}</p>
                <p><strong>Kategori:</strong> ${kitap.kategori}</p>
                <p><em>${kitap.ozet}</em></p>
              </div>
            </div>`;
                  container.innerHTML += html;
              });
          });
  </script>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
