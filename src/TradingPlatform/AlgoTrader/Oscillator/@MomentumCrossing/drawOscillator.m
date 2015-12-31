
function drawOscillator(algoTrader, axesHandle, setSelector, initIndex, endIndex)

% Parameters
dateTime = algoTrader.DataSerie.DateTime(initIndex:endIndex);

% Momentum
[momentum, movingAverage] = algoTrader.bareOutput(initIndex, endIndex);

% DataSerie
symbolCode = algoTrader.DataSerie.SymbolCode;
compressionType = algoTrader.DataSerie.CompressionType;
compressionUnits = algoTrader.DataSerie.CompressionUnits;

hold on;
plot(axesHandle, ...
    dateTime, ...
    momentum, ...
    'b', ...
    'LineWidth',1 ...
    );
plot(axesHandle, ...
    dateTime, ...
    movingAverage, ...
    'm', ...
    'LineWidth',1 ...
    );
hold off;

% Itemize
% Information and fixes
if Settings.ShowLegend
    legend(axesHandle, 'String', { 'Momentum' 'Moving Average' } , 'Location', 'NorthWest');
end
xlabel(axesHandle, '\bfDate');
ylabel(axesHandle, '\bfValue');
xlim(axesHandle, [dateTime(1) dateTime(end)]);

% Axes Title
title(axesHandle, '\bfMomentumCrossing');

% Description
description = [ ...
    'Momentum | ', ...
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
