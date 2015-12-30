
function [profitLossSerie, positionSerie, priceSerie, dateTimeSerie, longPosition, shortPosition, noPosition] ...
    = profitLossSerie(algoTrader, rangeInit, rangeEnd, applySplit)

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
profitLossSerie = ones(1, length(priceSerie));
positionSerie = zeros(1, length(priceSerie));

if ~isempty(longPosition) || ~isempty(shortPosition)
    
    position = sortrows([[longPosition ones(size(longPosition, 1),1)]; [shortPosition -ones(size(shortPosition, 1),1)]], 1);
    
    % We need a row vector
    %priceSerie = reshape(priceSerie, 1, []);
    
    % Available funds to invest
    currentFunds = algoTrader.InitialFunds;
    
    for i = 1:size(position,1)
        
        % Open position price
        openPosition = position(i,1);
        openPrice = priceSerie(openPosition);
        
        % Close position price
        closePosition = position(i,2);
        %closePrice = priceSerie(closePosition);
        
        % Number of stocks that we can buy/sell
        n = max(0,floor((min(currentFunds,algoTrader.InvestmentLimit)-2*algoTrader.TradingCost)*algoTrader.Money2Tick/openPrice));
        
        % Proceed only if we buy/sell
        if n > 0
            
            positionType = position(i,3);
            
            if positionType == 1
                % Long position
                profitLossSerie = longPositionFunction( ...
                    profitLossSerie, priceSerie, ...
                    openPosition, closePosition, ...
                    currentFunds, n, algoTrader.Tick2Money, algoTrader.TradingCost ...
                    );
                positionSerie(openPosition:closePosition) = n;
                
            elseif positionType == -1
                % Short position
                profitLossSerie = shortPositionFunction( ...
                    profitLossSerie, priceSerie, ...
                    openPosition, closePosition, ...
                    currentFunds, n, algoTrader.Tick2Money, algoTrader.TradingCost ...
                    );
                positionSerie(openPosition:closePosition) = -n;
                
            end
            
            % Update remaining funds
            currentFunds = profitLossSerie(end)*algoTrader.InitialFunds;
            
        end
        
    end
    
end

end

function profitLossSerie = longPositionFunction(profitLossSerie, priceSerie, initIndex, endIndex, currentFunds, n, tick2money, tradingCost)

profitLossSerieChunk = ...
    ( ...
        + currentFunds ...
        + n*(priceSerie(initIndex:endIndex)-priceSerie(initIndex))*tick2money ...
        - 2*tradingCost ...
    ) / currentFunds;

profitLossSerie(initIndex:end) = ...
    profitLossSerie(initIndex:end) .* ...
    [ ...
        profitLossSerieChunk ...
        profitLossSerieChunk(end)*ones(1,length(priceSerie)-endIndex) ...
    ];

end

function profitLossSerie = shortPositionFunction(profitLossSerie, priceSerie, initIndex, endIndex, currentFunds, n, tick2money, tradingCost)

profitLossSerieChunk = ...
    ( ...
        + currentFunds ...
        + n*(priceSerie(initIndex)-priceSerie(initIndex:endIndex))*tick2money ...
        - 2*tradingCost ...
    ) / currentFunds;

profitLossSerie(initIndex:end) = ...
    profitLossSerie(initIndex:end) .* ...
    [ ...
        profitLossSerieChunk ...
        profitLossSerieChunk(end)*ones(1,length(priceSerie)-endIndex) ...
    ];

end
