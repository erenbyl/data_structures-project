<%@ Page Title="Ana Sayfa" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="WebApplication3.WebForm1" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .content-wrapper {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .middle-panel {
            flex: none;
            position: relative;
            background-image: url('https://raw.githubusercontent.com/erenbyl/data_structures-project/dijital-kutuphane/map.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            height: 768px;
            border-radius: 10px;
            box-shadow: 0 0 8px rgba(0, 0, 0, 0.2);
            cursor: default;
        }

        .info-section {
            background-color: #f9fafc;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 8px rgba(0,0,0,0.05);
        }

        .right-panel {
            position: fixed;
            right: 20px;
            top: 80px;
            width: 330px;
            background-color: #ffffff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15);
            display: none;
            z-index: 998;
        }

        .right-panel h3 {
            margin-top: 0;
            font-weight: 600;
            color: #2c3e50;
            font-size: 18px;
            border-bottom: 1px solid #eee;
            padding-bottom: 8px;
            margin-bottom: 16px;
        }

        .right-panel p {
            font-size: 14px;
            color: #555;
        }

        .btn-gonder {
            background-color: #4a90e2;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            width: 100%;
            font-weight: bold;
            font-size: 15px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn-gonder:hover {
            background-color: #3b7dd8;
        }

        #btnTogglePanel {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 12px 18px;
            font-size: 15px;
            font-weight: 600;
            border: none;
            border-radius: 10px;
            background-color: #3498db;
            color: white;
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
            transition: background-color 0.3s ease;
            z-index: 999;
        }

        #btnTogglePanel:hover {
            background-color: #2b7fc3;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group textarea {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
            resize: vertical;
            font-size: 14px;
        }

        .form-group label {
            font-weight: 600;
            margin-bottom: 5px;
            display: block;
        }
    </style>

    <div class="content-wrapper">
        <div class="middle-panel" id="mapPanel">
            <!-- Harita üzerindeki yazı gösterimi kaldırıldı -->
        </div>

        <div class="info-section">
            <h2 style="color: #2c3e50; font-weight: bold;">📘 Akıllı Şehir Nedir?</h2>
            <p style="font-size: 16px; line-height: 1.7;">
                Bu Web sitesiyle,şehrimizde bulunana Acil toplanma alanlarına,şehrin ulaşım imkanlarına, kütüphane hizmetlerine, nöbetçi eczanelere ve bu eczanelerde bulunan ilaç bilgilerine tek bir site üzerinden ulaşmanızı hedefledik.
                Daha güvenli, daha yeşil, daha akıllı bir şehir için biz buradayız. Siz de bu dönüşümün parçası olun.
            </p>

            <h3 style="margin-top: 25px;">🎯 Amaçlar:</h3>
            <ul style="font-size: 16px; padding-left: 20px;">
                <li>✅ Ana Sayfada bulunan Duyurular/Bize Ulaşın bölümüyle şehrimizde yapılan değişikliklere ulaşabilir ve fikirlerinizi bize iletebilirsiniz. </li>
                <li>✅ Toplu taşıma kısmında bulunan ilgili kısımlardan bulunduğunuz durağı ve gitmek istediğiniz durağı seçtiğinizde hangi toplu taşıma aracılığıyla nasıl gidebiliceğinizi size gösteriyor.</li>
                <li>✅ Acil durumlar kısmında bulunan ilgili yerlere acil durum türünü ve konumunuzu belirterek yetkililere ulaşacak ihbarı verebilirsiniz.</li>
                <li>✅ İlaç Sargulama kısmında bulunan ilgili yerlere aradığınız ilacın ismini yazarsanız aradığınız ilacın hangi eczanede kaç tane bulunduğunu öğrenebilirsiniz aynı zamanda nöbetçi eczane bilgisi de bu sayfada bulunmaktadır</li>
                <li>✅ Dijital kütüphane kısmında kütüphanede bulunan kitaplarımızı görüntüleyebilir ve istediğiniz kitabın müsaitlik durumunu öğrenebilirisniz.</li>
                <li>✅ Personel kısmında personellerimiz size daha iyi hizmet verebilmek için geri dönüşlerinizi görüntüleyip duyuruları yayınlıyorlar.</li>
            </ul>
        </div>
    </div>

    <button id="btnTogglePanel" type="button" onclick="toggleRightPanel()">
        📌 DUYURULAR / BİZE ULAŞIN
    </button>

    <div class="right-panel" id="rightPanel">
        <h3>📢 Duyurular</h3>
        <asp:Literal ID="litDuyurular" runat="server" />

        <h3>✉ Geri Bildirim</h3>
        <p>Bize görüşlerinizi yazın:</p>
        <div class="form-group">
            <asp:TextBox ID="txtGerıdonus" runat="server" TextMode="MultiLine" Rows="6" Width="100%"></asp:TextBox>
        </div>

        <asp:Label ID="lblDurum" runat="server" ForeColor="Green" Font-Bold="true" /><br />
        <asp:Button ID="btnGonder" runat="server" Text="GÖNDER" CssClass="btn-gonder" OnClick="btnGonder_Click" />
    </div>

    <script>
        function toggleRightPanel() {
            const panel = document.getElementById("rightPanel");
            panel.style.display = (panel.style.display === "none" || panel.style.display === "") ? "block" : "none";
        }
    </script>
</asp:Content>