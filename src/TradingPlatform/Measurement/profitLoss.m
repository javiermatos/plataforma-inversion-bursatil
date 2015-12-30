
function pl = profitLoss(stockQuote, signal, transactionCost)

% Default transactionCost
if nargin < 3, transactionCost = 0; end

stockQuote = reshape(stockQuote,1,[]);

% Positions in the signal
[ longPosition, shortPosition ] = positions(signal);

% Calculate Profit/Loss
% Transaction cost
pl = -(size(longPosition,1)+size(shortPosition,1))*2*transactionCost;

% Long positions contribution
if ~isempty(longPosition)
    pl = pl + ...
        - sum(stockQuote(longPosition(:,1))) ...    % Open long position
        + sum(stockQuote(longPosition(:,2)));       % Close long position
end

% Short positions contribution
if ~isempty(shortPosition)
    pl = pl + ...
        + sum(stockQuote(shortPosition(:,1))) ...   % Open short position
        - sum(stockQuote(shortPosition(:,2)));      % Close short position
end

end
