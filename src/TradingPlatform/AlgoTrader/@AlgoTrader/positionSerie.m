
function [positionSerie, priceSerie, dateTimeSerie, longPosition, shortPosition, noPosition] ...
    = positionSerie(algoTrader, setSelector, rangeInit, rangeEnd)

% rangeInit
if ~exist('rangeInit','var'); rangeInit = []; end
% rangeEnd
if ~exist('rangeEnd','var'); rangeEnd = []; end
% setSelector
if ~exist('setSelector','var'); setSelector = Settings.TargetSet; end

% Compute positions from signal and correct the result to get the absolute
% position (and not the relative to rangeInit)
[longPosition, shortPosition, noPosition, initIndex, endIndex] = algoTrader.signal2positions(setSelector, rangeInit, rangeEnd);
priceSerie = algoTrader.DataSerie.Serie(initIndex:endIndex);
dateTimeSerie = algoTrader.DataSerie.DateTime(initIndex:endIndex);

% Initialize values
positionSerie = zeros(1, length(priceSerie));

% Positions table
positions = sortrows([[ones(size(longPosition, 1),1) longPosition]; [-ones(size(shortPosition, 1),1) shortPosition]], 2);
positionType = positions(:,1);
openPosition = positions(:,2);
openPrice = priceSerie(openPosition)';
closePosition = positions(:,3);
closePrice = priceSerie(closePosition)';

% Available funds to invest
currentFunds = algoTrader.InitialFunds;

diff = positionType.*(closePrice-openPrice);

for i = 1:length(diff)
    
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
    
    if n > 0
        
        newFunds = ...
            + currentFunds ...
            + n*(diff(i)) ...
            - (fixedCost0 + variableCost0) ...
            - (fixedCostN + variableCostN);
        
        positionSerie(openPosition(i):closePosition(i)) = positionType(i)*n*openPrice(i);
        
        currentFunds = newFunds;
        
    end
    
end

end
