using System;

public partial class giris : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // İsteğe bağlı: sayfa yenilendiğinde mesaj sıfırlansın
        lblMessage.Text = "";
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string kullanici = txtUsername.Text.Trim();
        string sifre = txtPassword.Text.Trim();

        if (kullanici == "umut" && sifre == "0909")
        {
            Session["admin"] = true; // oturum başlat
            Response.Redirect("umut.aspx"); // giriş başarılıysa umut.aspx'e yönlendir
        }
        else
        {
            lblMessage.Text = "Kullanıcı adı veya şifre yanlış!";
        }
    }
}
