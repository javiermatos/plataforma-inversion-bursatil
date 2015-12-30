
% Calculate Profit/Loss Serie
function profitLossSerie = computeProfitLossSerie(te, set)

% var
if ~exist('set','var'); set = 'all'; end

% position
[longPosition, shortPosition, ~, serie] = te.computePositionsSerie(set);
position = [];
if ~isempty(longPosition) || ~isempty(shortPosition)
    position = sortrows([[ones(size(longPosition, 1),1) longPosition]; [-ones(size(shortPosition, 1),1) shortPosition]], 2);
end

% reshape
serie = reshape(serie, 1, []);

% function to apply
switch lower(te.Measurement)
    case 'relative'
        lpfun = @relativeLongPositionProfitLossSerie;
        spfun = @relativeShortPositionProfitLossSerie;
    case 'absolute'
        lpfun = @absoluteLongPositionProfitLossSerie;
        spfun = @absoluteShortPositionProfitLossSerie;
end

% Available funds to invest
funds = te.Investment;

% Initialize profit/loss serie
profitLossSerie = zeros(1, te.FinancialTimeSerie.Length);

for i = 1:size(position,1)
    
    % Open position price
    openPosition = position(i,2);
    open = serie(openPosition);
    % Close position price
    closePosition = position(i,3);
    close = serie(closePosition);
    
    % Number of stocks that we can buy
    n = max(0,floor((funds-2*te.TradeCost)*te.Money2Tick/open));
    
    % Proceed only if we buy/sell
    if n > 0
        
        type = position(i,1);
        if type == 1
            % Long position
            profitLossSerie = lpfun(profitLossSerie, serie, openPosition, closePosition, funds, n, te.Tick2Money, te.TradeCost);
            funds = n*(close-open)*te.Tick2Money+funds-2*te.TradeCost;

        elseif type == -1
            % Short position
            profitLossSerie = spfun(profitLossSerie, serie, openPosition, closePosition, funds, n, te.Tick2Money, te.TradeCost);
            funds = n*(open-close)*te.Tick2Money+funds-2*te.TradeCost;

        end
        
    end
    
end


end

function profitLossSerie = relativeLongPositionProfitLossSerie(profitLossSerie, serie, startIndex, endIndex, funds, n, tick2money, tradeCost)

open = serie(startIndex);
close = serie(endIndex);
subset = serie(startIndex:endIndex);

profitLossSerie(startIndex:end) = ...
    (profitLossSerie(startIndex:end)+1) .* ...
    [ ...
        (n*(subset-open)*tick2money+funds-2*tradeCost)/funds ...
        ones(1,length(serie)-endIndex)*((n*(close-open)*tick2money+funds-2*tradeCost)/funds) ...
    ]-1;

end

function profitLossSerie = relativeShortPositionProfitLossSerie(profitLossSerie, serie, startIndex, endIndex, funds, n, tick2money, tradeCost)

open = serie(startIndex);
close = serie(endIndex);
subset = serie(startIndex:endIndex);

profitLossSerie(startIndex:end) = ...
    (profitLossSerie(startIndex:end)+1) .* ...
    [ ...
        (n*(open-subset)*tick2money+funds-2*tradeCost)/funds ...
        ones(1,length(serie)-endIndex)*((n*(open-close)*tick2money+funds-2*tradeCost)/funds) ...
    ]-1;

end

function profitLossSerie = absoluteLongPositionProfitLossSerie(profitLossSerie, serie, startIndex, endIndex, funds, n, tick2money, tradeCost)

open = serie(startIndex);
close = serie(endIndex);
subset = serie(startIndex:endIndex);

profitLossSerie(startIndex:end) = ...
    profitLossSerie(startIndex:end) + ...
    [ ...
        n*(subset-open)*tick2money-2*tradeCost ...
        ones(1,length(serie)-endIndex)*(n*(close-open)*tick2money-2*tradeCost) ...
    ];

end

function profitLossSerie = absoluteShortPositionProfitLossSerie(profitLossSerie, serie, startIndex, endIndex, funds, n, tick2money, tradeCost)

open = serie(startIndex);
close = serie(endIndex);
subset = serie(startIndex:endIndex);

profitLossSerie(startIndex:end) = ...
    profitLossSerie(startIndex:end) + ...
    [ ...
        n*(open-subset)*tick2money-2*tradeCost ...
        ones(1,length(serie)-endIndex)*(n*(open-close)*tick2money-2*tradeCost) ...
    ];

end
