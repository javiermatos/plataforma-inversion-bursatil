
function printPositionsLog(algoTrader, setSelector, rangeInit, rangeEnd)

% rangeInit
if ~exist('rangeInit','var'); rangeInit = []; end
% rangeEnd
if ~exist('rangeEnd','var'); rangeEnd = []; end
% setSelector
if ~exist('setSelector','var'); setSelector = Default.TargetSet; end

[positionType, openIndex, closeIndex, openDate, closeDate, openPrice, closePrice, profitLoss] ...
    = positionsLog(algoTrader, setSelector, rangeInit, rangeEnd);

openDate = datestr(openDate, Default.DateFormat);
closeDate = datestr(closeDate, Default.DateFormat);
table = [];
for i = 1:size(positionType,1)
    
    table = [table sprintf(['%+d [%5.4g %5.4g] [' openDate(i,:) ' ' closeDate(i,:) '] [%6.5g %6.5g] %6.5f\n'], ...
        positionType(i), ...
        openIndex(i), ...
        closeIndex(i), ...
        openPrice(i), ...
        closePrice(i), ...
        profitLoss(i) ...
        )];
    
end

disp(table);

end
