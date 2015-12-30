
function plotSerieCustomizer(te, startIndex, endIndex, axesHandle, fun, varargin)

plotSerieCustomizer@TradingEngine(te, startIndex, endIndex, axesHandle, fun, varargin{:});

% Financial Time Serie
fts = te.FinancialTimeSerie;

% Moving Average
leadMovingAverage = movavg(fts.Serie, te.Mode, te.Lead);
lagMovingAverage = movavg(fts.Serie, te.Mode, te.Lag);

% AxesCustomization
axes(axesHandle);
hold on;
plot(axesHandle,fts.Date(startIndex:endIndex),fun(leadMovingAverage(startIndex:endIndex)),'r');
plot(axesHandle,fts.Date(startIndex:endIndex),fun(lagMovingAverage(startIndex:endIndex)),'b');
hold off;

end
