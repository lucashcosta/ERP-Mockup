using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using WebAdmin;
using System.Data.SqlClient;
using System.Globalization;
using System.Data;

namespace WebAdmin
{
    public class Global : HttpApplication
    {
        private static String connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            AuthConfig.RegisterOpenAuth();
            RouteConfig.RegisterRoutes(RouteTable.Routes);
        }

        void Application_End(object sender, EventArgs e)
        {
            //  Code that runs on application shutdown

        }

        void Application_Error(object sender, EventArgs e)
        {
            // Code that runs when an unhandled error occurs

        }

        void Session_Start()
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                if (Session["UserBinds"] == null)
                    Session["UserBinds"] = getUserBinds();
        }

        public static string[] getUserBinds()
        {
            SqlCommand cmd;
            string strQuery = "SELECT [id_distribuidor], [id_marca], [nombre_marca] FROM [dbo].[DistribuidoresClientes] WHERE UserName = '" + HttpContext.Current.User.Identity.Name + "'";
            cmd = new SqlCommand(strQuery);
            DataTable user = GetData(cmd);
            string idBrand = user.Rows[0].Field<int>("id_marca").ToString();
            string idDist = user.Rows[0].Field<int>("id_distribuidor").ToString();
            string nameBrand = user.Rows[0].Field<string>("nombre_marca");

            return new string[] { idBrand, idDist, nameBrand };
        }

        private static DataTable GetData(SqlCommand cmd)
        {
            DataTable dt = new DataTable();
            SqlConnection con = new SqlConnection(connectionString);
            SqlDataAdapter sda = new SqlDataAdapter();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            con.Open();
            sda.SelectCommand = cmd;
            sda.Fill(dt);
            return dt;
        }

    }
}
