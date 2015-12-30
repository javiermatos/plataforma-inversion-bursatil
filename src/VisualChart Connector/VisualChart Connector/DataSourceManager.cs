using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using VCDataSourceLib;

namespace VisualChartConnector
{
    public class DataSourceManager
    {

        VCDS_DataSourceManager visualChartDataSourceManager;
        

        public DataSourceManager()
        {
            visualChartDataSourceManager = new VCDS_DataSourceManager();
        }

        ~DataSourceManager()
        {
            try
            {
                visualChartDataSourceManager.DeleteAll();
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
                VCDS_DataSerie visualChartDataSerie = visualChartDataSourceManager.NewDataSerie(symbolCode, DataSerie.getVisualChartCompressionType(compressionType), compressionUnits);
                return new DataSerie(visualChartDataSerie);
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
                VCDS_DataSerie visualChartDataSerie = visualChartDataSourceManager.NewDataSerie(symbolCode, DataSerie.getVisualChartCompressionType(compressionType), compressionUnits, initDateTime);
                return new DataSerie(visualChartDataSerie);
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
                VCDS_DataSerie visualChartDataSerie = visualChartDataSourceManager.NewDataSerie(symbolCode, DataSerie.getVisualChartCompressionType(compressionType), compressionUnits, initDateTime, endDateTime);
                return new DataSerie(visualChartDataSerie);
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
