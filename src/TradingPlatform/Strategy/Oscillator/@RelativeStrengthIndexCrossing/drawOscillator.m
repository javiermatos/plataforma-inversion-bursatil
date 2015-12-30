
function drawOscillator(algoTrader, axesHandle, initIndex, endIndex)

% Parameters
samples = algoTrader.Samples;
mode = algoTrader.Mode;
crossingSamples = algoTrader.CrossingSamples;
serie = algoTrader.DataSerie.Serie(max(initIndex-(samples+crossingSamples)+1,1):endIndex);
dateTime = algoTrader.DataSerie.DateTime(initIndex:endIndex);

symbolCode = algoTrader.DataSerie.SymbolCode;
compressionType = algoTrader.DataSerie.CompressionType;
compressionUnits = algoTrader.DataSerie.CompressionUnits;

relativeStrengthIndex = rsindex(serie, samples);
relativeStrengthIndexModified = relativeStrengthIndex;
% Only NaN values at first
relativeStrengthIndexModified(isnan(relativeStrengthIndexModified(samples+1:end))) = 50;
movingAverage = movavg(relativeStrengthIndexModified(samples+1:end), mode, crossingSamples);
movingAverage = [NaN(1, samples) movingAverage];
relativeStrengthIndex = relativeStrengthIndex(end-(endIndex-initIndex):end);
movingAverage = movingAverage(end-(endIndex-initIndex):end);

hold on;
plot(axesHandle, ...
    dateTime, ...
    relativeStrengthIndex, ...
    'k', ...
    'LineWidth',1 ...
    );
plot(axesHandle, ...
    dateTime, ...
    movingAverage, ...
    'b', ...
    'LineWidth', 1 ...
    );
hold off;

% Itemize
% Information and fixes
legend(axesHandle, 'String', { 'Relative Strength Index Crossing' 'Moving Average' }, 'Location', 'NorthWest');
xlabel(axesHandle, '\bfDate');
ylabel(axesHandle, '\bfValue');
xlim(axesHandle, [dateTime(1) dateTime(end)]);

% Axes Title
title(axesHandle, '\bfRelative Strength Index Crossing');

% Description
description = [ ...
    'Relative Strength Index Crossing | ', ...
    symbolCode, ' - ', ...
    compressionType, ' ', '(', num2str(compressionUnits) ,')', ...
    ' from ', datestr(dateTime(1)), ...
    ' to ', datestr(dateTime(end)) ...
    ];

% Figure Name
figureHandle = get(axesHandle,'Parent');
if isempty(get(figureHandle,'Name'))
    set(figureHandle,'Name',description);
end

end
