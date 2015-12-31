
function fig = plotSignal(algoTrader, setSelector, rangeInit, rangeEnd)

% rangeInit
if ~exist('rangeInit','var'); rangeInit = []; end
% rangeEnd
if ~exist('rangeEnd','var'); rangeEnd = []; end
% setSelector
if ~exist('setSelector','var'); setSelector = Default.TargetSet; end

figureHandle = algoTrader.plotWrapper(@drawSignal, [], setSelector, rangeInit, rangeEnd);

% plotWrapper correction
%axesHandle = get(figureHandle,'CurrentAxes');
%ylim(axesHandle,[-2 2]);

% Protects against edition if needed
set(figureHandle,'HandleVisibility','callback');

% Define output argument if requested
if nargout == 1
    fig = figureHandle;
end

end
