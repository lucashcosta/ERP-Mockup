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
    public partial class Mensajero : System.Web.UI.Page
    {
        private String connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                BindDropDown();
                BindTable();
                BindEditDropDown();
                BindVehiclesDropD();
                BindRutesDropD();
                
            }
        }

        // Filling fields
        private void BindDropDown()
        {
            string strQuery = "SELECT [id] ,[nombre], [descripcion] FROM [dbo].[Mensajeros]";
            SqlCommand cmd = new SqlCommand(strQuery);
            dropDelete.DataSource = GetData(cmd);
            dropDelete.DataTextField = "nombre";
            dropDelete.DataValueField = "id";
            dropDelete.DataBind();
        }

        private void BindVehiclesDropD()
        {
            string strQuery = "SELECT [id] ,[nombre] FROM [dbo].[Vehiculos]";
            SqlCommand cmd = new SqlCommand(strQuery);
            select_vehicleDropD.DataSource = GetData(cmd);
            select_vehicleDropD.DataTextField = "nombre";
            select_vehicleDropD.DataValueField = "id";
            select_vehicleDropD.DataBind();
        }

        private void BindRutesDropD()
        {
            string strQuery = "SELECT [id] ,[nombre] FROM [dbo].[Rutas]";
            SqlCommand cmd = new SqlCommand(strQuery);
            select_ruteDropD.DataSource = GetData(cmd);
            select_ruteDropD.DataTextField = "nombre";
            select_ruteDropD.DataValueField = "id";
            select_ruteDropD.DataBind();
        }

        private void BindTable()
        {
            string strQuery = "SELECT [id_mensajero], [nombre_mensajero], [nombre_vehiculo], [nombre_ruta] FROM [dbo].[View_Mensajeros]";
            SqlCommand cmd = new SqlCommand(strQuery);
            gridView.DataSource = GetData(cmd);
            gridView.DataBind();
        }

        private void BindEditDropDown()
        {
            string strQuery = "SELECT [id] ,[nombre], [descripcion] FROM [dbo].[Mensajeros]";
            SqlCommand cmd = new SqlCommand(strQuery);
            DropEdit.DataSource = GetData(cmd);
            DropEdit.DataTextField = "nombre";
            DropEdit.DataValueField = "id";
            DropEdit.DataBind();

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

                string sql_command = "DELETE FROM Mensajeros WHERE id=" + id;
                SqlCommand cmd = new SqlCommand(sql_command, connection);
                //cmd.Parameters.RemoveAt("@id", );
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

        private void Add(string name, string desc, int vehicId, int ruteId)
        {
            var connection = new SqlConnection(connectionString);
            connection.Open();
            string sql_insert = "INSERT INTO Mensajeros(nombre, descripcion, id_vehiculo, id_ruta) VALUES (@name, @desc, @vehicId, @ruteId)";

            try
            {
                SqlCommand command = new SqlCommand(sql_insert, connection);
                command.Parameters.AddWithValue("@name", name);
                command.Parameters.AddWithValue("@desc", desc);
                command.Parameters.AddWithValue("@vehicId", vehicId);
                command.Parameters.AddWithValue("@ruteId", ruteId);

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
            string sql_update = "UPDATE Mensajeros SET descripcion = @nuevaDesc WHERE id = @idEditado"; // Update Desc only

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

        protected void deleteBtn_Click(object sender, EventArgs e)
        {
            if (dropDelete.SelectedItem != null)
            {
                if (dropDelete.SelectedValue == "0")
                    return;
                Delete(int.Parse(dropDelete.SelectedValue));
                dropDelete.Items.Remove(dropDelete.SelectedItem);
            }
        }

        protected void addBtn_Click(object sender, EventArgs e)
        {
            if (InputField.Text == "" || select_ruteDropD.SelectedValue == "0" || select_vehicleDropD.SelectedValue == "0")
                return;

            Add(InputField.Text, DescField.Text, Convert.ToInt32(select_vehicleDropD.SelectedValue), Convert.ToInt32(select_ruteDropD.SelectedValue));
            Response.Redirect("Mensajeros.aspx"); // Fix POST method when refreshing
        }

        protected void updateBtn_Click(object sender, EventArgs e)
        {
            if (DropEdit.SelectedValue == "0" || editDesc.Text == "")
                return;

            Update(int.Parse(DropEdit.SelectedValue), editDesc.Text);
            Response.Redirect("Mensajeros.aspx"); // Fix POST method when refreshing
        }
    }
}