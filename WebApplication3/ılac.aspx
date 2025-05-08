<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WebForm3.aspx.cs" Inherits="WebApplication1.WebForm3" %>

<!DOCTYPE html>
<html lang="tr">
<head runat="server">
    <meta charset="utf-8" />
    <title>Akıllı İlaç ve Nöbetçi Eczane Sistemi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body { font-family: Arial, sans-serif; background: #f4f7fc; padding: 20px; }
        .section { background: #fff; padding: 20px; border-radius: 10px; box-shadow: 0 0 10px #ddd; margin-bottom: 20px; }
        h3 { color: #333; }
        .btn-custom { width: 100%; max-width: 300px; padding: 12px; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <!-- Vatandaş - İlaç Arama -->
            <div class="section">
                <h3>👥 Vatandaş - İlaç Arama</h3>
                <asp:TextBox ID="txtSearchMedicine" runat="server" CssClass="form-control mb-3" Placeholder="İlaç adı giriniz..."></asp:TextBox>
                <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-primary btn-custom" Text="Ara" OnClick="btnSearch_Click" />
                <asp:Literal ID="litSearchResult" runat="server" />
            </div>

            <!-- Nöbetçi Eczaneler -->
            <div class="section">
                <h3>📍 Nöbetçi Eczaneler</h3>
                <asp:BulletedList ID="bltDutyPharmacies" runat="server" CssClass="list-group" />
            </div>

            <!-- Eczacı Girişi -->
            <div class="section">
                <h3>💼 Eczacı Girişi</h3>
                <asp:TextBox ID="txtPharmacyName" runat="server" CssClass="form-control mb-2" Placeholder="Eczane adı giriniz"></asp:TextBox>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control mb-2" TextMode="Password" Placeholder="Şifre giriniz"></asp:TextBox>
                <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-success btn-custom" Text="Giriş Yap" OnClick="btnLogin_Click" />
                <asp:Literal ID="litLoginStatus" runat="server" />

                <asp:Panel ID="pnlPharmacist" runat="server" CssClass="mt-4" Visible="false">
                    <h3>📦 Stok Güncelleme</h3>
                    <asp:TextBox ID="txtMedicineName" runat="server" CssClass="form-control mb-2" Placeholder="İlaç adı"></asp:TextBox>
                    <asp:TextBox ID="txtStockCount" runat="server" CssClass="form-control mb-2" Placeholder="Stok (+ ekle, - çıkar)"></asp:TextBox>
                    <asp:Button ID="btnUpdateStock" runat="server" CssClass="btn btn-warning btn-custom" Text="Stok Güncelle" OnClick="btnUpdateStock_Click" />
                    <asp:Literal ID="litUpdateStatus" runat="server" />

                    <h3 class="mt-4">🌙 Nöbetçi Eczane Yönetimi</h3>
                    <asp:Button ID="btnToggleDuty" runat="server" CssClass="btn btn-info btn-custom" Text="Nöbetçi Durumunu Değiştir" OnClick="btnToggleDuty_Click" />
                    <asp:Literal ID="litDutyStatus" runat="server" />
                </asp:Panel>
            </div>
        </div>
    </form>
</body>
</html>