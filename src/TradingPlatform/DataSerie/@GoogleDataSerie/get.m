
function [dateTime, open, high, low, close, volume] = get(symbolCode, compressionType, compressionUnits, initDateTime, endDateTime)

% Download information
[dateTime, open, high, low, close, volume] ...
    = getGoogleDataSerie( ...
    symbolCode, compressionType, compressionUnits, ...
    initDateTime, endDateTime ...
    );

end


function [dateTime, open, high, low, close, volume] ...
    = getGoogleDataSerie(symbolCode, compressionType, compressionUnits, initDateTime, endDateTime)

% Generates URL from Google Finance
url = generateURL(symbolCode, compressionType, initDateTime, endDateTime);

% Initialize values
dateTime = [];
open = [];
high = [];
low = [];
close = [];
volume = [];

% Google Finance has a 4000 rows limitation. It is necessary to request
% many times the same stock symbol with different date to get all the
% values.
hasFinished = false;
while ~hasFinished
    
    [strInput, status] = urlread(url);
    
    % Check status and extract columns if success, otherwise show error message
    if status
        
        if isempty(strInput(34:end))
            hasFinished = true;
        else
            
            % It is necessary to jump 34 characters in order to avoid column names
            cellArray = textscan(strInput(34:end),'%s%f%f%f%f%f','Delimiter',',');
            
            % Prevent persistent single row infinite loop because of the
            % way in which Google Finance works.
            if length(cellArray{1}) == 1 && dateTime(end) <= datenum(cellArray{1}(1))
                hasFinished = true;
            else
                
                % is repeated row?
                while ~isempty(dateTime) && dateTime(end) <= datenum(cellArray{1}(1))
                    for i = 1:length(cellArray)
                        cellArray{i}(1) = [];
                    end
                end
                
                dateTime = [dateTime; datenum(cellArray{1})];
                open = [open; cellArray{2}];
                high = [high; cellArray{3}];
                low = [low; cellArray{4}];
                close = [close; cellArray{5}];
                volume = [volume; cellArray{6}];
                
                url = regexprep(url, '&enddate=\d\d\d\d-\d\d-\d\d', ['&enddate=', datestr(dateTime(end)-1, 'yyyy-mm-dd')]);
            end
            
        end
        
    else
        error('Data adquisition from Google Finance failed.');
    end
    
end

% Apply compressionUnits and invert order (older values first)
endLimit = length(dateTime) - mod(length(dateTime), compressionUnits);

dateTime = flipud(dateTime);
dateTime = dateTime(compressionUnits:compressionUnits:endLimit);

open = flipud(open);
open = open(1:compressionUnits:endLimit);

high = flipud(high);
high = max(reshape(high(1:endLimit), compressionUnits, []), [], 1)';

low = flipud(low);
low = min(reshape(low(1:endLimit), compressionUnits, []), [], 1)';

close = flipud(close);
close = close(compressionUnits:compressionUnits:endLimit);

volume = flipud(volume);
volume = sum(reshape(volume(1:endLimit), compressionUnits, []),1)';

end


function url = generateURL(symbolCode, compressionType, initDateTime, endDateTime)

% Base address of Google Finance
%baseAddress = 'http://finance.google.com/finance/historical?';
baseAddress = 'http://google.com/finance/historical?';

% Generate url
url = strcat( ...
    baseAddress, ...            % Base address
    '&q=', upper(symbolCode), ...   % Stock symbol
    '&output=csv' ...           % CVS output
    );

% Check compression type
switch lower(compressionType)
    
    case 'days'
        compressionTypeTag = 'daily';
        
    case 'weeks'
        compressionTypeTag = 'weekly';
        
    otherwise
        error('Compression type is not valid.');
		
end

url = strcat( ...
    url, ...
    '&histperiod=', compressionTypeTag ... % Compression type tag
    );

% optional initDateTime
if isempty(initDateTime)
    % If we don't specify initial date time it will take information from
    % from the last year and no more.
    % The oldest date allowed is 1970-01-01
    initDateTime = '1970-01-01';
end
url = strcat( ...
    url, ...
    '&startdate=', datestr(initDateTime, 'yyyy-mm-dd') ... % Start date
    );

% optional endDateTime
if isempty(endDateTime)
    endDateTime = today;
end
url = strcat( ...
    url, ...
    '&enddate=', datestr(endDateTime, 'yyyy-mm-dd') ... % End date
    );

end
