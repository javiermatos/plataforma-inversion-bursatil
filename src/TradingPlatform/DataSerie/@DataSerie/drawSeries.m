
function drawSeries(dataSerie, axesHandle, initIndex, endIndex)

open = dataSerie.Open(initIndex:endIndex);
high = dataSerie.High(initIndex:endIndex);
low = dataSerie.Low(initIndex:endIndex);
close = dataSerie.Close(initIndex:endIndex);
dateTime = dataSerie.DateTime(initIndex:endIndex);
symbolCode = dataSerie.SymbolCode;
compressionType = dataSerie.CompressionType;
compressionUnits = dataSerie.CompressionUnits;

% Draw
hold on;
plot(axesHandle, ...
    dateTime, open, ...
    Default.OpenLineStyle, ...
    'Color', Default.OpenLineColor, ...
    'LineWidth', Default.PriceLineWidth ...
    );
plot(axesHandle, ...
    dateTime, high, ...
    Default.HighLineStyle, ...
    'Color', Default.HighLineColor, ...
    'LineWidth', Default.PriceLineWidth ...
    );
plot(axesHandle, ...
    dateTime, low, ...
    Default.LowLineStyle, ...
    'Color', Default.LowLineColor, ...
    'LineWidth', Default.PriceLineWidth ...
    );
plot(axesHandle, ...
    dateTime, close, ...
    Default.CloseLineStyle, ...
    'Color', Default.CloseLineColor, ...
    'LineWidth', Default.PriceLineWidth ...
    );
hold off;

% Itemize
% Information and fixes
if Default.ShowLegend
    legend(axesHandle, 'Open','High','Low','Close','Location','NorthWest');
end
xlabel(axesHandle, '\bfDate');
ylabel(axesHandle, '\bfPrice');
xlim(axesHandle, [dateTime(1) dateTime(end)]);

% Axes Title
title(axesHandle, '\bfSeries');

% Description
description = [ ...
    'Series | ', ...
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
