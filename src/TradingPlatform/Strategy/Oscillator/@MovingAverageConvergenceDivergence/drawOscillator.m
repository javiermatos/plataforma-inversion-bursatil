
function drawOscillator(algoTrader, axesHandle, initIndex, endIndex)

% Parameters
mode = algoTrader.Mode;
lead = algoTrader.Lead;
lag = algoTrader.Lag;
signalMode = algoTrader.SignalMode;
signalSamples = algoTrader.SignalSamples;
serie = algoTrader.DataSerie.Serie(max(initIndex-(lag-1+signalSamples-1),1):endIndex);
dateTime = algoTrader.DataSerie.DateTime(initIndex:endIndex);

symbolCode = algoTrader.DataSerie.SymbolCode;
compressionType = algoTrader.DataSerie.CompressionType;
compressionUnits = algoTrader.DataSerie.CompressionUnits;

leadMovingAverage = movavg(serie, mode, lead);
lagMovingAverage = movavg(serie, mode, lag);
diff = leadMovingAverage-lagMovingAverage;
diffMovingAverage = movavg(diff(lag:end), signalMode, signalSamples);
diffMovingAverage = [ NaN(1, lag-1) diffMovingAverage ];

diff = diff(end-(endIndex-initIndex):end);
diffMovingAverage = diffMovingAverage(end-(endIndex-initIndex):end);

hold on;
plot(axesHandle, ...
    dateTime, ...
    diff, ...
    'k', ...
    'LineWidth',1 ...
    );
plot(axesHandle, ...
    dateTime, ...
    diffMovingAverage, ...
    'b', ...
    'LineWidth', 1 ...
    );
hold off;

% Itemize
% Information and fixes
legend(axesHandle, 'String', { 'MACD' 'Signal' }, 'Location', 'NorthWest');
xlabel(axesHandle, '\bfDate');
ylabel(axesHandle, '\bfValue');
xlim(axesHandle, [dateTime(1) dateTime(end)]);

% Axes Title
title(axesHandle, '\bfMoving Average Convergence/Divergence');

% Description
description = [ ...
    'Moving Average Convergence/Divergence | ', ...
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
