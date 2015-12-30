
%vcc = NET.addAssembly('./VisualChartConnector.dll');
%vccPath = which('VisualChartConnector.dll');
visualChartConnector = NET.addAssembly(which('VisualChartConnector.dll'));

% DataSourceManager
dataSourceManager = VisualChartConnector.DataSourceManager();

% DataSerie
% http://www.agmercados.com/dexx/strategies/exchanges/splits/splits.asp?opcion=dividendos
dataSerie = dataSourceManager.getSerie('010060TEF.MC', VisualChartConnector.enumCompressionType.Days, 1);

%methods(dataSerie,'-full');
%properties(dataSerie);

dataSerieMatrix = double(dataSerie.Matrix);

dateTimeVector = dataSerieMatrix(:,1:6);
dateTime = datenum(dataSerieMatrix(:,1:6));
open = dataSerieMatrix(:,7);
high = dataSerieMatrix(:,8);
low = dataSerieMatrix(:,9);
close = dataSerieMatrix(:,10);
volume = dataSerieMatrix(:,11);
openInterest = dataSerieMatrix(:,12);
