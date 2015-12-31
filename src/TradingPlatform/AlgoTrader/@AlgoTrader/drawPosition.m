
function drawPosition(algoTrader, axesHandle, setSelector, initIndex, endIndex)

[ ...
    position, ...
    ~, ...      % Price serie
    dateTime, ...
    longPosition, ...
    shortPosition, ...
    noPosition ...
] ...
= algoTrader.positionSerie(setSelector, initIndex, endIndex);

symbolCode = algoTrader.DataSerie.SymbolCode;
compressionType = algoTrader.DataSerie.CompressionType;
compressionUnits = algoTrader.DataSerie.CompressionUnits;

% Draw
% Groups
lpGroup = hggroup;
spGroup = hggroup;
npGroup = hggroup;

hold on;
if ~isempty(longPosition)
    
    lpX = dateTime([longPosition(:,1) longPosition(:,2)]);
    lpX = [lpX(:,1) lpX(:,1) lpX(:,2) lpX(:,2)]';
    lpY = [zeros(size(longPosition,1),1) position(longPosition(:,1))'];
    lpY = [lpY fliplr(lpY)]';
    
    handle = patch( ...
        lpX, lpY, ...
        Default.LongPositionLineColor, ...
        'EdgeColor', Default.LongPositionLineColor ...
        );
    
    % Add plot to group
    set(handle,'Parent',lpGroup);
    
end

if ~isempty(shortPosition)
    
    spX = dateTime([shortPosition(:,1) shortPosition(:,2)]);
    spX = [spX(:,1) spX(:,1) spX(:,2) spX(:,2)]';
    spY = [zeros(size(shortPosition,1),1) position(shortPosition(:,1))'];
    spY = [spY fliplr(spY)]';
    
    handle = patch( ...
        spX, spY, ...
        Default.ShortPositionLineColor, ...
        'EdgeColor', Default.ShortPositionLineColor ...
        );
    
    % Add plot to group
    set(handle,'Parent',spGroup);
    
end

for i = 1:size(noPosition, 1)
    
    npPlot = plot(axesHandle, ...
        dateTime([noPosition(i,1) noPosition(i,2)]), ...
        [0 0], ...
        Default.NoPositionLineStyle, ...
        'Color', Default.NoPositionLineColor, ...
        'LineWidth', Default.PositionLineWidth ...
        );
    
    % Add plot to group
    set(npPlot,'Parent',npGroup);
    
end
hold off;

% Strings holder
if Default.ShowLegend
legendString = {};
if ~isempty(get(lpGroup,'Children'))
    legendString = [ legendString {'Long position'} ];
    
    % Include in legend
    set(get(get(lpGroup,'Annotation'),'LegendInformation'),...
        'IconDisplayStyle','on');
end
if ~isempty(get(spGroup,'Children'))
    legendString = [ legendString {'Short position'} ];
    
    % Include in legend
    set(get(get(spGroup,'Annotation'),'LegendInformation'),...
        'IconDisplayStyle','on');
end
if ~isempty(get(npGroup,'Children'))
    legendString = [ legendString {'No position'} ];
    
    % Include in legend
    set(get(get(npGroup,'Annotation'),'LegendInformation'),...
        'IconDisplayStyle','on');
end
end

% Itemize
% Information and fixes
if Default.ShowLegend
    legend(axesHandle, 'String', legendString, 'Location', 'NorthWest');
end
xlabel(axesHandle, '\bfDate');
ylabel(axesHandle, '\bfPosition Investment');
xlim(axesHandle, [dateTime(1) dateTime(end)]);

% Axes Title
title(axesHandle, '\bfPosition');

% Description
description = [ ...
    'Position | ', ...
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
