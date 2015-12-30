
function m = struct2matrix(stockData)

m = [ ...
        stockData.date, ...     % Date
        stockData.open, ...     % Open
        stockData.high, ...     % High
        stockData.low, ...      % Low
        stockData.close, ...    % Close
        stockData.volume ...    % Volume
    ];

end
