using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAdmin.Classes.Order
{
    public class Order
    {
        public int OrderId { get; set; }
        public List<OrderItem> Items { get; set; }

        public Order(IDictionary<string, object> order)
        {
            // Retrieve Order ID
            dynamic outputId = order["id"];
            OrderId = Convert.ToInt32(outputId);

            Items = new List<OrderItem>();
            dynamic outputItems = order["items"];
            object[] objectItems = (object[])outputItems;

            foreach (object item in objectItems)
            {
                Items.Add(new OrderItem(item));
            }
        }

        public double GetGrandTotal()
        {
            double total = 0.0;
            foreach (OrderItem item in Items)
            {
                total += item.total;
            }

            return total;
        }
    }
}