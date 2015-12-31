
function drawOscillator(algoTrader, axesHandle, setSelector, initIndex, endIndex)

% Parameters
dateTime = algoTrader.DataSerie.DateTime(initIndex:endIndex);

% Momentum
momentum = algoTrader.bareOutput(initIndex, endIndex);

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
    [dateTime(1) dateTime(end)], ...
    [0 0], ...
    'k', ...
    'LineWidth', 1 ...
    );
hold off;

% Itemize
% Information and fixes
if Default.ShowLegend
    legend(axesHandle, 'String', { 'Momentum' 'Zero line' } , 'Location', 'NorthWest');
end
xlabel(axesHandle, '\bfDate');
ylabel(axesHandle, '\bfValue');
xlim(axesHandle, [dateTime(1) dateTime(end)]);

% Axes Title
title(axesHandle, '\bfMomentum');

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
