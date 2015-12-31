
function drawDiffProfitLoss(algoTrader, axesHandle, setSelector, initIndex, endIndex)

[ ...
    diffProfitLoss, ...
    ~, ...      % Position serie
    ~, ...      % Price serie
    dateTime, ...
    longPosition, ...
    shortPosition, ...
    noPosition ...
] ...
= algoTrader.diffProfitLossSerie(setSelector, initIndex, endIndex);

symbolCode = algoTrader.DataSerie.SymbolCode;
compressionType = algoTrader.DataSerie.CompressionType;
compressionUnits = algoTrader.DataSerie.CompressionUnits;

% Draw
% Groups
lpGroup = hggroup;
spGroup = hggroup;
npGroup = hggroup;

hold on;
for i = 1:size(longPosition, 1)
    
    lpPlot = plot(axesHandle, ...
        dateTime(longPosition(i,1):longPosition(i,2)), ...
        diffProfitLoss(longPosition(i,1):longPosition(i,2)), ...
        Settings.LongPositionLineStyle, ...
        'Color', Settings.LongPositionLineColor, ...
        'LineWidth', Settings.PositionLineWidth ...
        );
    
    % Add plot to group
    set(lpPlot,'Parent',lpGroup);
    
end

for i = 1:size(shortPosition, 1)
    
    spPlot = plot(axesHandle, ...
        dateTime(shortPosition(i,1):shortPosition(i,2)), ...
        diffProfitLoss(shortPosition(i,1):shortPosition(i,2)), ...
        Settings.ShortPositionLineStyle, ...
        'Color', Settings.ShortPositionLineColor, ...
        'LineWidth', Settings.PositionLineWidth ...
        );
    
    % Add plot to group
    set(spPlot,'Parent',spGroup);
    
end

for i = 1:size(noPosition, 1)
    
    npPlot = plot(axesHandle, ...
        dateTime(noPosition(i,1):noPosition(i,2)), ...
        diffProfitLoss(noPosition(i,1):noPosition(i,2)), ...
        Settings.NoPositionLineStyle, ...
        'Color', Settings.NoPositionLineColor, ...
        'LineWidth', Settings.PositionLineWidth ...
        );
    
    % Add plot to group
    set(npPlot,'Parent',npGroup);
    
end
hold off;

% Strings holder
if Settings.ShowLegend
legendString = {};
if ~isempty(get(lpGroup,'Children'))
    legendString = [ legendString {'Profit/Loss in long position'} ];
    
    % Include in legend
    set(get(get(lpGroup,'Annotation'),'LegendInformation'),...
        'IconDisplayStyle','on');
end
if ~isempty(get(spGroup,'Children'))
    legendString = [ legendString {'Profit/Loss in short position'} ];
    
    % Include in legend
    set(get(get(spGroup,'Annotation'),'LegendInformation'),...
        'IconDisplayStyle','on');
end
if ~isempty(get(npGroup,'Children'))
    legendString = [ legendString {'Profit/Loss in no position'} ];
    
    % Include in legend
    set(get(get(npGroup,'Annotation'),'LegendInformation'),...
        'IconDisplayStyle','on');
end
end

% Itemize
% Information and fixes
if Settings.ShowLegend
    legend(axesHandle, 'String', legendString, 'Location', 'NorthWest');
end
xlabel(axesHandle, '\bfDate');
ylabel(axesHandle, '\bfQuantity');
xlim(axesHandle, [dateTime(1) dateTime(end)]);

% Axes Title
title(axesHandle, '\bfProfit/Loss');

% Description
description = [ ...
    'Profit/Loss | ', ...
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
