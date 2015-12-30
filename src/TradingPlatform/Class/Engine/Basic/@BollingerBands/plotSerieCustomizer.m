
function plotSerieCustomizer(te, startIndex, endIndex, axesHandle, fun, varargin)

plotSerieCustomizer@TradingEngine(te, startIndex, endIndex, axesHandle, fun, varargin{:});

% Financial Time Serie
fts = te.FinancialTimeSerie;

% Personalized code
[movingAverage, upperBand, lowerBand] = bbands(fts.Serie, te.Mode, te.Samples, te.K);

% AxesCustomization
axes(axesHandle);
hold on;
plot(axesHandle,fts.Date(startIndex:endIndex),fun(movingAverage(startIndex:endIndex)),'k');
plot(axesHandle,fts.Date(startIndex:endIndex),fun(upperBand(startIndex:endIndex)),'m');
plot(axesHandle,fts.Date(startIndex:endIndex),fun(lowerBand(startIndex:endIndex)),'c');
hold off;

end
