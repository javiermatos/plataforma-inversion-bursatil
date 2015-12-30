
function output = plotWrapper(te, startRange, endRange, axesHandle, customizer, varargin)

% Financial Time Serie
fts = te.FinancialTimeSerie;

% startRange
if ~exist('startRange','var'); startRange = 1; end
% endRange
if ~exist('endRange','var'); endRange = fts.Length; end

[startIndex, endIndex] = fts.range2index(startRange, endRange);


if ~isempty(startIndex) && ~isempty(endIndex)
    
    description = [ ...
        class(te), ...
        ' | Fitness = ', num2str(te.Fitness), ...
        ' | Profit/Loss = ', num2str(te.computeProfitLoss('test')) ...
        ];
    
    if isempty(axesHandle)
        figureHandle = figure( ...
            'Name', description, ...
            'NumberTitle', 'off', ...
            'Color', Default.BackgroundColor ...
            );
        axesHandle = axes();
    end
    
    % Customizer function
    varargin{end+1} = description;
    customizer(te, startIndex, endIndex, axesHandle, varargin{:});
    
    
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
