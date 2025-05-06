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
            background-image: url('https://raw.githubusercontent.com/erenbyl/data_structures-project/main/image.png');
            background-size: contain;
            background-repeat: no-repeat;
            background-position: center;
            height: 768px;
            border-radius: 10px;
            box-shadow: 0 0 8px rgba(0, 0, 0, 0.2);
        }

        #info-box {
            display: none;
            position: absolute;
            background-color: white;
            border: 1px solid #ccc;
            padding: 8px;
            font-size: 14px;
            z-index: 10;
            border-radius: 5px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
        }

        .info-section {
            background-color: #f9f9f9;
            padding: 30px;
            border-radius: 10px;
        }

        .right-panel {
            position: fixed;
            right: 20px;
            top: 80px;
            width: 300px;
            background-color: #c9d8e2;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 8px rgba(0, 0, 0, 0.2);
            display: none;
        }

        .right-panel h3 {
            margin-top: 0;
            font-weight: bold;
        }

        .btn-gonder {
            padding: 10px 20px;
            background-color: #e0e0e0;
            font-weight: bold;
            border: none;
            cursor: pointer;
        }

        .btn-gonder:hover {
            background-color: #d0d0d0;
        }
    </style>

    <div class="content-wrapper">
        <!-- Orta Harita Paneli -->
        <div class="middle-panel" id="mapPanel">
            <div id="info-box">Murtaza Cicioğlu Caddesi<br />Posta Kodu: 34000<br />Yoğunluk: Orta</div>
        </div>

        <!-- Harita Panelinden sonra bilgi bölümü artık içeride -->
        <div class="info-section">
            <h2 style="color: #2c3e50; font-weight: bold;">Akıllı Şehir Nedir?</h2>
            <p style="font-size: 16px; line-height: 1.7;">
                Şehirlerin küresel olarak birbirine bağlı bir ekonomide rekabet etme ve kent sakinlerinin refahını sürdürülebilir bir şekilde sağlayabilme ihtiyacı, ülkeleri ve şehirleri yeni teknoloji ve yenilikçi yaklaşımları değerlendirmeye yönlendirmektedir.
                Bu motivasyon, söz konusu teknolojiler ve yaklaşımların getirdiği karmaşıklık ve değişim hızı, geleneksel silo çözümleri geliştiren ekosistem paydaşlarını zorlamakta ve şehir çözümlerinin bütüncül ve sistematik olarak ele alınmasını zorunlu kılmaktadır.
            </p>

            <h3 style="margin-top: 25px;">Daha açık bir ifade ile Akıllı Şehir ile amaçlanan:</h3>
            <ul style="font-size: 16px; padding-left: 20px;">
                <li>✅ Şehrin mevcut ve gelecek beklenti ve problemlerini şehir mekanlarında ve sistemlerinde tetikleyici güç haline getirmek</li>
                <li>✅ Fiziksel, sosyal ve dijital planlamayı birlikte ele alabilmek</li>
                <li>✅ Ortaya çıkan zorlukları sistematik, çevik ve sürdürülebilir şekilde öngörmek, tanımlamak ve karşılamak</li>
                <li>✅ Şehirdeki organizasyonel yapılar arası etkileşimi sağlayarak bütünleşik hizmet sunumu yapmak</li>
            </ul>
        </div>
    </div>

    <!-- SAĞ PANEL AÇ/KAPA BUTONU -->
    <button id="btnTogglePanel" type="button" onclick="toggleRightPanel()" 
        style="position: fixed; top: 20px; right: 20px; padding: 10px 15px; font-weight: bold; border-radius: 8px; background-color: #3498db; color: white; border: none; z-index: 999;">
        📌 Paneli Aç/Kapat
    </button>

    <!-- SAĞ PANEL -->
    <div class="right-panel" id="rightPanel">
        <h3>DUYURULAR!!!</h3>
        <asp:Literal ID="litDuyurular" runat="server" />

        <h3>DİLEK, ŞİKAYETLERİNİZ</h3>
        <p>Bize geri dönüş yapın!</p>
        <asp:TextBox ID="txtGerıdonus" runat="server" TextMode="MultiLine" Rows="6" Width="100%"></asp:TextBox><br /><br />
        <asp:Label ID="lblDurum" runat="server" ForeColor="Green" Font-Bold="true"></asp:Label><br />
        <asp:Button ID="btnGonder" runat="server" Text="GÖNDER" CssClass="btn-gonder" OnClick="btnGonder_Click" />

        <hr />
        <button type="button" class="btn-gonder" onclick="toggleTool()">TANIMLAMA ARACI</button>
    </div>

    <script>
        function toggleRightPanel() {
            const panel = document.getElementById("rightPanel");
            panel.style.display = (panel.style.display === "none" || panel.style.display === "") ? "block" : "none";
        }

        function toggleTool() {
            const tool = document.getElementById("tool-panel");
            if (tool) {
                tool.style.display = (tool.style.display === "none") ? "block" : "none";
            }
        }

        const mapPanel = document.getElementById("mapPanel");
        const infoBox = document.getElementById("info-box");

        mapPanel.addEventListener("mousemove", function (e) {
            const rect = mapPanel.getBoundingClientRect();
            const x = e.clientX - rect.left;
            const y = e.clientY - rect.top;

            if (x > 290 && x < 520 && y > 140 && y < 210) {
                infoBox.style.left = (x + 10) + "px";
                infoBox.style.top = (y + 10) + "px";
                infoBox.style.display = "block";
            } else {
                infoBox.style.display = "none";
            }
        });

        mapPanel.addEventListener("mouseleave", function () {
            infoBox.style.display = "none";
        });
    </script>
</asp:Content>
