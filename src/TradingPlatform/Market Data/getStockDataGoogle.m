% getStockDataGoogle - Get Stock Data from Google Finance website
%
% Synopsis
%   stockData = getstockDataYahoo(symbol, varargin)
%
% Description
%   Takes stock data from Google Finance website.
%
% Inputs ([]s are optional)
%   (string)    symbol                  Stock symbol.
%   (string)    [frecuency = 'daily']   Data frecuency. Daily data by
%                                       default. 
%   (string)    [startDate = ...]       Start date of retrieved stock data.
%                                       If omitted it will retrieve oldest
%                                       possible data. Date format is
%                                       yyyy-mm-dd. The oldest date allowed
%                                       is 1970-01-01
%   (string)    [endDate = ...]         End date of retrieved stock data.
%                                       If omitted it will retrieve newest
%                                       possible data. Date format is
%                                       yyyy-mm-dd.
%
% Outputs ([]s are optional)
%   (struct)        stockData               Retrieved data.
%   (string)        stockData.symbol        Stock symbol.
%   (string)        stockData.frecuency     Data frecuency (daily, weekly).
%   (array(double)) stockData.date          Date of the values. Date format
%                                           is yyyy-mm-dd.
%   (array(double)) stockData.open          Stock's open price.
%   (array(double)) stockData.high          Stock's highest price.
%   (array(double)) stockData.low           Stock's lowest price.
%   (array(double)) stockData.close         Stock's adjusted closing price.
%   (array(double)) stockData.volume        Stock's transaction volume.
%
% Examples
%   % Gets IBM historical daily data
%   ibmDaily = getstockDataGoogle('IBM');
%
%   % Gets Intel weekly data in 2009
%   intelWeekly2009 = getstockDataGoogle('INTC', ...
%                                       'frecuency', 'weekly', ...
%                                       'startDate', '2009-01-01', ...
%                                       'endDate', '2010-01-01');
%

% References
%   http://computerprogramming.suite101.com/article.cfm/an_introduction_to_google_finance
%
% Author
%   Javier Matos Odut <javiermatos(at)intoabstraction.com>
%
% License
%   Public domain.
%
% Changes
%   2010.07.14  First edition.

function stockData = getStockDataGoogle(symbol, varargin)

% Generates URL
[url, frecuency] = googleFinancialGenerateURL(symbol, varargin{:});

% Initialize data
stockData = struct( ...             % Structure
    'symbol',       symbol, ...     % Stock symbol
    'frecuency',    frecuency, ...  % Data frecuency
    'date',         {{}}, ...       % Date of the values
    'open',         [], ...         % Stock's open price
    'high',         [], ...         % Stock's highest price
    'low',          [], ...         % Stock's lowest price
    'close',        [], ...         % Stock's adjusted closing price
    'volume',       [] ...          % Stock's transaction volume volume
    );

% Reads URL Address
%disp(['Reading from url ', url]);

% Google Finance has a 4000 rows limitation. It is necessary to request
% many times the same stock symbol with different date to get all the
% values.
while true

[strInput, status] = urlread(url);

% Check status and extract columns if success, otherwise show error message
if status
    
    [ ...
        temp.date, ...              % Date of the values
        temp.open, ...              % Stock's open price
        temp.high, ...              % Stock's higher price
        temp.low, ...               % Stock's lower price
        temp.close, ...             % Stock's adjusted closing price
        temp.volume, ...            % Stock's volume transaction
    ] = ...
    strread(strInput(34:end),'%s%f%f%f%f%f','delimiter',',');
    % It is necessary to jump 34 characters in order to avoid column names
    
    % Select start of rows depending on retrieval
    if isempty(stockData.open)
        start = 1;
    else
        % To avoid repeated rows
        start = 3;
    end

    stockData.date = [ stockData.date ; cellstr(datestr(temp.date(start:end), 'yyyy-mm-dd')) ];
    stockData.open = [ stockData.open ; temp.open(start:end) ];
    stockData.high = [ stockData.high ; temp.high(start:end) ];
    stockData.low = [ stockData.low ; temp.low(start:end) ];
    stockData.close = [ stockData.close ; temp.close(start:end) ];
    stockData.volume = [ stockData.volume ; temp.volume(start:end) ];
    
    if length(temp.open) == 4000
        if regexpi(url, '&enddate=')
            url = regexprep(url, '&enddate=\d\d\d\d-\d\d-\d\d', ['&enddate=',stockData.date{end}]);
        else
            url = strcat(url, '&enddate=', stockData.date{end});
        end
    else
        % Stop retrieving data
        break;
    end
    
    % Uniform output date
    %stockData.date = cellstr(datestr(stockData.date, 'yyyy-mm-dd'));
    stockData.date = datenum(stockData.date);
    
    % Invert columns (older values first)
    stockData.date = flipud(stockData.date);
    stockData.open = flipud(stockData.open);
    stockData.high = flipud(stockData.high);
    stockData.low = flipud(stockData.low);
    stockData.close = flipud(stockData.close);
    stockData.volume = flipud(stockData.volume);
    
else
    error('Data adquisition from Google Finance failed.');
end

end


end

function [url, frecuency] = googleFinancialGenerateURL(symbol, varargin)

% Analyze input arguments
for i = 1:floor(length(varargin)/2)
    
    label = varargin{2*i-1};
    value = varargin{2*i};
    
    switch lower(label)
        
        case 'frecuency'
            frecuency = lower(value);
            
        case 'startdate'
            startDate = value;
            
        case 'enddate'
            endDate = value;
        
        otherwise
            error('Not valid argument.');
    end
end

% Base address of Google Finance
baseAddress = 'http://finance.google.com/finance/historical?';

% Generate url
url = strcat( ...
    baseAddress, ...            % Base address
    '&q=', upper(symbol), ...   % Stock symbol
    '&output=csv' ...           % CVS output
    );

% If frecuency is not specified or it is daily...
if exist('frecuency','var') && ~strcmpi(frecuency, 'daily')
    
    % Check time frecuency
    if ~any(strcmpi(frecuency, {'daily', 'weekly'}))
        error('Time frecuency is not valid.');
    end
    
    url = strcat( ...
        url, ...
        '&histperiod=', frecuency ...   % Frecuency
        );
else
    frecuency = 'daily';
end

% If startDate is not specified...
if ~exist('startDate','var')
    % The oldest date allowed is 1970-01-01
    startDate = '1970-01-01';
end
url = strcat( ...
    url, ...
    '&startdate=', datestr(startDate, 'yyyy-mm-dd') ... % Start date
    );

% If endDate is specified...
% The newer data allowed is today
% endDate = datestr(today, 'yyyy-mm-dd');
if exist('endDate','var')
    url = strcat( ...
        url, ...
        '&enddate=', datestr(endDate, 'yyyy-mm-dd') ... % End date
        );
end

end
