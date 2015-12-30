using System;
using System.Collections.Generic;
using VCDataSourceLib;

namespace VisualChartConnector
{
    public class DataSerie : IEnumerable<BarValue>
    {

        String symbolCode;
        enumCompressionType compressionType;
        int compressionUnits;
        SortedSet<BarValue> barsValues;


        public DataSerie(VCDS_DataSerie visualChartDataSerie)
        {
            this.symbolCode = visualChartDataSerie.Code;
            this.compressionType = getCompressionType(visualChartDataSerie.CompressionType);
            this.compressionUnits = visualChartDataSerie.Compression;
            this.barsValues = new SortedSet<BarValue>();

            Array visualChartBarsValues = visualChartDataSerie.GetBarsValues(1, visualChartDataSerie.Size);

            foreach (VCDS_BarValue visualChartBarValue in visualChartBarsValues)
            {
                barsValues.Add(new BarValue(visualChartBarValue));
            }

        }


        #region Properties
        public String SymbolCode
        {
            get { return symbolCode; }
        }

        public String CompressionType
        {
            get { return compressionType.ToString(); }
        }

        public int CompressionUnits
        {
            get { return compressionUnits; }
        }

        public DateTime[] DateTime
        {
            get
            {
                DateTime[] dateTime = new DateTime[barsValues.Count];

                long index = 0;
                foreach (BarValue barValue in barsValues)
                {
                    dateTime[index++] = barValue.DateTime;
                }

                return dateTime;
            }
        }

        public int[,] DateTimeVector
        {
            get
            {
                int[,] dateTimeVector = new int[barsValues.Count, 6];

                long index = 0;
                foreach (BarValue barValue in barsValues)
                {
                    dateTimeVector[index, 0] = barValue.DateTime.Year;
                    dateTimeVector[index, 1] = barValue.DateTime.Month;
                    dateTimeVector[index, 2] = barValue.DateTime.Day;
                    dateTimeVector[index, 3] = barValue.DateTime.Hour;
                    dateTimeVector[index, 4] = barValue.DateTime.Minute;
                    dateTimeVector[index, 5] = barValue.DateTime.Second;

                    ++index;
                }

                return dateTimeVector;
            }
        }

        public double[] Open
        {
            get
            {
                double[] open = new double[barsValues.Count];

                long index = 0;
                foreach (BarValue barValue in barsValues)
                {
                    open[index++] = barValue.Open;
                }

                return open;
            }
        }

        public double[] High
        {
            get
            {
                double[] high = new double[barsValues.Count];

                long index = 0;
                foreach (BarValue barValue in barsValues)
                {
                    high[index++] = barValue.High;
                }

                return high;
            }
        }

        public double[] Low
        {
            get
            {
                double[] low = new double[barsValues.Count];

                long index = 0;
                foreach (BarValue barValue in barsValues)
                {
                    low[index++] = barValue.Low;
                }

                return low;
            }
        }

        public double[] Close
        {
            get
            {
                double[] close = new double[barsValues.Count];

                long index = 0;
                foreach (BarValue barValue in barsValues)
                {
                    close[index++] = barValue.Close;
                }

                return close;
            }
        }

        public double[] Volume
        {
            get
            {
                double[] volume = new double[barsValues.Count];

                long index = 0;
                foreach (BarValue barValue in barsValues)
                {
                    volume[index++] = barValue.Volume;
                }

                return volume;
            }
        }

        public double[] OpenInterest
        {
            get
            {
                double[] openInterest = new double[barsValues.Count];

                long index = 0;
                foreach (BarValue barValue in barsValues)
                {
                    openInterest[index++] = barValue.OpenInterest;
                }

                return openInterest;
            }
        }

        public double[,] Matrix
        {
            get
            {
                double[,] dataSerieMatrix = new double[barsValues.Count, 6 + 6];

                long index = 0;
                foreach (BarValue barValue in barsValues)
                {
                    dataSerieMatrix[index, 0] = barValue.DateTime.Year;
                    dataSerieMatrix[index, 1] = barValue.DateTime.Month;
                    dataSerieMatrix[index, 2] = barValue.DateTime.Day;
                    dataSerieMatrix[index, 3] = barValue.DateTime.Hour;
                    dataSerieMatrix[index, 4] = barValue.DateTime.Minute;
                    dataSerieMatrix[index, 5] = barValue.DateTime.Second;

                    dataSerieMatrix[index, 6] = barValue.Open;
                    dataSerieMatrix[index, 7] = barValue.High;
                    dataSerieMatrix[index, 8] = barValue.Low;
                    dataSerieMatrix[index, 9] = barValue.Close;
                    dataSerieMatrix[index, 10] = barValue.Volume;
                    dataSerieMatrix[index, 11] = barValue.OpenInterest;

                    ++index;
                }

                return dataSerieMatrix;
            }
        }

        public DateTime InitDateTime
        {
            get { return barsValues.Min.DateTime; }
        }

        public DateTime EndDateTime
        {
            get { return barsValues.Max.DateTime; }
        }

        public long Size
        {
            get { return barsValues.Count; }
        }
        #endregion


        public static enumVCDSCompressionType getVisualChartCompressionType(enumCompressionType compressionType)
        {
            return (enumVCDSCompressionType)Enum.Parse(typeof(enumVCDSCompressionType), "VCDS_CT_" + compressionType.ToString());
        }

        public static enumCompressionType getCompressionType(enumVCDSCompressionType visualChartCompressionType)
        {
            return (enumCompressionType)Enum.Parse(typeof(enumCompressionType), visualChartCompressionType.ToString().Substring(8));
        }

        public IEnumerator<BarValue> GetEnumerator()
        {
            return barsValues.GetEnumerator();
        }

        System.Collections.IEnumerator System.Collections.IEnumerable.GetEnumerator()
        {
            return barsValues.GetEnumerator();
        }
    }
}
