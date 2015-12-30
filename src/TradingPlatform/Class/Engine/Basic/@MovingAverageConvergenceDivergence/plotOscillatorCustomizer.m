
function plotOscillatorCustomizer(te, startIndex, endIndex, axesHandle, varargin)

% Financial Time Serie
fts = te.FinancialTimeSerie;

% Moving Average
leadMovingAverage = movavg(fts.Serie, te.Mode, te.Lead);
lagMovingAverage = movavg(fts.Serie, te.Mode, te.Lag);
macd = leadMovingAverage-lagMovingAverage;
compound = movavg(macd, te.Mode, te.Samples);
histogram = macd-compound;

% AxesCustomization
axes(axesHandle);
hold on;
plot(axesHandle,fts.Date(startIndex:endIndex),macd(startIndex:endIndex),'r');
plot(axesHandle,fts.Date(startIndex:endIndex),compound(startIndex:endIndex),'b');
bar(axesHandle,fts.Date(startIndex:endIndex),histogram(startIndex:endIndex));
hold off;

end
