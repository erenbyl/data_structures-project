<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TopluTasimaS.aspx.cs" Inherits="WebApplication1.TopluTasimaS" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Toplu Taşıma</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f0fa;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            margin-top: 40px;
            color: #6a5acd;
            font-size: 36px;
        }

        .container {
            display: flex;
            justify-content: center;
            align-items: flex-start;
            gap: 80px;
            padding: 60px 100px;
            max-width: 1400px;
            margin: auto;
        }

        .image-box img {
            width: 500px;
            height: auto;
            border-radius: 20px;
            box-shadow: 0 0 20px rgba(0,0,0,0.2);
        }

        .form-box {
            background-color: #e0e7ff;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            width: 400px;
        }

        .form-box label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
            font-size: 16px;
            color: #4b3f72;
        }

        .form-box select,
        .form-box button,
        .form-box input[type="submit"] {
            width: 100%;
            padding: 12px;
            margin-top: 8px;
            border-radius: 10px;
            border: 1px solid #ccc;
            font-size: 15px;
        }

        .form-box button,
        .form-box input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            font-weight: bold;
            cursor: pointer;
            margin-top: 25px;
            border: none;
            transition: background-color 0.3s ease;
        }

        .form-box input[type="submit"]:hover {
            background-color: #45a049;
        }

        .result-box {
            max-width: 800px;
            margin: 40px auto;
            background-color: #fff;
            padding: 25px;
            border-radius: 20px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            text-align: center;
            font-size: 18px;
            color: #333;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h1>Nasıl Gidilir ?</h1>
        <hr />
        <div class="container">
            <div class="image-box">
                <img src="Images/Sehir_Haritası_Duraklı.png" alt="Otobüs Durakları" title="Otobüs Durakları" />
            </div>
            <div class="form-box">
                <label>Nereden?</label>
                <asp:DropDownList ID="ddlNereden" runat="server">
                    <asp:ListItem Text="Seçiniz" Value="" />
                    <asp:ListItem>Hastane Durağı</asp:ListItem>
                    <asp:ListItem>Okul Durağı</asp:ListItem>
                    <asp:ListItem>Park Durağı</asp:ListItem>
                    <asp:ListItem>Stadyum Durağı</asp:ListItem>
                    <asp:ListItem>Market Durağı</asp:ListItem>
                    <asp:ListItem>Belediye Durağı</asp:ListItem>
                    <asp:ListItem>Veteriner Durağı</asp:ListItem>
                </asp:DropDownList>

                <label>Nereye?</label>
                <asp:DropDownList ID="ddlNereye" runat="server">
                    <asp:ListItem Text="Seçiniz" Value="" />
                    <asp:ListItem>Hastane Durağı</asp:ListItem>
                    <asp:ListItem>Okul Durağı</asp:ListItem>
                    <asp:ListItem>Park Durağı</asp:ListItem>
                    <asp:ListItem>Stadyum Durağı</asp:ListItem>
                    <asp:ListItem>Market Durağı</asp:ListItem>
                    <asp:ListItem>Belediye Durağı</asp:ListItem>
                    <asp:ListItem>Veteriner Durağı</asp:ListItem>
                </asp:DropDownList>

                <asp:Button ID="btnSorgula" runat="server" Text="Sorgula" OnClick="btnSorgula_Click" />
            </div>
        </div>

        <div class="result-box">
            <asp:Label ID="lblSonuc" runat="server" Text=" " />
        </div>
    </form>
</body>
</html>
