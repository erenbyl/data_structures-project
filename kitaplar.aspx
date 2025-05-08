<%@ Page Language="C#" AutoEventWireup="true" CodeFile="kitaplar.aspx.cs" Inherits="WebApplication1.kitaplar" %>


<!DOCTYPE html>
<html lang="tr">
<head>
  <meta charset="UTF-8" />
  <title>Tüm Kitaplar</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <style>
    .kitap-kart {
      border: 1px solid #ddd;
      border-radius: 10px;
      padding: 15px;
      margin-bottom: 20px;
      box-shadow: 0 0 5px rgba(0,0,0,0.1);
    }
    .kitap-kapak {
      width: 100%;
      height: auto;
      max-height: 300px;
      object-fit: contain;
    }
  </style>
</head>
<body>
  <div class="container mt-4">
    <h2 class="mb-4">📚 Tüm Kitaplar</h2>
    <div id="kitaplarListesi" class="row"></div>
  </div>

  <script>
    fetch('kitaplar.json')
      .then(res => res.json())
      .then(data => {
        const container = document.getElementById('kitaplarListesi');
        data.forEach(kitap => {
          const html = `
            <div class="col-md-4">
              <div class="kitap-kart">
                <img src="images/kapaklar/${kitap.kapak}" alt="${kitap.isim}" class="kitap-kapak mb-3" />
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
