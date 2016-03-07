using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace WebAdmin.Classes
{
    public class BoxTable
    {
        public List<BoxItem> BoxItemsTable { get; }

        public BoxTable(DataTable table)
        {
            BoxItemsTable = new List<BoxItem>();
            foreach (DataRow row in table.Rows)
            {
                BoxItemsTable.Add(new BoxItem(row));
            }
        }

        public double Total
        {
            get
            {
                double total = 0.0;
                foreach (BoxItem item in BoxItemsTable)
                {
                    total += item.Total;
                }

                return total;
            }
        }
    }
}