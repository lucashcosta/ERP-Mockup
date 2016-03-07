using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using WebAdmin.Classes.PosiblesClientes;

namespace WebAdmin.Classes
{
    public class ClientsTable
    {
        public List<Client> ClientsStoredTable { get; set; }

        public ClientsTable(DataTable table)
        {
            ClientsStoredTable = new List<Client>();
            foreach (DataRow row in table.Rows)
            {
                ClientsStoredTable.Add(new Client(row));
            }
        }
    }
}