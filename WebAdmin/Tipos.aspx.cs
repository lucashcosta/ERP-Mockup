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
    public partial class Productos : System.Web.UI.Page
    {
        private static string[] m_UserBinds;
        int brandId;

        private String connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["UserBinds"] != null)
                {
                    m_UserBinds = Session["UserBinds"] as string[];
                    brandId = Convert.ToInt32(m_UserBinds[0]);
                }
                else
                {
                    m_UserBinds = Global.getUserBinds();
                    brandId = Convert.ToInt32(m_UserBinds[0]);
                }

                BindDropDown();
                BindTable();
            }
        }

        // Filling fields
        private void BindDropDown()
        {
            // make sure m_UserBinds have something
            if (m_UserBinds == null)
            {
                if (Session["UserBinds"] != null)
                    m_UserBinds = Session["UerBinds"] as string[];
                else
                    m_UserBinds = Global.getUserBinds();
            }

            string strQuery = "SELECT [id_tipo] ,[nombre_tipo] FROM [dbo].[View_MarcasTipos] WHERE id_marca = " + m_UserBinds[0];
            SqlCommand cmd = new SqlCommand(strQuery);
            DataTable d_types = GetData(cmd);
            typeDrop.DataSource = d_types;
            typeDrop.DataTextField = "nombre_tipo";
            typeDrop.DataValueField = "id_tipo";
            typeDrop.DataBind();

            DropEdit.DataSource = d_types;
            DropEdit.DataTextField = "nombre_tipo";
            DropEdit.DataValueField = "id_tipo";
            DropEdit.DataBind();
        }

        private void BindTable()
        {
            // make sure m_UserBinds have something
            if (m_UserBinds == null)
            {
                if (Session["UserBinds"] != null)
                    m_UserBinds = Session["UerBinds"] as string[];

                else
                    m_UserBinds = Global.getUserBinds();
            }

            string strQuery = "SELECT * FROM [dbo].[View_MarcasTipos] WHERE id_marca = " + Convert.ToInt32(m_UserBinds[0]);
            SqlCommand cmd = new SqlCommand(strQuery);
            TiposGridView.DataSource = GetData(cmd);
            TiposGridView.DataBind();
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

                string sql_command = "DELETE FROM Tipos WHERE id_tipo=" + id;
                SqlCommand cmd = new SqlCommand(sql_command, connection);
                //cmd.Parameters.RemoveAt("@id_tipo", );
                cmd.ExecuteNonQuery();
                cmd.Dispose();

                //Refresh Table
                BindTable();
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
        }

        private void Add(string name, string desc, double percent)
        {
            var connection = new SqlConnection(connectionString);
            connection.Open();
            string sql_insert = "INSERT INTO Tipos(nombre_tipo, descripcion_tipo, aumentoPorcentaje_tipo, id_marca) VALUES (@name, @desc, @percent, @brandId)";

            try
            {
                SqlCommand command = new SqlCommand(sql_insert, connection);
                command.Parameters.AddWithValue("@name", name);
                command.Parameters.AddWithValue("@desc", desc);
                command.Parameters.AddWithValue("@percent", percent);

                // make sure m_UserBinds have something
                if (m_UserBinds == null)
                {
                    if (Session["UserBinds"] != null)
                        m_UserBinds = Session["UerBinds"] as string[];

                    else
                        m_UserBinds = Global.getUserBinds();
                }
                command.Parameters.AddWithValue("@brandId", Convert.ToInt32(m_UserBinds[0]));

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
            string sql_update = "UPDATE Tipos SET descripcion_tipo = @nuevaDesc WHERE id_tipo = @idEditado"; // Update Desc only

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

        protected void deleteTypedBtn_Click(object sender, EventArgs e)
        {
            if (typeDrop.SelectedItem != null)
            {
                if (typeDrop.SelectedValue == "0")
                    return;
                Delete(int.Parse(typeDrop.SelectedValue));
                typeDrop.Items.Remove(typeDrop.SelectedItem);
            }
        }

        protected void adddBtn_Click(object sender, EventArgs e)
        {
            if (InputField.Text == "")
                return;

            double percent;
            if (!double.TryParse(percentInputField.Text, out percent))
                percent = 0.0;

            Add(InputField.Text, DescField.Text, percent);
            Response.Redirect("Tipos.aspx"); // Fix POST method when refreshing
        }

        protected void updateBtn_Click(object sender, EventArgs e)
        {
            if (DropEdit.SelectedValue == "0" || editDesc.Text == "")
                return;

            Update(int.Parse(DropEdit.SelectedValue), editDesc.Text);
            Response.Redirect("Tipos.aspx"); // Fix POST method when refreshing
        }
    }
}