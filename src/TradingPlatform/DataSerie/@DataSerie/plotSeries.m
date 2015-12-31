
function fig = plotSeries(dataSerie, rangeInit, rangeEnd)

% rangeInit
if ~exist('rangeInit','var'); rangeInit = []; end
% rangeEnd
if ~exist('rangeEnd','var'); rangeEnd = []; end

figureHandle = dataSerie.plotWrapper(@drawSeries, [], rangeInit, rangeEnd);

% Protects against edition if needed
set(figureHandle,'HandleVisibility','callback');

% Define output argument if requested
if nargout == 1
    fig = figureHandle;
end

end
