using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAdmin.Classes
{
    public class Item
    {
        private string name;
        public string Name
        {
            get{ return name; }
            set{ name = value; }
        }

        private int requestedQty;
        public int RequestedQty
        {
            get{ return requestedQty; }
            set{ requestedQty = value; }
        }

        //public List<Item> GetPopularItems()
        //{
 
        //}
    }
}