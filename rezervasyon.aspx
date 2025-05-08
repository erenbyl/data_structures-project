<%@ Page Language="C#" AutoEventWireup="true" CodeFile="rezervasyon.aspx.cs" Inherits="WebApplication1.rezervasyon" %>


<!DOCTYPE html>
<html lang="tr">
<head>
  <meta charset="UTF-8" />
  <title>Rezervasyonlarım</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f5f5f5;
      font-family: 'Segoe UI', sans-serif;
    }
    .kitap-kart {
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(0,0,0,0.1);
      margin-bottom: 20px;
      background: #fff;
      padding: 15px;
    }
  </style>
</head>
<body>
  <div class="container mt-5">
    <h2>📚 Rezerve Ettiğiniz Kitaplar</h2>
    <div id="rezervasyonListesi" class="mt-4 row"></div>
  </div>

  <script>
      const odunclar = JSON.parse(localStorage.getItem("oduncDurumlari") || "{}");

      fetch("kitaplar.json")
          .then(res => res.json())
          .then(kitaplar => {
              const container = document.getElementById("rezervasyonListesi");
              const rezerveEdilenler = kitaplar.filter(k => odunclar[k.isim]);

              if (rezerveEdilenler.length === 0) {
                  container.innerHTML = "<p>Şu anda ödünç aldığınız kitap bulunmamaktadır.</p>";
                  return;
              }

              rezerveEdilenler.forEach(kitap => {
                  const html = `
            <div class="col-md-4">
              <div class="kitap-kart">
                <img src="images/kapaklar/${kitap.kapak}" class="img-fluid mb-2" style="height: 200px; object-fit: contain;" />
                <h5>${kitap.isim}</h5>
                <p><strong>Yazar:</strong> ${kitap.yazar}</p>
                <p><strong>Kategori:</strong> ${kitap.kategori}</p>
              </div>
            </div>
          `;
                  container.innerHTML += html;
              });
          });
  </script>
</body>
</html>
