<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PersonelSayfası.aspx.cs" Inherits="WebApplication3.PersonelSayfası" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .main-container {
            width: 95%;
            margin: auto;
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 8px rgba(0, 0, 0, 0.2);
        }

        .header {
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .header label {
            font-size: 18px;
            font-weight: bold;
            font-style: italic;
        }

        .header input[type="text"] {
            width: 200px;
            padding: 5px;
        }

        .panel-container {
            display: flex;
            justify-content: space-between;
            gap: 30px;
        }

        .panel {
            flex: 1;
            background-color: #dcdcdc;
            padding: 20px;
            border: 1px dashed #999;
            border-radius: 5px;
        }

        .panel h3 {
            text-align: center;
            margin-top: 0;
        }

        .panel textarea,
        .panel input[type="text"] {
            width: 100%;
            padding: 8px;
            margin-top: 10px;
            box-sizing: border-box;
        }

        .panel button,
        .panel .btn {
            display: block;
            margin: 20px auto 0 auto;
            padding: 10px 20px;
            background-color: #c2d4e6;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .panel button:hover {
            background-color: #a2bddc;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="main-container">
        <!-- Personel Adı -->
        <div class="header">
            <label for="txtPersonelAdi" style="font-weight:bold; font-style:italic;">Personel Adı:</label>
<asp:Label ID="lblPersonelAdi" runat="server" Style="font-weight:normal; font-style:italic;" />


        </div>

        <!-- Dilek-Şikayet ve Duyuru -->
        <div class="panel-container">
            <!-- Dilek-Şikayet -->
            <div class="panel">
                <h3>DİLEK-ŞİKAYET</h3>
              
                <asp:TextBox ID="txtSikayet" runat="server" TextMode="MultiLine" Rows="22" />
            </div>

            <!-- Duyuru -->
            <div class="panel">
                <h3>DUYURU EKLEME SİSTEMİ</h3>
                <label>Duyuru Başlığı</label>
                <asp:TextBox ID="txtBaslık" runat="server" /><br />
                <label>Duyuru İçeriği</label>
                <asp:TextBox ID="txtIcerik" runat="server" TextMode="MultiLine" Rows="15" /><br />
                 <asp:Label ID="lblDurum" runat="server" ForeColor="Green"></asp:Label><br /><br />
               <asp:Button ID="btnDuyuruKaydet" runat="server" Text="Kaydet" OnClick="btnDuyuruKaydet_Click" />

               

            </div>
        </div>
    </div>
</asp:Content>

