<%@ Page Title="Toplu Taşıma" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="TopluTasima.aspx.cs" Inherits="WebApplication3.TopluTasima" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f0fa;
        }

        h1 {
            text-align: center;
            margin-top: 40px;
            color: #4a90e2;
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

        .image-box {
            position: relative;
        }

        .image-box img {
            width: 500px;
            height: auto;
            border-radius: 20px;
            box-shadow: 0 0 20px rgba(0,0,0,0.2);
        }

        .tooltip-dot {
            position: absolute;
            width: 20px;
            height: 20px;
            background-color: transparent;
            border-radius: 50%;
            cursor: default;
            transform: translate(-50%, -50%);
            pointer-events: auto;
        }

        .tooltip-dot:hover .tooltip-text {
            opacity: 1;
            visibility: visible;
        }

        .tooltip-text {
            position: absolute;
            top: -35px;
            left: 50%;
            transform: translateX(-50%);
            background-color: #333;
            color: #fff;
            padding: 5px 10px;
            border-radius: 8px;
            white-space: nowrap;
            font-size: 13px;
            opacity: 0;
            visibility: hidden;
            transition: opacity 0.3s;
        }

        .tooltip-text::after {
            content: '';
            position: absolute;
            top: 100%;
            left: 50%;
            margin-left: -5px;
            border-width: 6px;
            border-style: solid;
            border-color: #333 transparent transparent transparent;
        }

        .form-box {
            background-color: #add8e6;
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
            color: #4a90e2;
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
            background-color: #4a90e2;
            color: white;
            font-weight: bold;
            cursor: pointer;
            margin-top: 25px;
            border: none;
            transition: background-color 0.3s ease;
        }

        .form-box input[type="submit"]:hover {
            background-color: #388e3c;
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
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Nasıl Gidilir ?</h1>
    <hr />
    <div class="container">
        <div class="image-box">
            <img src="https://raw.githubusercontent.com/erenbyl/data_structures-project/Ssemanurr-patch-1/Images/Sehir_Haritas%C4%B1_Durakl%C4%B1.png" alt="Otobüs Durakları" />

            <!-- Tooltip noktaları -->
            <div class="tooltip-dot" style="top: 35px; left: 75px;">
                <div class="tooltip-text">Okul Durağı</div>
            </div>
            <div class="tooltip-dot" style="top: 35px; left: 250px;">
                <div class="tooltip-text">Park Durağı</div>
            </div>
            <div class="tooltip-dot" style="top: 35px; left: 480px;">
                <div class="tooltip-text">Stadyum Durağı</div>
            </div>
            <div class="tooltip-dot" style="top: 130px; left: 135px;">
                <div class="tooltip-text">Hastane Durağı</div>
            </div>
            <div class="tooltip-dot" style="top: 250px; left: 200px;">
                <div class="tooltip-text">Veteriner Durağı</div>
            </div>
            <div class="tooltip-dot" style="top: 230px; left: 460px;">
                <div class="tooltip-text">Market Durağı</div>
            </div>
            <div class="tooltip-dot" style="top: 240px; left: 275px;">
                <div class="tooltip-text">Belediye Durağı</div>
            </div>
        </div>

        <div class="form-box">
            <label>Nereden?</label>
            <asp:DropDownList ID="ddlNereden" runat="server">
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
        <asp:Label ID="lblSonuc" runat="server" Text="" />
    </div>
</asp:Content>
