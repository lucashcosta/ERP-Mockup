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
    public partial class Catalogos : System.Web.UI.Page
    {
        private String connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                BindDropDown();
                BindTable();
                BindEditDropDown();
            }
        }

        // Filling fields
        private void BindDropDown()
        {
            string strQuery = "SELECT [id_marca] ,[nombre_marca], [estaPublicado_marca], [descripcion_marca] FROM [dbo].[Marcas]";
            SqlCommand cmd = new SqlCommand(strQuery);
            brandDrop.DataSource = GetData(cmd);
            brandDrop.DataTextField = "nombre_marca";
            brandDrop.DataValueField = "id_marca";
            brandDrop.DataBind();
        }

        private void BindTable()
        {
            string strQuery = "SELECT [id_marca] ,[nombre_marca], [estaPublicado_marca], [descripcion_marca] FROM [dbo].[Marcas]";
            SqlCommand cmd = new SqlCommand(strQuery);
            MarcasGridView.DataSource = GetData(cmd);
            MarcasGridView.DataBind();
        }

        private void BindEditDropDown()
        {
            string strQuery = "SELECT [id_marca] ,[nombre_marca], [estaPublicado_marca], [descripcion_marca] FROM [dbo].[Marcas]";
            SqlCommand cmd = new SqlCommand(strQuery);
            brandDropEdit.DataSource = GetData(cmd);
            brandDropEdit.DataTextField = "nombre_marca";
            brandDropEdit.DataValueField = "id_marca";
            brandDropEdit.DataBind();

        }


        // Methods
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
                
                //Refresh Table
                BindTable();
            }
            catch (SqlException s_exp)
            {
                Response.Write(s_exp);
            }
        }

        private void Add(string name, string desc)
        {
            var connection = new SqlConnection(connectionString);
            connection.Open();
            string sql_insert = "INSERT INTO Marcas(nombre_marca, descripcion_marca) VALUES (@name, @desc)";

            try
            {
                SqlCommand command = new SqlCommand(sql_insert, connection);
                command.Parameters.AddWithValue("@name", name);
                command.Parameters.AddWithValue("@desc", desc);

                command.ExecuteNonQuery();
                command.Parameters.Clear();
                command.Dispose();
                connection.Close();
            }
            catch (SqlException s_exp)
            {
                string htmlError = "<div class=\"alert alert-danger alert-dismissable\">" +
                                      "<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">&times;</button>" +
                                      "Error: " + s_exp +
                                   "</div>";
                Response.Write(htmlError);
                //Response.Write(s_exp);
            }

            //Refresh Table
            BindTable();
        }

        private void Update(int idEdited, string newDesc) 
        {
            var connection = new SqlConnection(connectionString);
            connection.Open();
            string sql_update = "UPDATE Marcas SET descripcion_marca = @nuevaDesc WHERE id_marca = @idEditado"; // Update Desc only

            try
            {
                SqlCommand command = new SqlCommand(sql_update, connection);
                command.Parameters.AddWithValue("@nuevaDesc", newDesc);
                command.Parameters.AddWithValue("@idEditado", idEdited);

                command.ExecuteNonQuery();
                command.Parameters.Clear();
                command.Dispose();
                connection.Close();
            }
            catch (SqlException s_exp)
            {
                string htmlError = "<div class=\"alert alert-danger alert-dismissable\">" +
                                      "<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">&times;</button>" +
                                      "Error: " + s_exp +
                                   "</div>";
                Response.Write(htmlError);
                //Response.Write(s_exp);
            }

            //Refresh Table
            BindTable();

        }

        protected void deleteBrandBtn_Click(object sender, EventArgs e)
        {
            if (brandDrop.SelectedItem != null)
            {
                if (brandDrop.SelectedValue == "0")
                    return;
                DeleteBrand(int.Parse(brandDrop.SelectedValue));
                brandDrop.Items.Remove(brandDrop.SelectedItem);
            }
        }

        protected void addBrandBtn_Click(object sender, EventArgs e)
        {
            if (brandInputField.Text == "")
                return;

            Add(brandInputField.Text, brandDescField.Text);
            Response.Redirect("Marcas.aspx"); // Fix POST method when refreshing
        }

        protected void updateBrandBtn_Click(object sender, EventArgs e)
        {
            if (brandDropEdit.SelectedValue == "0" || editBrandDesc.Text == "" )
                return;

            Update(int.Parse(brandDropEdit.SelectedValue), editBrandDesc.Text);
            Response.Redirect("Marcas.aspx"); // Fix POST method when refreshing
        }
    }
}