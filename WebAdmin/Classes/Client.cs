using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace WebAdmin.Classes
{
    public class Client
    {
        public string Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string FullName { get; set; }
        public string Phone { get; set; }
        public string Mobile { get; set; }
        public string Plano { get; set; }
        public string Colonia { get; set; }
        public string Ruta { get; set; }
        public string idRuta { get; set; }
        public string Postal { get; set; }

        public Client(DataRow row)
        {
            try { Id = row["id_cliente"].ToString(); }
            catch (Exception e) { Id = String.Empty; }

            try { FirstName = row["nombre_cliente"].ToString(); }
            catch (Exception e) { FirstName = String.Empty; }

            try { LastName = row["apellido_cliente"].ToString(); }
            catch (Exception e) { LastName = String.Empty; }

            FullName = FirstName + " " + LastName;
            
            try { Phone = row["telefono_cliente"].ToString(); }
            catch (Exception e) { Phone = String.Empty; }

            try { Mobile = row["movil_cliente"].ToString(); }
            catch (Exception e) { Mobile = String.Empty; }

            try { Colonia = row["colonia_cliente"].ToString(); }
            catch (Exception e) { Colonia = String.Empty; }

            try { Ruta = row["nombre_ruta"].ToString(); }
            catch (Exception e) { Ruta = String.Empty; }

            try { idRuta = row["id_ruta"].ToString(); }
            catch (Exception e) { idRuta = String.Empty; }

            try { Plano = row["plano_cliente"].ToString(); }
            catch (Exception e) { Plano = String.Empty; }

            try { Postal = row["postal_cliente"].ToString(); }
            catch (Exception e) { Postal = String.Empty; }
        }

        public Client(IDictionary<string, object> client)
        {
            Id = client["Id"].ToString();
            FirstName = client["FirstName"].ToString();
            FirstName = client["LastName"].ToString();
            FullName = client["FullName"].ToString();
            Phone = client["Phone"].ToString();
            Mobile = client["Mobile"].ToString();
            Colonia = client["Colonia"].ToString();
            Ruta = client["Ruta"].ToString();
            idRuta = client["idRuta"].ToString();
            Plano = client["Plano"].ToString();
            Postal = client["Postal"].ToString();
        }

        public Client() { }
    }
}