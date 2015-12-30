using System;
using VCDataSourceLib;

namespace VisualChartConnector
{
    public class BarValue : IComparable<BarValue>
    {

        DateTime dateTime;
        double open;
        double high;
        double low;
        double close;
        double volume;
        double openInterest;


        public BarValue(VCDS_BarValue visualChartBarValue)
        {
            this.dateTime = visualChartBarValue.Date;
            this.open = visualChartBarValue.Open;
            this.high = visualChartBarValue.High;
            this.low = visualChartBarValue.Low;
            this.close = visualChartBarValue.Close;
            this.volume = visualChartBarValue.Volume;
            this.openInterest = visualChartBarValue.OpenInterest;
        }

        public BarValue(DateTime date, double open, double high, double low, double close, double volume, double openInterest)
        {
            this.dateTime = date;
            this.open = open;
            this.high = high;
            this.low = low;
            this.close = close;
            this.volume = volume;
            this.openInterest = openInterest;
        }


        #region Properties
        public DateTime DateTime
        {
            get { return dateTime; }
        }

        public double Open
        {
            get { return open; }
        }

        public double High
        {
            get { return high; }
        }

        public double Low
        {
            get { return low; }
        }

        public double Close
        {
            get { return close; }
        }

        public double Volume
        {
            get { return volume; }
        }

        public double OpenInterest
        {
            get { return openInterest; }
        }
        #endregion


        public override String ToString()
        {
            return String.Format("{0:d} | O {1:F}; H {2:F}; L {3:F}; C {4:F}; V {5:G}; OI {6:G}",
                dateTime.ToString("yyyy.MM.dd"), open, high, low, close, volume, openInterest);
        }

        public int CompareTo(BarValue other)
        {
            return dateTime.CompareTo(other.dateTime);
        }

    }
}
