
function pfPerPosition = profitLossPerPosition(stockQuote, signal, transactionCost)

% Default transactionCost
if nargin < 3, transactionCost = 0; end

stockQuote = reshape(stockQuote,1,[]);

% Positions in the signal
[ longPosition, shortPosition ] = positions(signal);

% Profit/Loss in long positions
vLongPosition = zeros(size(longPosition,1),1);
for i = 1:size(longPosition,1)
    vLongPosition(i) = stockQuote(longPosition(i,2)) - stockQuote(longPosition(i,1));
end

% Profit/Loss in short positions
vShortPosition = zeros(size(shortPosition,1),1);
for i = 1:size(shortPosition,1)
    vShortPosition(i) = stockQuote(shortPosition(i,1)) - stockQuote(shortPosition(i,2));
end

pfPerPosition = ...
    [ ...
        [ ones(size(longPosition,1),1) longPosition vLongPosition ] ;
        [ -ones(size(shortPosition,1),1) shortPosition vShortPosition ] ...
    ];
pfPerPosition = sortrows(pfPerPosition,2);

end
