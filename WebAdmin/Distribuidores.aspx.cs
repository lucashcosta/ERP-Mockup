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
    public partial class Distribuidores : System.Web.UI.Page
    {
        private String connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                BindDropDown();
                BindTable();
                BindBrandDrop();
            }
        }

        // Filling fields
        private void BindDropDown()
        {
            string strQuery = "SELECT [id_distribuidor] ,[nombre_distribuidor] FROM [dbo].[Distribuidores]";
            SqlCommand cmd = new SqlCommand(strQuery);
            DataTable prod = GetData(cmd);
            productDrop.DataSource = prod;
            productDrop.DataTextField = "nombre_distribuidor";
            productDrop.DataValueField = "id_distribuidor";
            productDrop.DataBind();

            // BindEditDropDown
            productDropEdit.DataSource = prod;
            productDropEdit.DataTextField = "nombre_distribuidor";
            productDropEdit.DataValueField = "id_distribuidor";
            productDropEdit.DataBind();
        }

        private void BindTable()
        {
            string strQuery = "SELECT [id_distribuidor], [id_marca] ,[nombre_distribuidor], [nombre_marca] FROM [dbo].[View_DistribuidoresMarcas]";
            SqlCommand cmd = new SqlCommand(strQuery);
            ProductosGridView.DataSource = GetData(cmd);
            ProductosGridView.DataBind();
        }

        private void BindBrandDrop()
        {
            string strQuery = "SELECT [id_marca] ,[nombre_marca] FROM [dbo].[Marcas]";
            SqlCommand cmd = new SqlCommand(strQuery);
            brandInputField.DataSource = GetData(cmd);
            brandInputField.DataTextField = "nombre_marca";
            brandInputField.DataValueField = "id_marca";
            brandInputField.DataBind();
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

        private void Delete(int id)
        {
            SqlConnection connection = new SqlConnection(connectionString);
            try
            {
                connection.Open();

                string sql_command = "DELETE FROM Distribuidores WHERE id_distribuidor=" + id;
                SqlCommand cmd = new SqlCommand(sql_command, connection);
                //cmd.Parameters.RemoveAt("@id_marca", );
                cmd.ExecuteNonQuery();
                cmd.Dispose();
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

        private void Add(string name, string dir, int id)
        {
            var connection = new SqlConnection(connectionString);
            connection.Open();
            string sql_insert = "INSERT INTO Distribuidores(nombre_distribuidor, direccion_distribuidor, id_marca) VALUES (@name, @dir, @idBrand)";

            try
            {
                SqlCommand command = new SqlCommand(sql_insert, connection);
                command.Parameters.AddWithValue("@name", name);
                command.Parameters.AddWithValue("@dir", dir);
                command.Parameters.AddWithValue("@idBrand", id);

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

        private void Update(int idEdited, string newName, string newDir) //Pasrsing newPrice here to avoid FormatErrors
        {
            var connection = new SqlConnection(connectionString);
            connection.Open();
            string sql_update = String.Empty;

            if (newDir == "" && newName != "") { sql_update = "UPDATE Distribuidores SET nombre_distribuidor = @newName WHERE id_distribuidor = @idEditado"; } // Update Price only
            if (newName == "" && newDir != "") { sql_update = "UPDATE Distribuidores SET direccion_distribuidor = @newDir WHERE id_distribuidor = @idEditado"; } // Update Desc only
            if (newName != "" && newDir != "") { sql_update = "UPDATE Distribuidores SET nombre_distribuidor = @newName, direccion_distribuidor = @newDir WHERE id_distribuidor = @idEditado"; } // Update both

            try
            {
                SqlCommand command = new SqlCommand(sql_update, connection);
                if (newDir != "")
                    command.Parameters.AddWithValue("@newName", newName);
                command.Parameters.AddWithValue("@newDir", newDir);
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

        protected void deleteProductdBtn_Click(object sender, EventArgs e)
        {
            if (productDrop.SelectedItem != null)
            {
                if (productDrop.SelectedValue == "0")
                    return;
                Delete(int.Parse(productDrop.SelectedValue));
                productDrop.Items.Remove(productDrop.SelectedItem);
            }
        }

        protected void addProdBtn_Click(object sender, EventArgs e)
        {
            if (prodNameField.Text == "" || prodDirField.Text == "" || brandInputField.SelectedValue == "0")
                return;
            Add(prodNameField.Text, prodDirField.Text, Convert.ToInt32(brandInputField.SelectedValue));
            Response.Redirect("Distribuidores.aspx"); // Fix POST method when refreshing
        }

        protected void updaeProdBtn_Click(object sender, EventArgs e)
        {
            if (productDropEdit.SelectedValue == "0" || (editProdDir.Text == "" && editProdName.Text == ""))
                return;

            Update(int.Parse(productDropEdit.SelectedValue), editProdName.Text, editProdDir.Text);
            Response.Redirect("Distribuidores.aspx"); // Fix POST method when refreshing
        }
    }

}