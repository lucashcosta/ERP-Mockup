using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAdmin.Classes.Order
{
    public class OrderItem
    {
        public int productId { get; set; }
        public double productPrice { get; set; }
        public string productName { get; set; }
        public int typeId { get; set; }
        public double typeIncrease { get; set; }
        public string typeName { get; set; }
        public int quantity { get; set; }
        public double total { get; set; }

        public OrderItem(object objectItem)
        {
            Dictionary<string, object> item = (Dictionary<string, object>)objectItem;

            productId = Convert.ToInt32(item["productId"]);
            productPrice = Convert.ToDouble(item["productPrice"]);
            productName = item["productName"].ToString();

            typeId = Convert.ToInt32(item["typeId"]);
            typeIncrease = Convert.ToDouble(item["typeIncrease"]);
            typeName = item["typeName"].ToString();

            quantity = Convert.ToInt32(item["qty"]);
            total = Convert.ToDouble(item["total"]);
        }

        public double GetUnitPrice()
        {
             return productPrice + (productPrice * (typeIncrease / 100));
        }
    }
}