using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAdmin.Classes
{
    public class Client
    {
        private string firstName;
        public string FirstName
        {
            get { return firstName; }
            set { firstName = value; }
        }

        private string lastName;
        public string LastName
        {
            get { return lastName; }
            set { lastName = value; }
        }

        private string phone;
        public string Phone
        {
            get { return phone; }
            set { phone = value; }
        }

        private string mobile;
        public string Mobile
        {
            get { return mobile; }
            set { mobile = value; }
        }

        private string plano;
        public string Plano
        {
            get { return plano; }
            set { plano = value; }
        }

    }
}