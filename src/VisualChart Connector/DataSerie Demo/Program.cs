using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using VisualChartConnector;

namespace DataSerie_Demo
{
    class Program
    {
        static void Main(string[] args)
        {
            DataSourceManager dataSerieManager = new DataSourceManager();

            // http://www.agmercados.com/dexx/strategies/exchanges/splits/splits.asp?opcion=dividendos
            //String symbol = "010060BBVA.MC";
            String symbol = "010060TEF.MC";

            DateTime initDate = new DateTime(2010, 1, 1);
            DateTime endDate = new DateTime(2011, 1, 1);

            DataSerie dataSerie = dataSerieManager.getSerie(symbol, enumCompressionType.Days, 1, initDate, endDate);

            Console.WriteLine("dataSerie.Size = " + dataSerie.Size);
            Console.WriteLine("initDate = " + dataSerie.InitDateTime);
            Console.WriteLine("endDate = " + dataSerie.EndDateTime);
            Console.WriteLine("Name = " + dataSerie.SymbolCode);

            foreach (BarValue bv in dataSerie)
            {
                Console.WriteLine(bv.ToString());
            }

            ;

        }
    }
}
