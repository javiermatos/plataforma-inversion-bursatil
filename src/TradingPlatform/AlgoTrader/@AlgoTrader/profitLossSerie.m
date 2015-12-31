
function [profitLossSerie, positionSerie, priceSerie, dateTimeSerie, longPosition, shortPosition, noPosition] ...
    = profitLossSerie(algoTrader, setSelector, rangeInit, rangeEnd)

% rangeInit
if ~exist('rangeInit','var'); rangeInit = []; end
% rangeEnd
if ~exist('rangeEnd','var'); rangeEnd = []; end
% setSelector
if ~exist('setSelector','var'); setSelector = Default.TargetSet; end

% Compute positions from signal and correct the result to get the absolute
% position (and not the relative to rangeInit)
[longPosition, shortPosition, noPosition, initIndex, endIndex] = algoTrader.signal2positions(setSelector, rangeInit, rangeEnd);
priceSerie = algoTrader.DataSerie.Serie(initIndex:endIndex);
dateTimeSerie = algoTrader.DataSerie.DateTime(initIndex:endIndex);

% Initialize values
profitLossSerie = ones(1, length(priceSerie));
positionSerie = zeros(1, length(priceSerie));

% Positions table
positions = sortrows([[ones(size(longPosition, 1),1) longPosition]; [-ones(size(shortPosition, 1),1) shortPosition]], 2);
positionType = positions(:,1);
openPosition = positions(:,2);
openPrice = priceSerie(positions(:,2));
closePosition = positions(:,3);
closePrice = priceSerie(positions(:,3));

% Available funds to invest
currentFunds = algoTrader.InitialFunds;

for i = 1:size(positionType,1)
    
    % Number of stocks that we can buy/sell
    investment = min(currentFunds,algoTrader.InvestmentLimit);
    n = max(0,floor(investment/openPrice(i)));
    
    investmentCapital0 = n*openPrice(i);
    index0 = find(investmentCapital0<=algoTrader.TradingCost(:,1), 1, 'first');
    fixedCost0 = algoTrader.TradingCost(index0,2);
    variableCost0 = algoTrader.TradingCost(index0,3)*investmentCapital0/100;
    
    investmentCapitalN = n*closePrice(i);
    indexN = find(investmentCapitalN<=algoTrader.TradingCost(:,1), 1, 'first');
    fixedCostN = algoTrader.TradingCost(indexN,2);
    variableCostN = algoTrader.TradingCost(indexN,3)*investmentCapitalN/100;
    
    % Proceed only if we can buy or sell
    if n > 0
        
        if positionType(i) == 1
            % Long position
            profitLossSerie = longPositionFunction( ...
                profitLossSerie, priceSerie, ...
                openPosition(i), closePosition(i), ...
                currentFunds, n, ...
                fixedCost0, variableCost0, ...
                fixedCostN, variableCostN ...
                );
            positionSerie(openPosition:closePosition) = n;
            
        elseif positionType(i) == -1
            % Short position
            profitLossSerie = shortPositionFunction( ...
                profitLossSerie, priceSerie, ...
                openPosition(i), closePosition(i), ...
                currentFunds, n, ...
                fixedCost0, variableCost0, ...
                fixedCostN, variableCostN ...
                );
            positionSerie(openPosition:closePosition) = -n;
            
        end
        
        % Update remaining funds
        currentFunds = profitLossSerie(end)*algoTrader.InitialFunds;
        
    end
    
end

end

function profitLossSerie = longPositionFunction(profitLossSerie, priceSerie, initIndex, endIndex, currentFunds, n, fixedCost0, variableCost0, fixedCostN, variableCostN)

profitLossSerieChunk = ...
    ( ...
        + currentFunds ...
        + n*(priceSerie(initIndex:endIndex)-priceSerie(initIndex)) ...
        - (fixedCost0 + variableCost0) ...
    );

profitLossSerieChunk(end) = profitLossSerieChunk(end)-(fixedCostN+variableCostN);
profitLossSerieChunk = profitLossSerieChunk/currentFunds;

profitLossSerie(initIndex:end) = ...
    profitLossSerie(initIndex:end) .* ...
    [ ...
        profitLossSerieChunk ...
        profitLossSerieChunk(end)*ones(1,length(priceSerie)-endIndex) ...
    ];

end

function profitLossSerie = shortPositionFunction(profitLossSerie, priceSerie, initIndex, endIndex, currentFunds, n, fixedCost0, variableCost0, fixedCostN, variableCostN)

profitLossSerieChunk = ...
    ( ...
        + currentFunds ...
        + n*(priceSerie(initIndex)-priceSerie(initIndex:endIndex)) ...
        - (fixedCost0 + variableCost0) ...
    );

profitLossSerieChunk(end) = profitLossSerieChunk(end)-(fixedCostN+variableCostN);
profitLossSerieChunk = profitLossSerieChunk/currentFunds;

profitLossSerie(initIndex:end) = ...
    profitLossSerie(initIndex:end) .* ...
    [ ...
        profitLossSerieChunk ...
        profitLossSerieChunk(end)*ones(1,length(priceSerie)-endIndex) ...
    ];

end
