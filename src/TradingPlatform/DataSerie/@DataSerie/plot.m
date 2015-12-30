
function fig = plot(dataSerie, rangeInit, rangeEnd)

% rangeInit
if ~exist('rangeInit','var'); rangeInit = []; end
% rangeEnd
if ~exist('rangeEnd','var'); rangeEnd = []; end

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
    class(dataSerie), ' | ', ...
    dataSerie.SymbolCode, ' - ', ...
    dataSerie.CompressionType, ' ', '(', num2str(dataSerie.CompressionUnits) ,')', ...
    ' from ', datestr(dataSerie.DateTime(initIndex)), ...
    ' to ', datestr(dataSerie.DateTime(endIndex)) ...
    ];

% Figure handle
figureHandle = figure('Name',description);

% Serie
serie = subplot(2,1,1);
dataSerie.plotWrapper(@drawSerie, serie, rangeInit, rangeEnd);

% Volume
volume = subplot(2,1,2);
dataSerie.plotWrapper(@drawVolume, volume, rangeInit, rangeEnd);

% Link axes views over x
linkaxes([serie, volume],'x');

% Protects against edition
set(figureHandle,'HandleVisibility','callback');

% Output
if nargout == 1
    fig = figureHandle;
end

end
