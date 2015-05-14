using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAdmin.Classes
{
    public class ItemsPrepared
    {
        private string name;
        public string Name
        {
            get { return name; }
            set { name = value; }
        }

        private int qty;
        public int Qty
        {
            get { return qty; }
            set { qty = value; }
        }

        private string descrption;
        public string Description
        {
            get { return descrption; }
            set { descrption = value; }
        }

        private string price;
        public string Price
        {
            get { return price; }
            set { price = value; }
        }

        private string brand;
        public string Brand
        {
            get { return brand; }
            set { brand = value; }
        }
    }
}