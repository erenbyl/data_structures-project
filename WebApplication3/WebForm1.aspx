<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="WebApplication3.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .card-container {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 50px;
            flex-wrap: wrap;
        }

        .card {
            width: 300px;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            overflow: hidden;
            transition: transform 0.3s;
        }

        .card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card-title {
            padding: 15px;
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <div class="hero-section">
    AKILLI ŞEHİR PROJESİ
</div>
    <h3>📢 Duyurular</h3>
    <asp:Literal ID="litDuyurular" runat="server" />
     

 <!-- İçerik -->
 <div class="main-content">
   
    <div class="card-container">
        <div class="card">
           
            <div class="card-title">Dilara</div>
        </div>
        <div class="card">
            
            <div class="card-title">Cömert</div>
        </div>
        <div class="card">
            
            <div class="card-title">Berra Akman</div>
        </div>
    </div>
</asp:Content>
