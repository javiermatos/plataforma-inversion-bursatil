
function plotSerieCustomizer(te, startIndex, endIndex, axesHandle, fun, varargin)

plotSerieCustomizer@TradingEngine(te, startIndex, endIndex, axesHandle, fun, varargin{:});

% Financial Time Serie
fts = te.FinancialTimeSerie;

% Moving Average
movingAverage = movavg(fts.Serie, te.Mode, te.Samples);

% Displace moving average
d = te.Displacement;
movingAverage = [ NaN(d,1) ; movingAverage(1:end-d) ];

% AxesCustomization
axes(axesHandle);
hold on;
plot(axesHandle,fts.Date(startIndex:endIndex),fun(movingAverage(startIndex:endIndex)),'b');
hold off;

end
