
function fig = plotSeriePositionProfitLoss(algoTrader, setSelector, rangeInit, rangeEnd)

% rangeInit
if ~exist('rangeInit','var'); rangeInit = []; end
% rangeEnd
if ~exist('rangeEnd','var'); rangeEnd = []; end
% setSelector
if ~exist('setSelector','var'); setSelector = Default.TargetSet; end

dataSerie = algoTrader.DataSerie;

% rangeInit
if ~exist('rangeInit','var') || isempty(rangeInit)
    initIndex = 1;
elseif isscalar(rangeInit)
    initIndex = rangeInit;
elseif ischar(rangeInit)
    initIndex = find(datenum(rangeInit) <= dataSerie.DateTime, 1, 'first');
end

% rangeEnd
if ~exist('rangeEnd','var') || isempty(rangeEnd)
    endIndex = length(dataSerie.DateTime);
elseif isscalar(rangeEnd)
    endIndex = rangeEnd;
elseif ischar(rangeEnd)
    endIndex = find(datenum(rangeEnd) >= dataSerie.DateTime, 1, 'last');
end

% Description
description = [ ...
    'Serie/Position & Profit/Loss | ', ...
    dataSerie.SymbolCode, ' - ', ...
    dataSerie.CompressionType, ' ', '(', num2str(dataSerie.CompressionUnits) ,')', ...
    ' from ', datestr(dataSerie.DateTime(initIndex)), ...
    ' to ', datestr(dataSerie.DateTime(endIndex)) ...
    ];

% Figure handle
figureHandle = figure('Name',description);

% SeriePosition
seriePosition = subplot(2,1,1);
algoTrader.plotWrapper(@drawSeriePosition, seriePosition, setSelector, rangeInit, rangeEnd);

% ProfitLoss
profitLoss = subplot(2,1,2);
algoTrader.plotWrapper(@drawProfitLoss, profitLoss, setSelector, rangeInit, rangeEnd);

% Link axes views over x
linkaxes([seriePosition, profitLoss],'x');

% Protects against edition
set(figureHandle,'HandleVisibility','callback');

% Output
if nargout == 1
    fig = figureHandle;
end

end
