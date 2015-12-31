
function drawOscillator(algoTrader, axesHandle, setSelector, initIndex, endIndex)

% Parameters
dateTime = algoTrader.DataSerie.DateTime(initIndex:endIndex);

% macd signal and histogram
[macd, signal, histogram] = algoTrader.bareOutput(initIndex, endIndex);

% DataSerie
symbolCode = algoTrader.DataSerie.SymbolCode;
compressionType = algoTrader.DataSerie.CompressionType;
compressionUnits = algoTrader.DataSerie.CompressionUnits;

hold on;
bar(axesHandle, ...
    dateTime, ...
    histogram, ...
    'FaceColor', [0.4 0.4 0.4], ...
    'EdgeColor', [0.4 0.4 0.4] ...
    );
plot(axesHandle, ...
    dateTime, ...
    macd, ...
    'b', ...
    'LineWidth',1 ...
    );
plot(axesHandle, ...
    dateTime, ...
    signal, ...
    'r', ...
    'LineWidth', 1 ...
    );
hold off;

% Itemize
% Information and fixes
if Settings.ShowLegend
    legend(axesHandle, 'String', { 'Histogram' 'MACD' 'Signal' }, 'Location', 'NorthWest');
end
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