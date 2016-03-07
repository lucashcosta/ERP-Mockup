using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace WebAdmin.Classes
{
    public class BoxItem
    {
        public string Id { get; set; }
        public double Total { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }

        public string FullName
        {
            get { return FirstName + " " + LastName; }
        }

        public BoxItem(DataRow row)
        {
            Id = row["id_pedido"].ToString();
            FirstName = row["nombre_cliente"].ToString();
            LastName = row["apellido_cliente"].ToString();

            try
            {
                Total = Convert.ToDouble(row["totalProductos_orden"]);
            }

            catch (Exception e) { Total = 0.0; }
        }
    }
}