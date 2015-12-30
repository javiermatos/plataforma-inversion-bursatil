
function drawPosition(algoTrader, axesHandle, initIndex, endIndex, applySplit)

[ ...
    position, ...
    ~, ...      % Price serie
    dateTime, ...
    longPosition, ...
    shortPosition, ...
    noPosition ...
] ...
= algoTrader.positionSerie(initIndex, endIndex, applySplit);

symbolCode = algoTrader.DataSerie.SymbolCode;
compressionType = algoTrader.DataSerie.CompressionType;
compressionUnits = algoTrader.DataSerie.CompressionUnits;

% Draw
% Groups
lpGroup = hggroup;
spGroup = hggroup;
npGroup = hggroup;

hold on;
if Settings.PositionType == 0 && ~isempty(longPosition);
    
    lpX = dateTime([longPosition(:,1) longPosition(:,2)]);
    lpX = [lpX(:,1) lpX(:,1) lpX(:,2) lpX(:,2)]';
    lpY = [zeros(size(longPosition,1),1) position(longPosition(:,1))'];
    lpY = [lpY fliplr(lpY)]';

    handle = patch( ...
        lpX, lpY, ...
        Settings.LongPositionLineColor, ...
        'EdgeColor', Settings.LongPositionLineColor ...
    );
    
    % Add plot to group
    set(handle,'Parent',lpGroup);
    
elseif Settings.PositionType == 1
    
    for i = 1:size(longPosition, 1)

        lpPlot = plot(axesHandle, ...
            dateTime([longPosition(i,1) longPosition(i,2)]), ...
            position([longPosition(i,1) longPosition(i,1)]), ...
            Settings.LongPositionLineStyle, ...
            'Color', Settings.LongPositionLineColor, ...
            'LineWidth', Settings.PositionLineWidth ...
            );

        % Add plot to group
        set(lpPlot,'Parent',lpGroup);

    end
    
end

if Settings.PositionType == 0 && ~isempty(shortPosition);
    
    spX = dateTime([shortPosition(:,1) shortPosition(:,2)]);
    spX = [spX(:,1) spX(:,1) spX(:,2) spX(:,2)]';
    spY = [zeros(size(shortPosition,1),1) position(shortPosition(:,1))'];
    spY = [spY fliplr(spY)]';

    handle = patch( ...
        spX, spY, ...
        Settings.ShortPositionLineColor, ...
        'EdgeColor', Settings.ShortPositionLineColor ...
    );
    
    % Add plot to group
    set(handle,'Parent',spGroup);
    
elseif Settings.PositionType == 1

    for i = 1:size(shortPosition, 1)

        spPlot = plot(axesHandle, ...
            dateTime([shortPosition(i,1) shortPosition(i,2)]), ...
            position([shortPosition(i,1) shortPosition(i,1)]), ...
            Settings.ShortPositionLineStyle, ...
            'Color', Settings.ShortPositionLineColor, ...
            'LineWidth', Settings.PositionLineWidth ...
            );

        % Add plot to group
        set(spPlot,'Parent',spGroup);

    end
    
end

for i = 1:size(noPosition, 1)
    
    npPlot = plot(axesHandle, ...
        dateTime([noPosition(i,1) noPosition(i,2)]), ...
        [0 0], ...
        Settings.NoPositionLineStyle, ...
        'Color', Settings.NoPositionLineColor, ...
        'LineWidth', Settings.PositionLineWidth ...
        );
    
    % Add plot to group
    set(npPlot,'Parent',npGroup);
    
end
hold off;

% Strings holder
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

% Itemize
% Information and fixes
legend(axesHandle, 'String', legendString, 'Location', 'NorthWest');
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
