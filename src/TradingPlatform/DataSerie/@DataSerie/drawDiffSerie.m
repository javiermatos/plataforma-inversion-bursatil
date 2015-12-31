
function drawDiffSerie(dataSerie, axesHandle, initIndex, endIndex)

serie = dataSerie.DiffSerie(initIndex:endIndex);
dateTime = dataSerie.DateTime(initIndex:endIndex);
symbolCode = dataSerie.SymbolCode;
compressionType = dataSerie.CompressionType;
compressionUnits = dataSerie.CompressionUnits;

% Draw
hold on;
plot(axesHandle, ...
    dateTime, serie, ...
    Default.DiffSerieLineStyle, ...
    'Color', Default.DiffSerieLineColor, ...
    'LineWidth', Default.PriceLineWidth ...
    );
hold off;

% Itemize
% Information and fixes
if Default.ShowLegend
    legend(axesHandle, 'DiffSerie','Location','NorthWest');
end
xlabel(axesHandle, '\bfDate');
ylabel(axesHandle, '\bfDiffSerie');
xlim(axesHandle, [dateTime(1) dateTime(end)]);

% Axes Title
title(axesHandle, '\bfDiffSerie');

% Description
description = [ ...
    'Close | ', ...
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
