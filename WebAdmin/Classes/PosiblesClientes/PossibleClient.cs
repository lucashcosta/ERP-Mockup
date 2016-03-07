using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace WebAdmin.Classes.PosiblesClientes
{
    public class PossibleClient : Client
    {
        public PossibleClient(DataRow row) : base(row)
        {

        }
    }
}