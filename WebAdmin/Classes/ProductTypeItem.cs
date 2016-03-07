using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace WebAdmin.Classes
{
    public class ProductTypeItem
    {
        public int IdType { get; set; }
        public string TypeName { get; set; }
        //public string BrandName { get; set; }
        public double IncreaseRatio { get; set; }

        public ProductTypeItem(DataRow row)
        {
            TypeName = row["nombre_tipo"].ToString();
            //BrandName = row["nombre_marca"].ToString();

            try
            {
                IdType = Convert.ToInt32(row["id_tipo"]);
                //IdBrand = Convert.ToInt32(row["id_marca"]);
                IncreaseRatio = Convert.ToDouble(row["aumentoPorcentaje_tipo"]);
            }
            catch (Exception ex) { }
        }
    }
}