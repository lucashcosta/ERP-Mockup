using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAdmin.Classes
{
    public class NotificationAutoGen
    {
        private int stackID;
        public int StackID
        {
            get { return stackID; }
            set { stackID = value; }
        }

        private string name;
        public string Name
        {
            get { return name; }
            set { name = value; }
        }

        private string type;
        public string Type
        {
            get { return type; }
            set { type = value; }
        }

        private int clientID;
        public int ClientID
        {
            get { return clientID; }
            set { clientID = value; }
        }

        private int distID;
        public int DistID
        {
            get { return distID; }
            set { distID = value; }
        }

        private DateTime creationDate;
        public DateTime CreationDate
        {
            get { return creationDate; }
            set { creationDate = value; }
        }
    }
}