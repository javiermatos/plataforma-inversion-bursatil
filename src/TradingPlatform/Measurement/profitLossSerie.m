
% Calculate Profit/Loss Serie
function serie = profitLossSerie(stockQuote, signal, transactionCost)

% Default transactionCost
if nargin < 3, transactionCost = 0; end

stockQuote = reshape(stockQuote,1,[]);

% Positions in the signal
[ longPosition, shortPosition ] = positions(signal);

% Initialize variable
serie = zeros(size(stockQuote));

% Long positions contribution
for i = 1:size(longPosition,1)
    
    serie(longPosition(i,1):longPosition(i,2)) = ...
        serie(longPosition(i,1):longPosition(i,2)) + ...
        stockQuote(longPosition(i,1):longPosition(i,2)) - stockQuote(longPosition(i,1));
    
    % TODO - Add transaction cost
    serie(longPosition(i,2)+1:end) = serie(longPosition(i,2)+1:end) + (stockQuote(longPosition(i,2)) - stockQuote(longPosition(i,1)));
    
end

% Short positions contribution
for i = 1:size(shortPosition,1)
    serie(shortPosition(i,1):shortPosition(i,2)) = ...
        serie(shortPosition(i,1):shortPosition(i,2)) + ...
        stockQuote(shortPosition(i,1)) - stockQuote(shortPosition(i,1):shortPosition(i,2));
    
    % TODO - Add transaction cost
    serie(shortPosition(i,2)+1:end) = serie(shortPosition(i,2)+1:end) + (stockQuote(shortPosition(i,1)) - stockQuote(shortPosition(i,2)));
    
end

if nargout == 0
    clf;
    subplot(3,1,1);
    plot(stockQuote);
    subplot(3,1,2);
    plot(serie);
    subplot(3,1,3);
    plot(signal);
end

end
