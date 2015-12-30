
function profitLoss = profitLoss(algoTrader, rangeInit, rangeEnd, applySplit)

% rangeInit
if ~exist('rangeInit','var'); rangeInit = []; end
% rangeEnd
if ~exist('rangeEnd','var'); rangeEnd = []; end
% applySplit
if ~exist('applySplit','var'); applySplit = true; end

% Compute positions from signal and correct the result to get the absolute
% position (and not the relative to rangeInit)
[longPosition, shortPosition, ~, initIndex, endIndex] = algoTrader.signal2positions(rangeInit, rangeEnd, applySplit);
priceSerie = algoTrader.DataSerie.Serie(initIndex:endIndex);

% Initialize values
profitLoss = 1;

if ~isempty(longPosition) || ~isempty(shortPosition)
    
    position = sortrows([[longPosition ones(size(longPosition, 1),1)]; [shortPosition -ones(size(shortPosition, 1),1)]], 1);
    
    % Available funds to invest
    currentFunds = algoTrader.InitialFunds;
    
    
    for i = 1:size(position,1)
        
        % Open position price
        openPrice = priceSerie(position(i,1));
        
        % Close position price
        closePrice = priceSerie(position(i,2));

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
                
            elseif positionType == -1
                % Short position
                currentFunds = ...
                    + currentFunds ...
                    + n*(openPrice-closePrice)*algoTrader.Tick2Money ...
                    - 2*algoTrader.TradingCost;
            end
            
        end
        
    end
    
    profitLoss = (currentFunds/algoTrader.InitialFunds);
    
end

end
