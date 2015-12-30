
function output = plotSerie(te, startRange, endRange, fun, axesHandle)

% Financial Time Serie
fts = te.FinancialTimeSerie;

% startRange
if ~exist('startRange','var'); startRange = 1; end
% endRange
if ~exist('endRange','var'); endRange = fts.Length; end
% fun
if ~exist('fun','var'); fun = @(x) x; end


[startIndex, endIndex] = fts.range2index(startRange, endRange);

if ~isempty(startIndex) && ~isempty(endIndex)
    
    description = [ ...
        class(te), ...
        ' | Fitness = ', num2str(te.Fitness), ...
        ' | Profit/Loss = ', num2str(te.computeProfitLoss('test')) ...
        ];
    
    % Relative index positions
    [longPosition, shortPosition, noPosition] = te.signal2positions('index', startIndex, endIndex);
    
    % Absolute index positions
    longPosition = longPosition + startIndex - 1;
    shortPosition = shortPosition + startIndex - 1;
    noPosition = noPosition + startIndex - 1;
    
    if ~exist('axesHandle','var')
        figureHandle = figure( ...
            'Name', description, ...
            'NumberTitle', 'off', ...
            'Color', Default.BackgroundColor ...
            );
        axesHandle = axes();
    end
    
    % Groups
    lpGroup = hggroup;
    spGroup = hggroup;
    npGroup = hggroup;
    
    hold on;
    for i = 1:size(longPosition, 1)
        
        lpPlot = plot(axesHandle, ...
            fts.Date(longPosition(i,1):longPosition(i,2)), ...
            fun(fts.Serie(longPosition(i,1):longPosition(i,2))), ...
            Default.LongPositionLineSpec, ...
            'LineWidth', Default.PositionLineWidth ...
            );
        
        % Add plot to group
        set(lpPlot,'Parent',lpGroup);
        
    end
    
    for i = 1:size(shortPosition, 1)
        
        spPlot = plot(axesHandle, ...
            fts.Date(shortPosition(i,1):shortPosition(i,2)), ...
            fun(fts.Serie(shortPosition(i,1):shortPosition(i,2))), ...
            Default.ShortPositionLineSpec, ...
            'LineWidth', Default.PositionLineWidth ...
            );
        
        % Add plot to group
        set(spPlot,'Parent',spGroup);
        
    end
    
    for i = 1:size(noPosition, 1)
        
        npPlot = plot(axesHandle, ...
            fts.Date(noPosition(i,1):noPosition(i,2)), ...
            fun(fts.Serie(noPosition(i,1):noPosition(i,2))), ...
            Default.NoPositionLineSpec, ...
            'LineWidth', Default.PositionLineWidth ...
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
    
    % Information and fixes
    dataDescription = ...
        [fts.Symbol ,' - ', fts.Frecuency, ...
        ' from ', datestr(fts.Date(startIndex)), ...
        ' to ', datestr(fts.Date(endIndex))];

    title(axesHandle, {['\bf', description], ['\bf', strrep(dataDescription, '^', '\^')]});
    legend(axesHandle, 'String', legendString);
    xlabel(axesHandle, '\bfDate');
    ylabel(axesHandle, ['\bfPrice', ' [ fun = ', func2str(fun), ' ]']);
    xlim(axesHandle, [fts.Date(startIndex) fts.Date(endIndex)]);
    
    
    % Corrections
    % Axes boxes
    set(axesHandle, 'Box', Default.Box);
    
    % Automatic y limit
    set(axesHandle, 'YLimMode', 'auto');
    
    % Grid
    set(axesHandle, ...
        'XGrid', Default.XGrid, ...
        'XColor', Default.GridColor, ...
        'YGrid', Default.YGrid, ...
        'YColor', Default.GridColor ...
        );
    
    % Partition line
    if te.TrainingSetItems > 0
        xPartitionLine = fts.Date(te.TrainingSetItems);
        set(axesHandle, 'XTick', sort([get(axesHandle, 'XTick') xPartitionLine]));
    end
    
    % Set date in x
    datetick(axesHandle, 'x', Default.DateFormat, 'keepticks', 'keeplimits');
    
    % Customize
    te.plotSerieCustomize(startIndex, endIndex, fun, axesHandle);
    
    % Corrections if we generate an independent figure
    if exist('figureHandle','var')
        plotCorrection(figureHandle);
    end
    
    % Define output argument if requested
    if nargout == 1
        if exist('figureHandle','var')
            output = figureHandle;
        else
            output = axesHandle;
        end
    end
    
else
    error('Empty range.');
end

end
