
function [diffProfitLossSerie, positionSerie, priceSerie, dateTimeSerie, longPosition, shortPosition, noPosition] ...
    = diffProfitLossSerie(algoTrader, setSelector, rangeInit, rangeEnd)

% rangeInit
if ~exist('rangeInit','var'); rangeInit = []; end
% rangeEnd
if ~exist('rangeEnd','var'); rangeEnd = []; end
% setSelector
if ~exist('setSelector','var'); setSelector = Settings.TargetSet; end

[profitLossSerie, positionSerie, priceSerie, dateTimeSerie, longPosition, shortPosition, noPosition] ...
    = algoTrader.profitLossSerie(setSelector, rangeInit, rangeEnd);

diffProfitLossSerie = [0 diff(profitLossSerie)./profitLossSerie(1:end-1)];

end
