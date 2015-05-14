using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace WebAdmin
{
    public partial class GridDrop : System.Web.UI.Page
    {
        private String connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                BindDropDown();
            }
        }

        private void BindDropDown()
        {
            string strQuery = "SELECT [id_marca] ,[nombre_marca], [estaPublicado_marca] FROM [dbo].[Marcas]";
            SqlCommand cmd = new SqlCommand(strQuery);
            brandDrop.DataSource = GetData(cmd);
            brandDrop.DataTextField = "nombre_marca";
            brandDrop.DataValueField = "id_marca";
            brandDrop.DataBind();
        }

        private DataTable GetData(SqlCommand cmd)
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

        private void DeleteBrand(int id)
        {
            SqlConnection connection = new SqlConnection(connectionString);
            try
            {
                connection.Open();

                string sql_command = "DELETE FROM Marcas WHERE id_marca=" + id;
                SqlCommand cmd = new SqlCommand(sql_command, connection);
                //cmd.Parameters.RemoveAt("@id_marca", );
                cmd.ExecuteNonQuery();
                cmd.Dispose();
            }
            catch (SqlException s_exp)
            {
                Response.Write(s_exp);
            }
        }

        protected void deleteBrandBtn_Click(object sender, EventArgs e)
        {
            if (brandDrop.SelectedItem != null)
            {
                if (brandDrop.SelectedValue == "Selecciona marca")
                    return;
                DeleteBrand(int.Parse(brandDrop.SelectedValue));
                brandDrop.Items.Remove(brandDrop.SelectedItem);
            }
        }
    }
}