
function fig = plot(algoTrader, rangeInit, rangeEnd, applySplit)

% rangeInit
if ~exist('rangeInit','var'); rangeInit = []; end
% rangeEnd
if ~exist('rangeEnd','var'); rangeEnd = []; end
% applySplit
if ~exist('applySplit','var'); applySplit = true; end

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
    class(algoTrader), ' | ', ...
    dataSerie.SymbolCode, ' - ', ...
    dataSerie.CompressionType, ' ', '(', num2str(dataSerie.CompressionUnits) ,')', ...
    ' from ', datestr(dataSerie.DateTime(initIndex)), ...
    ' to ', datestr(dataSerie.DateTime(endIndex)) ...
    ];

% Figure handle
figureHandle = figure('Name',description);

% SeriePosition
seriePosition = subplot(2,1,1);
algoTrader.plotWrapper(@drawSeriePosition, seriePosition, rangeInit, rangeEnd, applySplit);

% Position
position = subplot(4,1,3);
algoTrader.plotWrapper(@drawPosition, position, rangeInit, rangeEnd, applySplit);

% ProfitLoss
profitLoss = subplot(4,1,4);
algoTrader.plotWrapper(@drawProfitLoss, profitLoss, rangeInit, rangeEnd, applySplit);

% Link axes views over x
linkaxes([seriePosition, position, profitLoss],'x');

% Protects against edition
set(figureHandle,'HandleVisibility','callback');

% Output
if nargout == 1
    fig = figureHandle;
end

end
