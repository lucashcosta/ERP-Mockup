using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAdmin.Classes
{
    public class SellsMonth
    {
        private int qty;
        public int Qty
        {
            get { return qty; }
            set { qty = value; }
        }

        private int monthNumber;
        public int MonthNumber
        {
            get { return monthNumber; }
            set { monthNumber = value; }
        }

        private string monthName;
        public string MonthName
        {
            get { return monthName; }
            set { monthName = value; }
        }

        private string distName;
        public string DistName
        {
            get { return distName; }
            set { distName = value; }
        }
    }
}