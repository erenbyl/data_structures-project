<%@ Page Title="Acil Durumlar" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AcilDurum.aspx.cs" Inherits="WebApplication3.AcilDurum" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="server">
    <title>Acil Durum Bildirimi</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet" />
    <style>
        * { box-sizing: border-box; }
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(to right, #eef2f3, #f9f9f9);
            margin: 0;
            padding: 30px;
        }
        .panel {
            max-width: 600px;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 25px 30px;
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.08);
            margin-bottom: 20px;
        }
        h2, h3 { 
            color: #DC3545; 
            margin-bottom: 20px; 
            font-size: 22px;
        }
        label {
            font-weight: 600;
            display: block;
            margin-top: 15px;
        }
        input[type="text"], select {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            border-radius: 8px;
            border: 1px solid #ccc;
            transition: border 0.3s ease;
        }
        input[type="text"]:focus, select:focus {
            border-color: #DC3545;
            outline: none;
        }
        .btn {
            margin-top: 20px;
            width: 100%;
            padding: 12px;
            font-size: 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .btn-send {
            background-color: #DC3545;
            color: white;
        }
        .btn-send:hover {
            background-color: #c82333;
        }
        .result-msg {
            display: block;
            margin-top: 15px;
            padding: 12px;
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            border-radius: 8px;
            color: #155724;
            text-align: center;
            font-weight: 600;
        }
        .error-msg {
            color: red;
            font-weight: bold;
        }
        .ihbar-kutu {
            border: 2px solid #DC3545;
            border-radius: 4px;
            background-color: #ffffff;
            padding: 10px;
            margin-top: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow-x: auto;
            width: 100%;
            box-sizing: border-box;
            word-break: break-word;
            white-space: normal;
        }
        .ihbar-kutu ul {
            padding: 0;
            margin: 0;
            list-style: none;
        }
        .ihbar-kutu li {
            background-color: #ffe5e5;
            padding: 5px;
            margin-bottom: 5px;
            border-radius: 4px;
            font-size: 14px;
            word-break: break-word;
            white-space: normal;
        }
        .ihbar-kutu li:hover {
            background-color: #f28b82;
        }
    </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="panel">
        <h2>Acil Durum Bildir</h2>
        <label>Acil Durum Türü:</label>
        <asp:DropDownList ID="ddlTur" runat="server">
            <asp:ListItem Text="Deprem" Value="Deprem" />
            <asp:ListItem Text="Yangın" Value="Yangın" />
            <asp:ListItem Text="Sel" Value="Sel" />
            <asp:ListItem Text="Heyelan" Value="Heyelan" />
            <asp:ListItem Text="Trafik Kazası" Value="Trafik Kazası" />
        </asp:DropDownList>

        <label>Konum:</label>
        <asp:DropDownList ID="ddlKonum" runat="server">
            <asp:ListItem Text="Ulutepe" Value="Ulutepe" />
            <asp:ListItem Text="Gölpınar" Value="Gölpınar" />
            <asp:ListItem Text="Yeşilvadi" Value="Yeşilvadi" />
            <asp:ListItem Text="Serinova" Value="Serinova" />
            <asp:ListItem Text="Akçadere" Value="Akçadere" />
            <asp:ListItem Text="Yıldızkent" Value="Yıldızkent" />
        </asp:DropDownList>

        <asp:Button ID="Button1" runat="server" Text="Gönder" OnClick="btnGonder_Click" CssClass="btn btn-send" />
        <asp:Label ID="lblSonuc" runat="server" CssClass="result-msg" Visible="false" />
    </div>

    <div class="panel">
        <h2>Gelen İhbarları Görüntüle</h2>
        <label for="txtKod">Ekip Kodu Girin:</label>
        <asp:TextBox ID="txtKod" runat="server" />
        <asp:Button ID="btnKodGiris" runat="server" Text="Doğrula" OnClick="btnKodGiris_Click" CssClass="btn btn-send" />
        <asp:Label ID="lblKodSonuc" runat="server" CssClass="error-msg" Visible="false" />
    </div>

    <div class="panel">
        <asp:Panel ID="gelenIhbarlarPanel" runat="server" Visible="false" CssClass="ihbar-kutu">
            <h3>Gelen İhbarlar</h3>
            <asp:Literal ID="litListe" runat="server" Text="" />
        </asp:Panel>
    </div>
</asp:Content>
