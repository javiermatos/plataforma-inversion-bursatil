
function fig = plotDiffProfitLoss(algoTrader, rangeInit, rangeEnd, applySplit)

% rangeInit
if ~exist('rangeInit','var'); rangeInit = []; end
% rangeEnd
if ~exist('rangeEnd','var'); rangeEnd = []; end
% applySplit
if ~exist('applySplit','var'); applySplit = true; end

figureHandle = algoTrader.plotWrapper(@drawDiffProfitLoss, [], rangeInit, rangeEnd, applySplit);

% Protects against edition if needed
set(figureHandle,'HandleVisibility','callback');

% Define output argument if requested
if nargout == 1
    fig = figureHandle;
end

end
