<%@ Page Title="Akıllı İlaç ve Nöbetçi Eczane Sistemi" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="WebForm3.aspx.cs" Inherits="WebApplication3.WebForm3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        <style>
        body { font-family: Arial, sans-serif; background: #f4f7fc; padding: 20px; }
        .section { background: #fff; padding: 20px; border-radius: 10px; box-shadow: 0 0 10px #ddd; margin-bottom: 20px; }
        h3 { color: #333; }
        .btn-custom { width: 100%; max-width: 300px; padding: 12px; }
   

        .section {
            background: #fff;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 10px;
            box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
        }

        h3 {
            font-size: 1.3rem;
            margin-bottom: 15px;
            font-weight: bold;
        }

        .form-inline input {
            display: inline-block;
            width: auto;
            margin-right: 5px;
        }

        .btn-custom {
            padding: 10px 15px;
            font-size: 1rem;
        }
    </style>

    <div class="container">
        <div class="section">
            <h3>👥 Vatandaş - İlaç Arama</h3>
            <div class="form-inline">
                <asp:TextBox ID="txtSearchMedicine" runat="server" CssClass="form-control" Placeholder="İlaç adı giriniz..."></asp:TextBox>
                <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-outline-secondary" Text="Ara" OnClick="btnSearch_Click" />
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
                <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-outline-secondary" Text="Giriş" OnClick="btnLogin_Click" />
            </div>
            <asp:Literal ID="litLoginStatus" runat="server" />

            <asp:Panel ID="pnlPharmacist" runat="server" CssClass="mt-3" Visible="false">
                <h4 class="mt-4">📦 Stok Güncelleme</h4>
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
