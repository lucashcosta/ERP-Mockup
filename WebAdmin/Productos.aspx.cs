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
    public partial class Tipos : System.Web.UI.Page
    {
        private static string[] m_UserBinds;
        private string strQuery;

        private String connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                

                if (Session["UserBinds"] != null)
                {
                    m_UserBinds = Session["UserBinds"] as string[];
                }
                else
                {
                    m_UserBinds = Global.getUserBinds();
                }
                BindDropDown();
                BindTable();
                

                if (User.Identity.Name.Equals("admin"))
                {
                    //Bind all brands
                    BindBrandDrop();
                }
                else
                {
                    //Bind normally
                    BindBrand();
                }
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

            string strQuery = "SELECT [id_producto] ,[nombre_producto] FROM [dbo].[View_MarcasProducto] WHERE id_marca = " + m_UserBinds[0];
            SqlCommand cmd = new SqlCommand(strQuery);
            DataTable prod = GetData(cmd);
            productDrop.DataSource = prod;
            productDrop.DataTextField = "nombre_producto";
            productDrop.DataValueField = "id_producto";
            productDrop.DataBind();

            // BindEditDropDown
            productDropEdit.DataSource = prod;
            productDropEdit.DataTextField = "nombre_producto";
            productDropEdit.DataValueField = "id_producto";
            productDropEdit.DataBind();
        }

        private void BindTable()
        {
            if (User.Identity.Name.Equals("admin"))
            {
                //Bind all brands
                strQuery = "SELECT [id_producto], [id_marca], [nombre_marca] ,[nombre_producto], [estaPublicado_producto], [descripcion_producto], [precioUnitario_producto] FROM [dbo].[View_MarcasProducto]";
            }
            else
                strQuery = "SELECT [id_producto], [id_marca], [nombre_marca] ,[nombre_producto], [estaPublicado_producto], [descripcion_producto], [precioUnitario_producto] FROM [dbo].[View_MarcasProducto] WHERE id_marca = " + m_UserBinds[0];

            SqlCommand cmd = new SqlCommand(strQuery);
            ProductosGridView.DataSource = GetData(cmd);
            ProductosGridView.DataBind();
        }

        //Bind brand
        private void BindBrand()
        {
            // make sure m_UserBinds have something
            if (m_UserBinds == null)
            {
                if (Session["UserBinds"] != null)
                    m_UserBinds = Session["UerBinds"] as string[];
                else
                    m_UserBinds = Global.getUserBinds();
            }

            userBrand.Text = m_UserBinds[2];
        }

        private void BindBrandDrop()
        {
            string strQuery = "SELECT [id_marca] ,[nombre_marca], [estaPublicado_marca], [descripcion_marca] FROM [dbo].[Marcas]";
            SqlCommand cmd = new SqlCommand(strQuery);
            brandInputField.DataSource = GetData(cmd);
            brandInputField.DataTextField = "nombre_marca";
            brandInputField.DataValueField = "id_marca";
            brandInputField.Items.Clear();
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

                string sql_command = "DELETE FROM Productos WHERE id_producto=" + id;
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

        private void Add(string name, double? price, int id, string desc)
        {
            var connection = new SqlConnection(connectionString);
            connection.Open();
            string sql_insert = "INSERT INTO Productos(nombre_producto, precioUnitario_producto, id_marca, descripcion_producto) VALUES (@name, @price, @idBrand, @desc)";
            
            try 
            {
                SqlCommand command = new SqlCommand(sql_insert, connection);
                command.Parameters.AddWithValue("@name", name);
                command.Parameters.AddWithValue("@price", price);

                if (User.Identity.Name.Equals("admin"))
                    id = Convert.ToInt32(brandInputField.SelectedValue);

                command.Parameters.AddWithValue("@idBrand", id);


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

        private void Update(int idEdited, string newPrice, string newDesc) //Pasrsing newPrice here to avoid FormatErrors
        {
            var connection = new SqlConnection(connectionString);
            connection.Open();
            string sql_update=String.Empty;

            if (newDesc == "" && newPrice != "") { sql_update = "UPDATE Productos SET precioUnitario_producto = @nuevoPrecio WHERE id_producto = @idEditado"; } // Update Price only
            if (newPrice == "" && newDesc != "") { sql_update = "UPDATE Productos SET descripcion_producto = @nuevaDesc WHERE id_producto = @idEditado"; } // Update Desc only
            if (newPrice != "" && newDesc != "") { sql_update = "UPDATE Productos SET precioUnitario_producto = @nuevoPrecio, descripcion_producto = @nuevaDesc WHERE id_producto = @idEditado"; } // Update both

            try
            {
                SqlCommand command = new SqlCommand(sql_update, connection);
                if(newPrice != "")
                    command.Parameters.AddWithValue("@nuevoPrecio", Convert.ToDouble(newPrice));
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
            if (prodInputField.Text == "" || prodPriceField.Text == "")
                return;

            // make sure m_UserBinds have something
            if (m_UserBinds == null)
            {
                if (Session["UserBinds"] != null)
                    m_UserBinds = Session["UerBinds"] as string[];
                else
                    m_UserBinds = Global.getUserBinds();
            }

            Add(prodInputField.Text, double.Parse(prodPriceField.Text), Convert.ToInt32(m_UserBinds[0]), prodDescField.Text);
            Response.Redirect("Productos.aspx"); // Fix POST method when refreshing
        }

        protected void updaeProdBtn_Click(object sender, EventArgs e)
        {
            if (productDropEdit.SelectedValue == "0" || (editProdDesc.Text == "" && editProdPrice.Text == ""))
                return;

            Update(int.Parse(productDropEdit.SelectedValue), editProdPrice.Text, editProdDesc.Text);
            Response.Redirect("Productos.aspx"); // Fix POST method when refreshing
        }
    }
}