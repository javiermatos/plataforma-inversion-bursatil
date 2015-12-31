
function [dateTime, open, high, low, close, volume] = get(symbolCode, compressionType, compressionUnits, initDateTime, endDateTime)

% Download information
[dateTime, open, high, low, close, volume] ...
    = getVisualChartDataSerie( ...
    symbolCode, compressionType, compressionUnits, ...
    initDateTime, endDateTime ...
    );

end


function [dateTime, open, high, low, close, volume] ...
    = getVisualChartDataSerie(symbolCode, compressionType, compressionUnits, initDateTime, endDateTime)

% load assembly into MATLAB
NET.addAssembly(which('VisualChartConnector.dll'));

% Simple instance
%dataSourceManager = VisualChartConnector.DataSourceManager();
% Singleton instance
dataSourceManager = VisualChartConnector.SafeDataSourceManager.Instance;

% Compression type enum
compressionTypeEnum = string2enum(compressionType);

% initDateTimeObject
if ~isempty(initDateTime)
    initDateTime = datevec(initDateTime);
    initDateTimeObject = System.DateTime( ...
        initDateTime(1), initDateTime(2), initDateTime(3), ...
        initDateTime(4), initDateTime(5), initDateTime(6) ...
        );
end

% endDateTimeObject
if ~isempty(endDateTime)
    endDateTime = datevec(endDateTime);
    endDateTimeObject = System.DateTime( ...
        endDateTime(1), endDateTime(2), endDateTime(3), ...
        endDateTime(4), endDateTime(5), endDateTime(6) ...
        );
end

% Which method should be called?
if ~isempty(initDateTime) && ~isempty(endDateTime)
    dataSerie = dataSourceManager.getSerie(symbolCode, compressionTypeEnum, compressionUnits, initDateTimeObject, endDateTimeObject);
elseif ~isempty(initDateTime)
    dataSerie = dataSourceManager.getSerie(symbolCode, compressionTypeEnum, compressionUnits, initDateTimeObject);
elseif ~isempty(endDateTime)
    dataSerie = dataSourceManager.getSerie(symbolCode, compressionTypeEnum, compressionUnits, System.Date(1900,1,1), endDateTimeObject);
else
    dataSerie = dataSourceManager.getSerie(symbolCode, compressionTypeEnum, compressionUnits);
end

% Get matrix of values
dataSerieMatrix = double(dataSerie.Matrix);

% Generate output
%dateTimeVector = dataSerieMatrix(:,1:6);
dateTime = datenum(dataSerieMatrix(:,1:6));
open = dataSerieMatrix(:,7);
high = dataSerieMatrix(:,8);
low = dataSerieMatrix(:,9);
close = dataSerieMatrix(:,10);
volume = dataSerieMatrix(:,11);
%openInterest = dataSerieMatrix(:,12);

end


function compressionTypeEnum = string2enum(compressionTypeString)

switch lower(compressionTypeString)
    
    case 'ticks'
        compressionTypeEnum = VisualChartConnector.enumCompressionType.Ticks;
        
    case 'minutes'
        compressionTypeEnum = VisualChartConnector.enumCompressionType.Minutes;
        
    case 'days'
        compressionTypeEnum = VisualChartConnector.enumCompressionType.Days;
        
    case 'weeks'
        compressionTypeEnum = VisualChartConnector.enumCompressionType.Weeks;
        
    case 'months'
        compressionTypeEnum = VisualChartConnector.enumCompressionType.Months;
        
    otherwise
        error('Not valid argument.')
		
end

end
