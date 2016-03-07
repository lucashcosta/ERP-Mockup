using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using WebAdmin.Classes.PosiblesClientes;

namespace WebAdmin.Classes
{
    public class PossibleClientsTable
    {
        public List<PossibleClient> ClientsTable { get; }

        public PossibleClientsTable(DataTable table)
        {
            ClientsTable = new List<PossibleClient>();
            foreach (DataRow row in table.Rows)
            {
                ClientsTable.Add(new PossibleClient(row));
            }
        }
    }
}