<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="WebApplication1.WebForm2" %>

<!DOCTYPE html>
<html lang="tr">
<head runat="server">
  <meta charset="UTF-8" />
  <title>AKILLI ŞEHİR YÖNETİMİ</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
    }
    .navbar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      background-color: lightgoldenrodyellow;
      padding: 40px 40px;
    }
    .nav-links {
      display: flex;
      gap: 40px;
    }
    .nav-links a {
      text-decoration: none;
      color: #333;
      font-weight: bold;
    }
    .nav-links a:hover {
      color: #f26522;
    }
  </style>
</head>
<body>
  <form id="form1" runat="server">
    <div class="navbar">
      <div class="logo">
           <img src="" alt="Logo" style="height: 60px;"><strong>AKILLI ŞEHİR</strong></div>
      <div class="nav-links">
        <a href="#">Toplu Taşıma</a>
        <a href="#">Acil Durum</a>
        <a href="umut.aspx">Dijital Kütüphane</a>
        <a href="#">Stok Yönetimi</a>
      </div>
    </div>
  </form>
</body>
</html>
