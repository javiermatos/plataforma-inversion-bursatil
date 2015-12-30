
function plotSerieCustomizer(te, startIndex, endIndex, axesHandle, fun, varargin)

plotSerieCustomizer@TradingEngine(te, startIndex, endIndex, axesHandle, fun, varargin{:});

% Financial Time Serie
fts = te.FinancialTimeSerie;

% First tail fragment
firstTailFragmentIndex = te.firstTailFragment();

% AxesCustomization
axes(axesHandle);
hold on;
color = { 'c', 'm' };
for i = 2:firstTailFragmentIndex
    
    [startFragmentIndex, endFragmentIndex] = te.fragmentTestRange(i);
    
    % Moving Average
    movingAverage = movavg(fts.Serie(startFragmentIndex-te.Samples(i-1)+1:endFragmentIndex), te.Mode, te.Samples(i-1));
    plot( ...
        axesHandle, ...
        fts.Date(startFragmentIndex:endFragmentIndex), ...
        fun(movingAverage(te.Samples(i-1):end)), ...
        color{mod(i,2)+1} ...
        );
    
end
hold off;

end
