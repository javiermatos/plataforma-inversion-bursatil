
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
    Settings.DiffSerieLineStyle, ...
    'Color', Settings.DiffSerieLineColor, ...
    'LineWidth', Settings.PriceLineWidth ...
    );
hold off;

% Itemize
% Information and fixes
legend(axesHandle, 'DiffSerie','Location','NorthWest');
xlabel(axesHandle, '\bfDateTime');
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