<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="WebApplication1.WebForm2" %>

<!DOCTYPE html>
<html lang="tr">
<head runat="server">
    <meta charset="UTF-8" />
    <title>Akıllı Şehir Uludağ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f4f7fc;
            font-family: 'Segoe UI', sans-serif;
        }

        .sidebar {
            background-color: #ffffff;
            padding: 20px;
            min-height: 100vh;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
        }

        .sidebar h2 {
            font-weight: bold;
            font-size: 1.5rem;
            color: #2c3e50;
            margin-bottom: 30px;
        }

        .sidebar .btn {
            width: 100%;
            margin-bottom: 10px;
            text-align: left;
        }

        .main-content {
            background: url('/images/map-background.jpg') no-repeat center center;
            background-size: cover;
            min-height: 100vh;
        }

        .right-panel {
            background-color: #ffffff;
            padding: 20px;
            min-height: 100vh;
            box-shadow: -2px 0 5px rgba(0,0,0,0.1);
        }

        .form-control, .btn {
            border-radius: 10px;
        }

        .section-title {
            font-weight: bold;
            font-size: 1.2rem;
            color: #2c3e50;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="row">
                <!-- Sol Menü -->
                <div class="col-md-2 sidebar d-flex flex-column">
                    <h2>AKILLI ŞEHİR<br />ULUDAĞ</h2>
                    <button type="button" class="btn btn-outline-primary">ANA SAYFA</button>
                    <button type="button" class="btn btn-outline-primary">TOPLU TAŞIMA</button>
                    <button type="button" class="btn btn-outline-primary">ACİL DURUMLAR</button>
                    <button type="button" class="btn btn-outline-primary" onclick="location.href='WebForm3.aspx'">İLAÇ STOK SORGULAMA</button>
                    <button type="button" class="btn btn-outline-primary">DİJİTAL KÜTÜPHANE</button>
                    <button type="button" class="btn btn-outline-secondary">PERSONEL GİRİŞİ</button>
                </div>

                <!-- Orta Harita Alanı -->
                <div class="col-md-7 main-content">
                    <!-- Harita arka plan olarak eklendi -->
                </div>

                <!-- Sağ Panel -->
                <div class="col-md-3 right-panel">
                    <div class="mb-4">
                        <div class="section-title">📢 DUYURULAR</div>
                        <p>Buraya sistem duyuruları gelecek.</p>
                    </div>
                    <div>
                        <div class="section-title">📨 DİLEK - ŞİKAYETLERİNİZ</div>
                        <p>Bize geri dönüş yapın!</p>
                        <textarea class="form-control mb-3" placeholder="Mesajınızı buraya yazın..." rows="4"></textarea>
                        <button type="submit" class="btn btn-primary">Gönder</button>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
