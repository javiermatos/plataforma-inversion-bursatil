
function drawOpen(dataSerie, axesHandle, initIndex, endIndex)

serie = dataSerie.Open(initIndex:endIndex);
dateTime = dataSerie.DateTime(initIndex:endIndex);
symbolCode = dataSerie.SymbolCode;
compressionType = dataSerie.CompressionType;
compressionUnits = dataSerie.CompressionUnits;

% Draw
hold on;
plot(axesHandle, ...
    dateTime, serie, ...
    Settings.OpenLineStyle, ...
    'Color', Settings.OpenLineColor, ...
    'LineWidth', Settings.PriceLineWidth ...
    );
hold off;

% Itemize
% Information and fixes
if Settings.ShowLegend
    legend(axesHandle, 'Open','Location','NorthWest');
end
xlabel(axesHandle, '\bfDate');
ylabel(axesHandle, '\bfPrice');
xlim(axesHandle, [dateTime(1) dateTime(end)]);

% Axes Title
title(axesHandle, '\bfOpen');

% Description
description = [ ...
    'Open | ', ...
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
