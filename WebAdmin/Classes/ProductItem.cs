using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace WebAdmin.Classes
{
    public class ProductItem
    {
        public int IdProduct { get; set; }
        public int IdBrand { get; set; }
        public string ProductName { get; set; }
        public string BrandName { get; set; }
        public double UnitPrice { get; set; }

        public ProductItem(DataRow row)
        {
            ProductName = row["nombre_producto"].ToString();
            BrandName = row["nombre_marca"].ToString();

            try
            {
                IdProduct = Convert.ToInt32(row["id_producto"]);
                IdBrand = Convert.ToInt32(row["id_marca"]);
                UnitPrice = Convert.ToDouble(row["precioUnitario_producto"]);
            }
            catch (Exception ex) { }
        }
    }
}