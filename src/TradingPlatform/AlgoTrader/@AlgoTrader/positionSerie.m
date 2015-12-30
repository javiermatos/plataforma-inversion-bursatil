
function [positionSerie, priceSerie, dateTimeSerie, longPosition, shortPosition, noPosition] ...
    = positionSerie(algoTrader, rangeInit, rangeEnd, applySplit)

% rangeInit
if ~exist('rangeInit','var'); rangeInit = []; end
% rangeEnd
if ~exist('rangeEnd','var'); rangeEnd = []; end
% applySplit
if ~exist('applySplit','var'); applySplit = true; end

% Compute positions from signal and correct the result to get the absolute
% position (and not the relative to rangeInit)
[longPosition, shortPosition, noPosition, initIndex, endIndex] = algoTrader.signal2positions(rangeInit, rangeEnd, applySplit);
priceSerie = algoTrader.DataSerie.Serie(initIndex:endIndex);
dateTimeSerie = algoTrader.DataSerie.DateTime(initIndex:endIndex);

% Initialize values
positionSerie = zeros(1, length(priceSerie));

if ~isempty(longPosition) || ~isempty(shortPosition)
    
    position = sortrows([[longPosition ones(size(longPosition, 1),1)]; [shortPosition -ones(size(shortPosition, 1),1)]], 1);
    
    % Available funds to invest
    currentFunds = algoTrader.InitialFunds;
    
    
    for i = 1:size(position,1)
        
        % Open position price
        openPosition = position(i,1);
        openPrice = priceSerie(openPosition);
        
        % Close position price
        closePosition = position(i,2);
        closePrice = priceSerie(closePosition);
        
        % Number of stocks that we can buy/sell
        n = max(0,floor((min(currentFunds,algoTrader.InvestmentLimit)-2*algoTrader.TradingCost)*algoTrader.Money2Tick/openPrice));

        % Proceed only if we buy/sell
        if n > 0

            positionType = position(i,3);

            if positionType == 1
                % Long position
                currentFunds = ...
                    + currentFunds ...
                    + n*(closePrice-openPrice)*algoTrader.Tick2Money ...
                    - 2*algoTrader.TradingCost;
                positionSerie(openPosition:closePosition) = n*openPrice;
                
            elseif positionType == -1
                % Short position
                currentFunds = ...
                    + currentFunds ...
                    + n*(openPrice-closePrice)*algoTrader.Tick2Money ...
                    - 2*algoTrader.TradingCost;
                positionSerie(openPosition:closePosition) = -n*openPrice;
                
            end
            
        end
        
    end
    
end

end
