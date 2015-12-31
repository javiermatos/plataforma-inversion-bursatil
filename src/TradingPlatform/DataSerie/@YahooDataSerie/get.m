
function [dateTime, open, high, low, close, volume] = get(symbolCode, compressionType, compressionUnits, initDateTime, endDateTime)

% Download information
[dateTime, open, high, low, close, volume] ...
    = getYahooDataSerie( ...
    symbolCode, compressionType, compressionUnits, ...
    initDateTime, endDateTime ...
    );

end


function [dateTime, open, high, low, close, volume] ...
    = getYahooDataSerie(symbolCode, compressionType, compressionUnits, initDateTime, endDateTime)

% Generates URL from Yahoo! Finance
url = generateURL(symbolCode, compressionType, initDateTime, endDateTime);

% Reads data from Yahoo! Finance
[strInput, status] = urlread(url);

% Check status and extract columns if success, otherwise show error message
if status
    
    % It is necessary to jump 43 characters in order to avoid headers
    cellArray = textscan(strInput(43:end),'%s%f%f%f%f%f%f','Delimiter',',');
    
    % Apply compressionUnits and invert order (older values first)
    endLimit = length(cellArray{1}) - mod(length(cellArray{1}), compressionUnits);
    
    dateTime = flipud(datenum(cellArray{1}));
    dateTime = dateTime(compressionUnits:compressionUnits:endLimit);
    
    open = flipud(cellArray{2});
    open = open(1:compressionUnits:endLimit);
    
    high = flipud(cellArray{3});
    high = max(reshape(high(1:endLimit), compressionUnits, []), [], 1)';
    
    low = flipud(cellArray{4});
    low = min(reshape(low(1:endLimit), compressionUnits, []), [], 1)';
    
    % Close
    close = flipud(cellArray{5});
    close = close(compressionUnits:compressionUnits:endLimit);
    
%     % Adjusted close
%     close = flipud(cellArray{7});
%     close = close(compressionUnits:compressionUnits:endLimit);
    
    volume = flipud(cellArray{6});
    volume = sum(reshape(volume(1:endLimit), compressionUnits, []),1)';
    
    
else
    error('Data adquisition from Yahoo! Finance failed.');
end

end


function url = generateURL(symbolCode, compressionType, initDateTime, endDateTime)

% Base address of Yahoo! Finance
baseAddress = 'http://ichart.finance.yahoo.com/table.csv?';

% Generate url
url = strcat( ...
    baseAddress, ...                % Base address
    '&s=', upper(symbolCode), ...   % Stock symbol
    '&ignore=.csv' ...              % CVS output
    );

% Check compression type
switch lower(compressionType)
    
    case 'days'
        compressionTypeTag = 'd';
        
    case 'weeks'
        compressionTypeTag = 'w';
        
    case 'months'
        compressionTypeTag = 'm';
        
    otherwise
        error('Compression type is not valid.');
		
end

url = strcat( ...
    url, ...
    '&g=', compressionTypeTag ... % Compression type tag
    );

% optional initDateTime
if ~isempty(initDateTime)
    url = strcat( ...
        url, ...
        '&a=', num2str(str2double(datestr(initDateTime, 'mm'))-1, '%02d'), ...  % Month
        '&b=', datestr(initDateTime, 'dd'), ...                                 % Day
        '&c=', datestr(initDateTime, 'yyyy') ...                                % Year
        );
end

% optional endDateTime
if ~isempty(endDateTime)
    url = strcat( ...
        url, ...
        '&d=', num2str(str2double(datestr(endDateTime, 'mm'))-1, '%02d'), ...   % Month
        '&e=', datestr(endDateTime, 'dd'), ...                                  % Day
        '&f=', datestr(endDateTime, 'yyyy') ...                                 % Year
        );
end

end
