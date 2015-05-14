using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebAdmin.Classes;

namespace WebAdmin
{
    public partial class Scheduler : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AutoGenNotification();
        }

        private void AutoGenNotification()
        {
            if (Request.IsLocal)
            {
                string strConnString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                List<NotificationAutoGen> notifItems = new List<NotificationAutoGen>();
                DataSet data;
                DataTable table;

                string query = "[GetAutoRequestsFromStack]";
                SqlCommand cmd = new SqlCommand(query);
                cmd.CommandType = CommandType.StoredProcedure;
                data = GetDataReports(cmd);
                table = data.Tables[0];

                foreach (DataRow row in table.Rows)
                {

                    notifItems.Add(new NotificationAutoGen() { StackID = row.Field<int>(0), ClientID = row.Field<int>(1), DistID = row.Field<int>(2), CreationDate = row.Field<DateTime>(4), Type = "AutoGen"});
                }

                Application["AGN"] = notifItems;
            }
        }

        //[WebMethod]
        //public static string SchedulerNotification(string user, string pass)
        //{
        //    if (Membership.ValidateUser(user, pass))
        //    {
        //        FormsAuthentication.SetAuthCookie(username, true);
        //    }
        //    string query = "[GetAutoRequestsFromStack]";
        //    SqlCommand cmd = new SqlCommand(query);
        //    cmd.CommandType = CommandType.StoredProcedure;
        //    cmd.Parameters.AddWithValue("@Days", Convert.ToInt32(days));
        //    return GetDataReports(cmd).GetXml();
        //}

        private static DataSet GetDataReports(SqlCommand cmd)
        {
            string strConnString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            cmd.Connection = con;
            try
            {
                SqlDataAdapter custDA = new SqlDataAdapter();
                custDA.SelectCommand = cmd;

                con.Open();

                DataSet custDS = new DataSet();
                custDA.Fill(custDS, "Notifications");

                con.Close();
                con.Dispose();

                return custDS;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}