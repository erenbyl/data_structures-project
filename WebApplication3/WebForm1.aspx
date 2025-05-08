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
            background-size: cover; /* Haritayı panelin boyutlarına göre ölçeklendirir */
            background-repeat: no-repeat;
            background-position: center;
            height: 768px;
            border-radius: 10px;
            box-shadow: 0 0 8px rgba(0, 0, 0, 0.2);
            cursor: default; /* İmleci varsayılan yap */
        }

        #info-box {
            display: none;
            position: absolute;
            background-color: #ffffff;
            border: 1px solid #ddd;
            padding: 10px;
            font-size: 14px;
            border-radius: 6px;
            box-shadow: 0 0 6px rgba(0, 0, 0, 0.2);
            z-index: 10;
        }

        .info-section {
            background-color: #f9fafc;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 8px rgba(0,0,0,0.05);
        }

        /* Sağ Panel */
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

        /* Panel Toggle Button */
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
            <div id="info-box"></div>
        </div>

        <div class="info-section">
            <h2 style="color: #2c3e50; font-weight: bold;">📘 Akıllı Şehir Nedir?</h2>
            <p style="font-size: 16px; line-height: 1.7;">
                Şehirlerin küresel olarak birbirine bağlı bir ekonomide rekabet etme ve kent sakinlerinin refahını sürdürülebilir bir şekilde sağlayabilme ihtiyacı, ülkeleri ve şehirleri yeni teknoloji ve yenilikçi yaklaşımları değerlendirmeye yönlendirmektedir.
            </p>

            <h3 style="margin-top: 25px;">🎯 Amaçlar:</h3>
            <ul style="font-size: 16px; padding-left: 20px;">
                <li>✅ Şehir problemlerini tetikleyici güç haline getirmek</li>
                <li>✅ Fiziksel, sosyal ve dijital planlamayı bütünleşik düşünmek</li>
                <li>✅ Zorluklara sistematik, çevik ve sürdürülebilir çözümler sunmak</li>
                <li>✅ Organizasyonlar arası etkileşimle entegre hizmet sunmak</li>
            </ul>
        </div>
    </div>

    <button id="btnTogglePanel" type="button" onclick="toggleRightPanel()">
        📌 Paneli Aç / Kapat
    </button>

    <div class="right-panel" id="rightPanel">
        <h3>📢 Duyurular</h3>
        <asp:Literal ID="litDuyurular" runat="server" />

        <h3>✉️ Geri Bildirim</h3>
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

        const mapPanel = document.getElementById("mapPanel");
        const infoBox = document.getElementById("info-box");
        const buildingInfo = [
            { name: "Eren Eczanesi", xStart: 640, xEnd: 800, yStart: 300, yEnd: 390 },
            { name: "Hastane", xStart: 400, xEnd: 600, yStart: 400, yEnd: 470 },
            { name: "Dilara Eczanesi", xStart: 160, xEnd: 300, yStart: 480, yEnd: 570 },
            { name: "Umut Eczanesi", xStart: 160, xEnd: 300, yStart: 300, yEnd: 390 },
            { name: "Kütüphane", xStart: 860, xEnd: 1000, yStart: 300, yEnd: 420 },
            { name: "Acil Toplanma Alanı", xStart: 380, xEnd: 780, yStart: 0, yEnd: 250 },



            // Haritadaki diğer binalar için de benzer nesneler ekleyebilirsiniz.
        ];

        mapPanel.addEventListener("mousemove", function (e) {
            const rect = mapPanel.getBoundingClientRect();
            const mouseX = e.clientX - rect.left;
            const mouseY = e.clientY - rect.top;
            let hoveredBuilding = null;

            for (const building of buildingInfo) {
                if (mouseX > building.xStart && mouseX < building.xEnd &&
                    mouseY > building.yStart && mouseY < building.yEnd) {
                    hoveredBuilding = building;
                    break;
                }
            }

            if (hoveredBuilding) {
                infoBox.textContent = hoveredBuilding.name;
                infoBox.style.left = (mouseX + 10) + "px";
                infoBox.style.top = (mouseY + 10) + "px";
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