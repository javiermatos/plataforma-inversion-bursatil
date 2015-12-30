
function drawOscillator(algoTrader, axesHandle, initIndex, endIndex)

% Parameters
delay = algoTrader.Delay;
serie = algoTrader.DataSerie.Serie(max(initIndex-delay,1):endIndex);
dateTime = algoTrader.DataSerie.DateTime(initIndex:endIndex);

symbolCode = algoTrader.DataSerie.SymbolCode;
compressionType = algoTrader.DataSerie.CompressionType;
compressionUnits = algoTrader.DataSerie.CompressionUnits;

% Momentum
momentum = [NaN(1, delay) serie(delay+1:end)-serie(1:end-delay)];
momentum = momentum(end-(endIndex-initIndex):end);

hold on;
plot(axesHandle, ...
    dateTime, ...
    momentum, ...
    'r', ...
    'LineWidth',1 ...
    );
plot(axesHandle, ...
    [dateTime(1), dateTime(end)], ...
    [0, 0], ...
    'k', ...
    'LineWidth', 1 ...
    );
hold off;

% Itemize
% Information and fixes
legend(axesHandle, 'String', { 'Momentum' 'Zero line' } , 'Location', 'NorthWest');
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
