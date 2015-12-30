% getStockDataYahoo - Get Stock Data from Yahoo! Finance website
%
% Synopsis
%   stockData = getstockDataYahoo(symbol, varargin)
%
% Description
%   Takes stock data from Yahoo! Finance website.
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
%   (string)        stockData.frecuency     Data frecuency (daily, weekly,
%                                           montly).
%   (array(double)) stockData.date          Date of the values. Date format
%                                           is yyyy-mm-dd.
%   (array(double)) stockData.open          Stock's open price.
%   (array(double)) stockData.high          Stock's highest price.
%   (array(double)) stockData.low           Stock's lowest price.
%   (array(double)) stockData.close         Stock's adjusted closing price.
%   (array(double)) stockData.volume        Stock's transaction volume.
%   (array(double)) stockData.rawclose      Stock's close price.
%
% Examples
%   % Gets IBM historical daily data
%   ibmDaily = getstockDataYahoo('IBM');
%
%   % Gets Intel montly data in 2009
%   intelMontly2009 = getstockDataYahoo('INTC', ...
%                                       'frecuency', 'montly', ...
%                                       'startDate', '2009-01-01', ...
%                                       'endDate', '2010-01-01');
%

% References
%   http://computerprogramming.suite101.com/article.cfm/using_yahoo_financial
%
% Author
%   Javier Matos Odut <javiermatos(at)intoabstraction.com>
%
% License
%   Public domain.
%
% Changes
%   2010.07.14  First edition.

function stockData = getStockDataYahoo(symbol, varargin)

% Generates URL and returns frecuency from data
[url, frecuency] = yahooFinancialGenerateURL(symbol, varargin{:});

% Initialize data
stockData = struct( ...             % Structure
    'symbol',       symbol, ...     % Stock symbol
    'frecuency',    frecuency, ...  % Data frecuency
    'date',         {{}}, ...       % Date of the values
    'open',         [], ...         % Stock's open price
    'high',         [], ...         % Stock's highest price
    'low',          [], ...         % Stock's lowest price
    'close',        [], ...         % Stock's adjusted closing price
    'volume',       [], ...         % Stock's transaction volume
    'rawclose',     [] ...          % Stock's close price
    );

% Reads URL Address
%disp(['Reading from url ', url]);
[strInput, status] = urlread(url);

% Check status and extract columns if success, otherwise show error message
if status
    
    [ ...
        stockData.date, ...         % Date of the values
        stockData.open, ...         % Stock's open price
        stockData.high, ...         % Stock's higher price
        stockData.low, ...          % Stock's lower price
        stockData.rawclose, ...     % Stock's close price
        stockData.volume, ...       % Stock's volume transaction
        stockData.close...          % Stock's adjusted closing price
    ] = ...
    strread(strInput(43:end),'%s%f%f%f%f%f%f','delimiter',',');
    % It is necessary to jump 43 characters in order to avoid column names
    
    % Uniform output date
    %stockData.date = cellstr(datestr(stockData.date, 'yyyy-mm-dd'));
    stockData.date = datenum(stockData.date);
    
    % Invert columns (older values first)
    stockData = flipStockData(stockData);

else
    error('Data adquisition from Yahoo! Finance failed.');
end

end

function [url, frecuency] = yahooFinancialGenerateURL(symbol, varargin)

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

% Base address of Yahoo! Finance
baseAddress = 'http://ichart.finance.yahoo.com/table.csv?';

% Generate url
url = strcat( ...
    baseAddress, ...            % Base address
    '&s=', upper(symbol), ...   % Stock symbol
    '&ignore=.csv' ...          % CVS output
    );

% If frecuency is not specified or it is daily...
if exist('frecuency','var') && ~strcmpi(frecuency, 'daily')
    
    % Check time frecuency
    switch lower(frecuency)
        
        case 'daily'
            frecuencyTag = 'd';
            
        case 'weekly'
            frecuencyTag = 'w';
            
        case 'monthly'
            frecuencyTag = 'm';
            
        otherwise
            error('Time frecuency is not valid.');
    end
    
    url = strcat( ...
        url, ...
        '&g=', frecuencyTag ... % Frecuency
        );
else
    frecuency = 'daily';
end

% If startDate is specified...
if exist('startDate','var')
    url = strcat( ...
        url, ...
        '&a=', num2str(str2double(datestr(startDate, 'mm'))-1, '%02d'), ... % Month
        '&b=', datestr(startDate, 'dd'), ...                                % Day
        '&c=', datestr(startDate, 'yyyy') ...                               % Year
        );
end

% If endDate is specified...
if exist('endDate','var')
    url = strcat( ...
        url, ...
        '&d=', num2str(str2double(datestr(endDate, 'mm'))-1, '%02d'), ...   % Month
        '&e=', datestr(endDate, 'dd'), ...                                  % Day
        '&f=', datestr(endDate, 'yyyy') ...                                 % Year
        );
end

end
