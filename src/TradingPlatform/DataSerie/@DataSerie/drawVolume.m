
function drawVolume(dataSerie, axesHandle, initIndex, endIndex)

serie = dataSerie.Volume(initIndex:endIndex);
dateTime = dataSerie.DateTime(initIndex:endIndex);
symbolCode = dataSerie.SymbolCode;
compressionType = dataSerie.CompressionType;
compressionUnits = dataSerie.CompressionUnits;

% Draw
hold on;
if Default.VolumeType == 0
    bar(axesHandle, ...
        dateTime, serie, ...
        'FaceColor', Default.VolumeFaceColor, ...
        'EdgeColor', Default.VolumeEdgeColor, ...
        'BarWidth', Default.VolumeBarWidth ...
        );
elseif Default.VolumeType == 1
    plot(axesHandle, ...
        dateTime, serie, ...
        Default.VolumeLineStyle, ...
        'Color', Default.VolumeLineColor, ...
        'LineWidth', Default.VolumeLineWidth ...
        );
end
hold off;

% Itemize
% Information and fixes
if Default.ShowLegend
    legend(axesHandle, 'Volume','Location','NorthWest');
end
xlabel(axesHandle, '\bfDate');
ylabel(axesHandle, '\bfQuantity');
xlim(axesHandle, [dateTime(1) dateTime(end)]);

% Axes Title
title(axesHandle, '\bfVolume');

% Description
description = [ ...
    'Volume | ', ...
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
