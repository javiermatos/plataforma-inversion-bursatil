
function fig = plotOscillator(algoTrader, setSelector, rangeInit, rangeEnd)

% rangeInit
if ~exist('rangeInit','var'); rangeInit = []; end
% rangeEnd
if ~exist('rangeEnd','var'); rangeEnd = []; end
% setSelector
if ~exist('setSelector','var'); setSelector = Settings.TargetSet; end

figureHandle = algoTrader.plotWrapper(@drawOscillator, [], setSelector, rangeInit, rangeEnd);

% Protects against edition if needed
set(figureHandle,'HandleVisibility','callback');

% Define output argument if requested
if nargout == 1
    fig = figureHandle;
end

end