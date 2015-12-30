using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using VCDataSourceLib;

namespace VisualChartConnector
{
    public sealed class SafeDataSourceManager
    {

        static volatile SafeDataSourceManager safeDataSourceManager;
        static object instanceSync = new Object();
        static object destructorSync = new Object();
        static object getMethodSync = new Object();

        static VCDS_DataSourceManager visualChartDataSourceManager;

        private SafeDataSourceManager()
        {
            visualChartDataSourceManager = new VCDS_DataSourceManager();
        }

        public static SafeDataSourceManager Instance
        {
            get
            {
                if (safeDataSourceManager == null)
                {
                    lock (instanceSync)
                    {
                        if (safeDataSourceManager == null)
                        {
                            safeDataSourceManager = new SafeDataSourceManager();
                        }
                    }
                }

                return safeDataSourceManager;
            }
        }

        ~SafeDataSourceManager()
        {
            try
            {
                lock (destructorSync)
                {
                    visualChartDataSourceManager.DeleteAll();
                }
            }
            catch (System.Runtime.InteropServices.COMException e)
            {
                // Show a warning
                MessageBox.Show(
                    "Error deleting VCDS_DataSourceManager: " + e.Message,
                    "DataSourceManager",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Warning
                    );
            }
        }

        public DataSerie getSerie(String symbolCode, enumCompressionType compressionType, int compressionUnits)
        {
            try
            {
                DataSerie dataSerie;

                lock (getMethodSync)
                {
                    VCDS_DataSerie visualChartDataSerie = visualChartDataSourceManager.NewDataSerie(symbolCode, DataSerie.getVisualChartCompressionType(compressionType), compressionUnits);
                    dataSerie = new DataSerie(visualChartDataSerie);
                }

                return dataSerie;
            }
            catch (System.Runtime.InteropServices.COMException e)
            {
                // Show an error
                MessageBox.Show(
                    "Error creating VCDS_DataSerie: " + e.Message,
                    "DataSourceManager",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Error
                    );

                return null;
            }
        }

        public DataSerie getSerie(String symbolCode, enumCompressionType compressionType, int compressionUnits, DateTime initDateTime)
        {
            try
            {
                DataSerie dataSerie;

                lock (getMethodSync)
                {
                    VCDS_DataSerie visualChartDataSerie = visualChartDataSourceManager.NewDataSerie(symbolCode, DataSerie.getVisualChartCompressionType(compressionType), compressionUnits, initDateTime);
                    dataSerie = new DataSerie(visualChartDataSerie);
                }

                return dataSerie;
            }
            catch (System.Runtime.InteropServices.COMException e)
            {
                // Show an error
                MessageBox.Show(
                    "Error creating VCDS_DataSerie: " + e.Message,
                    "DataSourceManager",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Error
                    );

                return null;
            }
        }

        public DataSerie getSerie(String symbolCode, enumCompressionType compressionType, int compressionUnits, DateTime initDateTime, DateTime endDateTime)
        {
            try
            {
                DataSerie dataSerie;

                lock (getMethodSync)
                {
                    VCDS_DataSerie visualChartDataSerie = visualChartDataSourceManager.NewDataSerie(symbolCode, DataSerie.getVisualChartCompressionType(compressionType), compressionUnits, initDateTime, endDateTime);
                    dataSerie = new DataSerie(visualChartDataSerie);
                }

                return dataSerie;
            }
            catch (System.Runtime.InteropServices.COMException e)
            {
                // Show an error
                MessageBox.Show(
                    "Error creating VCDS_DataSerie: " + e.Message,
                    "DataSourceManager",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Error
                    );

                return null;
            }
        }

    }

}
