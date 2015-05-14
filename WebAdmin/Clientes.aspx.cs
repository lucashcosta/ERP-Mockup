using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Configuration;
using System.Web.Http;
using System.Globalization;

namespace WebAdmin
{
    public partial class Clientes : System.Web.UI.Page
    {
        private String connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        private static int PageSize = 15;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //BindTable();
                BindRutesDropD();
                BindRefs();
            }
        }

        private void BindRutesDropD()
        {
            string strQuery = "SELECT [id], [nombre] FROM [dbo].[Rutas]";
            SqlCommand cmd = new SqlCommand(strQuery);

            ruteInputDropD.DataSource = GetData(cmd);
            ruteInputDropD.DataTextField = "nombre";
            ruteInputDropD.DataValueField = "id";
            ruteInputDropD.DataBind();
        }

        private void BindRefs()
        {
            string strQuery = "SELECT [id_medio], [nombre_medio] FROM [dbo].[MediosContacto]";
            SqlCommand cmd = new SqlCommand(strQuery);

            contactRefInput.DataSource = GetData(cmd);
            contactRefInput.DataTextField = "nombre_medio";
            contactRefInput.DataValueField = "id_medio";
            contactRefInput.DataBind();
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

        private void Add(int ruteId, string firstName, string lastName, string phone, string mobile, string plano, string city, string colony, string street, string betStreets, string dirNumber, string postal, string dirRef, string notes, string contactRef, string ship, string disc)
        {
            var connection = new SqlConnection(connectionString);
            connection.Open();
            string sql_insert = "INSERT INTO Clientes(id_ruta, nombre_cliente, apellido_cliente, telefono_cliente, movil_cliente, plano_cliente, ciudad_cliente, colonia_cliente, calle_cliente, entreCalles_cliente, numeroDir_cliente, postal_cliente, referencias_direccion_cliente, cantidad_compras, notas_cliente, formaContacto_cliente, envioEspecial_cliente, precioEnvio_cliente, descuentoEspecial_cliente, valorDescuento_cliente, nombreFactura_cliente, dirFactura_cliente, rfcFactura_cliente) "
                                +"VALUES (@ruteId, @firstName, @lastName, @phone, @mobile, @plano, @city, @colony, @street, @betStreets, @dirNumber, @postal, @referencias_direccion_cliente, @buys, @notes, @contactRef, @specialShipping, @specialShippingPrice, @specialDiscount, @specialDiscountValue, @facName, @facDir, @facRFC)";
            
            // Set special ship price if the case
            int specialShipping = 0;
            if (shipbox.Checked)
                specialShipping = 1;

            // Set discount value id the case
            int specialDiscount = 0;
            if (discbox.Checked)
                specialDiscount = 1;

            // Handle disc and ship values
            double m_ship = 0.0, m_discValue = 0.0;
            if (!String.IsNullOrWhiteSpace(shipValue.Text))
                m_ship = Convert.ToDouble(shipValue.Text);
            if (!String.IsNullOrWhiteSpace(discValue.Text))
                m_discValue = Convert.ToDouble(discValue.Text);

            try
            {
                SqlCommand command = new SqlCommand(sql_insert, connection);
                command.Parameters.AddWithValue("@ruteId", ruteId);
                command.Parameters.AddWithValue("@firstName", CultureInfo.CurrentCulture.TextInfo.ToTitleCase(firstName).Trim());
                command.Parameters.AddWithValue("@lastName", CultureInfo.CurrentCulture.TextInfo.ToTitleCase(lastName).Trim());
                command.Parameters.AddWithValue("@phone", phone.Trim());
                command.Parameters.AddWithValue("@mobile", mobile.Trim());
                command.Parameters.AddWithValue("@plano", plano.Trim().ToUpper());
                command.Parameters.AddWithValue("@city", city.Trim());
                command.Parameters.AddWithValue("@colony", colony.Trim());
                command.Parameters.AddWithValue("@street", street.Trim());
                command.Parameters.AddWithValue("@betStreets", betStreets.Trim());
                command.Parameters.AddWithValue("@dirNumber", dirNumber.Trim());
                command.Parameters.AddWithValue("@postal", postal.Trim());
                command.Parameters.AddWithValue("@referencias_direccion_cliente", dirRef.Trim());
                command.Parameters.AddWithValue("@buys", 0);
                command.Parameters.AddWithValue("@notes", notes.Trim());
                command.Parameters.AddWithValue("@contactRef", contactRef.Trim());
                command.Parameters.AddWithValue("@specialShipping", specialShipping);
                command.Parameters.AddWithValue("@specialShippingPrice", m_ship);
                command.Parameters.AddWithValue("@specialDiscount", specialDiscount);
                command.Parameters.AddWithValue("@specialDiscountValue", m_discValue);
                command.Parameters.AddWithValue("@facName", facName.Text);
                command.Parameters.AddWithValue("@facDir", facDir.Text);
                command.Parameters.AddWithValue("@facRFC", facRFC.Text);

                command.ExecuteNonQuery();
                command.Parameters.Clear();
                command.Dispose();
                connection.Close();
            }
            catch (SqlException s_exp)
            {
                messagesText.Attributes["class"] = "alert alert-danger alert-dismissable";
                lblMessage.Text = s_exp.ToString();
                panelMessage.Visible = true;
            }

            //Refresh Table
            //BindTable();
        }

        protected void addBtn_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(firstNameInput.Text) || String.IsNullOrEmpty(lastNameInput.Text) || String.IsNullOrEmpty(phoneInput.Text)
                || String.IsNullOrEmpty(cityInput.Text) || String.IsNullOrEmpty(colonyInput.Text) || String.IsNullOrEmpty(dirNumberInput.Text))
                return;

            Add(Convert.ToInt32(ruteInputDropD.SelectedValue), firstNameInput.Text, lastNameInput.Text, phoneInput.Text, mobileInput.Text, planoInput.Text, cityInput.Text, colonyInput.Text,
                streetInput.Text, betStreetsInput.Text, dirNumberInput.Text, postalInput.Text, dirRefInput.Text, notesInput.Text, contactRefInput.SelectedItem.Text, shipValue.Text, discValue.Text);
            Response.Redirect("Clientes.aspx"); // Fix POST method when refreshing
        }

    }
}