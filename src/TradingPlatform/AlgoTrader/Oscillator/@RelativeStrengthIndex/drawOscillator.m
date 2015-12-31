
function drawOscillator(algoTrader, axesHandle, setSelector, initIndex, endIndex)

% Parameters
riseThreshold = algoTrader.RiseThreshold;
fallThreshold = algoTrader.FallThreshold;
dateTime = algoTrader.DataSerie.DateTime(initIndex:endIndex);

% Relative Strength Index
relativeStrengthIndex = algoTrader.bareOutput(initIndex, endIndex);

% DataSerie
symbolCode = algoTrader.DataSerie.SymbolCode;
compressionType = algoTrader.DataSerie.CompressionType;
compressionUnits = algoTrader.DataSerie.CompressionUnits;

hold on;
plot(axesHandle, ...
    dateTime, ...
    relativeStrengthIndex, ...
    'b', ...
    'LineWidth',1 ...
    );
plot(axesHandle, ...
    [dateTime(1), dateTime(end)], ...
    [riseThreshold, riseThreshold], ...
    'm', ...
    'LineWidth', 1 ...
    );
plot(axesHandle, ...
    [dateTime(1), dateTime(end)], ...
    [fallThreshold, fallThreshold], ...
    'c', ...
    'LineWidth', 1 ...
    );
hold off;

% Itemize
% Information and fixes
if Default.ShowLegend
    legend(axesHandle, 'String', { 'Relative Strength Index' 'Rise Threshold' 'Fall Threshold' }, 'Location', 'NorthWest');
end
xlabel(axesHandle, '\bfDate');
ylabel(axesHandle, '\bfValue');
xlim(axesHandle, [dateTime(1) dateTime(end)]);

% Axes Title
title(axesHandle, '\bfRelative Strength Index');

% Description
description = [ ...
    'Relative Strength Index | ', ...
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
