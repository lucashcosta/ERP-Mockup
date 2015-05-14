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
    public partial class MedioContacto : System.Web.UI.Page
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
            string strQuery = "SELECT [id_medio] ,[nombre_medio] FROM [dbo].[MediosContacto]";
            SqlCommand cmd = new SqlCommand(strQuery);
            dropDelete.DataSource = GetData(cmd);
            dropDelete.DataTextField = "nombre_medio";
            dropDelete.DataValueField = "id_medio";
            dropDelete.DataBind();
        }

        private void BindTable()
        {
            string strQuery = "SELECT [id_medio] ,[nombre_medio], [descripcion_medio] FROM [dbo].[MediosContacto]";
            SqlCommand cmd = new SqlCommand(strQuery);
            gridView.DataSource = GetData(cmd);
            gridView.DataBind();
        }

        private void BindEditDropDown()
        {
            string strQuery = "SELECT [id_medio] ,[nombre_medio] FROM [dbo].[MediosContacto]";
            SqlCommand cmd = new SqlCommand(strQuery);
            DropEdit.DataSource = GetData(cmd);
            DropEdit.DataTextField = "nombre_medio";
            DropEdit.DataValueField = "id_medio";
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

                string sql_command = "DELETE FROM MediosContacto WHERE id_medio=" + id;
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

        private void Add(string name, string desc)
        {
            var connection = new SqlConnection(connectionString);
            connection.Open();
            string sql_insert = "INSERT INTO MediosContacto(nombre_medio, descripcion_medio) VALUES (@name, @desc)";

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
            string sql_update = "UPDATE MediosContacto SET descripcion_medio = @nuevaDesc WHERE id_medio = @idEditado"; // Update Desc only

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


            if (InputField.Text == "")
                return;

            Add(InputField.Text, DescField.Text.Trim());
            Response.Redirect("MedioContacto.aspx"); // Fix POST method when refreshing
        }

        protected void updateBtn_Click(object sender, EventArgs e)
        {
            if (DropEdit.SelectedValue == "0" || editDesc.Text == "")
                return;

            Update(int.Parse(DropEdit.SelectedValue), editDesc.Text.Trim());
            Response.Redirect("MedioContacto.aspx"); // Fix POST method when refreshing
        }
    }
}