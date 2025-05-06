<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DilekSikayet.aspx.cs" Inherits="WebApplication3.DilekSikayet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="section">
        <h2>Dilek - Şikayet</h2>

       
        <label>Dilek veya şikayetinizi yazınız:</label><br />
        <asp:TextBox ID="txtDilek" runat="server" TextMode="MultiLine" Rows="6" Width="100%"></asp:TextBox><br /><br />
         <asp:Label ID="lblDurum" runat="server" ForeColor="Green" Font-Bold="true"></asp:Label><br /><br />

 

 

     

 <asp:Label ID="Label1" runat="server" ForeColor="Green"></asp:Label><br /><br />

        <asp:Button ID="btnGonder" runat="server" Text="Gönder" CssClass="btn" OnClick="btnGonder_Click" />

    </div>

</asp:Content>
