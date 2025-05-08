<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="Acildurum.WebForm1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Acil Durum Bildirimi</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet"/>
        <style>

        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(to right, #eef2f3, #f9f9f9);
            margin: 0;
            padding: 30px;
        }

        .panel {
            max-width: 600px;
            margin: 0 auto;
            background-color:#ffffff;
            padding: 25px 30px;
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.08);
        }

        h2, h3 {
            color: #DC3545;
            margin-bottom: 20px;
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
            background-color: #DC3545;
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

        .loading-msg {
            background-color: #fff3cd;
            color: #856404;
            border: 1px solid #ffeeba;
            padding: 10px;
            border-radius: 6px;
            margin-top: 10px;
            text-align: center;
            font-weight: bold;
        }

        ul {
            padding-left: 20px;
            margin-top: 10px;
            list-style-type: square;
            font-size:16px;
        }

            .panel-section {
                margin-bottom: 50px;
            }
        .error-msg {
            color: red;
            font-weight: bold;
        }

        .gelen-ihbarlar-panel {
            display: none;
           
        }

        .gelen-ihbarlar-panel.active {
            display: block;
        }

            .ihbar-kutu {
                border: 2px solid #DC3545; /* Kutu kenarlığı */
                border-radius: 4px; /* Yuvarlak köşeler */
                background-color: #ffffff; /* Arka plan rengi */
                padding: 10px; /* İç boşluk */
                margin-top: 20px; /* Üstten boşluk */
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Hafif gölge */
                /*  width: 600px;*/
                overflow-x: auto;
                width: 100%;
                max-width: 100%;
                box-sizing: border-box;
                word-break: break-word;
                white-space: normal;
                margin-top: 20px;
            }

/* Liste elemanlarının tasarımı */
.ihbar-kutu ul {
    padding: 0;
    margin: 0;
    list-style: none;/* İçerideki boşlukları kaldır */
}

.ihbar-kutu li {
    background-color: #ffe5e5; /* List item arka plan rengi */
    padding: 5px; /* İç boşluk */
    margin-bottom: 5px; /* Alt boşluk */
    border-radius: 4px; /* Yuvarlatılmış köşeler */
    font-size: 14px; /* Yazı boyutu */
    word-break: break-word;
    white-space: normal;
    
}


.ihbar-kutu li:hover {
    background-color: #f28b82; /* Hover durumu */
}

    /* Kutu tasarımı */


        
</style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="panel panel-section">
            <h2> Acil Durum Bildir</h2>

            <label>Acil Durum Türü:</label>
            <asp:DropDownList ID="ddlTur" runat="server">
                <asp:ListItem Text="Deprem" Value="Deprem" />
                <asp:ListItem Text="Yangın" Value="Yangın" />
                <asp:ListItem Text="Sel" Value="Sel" />
                <asp:ListItem Text="Heyelan" Value="Heyelan" />
                <asp:ListItem Text="Trafik Kazası" Value="Trafik Kazası" />
            </asp:DropDownList>
             <!-- <label>Konum:</label>
             <asp:TextBox ID="txtKonum" runat="server" />-->
            <label>Konum</label>
            <asp:DropDownList ID="ddlKonum" runat="server">
           <asp:ListItem Text="Ulutepe" Value="Ulutepe" />
           <asp:ListItem Text="Gölpınar " Value="Gölpınar " />
           <asp:ListItem Text="Yeşilvadi " Value="Yeşilvadi " />
            <asp:ListItem Text="Akçadere" Value="Akçadere" />
            <asp:ListItem Text="Yıldızkent " Value="Yıldızkent " />
           </asp:DropDownList>


            <asp:Button ID="Button1" runat="server" Text="Gönder" OnClick="btnGonder_Click" CssClass="btn btn-send"  />

            <asp:Label ID="lblSonuc" runat="server" CssClass="result-msg" Visible="false" />

            </div>
   <!-- Ekip Girişi Paneli (Şifre Doğrulama) -->
        <div class="panel">
            <h2>Gelen İhbarları Görüntüle</h2>
            <label for="txtKod">Ekip Kodu Girin:</label>
            <asp:TextBox ID="txtKod" runat="server" />
            <asp:Button ID="btnKodGiris" runat="server" Text="Doğrula"  OnClick="btnKodGiris_Click" CssClass="btn btn-send"  />
            <asp:Label ID="lblKodSonuc" runat="server" CssClass="error-msg" Visible="false" />
        </div>
        <div class="panel">
          <asp:Panel ID="gelenIhbarlarPanel" runat="server" Visible="false"  CssClass="ihbar-kutu">
          <h3>Gelen İhbarlar</h3>
          <asp:Literal ID="litListe" runat="server" Text=""></asp:Literal>
          </asp:Panel>
        </div>
        
        
    </form>
</body>
</html>
