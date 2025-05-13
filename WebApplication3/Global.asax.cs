using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace WebApplication3
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Uygulama başlangıcında çalışan kod
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            string dilekPath = HttpRuntime.AppDomainAppPath + "App_Data\\dilekler.csv";
            Hashtable dilekListesi = new Hashtable();

            if (System.IO.File.Exists(dilekPath))
            {
                string[] lines = System.IO.File.ReadAllLines(dilekPath);
                for (int i = 1; i < lines.Length; i++)
                {
                    string[] parts = lines[i].Split(new[] { "\",\"" }, StringSplitOptions.None);
                    if (parts.Length >= 2)
                    {
                        string zaman = parts[0].Trim('"');
                        string mesaj = parts[1].Trim('"');

                        string key = "dilek_" + zaman.Replace(" ", "_").Replace(":", "_").Replace("-", "_");
                        dilekListesi[key] = mesaj;
                    }
                }
            }
            Application["DilekListesi"] = dilekListesi;

            // === DUYURULAR ===
            string duyuruPath = HttpRuntime.AppDomainAppPath + "App_Data\\duyurular.csv";
            Hashtable duyuruListesi = new Hashtable();

            if (System.IO.File.Exists(duyuruPath))
            {
                string[] lines = System.IO.File.ReadAllLines(duyuruPath);
                for (int i = 1; i < lines.Length; i++)
                {
                    string[] parts = lines[i].Split(new[] { "\",\"" }, StringSplitOptions.None);
                    if (parts.Length >= 3)
                    {
                        string zaman = parts[0].Trim('"');
                        string baslik = parts[1].Trim('"');
                        string icerik = parts[2].Trim('"');

                        string key = "duyuru_" + zaman.Replace(" ", "_").Replace(":", "_").Replace("-", "_");
                        string duyuruMetni = "📌 <b>" + baslik + "</b><br/>" + icerik;
                        duyuruListesi[key] = duyuruMetni;
                    }
                }
            }
            Application["Duyurular"] = duyuruListesi;
        }

    }
    }
