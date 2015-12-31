
function drawSignal(algoTrader, axesHandle, setSelector, initIndex, endIndex)

% initIndex
if ~exist('initIndex','var') || isempty(initIndex); initIndex = 1; end
% endIndex
if ~exist('endIndex','var') || isempty(endIndex); endIndex = length(algoTrader.Signal); end

symbolCode = algoTrader.DataSerie.SymbolCode;
compressionType = algoTrader.DataSerie.CompressionType;
compressionUnits = algoTrader.DataSerie.CompressionUnits;

% Signal
signal = zeros(1, length(algoTrader.Signal));

% Apply setSelector
switch setSelector
    
    case 0
        signal(algoTrader.TrainingSet(1):algoTrader.TrainingSet(2)) = ...
            algoTrader.Signal(algoTrader.TrainingSet(1):algoTrader.TrainingSet(2));
    case 1
        signal(algoTrader.TestSet(1):algoTrader.TestSet(2)) = ...
            algoTrader.Signal(algoTrader.TestSet(1):algoTrader.TestSet(2));
    case 2
        signal(algoTrader.TrainingSet(1):algoTrader.TrainingSet(2)) = ...
            algoTrader.Signal(algoTrader.TrainingSet(1):algoTrader.TrainingSet(2));
        signal(algoTrader.TestSet(1):algoTrader.TestSet(2)) = ...
            algoTrader.Signal(algoTrader.TestSet(1):algoTrader.TestSet(2));
    case 3
        signal = algoTrader.Signal;
    
end

% Cut to fit the size
signal = signal(initIndex:endIndex);
dateTime = algoTrader.DataSerie.DateTime(initIndex:endIndex);

% Draw
plot(axesHandle, dateTime, signal);

% Itemize
% Information and fixes
if Settings.ShowLegend
    legend(axesHandle, 'Signal', 'Location', 'NorthWest');
end
xlabel(axesHandle, '\bfDate');
ylabel(axesHandle, '\bfValue');

xlim(axesHandle, [dateTime(1) dateTime(end)]);
ylim(axesHandle, [-2 2]);

% Axes Title
title(axesHandle, '\bfSignal');

% Description
description = [ ...
    'Signal | ', ...
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
