using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace WebApplication1
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            // Ana sayfa URL'si boşsa => Kutuphane/umut.aspx'e yönlendir
            routes.MapPageRoute(
                routeName: "KutuphaneyeYonlendir",
                routeUrl: "",
                physicalFile: "~/Kutuphane/umut.aspx"
            );

            // Diğer MVC controller yönlendirmesi (mevcut yapı bozulmuyor)
            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
