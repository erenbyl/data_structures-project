<%@ Page Language="C#" AutoEventWireup="true" CodeFile="giris.aspx.cs" Inherits="giris" %>

<!DOCTYPE html>
<html lang="tr">
<head runat="server">
  <meta charset="UTF-8" />
  <title>Giriş Yap</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f5f5f5;
    }

    .login-container {
      max-width: 400px;
      margin: 100px auto;
      padding: 30px;
      background-color: white;
      border-radius: 10px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }

    .form-control:focus {
      box-shadow: none;
      border-color: #007bff;
    }

    h2 {
      text-align: center;
      margin-bottom: 20px;
    }
  </style>
</head>
<body>
  <form id="form1" runat="server">
    <div class="login-container">
      <h2>Giriş Yap</h2>

      <div class="mb-3">
        <asp:Label ID="lblUsername" runat="server" Text="Kullanıcı Adı"></asp:Label>
        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Kullanıcı adınızı girin"></asp:TextBox>
      </div>

      <div class="mb-3">
        <asp:Label ID="lblPassword" runat="server" Text="Şifre"></asp:Label>
        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Şifrenizi girin"></asp:TextBox>
      </div>

      <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-primary w-100" Text="Giriş Yap" OnClick="btnLogin_Click" />

      <asp:Label ID="lblMessage" runat="server" ForeColor="Red" CssClass="mt-3 d-block text-center" />
    </div>
  </form>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
