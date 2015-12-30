
function drawOscillator(algoTrader, axesHandle, initIndex, endIndex)

samples = algoTrader.Samples;
mode = algoTrader.Mode;
crossingSamples = algoTrader.CrossingSamples;
highSerie = algoTrader.DataSerie.High(max(initIndex-(samples+crossingSamples)+1,1):endIndex);
lowSerie = algoTrader.DataSerie.Low(max(initIndex-(samples+crossingSamples)+1,1):endIndex);
closeSerie = algoTrader.DataSerie.Close(max(initIndex-(samples+crossingSamples)+1,1):endIndex);
dateTime = algoTrader.DataSerie.DateTime(initIndex:endIndex);

symbolCode = algoTrader.DataSerie.SymbolCode;
compressionType = algoTrader.DataSerie.CompressionType;
compressionUnits = algoTrader.DataSerie.CompressionUnits;

stochastic = stoch(highSerie, lowSerie, closeSerie, samples);
movingAverage = movavg(stochastic(samples:end), mode, crossingSamples);
movingAverage = [NaN(1, samples-1) movingAverage];
stochastic = stochastic(end-(endIndex-initIndex):end);
movingAverage = movingAverage(end-(endIndex-initIndex):end);

hold on;
plot(axesHandle, ...
    dateTime, ...
    stochastic, ...
    'k', ...
    'LineWidth', 1 ...
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
legend(axesHandle, 'String', { 'Stochastic Crossing' 'Moving Average' }, 'Location', 'NorthWest');
xlabel(axesHandle, '\bfDate');
ylabel(axesHandle, '\bfValue');
xlim(axesHandle, [dateTime(1) dateTime(end)]);

% Axes Title
title(axesHandle, '\bfStochastic Crossing');

% Description
description = [ ...
    'Stochastic Crossing | ', ...
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
