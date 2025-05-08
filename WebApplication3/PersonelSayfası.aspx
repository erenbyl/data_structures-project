<%@ Page Title="Personel Sayfası" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PersonelSayfası.aspx.cs" Inherits="WebApplication3.PersonelSayfası" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .main-container {
            padding: 20px;
        }

        .header {
            font-size: 18px;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 25px;
        }

        .panel-container {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
        }

        .panel {
            flex: 1;
            min-width: 300px;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.06);
        }

        .panel h3 {
            text-align: center;
            color: #34495e;
            margin-bottom: 20px;
        }

        .panel label {
            font-weight: bold;
            display: block;
            margin-bottom: 6px;
            color: #333;
        }

        .panel textarea,
        .panel input[type="text"] {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 1rem;
            margin-bottom: 15px;
            box-sizing: border-box;
        }

        .btn-primary {
            background-color: #4a90e2;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 6px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
            width: 100%;
        }

        .btn-primary:hover {
            background-color: #3b7dd8;
        }

        .status-label {
            font-weight: bold;
            color: green;
            margin-bottom: 10px;
            display: block;
            text-align: center;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="main-container">
        <!-- Personel Adı -->
        <div class="header">
            Personel Adı: <span style="font-style: italic; font-weight: normal;">
                <asp:Label ID="lblPersonelAdi" runat="server" />
            </span>
        </div>

        <!-- Paneller -->
        <div class="panel-container">
            <!-- Dilek-Şikayet Paneli -->
            <div class="panel">
                <h3>DİLEK - ŞİKAYET</h3>
                <asp:TextBox ID="txtSikayet" runat="server" TextMode="MultiLine" Rows="20" />
            </div>

            <!-- Duyuru Paneli -->
            <div class="panel">
                <h3>DUYURU EKLEME SİSTEMİ</h3>
                <label for="txtBaslık">Duyuru Başlığı</label>
                <asp:TextBox ID="txtBaslık" runat="server" />

                <label for="txtIcerik">Duyuru İçeriği</label>
                <asp:TextBox ID="txtIcerik" runat="server" TextMode="MultiLine" Rows="10" />

                <asp:Label ID="lblDurum" runat="server" CssClass="status-label" />

                <asp:Button ID="btnDuyuruKaydet" runat="server" Text="Kaydet" CssClass="btn-primary" OnClick="btnDuyuruKaydet_Click" />
            </div>
        </div>
    </div>
</asp:Content>
