
function [diffProfitLossSerie, positionSerie, priceSerie, dateTimeSerie, longPosition, shortPosition, noPosition] ...
    = diffProfitLossSerie(algoTrader, rangeInit, rangeEnd, applySplit)

% rangeInit
if ~exist('rangeInit','var'); rangeInit = []; end
% rangeEnd
if ~exist('rangeEnd','var'); rangeEnd = []; end
% applySplit
if ~exist('applySplit','var'); applySplit = true; end

[profitLossSerie, positionSerie, priceSerie, dateTimeSerie, longPosition, shortPosition, noPosition] ...
    = algoTrader.profitLossSerie(rangeInit, rangeEnd, applySplit);

diffProfitLossSerie = [0 diff(profitLossSerie)./profitLossSerie(1:end-1)];

end
