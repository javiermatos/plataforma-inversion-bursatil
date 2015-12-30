
function drawVolume(dataSerie, axesHandle, initIndex, endIndex)

serie = dataSerie.Volume(initIndex:endIndex);
dateTime = dataSerie.DateTime(initIndex:endIndex);
symbolCode = dataSerie.SymbolCode;
compressionType = dataSerie.CompressionType;
compressionUnits = dataSerie.CompressionUnits;

% Draw
hold on;
if Settings.VolumeType == 0
    bar(axesHandle, ...
        dateTime, serie, ...
        'FaceColor', Settings.VolumeFaceColor, ...
        'EdgeColor', Settings.VolumeEdgeColor, ...
        'BarWidth', Settings.VolumeBarWidth ...
        );
elseif Settings.VolumeType == 1
    plot(axesHandle, ...
        dateTime, serie, ...
        Settings.VolumeLineStyle, ...
        'Color', Settings.VolumeLineColor, ...
        'LineWidth', Settings.VolumeLineWidth ...
        );
end
hold off;

% Itemize
% Information and fixes
legend(axesHandle, 'Volume','Location','NorthWest');
xlabel(axesHandle, '\bfDateTime');
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
