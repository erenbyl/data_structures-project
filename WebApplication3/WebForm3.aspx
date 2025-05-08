<%@ Page Title="Akıllı İlaç ve Nöbetçi Eczane Sistemi" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="WebForm3.aspx.cs" Inherits="WebApplication3.WebForm3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f4f7fc;
        }

        .container {
            padding: 30px;
        }

        .section {
            background: #ffffff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            margin-bottom: 25px;
            transition: box-shadow 0.3s ease-in-out;
        }

        .section:hover {
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.12);
        }

        h3 {
            color: #2b2b2b;
            font-size: 1.6rem;
            font-weight: 600;
            margin-bottom: 20px;
        }

        h4 {
            color: #444;
            font-size: 1.2rem;
            font-weight: 600;
            margin-top: 20px;
        }

        .form-inline {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            align-items: center;
        }

        .form-control {
            padding: 10px 12px;
            border-radius: 8px;
            border: 1px solid #ccc;
            width: 100%;
            max-width: 250px;
            transition: border 0.3s;
        }

        .form-control:focus {
            border-color: #007bff;
            outline: none;
        }

        .btn-modern {
            background: linear-gradient(135deg, #4e9af1, #007bff);
            color: #fff;
            border: none;
            padding: 10px 20px;
            font-weight: 600;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 123, 255, 0.3);
            transition: background 0.3s ease, transform 0.2s ease;
        }

        .btn-modern:hover {
            background: linear-gradient(135deg, #3c85e5, #0069d9);
            transform: translateY(-2px);
        }

        .btn-custom {
            width: 100%;
            max-width: 300px;
            padding: 12px;
            font-size: 1rem;
            border-radius: 8px;
        }

        .list-group {
            padding-left: 20px;
        }

        .mb-2 {
            margin-bottom: 10px;
        }

        .mt-3 {
            margin-top: 20px;
        }

        .mt-4 {
            margin-top: 30px;
        }

        @media (max-width: 600px) {
            .form-inline {
                flex-direction: column;
                align-items: stretch;
            }
        }
    </style>

    <div class="container">
        <div class="section">
            <h3>👥 Vatandaş - İlaç Arama</h3>
            <div class="form-inline">
                <asp:TextBox ID="txtSearchMedicine" runat="server" CssClass="form-control" Placeholder="İlaç adı giriniz..."></asp:TextBox>
                <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-modern" Text="🔍 Ara" OnClick="btnSearch_Click" />
            </div>
            <asp:Literal ID="litSearchResult" runat="server" />
        </div>

        <div class="section">
            <h3>📍 Nöbetçi Eczaneler</h3>
            <asp:BulletedList ID="bltDutyPharmacies" runat="server" CssClass="list-group" />
        </div>

        <div class="section">
            <h3>💼 Eczacı Girişi</h3>
            <div class="form-inline">
                <asp:TextBox ID="txtPharmacyName" runat="server" CssClass="form-control" Placeholder="Eczane adı giriniz"></asp:TextBox>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Şifre giriniz"></asp:TextBox>
                <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-modern" Text="🔑 Giriş" OnClick="btnLogin_Click" />
            </div>
            <asp:Literal ID="litLoginStatus" runat="server" />

            <asp:Panel ID="pnlPharmacist" runat="server" CssClass="mt-3" Visible="false">
                <h4>📦 Stok Güncelleme</h4>
                <asp:TextBox ID="txtMedicineName" runat="server" CssClass="form-control mb-2" Placeholder="İlaç adı"></asp:TextBox>
                <asp:TextBox ID="txtStockCount" runat="server" CssClass="form-control mb-2" TextMode="Number" Placeholder="Stok (+ ekle, - çıkar)"></asp:TextBox>
                <asp:Button ID="btnUpdateStock" runat="server" CssClass="btn btn-warning btn-custom" Text="Stok Güncelle" OnClick="btnUpdateStock_Click" />
                <asp:Literal ID="litUpdateStatus" runat="server" />

                <h4 class="mt-4">🌙 Nöbetçi Eczane Yönetimi</h4>
                <asp:Button ID="btnToggleDuty" runat="server" CssClass="btn btn-info btn-custom" Text="Nöbetçi Durumunu Değiştir" OnClick="btnToggleDuty_Click" />
                <asp:Literal ID="litDutyStatus" runat="server" />
            </asp:Panel>
        </div>
    </div>
</asp:Content>