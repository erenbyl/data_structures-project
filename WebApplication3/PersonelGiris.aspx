<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PersonelGiris.aspx.cs" Inherits="WebApplication3.PersonelGiris" %>

<!DOCTYPE html>
<html lang="tr">
<head runat="server">
  <meta charset="utf-8" />
  <title>Personel Girişi</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      margin: 0;
      padding: 0;
    }

    .center-container {
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    .login-panel {
      background-color: #ccc;
      padding: 40px;
      border-radius: 8px;
      width: 400px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .login-panel h2 {
      text-align: center;
      margin-bottom: 30px;
    }

    .login-panel label {
      font-weight: bold;
      display: block;
      margin-top: 15px;
      margin-bottom: 5px;
    }

    .login-panel input[type="text"],
    .login-panel input[type="password"] {
      width: 100%;
      padding: 10px;
      border: 1px solid #aaa;
      border-radius: 4px;
    }

    .login-panel input[type="submit"],
    .login-panel button {
      margin-top: 25px;
      width: 100%;
      padding: 10px;
      background-color: #c2d4e6;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-weight: bold;
    }

    .login-panel input[type="submit"]:hover,
    .login-panel button:hover {
      background-color: #a2bddc;
    }
  </style>
</head>
<body>
  <form id="form1" runat="server">
    <div class="center-container">
      <div class="login-panel">
        <h2>PERSONEL GİRİŞ</h2>

        <label for="txtKullanici">Personel Adı:</label>
        <asp:TextBox ID="txtKullanici" runat="server" />

        <label for="txtSifre">Şifre:</label>
        <asp:TextBox ID="txtSifre" runat="server" TextMode="Password" />

        <asp:Button ID="btnGiris" runat="server" Text="Giriş Yap" OnClick="btnGiris_Click" />
      </div>
    </div>
  </form>
</body>
</html>
