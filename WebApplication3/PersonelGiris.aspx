<%@ Page Title="Personel Giriş" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="PersonelGiris.aspx.cs" Inherits="WebApplication3.PersonelGiris" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .login-container {
            background-color: white;
            max-width: 400px;
            margin: 60px auto;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .login-container h2 {
            text-align: center;
            margin-bottom: 25px;
            font-weight: bold;
            color: #2c3e50;
        }

        .login-container label {
            font-weight: bold;
            color: #333;
            margin-top: 10px;
            display: block;
        }

        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 6px;
            border: 1px solid #ccc;
            margin-bottom: 15px;
            font-size: 1rem;
        }

        .login-container input[type="submit"] {
            background-color: #4a90e2;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 6px;
            width: 100%;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .login-container input[type="submit"]:hover {
            background-color: #3b7dd8;
        }
    </style>

    <div class="login-container">
        <h2>👤 PERSONEL GİRİŞ</h2>

        <asp:Label ID="lblKullanici" runat="server" Text="Personel Adı:" AssociatedControlID="txtKullanici" />
        <asp:TextBox ID="txtKullanici" runat="server" CssClass="form-control" />

        <asp:Label ID="lblSifre" runat="server" Text="Şifre:" AssociatedControlID="txtSifre" />
        <asp:TextBox ID="txtSifre" runat="server" TextMode="Password" CssClass="form-control" />

        <asp:Button ID="btnGiris" runat="server" Text="Giriş Yap" OnClick="btnGiris_Click" />
    </div>
</asp:Content>
