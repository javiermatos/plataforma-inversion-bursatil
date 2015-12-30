
function plotSerieCustomizer(te, startIndex, endIndex, axesHandle, fun, varargin)

plotSerieCustomizer@TradingEngine(te, startIndex, endIndex, axesHandle, fun, varargin{:});

% Financial Time Serie
fts = te.FinancialTimeSerie;

% Moving Average
movingAverage = movavg(fts.Serie, te.Mode, te.Samples);
upperBand = movingAverage*(1+te.RiseThreshold);
lowerBand = movingAverage*(1-te.FallThreshold);


% AxesCustomization
axes(axesHandle);
hold on;
plot(axesHandle,fts.Date(startIndex:endIndex),fun(movingAverage(startIndex:endIndex)),'k');
plot(axesHandle,fts.Date(startIndex:endIndex),fun(upperBand(startIndex:endIndex)),'--m');
plot(axesHandle,fts.Date(startIndex:endIndex),fun(lowerBand(startIndex:endIndex)),'--c');
hold off;

end
